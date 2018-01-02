From: srinivas.kandagatla@linaro.org
Subject: [PATCH 5/6] slimbus: Fix missing unlock on error in slim_msg_response()
Date: Tue,  2 Jan 2018 17:54:23 +0000
Message-ID: <20180102175424.14391-6-srinivas.kandagatla@linaro.org>
References: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sdharia@codeaurora.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Add the missing unlock before return from function slim_msg_response()
in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index a9a6dc4af0da..884419c37e84 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -38,6 +38,7 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 	if (msg == NULL || msg->rbuf == NULL) {
 		dev_err(ctrl->dev, "Got response to invalid TID:%d, len:%d\n",
 				tid, len);
+		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
 		return;
 	}
 
-- 
2.15.0
