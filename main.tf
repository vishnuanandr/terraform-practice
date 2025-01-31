provider "aws" {
  region = "us-east-1"
}

locals {
  application = "Core"
  server_name = "ec2-${var.Environment}-${var.instance_name1}"
}

data "aws_availability_zone" "available" {}

data "aws_region" "current" {}

resource "aws_s3_bucket" "test_bucket1" {
  bucket = "aws-vishnu-bucket123-${random_id.randomness.hex}"
  tags = {
    Name        = "My Bucket 1"
    source      = "Terraform"
    Environment = var.Environment
    purpose     = local.application
    server      = local.server_name
    Region      = data.aws_region.current.name
  }
}

resource "aws_s3_bucket_acl" "test_bucket_acl1" {
  bucket = aws_s3_bucket.test_bucket1.id
  acl    = "private"
}

resource "random_id" "randomness" {
  byte_length = 16
}