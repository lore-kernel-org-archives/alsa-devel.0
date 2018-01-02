From: srinivas.kandagatla@linaro.org
Subject: [PATCH 0/6] slimbus: sparse and CoverityScan fixes
Date: Tue,  2 Jan 2018 17:54:18 +0000
Message-ID: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sdharia@codeaurora.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg, 

Here are few patches which are submitted in the list few days back,
these also fix some of the sparse errors reported.

Thanks,
Srini

Colin Ian King (3):
  slimbus: avoid null pointer dereference on msg
  slimbus: fix retries comparison to correctly identify failed
    allocation
  slimbus: make functions slim_ack_txn and slim_alloc_txbuf static

Wei Yongjun (3):
  slimbus: Use GFP_ATOMIC under spin lock
  slimbus: Fix missing unlock on error in slim_msg_response()
  slimbus: qcom: Fix return value check in qcom_slim_probe()

 drivers/slimbus/messaging.c |  8 +++++---
 drivers/slimbus/qcom-ctrl.c | 13 +++++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.15.0
