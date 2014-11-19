From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 5/9] ASoC: ipq806x: Add I2S PCM platform
 driver
Date: Wed, 19 Nov 2014 15:10:59 -0600
Message-ID: <546D0763.7070600@linux.intel.com>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org> <1416423169-21865-6-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-6-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Bryan Huntsman <bryanh@codeaurora.org>, Mark Brown <broonie@kernel.org>, David Brown <davidb@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 11/19/14, 12:52 PM, Kenneth Westfield wrote:
> From: Kenneth Westfield <kwestfie@codeaurora.org>
>
> Add PCM platform driver for the LPASS I2S port.
>
> Change-Id: If6516fb615b16551817fd9248c1c704fe521fb32
> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
> ---
>   sound/soc/qcom/lpass-pcm-mi2s.c | 390 ++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/lpass-pcm-mi2s.h |  40 +++++
>   2 files changed, 430 insertions(+)
>   create mode 100644 sound/soc/qcom/lpass-pcm-mi2s.c
>   create mode 100644 sound/soc/qcom/lpass-pcm-mi2s.h
>
> diff --git a/sound/soc/qcom/lpass-pcm-mi2s.c b/sound/soc/qcom/lpass-pcm-mi2s.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..110b088d156c6d06cbe054920fc63fd064a0ac45
> --- /dev/null
> +++ b/sound/soc/qcom/lpass-pcm-mi2s.c
> @@ -0,0 +1,390 @@
> +/*
> + * Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/dma-mapping.h>
> +#include <sound/soc.h>
> +#include "lpass-lpaif.h"
> +#include "lpass-pcm-mi2s.h"
> +
> +#define DRV_NAME	"lpass-pcm-mi2s"
> +#define DRV_VERSION	"1.0"
> +
> +/* MI2S Hw params */
> +#define LPASS_MI2S_NO_OF_PERIODS	(65)
> +#define LPASS_MI2S_PERIOD_BYTES_MIN	(8064)
> +#define LPASS_MI2S_BUFF_SIZE		(LPASS_MI2S_PERIOD_BYTES_MIN * \
> +					LPASS_MI2S_NO_OF_PERIODS)
> +
> +static struct snd_pcm_hardware lpass_pcm_hardware_playback = {
> +	.info			=	SNDRV_PCM_INFO_MMAP |
> +					SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +					SNDRV_PCM_INFO_MMAP_VALID |
> +					SNDRV_PCM_INFO_INTERLEAVED |
> +					SNDRV_PCM_INFO_PAUSE |
> +					SNDRV_PCM_INFO_RESUME,
> +	.formats		=	SNDRV_PCM_FMTBIT_S16 |
> +					SNDRV_PCM_FMTBIT_S24 |
> +					SNDRV_PCM_FMTBIT_S32,
> +	.rates			=	SNDRV_PCM_RATE_8000_192000,
> +	.rate_min		=	8000,
> +	.rate_max		=	192000,
> +	.channels_min		=	2,
> +	.channels_max		=	8,
> +	.buffer_bytes_max	=	LPASS_MI2S_BUFF_SIZE,
> +	.period_bytes_max	=	(LPASS_MI2S_BUFF_SIZE) / 2,
> +	.period_bytes_min	=	LPASS_MI2S_PERIOD_BYTES_MIN,
> +	.periods_min		=	LPASS_MI2S_NO_OF_PERIODS,
> +	.periods_max		=	LPASS_MI2S_NO_OF_PERIODS,

Did you really mean 65 periods min and max? .periods_min is typically 
1..4, 16 in rare cases.

> +	.fifo_size		=	0,
> +};
> +
> +static int lpass_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
> +{
> +	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> +	size_t size;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		size = lpass_pcm_hardware_playback.buffer_bytes_max;
> +	} else {
> +		pr_err("%s: Invalid stream direction\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> +	buf->dev.dev = pcm->card->dev;
> +	buf->private_data = NULL;
> +	buf->area = dma_alloc_coherent(pcm->card->dev, size,
> +					&buf->addr, GFP_KERNEL);
> +	if (!buf->area) {
> +		pr_err("%s: Could not allocate DMA buffer\n", __func__);
> +		return -ENOMEM;
> +	}
> +	buf->bytes = size;
> +
> +	return 0;
> +}
> +
> +static void lpass_pcm_free_dma_buffer(struct snd_pcm *pcm, int stream)
> +{
> +	struct snd_pcm_substream *substream;
> +	struct snd_dma_buffer *buf;
> +
> +	substream = pcm->streams[stream].substream;
> +	buf = &substream->dma_buffer;
> +	if (buf->area) {
> +		dma_free_coherent(pcm->card->dev, buf->bytes,
> +					buf->area, buf->addr);
> +	}
> +	buf->area = NULL;
> +}
> +
> +static irqreturn_t lpass_pcm_mi2s_irq(int intrsrc, void *data)
> +{
> +	int dma_ch;
> +	uint32_t ret = IRQ_NONE;
> +	uint32_t has_xrun, pending;
> +
> +	struct snd_pcm_substream *substream = data;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
> +
> +	if (prtd) {
> +		dma_ch = prtd->lpaif_info.dma_ch;
> +	} else {
> +		pr_debug("%s: received interrupt w/o runtime\n", __func__);
> +		return IRQ_NONE;
> +	}
> +
> +	pending = intrsrc & (LPAIF_UNDER_CH(dma_ch) | LPAIF_PER_CH(dma_ch) |
> +				LPAIF_ERR_CH(dma_ch));
> +
> +	has_xrun = pending & LPAIF_UNDER_CH(dma_ch);
> +
> +	if (unlikely(has_xrun) && substream->runtime &&
> +			snd_pcm_running(substream)) {
> +		pr_debug("%s: xrun warning\n", __func__);
> +		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> +		pending &= ~LPAIF_UNDER_CH(dma_ch);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (pending & LPAIF_PER_CH(dma_ch)) {
> +		if (++prtd->pcm_stream_info.period_index >= runtime->periods)
> +			prtd->pcm_stream_info.period_index = 0;
> +		snd_pcm_period_elapsed(substream);
> +		pending &= ~LPAIF_PER_CH(dma_ch);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (pending & LPAIF_UNDER_CH(dma_ch)) {
> +		snd_pcm_period_elapsed(substream);
> +		pr_debug("%s: xrun warning\n", __func__);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (pending & LPAIF_ERR_CH(dma_ch)) {
> +		pr_debug("%s: Bus access warning\n", __func__);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	return ret;
> +}
> +
> +static snd_pcm_uframes_t lpass_pcm_mi2s_pointer(
> +				struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
> +	snd_pcm_uframes_t offset;
> +
> +	offset = prtd->pcm_stream_info.period_index * runtime->period_size;
> +
> +	return offset >= (runtime->buffer_size) ? 0 : offset;
> +}
> +
> +static int lpass_pcm_mi2s_mmap(struct snd_pcm_substream *substream,
> +				struct vm_area_struct *vma)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	return dma_mmap_coherent(substream->pcm->card->dev, vma,
> +		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
> +}
> +
> +static int lpass_pcm_mi2s_prepare(struct snd_pcm_substream *substream)
> +{
> +	int ret;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpaif_dai_dma_params dma_params;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
> +
> +	if (!prtd) {
> +		pr_err("%s: Error in getting runtime data\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * This is the case for under\over-run, we have already
> +	 * configured the DMA registers for this stream
> +	 */
> +	if (prtd->pcm_stream_info.pcm_prepare_start)
> +		return 0;
> +
> +	lpaif_dma_stop(prtd->lpaif_info.dma_ch);
> +	prtd->pcm_stream_info.pcm_prepare_start = 1;
> +	prtd->lpaif_info.lpa_if_dma_start = 0;
> +
> +	memset(&dma_params, 0, sizeof(dma_params));
> +	dma_params.src_start = runtime->dma_addr;
> +	dma_params.buffer_size = snd_pcm_lib_buffer_bytes(substream);
> +	dma_params.period_size = snd_pcm_lib_period_bytes(substream);
> +	dma_params.channels = runtime->channels;
> +	ret = lpaif_cfg_dma(prtd->lpaif_info.dma_ch, &dma_params,
> +					prtd->pcm_stream_info.bit_width,
> +					1 /*enable intr*/);
> +	if (ret) {
> +		pr_err("%s: Error in configuring DMA\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	lpaif_register_dma_irq_handler(prtd->lpaif_info.dma_ch,
> +					lpass_pcm_mi2s_irq, substream);
> +
> +	return 0;
> +}
> +
> +static int lpass_pcm_mi2s_close(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
> +
> +	if (prtd) {
> +		lpaif_dai_stop(prtd->lpaif_info.dma_ch);
> +		lpaif_unregister_dma_irq_handler(prtd->lpaif_info.dma_ch);
> +		kfree(prtd);
> +	}
> +
> +	return 0;
> +}
> +
> +static int lpass_pcm_mi2s_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			lpaif_cfg_i2s_playback(1, 0, LPAIF_MI2S);
> +		} else {
> +			pr_err("%s: Invalid stream direction\n", __func__);
> +			ret = -EINVAL;
> +		}
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			lpaif_cfg_i2s_playback(0, 0, LPAIF_MI2S);
> +		} else {
> +			pr_err("%s: Invalid stream direction\n", __func__);
> +			ret = -EINVAL;
> +		}
> +		break;
> +	default:
> +		pr_err("%s: Invalid trigger command given\n", __func__);
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int lpass_pcm_mi2s_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
> +
> +	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> +	prtd->pcm_stream_info.pcm_prepare_start = 0;
> +	prtd->pcm_stream_info.period_index = 0;
> +	return 0;
> +}
> +
> +static int lpass_pcm_mi2s_open(struct snd_pcm_substream *substream)
> +{
> +	int ret;
> +	struct lpass_runtime_data_t *prtd;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		runtime->dma_bytes =
> +			lpass_pcm_hardware_playback.buffer_bytes_max;
> +		snd_soc_set_runtime_hwparams(substream,
> +				&lpass_pcm_hardware_playback);
> +	} else {
> +		pr_err("%s: Invalid stream direction\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +			SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0) {
> +		pr_err("%s: snd_pcm_hw_constraint_integer failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	prtd = kzalloc(sizeof(struct lpass_runtime_data_t), GFP_KERNEL);
> +	if (prtd == NULL)
> +		return -ENOMEM;
> +
> +	prtd->pcm_stream_info.pcm_prepare_start = 0;
> +	prtd->lpaif_clk.is_bit_clk_enabled = 0;
> +	prtd->lpaif_clk.is_osr_clk_enabled = 0;
> +	prtd->lpaif_info.dma_ch = LPAIF_MI2S_DMA_RD_CH;
> +
> +	prtd->pcm_stream_info.substream = substream;
> +	runtime->private_data = prtd;
> +
> +	return 0;
> +}
> +
> +static struct snd_pcm_ops lpass_asoc_pcm_mi2s_ops = {
> +	.open		= lpass_pcm_mi2s_open,
> +	.hw_params	= lpass_pcm_mi2s_hw_params,
> +	.trigger	= lpass_pcm_mi2s_trigger,
> +	.ioctl		= snd_pcm_lib_ioctl,
> +	.close		= lpass_pcm_mi2s_close,
> +	.prepare	= lpass_pcm_mi2s_prepare,
> +	.mmap		= lpass_pcm_mi2s_mmap,
> +	.pointer	= lpass_pcm_mi2s_pointer,
> +};
> +
> +static void lpass_asoc_pcm_mi2s_free(struct snd_pcm *pcm)
> +{
> +	lpass_pcm_free_dma_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
> +}
> +
> +static int lpass_asoc_pcm_mi2s_new(struct snd_soc_pcm_runtime *prtd)
> +{
> +	struct snd_card *card = prtd->card->snd_card;
> +	struct snd_pcm *pcm = prtd->pcm;
> +	int ret = 0;
> +
> +	if (!card->dev->coherent_dma_mask)
> +		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +
> +	if (!card->dev->dma_mask)
> +		card->dev->dma_mask = &card->dev->coherent_dma_mask;
> +
> +	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
> +		ret = lpass_pcm_preallocate_dma_buffer(pcm,
> +				SNDRV_PCM_STREAM_PLAYBACK);
> +	} else {
> +		pr_err("%s: Invalid stream direction\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct snd_soc_platform_driver lpass_asoc_pcm_mi2s_platform = {
> +	.ops		= &lpass_asoc_pcm_mi2s_ops,
> +	.pcm_new	= lpass_asoc_pcm_mi2s_new,
> +	.pcm_free	= lpass_asoc_pcm_mi2s_free,
> +};
> +
> +static int lpass_pcm_mi2s_driver_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = snd_soc_register_platform(&pdev->dev,
> +			&lpass_asoc_pcm_mi2s_platform);
> +	if (ret)
> +		dev_err(&pdev->dev, "%s: Failed to register pcm device: %d\n",
> +				__func__, ret);
> +
> +	return ret;
> +}
> +
> +static int lpass_pcm_mi2s_driver_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_platform(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id lpass_pcm_mi2s_dt_match[] = {
> +	{ .compatible = "qcom,lpass-pcm-mi2s", },
> +	{}
> +};
> +
> +static struct platform_driver lpass_pcm_mi2s_driver = {
> +	.driver	= {
> +		.name	= DRV_NAME,
> +		.owner	= THIS_MODULE,
> +		.of_match_table = lpass_pcm_mi2s_dt_match,
> +	},
> +	.probe	= lpass_pcm_mi2s_driver_probe,
> +	.remove	= lpass_pcm_mi2s_driver_remove,
> +};
> +module_platform_driver(lpass_pcm_mi2s_driver);
> +
> +MODULE_DESCRIPTION("LPASS PCM MI2S Platform Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_DEVICE_TABLE(of, lpass_pcm_mi2s_dt_match);
> +MODULE_VERSION(DRV_VERSION);
> diff --git a/sound/soc/qcom/lpass-pcm-mi2s.h b/sound/soc/qcom/lpass-pcm-mi2s.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..edd43c4d419d1999babe20d4e6f58c77df38c6e1
> --- /dev/null
> +++ b/sound/soc/qcom/lpass-pcm-mi2s.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (c) 2014 The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _LPASS_PCM_MI2S_H
> +#define _LPAS_PCM_MI2S_H
> +
> +struct lpass_pcm_stream_t {
> +	uint8_t pcm_prepare_start;
> +	uint32_t period_index;
> +	struct snd_pcm_substream *substream;
> +	uint32_t bit_width;
> +};
> +
> +struct lpass_lpaif_t {
> +	uint8_t lpa_if_dma_start;
> +	uint8_t dma_ch;
> +};
> +
> +struct lpass_lpaif_clk_t {
> +	uint8_t is_bit_clk_enabled;
> +	uint8_t is_osr_clk_enabled;
> +};
> +
> +struct lpass_runtime_data_t {
> +	struct lpass_pcm_stream_t pcm_stream_info;
> +	struct lpass_lpaif_t lpaif_info;
> +	struct lpass_lpaif_clk_t lpaif_clk;
> +};
> +
> +#endif /* _LPASS_PCM_MI2S_H */
>
