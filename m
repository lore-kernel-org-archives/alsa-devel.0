From: Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Use the generic IPC/mailbox
	APIs in Baytrail
Date: Tue,  7 Apr 2015 09:33:31 +0800
Message-ID: <1428370412-15155-3-git-send-email-yao.jin@linux.intel.com>
References: <1428370412-15155-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CA67926051D
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 03:26:45 +0200 (CEST)
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

Use the generic IPC/mailbox APIs to replace the original processing
code for Baytrail platform.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 360 ++++++----------------------
 1 file changed, 77 insertions(+), 283 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index aabb9b0..1efb33b 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -31,6 +31,7 @@
 #include "sst-baytrail-ipc.h"
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
+#include "../common/sst-ipc.h"
 
 /* IPC message timeout */
 #define IPC_TIMEOUT_MSECS	300
@@ -142,23 +143,6 @@ struct sst_byt_fw_init {
 	u8 debug_info;
 } __packed;
 
-/* driver internal IPC message structure */
-struct ipc_message {
-	struct list_head list;
-	u64 header;
-
-	/* direction wrt host CPU */
-	char tx_data[SST_BYT_IPC_MAX_PAYLOAD_SIZE];
-	size_t tx_size;
-	char rx_data[SST_BYT_IPC_MAX_PAYLOAD_SIZE];
-	size_t rx_size;
-
-	wait_queue_head_t waitq;
-	bool complete;
-	bool wait;
-	int errno;
-};
-
 struct sst_byt_stream;
 struct sst_byt;
 
@@ -195,14 +179,7 @@ struct sst_byt {
 	struct sst_fw *fw;
 
 	/* IPC messaging */
-	struct list_head tx_list;
-	struct list_head rx_list;
-	struct list_head empty_list;
-	wait_queue_head_t wait_txq;
-	struct task_struct *tx_thread;
-	struct kthread_worker kworker;
-	struct kthread_work kwork;
-	struct ipc_message *msg;
+	struct sst_generic_ipc ipc;
 };
 
 static inline u64 sst_byt_header(int msg_id, int data, bool large, int str_id)
@@ -246,209 +223,6 @@ static struct sst_byt_stream *sst_byt_get_stream(struct sst_byt *byt,
 	return NULL;
 }
 
