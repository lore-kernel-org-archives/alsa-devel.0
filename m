From: apatard@mandriva.com
Subject: [patch 5/6] kirkwood: Add i2s support
Date: Thu, 27 May 2010 14:57:42 +0200
Message-ID: <20100527130338.968177114@mandriva.com>
References: <20100527125737.524554667@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline; filename=kirkwood_i2s.patch
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch enables support for the i2s controller available on kirkwood platforms

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Index: sound-2.6/sound/soc/kirkwood/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/kirkwood/Kconfig	2010-05-27 14:09:55.807674540 +0200
@@ -0,0 +1,11 @@
+config SND_KIRKWOOD_SOC
+	tristate "SoC Audio for the Marvell Kirkwood chip"
+	depends on ARCH_KIRKWOOD
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Kirkwood I2S interface. You will also need to select the
+	  audio interfaces to support below.
+
+config SND_KIRKWOOD_SOC_I2S
+	tristate
+
Index: sound-2.6/sound/soc/kirkwood/kirkwood-dma.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/kirkwood/kirkwood-dma.c	2010-05-27 14:09:55.844174800 +0200
@@ -0,0 +1,383 @@
+/*
+ * kirkwood-dma.c
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
+#include "kirkwood-dma.h"
+#include "kirkwood.h"
+
+#define KIRKWOOD_RATES \
+	(SNDRV_PCM_RATE_44100 | \
+	 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
+#define KIRKWOOD_FORMATS \
+	(SNDRV_PCM_FMTBIT_S16_LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE | \
+	 SNDRV_PCM_FMTBIT_S32_LE)
+
+struct kirkwood_dma_priv {
+	struct snd_pcm_substream *play_stream;
+	struct snd_pcm_substream *rec_stream;
+	struct kirkwood_dma_data *data;
+};
+
+static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_PAUSE),
+	.formats		= KIRKWOOD_FORMATS,
+	.rates			= KIRKWOOD_RATES,
+	.rate_min		= 44100,
+	.rate_max		= 96000,
+	.channels_min		= 1,
+	.channels_max		= 2,
+	.buffer_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES * KIRKWOOD_SND_MAX_PERIODS,
+	.period_bytes_min	= KIRKWOOD_SND_MIN_PERIOD_BYTES,
+	.period_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES,
+	.periods_min		= KIRKWOOD_SND_MIN_PERIODS,
+	.periods_max		= KIRKWOOD_SND_MAX_PERIODS,
+	.fifo_size		= 0,
+};
+
+static u64 kirkwood_dma_dmamask = 0xFFFFFFFFUL;
+
+static irqreturn_t kirkwood_dma_irq(int irq, void *dev_id)
+{
+	struct kirkwood_dma_priv *prdata = dev_id;
+	struct kirkwood_dma_data *priv = prdata->data;
+	unsigned long mask, status, cause;
+
+	mask = readl(priv->io + KIRKWOOD_INT_MASK);
+	status = readl(priv->io + KIRKWOOD_INT_CAUSE) & mask;
+
+	cause = readl(priv->io + KIRKWOOD_ERR_CAUSE);
+	if (unlikely(cause)) {
+		printk(KERN_WARNING "%s: got err interrupt 0x%lx\n",
+				__func__, cause);
+		writel(cause, priv->io + KIRKWOOD_ERR_CAUSE);
+		return IRQ_HANDLED;
+	}
+
+	/* we've enabled only bytes interrupts ... */
+	if (status & ~(KIRKWOOD_INT_CAUSE_PLAY_BYTES | \
+			KIRKWOOD_INT_CAUSE_REC_BYTES)) {
+		printk(KERN_WARNING "%s: unexpected interrupt %lx\n",
+			__func__, status);
+		return IRQ_NONE;
+	}
+
+	/* ack int */
+	writel(status, priv->io + KIRKWOOD_INT_CAUSE);
+
+	if (status & KIRKWOOD_INT_CAUSE_PLAY_BYTES)
+		snd_pcm_period_elapsed(prdata->play_stream);
+
+	if (status & KIRKWOOD_INT_CAUSE_REC_BYTES)
+		snd_pcm_period_elapsed(prdata->rec_stream);
+
+	return IRQ_HANDLED;
+}
+
+static void kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
+					unsigned long dma,
+					struct mbus_dram_target_info *dram)
+{
+	int i;
+
+	/* First disable and clear windows */
+	writel(0, base + KIRKWOOD_AUDIO_WIN_CTRL_REG(win));
+	writel(0, base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
+
+	/* try to find matching cs for current dma address */
+	for (i = 0; i < dram->num_cs; i++) {
+		struct mbus_dram_window *cs = dram->cs + i;
+		if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
+			writel(cs->base & 0xffff0000,
+				base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
+			writel(((cs->size - 1) & 0xffff0000) |
+				(cs->mbus_attr << 8) |
+				(dram->mbus_dram_target_id << 4) | 1,
+				base + KIRKWOOD_AUDIO_WIN_CTRL_REG(win));
+		}
+	}
+}
+
+static int kirkwood_dma_open(struct snd_pcm_substream *substream)
+{
+	int err;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct kirkwood_dma_data *priv;
+	struct kirkwood_dma_priv *prdata = cpu_dai->private_data;
+	unsigned long addr;
+
+	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
+	snd_soc_set_runtime_hwparams(substream, &kirkwood_dma_snd_hw);
+
+	/* Ensure that all constraints linked to dma burst are fullfilled */
+	err = snd_pcm_hw_constraint_minmax(runtime,
+			SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+			priv->burst * 2,
+			KIRKWOOD_AUDIO_BUF_MAX-1);
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
+		prdata = kzalloc(sizeof(struct kirkwood_dma_priv), GFP_KERNEL);
+		if (prdata == NULL)
+			return -ENOMEM;
+
+		prdata->data = priv;
+
+		err = request_irq(priv->irq, kirkwood_dma_irq, IRQF_SHARED,
+				  "kirkwood-i2s", prdata);
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
+		writel((unsigned long)-1, priv->io + KIRKWOOD_ERR_MASK);
+	}
+
+	addr = virt_to_phys(substream->dma_buffer.area);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		prdata->play_stream = substream;
+		kirkwood_dma_conf_mbus_windows(priv->io,
+			KIRKWOOD_PLAYBACK_WIN, addr, priv->dram);
+	} else {
+		prdata->rec_stream = substream;
+		kirkwood_dma_conf_mbus_windows(priv->io,
+			KIRKWOOD_RECORD_WIN, addr, priv->dram);
+	}
+
+	return 0;
+}
+
+static int kirkwood_dma_close(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct kirkwood_dma_priv *prdata = cpu_dai->private_data;
+	struct kirkwood_dma_data *priv;
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
+		writel(0, priv->io + KIRKWOOD_ERR_MASK);
+		free_irq(priv->irq, prdata);
+		kfree(prdata);
+		soc_runtime->dai->cpu_dai->private_data = NULL;
+	}
+
+	return 0;
+}
+
+static int kirkwood_dma_hw_params(struct snd_pcm_substream *substream,
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
+static int kirkwood_dma_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+static int kirkwood_dma_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct kirkwood_dma_data *priv;
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
+		writel(count, priv->io + KIRKWOOD_PLAY_BYTE_INT_COUNT);
+		writel(runtime->dma_addr, priv->io + KIRKWOOD_PLAY_BUF_ADDR);
+		writel(size, priv->io + KIRKWOOD_PLAY_BUF_SIZE);
+	} else {
+		writel(count, priv->io + KIRKWOOD_REC_BYTE_INT_COUNT);
+		writel(runtime->dma_addr, priv->io + KIRKWOOD_REC_BUF_ADDR);
+		writel(size, priv->io + KIRKWOOD_REC_BUF_SIZE);
+	}
+
+
+	return 0;
+}
+
+static snd_pcm_uframes_t kirkwood_dma_pointer(struct snd_pcm_substream
+						*substream)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct kirkwood_dma_data *priv;
+	snd_pcm_uframes_t count;
+
+	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		count = bytes_to_frames(substream->runtime,
+			readl(priv->io + KIRKWOOD_PLAY_BYTE_COUNT));
+	else
+		count = bytes_to_frames(substream->runtime,
+			readl(priv->io + KIRKWOOD_REC_BYTE_COUNT));
+
+	return count;
+}
+
+struct snd_pcm_ops kirkwood_dma_ops = {
+	.open =		kirkwood_dma_open,
+	.close =        kirkwood_dma_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	kirkwood_dma_hw_params,
+	.hw_free =      kirkwood_dma_hw_free,
+	.prepare =      kirkwood_dma_prepare,
+	.pointer =	kirkwood_dma_pointer,
+};
+
+static int kirkwood_dma_preallocate_dma_buffer(struct snd_pcm *pcm,
+		int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = kirkwood_dma_snd_hw.buffer_bytes_max;
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
+static int kirkwood_dma_new(struct snd_card *card,
+		struct snd_soc_dai *dai, struct snd_pcm *pcm)
+{
+	int ret;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &kirkwood_dma_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		ret = kirkwood_dma_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			return ret;
+	}
+
+	if (dai->capture.channels_min) {
+		ret = kirkwood_dma_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void kirkwood_dma_free_dma_buffers(struct snd_pcm *pcm)
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
+struct snd_soc_platform kirkwood_soc_platform = {
+	.name		= "kirkwood-dma",
+	.pcm_ops	= &kirkwood_dma_ops,
+	.pcm_new	= kirkwood_dma_new,
+	.pcm_free	= kirkwood_dma_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(kirkwood_soc_platform);
+
+static int __init kirkwood_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&kirkwood_soc_platform);
+}
+module_init(kirkwood_soc_platform_init);
+
+static void __exit kirkwood_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&kirkwood_soc_platform);
+}
+module_exit(kirkwood_soc_platform_exit);
+
+MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
+MODULE_DESCRIPTION("Marvell Kirkwood Audio DMA module");
+MODULE_LICENSE("GPL");
+
Index: sound-2.6/sound/soc/kirkwood/kirkwood.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/kirkwood/kirkwood.h	2010-05-27 14:09:55.851714894 +0200
@@ -0,0 +1,126 @@
+/*
+ * kirkwood.h
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _KIRKWOOD_AUDIO_H
+#define _KIRKWOOD_AUDIO_H
+
+#define KIRKWOOD_RECORD_WIN			0
+#define KIRKWOOD_PLAYBACK_WIN			1
+#define KIRKWOOD_MAX_AUDIO_WIN			2
+
+#define KIRKWOOD_AUDIO_WIN_BASE_REG(win)	(0xA00 + ((win)<<3))
+#define KIRKWOOD_AUDIO_WIN_CTRL_REG(win)	(0xA04 + ((win)<<3))
+
+
+#define KIRKWOOD_RECCTL			0x1000
+#define KIRKWOOD_RECCTL_SPDIF_EN		(1<<11)
+#define KIRKWOOD_RECCTL_I2S_EN			(1<<10)
+#define KIRKWOOD_RECCTL_PAUSE			(1<<9)
+#define KIRKWOOD_RECCTL_MUTE			(1<<8)
+#define KIRKWOOD_RECCTL_BURST_MASK		(3<<5)
+#define KIRKWOOD_RECCTL_BURST_128		(2<<5)
+#define KIRKWOOD_RECCTL_BURST_32		(1<<5)
+#define KIRKWOOD_RECCTL_MONO			(1<<4)
+#define KIRKWOOD_RECCTL_MONO_CHAN_RIGHT	(1<<3)
+#define KIRKWOOD_RECCTL_MONO_CHAN_LEFT		(0<<3)
+#define KIRKWOOD_RECCTL_SIZE_MASK		(7<<0)
+#define KIRKWOOD_RECCTL_SIZE_16		(7<<0)
+#define KIRKWOOD_RECCTL_SIZE_16_C		(3<<0)
+#define KIRKWOOD_RECCTL_SIZE_20		(2<<0)
+#define KIRKWOOD_RECCTL_SIZE_24		(1<<0)
+#define KIRKWOOD_RECCTL_SIZE_32		(0<<0)
+
+#define KIRKWOOD_REC_BUF_ADDR			0x1004
+#define KIRKWOOD_REC_BUF_SIZE			0x1008
+#define KIRKWOOD_REC_BYTE_COUNT			0x100C
+
+#define KIRKWOOD_PLAYCTL			0x1100
+#define KIRKWOOD_PLAYCTL_PLAY_BUSY		(1<<16)
+#define KIRKWOOD_PLAYCTL_BURST_MASK		(3<<11)
+#define KIRKWOOD_PLAYCTL_BURST_128		(2<<11)
+#define KIRKWOOD_PLAYCTL_BURST_32		(1<<11)
+#define KIRKWOOD_PLAYCTL_PAUSE			(1<<9)
+#define KIRKWOOD_PLAYCTL_SPDIF_MUTE		(1<<8)
+#define KIRKWOOD_PLAYCTL_I2S_MUTE		(1<<7)
+#define KIRKWOOD_PLAYCTL_SPDIF_EN		(1<<4)
+#define KIRKWOOD_PLAYCTL_I2S_EN		(1<<3)
+#define KIRKWOOD_PLAYCTL_SIZE_MASK		(7<<0)
+#define KIRKWOOD_PLAYCTL_SIZE_16		(7<<0)
+#define KIRKWOOD_PLAYCTL_SIZE_16_C		(3<<0)
+#define KIRKWOOD_PLAYCTL_SIZE_20		(2<<0)
+#define KIRKWOOD_PLAYCTL_SIZE_24		(1<<0)
+#define KIRKWOOD_PLAYCTL_SIZE_32		(0<<0)
+
+#define KIRKWOOD_PLAY_BUF_ADDR			0x1104
+#define KIRKWOOD_PLAY_BUF_SIZE			0x1108
+#define KIRKWOOD_PLAY_BYTE_COUNT		0x110C
+
+#define KIRKWOOD_DCO_CTL			0x1204
+#define KIRKWOOD_DCO_CTL_OFFSET_MASK		(0xFFF<<2)
+#define KIRKWOOD_DCO_CTL_OFFSET_0		(0x800<<2)
+#define KIRKWOOD_DCO_CTL_FREQ_MASK		(3<<0)
+#define KIRKWOOD_DCO_CTL_FREQ_11		(0<<0)
+#define KIRKWOOD_DCO_CTL_FREQ_12		(1<<0)
+#define KIRKWOOD_DCO_CTL_FREQ_24		(2<<0)
+
+#define KIRKWOOD_DCO_SPCR_STATUS		0x120c
+#define KIRKWOOD_DCO_SPCR_STATUS_DCO_LOCK	(1<<16)
+
+#define KIRKWOOD_ERR_CAUSE			0x1300
+#define KIRKWOOD_ERR_MASK			0x1304
+
+#define KIRKWOOD_INT_CAUSE			0x1308
+#define KIRKWOOD_INT_MASK			0x130C
+#define KIRKWOOD_INT_CAUSE_PLAY_BYTES		(1<<14)
+#define KIRKWOOD_INT_CAUSE_REC_BYTES		(1<<13)
+#define KIRKWOOD_INT_CAUSE_DMA_PLAY_END	(1<<7)
+#define KIRKWOOD_INT_CAUSE_DMA_PLAY_3Q		(1<<6)
+#define KIRKWOOD_INT_CAUSE_DMA_PLAY_HALF	(1<<5)
+#define KIRKWOOD_INT_CAUSE_DMA_PLAY_1Q		(1<<4)
+#define KIRKWOOD_INT_CAUSE_DMA_REC_END		(1<<3)
+#define KIRKWOOD_INT_CAUSE_DMA_REC_3Q		(1<<2)
+#define KIRKWOOD_INT_CAUSE_DMA_REC_HALF	(1<<1)
+#define KIRKWOOD_INT_CAUSE_DMA_REC_1Q		(1<<0)
+
+#define KIRKWOOD_REC_BYTE_INT_COUNT		0x1310
+#define KIRKWOOD_PLAY_BYTE_INT_COUNT		0x1314
+#define KIRKWOOD_BYTE_INT_COUNT_MASK		0xffffff
+
+#define KIRKWOOD_I2S_PLAYCTL			0x2508
+#define KIRKWOOD_I2S_RECCTL			0x2408
+#define KIRKWOOD_I2S_CTL_JUST_MASK		(0xf<<26)
+#define KIRKWOOD_I2S_CTL_LJ			(0<<26)
+#define KIRKWOOD_I2S_CTL_I2S			(5<<26)
+#define KIRKWOOD_I2S_CTL_RJ			(8<<26)
+#define KIRKWOOD_I2S_CTL_SIZE_MASK		(3<<30)
+#define KIRKWOOD_I2S_CTL_SIZE_16		(3<<30)
+#define KIRKWOOD_I2S_CTL_SIZE_20		(2<<30)
+#define KIRKWOOD_I2S_CTL_SIZE_24		(1<<30)
+#define KIRKWOOD_I2S_CTL_SIZE_32		(0<<30)
+
+#define KIRKWOOD_AUDIO_BUF_MAX			(16*1024*1024)
+
+/* Theses values come from the marvell alsa driver */
+/* need to find where they come from               */
+#define KIRKWOOD_SND_MIN_PERIODS		8
+#define KIRKWOOD_SND_MAX_PERIODS		16
+#define KIRKWOOD_SND_MIN_PERIOD_BYTES		0x4000
+#define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x4000
+
+struct kirkwood_dma_data {
+	struct resource *mem;
+	void __iomem *io;
+	int irq;
+	int burst;
+	struct mbus_dram_target_info *dram;
+};
+
+#endif
Index: sound-2.6/sound/soc/kirkwood/kirkwood-i2s.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/kirkwood/kirkwood-i2s.c	2010-05-27 14:09:55.859694735 +0200
@@ -0,0 +1,485 @@
+/*
+ * kirkwood-i2s.c
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
+#include "kirkwood-i2s.h"
+#include "kirkwood.h"
+
+#define DRV_NAME	"kirkwood-i2s"
+
+#define KIRKWOOD_I2S_RATES \
+	(SNDRV_PCM_RATE_44100 | \
+	 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
+#define KIRKWOOD_I2S_FORMATS \
+	(SNDRV_PCM_FMTBIT_S16_LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE | \
+	 SNDRV_PCM_FMTBIT_S32_LE)
+
+
+struct snd_soc_dai kirkwood_i2s_dai;
+static struct kirkwood_dma_data *priv;
+
+static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	unsigned long mask;
+	unsigned long value;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		mask = KIRKWOOD_I2S_CTL_RJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		mask = KIRKWOOD_I2S_CTL_LJ;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		mask = KIRKWOOD_I2S_CTL_I2S;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Set same format for playback and record
+	 * This avoids some troubles.
+	 */
+	value = readl(priv->io+KIRKWOOD_I2S_PLAYCTL);
+	value &= ~KIRKWOOD_I2S_CTL_JUST_MASK;
+	value |= mask;
+	writel(value, priv->io+KIRKWOOD_I2S_PLAYCTL);
+
+	value = readl(priv->io+KIRKWOOD_I2S_RECCTL);
+	value &= ~KIRKWOOD_I2S_CTL_JUST_MASK;
+	value |= mask;
+	writel(value, priv->io+KIRKWOOD_I2S_RECCTL);
+
+	return 0;
+}
+
+static inline void kirkwood_set_dco(void __iomem *io, unsigned long rate)
+{
+	unsigned long value;
+
+	value = KIRKWOOD_DCO_CTL_OFFSET_0;
+	switch (rate) {
+	default:
+	case 44100:
+		value |= KIRKWOOD_DCO_CTL_FREQ_11;
+		break;
+	case 48000:
+		value |= KIRKWOOD_DCO_CTL_FREQ_12;
+		break;
+	case 96000:
+		value |= KIRKWOOD_DCO_CTL_FREQ_24;
+		break;
+	}
+	writel(value, io + KIRKWOOD_DCO_CTL);
+
+	/* wait for dco locked */
+	do {
+		cpu_relax();
+		value = readl(io + KIRKWOOD_DCO_SPCR_STATUS);
+		value &= KIRKWOOD_DCO_SPCR_STATUS;
+	} while (value == 0);
+}
+
+static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	unsigned int i2s_reg, reg;
+	unsigned long i2s_value, value;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		i2s_reg = KIRKWOOD_I2S_PLAYCTL;
+		reg = KIRKWOOD_PLAYCTL;
+	} else {
+		i2s_reg = KIRKWOOD_I2S_RECCTL;
+		reg = KIRKWOOD_RECCTL;
+	}
+
+	/* set dco conf */
+	kirkwood_set_dco(priv->io, params_rate(params));
+
+	i2s_value = readl(priv->io+i2s_reg);
+	i2s_value &= ~KIRKWOOD_I2S_CTL_SIZE_MASK;
+
+	value = readl(priv->io+reg);
+	value &= ~KIRKWOOD_PLAYCTL_SIZE_MASK;
+
+	/*
+	 * Size settings in play/rec i2s control regs and play/rec control
+	 * regs must be the same.
+	 */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_16;
+		value |= KIRKWOOD_PLAYCTL_SIZE_16_C;
+		break;
+	/*
+	 * doesn't work... S20_3LE != kirkwood 20bit format ?
+	 *
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_20;
+		value |= KIRKWOOD_PLAYCTL_SIZE_20;
+		break;
+	*/
+	case SNDRV_PCM_FORMAT_S24_LE:
+		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_24;
+		value |= KIRKWOOD_PLAYCTL_SIZE_24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_32;
+		value |= KIRKWOOD_PLAYCTL_SIZE_32;
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
+static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
+				int cmd, struct snd_soc_dai *dai)
+{
+	unsigned long value;
+
+	/*
+	 * specs says KIRKWOOD_PLAYCTL must be read 2 times before
+	 * changing it. So read 1 time here and 1 later.
+	 */
+	value = readl(priv->io + KIRKWOOD_PLAYCTL);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* stop audio, enable interrupts */
+		value = readl(priv->io + KIRKWOOD_PLAYCTL);
+		value |= KIRKWOOD_PLAYCTL_PAUSE;
+		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+
+		value = readl(priv->io + KIRKWOOD_INT_MASK);
+		value |= KIRKWOOD_INT_CAUSE_PLAY_BYTES;
+		writel(value, priv->io + KIRKWOOD_INT_MASK);
+
+		/* configure audio & enable i2s playback */
+		value = readl(priv->io + KIRKWOOD_PLAYCTL);
+		value &= ~KIRKWOOD_PLAYCTL_BURST_MASK;
+		value &= ~(KIRKWOOD_PLAYCTL_PAUSE|KIRKWOOD_PLAYCTL_SPDIF_EN);
+
+		if (priv->burst == 32)
+			value |= KIRKWOOD_PLAYCTL_BURST_32;
+		else
+			value |= KIRKWOOD_PLAYCTL_BURST_128;
+		value |= KIRKWOOD_PLAYCTL_I2S_EN;
+		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* stop audio, disable interrupts */
+		value = readl(priv->io + KIRKWOOD_PLAYCTL);
+		value |= KIRKWOOD_PLAYCTL_PAUSE;
+		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+
+		value = readl(priv->io + KIRKWOOD_INT_MASK);
+		value &= ~KIRKWOOD_INT_CAUSE_PLAY_BYTES;
+		writel(value, priv->io + KIRKWOOD_INT_MASK);
+
+		/* disable all playbacks */
+		value = readl(priv->io + KIRKWOOD_PLAYCTL);
+		value &= ~(KIRKWOOD_PLAYCTL_I2S_EN | KIRKWOOD_PLAYCTL_SPDIF_EN);
+		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		value = readl(priv->io + KIRKWOOD_PLAYCTL);
+		value |= KIRKWOOD_PLAYCTL_PAUSE;
+		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		value = readl(priv->io + KIRKWOOD_PLAYCTL);
+		value &= ~KIRKWOOD_PLAYCTL_PAUSE;
+		writel(value, priv->io + KIRKWOOD_PLAYCTL);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
+				int cmd, struct snd_soc_dai *dai)
+{
+	unsigned long value;
+
+	value = readl(priv->io + KIRKWOOD_RECCTL);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* stop audio, enable interrupts */
+		value = readl(priv->io + KIRKWOOD_RECCTL);
+		value |= KIRKWOOD_RECCTL_PAUSE;
+		writel(value, priv->io + KIRKWOOD_RECCTL);
+
+		value = readl(priv->io + KIRKWOOD_INT_MASK);
+		value |= KIRKWOOD_INT_CAUSE_REC_BYTES;
+		writel(value, priv->io + KIRKWOOD_INT_MASK);
+
+		/* configure audio & enable i2s record */
+		value = readl(priv->io + KIRKWOOD_RECCTL);
+		value &= ~KIRKWOOD_RECCTL_BURST_MASK;
+		value &= ~KIRKWOOD_RECCTL_MONO;
+		value &= ~(KIRKWOOD_RECCTL_PAUSE | KIRKWOOD_RECCTL_SPDIF_EN);
+
+		if (priv->burst == 32)
+			value |= KIRKWOOD_RECCTL_BURST_32;
+		else
+			value |= KIRKWOOD_RECCTL_BURST_128;
+		value |= KIRKWOOD_RECCTL_I2S_EN;
+
+		writel(value, priv->io + KIRKWOOD_RECCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* stop audio, disable interrupts */
+		value = readl(priv->io + KIRKWOOD_RECCTL);
+		value |= KIRKWOOD_RECCTL_PAUSE;
+		writel(value, priv->io + KIRKWOOD_RECCTL);
+
+		value = readl(priv->io + KIRKWOOD_INT_MASK);
+		value &= ~KIRKWOOD_INT_CAUSE_REC_BYTES;
+		writel(value, priv->io + KIRKWOOD_INT_MASK);
+
+		/* disable all records */
+		value = readl(priv->io + KIRKWOOD_RECCTL);
+		value &= ~(KIRKWOOD_RECCTL_I2S_EN | KIRKWOOD_RECCTL_SPDIF_EN);
+		writel(value, priv->io + KIRKWOOD_RECCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		value = readl(priv->io + KIRKWOOD_RECCTL);
+		value |= KIRKWOOD_RECCTL_PAUSE;
+		writel(value, priv->io + KIRKWOOD_RECCTL);
+		break;
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		value = readl(priv->io + KIRKWOOD_RECCTL);
+		value &= ~KIRKWOOD_RECCTL_PAUSE;
+		writel(value, priv->io + KIRKWOOD_RECCTL);
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
+static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return kirkwood_i2s_play_trigger(substream, cmd, dai);
+	else
+		return kirkwood_i2s_rec_trigger(substream, cmd, dai);
+
+	return 0;
+}
+
+static int kirkwood_i2s_probe(struct platform_device *pdev,
+			     struct snd_soc_dai *dai)
+{
+	unsigned long value;
+	unsigned int reg_data;
+
+	/* put system in a "safe" state : */
+	/* disable audio interrupts */
+	writel(0xffffffff, priv->io + KIRKWOOD_INT_CAUSE);
+	writel(0, priv->io + KIRKWOOD_INT_MASK);
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
+	value = readl(priv->io + KIRKWOOD_PLAYCTL);
+	value &= ~(KIRKWOOD_PLAYCTL_I2S_EN|KIRKWOOD_PLAYCTL_SPDIF_EN);
+	writel(value, priv->io + KIRKWOOD_PLAYCTL);
+
+	value = readl(priv->io + KIRKWOOD_RECCTL);
+	value &= ~(KIRKWOOD_RECCTL_I2S_EN | KIRKWOOD_RECCTL_SPDIF_EN);
+	writel(value, priv->io + KIRKWOOD_RECCTL);
+
+	return 0;
+
+}
+
+static void kirkwood_i2s_remove(struct platform_device *pdev,
+				struct snd_soc_dai *dai)
+{
+}
+
+static struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
+	.trigger	= kirkwood_i2s_trigger,
+	.hw_params      = kirkwood_i2s_hw_params,
+	.set_fmt        = kirkwood_i2s_set_fmt,
+};
+
+
+struct snd_soc_dai kirkwood_i2s_dai = {
+	.name = DRV_NAME,
+	.id = 0,
+	.probe = kirkwood_i2s_probe,
+	.remove = kirkwood_i2s_remove,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = KIRKWOOD_I2S_RATES,
+		.formats = KIRKWOOD_I2S_FORMATS,},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = KIRKWOOD_I2S_RATES,
+		.formats = KIRKWOOD_I2S_FORMATS,},
+	.ops = &kirkwood_i2s_dai_ops,
+};
+EXPORT_SYMBOL_GPL(kirkwood_i2s_dai);
+
+static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
+{
+	struct resource *mem;
+	struct kirkwood_asoc_platform_data *data =
+		pdev->dev.platform_data;
+	int err;
+
+	priv = kzalloc(sizeof(struct kirkwood_dma_data), GFP_KERNEL);
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
+	kirkwood_i2s_dai.capture.dma_data = priv;
+	kirkwood_i2s_dai.playback.dma_data = priv;
+
+	return snd_soc_register_dai(&kirkwood_i2s_dai);
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
+static __devexit int kirkwood_i2s_dev_remove(struct platform_device *pdev)
+{
+	if (priv) {
+		iounmap(priv->io);
+		release_mem_region(priv->mem->start, SZ_16K);
+		kfree(priv);
+	}
+	snd_soc_unregister_dai(&kirkwood_i2s_dai);
+	return 0;
+}
+
+static struct platform_driver kirkwood_i2s_driver = {
+	.probe  = kirkwood_i2s_dev_probe,
+	.remove = kirkwood_i2s_dev_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init kirkwood_i2s_init(void)
+{
+	return platform_driver_register(&kirkwood_i2s_driver);
+}
+module_init(kirkwood_i2s_init);
+
+static void __exit kirkwood_i2s_exit(void)
+{
+	platform_driver_unregister(&kirkwood_i2s_driver);
+}
+module_exit(kirkwood_i2s_exit);
+
+/* Module information */
+MODULE_AUTHOR("Arnaud Patard, <apatard@mandriva.com>");
+MODULE_DESCRIPTION("Kirkwood I2S SoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:kirkwood-i2s");
Index: sound-2.6/sound/soc/kirkwood/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/kirkwood/Makefile	2010-05-27 14:09:55.867694480 +0200
@@ -0,0 +1,6 @@
+snd-soc-kirkwood-objs := kirkwood-dma.o
+snd-soc-kirkwood-i2s-objs := kirkwood-i2s.o
+
+obj-$(CONFIG_SND_KIRKWOOD_SOC) += snd-soc-kirkwood.o
+obj-$(CONFIG_SND_KIRKWOOD_SOC_I2S) += snd-soc-kirkwood-i2s.o
+
Index: sound-2.6/sound/soc/Makefile
===================================================================
--- sound-2.6.orig/sound/soc/Makefile	2010-05-27 14:09:32.411724822 +0200
+++ sound-2.6/sound/soc/Makefile	2010-05-27 14:09:55.875714679 +0200
@@ -10,6 +10,7 @@ obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)   += imx/
 obj-$(CONFIG_SND_SOC)	+= nuc900/
 obj-$(CONFIG_SND_SOC)	+= omap/
+obj-$(CONFIG_SND_SOC)	+= kirkwood/
 obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= s3c24xx/
 obj-$(CONFIG_SND_SOC)	+= s6000/
Index: sound-2.6/sound/soc/kirkwood/kirkwood-dma.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/kirkwood/kirkwood-dma.h	2010-05-27 14:09:55.883714769 +0200
@@ -0,0 +1,17 @@
+/*
+ * kirkwood-dma.h
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _KIRKWOOD_DMA_H
+#define _KIRKWOOD_DMA_H
+
+extern struct snd_soc_platform kirkwood_soc_platform;
+
+#endif
Index: sound-2.6/sound/soc/kirkwood/kirkwood-i2s.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/sound/soc/kirkwood/kirkwood-i2s.h	2010-05-27 14:09:55.891695033 +0200
@@ -0,0 +1,17 @@
+/*
+ * kirkwood-i2s.h
+ *
+ * (c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef _KIRKWOOD_I2S_H
+#define _KIRKWOOD_I2S_H
+
+extern struct snd_soc_dai kirkwood_i2s_dai;
+
+#endif
Index: sound-2.6/sound/soc/Kconfig
===================================================================
--- sound-2.6.orig/sound/soc/Kconfig	2010-05-27 14:09:32.303673990 +0200
+++ sound-2.6/sound/soc/Kconfig	2010-05-27 14:09:55.899714700 +0200
@@ -32,6 +32,7 @@ source "sound/soc/fsl/Kconfig"
 source "sound/soc/imx/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
+source "sound/soc/kirkwood/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
 source "sound/soc/s6000/Kconfig"
