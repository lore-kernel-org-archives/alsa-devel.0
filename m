From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix module load when
	module size > DMA buffer size" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:21 +0000
Message-ID: <E1coDQH-0002D2-Q1@debutante>
References: <1489423292-19997-10-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2CE267046
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:31 +0100 (CET)
In-Reply-To: <1489423292-19997-10-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix module load when module size > DMA buffer size

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b7d0254c51f3ce79a8931690e8a2f035208f6b55 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 13 Mar 2017 22:11:31 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix module load when module size > DMA
 buffer size

When module size > DMA buffer size, driver copies first chunk and waits
for the BDL complete interrupt. BDL complete interrupt never occurs and
wait time expires as module load IPC is not send to start the DMA from
DSP.

To fix the above issue need to follow the below steps:
1. After copying the first chunk, send the module load IPC to start the
DMA.
2. Wait for the BDL interrupt. Once interrupt is received, copy the
next chunk.
3. Continue step 2 till all bytes are copied.
4. When all the bytes are copied (bytes_left = 0), wait for module load
IPC response
5. Handled module load IPC response messages, check the load module IPC
response and wake up the thread to complete module load.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 26 ++++++++-----
 sound/soc/intel/skylake/skl-sst-cldma.h |  2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h   |  1 +
 sound/soc/intel/skylake/skl-sst-ipc.c   | 66 ++++++++++++++++++++++-----------
 sound/soc/intel/skylake/skl-sst-ipc.h   |  5 +++
 sound/soc/intel/skylake/skl-sst.c       | 53 ++++++++++++++++++++------
 6 files changed, 110 insertions(+), 43 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index c9f6d87381db..d2b1d60fec02 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -164,7 +164,7 @@ static void skl_cldma_cleanup(struct sst_dsp  *ctx)
 	ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_bdl);
 }
 
-static int skl_cldma_wait_interruptible(struct sst_dsp *ctx)
+int skl_cldma_wait_interruptible(struct sst_dsp *ctx)
 {
 	int ret = 0;
 
@@ -243,9 +243,14 @@ static void skl_cldma_fill_buffer(struct sst_dsp *ctx, unsigned int size,
  * 2. Polling on fw register to identify if data left to transferred doesn't
  *    fill the ring buffer. Caller takes care of polling the required status
  *    register to identify the transfer status.
+ * 3. if wait flag is set, waits for DBL interrupt to copy the next chunk till
+ *    bytes_left is 0.
+ *    if wait flag is not set, doesn't wait for BDL interrupt. after ccopying
+ *    the first chunk return the no of bytes_left to be copied.
  */
 static int
-skl_cldma_copy_to_buf(struct sst_dsp *ctx, const void *bin, u32 total_size)
+skl_cldma_copy_to_buf(struct sst_dsp *ctx, const void *bin,
+			u32 total_size, bool wait)
 {
 	int ret = 0;
 	bool start = true;
@@ -272,13 +277,14 @@ skl_cldma_copy_to_buf(struct sst_dsp *ctx, const void *bin, u32 total_size)
 			size = ctx->cl_dev.bufsize;
 			skl_cldma_fill_buffer(ctx, size, curr_pos, true, start);
 
-			start = false;
-			ret = skl_cldma_wait_interruptible(ctx);
-			if (ret < 0) {
-				skl_cldma_stop(ctx);
-				return ret;
+			if (wait) {
+				start = false;
+				ret = skl_cldma_wait_interruptible(ctx);
+				if (ret < 0) {
+					skl_cldma_stop(ctx);
+					return ret;
+				}
 			}
-
 		} else {
 			skl_cldma_int_disable(ctx);
 
@@ -298,9 +304,11 @@ skl_cldma_copy_to_buf(struct sst_dsp *ctx, const void *bin, u32 total_size)
 		}
 		bytes_left -= size;
 		curr_pos = curr_pos + size;
+		if (!wait)
+			return bytes_left;
 	}
 
-	return ret;
+	return bytes_left;
 }
 
 void skl_cldma_process_intr(struct sst_dsp *ctx)
diff --git a/sound/soc/intel/skylake/skl-sst-cldma.h b/sound/soc/intel/skylake/skl-sst-cldma.h
index 99e4c86b6358..5b730a1a0ae4 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.h
+++ b/sound/soc/intel/skylake/skl-sst-cldma.h
@@ -213,7 +213,7 @@ struct skl_cl_dev_ops {
 	void (*cl_trigger)(struct sst_dsp  *ctx, bool enable);
 	void (*cl_cleanup_controller)(struct sst_dsp  *ctx);
 	int (*cl_copy_to_dmabuf)(struct sst_dsp *ctx,
-			const void *bin, u32 size);
+			const void *bin, u32 size, bool wait);
 	void (*cl_stop_dma)(struct sst_dsp *ctx);
 };
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index e8d1e149e0cd..5d7a93aa5bed 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -186,6 +186,7 @@ struct skl_module_table {
 void skl_cldma_process_intr(struct sst_dsp *ctx);
 void skl_cldma_int_disable(struct sst_dsp *ctx);
 int skl_cldma_prepare(struct sst_dsp *ctx);
+int skl_cldma_wait_interruptible(struct sst_dsp *ctx);
 
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index e1391dfbc9e9..e90fe2c0bf2c 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -34,6 +34,11 @@
 #define IPC_GLB_REPLY_STATUS_MASK	((0x1 << IPC_GLB_REPLY_STATUS_SHIFT) - 1)
 #define IPC_GLB_REPLY_STATUS(x)		((x) << IPC_GLB_REPLY_STATUS_SHIFT)
 
+#define IPC_GLB_REPLY_TYPE_SHIFT	29
+#define IPC_GLB_REPLY_TYPE_MASK		0x1F
+#define IPC_GLB_REPLY_TYPE(x)		(((x) >> IPC_GLB_REPLY_TYPE_SHIFT) \
+					& IPC_GLB_RPLY_TYPE_MASK)
+
 #define IPC_TIMEOUT_MSECS		3000
 
 #define IPC_EMPTY_LIST_SIZE		8
