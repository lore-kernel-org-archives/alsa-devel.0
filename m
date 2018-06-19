From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 3/5] slimbus: messaging: add
	slim_alloc/free_txn_tid()
Date: Tue, 19 Jun 2018 17:12:59 +0100
Message-ID: <20180619161301.4556-4-srinivas.kandagatla@linaro.org>
References: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id F1727266D4C
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 18:13:09 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so1345410wmd.0
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 09:13:09 -0700 (PDT)
In-Reply-To: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org, kramasub@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org

This patch adds slim_alloc_txn_tid() and slim_free_txn_tid() api
to allow controllers like ngd to allocate tids for user specific
commands. This also cleans up the existing code to use single place
for tid allocations and free.

This patch also make the tid allocation cyclic one, its very useful
to track the transactions back during debug.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 74 +++++++++++++++++++++++++++++++--------------
 drivers/slimbus/slimbus.h   |  2 ++
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index e3605ed1c459..d5879142dbef 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -29,22 +29,19 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 
 	spin_lock_irqsave(&ctrl->txn_lock, flags);
 	txn = idr_find(&ctrl->tid_idr, tid);
-	if (txn == NULL) {
-		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+
+	if (txn == NULL)
 		return;
-	}
 
 	msg = txn->msg;
 	if (msg == NULL || msg->rbuf == NULL) {
 		dev_err(ctrl->dev, "Got response to invalid TID:%d, len:%d\n",
 				tid, len);
-		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
 		return;
 	}
 
-	idr_remove(&ctrl->tid_idr, tid);
-	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-
+	slim_free_txn_tid(ctrl, txn);
 	memcpy(msg->rbuf, reply, len);
 	if (txn->comp)
 		complete(txn->comp);
@@ -55,6 +52,48 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 }
 EXPORT_SYMBOL_GPL(slim_msg_response);
 
+/**
+ * slim_alloc_txn_tid() - Allocate a tid to txn
+ *
+ * @ctrl: Controller handle
+ * @txn: transaction to be allocated with tid.
+ *
+ * Return: zero on success with valid txn->tid and error code on failures.
+ */
+int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&ctrl->txn_lock, flags);
+	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 0,
+				SLIM_MAX_TIDS, GFP_ATOMIC);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+		return ret;
+	}
+	txn->tid = ret;
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_alloc_txn_tid);
+
+/**
+ * slim_free_txn_tid() - Freee tid of txn
+ *
+ * @ctrl: Controller handle
+ * @txn: transaction whose tid should be freed
+ */
+void slim_free_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->txn_lock, flags);
+	idr_remove(&ctrl->tid_idr, txn->tid);
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+}
+EXPORT_SYMBOL_GPL(slim_free_txn_tid);
+
 /**
  * slim_do_transfer() - Process a SLIMbus-messaging transaction
  *
@@ -72,8 +111,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	bool need_tid = false, clk_pause_msg = false;
-	unsigned long flags;
-	int ret, tid, timeout;
+	int ret, timeout;
 
 	/*
 	 * do not vote for runtime-PM if the transactions are part of clock
@@ -97,34 +135,26 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	need_tid = slim_tid_txn(txn->mt, txn->mc);
 
 	if (need_tid) {
-		spin_lock_irqsave(&ctrl->txn_lock, flags);
-		tid = idr_alloc(&ctrl->tid_idr, txn, 0,
-				SLIM_MAX_TIDS, GFP_ATOMIC);
-		txn->tid = tid;
+		ret = slim_alloc_txn_tid(ctrl, txn);
+		if (ret)
+			return ret;
 
 		if (!txn->msg->comp)
 			txn->comp = &done;
 		else
 			txn->comp = txn->comp;
-
-		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-
-		if (tid < 0)
-			return tid;
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
 
-	if (ret && need_tid && !txn->msg->comp) {
+	if (!ret && need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
 		timeout = wait_for_completion_timeout(txn->comp,
 						      msecs_to_jiffies(ms));
 		if (!timeout) {
 			ret = -ETIMEDOUT;
-			spin_lock_irqsave(&ctrl->txn_lock, flags);
-			idr_remove(&ctrl->tid_idr, tid);
-			spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+			slim_free_txn_tid(ctrl, txn);
 		}
 	}
 
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 79f8e05d92dd..2ba6545fa716 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -240,6 +240,8 @@ int slim_unregister_controller(struct slim_controller *ctrl);
 void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 l);
 int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn);
 int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart);
+int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn);
+void slim_free_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn);
 
 static inline bool slim_tid_txn(u8 mt, u8 mc)
 {
-- 
2.16.2
