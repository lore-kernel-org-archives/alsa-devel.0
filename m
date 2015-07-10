From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/7] ASoC: Intel: Skylake: Add code loader DMA
	APIs
Date: Fri, 10 Jul 2015 22:18:42 +0530
Message-ID: <1436546926-17263-5-git-send-email-vinod.koul@intel.com>
References: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CFE826663D
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 18:47:09 +0200 (CEST)
In-Reply-To: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the last piece of code loader DMA APIs by adding the code
loader DMA APIs for the driver to use

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h   |   3 +
 sound/soc/intel/skylake/Makefile        |   2 +-
 sound/soc/intel/skylake/skl-sst-cldma.c | 133 ++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h   |   6 ++
 4 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index dd79648dfb3a..cbd568eac033 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -308,8 +308,11 @@ struct sst_dsp {
 
 	/* SKL data */
 
+	/* To allocate CL dma buffers */
+	struct skl_dsp_loader_ops dsp_ops;
 	struct skl_dsp_fw_ops fw_ops;
 	int sst_state;
+	struct skl_cl_dev cl_dev;
 	u32 intr_status;
 };
 
diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
index 10c1319f7ed5..eff3e1758b89 100644
--- a/sound/soc/intel/skylake/Makefile
+++ b/sound/soc/intel/skylake/Makefile
@@ -3,6 +3,6 @@ snd-soc-skl-objs := skl.o skl-pcm.o
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
 
 # Skylake IPC Support
-snd-soc-skl-ipc-objs := skl-sst-ipc.o skl-sst-dsp.o
+snd-soc-skl-ipc-objs := skl-sst-ipc.o skl-sst-dsp.o skl-sst-cldma.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl-ipc.o
diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index 44019eef6114..44748ba98da2 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -192,3 +192,136 @@ static void skl_cldma_fill_buffer(struct sst_dsp *ctx, unsigned int size,
 	if (trigger)
 		ctx->cl_dev.ops.cl_trigger(ctx, true);
 }
