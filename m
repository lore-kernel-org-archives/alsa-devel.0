From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 3/5] ASoC: Intel: Baytrail: Align with updated
	request-reply model
Date: Sat, 20 Jul 2019 21:45:30 +0200
Message-ID: <20190720194532.23682-4-cezary.rojewski@intel.com>
References: <20190720194532.23682-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A6C1F802BC
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2019 21:46:49 +0200 (CEST)
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

There is struct sst_ipc_message instance representing request and reply
each, and params: header, data and size need no longer to be declared
explicitly. Align with that model.

Update reply processing function to save RX header within message
container.

Despite the range of changes, status quo is achieved.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 65 ++++++++++-----------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 8bd1eddcc091..74274bd38f7a 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -211,7 +211,7 @@ static struct sst_byt_stream *sst_byt_get_stream(struct sst_byt *byt,
 static void sst_byt_stream_update(struct sst_byt *byt, struct ipc_message *msg)
 {
 	struct sst_byt_stream *stream;
-	u64 header = msg->header;
+	u64 header = msg->tx.header;
 	u8 stream_id = sst_byt_header_str_id(header);
 	u8 stream_msg = sst_byt_header_msg_id(header);
 
@@ -240,9 +240,10 @@ static int sst_byt_process_reply(struct sst_byt *byt, u64 header)
 	if (msg == NULL)
 		return 1;
 
+	msg->rx.header = header;
 	if (header & IPC_HEADER_LARGE(true)) {
-		msg->rx_size = sst_byt_header_data(header);
-		sst_dsp_inbox_read(byt->dsp, msg->rx_data, msg->rx_size);
+		msg->rx.size = sst_byt_header_data(header);
+		sst_dsp_inbox_read(byt->dsp, msg->rx.data, msg->rx.size);
 	}
 
 	/* update any stream states */
@@ -407,17 +408,18 @@ int sst_byt_stream_buffer(struct sst_byt *byt, struct sst_byt_stream *stream,
 
 int sst_byt_stream_commit(struct sst_byt *byt, struct sst_byt_stream *stream)
 {
-	struct sst_byt_alloc_params *str_req = &stream->request;
-	struct sst_byt_alloc_response *reply = &stream->reply;
-	u64 header;
+	struct sst_ipc_message request, reply = {0};
 	int ret;
 
-	header = sst_byt_header(IPC_IA_ALLOC_STREAM,
-				sizeof(*str_req) + sizeof(u32),
+	request.header = sst_byt_header(IPC_IA_ALLOC_STREAM,
+				sizeof(stream->request) + sizeof(u32),
 				true, stream->str_id);
-	ret = sst_ipc_tx_message_wait(&byt->ipc, header, str_req,
-				      sizeof(*str_req),
-				      reply, sizeof(*reply));
+	request.data = &stream->request;
+	request.size = sizeof(stream->request);
+	reply.data = &stream->reply;
+	reply.size = sizeof(stream->reply);
+
+	ret = sst_ipc_tx_message_wait(&byt->ipc, request, &reply);
 	if (ret < 0) {
 		dev_err(byt->dev, "ipc: error stream commit failed\n");
 		return ret;
@@ -430,7 +432,7 @@ int sst_byt_stream_commit(struct sst_byt *byt, struct sst_byt_stream *stream)
 
 int sst_byt_stream_free(struct sst_byt *byt, struct sst_byt_stream *stream)
 {
-	u64 header;
+	struct sst_ipc_message request = {0};
 	int ret = 0;
 	struct sst_dsp *sst = byt->dsp;
 	unsigned long flags;
@@ -438,8 +440,9 @@ int sst_byt_stream_free(struct sst_byt *byt, struct sst_byt_stream *stream)
 	if (!stream->commited)
 		goto out;
 
-	header = sst_byt_header(IPC_IA_FREE_STREAM, 0, false, stream->str_id);
-	ret = sst_ipc_tx_message_wait(&byt->ipc, header, NULL, 0, NULL, 0);
+	request.header = sst_byt_header(IPC_IA_FREE_STREAM,
+			0, false, stream->str_id);
+	ret = sst_ipc_tx_message_wait(&byt->ipc, request, NULL);
 	if (ret < 0) {
 		dev_err(byt->dev, "ipc: free stream %d failed\n",
 			stream->str_id);
@@ -459,15 +462,13 @@ int sst_byt_stream_free(struct sst_byt *byt, struct sst_byt_stream *stream)
 static int sst_byt_stream_operations(struct sst_byt *byt, int type,
 				     int stream_id, int wait)
 {
-	u64 header;
+	struct sst_ipc_message request = {0};
 
-	header = sst_byt_header(type, 0, false, stream_id);
+	request.header = sst_byt_header(type, 0, false, stream_id);
 	if (wait)
-		return sst_ipc_tx_message_wait(&byt->ipc, header, NULL,
-						0, NULL, 0);
+		return sst_ipc_tx_message_wait(&byt->ipc, request, NULL);
 	else
-		return sst_ipc_tx_message_nowait(&byt->ipc, header,
-						NULL, 0);
+		return sst_ipc_tx_message_nowait(&byt->ipc, request);
 }
 
 /* stream ALSA trigger operations */
@@ -475,19 +476,17 @@ int sst_byt_stream_start(struct sst_byt *byt, struct sst_byt_stream *stream,
 			 u32 start_offset)
 {
 	struct sst_byt_start_stream_params start_stream;
-	void *tx_msg;
-	size_t size;
-	u64 header;
+	struct sst_ipc_message request;
 	int ret;
 
 	start_stream.byte_offset = start_offset;
-	header = sst_byt_header(IPC_IA_START_STREAM,
+	request.header = sst_byt_header(IPC_IA_START_STREAM,
 				sizeof(start_stream) + sizeof(u32),
 				true, stream->str_id);
-	tx_msg = &start_stream;
-	size = sizeof(start_stream);
+	request.data = &start_stream;
+	request.size = sizeof(start_stream);
 
-	ret = sst_ipc_tx_message_nowait(&byt->ipc, header, tx_msg, size);
+	ret = sst_ipc_tx_message_nowait(&byt->ipc, request);
 	if (ret < 0)
 		dev_err(byt->dev, "ipc: error failed to start stream %d\n",
 			stream->str_id);
@@ -623,10 +622,10 @@ EXPORT_SYMBOL_GPL(sst_byt_dsp_wait_for_ready);
 
 static void byt_tx_msg(struct sst_generic_ipc *ipc, struct ipc_message *msg)
 {
-	if (msg->header & IPC_HEADER_LARGE(true))
-		sst_dsp_outbox_write(ipc->dsp, msg->tx_data, msg->tx_size);
+	if (msg->tx.header & IPC_HEADER_LARGE(true))
+		sst_dsp_outbox_write(ipc->dsp, msg->tx.data, msg->tx.size);
 
-	sst_dsp_shim_write64_unlocked(ipc->dsp, SST_IPCX, msg->header);
+	sst_dsp_shim_write64_unlocked(ipc->dsp, SST_IPCX, msg->tx.header);
 }
 
 static void byt_shim_dbg(struct sst_generic_ipc *ipc, const char *text)
@@ -648,9 +647,9 @@ static void byt_tx_data_copy(struct ipc_message *msg, char *tx_data,
 	size_t tx_size)
 {
 	/* msg content = lower 32-bit of the header + data */
-	*(u32 *)msg->tx_data = (u32)(msg->header & (u32)-1);
-	memcpy(msg->tx_data + sizeof(u32), tx_data, tx_size);
-	msg->tx_size += sizeof(u32);
+	*(u32 *)msg->tx.data = (u32)(msg->tx.header & (u32)-1);
+	memcpy(msg->tx.data + sizeof(u32), tx_data, tx_size);
+	msg->tx.size += sizeof(u32);
 }
 
 static u64 byt_reply_msg_match(u64 header, u64 *mask)
-- 
2.17.1
