From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 1/5] ASoC: Intel: Update request-reply IPC model
Date: Sat, 20 Jul 2019 21:45:28 +0200
Message-ID: <20190720194532.23682-2-cezary.rojewski@intel.com>
References: <20190720194532.23682-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF568F80390
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2019 21:46:51 +0200 (CEST)
In-Reply-To: <20190720194532.23682-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

struct ipc_message contains fields: header, tx_data and tx_size which
represent TX i.e. request while RX is represented by rx_data and rx_size
with reply's header equivalent missing.

Reply header may contain some vital information including, but not
limited to, received payload size. Some IPCs have entire payload found
within RX header instead. Content and value of said header is context
dependent and may vary between firmware versions and target platform.
Current model does not allow such IPCs to function at all.

Rather than appending yet another parameter to an already long list of
such for sst_ipc_tx_message_XXXs, declare message container in form of
struct sst_ipc_message and add them to parent's ipc_message declaration.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/common/sst-ipc.c | 69 ++++++++++++++++----------------
 sound/soc/intel/common/sst-ipc.h | 27 +++++++------
 2 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index ef5b66af1cd2..1186a03a88d6 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -43,7 +43,7 @@ static struct ipc_message *msg_get_empty(struct sst_generic_ipc *ipc)
 }
 
 static int tx_wait_done(struct sst_generic_ipc *ipc,
-	struct ipc_message *msg, void *rx_data)
+	struct ipc_message *msg, struct sst_ipc_message *reply)
 {
 	unsigned long flags;
 	int ret;
@@ -62,8 +62,11 @@ static int tx_wait_done(struct sst_generic_ipc *ipc,
 	} else {
 
 		/* copy the data returned from DSP */
-		if (rx_data)
-			memcpy(rx_data, msg->rx_data, msg->rx_size);
+		if (reply) {
+			reply->header = msg->rx.header;
+			if (reply->data)
+				memcpy(reply->data, msg->rx.data, msg->rx.size);
+		}
 		ret = msg->errno;
 	}
 
@@ -72,9 +75,9 @@ static int tx_wait_done(struct sst_generic_ipc *ipc,
 	return ret;
 }
 
-static int ipc_tx_message(struct sst_generic_ipc *ipc, u64 header,
-	void *tx_data, size_t tx_bytes, void *rx_data,
-	size_t rx_bytes, int wait)
+static int ipc_tx_message(struct sst_generic_ipc *ipc,
+	struct sst_ipc_message request,
+	struct sst_ipc_message *reply, int wait)
 {
 	struct ipc_message *msg;
 	unsigned long flags;
@@ -87,23 +90,24 @@ static int ipc_tx_message(struct sst_generic_ipc *ipc, u64 header,
 		return -EBUSY;
 	}
 
-	msg->header = header;
-	msg->tx_size = tx_bytes;
-	msg->rx_size = rx_bytes;
+	msg->tx.header = request.header;
+	msg->tx.size = request.size;
+	msg->rx.header = 0;
+	msg->rx.size = reply ? reply->size : 0;
 	msg->wait = wait;
 	msg->errno = 0;
 	msg->pending = false;
 	msg->complete = false;
 
-	if ((tx_bytes) && (ipc->ops.tx_data_copy != NULL))
-		ipc->ops.tx_data_copy(msg, tx_data, tx_bytes);
+	if ((request.size) && (ipc->ops.tx_data_copy != NULL))
+		ipc->ops.tx_data_copy(msg, request.data, request.size);
 
 	list_add_tail(&msg->list, &ipc->tx_list);
 	schedule_work(&ipc->kwork);
 	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
 
 	if (wait)
-		return tx_wait_done(ipc, msg, rx_data);
+		return tx_wait_done(ipc, msg, reply);
 	else
 		return 0;
 }
@@ -118,13 +122,13 @@ static int msg_empty_list_init(struct sst_generic_ipc *ipc)
 		return -ENOMEM;
 
 	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
-		ipc->msg[i].tx_data = kzalloc(ipc->tx_data_max_size, GFP_KERNEL);
-		if (ipc->msg[i].tx_data == NULL)
+		ipc->msg[i].tx.data = kzalloc(ipc->tx_data_max_size, GFP_KERNEL);
+		if (ipc->msg[i].tx.data == NULL)
 			goto free_mem;
 
-		ipc->msg[i].rx_data = kzalloc(ipc->rx_data_max_size, GFP_KERNEL);
-		if (ipc->msg[i].rx_data == NULL) {
-			kfree(ipc->msg[i].tx_data);
+		ipc->msg[i].rx.data = kzalloc(ipc->rx_data_max_size, GFP_KERNEL);
+		if (ipc->msg[i].rx.data == NULL) {
+			kfree(ipc->msg[i].tx.data);
 			goto free_mem;
 		}
 
@@ -136,8 +140,8 @@ static int msg_empty_list_init(struct sst_generic_ipc *ipc)
 
 free_mem:
 	while (i > 0) {
-		kfree(ipc->msg[i-1].tx_data);
-		kfree(ipc->msg[i-1].rx_data);
+		kfree(ipc->msg[i-1].tx.data);
+		kfree(ipc->msg[i-1].rx.data);
 		--i;
 	}
 	kfree(ipc->msg);
@@ -173,8 +177,8 @@ static void ipc_tx_msgs(struct work_struct *work)
 	spin_unlock_irq(&ipc->dsp->spinlock);
 }
 
-int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
-	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes)
+int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc,
+	struct sst_ipc_message request, struct sst_ipc_message *reply)
 {
 	int ret;
 
@@ -187,8 +191,7 @@ int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
 		if (ipc->ops.check_dsp_lp_on(ipc->dsp, true))
 			return -EIO;
 
-	ret = ipc_tx_message(ipc, header, tx_data, tx_bytes,
-		rx_data, rx_bytes, 1);
+	ret = ipc_tx_message(ipc, request, reply, 1);
 
 	if (ipc->ops.check_dsp_lp_on)
 		if (ipc->ops.check_dsp_lp_on(ipc->dsp, false))
@@ -198,19 +201,17 @@ int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
 }
 EXPORT_SYMBOL_GPL(sst_ipc_tx_message_wait);
 