+
+/*
+ * The CL dma doesn't have any way to update the transfer status until a BDL
+ * buffer is fully transferred
+ *
+ * So Copying is divided in two parts.
+ * 1. Interrupt on buffer done where the size to be transferred is more than
+ *    ring buffer size.
+ * 2. Polling on fw register to identify if data left to transferred doesn't
+ *    fill the ring buffer. Caller takes care of polling the required status
+ *    register to identify the transfer status.
+ */
+static int
+skl_cldma_copy_to_buf(struct sst_dsp *ctx, const void *bin, u32 total_size)
+{
+	int ret = 0;
+	bool start = true;
+	unsigned int excess_bytes;
+	u32 size;
+	unsigned int bytes_left = total_size;
+	const void *curr_pos = bin;
+
+	if (total_size <= 0)
+		return -EINVAL;
+
+	dev_dbg(ctx->dev, "%s: Total binary size: %u\n", __func__, bytes_left);
+
+	while (bytes_left) {
+		if (bytes_left > ctx->cl_dev.bufsize) {
+
+			/*
+			 * dma transfers only till the write pointer as
+			 * updated in spib
+			 */
+			if (ctx->cl_dev.curr_spib_pos == 0)
+				ctx->cl_dev.curr_spib_pos = ctx->cl_dev.bufsize;
+
+			size = ctx->cl_dev.bufsize;
+			skl_cldma_fill_buffer(ctx, size, curr_pos, true, start);
+
+			start = false;
+			ret = skl_cldma_wait_interruptible(ctx);
+			if (ret < 0) {
+				skl_cldma_stop(ctx);
+				return ret;
+			}
+
+		} else {
+			skl_cldma_int_disable(ctx);
+
+			if ((ctx->cl_dev.curr_spib_pos + bytes_left)
+							<= ctx->cl_dev.bufsize) {
+				ctx->cl_dev.curr_spib_pos += bytes_left;
+			} else {
+				excess_bytes = bytes_left -
+					(ctx->cl_dev.bufsize -
+					ctx->cl_dev.curr_spib_pos);
+				ctx->cl_dev.curr_spib_pos = excess_bytes;
+			}
+
+			size = bytes_left;
+			skl_cldma_fill_buffer(ctx, size,
+					curr_pos, false, start);
+		}
+		bytes_left -= size;
+		curr_pos = curr_pos + size;
+	}
+
+	return ret;
+}
+
+void skl_cldma_process_intr(struct sst_dsp *ctx)
+{
+	u8 cl_dma_intr_status;
+
+	cl_dma_intr_status =
+		sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_CL_SD_STS);
+
+	if (!(cl_dma_intr_status & SKL_CL_DMA_SD_INT_COMPLETE))
+		ctx->cl_dev.wake_status = SKL_CL_DMA_ERR;
+	else
+		ctx->cl_dev.wake_status = SKL_CL_DMA_BUF_COMPLETE;
+
+	ctx->cl_dev.wait_condition = true;
+	wake_up(&ctx->cl_dev.wait_queue);
+}
+
+int skl_cldma_prepare(struct sst_dsp *ctx)
+{
+	int ret;
+	u32 *bdl;
+
+	ctx->cl_dev.bufsize = SKL_MAX_BUFFER_SIZE;
+
+	/* Allocate cl ops */
+	ctx->cl_dev.ops.cl_setup_bdle = skl_cldma_setup_bdle;
+	ctx->cl_dev.ops.cl_setup_controller = skl_cldma_setup_controller;
+	ctx->cl_dev.ops.cl_setup_spb = skl_cldma_setup_spb;
+	ctx->cl_dev.ops.cl_cleanup_spb = skl_cldma_cleanup_spb;
+	ctx->cl_dev.ops.cl_trigger = skl_cldma_trigger;
+	ctx->cl_dev.ops.cl_cleanup_controller = skl_cldma_cleanup;
+	ctx->cl_dev.ops.cl_copy_to_dmabuf = skl_cldma_copy_to_buf;
+	ctx->cl_dev.ops.cl_stop_dma = skl_cldma_stop;
+
+	/* Allocate buffer*/
+	ret = ctx->dsp_ops.alloc_dma_buf(ctx->dev,
+			&ctx->cl_dev.dmab_data, ctx->cl_dev.bufsize);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Alloc buffer for base fw failed: %x", ret);
+		return ret;
+	}
+	/* Setup Code loader BDL */
+	ret = ctx->dsp_ops.alloc_dma_buf(ctx->dev,
+			&ctx->cl_dev.dmab_bdl, PAGE_SIZE);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Alloc buffer for blde failed: %x", ret);
+		ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
+		return ret;
+	}
+	bdl = (u32 *)ctx->cl_dev.dmab_bdl.area;
+
+	/* Allocate BDLs */
+	ctx->cl_dev.ops.cl_setup_bdle(ctx, &ctx->cl_dev.dmab_data,
+			&bdl, ctx->cl_dev.bufsize, 1);
+	ctx->cl_dev.ops.cl_setup_controller(ctx, &ctx->cl_dev.dmab_bdl,
+			ctx->cl_dev.bufsize, ctx->cl_dev.frags);
+
+	ctx->cl_dev.curr_spib_pos = 0;
+	ctx->cl_dev.dma_buffer_offset = 0;
+	init_waitqueue_head(&ctx->cl_dev.wait_queue);
+
+	return ret;
+}
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index c2d28781309a..e8ce1364bf7b 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -17,7 +17,9 @@
 #define __SKL_SST_DSP_H__
 
 #include <sound/memalloc.h>
+#include "skl-sst-cldma.h"
 
+struct sst_dsp;
 struct sst_dsp_device;
 
 /* Intel HD Audio General DSP Registers */
@@ -113,6 +115,10 @@ struct skl_dsp_loader_ops {
 		struct snd_dma_buffer *dmab);
 };
 
+void skl_cldma_process_intr(struct sst_dsp *ctx);
+void skl_cldma_int_disable(struct sst_dsp *ctx);
+int skl_cldma_prepare(struct sst_dsp *ctx);
+
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 		struct sst_dsp_device *sst_dev, int irq);
-- 
1.9.1