-static void sst_byt_ipc_shim_dbg(struct sst_byt *byt, const char *text)
-{
-	struct sst_dsp *sst = byt->dsp;
-	u64 isr, ipcd, imrx, ipcx;
-
-	ipcx = sst_dsp_shim_read64_unlocked(sst, SST_IPCX);
-	isr = sst_dsp_shim_read64_unlocked(sst, SST_ISRX);
-	ipcd = sst_dsp_shim_read64_unlocked(sst, SST_IPCD);
-	imrx = sst_dsp_shim_read64_unlocked(sst, SST_IMRX);
-
-	dev_err(byt->dev,
-		"ipc: --%s-- ipcx 0x%llx isr 0x%llx ipcd 0x%llx imrx 0x%llx\n",
-		text, ipcx, isr, ipcd, imrx);
-}
-
-/* locks held by caller */
-static struct ipc_message *sst_byt_msg_get_empty(struct sst_byt *byt)
-{
-	struct ipc_message *msg = NULL;
-
-	if (!list_empty(&byt->empty_list)) {
-		msg = list_first_entry(&byt->empty_list,
-				       struct ipc_message, list);
-		list_del(&msg->list);
-	}
-
-	return msg;
-}
-
-static void sst_byt_ipc_tx_msgs(struct kthread_work *work)
-{
-	struct sst_byt *byt =
-		container_of(work, struct sst_byt, kwork);
-	struct ipc_message *msg;
-	u64 ipcx;
-	unsigned long flags;
-
-	spin_lock_irqsave(&byt->dsp->spinlock, flags);
-	if (list_empty(&byt->tx_list)) {
-		spin_unlock_irqrestore(&byt->dsp->spinlock, flags);
-		return;
-	}
-
-	/* if the DSP is busy we will TX messages after IRQ */
-	ipcx = sst_dsp_shim_read64_unlocked(byt->dsp, SST_IPCX);
-	if (ipcx & SST_BYT_IPCX_BUSY) {
-		spin_unlock_irqrestore(&byt->dsp->spinlock, flags);
-		return;
-	}
-
-	msg = list_first_entry(&byt->tx_list, struct ipc_message, list);
-
-	list_move(&msg->list, &byt->rx_list);
-
-	/* send the message */
-	if (msg->header & IPC_HEADER_LARGE(true))
-		sst_dsp_outbox_write(byt->dsp, msg->tx_data, msg->tx_size);
-	sst_dsp_shim_write64_unlocked(byt->dsp, SST_IPCX, msg->header);
-
-	spin_unlock_irqrestore(&byt->dsp->spinlock, flags);
-}
-
-static inline void sst_byt_tx_msg_reply_complete(struct sst_byt *byt,
-						 struct ipc_message *msg)
-{
-	msg->complete = true;
-
-	if (!msg->wait)
-		list_add_tail(&msg->list, &byt->empty_list);
-	else
-		wake_up(&msg->waitq);
-}
-
-static void sst_byt_drop_all(struct sst_byt *byt)
-{
-	struct ipc_message *msg, *tmp;
-	unsigned long flags;
-
-	/* drop all TX and Rx messages before we stall + reset DSP */
-	spin_lock_irqsave(&byt->dsp->spinlock, flags);
-	list_for_each_entry_safe(msg, tmp, &byt->tx_list, list) {
-		list_move(&msg->list, &byt->empty_list);
-	}
-
-	list_for_each_entry_safe(msg, tmp, &byt->rx_list, list) {
-		list_move(&msg->list, &byt->empty_list);
-	}
-
-	spin_unlock_irqrestore(&byt->dsp->spinlock, flags);
-}
-
-static int sst_byt_tx_wait_done(struct sst_byt *byt, struct ipc_message *msg,
-				void *rx_data)
-{
-	unsigned long flags;
-	int ret;
-
-	/* wait for DSP completion */
-	ret = wait_event_timeout(msg->waitq, msg->complete,
-				 msecs_to_jiffies(IPC_TIMEOUT_MSECS));
-
-	spin_lock_irqsave(&byt->dsp->spinlock, flags);
-	if (ret == 0) {
-		list_del(&msg->list);
-		sst_byt_ipc_shim_dbg(byt, "message timeout");
-
-		ret = -ETIMEDOUT;
-	} else {
-
-		/* copy the data returned from DSP */
-		if (msg->rx_size)
-			memcpy(rx_data, msg->rx_data, msg->rx_size);
-		ret = msg->errno;
-	}
-
-	list_add_tail(&msg->list, &byt->empty_list);
-	spin_unlock_irqrestore(&byt->dsp->spinlock, flags);
-	return ret;
-}
-
-static int sst_byt_ipc_tx_message(struct sst_byt *byt, u64 header,
-				  void *tx_data, size_t tx_bytes,
-				  void *rx_data, size_t rx_bytes, int wait)
-{
-	unsigned long flags;
-	struct ipc_message *msg;
-
-	spin_lock_irqsave(&byt->dsp->spinlock, flags);
-
-	msg = sst_byt_msg_get_empty(byt);
-	if (msg == NULL) {
-		spin_unlock_irqrestore(&byt->dsp->spinlock, flags);
-		return -EBUSY;
-	}
-
-	msg->header = header;
-	msg->tx_size = tx_bytes;
-	msg->rx_size = rx_bytes;
-	msg->wait = wait;
-	msg->errno = 0;
-	msg->complete = false;
-
-	if (tx_bytes) {
-		/* msg content = lower 32-bit of the header + data */
-		*(u32 *)msg->tx_data = (u32)(header & (u32)-1);
-		memcpy(msg->tx_data + sizeof(u32), tx_data, tx_bytes);
-		msg->tx_size += sizeof(u32);
-	}
-
-	list_add_tail(&msg->list, &byt->tx_list);
-	spin_unlock_irqrestore(&byt->dsp->spinlock, flags);
-
-	queue_kthread_work(&byt->kworker, &byt->kwork);
-
-	if (wait)
-		return sst_byt_tx_wait_done(byt, msg, rx_data);
-	else
-		return 0;
-}
-
-static inline int sst_byt_ipc_tx_msg_wait(struct sst_byt *byt, u64 header,
-					  void *tx_data, size_t tx_bytes,
-					  void *rx_data, size_t rx_bytes)
-{
-	return sst_byt_ipc_tx_message(byt, header, tx_data, tx_bytes,
-				      rx_data, rx_bytes, 1);
-}
-
-static inline int sst_byt_ipc_tx_msg_nowait(struct sst_byt *byt, u64 header,
-						void *tx_data, size_t tx_bytes)
-{
-	return sst_byt_ipc_tx_message(byt, header, tx_data, tx_bytes,
-				      NULL, 0, 0);
-}
-
-static struct ipc_message *sst_byt_reply_find_msg(struct sst_byt *byt,
-						  u64 header)
-{
-	struct ipc_message *msg = NULL, *_msg;
-	u64 mask;
-
-	/* match reply to message sent based on msg and stream IDs */
-	mask = IPC_HEADER_MSG_ID_MASK |
-	       IPC_HEADER_STR_ID_MASK << IPC_HEADER_STR_ID_SHIFT;
-	header &= mask;
-
-	if (list_empty(&byt->rx_list)) {
-		dev_err(byt->dev,
-			"ipc: rx list is empty but received 0x%llx\n", header);
-		goto out;
-	}
-
-	list_for_each_entry(_msg, &byt->rx_list, list) {
-		if ((_msg->header & mask) == header) {
-			msg = _msg;
-			break;
-		}
-	}
-
-out:
-	return msg;
-}
-
 static void sst_byt_stream_update(struct sst_byt *byt, struct ipc_message *msg)
 {
 	struct sst_byt_stream *stream;
@@ -477,7 +251,7 @@ static int sst_byt_process_reply(struct sst_byt *byt, u64 header)
 {
 	struct ipc_message *msg;
 
-	msg = sst_byt_reply_find_msg(byt, header);
+	msg = sst_ipc_reply_find_msg(&byt->ipc, header);
 	if (msg == NULL)
 		return 1;
 
@@ -491,7 +265,7 @@ static int sst_byt_process_reply(struct sst_byt *byt, u64 header)
 
 	list_del(&msg->list);
 	/* wake up */
-	sst_byt_tx_msg_reply_complete(byt, msg);
+	sst_ipc_tx_msg_reply_complete(&byt->ipc, msg);
 
 	return 1;
 }
@@ -538,6 +312,7 @@ static irqreturn_t sst_byt_irq_thread(int irq, void *context)
 {
 	struct sst_dsp *sst = (struct sst_dsp *) context;
 	struct sst_byt *byt = sst_dsp_get_thread_context(sst);
+	struct sst_generic_ipc *ipc = &byt->ipc;
 	u64 header;
 	unsigned long flags;
 
@@ -569,7 +344,7 @@ static irqreturn_t sst_byt_irq_thread(int irq, void *context)
 	spin_unlock_irqrestore(&sst->spinlock, flags);
 
 	/* continue to send any remaining messages... */
-	queue_kthread_work(&byt->kworker, &byt->kwork);
+	queue_kthread_work(&ipc->kworker, &ipc->kwork);
 
 	return IRQ_HANDLED;
 }
@@ -656,7 +431,8 @@ int sst_byt_stream_commit(struct sst_byt *byt, struct sst_byt_stream *stream)
 	header = sst_byt_header(IPC_IA_ALLOC_STREAM,
 				sizeof(*str_req) + sizeof(u32),
 				true, stream->str_id);
-	ret = sst_byt_ipc_tx_msg_wait(byt, header, str_req, sizeof(*str_req),
+	ret = sst_ipc_tx_message_wait(&byt->ipc, header, str_req,
+				      sizeof(*str_req),
 				      reply, sizeof(*reply));
 	if (ret < 0) {
 		dev_err(byt->dev, "ipc: error stream commit failed\n");
@@ -679,7 +455,7 @@ int sst_byt_stream_free(struct sst_byt *byt, struct sst_byt_stream *stream)
 		goto out;
 
 	header = sst_byt_header(IPC_IA_FREE_STREAM, 0, false, stream->str_id);
-	ret = sst_byt_ipc_tx_msg_wait(byt, header, NULL, 0, NULL, 0);
+	ret = sst_ipc_tx_message_wait(&byt->ipc, header, NULL, 0, NULL, 0);
 	if (ret < 0) {
 		dev_err(byt->dev, "ipc: free stream %d failed\n",
 			stream->str_id);
@@ -703,9 +479,11 @@ static int sst_byt_stream_operations(struct sst_byt *byt, int type,
 
 	header = sst_byt_header(type, 0, false, stream_id);
 	if (wait)
-		return sst_byt_ipc_tx_msg_wait(byt, header, NULL, 0, NULL, 0);
+		return sst_ipc_tx_message_wait(&byt->ipc, header, NULL,
+						0, NULL, 0);
 	else
-		return sst_byt_ipc_tx_msg_nowait(byt, header, NULL, 0);
+		return sst_ipc_tx_message_nowait(&byt->ipc, header,
+						NULL, 0);
 }
 
 /* stream ALSA trigger operations */
@@ -725,7 +503,7 @@ int sst_byt_stream_start(struct sst_byt *byt, struct sst_byt_stream *stream,
 	tx_msg = &start_stream;
 	size = sizeof(start_stream);
 
-	ret = sst_byt_ipc_tx_msg_nowait(byt, header, tx_msg, size);
+	ret = sst_ipc_tx_message_nowait(&byt->ipc, header, tx_msg, size);
 	if (ret < 0)
 		dev_err(byt->dev, "ipc: error failed to start stream %d\n",
 			stream->str_id);
@@ -790,23 +568,6 @@ int sst_byt_get_dsp_position(struct sst_byt *byt,
 	return do_div(fw_tstamp.ring_buffer_counter, buffer_size);
 }
 
-static int msg_empty_list_init(struct sst_byt *byt)
-{
-	struct ipc_message *msg;
-	int i;
-
-	byt->msg = kzalloc(sizeof(*msg) * IPC_EMPTY_LIST_SIZE, GFP_KERNEL);
-	if (byt->msg == NULL)
-		return -ENOMEM;
-
-	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
-		init_waitqueue_head(&byt->msg[i].waitq);
-		list_add(&byt->msg[i].list, &byt->empty_list);
-	}
-
-	return 0;
-}
-
 struct sst_dsp *sst_byt_get_dsp(struct sst_byt *byt)
 {
 	return byt->dsp;
@@ -823,7 +584,7 @@ int sst_byt_dsp_suspend_late(struct device *dev, struct sst_pdata *pdata)
 
 	dev_dbg(byt->dev, "dsp reset\n");
 	sst_dsp_reset(byt->dsp);
-	sst_byt_drop_all(byt);
+	sst_ipc_drop_all(&byt->ipc);
 	dev_dbg(byt->dev, "dsp in reset\n");
 
 	dev_dbg(byt->dev, "free all blocks and unload fw\n");
@@ -876,9 +637,52 @@ int sst_byt_dsp_wait_for_ready(struct device *dev, struct sst_pdata *pdata)
 }
 EXPORT_SYMBOL_GPL(sst_byt_dsp_wait_for_ready);
 
+static void byt_tx_msg(struct sst_generic_ipc *ipc, struct ipc_message *msg)
+{
+	if (msg->header & IPC_HEADER_LARGE(true))
+		sst_dsp_outbox_write(ipc->dsp, msg->tx_data, msg->tx_size);
+
+	sst_dsp_shim_write64_unlocked(ipc->dsp, SST_IPCX, msg->header);
+}
+
+static void byt_shim_dbg(struct sst_generic_ipc *ipc, const char *text)
+{
+	struct sst_dsp *sst = ipc->dsp;
+	u64 isr, ipcd, imrx, ipcx;
+
+	ipcx = sst_dsp_shim_read64_unlocked(sst, SST_IPCX);
+	isr = sst_dsp_shim_read64_unlocked(sst, SST_ISRX);
+	ipcd = sst_dsp_shim_read64_unlocked(sst, SST_IPCD);
+	imrx = sst_dsp_shim_read64_unlocked(sst, SST_IMRX);
+
+	dev_err(ipc->dev,
+		"ipc: --%s-- ipcx 0x%llx isr 0x%llx ipcd 0x%llx imrx 0x%llx\n",
+		text, ipcx, isr, ipcd, imrx);
+}
+
+static void byt_tx_data_copy(struct ipc_message *msg, char *tx_data,
+	size_t tx_size)
+{
+	/* msg content = lower 32-bit of the header + data */
+	*(u32 *)msg->tx_data = (u32)(msg->header & (u32)-1);
+	memcpy(msg->tx_data + sizeof(u32), tx_data, tx_size);
+	msg->tx_size += sizeof(u32);
+}
+
+static u64 byt_reply_msg_match(u64 header, u64 *mask)
+{
+	/* match reply to message sent based on msg and stream IDs */
+	*mask = IPC_HEADER_MSG_ID_MASK |
+	       IPC_HEADER_STR_ID_MASK << IPC_HEADER_STR_ID_SHIFT;
+	header &= *mask;
+
+	return header;
+}
+
 int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 {
 	struct sst_byt *byt;
+	struct sst_generic_ipc *ipc;
 	struct sst_fw *byt_sst_fw;
 	struct sst_byt_fw_init init;
 	int err;
@@ -889,39 +693,30 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	if (byt == NULL)
 		return -ENOMEM;
 
-	byt->dev = dev;
-	INIT_LIST_HEAD(&byt->stream_list);
-	INIT_LIST_HEAD(&byt->tx_list);
-	INIT_LIST_HEAD(&byt->rx_list);
-	INIT_LIST_HEAD(&byt->empty_list);
-	init_waitqueue_head(&byt->boot_wait);
-	init_waitqueue_head(&byt->wait_txq);
+	ipc = &byt->ipc;
+	ipc->dev = dev;
+	ipc->ops.tx_msg = byt_tx_msg;
+	ipc->ops.shim_dbg = byt_shim_dbg;
+	ipc->ops.tx_data_copy = byt_tx_data_copy;
+	ipc->ops.reply_msg_match = byt_reply_msg_match;
 
-	err = msg_empty_list_init(byt);
-	if (err < 0)
-		return -ENOMEM;
-
-	/* start the IPC message thread */
-	init_kthread_worker(&byt->kworker);
-	byt->tx_thread = kthread_run(kthread_worker_fn,
-				     &byt->kworker, "%s",
-				     dev_name(byt->dev));
-	if (IS_ERR(byt->tx_thread)) {
-		err = PTR_ERR(byt->tx_thread);
-		dev_err(byt->dev, "error failed to create message TX task\n");
-		goto err_free_msg;
-	}
-	init_kthread_work(&byt->kwork, sst_byt_ipc_tx_msgs);
+	err = sst_ipc_init(ipc);
+	if (err != 0)
+		goto ipc_init_err;
 
+	INIT_LIST_HEAD(&byt->stream_list);
+	init_waitqueue_head(&byt->boot_wait);
 	byt_dev.thread_context = byt;
 
 	/* init SST shim */
 	byt->dsp = sst_dsp_new(dev, &byt_dev, pdata);
 	if (byt->dsp == NULL) {
 		err = -ENODEV;
-		goto dsp_err;
+		goto dsp_new_err;
 	}
 
+	ipc->dsp = byt->dsp;
+
 	/* keep the DSP in reset state for base FW loading */
 	sst_dsp_reset(byt->dsp);
 
@@ -961,10 +756,10 @@ boot_err:
 	sst_fw_free(byt_sst_fw);
 fw_err:
 	sst_dsp_free(byt->dsp);
-dsp_err:
-	kthread_stop(byt->tx_thread);
-err_free_msg:
-	kfree(byt->msg);
+dsp_new_err:
+	sst_ipc_fini(ipc);
+ipc_init_err:
+	kfree(byt);
 
 	return err;
 }
@@ -977,7 +772,6 @@ void sst_byt_dsp_free(struct device *dev, struct sst_pdata *pdata)
 	sst_dsp_reset(byt->dsp);
 	sst_fw_free_all(byt->dsp);
 	sst_dsp_free(byt->dsp);
-	kthread_stop(byt->tx_thread);
-	kfree(byt->msg);
+	sst_ipc_fini(&byt->ipc);
 }
 EXPORT_SYMBOL_GPL(sst_byt_dsp_free);
-- 
1.9.1
