From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 6/9] ASoC: hda: Add Code Loader DMA support
Date: Fri, 17 Apr 2015 18:46:04 +0530
Message-ID: <1429276567-29007-7-git-send-email-vinod.koul@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E344260578
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:28 +0200 (CEST)
In-Reply-To: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

For skylake the code loader dma will be used for fw download, module
download, and sending mailbox.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hda-sst-cldma.h       |  234 ++++++++++++++++++++++++
 include/sound/soc-hda-sst-dsp.h         |    9 +
 sound/soc/hda/intel/Makefile            |    2 +-
 sound/soc/hda/intel/soc-hda-sst-cldma.c |  297 +++++++++++++++++++++++++++++++
 4 files changed, 541 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/soc-hda-sst-cldma.h
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-cldma.c

diff --git a/include/sound/soc-hda-sst-cldma.h b/include/sound/soc-hda-sst-cldma.h
new file mode 100644
index 000000000000..a1e0c48ae5d5
--- /dev/null
+++ b/include/sound/soc-hda-sst-cldma.h
@@ -0,0 +1,234 @@
+/*
+ * Intel Code Loader DMA support
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
+#define FW_CL_STREAM_NUMBER	0xf
+
+#define DMA_ADDRESS_128_BITS_ALIGNMENT 7
+#define BDL_ALIGN(x)	(x >> DMA_ADDRESS_128_BITS_ALIGNMENT)
+
+#define ADSPIC_CL_DMA          0x2
+#define ADSPIS_CL_DMA          0x2
+#define CL_DMA_SD_INT_DESC_ERR		0x10	/* Descriptor error interrupt */
+#define CL_DMA_SD_INT_FIFO_ERR		0x08	/* FIFO error interrupt */
+#define CL_DMA_SD_INT_COMPLETE	0x04	/* Buffer completion interrupt */
+
+/* Code Loader -
+ * Stream Registers */
+#define HDA_ADSP_REG_CL_SD_CTL			(HDA_ADSP_LOADER_BASE + 0x00)
+#define HDA_ADSP_REG_CL_SD_STS			(HDA_ADSP_LOADER_BASE + 0x03)
+#define HDA_ADSP_REG_CL_SD_LPIB			(HDA_ADSP_LOADER_BASE + 0x04)
+#define HDA_ADSP_REG_CL_SD_CBL			(HDA_ADSP_LOADER_BASE + 0x08)
+#define HDA_ADSP_REG_CL_SD_LVI			(HDA_ADSP_LOADER_BASE + 0x0c)
+#define HDA_ADSP_REG_CL_SD_FIFOW		(HDA_ADSP_LOADER_BASE + 0x0e)
+#define HDA_ADSP_REG_CL_SD_FIFOSIZE		(HDA_ADSP_LOADER_BASE + 0x10)
+#define HDA_ADSP_REG_CL_SD_FORMAT		(HDA_ADSP_LOADER_BASE + 0x12)
+#define HDA_ADSP_REG_CL_SD_FIFOL		(HDA_ADSP_LOADER_BASE + 0x14)
+#define HDA_ADSP_REG_CL_SD_BDLPL		(HDA_ADSP_LOADER_BASE + 0x18)
+#define HDA_ADSP_REG_CL_SD_BDLPU		(HDA_ADSP_LOADER_BASE + 0x1c)
+
+/* Code Loader -
+ * Software Position Based FIFO Capability Registers */
+#define HDA_ADSP_REG_CL_SPBFIFO				(HDA_ADSP_LOADER_BASE + 0x20)
+#define HDA_ADSP_REG_CL_SPBFIFO_SPBFCH		(HDA_ADSP_REG_CL_SPBFIFO + 0x0)
+#define HDA_ADSP_REG_CL_SPBFIFO_SPBFCCTL	(HDA_ADSP_REG_CL_SPBFIFO + 0x4)
+#define HDA_ADSP_REG_CL_SPBFIFO_SPIB		(HDA_ADSP_REG_CL_SPBFIFO + 0x8)
+#define HDA_ADSP_REG_CL_SPBFIFO_MAXFIFOS	(HDA_ADSP_REG_CL_SPBFIFO + 0xc)
+
+
+/* Code Loader -
+ * Stream Descriptor x Control */
+/* Stream Reset */
+#define CL_SD_CTL_SRST_SHIFT	0
+#define CL_SD_CTL_SRST_MASK		(1 << CL_SD_CTL_SRST_SHIFT)
+#define CL_SD_CTL_SRST(x) \
+	((x << CL_SD_CTL_SRST_SHIFT) & CL_SD_CTL_SRST_MASK)
+
+/* Stream Run */
+#define CL_SD_CTL_RUN_SHIFT		1
+#define CL_SD_CTL_RUN_MASK		(1 << CL_SD_CTL_RUN_SHIFT)
+#define CL_SD_CTL_RUN(x) \
+	((x << CL_SD_CTL_RUN_SHIFT) & CL_SD_CTL_RUN_MASK)
+
+/* Interrupt On Completion Enable */
+#define CL_SD_CTL_IOCE_SHIFT	2
+#define CL_SD_CTL_IOCE_MASK		(1 << CL_SD_CTL_IOCE_SHIFT)
+#define CL_SD_CTL_IOCE(x) \
+	((x << CL_SD_CTL_IOCE_SHIFT) & CL_SD_CTL_IOCE_MASK)
+
+/* FIFO Error Interrupt Enable */
+#define CL_SD_CTL_FEIE_SHIFT	3
+#define CL_SD_CTL_FEIE_MASK		(1 << CL_SD_CTL_FEIE_SHIFT)
+#define CL_SD_CTL_FEIE(x) \
+	((x << CL_SD_CTL_FEIE_SHIFT) & CL_SD_CTL_FEIE_MASK)
+
+/* Descriptor Error Interrupt Enable */
+#define CL_SD_CTL_DEIE_SHIFT	4
+#define CL_SD_CTL_DEIE_MASK		(1 << CL_SD_CTL_DEIE_SHIFT)
+#define CL_SD_CTL_DEIE(x) \
+	((x << CL_SD_CTL_DEIE_SHIFT) & CL_SD_CTL_DEIE_MASK)
+
+/* FIFO Limit Change */
+#define CL_SD_CTL_FIFOLC_SHIFT	5
+#define CL_SD_CTL_FIFOLC_MASK	(1 << CL_SD_CTL_FIFOLC_SHIFT)
+#define CL_SD_CTL_FIFOLC(x) \
+	((x << CL_SD_CTL_FIFOLC_SHIFT) & CL_SD_CTL_FIFOLC_MASK)
+
+/* Stripe Control */
+#define CL_SD_CTL_STRIPE_SHIFT	16
+#define CL_SD_CTL_STRIPE_MASK	(0x3 << CL_SD_CTL_STRIPE_SHIFT)
+#define CL_SD_CTL_STRIPE(x) \
+	((x << CL_SD_CTL_STRIPE_SHIFT) & CL_SD_CTL_STRIPE_MASK)
+
+/* Traffic Priority */
+#define CL_SD_CTL_TP_SHIFT		18
+#define CL_SD_CTL_TP_MASK		(1 << CL_SD_CTL_TP_SHIFT)
+#define CL_SD_CTL_TP(x) \
+	((x << CL_SD_CTL_TP_SHIFT) & CL_SD_CTL_TP_MASK)
+
+/* Bidirectional Direction Control */
+#define CL_SD_CTL_DIR_SHIFT		19
+#define CL_SD_CTL_DIR_MASK		(1 << CL_SD_CTL_DIR_SHIFT)
+#define CL_SD_CTL_DIR(x) \
+	((x << CL_SD_CTL_DIR_SHIFT) & CL_SD_CTL_DIR_MASK)
+
+/* Stream Number */
+#define CL_SD_CTL_STRM_SHIFT	20
+#define CL_SD_CTL_STRM_MASK		(0xf << CL_SD_CTL_STRM_SHIFT)
+#define CL_SD_CTL_STRM(x) \
+	((x << CL_SD_CTL_STRM_SHIFT) & CL_SD_CTL_STRM_MASK)
+
+
+/* Code Loader -
+ * Stream Descriptor x Status */
+/* Buffer Completion Interrupt Status */
+#define CL_SD_STS_BCIS(x)		CL_SD_CTL_IOCE(x)
+
+/* FIFO Error */
+#define CL_SD_STS_FIFOE(x)		CL_SD_CTL_FEIE(x)
+
+/* Descriptor Error */
+#define CL_SD_STS_DESE(x)		CL_SD_CTL_DEIE(x)
+
+/* FIFO Ready */
+#define CL_SD_STS_FIFORDY(x)	CL_SD_CTL_FIFOLC(x)
+
+
+/* Code Loader -
+ * Stream Descriptor x Last Valid Index */
+#define CL_SD_LVI_SHIFT		0
+#define CL_SD_LVI_MASK		(0xff << CL_SD_LVI_SHIFT)
+#define CL_SD_LVI(x)		((x << CL_SD_LVI_SHIFT) & CL_SD_LVI_MASK)
+
+
+/* Code Loader -
+ * Stream Descriptor x FIFO Eviction Watermark */
+#define CL_SD_FIFOW_SHIFT	0
+#define CL_SD_FIFOW_MASK	(0x7 << CL_SD_FIFOW_SHIFT)
+#define CL_SD_FIFOW(x)		((x << CL_SD_FIFOW_SHIFT) & CL_SD_FIFOW_MASK)
+
+
+/* Code Loader -
+ * Stream Descriptor x Buffer Descriptor List Pointer Lower Base Address */
+/* Protect */
+#define CL_SD_BDLPLBA_PROT_SHIFT	0
+#define CL_SD_BDLPLBA_PROT_MASK		(1 << CL_SD_BDLPLBA_PROT_SHIFT)
+#define CL_SD_BDLPLBA_PROT(x) \
+	((x << CL_SD_BDLPLBA_PROT_SHIFT) & CL_SD_BDLPLBA_PROT_MASK)
+
+/* Buffer Descriptor List Lower Base Address */
+#define CL_SD_BDLPLBA_SHIFT	7
+#define CL_SD_BDLPLBA_MASK	(0x1ffffff << CL_SD_BDLPLBA_SHIFT)
+#define CL_SD_BDLPLBA(x) \
+	((BDL_ALIGN(lower_32_bits(x)) << CL_SD_BDLPLBA_SHIFT) & CL_SD_BDLPLBA_MASK)
+
+/* Buffer Descriptor List Upper Base Address */
+#define CL_SD_BDLPUBA_SHIFT	0
+#define CL_SD_BDLPUBA_MASK	(0xffffffff << CL_SD_BDLPUBA_SHIFT)
+#define CL_SD_BDLPUBA(x) \
+	((upper_32_bits(x) << CL_SD_BDLPUBA_SHIFT) & CL_SD_BDLPUBA_MASK)
+
+/* Code Loader - Software Position Based FIFO
+ * Capability Registers x Software Position Based FIFO Header */
+
+/* Next Capability Pointer */
+#define CL_SPBFIFO_SPBFCH_PTR_SHIFT	0
+#define CL_SPBFIFO_SPBFCH_PTR_MASK	(0xff << CL_SPBFIFO_SPBFCH_PTR_SHIFT)
+#define CL_SPBFIFO_SPBFCH_PTR(x) \
+	((x << CL_SPBFIFO_SPBFCH_PTR_SHIFT) & CL_SPBFIFO_SPBFCH_PTR_MASK)
+
+/* Capability Identifier */
+#define CL_SPBFIFO_SPBFCH_ID_SHIFT	16
+#define CL_SPBFIFO_SPBFCH_ID_MASK	(0xfff << CL_SPBFIFO_SPBFCH_ID_SHIFT)
+#define CL_SPBFIFO_SPBFCH_ID(x) \
+	((x << CL_SPBFIFO_SPBFCH_ID_SHIFT) & CL_SPBFIFO_SPBFCH_ID_MASK)
+
+/* Capability Version */
+#define CL_SPBFIFO_SPBFCH_VER_SHIFT	28
+#define CL_SPBFIFO_SPBFCH_VER_MASK	(0xf << CL_SPBFIFO_SPBFCH_VER_SHIFT)
+#define CL_SPBFIFO_SPBFCH_VER(x) \
+	((x << CL_SPBFIFO_SPBFCH_VER_SHIFT) & CL_SPBFIFO_SPBFCH_VER_MASK)
+
+
+/* Code Loader -
+   Software Position Based FIFO Control */
+/* Software Position in Buffer Enable */
+#define CL_SPBFIFO_SPBFCCTL_SPIBE_SHIFT	0
+#define CL_SPBFIFO_SPBFCCTL_SPIBE_MASK	(1 << CL_SPBFIFO_SPBFCCTL_SPIBE_SHIFT)
+#define CL_SPBFIFO_SPBFCCTL_SPIBE(x) \
+	((x << CL_SPBFIFO_SPBFCCTL_SPIBE_SHIFT) & CL_SPBFIFO_SPBFCCTL_SPIBE_MASK)
+
+#define SSTH_WAIT_TIMEOUT		1000	/* 1 sec */
+#define SSTH_MAX_BUFFER_SIZE		(4 * PAGE_SIZE)
+
+enum ssth_cl_dma_wake_states {
+	SSTH_CL_DMA_STATUS_NONE = 0,
+	SSTH_CL_DMA_BUF_COMPLETE,
+	SSTH_CL_DMA_ERR,	/* TODO: Expand the error states */
+};
+
+struct ssth_lib;
+struct ssth_cl_dev_ops {
+	void (*cl_setup_bdle)(struct snd_dma_buffer *dmab_data,
+			u32 **bdlp, u32 page_count);
+	void (*cl_setup_controller)(struct ssth_lib *ctx,
+			struct snd_dma_buffer *dmab_bdl,
+			unsigned int max_size, u32 page_count);
+	void (*cl_setup_spb)(struct ssth_lib  *ctx, unsigned int size);
+	void (*cl_cleanup_spb)(struct ssth_lib  *ctx);
+	void (*cl_trigger)(struct ssth_lib  *ctx, bool enable);
+	void (*cl_cleaup_controller)(struct ssth_lib  *ctx);
+	int (*cl_copy_to_bdl)(struct ssth_lib *ctx, const void *bin, u32 size);
+};
+
+/* Code loader device */
+struct ssth_cl_dev {
+	/* TODO: Add for synchroinization mechanism */
+	struct snd_dma_buffer dmab_data;
+	struct snd_dma_buffer dmab_bdl;
+
+	unsigned int bufsize;		/* Ring buffer size = period_count * period_size */
+	unsigned int period_count;
+	unsigned int period_size;
+	u32 *curr_pos;			/* Current possition in the blob to transferred */
+	unsigned int bytes_left;	/* Bytes left to be transferred */
+	unsigned int curr_spib_pos;	/* Current position in ring buffer */
+	bool cl_ops;
+	struct ssth_cl_dev_ops ops;
+
+	wait_queue_head_t wait_queue;
+	int wake_status;
+	bool wait_condition;
+};
diff --git a/include/sound/soc-hda-sst-dsp.h b/include/sound/soc-hda-sst-dsp.h
index 3d8b0c065002..82ba1c9a68c4 100644
--- a/include/sound/soc-hda-sst-dsp.h
+++ b/include/sound/soc-hda-sst-dsp.h
@@ -19,6 +19,7 @@
 
 #include <linux/spinlock.h>
 #include <sound/memalloc.h>