@@ -387,12 +392,27 @@ static int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
 	return 0;
 }
 
+static int skl_ipc_set_reply_error_code(u32 reply)
+{
+	switch (reply) {
+	case IPC_GLB_REPLY_OUT_OF_MEMORY:
+		return -ENOMEM;
+
+	case IPC_GLB_REPLY_BUSY:
+		return -EBUSY;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 		struct skl_ipc_header header)
 {
 	struct ipc_message *msg;
 	u32 reply = header.primary & IPC_GLB_REPLY_STATUS_MASK;
 	u64 *ipc_header = (u64 *)(&header);
+	struct skl_sst *skl = container_of(ipc, struct skl_sst, ipc);
 
 	msg = skl_ipc_reply_get_msg(ipc, *ipc_header);
 	if (msg == NULL) {
@@ -401,33 +421,37 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 	}
 
 	/* first process the header */
-	switch (reply) {
-	case IPC_GLB_REPLY_SUCCESS:
+	if (reply == IPC_GLB_REPLY_SUCCESS) {
 		dev_dbg(ipc->dev, "ipc FW reply %x: success\n", header.primary);
 		/* copy the rx data from the mailbox */
 		sst_dsp_inbox_read(ipc->dsp, msg->rx_data, msg->rx_size);
-		break;
-
-	case IPC_GLB_REPLY_OUT_OF_MEMORY:
-		dev_err(ipc->dev, "ipc fw reply: %x: no memory\n", header.primary);
-		msg->errno = -ENOMEM;
-		break;
-
-	case IPC_GLB_REPLY_BUSY:
-		dev_err(ipc->dev, "ipc fw reply: %x: Busy\n", header.primary);
-		msg->errno = -EBUSY;
-		break;
+		switch (IPC_GLB_NOTIFY_MSG_TYPE(header.primary)) {
+		case IPC_GLB_LOAD_MULTIPLE_MODS:
+			skl->mod_load_complete = true;
+			skl->mod_load_status = true;
+			wake_up(&skl->mod_load_wait);
+			break;
 
-	default:
-		dev_err(ipc->dev, "Unknown ipc reply: 0x%x\n", reply);
-		msg->errno = -EINVAL;
-		break;
-	}
+		default:
+			break;
 
-	if (reply != IPC_GLB_REPLY_SUCCESS) {
+		}
+	} else {
+		msg->errno = skl_ipc_set_reply_error_code(reply);
 		dev_err(ipc->dev, "ipc FW reply: reply=%d\n", reply);
 		dev_err(ipc->dev, "FW Error Code: %u\n",
 			ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+		switch (IPC_GLB_NOTIFY_MSG_TYPE(header.primary)) {
+		case IPC_GLB_LOAD_MULTIPLE_MODS:
+			skl->mod_load_complete = true;
+			skl->mod_load_status = false;
+			wake_up(&skl->mod_load_wait);
+			break;
+
+		default:
+			break;
+
+		}
 	}
 
 	list_del(&msg->list);
@@ -811,8 +835,8 @@ int skl_ipc_load_modules(struct sst_generic_ipc *ipc,
 	header.primary |= IPC_GLB_TYPE(IPC_GLB_LOAD_MULTIPLE_MODS);
 	header.primary |= IPC_LOAD_MODULE_CNT(module_cnt);
 
-	ret = sst_ipc_tx_message_wait(ipc, *ipc_header, data,
-				(sizeof(u16) * module_cnt), NULL, 0);
+	ret = sst_ipc_tx_message_nowait(ipc, *ipc_header, data,
+				(sizeof(u16) * module_cnt));
 	if (ret < 0)
 		dev_err(ipc->dev, "ipc: load modules failed :%d\n", ret);
 
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 7d21f055328d..fc07c397b060 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -77,6 +77,11 @@ struct skl_sst {
 	wait_queue_head_t boot_wait;
 	bool boot_complete;
 
+	/* module load */
+	wait_queue_head_t mod_load_wait;
+	bool mod_load_complete;
+	bool mod_load_status;
+
 	/* IPC messaging */
 	struct sst_generic_ipc ipc;
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index b30bd384c8d3..39d4aaac73bf 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -52,7 +52,8 @@ static int skl_transfer_firmware(struct sst_dsp *ctx,
 {
 	int ret = 0;
 
-	ret = ctx->cl_dev.ops.cl_copy_to_dmabuf(ctx, basefw, base_fw_size);
+	ret = ctx->cl_dev.ops.cl_copy_to_dmabuf(ctx, basefw, base_fw_size,
+								true);
 	if (ret < 0)
 		return ret;
 
@@ -323,22 +324,49 @@ static struct skl_module_table *skl_module_get_from_id(
 	return NULL;
 }
 
-static int skl_transfer_module(struct sst_dsp *ctx,
-			struct skl_load_module_info *module)
+static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
+				u32 size, u16 mod_id)
 {
-	int ret;
+	int ret, bytes_left, curr_pos;
 	struct skl_sst *skl = ctx->thread_context;
+	skl->mod_load_complete = false;
+	init_waitqueue_head(&skl->mod_load_wait);
 
-	ret = ctx->cl_dev.ops.cl_copy_to_dmabuf(ctx, module->fw->data,
-							module->fw->size);
-	if (ret < 0)
-		return ret;
+	bytes_left = ctx->cl_dev.ops.cl_copy_to_dmabuf(ctx, data, size, false);
+	if (bytes_left < 0)
+		return bytes_left;
 
-	ret = skl_ipc_load_modules(&skl->ipc, SKL_NUM_MODULES,
-						(void *)&module->mod_id);
-	if (ret < 0)
+	ret = skl_ipc_load_modules(&skl->ipc, SKL_NUM_MODULES, &mod_id);
+	if (ret < 0) {
 		dev_err(ctx->dev, "Failed to Load module: %d\n", ret);
+		goto out;
+	}
+
+	/*
+	 * if bytes_left > 0 then wait for BDL complete interrupt and
+	 * copy the next chunk till bytes_left is 0. if bytes_left is
+	 * is zero, then wait for load module IPC reply
+	 */
+	while (bytes_left > 0) {
+		curr_pos = size - bytes_left;
+
+		ret = skl_cldma_wait_interruptible(ctx);
+		if (ret < 0)
+			goto out;
+
+		bytes_left = ctx->cl_dev.ops.cl_copy_to_dmabuf(ctx,
+							data + curr_pos,
+							bytes_left, false);
+	}
+
+	ret = wait_event_timeout(skl->mod_load_wait, skl->mod_load_complete,
+				msecs_to_jiffies(SKL_IPC_BOOT_MSECS));
+	if (ret == 0 || !skl->mod_load_status) {
+		dev_err(ctx->dev, "Module Load failed\n");
+		ret = -EIO;
+	}
 
+out:
 	ctx->cl_dev.ops.cl_stop_dma(ctx);
 
 	return ret;
@@ -365,7 +393,8 @@ static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, u8 *guid)
 	}
 
 	if (!module_entry->usage_cnt) {
-		ret = skl_transfer_module(ctx, module_entry->mod_info);
+		ret = skl_transfer_module(ctx, module_entry->mod_info->fw->data,
+				module_entry->mod_info->fw->size, mod_id);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Failed to Load module\n");
 			return ret;
-- 
2.11.0
