From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: add code loader DMA
	operations" to the asoc tree
Date: Thu, 16 Jul 2015 22:01:18 +0100
Message-ID: <E1ZFqHO-0001gI-19@finisterre>
References: <1436546926-17263-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CFFFD2605D2
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:24 +0200 (CEST)
In-Reply-To: <1436546926-17263-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: add code loader DMA operations

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

>From 914426c8657c1e934b015ffa32e7bfd0cb34f47f Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 10 Jul 2015 22:18:41 +0530
Subject: [PATCH] ASoC: Intel: Skylake: add code loader DMA operations

This patch starts adding code loader DMA handling internal operations for
setting up bdle, controller, spb, cleanup routines and buffer filling

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 194 ++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-cldma.h |  60 ++++++++++
 2 files changed, 254 insertions(+)
 create mode 100644 sound/soc/intel/skylake/skl-sst-cldma.c

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
new file mode 100644
index 0000000..44019ee
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -0,0 +1,194 @@
+/*
+ * skl-sst-cldma.c - Code Loader DMA handler
+ *
+ * Copyright (C) 2015, Intel Corporation.
+ * Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/mm.h>
+#include <linux/kthread.h>
+#include "../common/sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
+
+static void skl_cldma_int_enable(struct sst_dsp *ctx)
+{
+	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPIC,
+				SKL_ADSPIC_CL_DMA, SKL_ADSPIC_CL_DMA);
+}
+
+void skl_cldma_int_disable(struct sst_dsp *ctx)
+{
+	sst_dsp_shim_update_bits_unlocked(ctx,
+			SKL_ADSP_REG_ADSPIC, SKL_ADSPIC_CL_DMA, 0);
+}
+
+/* Code loader helper APIs */
+static void skl_cldma_setup_bdle(struct sst_dsp *ctx,
+		struct snd_dma_buffer *dmab_data,
+		u32 **bdlp, int size, int with_ioc)
+{
+	u32 *bdl = *bdlp;
+
+	ctx->cl_dev.frags = 0;
+	while (size > 0) {
+		phys_addr_t addr = virt_to_phys(dmab_data->area +
+				(ctx->cl_dev.frags * ctx->cl_dev.bufsize));
+
+		bdl[0] = cpu_to_le32(lower_32_bits(addr));
+		bdl[1] = cpu_to_le32(upper_32_bits(addr));
+
+		bdl[2] = cpu_to_le32(ctx->cl_dev.bufsize);
+
+		size -= ctx->cl_dev.bufsize;
+		bdl[3] = (size || !with_ioc) ? 0 : cpu_to_le32(0x01);
+
+		bdl += 4;
+		ctx->cl_dev.frags++;
+	}
+}
+
+/*
+ * Setup controller
+ * Configure the registers to update the dma buffer address and
+ * enable interrupts.
+ * Note: Using the channel 1 for transfer
+ */
+static void skl_cldma_setup_controller(struct sst_dsp  *ctx,
+		struct snd_dma_buffer *dmab_bdl, unsigned int max_size,
+		u32 count)
+{
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPL,
+			CL_SD_BDLPLBA(dmab_bdl->addr));
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPU,
+			CL_SD_BDLPUBA(dmab_bdl->addr));
+
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_CBL, max_size);
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_LVI, count - 1);
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+			CL_SD_CTL_IOCE_MASK, CL_SD_CTL_IOCE(1));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+			CL_SD_CTL_FEIE_MASK, CL_SD_CTL_FEIE(1));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+			CL_SD_CTL_DEIE_MASK, CL_SD_CTL_DEIE(1));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+			CL_SD_CTL_STRM_MASK, CL_SD_CTL_STRM(FW_CL_STREAM_NUMBER));
+}
+
+static void skl_cldma_setup_spb(struct sst_dsp  *ctx,
+		unsigned int size, bool enable)
+{
+	if (enable)
+		sst_dsp_shim_update_bits_unlocked(ctx,
+				SKL_ADSP_REG_CL_SPBFIFO_SPBFCCTL,
+				CL_SPBFIFO_SPBFCCTL_SPIBE_MASK,
+				CL_SPBFIFO_SPBFCCTL_SPIBE(1));
+
+	sst_dsp_shim_write_unlocked(ctx, SKL_ADSP_REG_CL_SPBFIFO_SPIB, size);
+}
+
+static void skl_cldma_cleanup_spb(struct sst_dsp  *ctx)
+{
+	sst_dsp_shim_update_bits_unlocked(ctx,
+			SKL_ADSP_REG_CL_SPBFIFO_SPBFCCTL,
+			CL_SPBFIFO_SPBFCCTL_SPIBE_MASK,
+			CL_SPBFIFO_SPBFCCTL_SPIBE(0));
+
+	sst_dsp_shim_write_unlocked(ctx, SKL_ADSP_REG_CL_SPBFIFO_SPIB, 0);
+}
+
+static void skl_cldma_trigger(struct sst_dsp  *ctx, bool enable)
+{
+	if (enable)
+		sst_dsp_shim_update_bits_unlocked(ctx,
+			SKL_ADSP_REG_CL_SD_CTL,
+			CL_SD_CTL_RUN_MASK, CL_SD_CTL_RUN(1));
+	else
+		sst_dsp_shim_update_bits_unlocked(ctx,
+			SKL_ADSP_REG_CL_SD_CTL,
+			CL_SD_CTL_RUN_MASK, CL_SD_CTL_RUN(0));
+}
+
+static void skl_cldma_cleanup(struct sst_dsp  *ctx)
+{
+	skl_cldma_cleanup_spb(ctx);
+
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+				CL_SD_CTL_IOCE_MASK, CL_SD_CTL_IOCE(0));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+				CL_SD_CTL_FEIE_MASK, CL_SD_CTL_FEIE(0));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+				CL_SD_CTL_DEIE_MASK, CL_SD_CTL_DEIE(0));
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
+				CL_SD_CTL_STRM_MASK, CL_SD_CTL_STRM(0));
+
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPL, CL_SD_BDLPLBA(0));
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPU, 0);
+
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_CBL, 0);
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_LVI, 0);
+}
+
+static int skl_cldma_wait_interruptible(struct sst_dsp *ctx)
+{
+	int ret = 0;
+
+	if (!wait_event_timeout(ctx->cl_dev.wait_queue,
+				ctx->cl_dev.wait_condition,
+				msecs_to_jiffies(SKL_WAIT_TIMEOUT))) {
+		dev_err(ctx->dev, "%s: Wait timeout\n", __func__);
+		ret = -EIO;
+		goto cleanup;
+	}
+
+	dev_dbg(ctx->dev, "%s: Event wake\n", __func__);
+	if (ctx->cl_dev.wake_status != SKL_CL_DMA_BUF_COMPLETE) {
+		dev_err(ctx->dev, "%s: DMA Error\n", __func__);
+		ret = -EIO;
+	}
+
+cleanup:
+	ctx->cl_dev.wake_status = SKL_CL_DMA_STATUS_NONE;
+	return ret;
+}
+
+static void skl_cldma_stop(struct sst_dsp *ctx)
+{
+	ctx->cl_dev.ops.cl_trigger(ctx, false);
+}
+
+static void skl_cldma_fill_buffer(struct sst_dsp *ctx, unsigned int size,
+		const void *curr_pos, bool intr_enable, bool trigger)
+{
+	dev_dbg(ctx->dev, "Size: %x, intr_enable: %d\n", size, intr_enable);
+	dev_dbg(ctx->dev, "buf_pos_index:%d, trigger:%d\n",
+			ctx->cl_dev.dma_buffer_offset, trigger);
+	dev_dbg(ctx->dev, "spib position: %d\n", ctx->cl_dev.curr_spib_pos);
+
+	memcpy(ctx->cl_dev.dmab_data.area + ctx->cl_dev.dma_buffer_offset,
+			curr_pos, size);
+
+	if (ctx->cl_dev.curr_spib_pos == ctx->cl_dev.bufsize)
+		ctx->cl_dev.dma_buffer_offset = 0;
+	else
+		ctx->cl_dev.dma_buffer_offset = ctx->cl_dev.curr_spib_pos;
+
+	ctx->cl_dev.wait_condition = false;
+
+	if (intr_enable)
+		skl_cldma_int_enable(ctx);
+
+	ctx->cl_dev.ops.cl_setup_spb(ctx, ctx->cl_dev.curr_spib_pos, trigger);
+	if (trigger)
+		ctx->cl_dev.ops.cl_trigger(ctx, true);
+}
diff --git a/sound/soc/intel/skylake/skl-sst-cldma.h b/sound/soc/intel/skylake/skl-sst-cldma.h
index 34c366f..99e4c86 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.h
+++ b/sound/soc/intel/skylake/skl-sst-cldma.h
@@ -188,4 +188,64 @@
 #define CL_SPBFIFO_SPBFCCTL_SPIBE(x)	\
 	((x << CL_SPBFIFO_SPBFCCTL_SPIBE_SHIFT) & CL_SPBFIFO_SPBFCCTL_SPIBE_MASK)
 