+#include <sound/soc-hda-sst-cldma.h>
 
 #define ssth_writel_andor(ctx, reg, mask_and, mask_or) \
 	ssth_writel_traced( \
@@ -101,6 +102,12 @@
 #define ADSPIC_IPC                      1
 #define ADSPIS_IPC			1
 
+#define ADSPIC_CL_DMA          0x2
+#define ADSPIS_CL_DMA          0x2
+#define CL_DMA_SD_INT_DESC_ERR		0x10	/* Descriptor error interrupt */
+#define CL_DMA_SD_INT_FIFO_ERR		0x08	/* FIFO error interrupt */
+#define CL_DMA_SD_INT_COMPLETE	0x04	/* Buffer completion interrupt */
+
 /* ADSPCS - Audio DSP Control & Status */
 #define DSP_CORES 1
 #define DSP_CORE0_MASK 1
@@ -168,6 +175,8 @@ struct ssth_lib {
 
 	struct workqueue_struct *intr_wq;
 	struct work_struct ipc_process_msg_work;
+	struct ssth_cl_dev cl_dev;
+	struct work_struct cl_dma_process_work;
 };
 
 enum ssth_states {
diff --git a/sound/soc/hda/intel/Makefile b/sound/soc/hda/intel/Makefile
index 77c44428f40d..a31db94b2dde 100644
--- a/sound/soc/hda/intel/Makefile
+++ b/sound/soc/hda/intel/Makefile
@@ -1,5 +1,5 @@
 
-snd-soc-hda-sst-dsp-objs := soc-hda-sst-ipc.o soc-hda-sst-dsp.o
+snd-soc-hda-sst-dsp-objs := soc-hda-sst-ipc.o soc-hda-sst-dsp.o soc-hda-sst-cldma.o
 
 # SST DSP Library
 obj-$(CONFIG_SND_SOC_HDA_SST_DSP) += snd-soc-hda-sst-dsp.o
diff --git a/sound/soc/hda/intel/soc-hda-sst-cldma.c b/sound/soc/hda/intel/soc-hda-sst-cldma.c
new file mode 100644
index 000000000000..0222ca9f6fdc
--- /dev/null
+++ b/sound/soc/hda/intel/soc-hda-sst-cldma.c
@@ -0,0 +1,297 @@
+/*
+ *  soc-hda-sst-cldma.c - Code Loader DMA handler
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/kthread.h>
+#include <linux/irqreturn.h>
+#include <sound/soc-hda-sst-dsp.h>
+
+void ssth_cldma_int_enable(struct ssth_lib *ctx)
+{
+	ssth_updatel_bits(ctx, HDA_ADSP_REG_ADSPIC,
+			ADSPIC_CL_DMA, 0x2);
+}
+void ssth_cldma_int_disable(struct ssth_lib *ctx)
+{
+	ssth_updatel_bits(ctx, HDA_ADSP_REG_ADSPIC,
+			ADSPIC_CL_DMA, 0);
+}
+
+/* Code loader helper APIs */
+static void ssth_skl_cl_setup_bdle(struct snd_dma_buffer *dmab_data,
+		u32 **bdlp, u32 count)
+{
+	u32 *bdl = *bdlp;
+	int i = 0;
+
+	for (i = 0; i < count; i++) {
+		phys_addr_t addr = virt_to_phys(dmab_data->area + i * PAGE_SIZE);
+
+		bdl[0] = cpu_to_le32(lower_32_bits(addr));
+		bdl[1] = cpu_to_le32(upper_32_bits(addr));
+		bdl[2] = cpu_to_le32(PAGE_SIZE);
+		bdl[3] = 0;
+		bdl += 4;
+	}
+}
+
+/* Setup controller*/
+static void ssth_skl_cl_setup_controller(struct ssth_lib  *ctx,
+		struct snd_dma_buffer *dmab_bdl, unsigned int max_size,
+		u32 count)
+{
+	ssth_writel(ctx, CL_SD_BDLPL, CL_SD_BDLPLBA(dmab_bdl->addr));
+	ssth_writel(ctx, CL_SD_BDLPU, CL_SD_BDLPUBA(dmab_bdl->addr));
+
+	ssth_writel(ctx, CL_SD_CBL, max_size);
+	ssth_writel(ctx, CL_SD_LVI, count - 1);
+	ssth_updatel(ctx, CL_SD_CTL, IOCE_MASK, CL_SD_CTL_IOCE(1));
+	ssth_updatel(ctx, CL_SD_CTL, FEIE_MASK, CL_SD_CTL_FEIE(1));
+	ssth_updatel(ctx, CL_SD_CTL, DEIE_MASK, CL_SD_CTL_DEIE(1));
+	ssth_updatel(ctx, CL_SD_CTL, STRM_MASK,
+					CL_SD_CTL_STRM(FW_CL_STREAM_NUMBER));
+}
+
+static void ssth_skl_setup_spb(struct ssth_lib  *ctx, unsigned int size)
+{
+	ssth_updatel(ctx, CL_SPBFIFO_SPBFCCTL,
+			SPIBE_MASK, CL_SPBFIFO_SPBFCCTL_SPIBE(1));
+	ssth_writel(ctx, CL_SPBFIFO_SPIB, size);
+}
+
+static void ssth_skl_cleanup_spb(struct ssth_lib  *ctx)
+{
+	ssth_updatel(ctx, CL_SPBFIFO_SPBFCCTL,
+			SPIBE_MASK,  CL_SPBFIFO_SPBFCCTL_SPIBE(0));
+	ssth_writel(ctx, CL_SPBFIFO_SPIB, 0);
+}
+
+static void ssth_skl_cl_trigger(struct ssth_lib  *ctx, bool enable)
+{
+	if (enable)
+		ssth_updatel(ctx, CL_SD_CTL, RUN_MASK, CL_SD_CTL_RUN(1));
+	else
+		ssth_updatel(ctx, CL_SD_CTL, RUN_MASK, CL_SD_CTL_RUN(0));
+}
+
+static void ssth_skl_cl_cleaup(struct ssth_lib  *ctx)
+{
+	ssth_updatel(ctx, CL_SD_CTL, IOCE_MASK, CL_SD_CTL_IOCE(0));
+	ssth_updatel(ctx, CL_SD_CTL, FEIE_MASK, CL_SD_CTL_FEIE(0));
+	ssth_updatel(ctx, CL_SD_CTL, DEIE_MASK, CL_SD_CTL_DEIE(0));
+	ssth_updatel(ctx, CL_SD_CTL, STRM_MASK, CL_SD_CTL_STRM(0));
+
+	ssth_writel(ctx, CL_SD_BDLPL, CL_SD_BDLPLBA(0));
+	ssth_writel(ctx, CL_SD_BDLPU, 0);
+
+	ssth_writel(ctx, CL_SD_CBL, 0);
+	ssth_writel(ctx, CL_SD_LVI, 0);
+}
+
+int ssth_cl_dma_fill_buffer(struct ssth_lib *ctx, unsigned int size,
+		bool wait, bool int_enable, int buf_pos_index,
+		bool update_pos, bool trigger)
+{
+	unsigned int link_pos = 0;
+
+	memcpy((ctx->cl_dev.dmab_data.area + (buf_pos_index * ctx->cl_dev.period_size)),
+			ctx->cl_dev.curr_pos, size);
+
+	if (update_pos) {
+		ctx->cl_dev.bytes_left = ctx->cl_dev.bytes_left - size;
+		ctx->cl_dev.curr_pos = ctx->cl_dev.curr_pos + size;
+	}
+
+	if (wait) {
+		ctx->cl_dev.wait_condition = false;
+		ssth_cldma_int_enable(ctx);
+	}
+
+	ctx->cl_dev.ops.cl_setup_spb(ctx, ctx->cl_dev.curr_spib_pos);
+	if (trigger)
+		ctx->cl_dev.ops.cl_trigger(ctx, true);
+
+	if (wait) {
+		if (wait_event_timeout(ctx->cl_dev.wait_queue,
+				ctx->cl_dev.wait_condition,
+				msecs_to_jiffies(SSTH_WAIT_TIMEOUT))) {
+			dev_dbg(ctx->dev, "%s: Event wake\n", __func__);
+			if (ctx->cl_dev.wake_status == SSTH_CL_DMA_BUF_COMPLETE) {
+				ctx->cl_dev.wake_status = SSTH_CL_DMA_STATUS_NONE;
+				return 0;
+			} else {
+				dev_err(ctx->dev, "%s: DMA Error\n", __func__);
+				/* TODO: Handle DMA error scenario */
+				return -EIO;
+			}
+		} else  {
+			link_pos = ssth_readl(ctx, CL_SD_LPIB);
+			dev_err(ctx->dev, "%s: Wait timeout with lpib status: %u\n",
+					__func__, link_pos);
+
+			/* TODO: Handle wait timeout error scenario */
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int ssth_cl_copy_to_bdl(struct ssth_lib *ctx, const void *bin, u32 size)
+{
+	unsigned int link_pos = 0;
+	unsigned int bdl_index = 0;
+	int ret = 0;
+
+	if (size <= 0)
+		return -EINVAL;
+
+	ctx->cl_dev.bytes_left = size;
+	ctx->cl_dev.curr_pos = (u32 *)bin;
+	ctx->cl_dev.curr_spib_pos = 0;
+
+	if (ctx->cl_dev.bytes_left <= ctx->cl_dev.bufsize &&
+			ctx->cl_dev.bytes_left > ctx->cl_dev.period_size) {
+
+		dev_dbg(ctx->dev, "%s: size less than buffer size: %u\n",
+			       __func__, ctx->cl_dev.bytes_left);
+		ssth_cldma_int_disable(ctx);
+		ctx->cl_dev.curr_spib_pos = ctx->cl_dev.bytes_left;
+		ssth_cl_dma_fill_buffer(ctx, size, false, false, 0, false, true);
+		do {
+			mdelay(5);
+			link_pos = ssth_readl(ctx, CL_SD_LPIB);
+		} while (link_pos < size);
+		goto cleanup;
+	}
+
+	dev_dbg(ctx->dev, "%s: Total binary size: %u\n",
+			       __func__, ctx->cl_dev.bytes_left);
+	ctx->cl_dev.curr_spib_pos =
+			ctx->cl_dev.curr_spib_pos + ctx->cl_dev.bufsize;
+	dev_dbg(ctx->dev, "%s: spib pos: %u\n", __func__, ctx->cl_dev.curr_spib_pos);
+	ret = ssth_cl_dma_fill_buffer(ctx, ctx->cl_dev.bufsize, true,
+					true, 0, true, true);
+	if (ret < 0)
+		goto cleanup;
+
+	do {
+		if (ctx->cl_dev.bytes_left > ctx->cl_dev.period_size) {
+			ctx->cl_dev.curr_spib_pos =
+				ctx->cl_dev.curr_spib_pos + ctx->cl_dev.period_size;
+			bdl_index = (ctx->cl_dev.curr_spib_pos / ctx->cl_dev.period_size) - 1;
+			ret = ssth_cl_dma_fill_buffer(ctx, ctx->cl_dev.period_size, true,
+					true, bdl_index, true, false);
+			if (ret < 0)
+				goto cleanup;
+		} else {
+			ctx->cl_dev.curr_spib_pos =
+				ctx->cl_dev.curr_spib_pos + ctx->cl_dev.bufsize;
+			bdl_index = ctx->cl_dev.curr_spib_pos / ctx->cl_dev.period_size;
+			ssth_cl_dma_fill_buffer(ctx, ctx->cl_dev.bytes_left,
+					false, false, bdl_index, false, false);
+			do {
+				mdelay(5);
+				link_pos = ssth_readl(ctx, CL_SD_LPIB);
+			} while (link_pos < size);
+		}
+	} while (ctx->cl_dev.bytes_left > 0);
+
+cleanup:
+	ctx->cl_dev.ops.cl_trigger(ctx, false);
+	ctx->cl_dev.ops.cl_cleanup_spb(ctx);
+
+	return ret;
+}
+void ssth_process_cl_dma(struct work_struct *work)
+{
+	u8 cl_dma_intr_status;
+	struct ssth_lib *ctx = container_of(work,
+			struct ssth_lib, cl_dma_process_work);
+
+	cl_dma_intr_status = ssth_readb(ctx, CL_SD_STS);
+
+	if (!(cl_dma_intr_status & CL_DMA_SD_INT_COMPLETE)) {
+		/* TODO: Handle error scenarios */
+	} else {
+		ctx->cl_dev.wake_status = SSTH_CL_DMA_BUF_COMPLETE;
+		ctx->cl_dev.wait_condition = true;
+		wake_up(&ctx->cl_dev.wait_queue);
+	}
+}
+
+int ssth_cl_dma_prepare(struct ssth_lib *ctx)
+{
+	int ret = 0;
+	u32 *bdl;
+
+	ctx->cl_dev.period_size = PAGE_SIZE;
+	ctx->cl_dev.bufsize = SSTH_MAX_BUFFER_SIZE;
+
+	ctx->cl_dev.period_count =
+		(ctx->cl_dev.bufsize/ctx->cl_dev.period_size);
+
+	/* Make sure buffer size is mutliple of period size */
+	if (ctx->cl_dev.bufsize % ctx->cl_dev.period_size) {
+		dev_err(ctx->dev, "Buffer size is not mutltiple of Period size\n");
+		return -EINVAL;
+	}
+	dev_dbg(ctx->dev, "%s: buffer size: %u\n", __func__, ctx->cl_dev.bufsize);
+	dev_dbg(ctx->dev, "%s: period count: %u\n", __func__, ctx->cl_dev.period_count);
+
+	/* Allocate cl ops */
+	ctx->cl_dev.cl_ops = true,
+	ctx->cl_dev.ops.cl_setup_bdle = ssth_skl_cl_setup_bdle,
+	ctx->cl_dev.ops.cl_setup_controller = ssth_skl_cl_setup_controller,
+	ctx->cl_dev.ops.cl_setup_spb = ssth_skl_setup_spb,
+	ctx->cl_dev.ops.cl_cleanup_spb = ssth_skl_cleanup_spb,
+	ctx->cl_dev.ops.cl_trigger = ssth_skl_cl_trigger,
+	ctx->cl_dev.ops.cl_cleaup_controller = ssth_skl_cl_cleaup,
+	ctx->cl_dev.ops.cl_copy_to_bdl = ssth_cl_copy_to_bdl,
+
+	/* Allocate buffer*/
+	ret = ctx->dsp_ops.alloc_dma_buf(ctx->dev,
+			&ctx->cl_dev.dmab_data, ctx->cl_dev.bufsize);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Alloc buffer for base fw failed: %x", ret);
+		return ret;
+	}
+	/* Setup CL DMA ring buffer */
+	/* Allocate bdl */
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
+	ctx->cl_dev.ops.cl_setup_bdle(&ctx->cl_dev.dmab_data,
+			&bdl, ctx->cl_dev.period_count);
+	ctx->cl_dev.ops.cl_setup_controller(ctx, &ctx->cl_dev.dmab_bdl,
+			ctx->cl_dev.bufsize, ctx->cl_dev.period_count);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ssth_cl_dma_prepare);
-- 
1.7.9.5
