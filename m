From: srinivas.kandagatla@linaro.org
Subject: [PATCH v7 07/13] slimbus: Add support for
	'clock-pause' feature
Date: Wed, 15 Nov 2017 14:10:37 +0000
Message-ID: <20171115141043.29202-8-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54DBD2675C9
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 15:13:36 +0100 (CET)
Received: by mail-wr0-f193.google.com with SMTP id l22so20557773wrc.11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 06:13:36 -0800 (PST)
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
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
 drivers/slimbus/Makefile    |   2 +-
 drivers/slimbus/core.c      |  16 ++++++
 drivers/slimbus/messaging.c |  35 +++++++++++-
 drivers/slimbus/sched.c     | 128 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/slimbus/slimbus.h   |  54 +++++++++++++++++++
 5 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100644 drivers/slimbus/sched.c

diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
index dfa049a382ef..043402eae5be 100644
--- a/drivers/slimbus/Makefile
+++ b/drivers/slimbus/Makefile
@@ -2,4 +2,4 @@
 # Makefile for kernel slimbus framework.
 #
 obj-$(CONFIG_SLIMBUS)			+= slimbus.o
-slimbus-y				:= core.o messaging.o
+slimbus-y				:= core.o messaging.o sched.o
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index f7b14961c7e3..fa0ae157d6b0 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/idr.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/slimbus.h>
 #include "slimbus.h"
 
@@ -235,6 +236,8 @@ int slim_register_controller(struct slim_controller *ctrl)
 	ida_init(&ctrl->laddr_ida);
 	idr_init(&ctrl->tid_idr);
 	mutex_init(&ctrl->lock);
+	mutex_init(&ctrl->sched.m_reconf);
+	init_completion(&ctrl->sched.pause_comp);
 
 	dev_dbg(ctrl->dev, "Bus [%s] registered:dev:%p\n",
 		ctrl->name, ctrl->dev);
