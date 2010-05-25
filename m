From: apatard@mandriva.com
Subject: [patch 4/5] orion/kirkwood: Add i2s support
Date: Tue, 25 May 2010 14:22:40 +0200
Message-ID: <20100525122341.443140710@mandriva.com>
References: <20100525122236.841941526@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id DCFFF244FF
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 14:22:55 +0200 (CEST)
Content-Disposition: inline; filename=kirkwood_i2s.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch enables support for the i2s controller available on orion/kirkwood platforms

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Index: sound-2.6/sound/soc/orion/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/orion/Kconfig	2010-05-25 10:31:24.601080937 +0200
@@ -0,0 +1,11 @@
+config SND_ORION_SOC
+	tristate "SoC Audio for the Marvell Orion/Kirkwood chip"
+	depends on ARCH_KIRKWOOD || ARCH_ARCH_ORION5X
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Orion/Kirkwood I2S interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_ORION_SOC_I2S
+	tristate
+
Index: sound-2.6/sound/soc/orion/orion-dma.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/orion/orion-dma.c	2010-05-25 10:31:34.405079748 +0200
@@ -0,0 +1,381 @@
+/*
+ * orion-dma.c
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/mbus.h>
+#include <sound/soc.h>
+#include "orion-dma.h"
+#include "orion.h"
+
+#define ORION_RATES \
+	(SNDRV_PCM_RATE_44100 | \
+	 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
+#define ORION_FORMATS \
+	(SNDRV_PCM_FMTBIT_S16_LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE | \
+	 SNDRV_PCM_FMTBIT_S32_LE)
+
+struct orion_dma_priv {
+	struct snd_pcm_substream *play_stream;
+	struct snd_pcm_substream *rec_stream;
+	struct orion_dma_data *data;
+};
+
+static struct snd_pcm_hardware orion_dma_snd_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_PAUSE),
+	.formats		= ORION_FORMATS,
+	.rates			= ORION_RATES,
+	.rate_min		= 44100,
+	.rate_max		= 96000,
+	.channels_min		= 1,
+	.channels_max		= 2,
+	.buffer_bytes_max	= ORION_SND_MAX_PERIOD_BYTES * ORION_SND_MAX_PERIODS,
+	.period_bytes_min	= ORION_SND_MIN_PERIOD_BYTES,
+	.period_bytes_max	= ORION_SND_MAX_PERIOD_BYTES,
+	.periods_min		= ORION_SND_MIN_PERIODS,
+	.periods_max		= ORION_SND_MAX_PERIODS,
+	.fifo_size		= 0,
+};
+
+static u64 orion_dma_dmamask = 0xFFFFFFFFUL;
+
+static irqreturn_t orion_dma_irq(int irq, void *dev_id)
+{
+	struct orion_dma_priv *prdata = dev_id;
+	struct orion_dma_data *priv = prdata->data;
+	unsigned long mask, status, cause;
+
+	mask = readl(priv->io + ORION_INT_MASK);
+	status = readl(priv->io + ORION_INT_CAUSE) & mask;
+
+	cause = readl(priv->io + ORION_ERR_CAUSE);
+	if (unlikely(cause)) {
+		printk(KERN_WARNING "%s: got err interrupt 0x%lx\n",
+				__func__, cause);
+		writel(cause, priv->io + ORION_ERR_CAUSE);
+		return IRQ_HANDLED;
+	}
+
+	/* we've enabled only bytes interrupts ... */
+	if (status & ~(ORION_INT_CAUSE_PLAY_BYTES | \
+			ORION_INT_CAUSE_REC_BYTES)) {
+		printk(KERN_WARNING "%s: unexpected interrupt %lx\n",
+			__func__, status);
+		return IRQ_NONE;
+	}
+
+	/* ack int */
+	writel(status, priv->io + ORION_INT_CAUSE);
+
+	if (status & ORION_INT_CAUSE_PLAY_BYTES)
+		snd_pcm_period_elapsed(prdata->play_stream);
+
+	if (status & ORION_INT_CAUSE_REC_BYTES)
+		snd_pcm_period_elapsed(prdata->rec_stream);
+
+	return IRQ_HANDLED;
+}
+
+static void orion_dma_conf_mbus_windows(void __iomem *base, int win,
+					unsigned long dma,
+					struct mbus_dram_target_info *dram)
+{
+	int i;
+
+	/* First disable and clear windows */
+	writel(0, base + ORION_AUDIO_WIN_CTRL_REG(win));
+	writel(0, base + ORION_AUDIO_WIN_BASE_REG(win));
+
+	/* try to find matching cs for current dma address */
+	for (i = 0; i < dram->num_cs; i++) {
+		struct mbus_dram_window *cs = dram->cs + i;
+		if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
+			writel(cs->base & 0xffff0000,
+				base + ORION_AUDIO_WIN_BASE_REG(win));
+			writel(((cs->size - 1) & 0xffff0000) |
+				(cs->mbus_attr << 8) |
+				(dram->mbus_dram_target_id << 4) | 1,
+				base + ORION_AUDIO_WIN_CTRL_REG(win));
+		}
+	}
+}
+
+static int orion_dma_open(struct snd_pcm_substream *substream)
+{
+	int err;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct orion_dma_data *priv;
+	struct orion_dma_priv *prdata = cpu_dai->private_data;
+	unsigned long addr;
+
+	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
+	snd_soc_set_runtime_hwparams(substream, &orion_dma_snd_hw);
+
+	/* Ensure that all constraints linked to dma burst are fullfilled */
+	err = snd_pcm_hw_constraint_minmax(runtime,
+			SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+			priv->burst * 2,
+			ORION_AUDIO_BUF_MAX-1);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+			SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+			priv->burst);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
+			 SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+			 priv->burst);
+	if (err < 0)
+		return err;
+
+	if (soc_runtime->dai->cpu_dai->private_data == NULL) {
+		prdata = kzalloc(sizeof(struct orion_dma_priv), GFP_KERNEL);
+		if (prdata == NULL)
+			return -ENOMEM;
+
+		prdata->data = priv;
+
+		err = request_irq(priv->irq, orion_dma_irq, IRQF_SHARED,
+				  "orion-i2s", prdata);
+		if (err) {
+			kfree(prdata);
+			return -EBUSY;
+		}
+
+		soc_runtime->dai->cpu_dai->private_data = prdata;
+
+		/*
+		 * Enable Error interrupts. We're only ack'ing them but
+		 * it's usefull for diagnostics
+		 */
+		writel((unsigned long)-1, priv->io + ORION_ERR_MASK);
+	}
+
+	addr = virt_to_phys(substream->dma_buffer.area);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		prdata->play_stream = substream;
+		orion_dma_conf_mbus_windows(priv->io, 1, addr, priv->dram);
+	} else {
+		prdata->rec_stream = substream;
+		orion_dma_conf_mbus_windows(priv->io, 0, addr, priv->dram);
+	}
+
+	return 0;
+}
+
+static int orion_dma_close(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct orion_dma_priv *prdata = cpu_dai->private_data;
+	struct orion_dma_data *priv;
+
+	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
+
+	if (!prdata || !priv)
+		return 0;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		prdata->play_stream = NULL;
+	else
+		prdata->rec_stream = NULL;
+
+	if (!prdata->play_stream && !prdata->rec_stream) {
+		writel(0, priv->io + ORION_ERR_MASK);
+		free_irq(priv->irq, prdata);
+		kfree(prdata);
+		soc_runtime->dai->cpu_dai->private_data = NULL;
+	}
+
+	return 0;
+}
+
+static int orion_dma_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = params_buffer_bytes(params);
+
+	return 0;
+}
+
+static int orion_dma_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+static int orion_dma_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct orion_dma_data *priv;
+	unsigned long size, count;
+
+	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
+
+	/* compute buffer size in term of "words" as requested in specs */
+	size = frames_to_bytes(runtime, runtime->buffer_size);
+	size = (size>>2)-1;
+	count = snd_pcm_lib_period_bytes(substream);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		writel(count, priv->io + ORION_PLAY_BYTE_INT_COUNT);
+		writel(runtime->dma_addr, priv->io + ORION_PLAY_BUF_ADDR);
+		writel(size, priv->io + ORION_PLAY_BUF_SIZE);
+	} else {
+		writel(count, priv->io + ORION_REC_BYTE_INT_COUNT);
+		writel(runtime->dma_addr, priv->io + ORION_REC_BUF_ADDR);
+		writel(size, priv->io + ORION_REC_BUF_SIZE);
+	}
+
+
+	return 0;
+}
+
+static snd_pcm_uframes_t orion_dma_pointer(struct snd_pcm_substream
+						*substream)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct orion_dma_data *priv;
+	snd_pcm_uframes_t count;
+
+	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		count = bytes_to_frames(substream->runtime,
+			readl(priv->io + ORION_PLAY_BYTE_COUNT));
+	else
+		count = bytes_to_frames(substream->runtime,
+			readl(priv->io + ORION_REC_BYTE_COUNT));
+
+	return count;
+}
+
+struct snd_pcm_ops orion_dma_ops = {
+	.open =		orion_dma_open,
+	.close =        orion_dma_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	orion_dma_hw_params,
+	.hw_free =      orion_dma_hw_free,
+	.prepare =      orion_dma_prepare,
+	.pointer =	orion_dma_pointer,
+};
+
+static int orion_dma_preallocate_dma_buffer(struct snd_pcm *pcm,
+		int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = orion_dma_snd_hw.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->area = dma_alloc_coherent(pcm->card->dev, size,
+			&buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->bytes = size;
+	buf->private_data = NULL;
+
+	return 0;
+}
+
+static int orion_dma_new(struct snd_card *card,
+		struct snd_soc_dai *dai, struct snd_pcm *pcm)
+{
+	int ret;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &orion_dma_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		ret = orion_dma_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			return ret;
+	}
+
+	if (dai->capture.channels_min) {
+		ret = orion_dma_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void orion_dma_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_coherent(pcm->card->dev, buf->bytes,
+				buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+struct snd_soc_platform orion_soc_platform = {
+	.name		= "orion-dma",
+	.pcm_ops	= &orion_dma_ops,
+	.pcm_new	= orion_dma_new,
+	.pcm_free	= orion_dma_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(orion_soc_platform);
+
+static int __init orion_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&orion_soc_platform);
+}
+module_init(orion_soc_platform_init);
+
+static void __exit orion_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&orion_soc_platform);
+}
+module_exit(orion_soc_platform_exit);
+
+MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
+MODULE_DESCRIPTION("Marvell Orion/Kirkwood Audio DMA module");
+MODULE_LICENSE("GPL");
+
Index: sound-2.6/sound/soc/orion/orion.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/orion/orion.h	2010-05-24 23:51:07.028579877 +0200
@@ -0,0 +1,126 @@
+/*
+ * orion.h
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _ORION_AUDIO_H
+#define _ORION_AUDIO_H
+
+#define ORION_RECORD_WIN			0
+#define ORION_PLAYBACK_WIN			1
+#define ORION_MAX_AUDIO_WIN			2
+
+#define ORION_AUDIO_WIN_BASE_REG(win)		(0xA00 + ((win)<<3))
+#define ORION_AUDIO_WIN_CTRL_REG(win)		(0xA04 + ((win)<<3))
+
+
+#define ORION_RECCTL				0x1000
+#define ORION_RECCTL_SPDIF_EN		(1<<11)
+#define ORION_RECCTL_I2S_EN			(1<<10)
+#define ORION_RECCTL_PAUSE			(1<<9)
+#define ORION_RECCTL_MUTE			(1<<8)
+#define ORION_RECCTL_BURST_MASK		(3<<5)
+#define ORION_RECCTL_BURST_128		(2<<5)
+#define ORION_RECCTL_BURST_32		(1<<5)
+#define ORION_RECCTL_MONO			(1<<4)
+#define ORION_RECCTL_MONO_CHAN_RIGHT		(1<<3)
+#define ORION_RECCTL_MONO_CHAN_LEFT		(0<<3)
+#define ORION_RECCTL_SIZE_MASK		(7<<0)
+#define ORION_RECCTL_SIZE_16			(7<<0)
+#define ORION_RECCTL_SIZE_16_C		(3<<0)
+#define ORION_RECCTL_SIZE_20			(2<<0)
+#define ORION_RECCTL_SIZE_24			(1<<0)
+#define ORION_RECCTL_SIZE_32			(0<<0)
+
+#define ORION_REC_BUF_ADDR			0x1004
+#define ORION_REC_BUF_SIZE			0x1008
+#define ORION_REC_BYTE_COUNT			0x100C
+
+#define ORION_PLAYCTL			0x1100
+#define ORION_PLAYCTL_PLAY_BUSY		(1<<16)
+#define ORION_PLAYCTL_BURST_MASK		(3<<11)
+#define ORION_PLAYCTL_BURST_128		(2<<11)
+#define ORION_PLAYCTL_BURST_32		(1<<11)
+#define ORION_PLAYCTL_PAUSE			(1<<9)
+#define ORION_PLAYCTL_SPDIF_MUTE		(1<<8)
+#define ORION_PLAYCTL_I2S_MUTE		(1<<7)
+#define ORION_PLAYCTL_SPDIF_EN		(1<<4)
+#define ORION_PLAYCTL_I2S_EN			(1<<3)
+#define ORION_PLAYCTL_SIZE_MASK		(7<<0)
+#define ORION_PLAYCTL_SIZE_16		(7<<0)
+#define ORION_PLAYCTL_SIZE_16_C		(3<<0)
+#define ORION_PLAYCTL_SIZE_20		(2<<0)
+#define ORION_PLAYCTL_SIZE_24		(1<<0)
+#define ORION_PLAYCTL_SIZE_32		(0<<0)
+
+#define ORION_PLAY_BUF_ADDR			0x1104
+#define ORION_PLAY_BUF_SIZE			0x1108
+#define ORION_PLAY_BYTE_COUNT		0x110C
+
+#define ORION_DCO_CTL			0x1204
+#define ORION_DCO_CTL_OFFSET_MASK		(0xFFF<<2)
+#define ORION_DCO_CTL_OFFSET_0		(0x800<<2)
+#define ORION_DCO_CTL_FREQ_MASK		(3<<0)
+#define ORION_DCO_CTL_FREQ_11		(0<<0)
+#define ORION_DCO_CTL_FREQ_12		(1<<0)
+#define ORION_DCO_CTL_FREQ_24		(2<<0)
+
+#define ORION_DCO_SPCR_STATUS		0x120c
+#define ORION_DCO_SPCR_STATUS_DCO_LOCK	(1<<16)
+
+#define ORION_ERR_CAUSE			0x1300
+#define ORION_ERR_MASK			0x1304
+
+#define ORION_INT_CAUSE			0x1308
+#define ORION_INT_MASK			0x130C
+#define ORION_INT_CAUSE_PLAY_BYTES		(1<<14)
+#define ORION_INT_CAUSE_REC_BYTES		(1<<13)
+#define ORION_INT_CAUSE_DMA_PLAY_END		(1<<7)
+#define ORION_INT_CAUSE_DMA_PLAY_3Q		(1<<6)
+#define ORION_INT_CAUSE_DMA_PLAY_HALF	(1<<5)
+#define ORION_INT_CAUSE_DMA_PLAY_1Q		(1<<4)
+#define ORION_INT_CAUSE_DMA_REC_END		(1<<3)
+#define ORION_INT_CAUSE_DMA_REC_3Q		(1<<2)
+#define ORION_INT_CAUSE_DMA_REC_HALF		(1<<1)
+#define ORION_INT_CAUSE_DMA_REC_1Q		(1<<0)
+
+#define ORION_REC_BYTE_INT_COUNT		0x1310
+#define ORION_PLAY_BYTE_INT_COUNT		0x1314
+#define ORION_BYTE_INT_COUNT_MASK		0xffffff
+
+#define ORION_I2S_PLAYCTL			0x2508
+#define ORION_I2S_RECCTL			0x2408
+#define ORION_I2S_CTL_JUST_MASK		(0xf<<26)
+#define ORION_I2S_CTL_LJ			(0<<26)
+#define ORION_I2S_CTL_I2S			(5<<26)
+#define ORION_I2S_CTL_RJ			(8<<26)
+#define ORION_I2S_CTL_SIZE_MASK		(3<<30)
+#define ORION_I2S_CTL_SIZE_16			(3<<30)
+#define ORION_I2S_CTL_SIZE_20			(2<<30)
+#define ORION_I2S_CTL_SIZE_24			(1<<30)
+#define ORION_I2S_CTL_SIZE_32			(0<<30)
+
+#define ORION_AUDIO_BUF_MAX			(16*1024*1024)
+
+/* Theses values come from the marvell alsa driver */
+/* need to find where they come from               */
+#define ORION_SND_MIN_PERIODS			8
+#define ORION_SND_MAX_PERIODS			16
+#define	ORION_SND_MIN_PERIOD_BYTES	0x4000
+#define	ORION_SND_MAX_PERIOD_BYTES	0x4000
+
+struct orion_dma_data {
+	struct resource *mem;
+	void __iomem *io;
+	int irq;
+	int burst;
+	struct mbus_dram_target_info *dram;
+};
+
+#endif
Index: sound-2.6/sound/soc/orion/orion-i2s.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/orion/orion-i2s.c	2010-05-25 08:37:31.000000000 +0200
@@ -0,0 +1,485 @@
+/*
+ * orion-i2s.c
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/mbus.h>
+#include <linux/delay.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <plat/audio.h>
+#include "orion-i2s.h"
+#include "orion.h"
+
+#define DRV_NAME	"orion-i2s"
+
+#define ORION_I2S_RATES \
+	(SNDRV_PCM_RATE_44100 | \
+	 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
+#define ORION_I2S_FORMATS \
+	(SNDRV_PCM_FMTBIT_S16_LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE | \
+	 SNDRV_PCM_FMTBIT_S32_LE)
+
+
+struct snd_soc_dai orion_i2s_dai;
+static struct orion_dma_data *priv;
+
+static int orion_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	unsigned long mask;
+	unsigned long value;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		mask = ORION_I2S_CTL_RJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		mask = ORION_I2S_CTL_LJ;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		mask = ORION_I2S_CTL_I2S;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Set same format for playback and record
+	 * This avoids some troubles.
+	 */
+	value = readl(priv->io+ORION_I2S_PLAYCTL);
+	value &= ~ORION_I2S_CTL_JUST_MASK;
+	value |= mask;
+	writel(value, priv->io+ORION_I2S_PLAYCTL);
+
+	value = readl(priv->io+ORION_I2S_RECCTL);
+	value &= ~ORION_I2S_CTL_JUST_MASK;
+	value |= mask;
+	writel(value, priv->io+ORION_I2S_RECCTL);
+
+	return 0;
+}
+
+static inline void orion_set_dco(void __iomem *io, unsigned long rate)
+{
+	unsigned long value;
+
+	value = ORION_DCO_CTL_OFFSET_0;
+	switch (rate) {
+	default:
+	case 44100:
+		value |= ORION_DCO_CTL_FREQ_11;
+		break;
+	case 48000:
+		value |= ORION_DCO_CTL_FREQ_12;
+		break;
+	case 96000:
+		value |= ORION_DCO_CTL_FREQ_24;
+		break;
+	}
+	writel(value, io + ORION_DCO_CTL);
+
+	/* wait for dco locked */
+	do {
+		cpu_relax();
+		value = readl(io + ORION_DCO_SPCR_STATUS);
+		value &= ORION_DCO_SPCR_STATUS;
+	} while (value == 0);
+}
+
+static int orion_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	unsigned int i2s_reg, reg;
+	unsigned long i2s_value, value;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		i2s_reg = ORION_I2S_PLAYCTL;
+		reg = ORION_PLAYCTL;
+	} else {
+		i2s_reg = ORION_I2S_RECCTL;
+		reg = ORION_RECCTL;
+	}
+
+	/* set dco conf */
+	orion_set_dco(priv->io, params_rate(params));
+
+	i2s_value = readl(priv->io+i2s_reg);
+	i2s_value &= ~ORION_I2S_CTL_SIZE_MASK;
+
+	value = readl(priv->io+reg);
+	value &= ~ORION_PLAYCTL_SIZE_MASK;
+
+	/*
+	 * Size settings in play/rec i2s control regs and play/rec control
+	 * regs must be the same.
+	 */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		i2s_value |= ORION_I2S_CTL_SIZE_16;
+		value |= ORION_PLAYCTL_SIZE_16_C;
+		break;
+	/*
+	 * doesn't work... S20_3LE != orion/kirkwood 20bit format ?
+	 *
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		i2s_value |= ORION_I2S_CTL_SIZE_20;
+		value |= ORION_PLAYCTL_SIZE_20;
+		break;
+	*/
+	case SNDRV_PCM_FORMAT_S24_LE:
+		i2s_value |= ORION_I2S_CTL_SIZE_24;
+		value |= ORION_PLAYCTL_SIZE_24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		i2s_value |= ORION_I2S_CTL_SIZE_32;
+		value |= ORION_PLAYCTL_SIZE_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+	writel(i2s_value, priv->io+i2s_reg);
+	writel(value, priv->io+reg);
+
+	return 0;
+}
+
+static int orion_i2s_play_trigger(struct snd_pcm_substream *substream,
+				int cmd, struct snd_soc_dai *dai)
+{
+	unsigned long value;
+
+	/*
+	 * specs says ORION_PLAYCTL must be read 2 times before
+	 * changing it. So read 1 time here and 1 later.
+	 */
+	value = readl(priv->io + ORION_PLAYCTL);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* stop audio, enable interrupts */
+		value = readl(priv->io + ORION_PLAYCTL);
+		value |= ORION_PLAYCTL_PAUSE;
+		writel(value, priv->io + ORION_PLAYCTL);
+
+		value = readl(priv->io + ORION_INT_MASK);
+		value |= ORION_INT_CAUSE_PLAY_BYTES;
+		writel(value, priv->io + ORION_INT_MASK);
+
+		/* configure audio & enable i2s playback */
+		value = readl(priv->io + ORION_PLAYCTL);
+		value &= ~ORION_PLAYCTL_BURST_MASK;
+		value &= ~(ORION_PLAYCTL_PAUSE|ORION_PLAYCTL_SPDIF_EN);
+
+		if (priv->burst == 32)
+			value |= ORION_PLAYCTL_BURST_32;
+		else
+			value |= ORION_PLAYCTL_BURST_128;
+		value |= ORION_PLAYCTL_I2S_EN;
+		writel(value, priv->io + ORION_PLAYCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* stop audio, disable interrupts */
+		value = readl(priv->io + ORION_PLAYCTL);
+		value |= ORION_PLAYCTL_PAUSE;
+		writel(value, priv->io + ORION_PLAYCTL);
+
+		value = readl(priv->io + ORION_INT_MASK);
+		value &= ~ORION_INT_CAUSE_PLAY_BYTES;
+		writel(value, priv->io + ORION_INT_MASK);
+
+		/* disable all playbacks */
+		value = readl(priv->io + ORION_PLAYCTL);
+		value &= ~(ORION_PLAYCTL_I2S_EN | ORION_PLAYCTL_SPDIF_EN);
+		writel(value, priv->io + ORION_PLAYCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		value = readl(priv->io + ORION_PLAYCTL);
+		value |= ORION_PLAYCTL_PAUSE;
+		writel(value, priv->io + ORION_PLAYCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		value = readl(priv->io + ORION_PLAYCTL);
+		value &= ~ORION_PLAYCTL_PAUSE;
+		writel(value, priv->io + ORION_PLAYCTL);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int orion_i2s_rec_trigger(struct snd_pcm_substream *substream,
+				int cmd, struct snd_soc_dai *dai)
+{
+	unsigned long value;
+
+	value = readl(priv->io + ORION_RECCTL);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* stop audio, enable interrupts */
+		value = readl(priv->io + ORION_RECCTL);
+		value |= ORION_RECCTL_PAUSE;
+		writel(value, priv->io + ORION_RECCTL);
+
+		value = readl(priv->io + ORION_INT_MASK);
+		value |= ORION_INT_CAUSE_REC_BYTES;
+		writel(value, priv->io + ORION_INT_MASK);
+
+		/* configure audio & enable i2s record */
+		value = readl(priv->io + ORION_RECCTL);
+		value &= ~ORION_RECCTL_BURST_MASK;
+		value &= ~ORION_RECCTL_MONO;
+		value &= ~(ORION_RECCTL_PAUSE | ORION_RECCTL_SPDIF_EN);
+
+		if (priv->burst == 32)
+			value |= ORION_RECCTL_BURST_32;
+		else
+			value |= ORION_RECCTL_BURST_128;
+		value |= ORION_RECCTL_I2S_EN;
+
+		writel(value, priv->io + ORION_RECCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* stop audio, disable interrupts */
+		value = readl(priv->io + ORION_RECCTL);
+		value |= ORION_RECCTL_PAUSE;
+		writel(value, priv->io + ORION_RECCTL);
+
+		value = readl(priv->io + ORION_INT_MASK);
+		value &= ~ORION_INT_CAUSE_REC_BYTES;
+		writel(value, priv->io + ORION_INT_MASK);
+
+		/* disable all records */
+		value = readl(priv->io + ORION_RECCTL);
+		value &= ~(ORION_RECCTL_I2S_EN | ORION_RECCTL_SPDIF_EN);
+		writel(value, priv->io + ORION_RECCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		value = readl(priv->io + ORION_RECCTL);
+		value |= ORION_RECCTL_PAUSE;
+		writel(value, priv->io + ORION_RECCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		value = readl(priv->io + ORION_RECCTL);
+		value &= ~ORION_RECCTL_PAUSE;
+		writel(value, priv->io + ORION_RECCTL);
+		break;
+
+	default:
+		return -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+static int orion_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return orion_i2s_play_trigger(substream, cmd, dai);
+	else
+		return orion_i2s_rec_trigger(substream, cmd, dai);
+
+	return 0;
+}
+
+static int orion_i2s_probe(struct platform_device *pdev,
+			     struct snd_soc_dai *dai)
+{
+	unsigned long value;
+	unsigned int reg_data;
+
+	/* put system in a "safe" state : */
+	/* disable audio interrupts */
+	writel(0xffffffff, priv->io + ORION_INT_CAUSE);
+	writel(0, priv->io + ORION_INT_MASK);
+
+	reg_data = readl(priv->io + 0x1200);
+	reg_data &= (~(0x333FF8));
+	reg_data |= 0x111D18;
+	writel(reg_data, priv->io + 0x1200);
+
+	msleep(500);
+
+	reg_data = readl(priv->io + 0x1200);
+	reg_data &= (~(0x333FF8));
+	reg_data |= 0x111D18;
+	writel(reg_data, priv->io + 0x1200);
+
+	/* disable playback/record */
+	value = readl(priv->io + ORION_PLAYCTL);
+	value &= ~(ORION_PLAYCTL_I2S_EN|ORION_PLAYCTL_SPDIF_EN);
+	writel(value, priv->io + ORION_PLAYCTL);
+
+	value = readl(priv->io + ORION_RECCTL);
+	value &= ~(ORION_RECCTL_I2S_EN | ORION_RECCTL_SPDIF_EN);
+	writel(value, priv->io + ORION_RECCTL);
+
+	return 0;
+
+}
+
+static void orion_i2s_remove(struct platform_device *pdev,
+				struct snd_soc_dai *dai)
+{
+}
+
+static struct snd_soc_dai_ops orion_i2s_dai_ops = {
+	.trigger	= orion_i2s_trigger,
+	.hw_params      = orion_i2s_hw_params,
+	.set_fmt        = orion_i2s_set_fmt,
+};
+
+
+struct snd_soc_dai orion_i2s_dai = {
+	.name = DRV_NAME,
+	.id = 0,
+	.probe = orion_i2s_probe,
+	.remove = orion_i2s_remove,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = ORION_I2S_RATES,
+		.formats = ORION_I2S_FORMATS,},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = ORION_I2S_RATES,
+		.formats = ORION_I2S_FORMATS,},
+	.ops = &orion_i2s_dai_ops,
+};
+EXPORT_SYMBOL_GPL(orion_i2s_dai);
+
+static __devinit int orion_i2s_dev_probe(struct platform_device *pdev)
+{
+	struct resource *mem;
+	struct orion_asoc_platform_data *data =
+		pdev->dev.platform_data;
+	int err;
+
+	priv = kzalloc(sizeof(struct orion_dma_data), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&pdev->dev, "allocation failed\n");
+		err = -ENOMEM;
+		goto error;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "platform_get_resource failed\n");
+		err = -ENXIO;
+		goto err_alloc;
+	}
+
+	priv->mem = request_mem_region(mem->start, SZ_16K, DRV_NAME);
+	if (!priv->mem) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		err = -EBUSY;
+		goto error;
+	}
+
+	priv->io = ioremap(priv->mem->start, SZ_16K);
+	if (!priv->io) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		err = -ENOMEM;
+		goto err_iomem;
+	}
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq <= 0) {
+		dev_err(&pdev->dev, "platform_get_irq failed\n");
+		err = -ENXIO;
+		goto err_ioremap;
+	}
+
+	if (!data || !data->dram) {
+		dev_err(&pdev->dev, "no platform data ?!\n");
+		err = -EINVAL;
+		goto err_ioremap;
+	}
+
+	priv->dram = data->dram;
+	priv->burst = data->burst;
+
+	orion_i2s_dai.capture.dma_data = priv;
+	orion_i2s_dai.playback.dma_data = priv;
+
+	return snd_soc_register_dai(&orion_i2s_dai);
+
+err_ioremap:
+	iounmap(priv->io);
+err_iomem:
+	release_mem_region(priv->mem->start, SZ_16K);
+err_alloc:
+	kfree(priv);
+error:
+	return err;
+}
+
+static __devexit int orion_i2s_dev_remove(struct platform_device *pdev)
+{
+	if (priv) {
+		iounmap(priv->io);
+		release_mem_region(priv->mem->start, SZ_16K);
+		kfree(priv);
+	}
+	snd_soc_unregister_dai(&orion_i2s_dai);
+	return 0;
+}
+
+static struct platform_driver orion_i2s_driver = {
+	.probe  = orion_i2s_dev_probe,
+	.remove = orion_i2s_dev_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init orion_i2s_init(void)
+{
+	return platform_driver_register(&orion_i2s_driver);
+}
+module_init(orion_i2s_init);
+
+static void __exit orion_i2s_exit(void)
+{
+	platform_driver_unregister(&orion_i2s_driver);
+}
+module_exit(orion_i2s_exit);
+
+/* Module information */
+MODULE_AUTHOR("Arnaud Patard, <apatard@mandriva.com>");
+MODULE_DESCRIPTION("Orion/Kirkwood I2S SoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:orion-i2s");
Index: sound-2.6/sound/soc/orion/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/orion/Makefile	2010-05-25 10:31:24.633080406 +0200
@@ -0,0 +1,6 @@
+snd-soc-orion-objs := orion-dma.o
+snd-soc-orion-i2s-objs := orion-i2s.o
+
+obj-$(CONFIG_SND_ORION_SOC) += snd-soc-orion.o
+obj-$(CONFIG_SND_ORION_SOC_I2S) += snd-soc-orion-i2s.o
+
Index: sound-2.6/sound/soc/Makefile
===================================================================
--- sound-2.6.orig/sound/soc/Makefile	2010-05-24 23:50:35.880580638 +0200
+++ sound-2.6/sound/soc/Makefile	2010-05-24 23:51:07.072580370 +0200
@@ -10,6 +10,7 @@ obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)   += imx/
 obj-$(CONFIG_SND_SOC)	+= nuc900/
 obj-$(CONFIG_SND_SOC)	+= omap/
