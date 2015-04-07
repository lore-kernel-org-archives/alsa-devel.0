From: Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Refactor common IPC/mailbox
	code into generic APIs
Date: Tue,  7 Apr 2015 09:33:30 +0800
Message-ID: <1428370412-15155-2-git-send-email-yao.jin@linux.intel.com>
References: <1428370412-15155-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A5E260513
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 03:26:49 +0200 (CEST)
In-Reply-To: <1428370412-15155-1-git-send-email-yao.jin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, Jin Yao <yao.jin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Currently in Intel SST driver, some similar IPC/mailbox processing
code are used in different platforms (e.g. in baytrail/broadwell).

This patch extracts the common code and creates new files
(sst-ipc.c/sst-ipc.h) to contain the common code and provide the generic
APIs for IPC/mailbox processing.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 sound/soc/intel/common/Makefile  |   3 +-
 sound/soc/intel/common/sst-ipc.c | 294 +++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-ipc.h |  91 ++++++++++++
 3 files changed, 387 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/common/sst-ipc.c
 create mode 100644 sound/soc/intel/common/sst-ipc.h

diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 3df0e1c..f24154c 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,6 +1,7 @@
 snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
 snd-soc-sst-acpi-objs := sst-acpi.o
+snd-soc-sst-ipc-objs := sst-ipc.o
 
-obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o
+obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
 
diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
new file mode 100644
index 0000000..4b62a55
--- /dev/null
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -0,0 +1,294 @@
+/*
+ * Intel SST generic IPC Support
+ *
+ * Copyright (C) 2015, Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/kthread.h>
+#include <sound/asound.h>
+
+#include "sst-dsp.h"
+#include "sst-dsp-priv.h"
+#include "sst-ipc.h"
+
+/* IPC message timeout (msecs) */
+#define IPC_TIMEOUT_MSECS	300
+
+#define IPC_EMPTY_LIST_SIZE	8
+
+/* locks held by caller */
+static struct ipc_message *msg_get_empty(struct sst_generic_ipc *ipc)
+{
+	struct ipc_message *msg = NULL;
+
+	if (!list_empty(&ipc->empty_list)) {
+		msg = list_first_entry(&ipc->empty_list, struct ipc_message,
+			list);
+		list_del(&msg->list);
+	}
+
+	return msg;
+}
+
+static int tx_wait_done(struct sst_generic_ipc *ipc,
+	struct ipc_message *msg, void *rx_data)
+{
+	unsigned long flags;
+	int ret;
+
+	/* wait for DSP completion (in all cases atm inc pending) */
+	ret = wait_event_timeout(msg->waitq, msg->complete,
+		msecs_to_jiffies(IPC_TIMEOUT_MSECS));
+
+	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
+	if (ret == 0) {
+		if (ipc->ops.shim_dbg != NULL)
+			ipc->ops.shim_dbg(ipc, "message timeout");
+
+		list_del(&msg->list);
+		ret = -ETIMEDOUT;
+	} else {
+
+		/* copy the data returned from DSP */
+		if (msg->rx_size)
+			memcpy(rx_data, msg->rx_data, msg->rx_size);
+		ret = msg->errno;
+	}
+
+	list_add_tail(&msg->list, &ipc->empty_list);
+	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
+	return ret;
+}
+
+static int ipc_tx_message(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes, void *rx_data,
+	size_t rx_bytes, int wait)
+{
+	struct ipc_message *msg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
+
+	msg = msg_get_empty(ipc);
+	if (msg == NULL) {
+		spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
+		return -EBUSY;
+	}
+
+	msg->header = header;
+	msg->tx_size = tx_bytes;
+	msg->rx_size = rx_bytes;
+	msg->wait = wait;
+	msg->errno = 0;
+	msg->pending = false;
+	msg->complete = false;
+
+	if ((tx_bytes) && (ipc->ops.tx_data_copy != NULL))
+		ipc->ops.tx_data_copy(msg, tx_data, tx_bytes);
+
+	list_add_tail(&msg->list, &ipc->tx_list);
+	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
+
+	queue_kthread_work(&ipc->kworker, &ipc->kwork);
+
+	if (wait)
+		return tx_wait_done(ipc, msg, rx_data);
+	else
+		return 0;
+}
+
+static int msg_empty_list_init(struct sst_generic_ipc *ipc)
+{
+	int i;
+
+	ipc->msg = kzalloc(sizeof(struct ipc_message) *
+		IPC_EMPTY_LIST_SIZE, GFP_KERNEL);
+	if (ipc->msg == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
+		init_waitqueue_head(&ipc->msg[i].waitq);
+		list_add(&ipc->msg[i].list, &ipc->empty_list);
+	}
+
+	return 0;
+}
+
+static void ipc_tx_msgs(struct kthread_work *work)
+{
+	struct sst_generic_ipc *ipc =
+		container_of(work, struct sst_generic_ipc, kwork);
+	struct ipc_message *msg;
+	unsigned long flags;
+	u64 ipcx;
+
+	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
+
+	if (list_empty(&ipc->tx_list) || ipc->pending) {
+		spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
+		return;
+	}
+
+	/* if the DSP is busy, we will TX messages after IRQ.
+	 * also postpone if we are in the middle of procesing completion irq*/
+	ipcx = sst_dsp_shim_read_unlocked(ipc->dsp, SST_IPCX);
+	if (ipcx & (SST_IPCX_BUSY | SST_IPCX_DONE)) {
+		spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
+		return;
+	}
+
+	msg = list_first_entry(&ipc->tx_list, struct ipc_message, list);
+	list_move(&msg->list, &ipc->rx_list);
+
+	if (ipc->ops.tx_msg != NULL)
+		ipc->ops.tx_msg(ipc, msg);
+
+	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
+}
+
+int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes)
+{
+	return ipc_tx_message(ipc, header, tx_data, tx_bytes,
+		rx_data, rx_bytes, 1);
+}
+EXPORT_SYMBOL_GPL(sst_ipc_tx_message_wait);
+
+int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes)
+{
+	return ipc_tx_message(ipc, header, tx_data, tx_bytes,
+		NULL, 0, 0);
+}
+EXPORT_SYMBOL_GPL(sst_ipc_tx_message_nowait);
+
+struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
+	u64 header)
+{
+	struct ipc_message *msg;
+	u64 mask;
+
+	if (ipc->ops.reply_msg_match != NULL)
+		header = ipc->ops.reply_msg_match(header, &mask);
+
+	if (list_empty(&ipc->rx_list)) {
+		dev_err(ipc->dev, "error: rx list empty but received 0x%llx\n",
+			header);
+		return NULL;
+	}
+
+	list_for_each_entry(msg, &ipc->rx_list, list) {
+		if ((msg->header & mask) == header)
+			return msg;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(sst_ipc_reply_find_msg);
+
+/* locks held by caller */
+void sst_ipc_tx_msg_reply_complete(struct sst_generic_ipc *ipc,
+	struct ipc_message *msg)
+{
+	msg->complete = true;
+
+	if (!msg->wait)
+		list_add_tail(&msg->list, &ipc->empty_list);
+	else
+		wake_up(&msg->waitq);
+}
+EXPORT_SYMBOL_GPL(sst_ipc_tx_msg_reply_complete);
+
+void sst_ipc_drop_all(struct sst_generic_ipc *ipc)
+{
+	struct ipc_message *msg, *tmp;
+	unsigned long flags;
+	int tx_drop_cnt = 0, rx_drop_cnt = 0;
+
+	/* drop all TX and Rx messages before we stall + reset DSP */
+	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
+
+	list_for_each_entry_safe(msg, tmp, &ipc->tx_list, list) {
+		list_move(&msg->list, &ipc->empty_list);
+		tx_drop_cnt++;
+	}
+
+	list_for_each_entry_safe(msg, tmp, &ipc->rx_list, list) {
+		list_move(&msg->list, &ipc->empty_list);
+		rx_drop_cnt++;
+	}
+
+	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
+
+	if (tx_drop_cnt || rx_drop_cnt)
+		dev_err(ipc->dev, "dropped IPC msg RX=%d, TX=%d\n",
+			tx_drop_cnt, rx_drop_cnt);
+}
+EXPORT_SYMBOL_GPL(sst_ipc_drop_all);
+
+int sst_ipc_init(struct sst_generic_ipc *ipc)
+{
+	int ret;
+
+	INIT_LIST_HEAD(&ipc->tx_list);
+	INIT_LIST_HEAD(&ipc->rx_list);
+	INIT_LIST_HEAD(&ipc->empty_list);
+	init_waitqueue_head(&ipc->wait_txq);
+
+	ret = msg_empty_list_init(ipc);
+	if (ret < 0)
+		return -ENOMEM;
+
+	/* start the IPC message thread */
+	init_kthread_worker(&ipc->kworker);
+	ipc->tx_thread = kthread_run(kthread_worker_fn,
+					&ipc->kworker, "%s",
+					dev_name(ipc->dev));
+	if (IS_ERR(ipc->tx_thread)) {
+		dev_err(ipc->dev, "error: failed to create message TX task\n");
+		ret = PTR_ERR(ipc->tx_thread);
+		kfree(ipc->msg);
+		return ret;
+	}
+
+	init_kthread_work(&ipc->kwork, ipc_tx_msgs);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_ipc_init);
+
+void sst_ipc_fini(struct sst_generic_ipc *ipc)
+{
+	if (ipc->tx_thread)
+		kthread_stop(ipc->tx_thread);
+
+	if (ipc->msg)
+		kfree(ipc->msg);
+}
+EXPORT_SYMBOL_GPL(sst_ipc_fini);
+
+/* Module information */
+MODULE_AUTHOR("Jin Yao");
+MODULE_DESCRIPTION("Intel SST IPC generic");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
new file mode 100644
index 0000000..125ea45
--- /dev/null
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -0,0 +1,91 @@
+/*
+ * Intel SST generic IPC Support
+ *
+ * Copyright (C) 2015, Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __SST_GENERIC_IPC_H
+#define __SST_GENERIC_IPC_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
+
+#define IPC_MAX_MAILBOX_BYTES	256
+
+struct ipc_message {
+	struct list_head list;
+	u64 header;
+
+	/* direction wrt host CPU */
+	char tx_data[IPC_MAX_MAILBOX_BYTES];
+	size_t tx_size;
+	char rx_data[IPC_MAX_MAILBOX_BYTES];
+	size_t rx_size;
+
+	wait_queue_head_t waitq;
+	bool pending;
+	bool complete;
+	bool wait;
+	int errno;
+};
+
+struct sst_generic_ipc;
+
+struct sst_plat_ipc_ops {
+	void (*tx_msg)(struct sst_generic_ipc *, struct ipc_message *);
+	void (*shim_dbg)(struct sst_generic_ipc *, const char *);
+	void (*tx_data_copy)(struct ipc_message *, char *, size_t);
+	u64  (*reply_msg_match)(u64 header, u64 *mask);
+};
+
+/* SST generic IPC data */
+struct sst_generic_ipc {
+	struct device *dev;
+	struct sst_dsp *dsp;
+
+	/* IPC messaging */
+	struct list_head tx_list;
+	struct list_head rx_list;
+	struct list_head empty_list;
+	wait_queue_head_t wait_txq;
+	struct task_struct *tx_thread;
+	struct kthread_worker kworker;
+	struct kthread_work kwork;
+	bool pending;
+	struct ipc_message *msg;
+
+	struct sst_plat_ipc_ops ops;
+};
+
+int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes);
+
+int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes);
+
+struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
+	u64 header);
+
+void sst_ipc_tx_msg_reply_complete(struct sst_generic_ipc *ipc,
+	struct ipc_message *msg);
+
+void sst_ipc_drop_all(struct sst_generic_ipc *ipc);
+int sst_ipc_init(struct sst_generic_ipc *ipc);
+void sst_ipc_fini(struct sst_generic_ipc *ipc);
+
+#endif
-- 
1.9.1