@@ -266,6 +269,8 @@ int slim_unregister_controller(struct slim_controller *ctrl)
 {
 	/* Remove all clients */
 	device_for_each_child(ctrl->dev, NULL, slim_ctrl_remove_device);
+	/* Enter Clock Pause */
+	slim_ctrl_clk_pause(ctrl, false, 0);
 	ida_simple_remove(&ctrl_ida, ctrl->id);
 
 	return 0;
@@ -432,6 +437,14 @@ int slim_device_report_present(struct slim_controller *ctrl,
 	struct slim_device *sbdev;
 	int ret;
 
+	ret = pm_runtime_get_sync(ctrl->dev);
+
+	if (ctrl->sched.clk_state != SLIM_CLK_ACTIVE) {
+		dev_err(ctrl->dev, "slim ctrl not active,state:%d, ret:%d\n",
+				    ctrl->sched.clk_state, ret);
+		goto slimbus_not_active;
+	}
+
 	sbdev = slim_get_device(ctrl, e_addr);
 	if (IS_ERR(sbdev))
 		return -ENODEV;
@@ -443,6 +456,9 @@ int slim_device_report_present(struct slim_controller *ctrl,
 
 	ret = slim_device_alloc_laddr(sbdev, laddr, true);
 
+slimbus_not_active:
+	pm_runtime_mark_last_busy(ctrl->dev);
+	pm_runtime_put_autosuspend(ctrl->dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(slim_device_report_present);
diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index ba78c1bfe15d..c11534eaf97b 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -10,6 +10,7 @@
  * GNU General Public License for more details.
  */
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include "slimbus.h"
 
 /**
@@ -52,6 +53,10 @@ void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
 	memcpy(msg->rbuf, reply, len);
 	if (txn->comp)
 		complete(txn->comp);
+
+	/* Remove runtime-pm vote now that response was received for TID txn */
+	pm_runtime_mark_last_busy(ctrl->dev);
+	pm_runtime_put_autosuspend(ctrl->dev);
 }
 EXPORT_SYMBOL_GPL(slim_msg_response);
 
@@ -73,10 +78,29 @@ EXPORT_SYMBOL_GPL(slim_msg_response);
 int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
-	bool need_tid;
+	bool need_tid = false, clk_pause_msg = false;
 	unsigned long flags;
 	int ret, tid, timeout;
 
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
+	if (!clk_pause_msg) {
+		ret = pm_runtime_get_sync(ctrl->dev);
+		if (ctrl->sched.clk_state != SLIM_CLK_ACTIVE) {
+			dev_err(ctrl->dev, "ctrl wrong state:%d, ret:%d\n",
+				ctrl->sched.clk_state, ret);
+			goto slim_xfer_err;
+		}
+	}
+
 	need_tid = slim_tid_txn(txn->mt, txn->mc);
 
 	if (need_tid) {
@@ -115,6 +139,15 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 		dev_err(ctrl->dev, "Tx:MT:0x%x, MC:0x%x, LA:0x%x failed:%d\n",
 			txn->mt, txn->mc, txn->la, ret);
 
+slim_xfer_err:
+	if (!clk_pause_msg && (!need_tid  || ret == -ETIMEDOUT)) {
+		/*
+		 * remove runtime-pm vote if this was TX only, or
+		 * if there was error during this transaction
+		 */
+		pm_runtime_mark_last_busy(ctrl->dev);
+		pm_runtime_mark_last_busy(ctrl->dev);
+	}
 	return ret;
 }
 
diff --git a/drivers/slimbus/sched.c b/drivers/slimbus/sched.c
new file mode 100644
index 000000000000..74300f1a6898
--- /dev/null
+++ b/drivers/slimbus/sched.c
@@ -0,0 +1,128 @@
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
+#include "slimbus.h"
+
+/**
+ * slim_ctrl_clk_pause() - Called by slimbus controller to enter/exit
+ *			   'clock pause'
+ * @ctrl: controller requesting bus to be paused or woken up
+ * @wakeup: Wakeup this controller from clock pause.
+ * @restart: Restart time value per spec used for clock pause. This value
+ *	isn't used when controller is to be woken up.
+ *
+ * Slimbus specification needs this sequence to turn-off clocks for the bus.
+ * The sequence involves sending 3 broadcast messages (reconfiguration
+ * sequence) to inform all devices on the bus.
+ * To exit clock-pause, controller typically wakes up active framer device.
+ * This API executes clock pause reconfiguration sequence if wakeup is false.
+ * If wakeup is true, controller's wakeup is called.
+ * For entering clock-pause, -EBUSY is returned if a message txn in pending.
+ */
+int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart)
+{
+	int i, ret = 0;
+	unsigned long flags;
+	struct slim_sched *sched = &ctrl->sched;
+	struct slim_val_inf msg = {0, 0, NULL, NULL};
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
+		/*
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
+		/*
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
+	for (i = 0; i < SLIM_MAX_TIDS; i++) {
+		/* Pending response for a message */
+		if (idr_find(&ctrl->tid_idr, i)) {
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
+	ret = slim_do_transfer(ctrl, &txn);
+	if (ret)
+		goto clk_pause_ret;
+
+	txn.mc = SLIM_MSG_MC_NEXT_PAUSE_CLOCK;
+	txn.rl = 4;
+	msg.num_bytes = 1;
+	msg.wbuf = &restart;
+	ret = slim_do_transfer(ctrl, &txn);
+	if (ret)
+		goto clk_pause_ret;
+
+	txn.mc = SLIM_MSG_MC_RECONFIGURE_NOW;
+	txn.rl = 3;
+	msg.num_bytes = 1;
+	msg.wbuf = NULL;
+	ret = slim_do_transfer(ctrl, &txn);
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
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index f3ed5d4dbb0a..4fe1892cbd4f 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -35,6 +35,16 @@
 #define SLIM_MSG_MC_REPLY_VALUE                  0x64
 #define SLIM_MSG_MC_CHANGE_VALUE                 0x68
 
+/* Clock pause Reconfiguration messages */
+#define SLIM_MSG_MC_BEGIN_RECONFIGURATION        0x40
+#define SLIM_MSG_MC_NEXT_PAUSE_CLOCK             0x4A
+#define SLIM_MSG_MC_RECONFIGURE_NOW              0x5F
+
+/* Clock pause values per slimbus spec */
+#define SLIM_CLK_FAST				0
+#define SLIM_CLK_CONST_PHASE			1
+#define SLIM_CLK_UNSPECIFIED			2
+
 /* Destination type Values */
 #define SLIM_MSG_DEST_LOGICALADDR	0
 #define SLIM_MSG_DEST_ENUMADDR		1
@@ -102,6 +112,43 @@ struct slim_msg_txn {
 #define DEFINE_SLIM_LDEST_TXN(name, mc, rl, la, msg) \
 	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_LOGICALADDR, 0,\
 					0, la, msg, }
+
+#define DEFINE_SLIM_BCAST_TXN(name, mc, rl, la, msg) \
+	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_BROADCAST, 0,\
+					0, la, msg, }
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
+};
+
 /**
  * struct slim_controller  - Controls every instance of SLIMbus
  *				(similar to 'master' on SPI)
@@ -118,6 +165,7 @@ struct slim_msg_txn {
  * @devices: Slim device list
  * @tid_idr: tid id allocator
  * @txn_lock: Lock to protect table of transactions
+ * @sched: scheduler structure used by the controller
  * @xfer_msg: Transfer a message on this controller (this can be a broadcast
  *	control/status message like data channel setup, or a unicast message
  *	like value element read/write.
@@ -128,6 +176,9 @@ struct slim_msg_txn {
  *	address table and get_laddr can be used in that case so that controller
  *	can do this assignment. Use case is when the master is on the remote
  *	processor side, who is resposible for allocating laddr.
+ * @wakeup: This function pointer implements controller-specific procedure
+ *	to wake it up from clock-pause. Framework will call this to bring
+ *	the controller out of clock pause.
  *
  *	'Manager device' is responsible for  device management, bandwidth
  *	allocation, channel setup, and port associations per channel.
@@ -162,12 +213,14 @@ struct slim_controller {
 	struct list_head	devices;
 	struct idr		tid_idr;
 	spinlock_t		txn_lock;
+	struct slim_sched	sched;
 	int			(*xfer_msg)(struct slim_controller *ctrl,
 					    struct slim_msg_txn *tx);
 	int			(*set_laddr)(struct slim_controller *ctrl,
 					     struct slim_eaddr *ea, u8 laddr);
 	int			(*get_laddr)(struct slim_controller *ctrl,
 					     struct slim_eaddr *ea, u8 *laddr);
+	int			(*wakeup)(struct slim_controller *ctrl);
 };
 
 int slim_device_report_present(struct slim_controller *ctrl,
@@ -177,6 +230,7 @@ int slim_register_controller(struct slim_controller *ctrl);
 int slim_unregister_controller(struct slim_controller *ctrl);
 void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 l);
 int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn);
+int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 restart);
 
 static inline bool slim_tid_txn(u8 mt, u8 mc)
 {
-- 
2.15.0