+obj-$(CONFIG_SND_SOC)	+= orion/
 obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= s3c24xx/
 obj-$(CONFIG_SND_SOC)	+= s6000/
Index: sound-2.6/sound/soc/orion/orion-dma.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/orion/orion-dma.h	2010-05-24 23:51:07.080580373 +0200
@@ -0,0 +1,17 @@
+/*
+ * orion-dma.h
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _ORION_DMA_H
+#define _ORION_DMA_H
+
+extern struct snd_soc_platform orion_soc_platform;
+
+#endif
Index: sound-2.6/sound/soc/orion/orion-i2s.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/orion/orion-i2s.h	2010-05-24 23:51:07.088580320 +0200
@@ -0,0 +1,17 @@
+/*
+ * orion-i2s.h
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _ORION_I2S_H
+#define _ORION_I2S_H
+
+extern struct snd_soc_dai orion_i2s_dai;
+
+#endif
Index: sound-2.6/sound/soc/Kconfig
===================================================================
--- sound-2.6.orig/sound/soc/Kconfig	2010-05-24 23:50:35.860580703 +0200
+++ sound-2.6/sound/soc/Kconfig	2010-05-24 23:51:07.096580366 +0200
@@ -32,6 +32,7 @@ source "sound/soc/fsl/Kconfig"
 source "sound/soc/imx/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
+source "sound/soc/orion/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
 source "sound/soc/s6000/Kconfig"
