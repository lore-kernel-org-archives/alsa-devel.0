From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 1/9] ASoC: hda: Add helper to read/write to dsp
	mmio space
Date: Fri, 17 Apr 2015 18:45:59 +0530
Message-ID: <1429276567-29007-2-git-send-email-vinod.koul@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 03069260587
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:14 +0200 (CEST)
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

Adding some helper APIs which will be used in the DSP driver and ipc library
to read mmio.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hda-sst-dsp.h       |  169 +++++++++++++++++++++++++++++++++
 sound/soc/hda/intel/soc-hda-sst-dsp.c |  139 +++++++++++++++++++++++++++
 2 files changed, 308 insertions(+)
 create mode 100644 include/sound/soc-hda-sst-dsp.h
 create mode 100644 sound/soc/hda/intel/soc-hda-sst-dsp.c

diff --git a/include/sound/soc-hda-sst-dsp.h b/include/sound/soc-hda-sst-dsp.h
new file mode 100644
index 000000000000..daeee1840b94
--- /dev/null
+++ b/include/sound/soc-hda-sst-dsp.h
@@ -0,0 +1,169 @@
+/*
+ *  Intel SST DSP Support
+ *
+ * Copyright (C) 2014-15, Intel Corporation. All rights reserved.
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
+#ifndef __HDA_SST_DSP_H__
+#define __HDA_SST_DSP_H__
+
+#include <linux/spinlock.h>
+#include <sound/memalloc.h>
+
+#define ssth_writel_andor(ctx, reg, mask_and, mask_or) \
+	ssth_writel_traced( \
+	ctx, \
+	reg, \
+	(ssth_readl_traced(ctx, (reg)) & (mask_and) | (mask_or)))
+
+#define ssth_readb(ctx, reg) \
+	ssth_readb_traced(ctx, HDA_ADSP_REG_##reg)
+#define ssth_readw(ctx, reg) \
+	ssth_readw_traced(ctx, HDA_ADSP_REG_##reg)
+#define ssth_readl(ctx, reg) \
+	ssth_readl_traced(ctx, HDA_ADSP_REG_##reg)
+#define ssth_readl_alt(ctx, reg) \
+	ssth_readl_traced(ctx, reg)
+
+#define ssth_writeb(ctx, reg, value) \
+	ssth_writeb_traced(ctx, HDA_ADSP_REG_##reg, (value))
+#define ssth_writew(ctx, reg, value) \
+	ssth_writew_traced(ctx, HDA_ADSP_REG_##reg, (value))
+#define ssth_writel(ctx, reg, value) \
+	ssth_writel_traced(ctx, HDA_ADSP_REG_##reg, (value))
+
+#define ssth_updatel(ctx, reg, mask, value) \
+	ssth_updatel_bits(ctx, HDA_ADSP_REG_##reg, reg##_##mask, (value))
+
+#define ssth_updatel_locked(ctx, reg, mask, value) \
+	ssth_updatel_bits_locked(ctx, HDA_ADSP_REG_##reg, \
+		reg##_##mask, (value))
+
+/* Intel HD Audio General DSP Registers */
+#define HDA_ADSP_GEN_BASE		0x0
+#define HDA_ADSP_REG_ADSPCS		(HDA_ADSP_GEN_BASE + 0x04)
+#define HDA_ADSP_REG_ADSPIC		(HDA_ADSP_GEN_BASE + 0x08)
+#define HDA_ADSP_REG_ADSPIS		(HDA_ADSP_GEN_BASE + 0x0C)
+#define HDA_ADSP_REG_ADSPIC2		(HDA_ADSP_GEN_BASE + 0x10)
+#define HDA_ADSP_REG_ADSPIS2		(HDA_ADSP_GEN_BASE + 0x14)
+
+/* Intel HD Audio Inter-Processor Communication Registers */
+#define HDA_ADSP_IPC_BASE		0x40
+#define HDA_ADSP_REG_HIPCT		(HDA_ADSP_IPC_BASE + 0x00)
+#define HDA_ADSP_REG_HIPCTE		(HDA_ADSP_IPC_BASE + 0x04)
+#define HDA_ADSP_REG_HIPCI		(HDA_ADSP_IPC_BASE + 0x08)
+#define HDA_ADSP_REG_HIPCIE		(HDA_ADSP_IPC_BASE + 0x0C)
+#define HDA_ADSP_REG_HIPCCTL		(HDA_ADSP_IPC_BASE + 0x10)
+
+/*  HIPCI */
+#define HDA_ADSP_REG_HIPCI_BUSY		BIT(31)
+
+/* HIPCIE */
+#define HDA_ADSP_REG_HIPCIE_DONE	BIT(30)
+
+/* HIPCCTL */
+#define HDA_ADSP_REG_HIPCCTL_DONE	BIT(1)
+#define HDA_ADSP_REG_HIPCCTL_BUSY       BIT(0)
+
+/* HIPCT */
+#define HDA_ADSP_REG_HIPCT_BUSY		BIT(31)
+
+/* Intel HD Audio Code Loader DMA Registers */
+#define HDA_ADSP_LOADER_BASE	0x80
+
+/* Intel HD Audio SRAM Window 1 */
+#define HDA_ADSP_SRAM1_BASE		0xA000
+
+/* Intel HD Audio SRAM Window 2 */
+#define HDA_ADSP_SRAM2_BASE		0xC000
+
+/* Intel HD Audio SRAM Window 3 */
+#define HDA_ADSP_SRAM3_BASE		0xE000
+
+#define HDA_ADSP_MMIO_LEN		0x10000
+
+#define WINDOW0_STAT_SIZE		0x800
+
+#define WINDOW0_UP_SIZE			0x800
+
+#define WINDOW1_SIZE			0x1000
+
+#define ADSPIC_IPC                      1
+#define ADSPIS_IPC			1
+
+struct ssth_window {
+	void __iomem *w0stat;
+	void __iomem *w0up;
+	void __iomem *w1;
+	size_t w0stat_size;
+	size_t w0up_size;
+	size_t w1_size;
+};
+
+struct ssth_lib {
+	struct device *dev;
+	void __iomem *mmio_base;
+	struct ssth_window window;
+	int irq;
+	struct snd_dma_buffer dsp_fw_buf;
+	int sst_state;
+	struct mutex sst_lock;
+	spinlock_t reg_lock;
+	const struct firmware *fw;
+};
+
+enum ssth_states {
+	SST_DSP_RUNNING = 1,
+	SST_DSP_RESET
+};
+
+static inline void
+ssth_dsp_set_state_locked(struct ssth_lib *ctx, int state)
+{
+	mutex_lock(&ctx->sst_lock);
+	ctx->sst_state = state;
+	mutex_unlock(&ctx->sst_lock);
+}
+
+void ssth_updatel_bits(struct ssth_lib *ctx, u32 offset, u32 mask, u32 value);
+
+void ssth_mailbox_write(struct ssth_lib *ctx, void *message, size_t bytes);
+void ssth_mailbox_read(struct ssth_lib *ctx, void *message, size_t bytes);
+
+u8 ssth_readb_traced(
+	struct ssth_lib *ctx,
+	u32 offset);
+
+u16 ssth_readw_traced(
+	struct ssth_lib *ctx,
+	u32 offset);
+
+u32 ssth_readl_traced(
+	struct ssth_lib *ctx,
+	u32 offset);
+
+void ssth_writeb_traced(
+	struct ssth_lib *ctx,
+	u32 offset,
+	u8 val);
+
+void ssth_writew_traced(
+	struct ssth_lib *ctx,
+	u32 offset, u16 val);
+
+void ssth_writel_traced(
+	struct ssth_lib *ctx,
+	u32 offset,
+	u32 val);
+
+#endif /*__HDA_SST_DSP_H__*/
diff --git a/sound/soc/hda/intel/soc-hda-sst-dsp.c b/sound/soc/hda/intel/soc-hda-sst-dsp.c
new file mode 100644
index 000000000000..6e85645b3a3e
--- /dev/null
+++ b/sound/soc/hda/intel/soc-hda-sst-dsp.c
@@ -0,0 +1,139 @@
+/*
+ *  soc_hda_sst-dsp.c - HDA DSP library generic function
+ *
+ *  Copyright (C) 2014-15 Intel Corp
+ *  Author:Rafal Redzimski <rafal.f.redzimski@intel.com>
+ *		Jeeja KP <jeeja.kp@intel.com>
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
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock_types.h>
+#include <linux/mutex.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/memalloc.h>
+#include <sound/soc-hda-sst-dsp.h>
+#include <sound/soc-hda-sst-ipc.h>
+
+u8 ssth_readb_traced(struct ssth_lib *dsp, u32 offset)
+{
+	u8 val;
+
+	val = readb((dsp)->mmio_base + offset);
+	dev_dbg(dsp->dev, "readb offset=%#x val=%#x\n", offset, val);
+
+	return val;
+}
+
+u16 ssth_readw_traced(struct ssth_lib *dsp, u32 offset)
+{
+	u16 val;
+
+	val = readw((dsp)->mmio_base + offset);
+	dev_dbg(dsp->dev, "readw offset=%#x val=%#x\n", offset, val);
+	return val;
+}
+
+u32 ssth_readl_traced(struct ssth_lib *dsp, u32 offset)
+{
+	u32 val;
+
+	val = readl((dsp)->mmio_base + offset);
+	dev_dbg(dsp->dev, "readl offset=%#x val=%#x\n", offset, val);
+	return val;
+}
+
+void ssth_writeb_traced(struct ssth_lib *dsp, u32 offset, u8 val)
+{
+	writeb(val, (dsp)->mmio_base + offset);
+	dev_dbg(dsp->dev, "writeb offset=%#x val=%#x\n", offset, val);
+}
+
+void ssth_writew_traced(struct ssth_lib *dsp, u32 offset, u16 val)
+{
+	dev_dbg(dsp->dev, "writew offset=%#x val=%#x\n", offset, val);
+	writew(val, (dsp)->mmio_base + offset);
+}
+void ssth_writel_traced(struct ssth_lib *dsp, u32 offset, u32 val)
+{
+	dev_dbg(dsp->dev, "writel offset=%#x val=%#x\n", offset, val);
+	writel(val, (dsp)->mmio_base + offset);
+}
+
+void ssth_updatel_bits(
+	struct ssth_lib *ctx,
+	u32 offset, u32 mask, u32 value)
+{
+	u32 val;
+
+	val = (readl((ctx)->mmio_base + offset) & ~mask) | (value & mask);
+
+	writel(val, (ctx)->mmio_base + offset);
+
+	dev_dbg(ctx->dev, "update bits offset=%#x val=%#x\n", offset, val);
+}
+
+static void ssth_updatel_bits_locked(
+	struct ssth_lib  *ctx,
+	u32 offset, u32 mask, u32 value)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->reg_lock, flags);
+	ssth_updatel_bits(ctx, offset, mask, value);
+	spin_unlock_irqrestore(&ctx->reg_lock, flags);
+}
+
+static inline void _ssth_memcpy_toio_32(u32 __iomem *dest,
+	u32 *src, size_t bytes)
+{
+
+	/*
+	 * __iowrite32_copy uses 32-bit count values so divide by 4 for
+	 * right count in words
+	 */
+	__iowrite32_copy(dest, src, bytes/4);
+}
+
+static inline void _ssth_memcpy_fromio_32(u32 *dest,
+	__iomem u32 *src, size_t bytes)
+{
+
+	/*
+	 * __iowrite32_copy uses 32-bit count values so divide by 4 for
+	 * right count in words
+	 */
+	__iowrite32_copy(dest, src, bytes/4);
+}
+
+void ssth_mailbox_write(struct ssth_lib  *ctx, void *msg, size_t bytes)
+{
+	_ssth_memcpy_toio_32(ctx->window.w1, msg, bytes);
+}
+
+void ssth_mailbox_read(struct ssth_lib  *ctx, void *msg, size_t bytes)
+{
+	_ssth_memcpy_fromio_32(msg, ctx->window.w0up, bytes);
+}
+
+MODULE_DESCRIPTION("HDA SST/IPC Library");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
