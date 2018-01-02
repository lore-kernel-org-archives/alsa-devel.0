From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] slimbus: Fix missing unlock on error in slim_msg_response()
Date: Tue, 2 Jan 2018 01:46:00 +0000
Message-ID: <1514857560-83934-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Sagar Dharia <sdharia@codeaurora.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the missing unlock before return from function slim_msg_response()
in the error handling case.

Fixes: afbdcc7c384b ("slimbus: Add messaging APIs to slimbus framework")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 755462a..a1328ac 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -38,6 +38,7 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 	if (msg == NULL || msg->rbuf == NULL) {
 		dev_err(ctrl->dev, "Got response to invalid TID:%d, len:%d\n",
 				tid, len);
+		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
 		return;
 	}
