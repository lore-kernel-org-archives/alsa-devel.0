From: srinivas.kandagatla@linaro.org
Subject: [Patch v6 4/7] slimbus: Add support for 'clock-pause' feature
Date: Fri,  6 Oct 2017 17:51:33 +0200
Message-ID: <20171006155136.4682-5-srinivas.kandagatla@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

Per slimbus specification, a reconfiguration sequence known as
'clock pause' needs to be broadcast over the bus while entering low-
power mode. Clock-pause is initiated by the controller driver.
To exit clock-pause, controller typically wakes up the framer device.
Since wakeup precedure is controller-specific, framework calls it via
controller's function pointer to invoke it.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Makefile         |   2 +-
 drivers/slimbus/slim-core.c      |  15 +++++
 drivers/slimbus/slim-messaging.c |  50 ++++++++++++++--
 drivers/slimbus/slim-sched.c     | 126 +++++++++++++++++++++++++++++++++++++++
 include/linux/slimbus.h          |  54 ++++++++++++++++-
 5 files changed, 239 insertions(+), 8 deletions(-)
 create mode 100644 drivers/slimbus/slim-sched.c

diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
index ed8521a..8fc8b50 100644
--- a/drivers/slimbus/Makefile
+++ b/drivers/slimbus/Makefile
@@ -2,7 +2,7 @@
 # Makefile for kernel slimbus framework.
 #
 obj-$(CONFIG_SLIMBUS)			+= slimbus.o
-slimbus-y				:= slim-core.o slim-messaging.o
+slimbus-y				:= slim-core.o slim-messaging.o slim-sched.o
 
 #Controllers
 obj-$(CONFIG_SLIM_QCOM_CTRL)		+= slim-qcom-ctrl.o
diff --git a/drivers/slimbus/slim-core.c b/drivers/slimbus/slim-core.c
index 5b1da28..a5cb31b 100644
--- a/drivers/slimbus/slim-core.c
+++ b/drivers/slimbus/slim-core.c
@@ -364,6 +364,8 @@ int slim_register_controller(struct slim_controller *ctrl)
 	mutex_init(&ctrl->m_ctrl);
 	spin_lock_init(&ctrl->tx.lock);
 	spin_lock_init(&ctrl->rx.lock);