-int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc, u64 header,
-	void *tx_data, size_t tx_bytes)
+int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc,
+	struct sst_ipc_message request)
 {
-	return ipc_tx_message(ipc, header, tx_data, tx_bytes,
-		NULL, 0, 0);
+	return ipc_tx_message(ipc, request, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(sst_ipc_tx_message_nowait);
 
-int sst_ipc_tx_message_nopm(struct sst_generic_ipc *ipc, u64 header,
-	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes)
+int sst_ipc_tx_message_nopm(struct sst_generic_ipc *ipc,
+	struct sst_ipc_message request, struct sst_ipc_message *reply)
 {
-	return ipc_tx_message(ipc, header, tx_data, tx_bytes,
-		rx_data, rx_bytes, 1);
+	return ipc_tx_message(ipc, request, reply, 1);
 }
 EXPORT_SYMBOL_GPL(sst_ipc_tx_message_nopm);
 
@@ -230,7 +231,7 @@ struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
 	}
 
 	list_for_each_entry(msg, &ipc->rx_list, list) {
-		if ((msg->header & mask) == header)
+		if ((msg->tx.header & mask) == header)
 			return msg;
 	}
 
@@ -304,8 +305,8 @@ void sst_ipc_fini(struct sst_generic_ipc *ipc)
 
 	if (ipc->msg) {
 		for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
-			kfree(ipc->msg[i].tx_data);
-			kfree(ipc->msg[i].rx_data);
+			kfree(ipc->msg[i].tx.data);
+			kfree(ipc->msg[i].rx.data);
 		}
 		kfree(ipc->msg);
 	}
diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
index ef38600e88f7..08c4831b2664 100644
--- a/sound/soc/intel/common/sst-ipc.h
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -17,15 +17,16 @@
 
 #define IPC_MAX_MAILBOX_BYTES	256
 
-struct ipc_message {
-	struct list_head list;
+struct sst_ipc_message {
 	u64 header;
+	void *data;
+	size_t size;
+};
 
-	/* direction wrt host CPU */
-	char *tx_data;
-	size_t tx_size;
-	char *rx_data;
-	size_t rx_size;
+struct ipc_message {
+	struct list_head list;
+	struct sst_ipc_message tx;
+	struct sst_ipc_message rx;
 
 	wait_queue_head_t waitq;
 	bool pending;
@@ -66,14 +67,14 @@ struct sst_generic_ipc {
 	struct sst_plat_ipc_ops ops;
 };
 
-int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
-	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes);
+int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc,
+	struct sst_ipc_message request, struct sst_ipc_message *reply);
 
-int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc, u64 header,
-	void *tx_data, size_t tx_bytes);
+int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc,
+	struct sst_ipc_message request);
 
-int sst_ipc_tx_message_nopm(struct sst_generic_ipc *ipc, u64 header,
-	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes);
+int sst_ipc_tx_message_nopm(struct sst_generic_ipc *ipc,
+	struct sst_ipc_message request, struct sst_ipc_message *reply);
 
 struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
 	u64 header);
-- 
2.17.1