+/* SST IPC SKL defines */
+#define SKL_WAIT_TIMEOUT		500	/* 500 msec */
+#define SKL_MAX_BUFFER_SIZE		(32 * PAGE_SIZE)
+
+enum skl_cl_dma_wake_states {
+	SKL_CL_DMA_STATUS_NONE = 0,
+	SKL_CL_DMA_BUF_COMPLETE,
+	SKL_CL_DMA_ERR,	/* TODO: Expand the error states */
+};
+
+struct sst_dsp;
+
+struct skl_cl_dev_ops {
+	void (*cl_setup_bdle)(struct sst_dsp *ctx,
+			struct snd_dma_buffer *dmab_data,
+			u32 **bdlp, int size, int with_ioc);
+	void (*cl_setup_controller)(struct sst_dsp *ctx,
+			struct snd_dma_buffer *dmab_bdl,
+			unsigned int max_size, u32 page_count);
+	void (*cl_setup_spb)(struct sst_dsp  *ctx,
+			unsigned int size, bool enable);
+	void (*cl_cleanup_spb)(struct sst_dsp  *ctx);
+	void (*cl_trigger)(struct sst_dsp  *ctx, bool enable);
+	void (*cl_cleanup_controller)(struct sst_dsp  *ctx);
+	int (*cl_copy_to_dmabuf)(struct sst_dsp *ctx,
+			const void *bin, u32 size);
+	void (*cl_stop_dma)(struct sst_dsp *ctx);
+};
+
+/**
+ * skl_cl_dev - holds information for code loader dma transfer
+ *
+ * @dmab_data: buffer pointer
+ * @dmab_bdl: buffer descriptor list
+ * @bufsize: ring buffer size
+ * @frags: Last valid buffer descriptor index in the BDL
+ * @curr_spib_pos: Current position in ring buffer
+ * @dma_buffer_offset: dma buffer offset
+ * @ops: operations supported on CL dma
+ * @wait_queue: wait queue to wake for wake event
+ * @wake_status: DMA wake status
+ * @wait_condition: condition to wait on wait queue
+ * @cl_dma_lock: for synchronized access to cldma
+ */
+struct skl_cl_dev {
+	struct snd_dma_buffer dmab_data;
+	struct snd_dma_buffer dmab_bdl;
+
+	unsigned int bufsize;
+	unsigned int frags;
+
+	unsigned int curr_spib_pos;
+	unsigned int dma_buffer_offset;
+	struct skl_cl_dev_ops ops;
+
+	wait_queue_head_t wait_queue;
+	int wake_status;
+	bool wait_condition;
+};
+
 #endif /* SKL_SST_CLDMA_H_ */
-- 
2.1.4