+	mutex_init(&ctrl->sched.m_reconf);
+	init_completion(&ctrl->sched.pause_comp);
 
 	ctrl->pending_wr = kcalloc((ctrl->tx.n - 1),
 				   sizeof(struct slim_pending),
@@ -432,6 +434,8 @@ int slim_del_controller(struct slim_controller *ctrl)
 	/* Remove all clients */
 	device_for_each_child(&ctrl->dev, NULL, slim_ctrl_remove_device);
 
+	/* Enter clock pause */
+	slim_ctrl_clk_pause(ctrl, false, 0);
 
 	destroy_workqueue(ctrl->wq);
 
@@ -585,6 +589,14 @@ int slim_assign_laddr(struct slim_controller *ctrl, struct slim_eaddr *e_addr,
 	struct slim_device *slim;
 	struct slim_addrt *temp;
 
+	ret = pm_runtime_get_sync(ctrl->dev.parent);
+
+	if (ctrl->sched.clk_state != SLIM_CLK_ACTIVE) {
+		dev_err(&ctrl->dev, "slim ctrl not active,state:%d, ret:%d\n",
+				    ctrl->sched.clk_state, ret);
+		goto slimbus_not_active;
+	}
+
 	mutex_lock(&ctrl->m_ctrl);
 	/* already assigned */
 	if (ctrl_getaddr_entry(ctrl, e_addr, &i) == 0) {
@@ -655,6 +667,9 @@ int slim_assign_laddr(struct slim_controller *ctrl, struct slim_eaddr *e_addr,
 		}
 		mutex_unlock(&slim->report_lock);
 	}
+slimbus_not_active:
+	pm_runtime_mark_last_busy(ctrl->dev.parent);
+	pm_runtime_put_autosuspend(ctrl->dev.parent);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(slim_assign_laddr);
diff --git a/drivers/slimbus/slim-messaging.c b/drivers/slimbus/slim-messaging.c
index adcba67..f6a0fa2 100644
--- a/drivers/slimbus/slim-messaging.c
+++ b/drivers/slimbus/slim-messaging.c
@@ -10,6 +10,7 @@
  * GNU General Public License for more details.
  */
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/slimbus.h>
 
 /**
@@ -43,6 +44,9 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 	memcpy(msg->rbuf, reply, len);
 	if (msg->comp_cb)
 		msg->comp_cb(msg->ctx, 0);
+	/* Remove runtime-pm vote now that response was received for TID txn */
+	pm_runtime_mark_last_busy(ctrl->dev.parent);
+	pm_runtime_put_autosuspend(ctrl->dev.parent);
 }
 EXPORT_SYMBOL_GPL(slim_msg_response);
 
@@ -77,11 +81,21 @@ int slim_processtxn(struct slim_controller *ctrl,
 	int ret, i = 0;
 	unsigned long flags;
 	u8 *buf;
-	bool async = false;
+	bool async = false, clk_pause_msg = false;
 	struct slim_cb_data cbd;
 	DECLARE_COMPLETION_ONSTACK(done);
 	bool need_tid = slim_tid_txn(txn->mt, txn->mc);
 
+	/*
+	 * do not vote for runtime-PM if the transactions are part of clock
+	 * pause sequence
+	 */
+	if (ctrl->sched.clk_state == SLIM_CLK_ENTERING_PAUSE &&
+		(txn->mt == SLIM_MSG_MT_CORE &&
+		 txn->mc >= SLIM_MSG_MC_BEGIN_RECONFIGURATION &&
+		 txn->mc <= SLIM_MSG_MC_RECONFIGURE_NOW))
+		clk_pause_msg = true;
+
 	if (!txn->msg->comp_cb) {
 		txn->msg->comp_cb = slim_sync_default_cb;
 		cbd.comp = &done;
@@ -90,7 +104,7 @@ int slim_processtxn(struct slim_controller *ctrl,
 		async = true;
 	}
 
-	buf = slim_get_tx(ctrl, txn, need_tid);
+	buf = slim_get_tx(ctrl, txn, need_tid, clk_pause_msg);
 	if (!buf)
 		return -ENOMEM;
 
@@ -104,7 +118,8 @@ int slim_processtxn(struct slim_controller *ctrl,
 			if (ctrl->last_tid == (SLIM_MAX_TIDS - 1)) {
 				spin_unlock_irqrestore(&ctrl->txn_lock, flags);
 				slim_return_tx(ctrl, -ENOMEM);
-				return -ENOMEM;
+				ret = cbd.ret;
+				return ret;
 			}
 			ctrl->last_tid++;
 		}
@@ -429,6 +444,14 @@ void slim_return_tx(struct slim_controller *ctrl, int err)
 		cur.cb(cur.ctx, err);
 
 	up(&ctrl->tx_sem);
+	if (!cur.clk_pause && (!cur.need_tid || err)) {
+		/**
+		 * remove runtime-pm vote if this was TX only, or
+		 * if there was error during this transaction
+		 */
+		pm_runtime_mark_last_busy(ctrl->dev.parent);
+		pm_runtime_put_autosuspend(ctrl->dev.parent);
+	}
 }
 EXPORT_SYMBOL_GPL(slim_return_tx);
 
@@ -441,15 +464,25 @@ EXPORT_SYMBOL_GPL(slim_return_tx);
  * back to the pool.
  */
 void *slim_get_tx(struct slim_controller *ctrl, struct slim_msg_txn *txn,
-		bool need_tid)
+		bool need_tid, bool clk_pause)
 {
 	unsigned long flags;
 	int ret, idx;
 
+	if (!clk_pause) {
+		ret = pm_runtime_get_sync(ctrl->dev.parent);
+
+		if (ctrl->sched.clk_state != SLIM_CLK_ACTIVE) {
+			dev_err(&ctrl->dev, "ctrl wrong state:%d, ret:%d\n",
+				ctrl->sched.clk_state, ret);
+			goto slim_tx_err;
+		}
+	}
+
 	ret = down_interruptible(&ctrl->tx_sem);
 	if (ret < 0) {
 		dev_err(&ctrl->dev, "TX semaphore down returned:%d", ret);
-		return NULL;
+		goto slim_tx_err;
 	}
 	spin_lock_irqsave(&ctrl->tx.lock, flags);
 
@@ -457,15 +490,20 @@ void *slim_get_tx(struct slim_controller *ctrl, struct slim_msg_txn *txn,
 		spin_unlock_irqrestore(&ctrl->tx.lock, flags);
 		dev_err(&ctrl->dev, "controller TX buf unavailable");
 		up(&ctrl->tx_sem);
-		return NULL;
+		goto slim_tx_err;
 	}
 	idx = ctrl->tx.tail;
 	ctrl->tx.tail = (ctrl->tx.tail + 1) % ctrl->tx.n;
 	ctrl->pending_wr[idx].cb = txn->msg->comp_cb;
 	ctrl->pending_wr[idx].ctx = txn->msg->ctx;
 	ctrl->pending_wr[idx].need_tid = need_tid;
+	ctrl->pending_wr[idx].clk_pause = clk_pause;
 	spin_unlock_irqrestore(&ctrl->tx.lock, flags);
 
 	return ctrl->tx.base + (idx * ctrl->tx.sl_sz);
+slim_tx_err:
+	pm_runtime_mark_last_busy(ctrl->dev.parent);
+	pm_runtime_put_autosuspend(ctrl->dev.parent);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(slim_get_tx);
diff --git a/drivers/slimbus/slim-sched.c b/drivers/slimbus/slim-sched.c
new file mode 100644
index 0000000..3ed075f
--- /dev/null
+++ b/drivers/slimbus/slim-sched.c
@@ -0,0 +1,126 @@
+/* Copyright (c) 2011-2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/errno.h>
+#include <linux/slimbus.h>
+
+/**
+ * slim_ctrl_clk_pause: Called by slimbus controller to enter/exit 'clock pause'
+ * Slimbus specification needs this sequence to turn-off clocks for the bus.
+ * The sequence involves sending 3 broadcast messages (reconfiguration
+ * sequence) to inform all devices on the bus.
+ * To exit clock-pause, controller typically wakes up active framer device.
+ * @ctrl: controller requesting bus to be paused or woken up
+ * @wakeup: Wakeup this controller from clock pause.
+ * @restart: Restart time value per spec used for clock pause. This value
+ *	isn't used when controller is to be woken up.
+ * This API executes clock pause reconfiguration sequence if wakeup is false.
+ * If wakeup is true, controller's wakeup is called.
+ * For entering clock-pause, -EBUSY is returned if a message txn in pending.
+ */
+int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart)
+{
+	int i, ret = 0;
+	unsigned long flags;
+	struct slim_sched *sched = &ctrl->sched;
+	struct slim_val_inf msg = {0, 0, NULL, NULL, NULL, NULL};
+
+	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
+				3, SLIM_LA_MANAGER, &msg);
+
+	if (wakeup == false && restart > SLIM_CLK_UNSPECIFIED)
+		return -EINVAL;
+
+	mutex_lock(&sched->m_reconf);
+	if (wakeup) {
+		if (sched->clk_state == SLIM_CLK_ACTIVE) {
+			mutex_unlock(&sched->m_reconf);
+			return 0;
+		}
+
+		/**
+		 * Fine-tune calculation based on clock gear,
+		 * message-bandwidth after bandwidth management
+		 */
+		ret = wait_for_completion_timeout(&sched->pause_comp,
+				msecs_to_jiffies(100));
+		if (!ret) {
+			mutex_unlock(&sched->m_reconf);
+			pr_err("Previous clock pause did not finish");
+			return -ETIMEDOUT;
+		}
+		ret = 0;
+
+		/**
+		 * Slimbus framework will call controller wakeup
+		 * Controller should make sure that it sets active framer
+		 * out of clock pause
+		 */
+		if (sched->clk_state == SLIM_CLK_PAUSED && ctrl->wakeup)
+			ret = ctrl->wakeup(ctrl);
+		if (!ret)
+			sched->clk_state = SLIM_CLK_ACTIVE;
+		mutex_unlock(&sched->m_reconf);
+
+		return ret;
+	}
+
+	/* already paused */
+	if (ctrl->sched.clk_state == SLIM_CLK_PAUSED) {
+		mutex_unlock(&sched->m_reconf);
+		return 0;
+	}
+
+	spin_lock_irqsave(&ctrl->txn_lock, flags);
+	for (i = 0; i < ctrl->last_tid; i++) {
+		/* Pending response for a message */
+		if (ctrl->tid_tbl[i]) {
+			spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+			mutex_unlock(&sched->m_reconf);
+			return -EBUSY;
+		}
+	}
+	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
+
+	sched->clk_state = SLIM_CLK_ENTERING_PAUSE;
+
+	/* clock pause sequence */
+	ret = slim_processtxn(ctrl, &txn);
+	if (ret)
+		goto clk_pause_ret;
+
+	txn.mc = SLIM_MSG_MC_NEXT_PAUSE_CLOCK;
+	txn.rl = 4;
+	msg.num_bytes = 1;
+	msg.wbuf = &restart;
+	ret = slim_processtxn(ctrl, &txn);
+	if (ret)
+		goto clk_pause_ret;
+
+	txn.mc = SLIM_MSG_MC_RECONFIGURE_NOW;
+	txn.rl = 3;
+	msg.num_bytes = 1;
+	msg.wbuf = NULL;
+	ret = slim_processtxn(ctrl, &txn);
+
+clk_pause_ret:
+	if (ret) {
+		sched->clk_state = SLIM_CLK_ACTIVE;
+	} else {
+		sched->clk_state = SLIM_CLK_PAUSED;
+		complete(&sched->pause_comp);
+	}
+	mutex_unlock(&sched->m_reconf);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(slim_ctrl_clk_pause);
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index 080d86a..549f78f 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -117,11 +117,21 @@ struct slim_addrt {
 #define SLIM_MSG_MC_REPLY_VALUE                  0x64
 #define SLIM_MSG_MC_CHANGE_VALUE                 0x68
 
+/* Clock pause Reconfiguration messages */
+#define SLIM_MSG_MC_BEGIN_RECONFIGURATION        0x40
+#define SLIM_MSG_MC_NEXT_PAUSE_CLOCK             0x4A
+#define SLIM_MSG_MC_RECONFIGURE_NOW              0x5F
+
 /* Destination type Values */
 #define SLIM_MSG_DEST_LOGICALADDR	0
 #define SLIM_MSG_DEST_ENUMADDR		1
 #define	SLIM_MSG_DEST_BROADCAST		3
 
+/* Clock pause values per slimbus spec */
+#define SLIM_CLK_FAST				0
+#define SLIM_CLK_CONST_PHASE			1
+#define SLIM_CLK_UNSPECIFIED			2
+
 /**
  * struct slim_val_inf: Slimbus value or information element
  * @start_offset: Specifies starting offset in information/value element map
@@ -205,11 +215,46 @@ struct slim_ctrl_buf {
  * @cb: callback for this transfer
  * @ctx: contex for the callback function
  * @need_tid: True if this transfer need Transaction ID
+ * @clk_pause: True if this transfer is part of clock-pause sequence
  */
 struct slim_pending {
 	void (*cb)(void *ctx, int err);
 	void *ctx;
 	bool need_tid;
+	bool clk_pause;
+};
+
+/**
+ * enum slim_clk_state: Slimbus controller's clock state used internally for
+ *	maintaining current clock state.
+ * @SLIM_CLK_ACTIVE: Slimbus clock is active
+ * @SLIM_CLK_ENTERING_PAUSE: Slimbus clock pause sequence is being sent on the
+ *	bus. If this succeeds, state changes to SLIM_CLK_PAUSED. If the
+ *	transition fails, state changes back to SLIM_CLK_ACTIVE
+ * @SLIM_CLK_PAUSED: Slimbus controller clock has paused.
+ */
+enum slim_clk_state {
+	SLIM_CLK_ACTIVE,
+	SLIM_CLK_ENTERING_PAUSE,
+	SLIM_CLK_PAUSED,
+};
+
+/**
+ * struct slim_sched: Framework uses this structure internally for scheduling.
+ * @clk_state: Controller's clock state from enum slim_clk_state
+ * @pause_comp: Signals completion of clock pause sequence. This is useful when
+ *	client tries to call slimbus transaction when controller is entering
+ *	clock pause.
+ * @m_reconf: This mutex is held until current reconfiguration (data channel
+ *	scheduling, message bandwidth reservation) is done. Message APIs can
+ *	use the bus concurrently when this mutex is held since elemental access
+ *	messages can be sent on the bus when reconfiguration is in progress.
+ */
+struct slim_sched {
+	int			clkgear;
+	enum slim_clk_state	clk_state;
+	struct completion	pause_comp;
+	struct mutex		m_reconf;
 };
 
 /**
@@ -256,6 +301,7 @@ struct slim_pending {
  * @pending_wr: Pending write transactions to be acknowledged by controller
  * @tx_sem: Semaphore for available TX buffers for this controller
  * @last_tid: Last used entry for TID transactions
+ * @sched: scheduler structure used by the controller
  * @xfer_msg: Transfer a message on this controller (this can be a broadcast
  *	control/status message like data channel setup, or a unicast message
  *	like value element read/write.
@@ -265,6 +311,9 @@ struct slim_pending {
  * @get_laddr: It is possible that controller needs to set fixed logical
  *	address table and get_laddr can be used in that case so that controller
  *	can do this assignment.
+ * @wakeup: This function pointer implements controller-specific procedure
+ *	to wake it up from clock-pause. Framework will call this to bring
+ *	the controller out of clock pause.
  */
 struct slim_controller {
 	struct device		dev;
@@ -285,12 +334,14 @@ struct slim_controller {
 	struct slim_ctrl_buf	rx;
 	struct slim_pending	*pending_wr;
 	struct semaphore	tx_sem;
+	struct slim_sched	sched;
 	int			(*xfer_msg)(struct slim_controller *ctrl,
 					    struct slim_msg_txn *tx, void *buf);
 	int			(*set_laddr)(struct slim_controller *ctrl,
 					     struct slim_eaddr *ea, u8 laddr);
 	int			(*get_laddr)(struct slim_controller *ctrl,
 					     struct slim_eaddr *ea, u8 *laddr);
+	int			(*wakeup)(struct slim_controller *ctrl);
 };
 
 #define to_slim_controller(d) container_of(d, struct slim_controller, dev)
@@ -444,7 +495,7 @@ int slim_processtxn(struct slim_controller *ctrl, struct slim_msg_txn *txn);
 void *slim_get_rx(struct slim_controller *ctrl);
 int slim_return_rx(struct slim_controller *ctrl, void *buf);
 void *slim_get_tx(struct slim_controller *ctrl, struct slim_msg_txn *txn,
-		  bool need_tid);
+		  bool need_tid, bool clk_pause);
 void slim_return_tx(struct slim_controller *ctrl, int err);
 
 static inline bool slim_tid_txn(u8 mt, u8 mc)
@@ -456,5 +507,6 @@ static inline bool slim_tid_txn(u8 mt, u8 mc)
 		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION));
 }
 /* end of message apis */
+int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart);
 
 #endif /* _LINUX_SLIMBUS_H */
-- 
2.9.3
