From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 07/10] ASoC: ipq806x: Add I2S PCM platform driver
Date: Wed, 24 Dec 2014 08:42:07 -0800
Message-ID: <1419439330-2303-8-git-send-email-kwestfie@codeaurora.org>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add PCM platform driver for the LPASS I2S port.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/lpass-pcm-mi2s.c | 486 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 486 insertions(+)
 create mode 100644 sound/soc/qcom/lpass-pcm-mi2s.c

diff --git a/sound/soc/qcom/lpass-pcm-mi2s.c b/sound/soc/qcom/lpass-pcm-mi2s.c
new file mode 100644
index 0000000000000000000000000000000000000000..7cf2ef9525388e9cad1c1b532cd6bc3b46a48b9d
--- /dev/null
+++ b/sound/soc/qcom/lpass-pcm-mi2s.c
@@ -0,0 +1,486 @@
+/*
+ * Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include "lpass-lpaif-reg.h"
+#include "lpass-mi2s.h"
+
+#define DRV_NAME			"lpass-pcm-mi2s"
+
+/* MI2S HW params */
+#define LPASS_MI2S_PERIOD_SIZE		(8064)
+#define LPASS_MI2S_PERIODS_MIN		(2)
+#define LPASS_MI2S_PERIODS_MAX		(4)
+#define LPASS_MI2S_BUFF_SIZE_MIN	(LPASS_MI2S_PERIOD_SIZE * \
+						LPASS_MI2S_PERIODS_MIN)
+#define LPASS_MI2S_BUFF_SIZE_MAX	(LPASS_MI2S_PERIOD_SIZE * \
+						LPASS_MI2S_PERIODS_MAX)
+
+static struct snd_pcm_hardware lpass_pcm_mi2s_hardware_playback = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_BLOCK_TRANSFER |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED |
+					SNDRV_PCM_INFO_PAUSE |
+					SNDRV_PCM_INFO_RESUME,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24 |
+					SNDRV_PCM_FMTBIT_S32,
+	.rates			=	SNDRV_PCM_RATE_8000_192000,
+	.rate_min		=	8000,
+	.rate_max		=	192000,
+	.channels_min		=	1,
+	.channels_max		=	8,
+	.buffer_bytes_max	=	LPASS_MI2S_BUFF_SIZE_MAX,
+	.period_bytes_max	=	LPASS_MI2S_PERIOD_SIZE,
+	.period_bytes_min	=	LPASS_MI2S_PERIOD_SIZE,
+	.periods_min		=	LPASS_MI2S_PERIODS_MIN,
+	.periods_max		=	LPASS_MI2S_PERIODS_MAX,
+	.fifo_size		=	0,
+};
+
+static inline void lpass_lpaif_int_enable(struct snd_soc_platform *platform)
+{
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(platform);
+	u32 clear_offset = LPAIF_DMAIRQ_CLEAR(LPAIF_IRQ_RECV_HOST);
+	u32 enable_offset = LPAIF_DMAIRQ_EN(LPAIF_IRQ_RECV_HOST);
+	u32 chan_bitmask = LPAIF_DMAIRQ_ALL(LPAIF_DMA_RD_CH_MI2S);
+	u32 value;
+
+	/* clear status before enabling interrupts */
+	writel(chan_bitmask, drvdata->base + clear_offset);
+
+	value = readl(drvdata->base + enable_offset);
+	value |= chan_bitmask;
+	writel(value, drvdata->base + enable_offset);
+}
+
+static inline void lpass_lpaif_int_disable(struct snd_soc_platform *platform)
+{
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(platform);
+	u32 enable_offset = LPAIF_DMAIRQ_EN(LPAIF_IRQ_RECV_HOST);
+	u32 chan_bitmask = LPAIF_DMAIRQ_ALL(LPAIF_DMA_RD_CH_MI2S);
+	u32 value;
+
+	value = readl(drvdata->base + enable_offset);
+	value &= ~chan_bitmask;
+	writel(value, drvdata->base + enable_offset);
+}
+
+static inline u32 lpass_lpaif_int_retrieve(struct snd_soc_platform *platform)
+{
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(platform);
+	u32 status_offset = LPAIF_DMAIRQ_STAT(LPAIF_IRQ_RECV_HOST);
+	u32 clear_offset = LPAIF_DMAIRQ_CLEAR(LPAIF_IRQ_RECV_HOST);
+	u32 chan_bitmask = LPAIF_DMAIRQ_ALL(LPAIF_DMA_RD_CH_MI2S);
+	u32 value;
+
+	value = readl(drvdata->base + status_offset);
+	value &= chan_bitmask;
+	writel(value, drvdata->base + clear_offset);
+
+	return value;
+}
+
+static inline int lpass_lpaif_dma_set_format(struct snd_soc_platform *platform,
+		unsigned int channels, unsigned int bitwidth)
+{
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(platform);
+	u32 dma_control_offset =  LPAIF_DMA_CTL(LPAIF_DMA_RD_CH_MI2S);
+	u32 value = 0;
+
+	value |= LPAIF_DMACTL_BURST_EN;
+	value |= LPAIF_DMACTL_AUDIO_INTF_MI2S;
+	value |= LPAIF_DMACTL_FIFO_WM_8;
+
+	switch (bitwidth) {
+	case 16:
+		switch (channels) {
+		case 1:
+		case 2:
+			value |= LPAIF_DMACTL_WPSCNT_SINGLE;
+			break;
+		case 4:
+			value |= LPAIF_DMACTL_WPSCNT_DOUBLE;
+			break;
+		case 6:
+			value |= LPAIF_DMACTL_WPSCNT_TRIPLE;
+			break;
+		case 8:
+			value |= LPAIF_DMACTL_WPSCNT_QUAD;
+			break;
+		default:
+			dev_err(platform->dev, "%s: invalid PCM config given: bw=%u, ch=%u\n",
+					__func__, bitwidth, channels);
+			return -EINVAL;
+		}
+		break;
+	case 24:
+	case 32:
+		switch (channels) {
+		case 1:
+			value |= LPAIF_DMACTL_WPSCNT_SINGLE;
+			break;
+		case 2:
+			value |= LPAIF_DMACTL_WPSCNT_DOUBLE;
+			break;
+		case 4:
+			value |= LPAIF_DMACTL_WPSCNT_QUAD;
+			break;
+		case 6:
+			value |= LPAIF_DMACTL_WPSCNT_SIXPACK;
+			break;
+		case 8:
+			value |= LPAIF_DMACTL_WPSCNT_OCTAL;
+			break;
+		default:
+			dev_err(platform->dev, "%s: invalid PCM config given: bw=%u, ch=%u\n",
+					__func__, bitwidth, channels);
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(platform->dev, "%s: invalid PCM config given: bw=%u, ch=%u\n",
+				__func__, bitwidth, channels);
+		return -EINVAL;
+	}
+
+	writel(value, drvdata->base + dma_control_offset);
+
+	return 0;
+}
+
+static inline void lpass_lpaif_dma_set_addr(struct snd_soc_platform *platform,
+		dma_addr_t src_start, size_t buffer_size, size_t period_size)
+{
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(platform);
+	u32 base_address_offset = LPAIF_DMA_BASEADDR(LPAIF_DMA_RD_CH_MI2S);
+	u32 buffer_length_offset = LPAIF_DMA_BUFFLEN(LPAIF_DMA_RD_CH_MI2S);
+	u32 period_length_offset = LPAIF_DMA_PERLEN(LPAIF_DMA_RD_CH_MI2S);
+
+	writel(src_start, drvdata->base + base_address_offset);
+	writel((buffer_size >> 2) - 1, drvdata->base + buffer_length_offset);
+	writel((period_size >> 2) - 1, drvdata->base + period_length_offset);
+}
+
+static inline void lpass_lpaif_dma_start(struct snd_soc_platform *platform)
+{
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(platform);
+	u32 dma_control_offset = LPAIF_DMA_CTL(LPAIF_DMA_RD_CH_MI2S);
+	u32 value;
+
+	value = readl(drvdata->base + dma_control_offset);
+	value |= LPAIF_DMACTL_ENABLE;
+	writel(value, drvdata->base + dma_control_offset);
+}
+
+static inline void lpass_lpaif_dma_stop(struct snd_soc_platform *platform)
+{
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(platform);
+	u32 dma_control_offset = LPAIF_DMA_CTL(LPAIF_DMA_RD_CH_MI2S);
+	u32 value;
+
+	value = readl(drvdata->base + dma_control_offset);
+	value &= ~LPAIF_DMACTL_ENABLE;
+	writel(value, drvdata->base + dma_control_offset);
+}
+
+static inline void lpass_lpaif_dma_stop_clear(struct snd_soc_platform *platform)
+{
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(platform);
+	u32 dma_control_offset = LPAIF_DMA_CTL(LPAIF_DMA_RD_CH_MI2S);
+
+	writel(0, drvdata->base + dma_control_offset);
+}
+
+static int lpass_pcm_mi2s_alloc_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size;
+
+	size = lpass_pcm_mi2s_hardware_playback.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_coherent(pcm->card->dev, size,
+			&buf->addr, GFP_KERNEL);
+	if (!buf->area) {
+		dev_err(soc_runtime->dev, "%s: Could not allocate DMA buffer\n",
+				__func__);
+		return -ENOMEM;
+	}
+	buf->bytes = size;
+
+	return 0;
+}
+
+static void lpass_pcm_mi2s_free_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+
+	substream = pcm->streams[stream].substream;
+	buf = &substream->dma_buffer;
+	if (buf->area) {
+		dma_free_coherent(pcm->card->dev, buf->bytes, buf->area,
+				buf->addr);
+	}
+	buf->area = NULL;
+}
+
+static irqreturn_t lpass_pcm_mi2s_irq(int irq, void *data)
+{
+	struct snd_pcm_substream *substream = data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	u32 xrun_bitmask = LPAIF_DMAIRQ_XRUN(LPAIF_DMA_RD_CH_MI2S);
+	u32 period_bitmask = LPAIF_DMAIRQ_PER(LPAIF_DMA_RD_CH_MI2S);
+	u32 error_bitmask = LPAIF_DMAIRQ_ERR(LPAIF_DMA_RD_CH_MI2S);
+	u32 pending;
+	irqreturn_t ret = IRQ_NONE;
+
+	pending = lpass_lpaif_int_retrieve(soc_runtime->platform);
+
+	if (unlikely(pending & xrun_bitmask) && snd_pcm_running(substream)) {
+		dev_warn(soc_runtime->dev, "%s: xrun warning\n", __func__);
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		pending &= ~xrun_bitmask;
+		ret = IRQ_HANDLED;
+	}
+
+	if (pending & period_bitmask) {
+		if (++drvdata->period_index >= runtime->periods)
+			drvdata->period_index = 0;
+		snd_pcm_period_elapsed(substream);
+		pending &= ~period_bitmask;
+		ret = IRQ_HANDLED;
+	}
+
+	if (pending & xrun_bitmask) {
+		snd_pcm_period_elapsed(substream);
+		dev_warn(soc_runtime->dev, "%s: xrun warning\n", __func__);
+		ret = IRQ_HANDLED;
+	}
+
+	if (pending & error_bitmask) {
+		dev_err(soc_runtime->dev, "%s: Bus access error\n", __func__);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static int lpass_pcm_mi2s_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	int ret;
+
+	drvdata->prepare_start = 0;
+	drvdata->period_index = 0;
+
+	runtime->dma_bytes = lpass_pcm_mi2s_hardware_playback.buffer_bytes_max;
+	snd_soc_set_runtime_hwparams(substream,
+			&lpass_pcm_mi2s_hardware_playback);
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(soc_runtime->dev,
+				"%s: snd_pcm_hw_constraint_integer failed\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	return 0;
+}
+
+static int lpass_pcm_mi2s_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	snd_pcm_format_t format = params_format(params);
+	unsigned int channels = params_channels(params);
+	int bitwidth;
+	int ret;
+
+	bitwidth = snd_pcm_format_width(format);
+	if (bitwidth < 0) {
+		dev_err(soc_runtime->dev, "%s: Invalid bit width given\n",
+				__func__);
+		return bitwidth;
+	}
+
+	ret = lpass_lpaif_dma_set_format(soc_runtime->platform, channels,
+			bitwidth);
+	if (ret) {
+		dev_err(soc_runtime->dev, "%s: Error setting DMA format\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int lpass_pcm_mi2s_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+
+	lpass_lpaif_dma_stop_clear(soc_runtime->platform);
+	lpass_lpaif_int_disable(soc_runtime->platform);
+
+	return 0;
+}
+
+static int lpass_pcm_mi2s_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+
+	/* xrun recovery */
+	if (drvdata->prepare_start)
+		return 0;
+	drvdata->prepare_start = 1;
+
+	lpass_lpaif_dma_set_addr(soc_runtime->platform, runtime->dma_addr,
+			snd_pcm_lib_buffer_bytes(substream),
+			snd_pcm_lib_period_bytes(substream));
+
+	lpass_lpaif_int_enable(soc_runtime->platform);
+	lpass_lpaif_dma_start(soc_runtime->platform);
+
+	return 0;
+}
+
+static int lpass_pcm_mi2s_mmap(struct snd_pcm_substream *substream,
+		struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	return dma_mmap_coherent(substream->pcm->card->dev, vma,
+		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+}
+
+static snd_pcm_uframes_t lpass_pcm_mi2s_pointer(
+		struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	snd_pcm_uframes_t offset;
+
+	offset = drvdata->period_index * runtime->period_size;
+
+	return offset >= (runtime->buffer_size) ? 0 : offset;
+}
+
+static struct snd_pcm_ops lpass_pcm_mi2s_soc_ops = {
+	.open		= lpass_pcm_mi2s_open,
+	.hw_params	= lpass_pcm_mi2s_hw_params,
+	.hw_free	= lpass_pcm_mi2s_hw_free,
+	.prepare	= lpass_pcm_mi2s_prepare,
+	.mmap		= lpass_pcm_mi2s_mmap,
+	.pointer	= lpass_pcm_mi2s_pointer,
+	.ioctl		= snd_pcm_lib_ioctl,
+};
+
+static int lpass_pcm_mi2s_soc_new(struct snd_soc_pcm_runtime *soc_runtime)
+{
+	struct snd_card *card = soc_runtime->card->snd_card;
+	struct snd_pcm *pcm = soc_runtime->pcm;
+	struct snd_pcm_substream *substream =
+		pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	int ret;
+
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &card->dev->coherent_dma_mask;
+
+	ret = lpass_pcm_mi2s_alloc_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
+	if (ret)
+		return ret;
+
+	ret = request_irq(drvdata->irqnum, lpass_pcm_mi2s_irq,
+			IRQF_TRIGGER_RISING, "lpass-lpaif-intr", substream);
+	if (ret) {
+		dev_err(soc_runtime->dev, "%s: irq resource request failed\n",
+				__func__);
+		goto err_buf;
+	}
+
+	/* ensure DMA hw is turned off */
+	lpass_lpaif_dma_stop_clear(soc_runtime->platform);
+	lpass_lpaif_int_disable(soc_runtime->platform);
+
+	return 0;
+
+err_buf:
+	lpass_pcm_mi2s_free_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
+	return ret;
+}
+
+static void lpass_pcm_mi2s_soc_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream =
+		pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_mi2s_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+
+	lpass_pcm_mi2s_free_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
+
+	disable_irq(drvdata->irqnum);
+	free_irq(drvdata->irqnum, NULL);
+}
+
+static struct snd_soc_platform_driver lpass_pcm_mi2s_soc_driver = {
+	.pcm_new	= lpass_pcm_mi2s_soc_new,
+	.pcm_free	= lpass_pcm_mi2s_soc_free,
+	.ops		= &lpass_pcm_mi2s_soc_ops,
+};
+
+int lpass_pcm_mi2s_platform_register(struct device *dev)
+{
+	return devm_snd_soc_register_platform(dev, &lpass_pcm_mi2s_soc_driver);
+}
+
+MODULE_DESCRIPTION("QCOM LPASS MI2S PLATFORM DRIVER");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.8.2.1
