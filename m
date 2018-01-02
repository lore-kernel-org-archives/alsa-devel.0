From: srinivas.kandagatla@linaro.org
Subject: [PATCH 4/6] slimbus: Use GFP_ATOMIC under spin lock
Date: Tue,  2 Jan 2018 17:54:22 +0000
Message-ID: <20180102175424.14391-5-srinivas.kandagatla@linaro.org>
References: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102175424.14391-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sdharia@codeaurora.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

A spin lock is taken here so we should use GFP_ATOMIC.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 8b2c77f516b9..a9a6dc4af0da 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -98,7 +98,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	if (need_tid) {
 		spin_lock_irqsave(&ctrl->txn_lock, flags);
 		tid = idr_alloc(&ctrl->tid_idr, txn, 0,
-				SLIM_MAX_TIDS, GFP_KERNEL);
+				SLIM_MAX_TIDS, GFP_ATOMIC);
 		txn->tid = tid;
 
 		if (!txn->msg->comp)
-- 
2.15.0
