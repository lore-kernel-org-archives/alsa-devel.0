From: "Kenneth Westfield" <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: ipq806x: Add LPASS CPU DAI
 driver
Date: Fri, 21 Nov 2014 12:23:19 -0800
Message-ID: <5c20d259aa658a6f6407520c5f2e09ec.squirrel@www.codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
    <1416423169-21865-5-git-send-email-kwestfie@codeaurora.org>
    <546D08D2.5030808@linux.intel.com>
Reply-To: kwestfie@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <546D08D2.5030808@linux.intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Bryan Huntsman <bryanh@codeaurora.org>, Mark Brown <broonie@kernel.org>, David Brown <davidb@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, November 19, 2014 1:17 pm, Pierre-Louis Bossart wrote:

> On 11/19/14, 12:52 PM, Kenneth Westfield wrote:
>> From: Kenneth Westfield <kwestfie@codeaurora.org>
>>
>> Add the CPU DAI driver for the QCOM LPASS SOC.
>>
>> Change-Id: I64ac4407dd32bb9a3066d4b7427292002eaf5d14
>> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
>> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
>> ---
>>   sound/soc/qcom/lpass-cpu-dai.c | 307 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 307 insertions(+)
>>   create mode 100644 sound/soc/qcom/lpass-cpu-dai.c
>>
>> diff --git a/sound/soc/qcom/lpass-cpu-dai.c b/sound/soc/qcom/lpass-cpu-dai.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..0693e761e01fd416f52684977bcfaf1579dc259c
>> --- /dev/null
>> +++ b/sound/soc/qcom/lpass-cpu-dai.c
>> @@ -0,0 +1,307 @@
>> +/*
>> + * Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/clk.h>
>> +#include <sound/soc.h>
>> +#include <sound/pcm_params.h>
>> +#include "lpass-lpaif.h"
>> +#include "lpass-pcm-mi2s.h"
>> +
>> +#define DRV_NAME	"lpass-cpu-dai"
>> +#define DRV_VERSION	"1.0"
>> +
>> +#define LPASS_INVALID	(-1)
>> +
>> +struct mi2s_hw_params {
>> +	uint8_t channels;
>> +	uint32_t freq;
>> +	uint8_t bit_width;
>> +};
>> +
>> +static struct clk *lpaif_mi2s_bit_clk;
>> +static struct clk *lpaif_mi2s_osr_clk;
>> +static struct mi2s_hw_params mi2s_params;
>> +
>> +/*
>> + * Returns the OSR to BIT clock divider that would be used with the given
>> + * stream characteristics.
>> + */
>> +static uint32_t lpass_cpu_get_bit_div(uint32_t samp_freq, uint32_t bit_width,
>> +							uint32_t channels)
>> +{
>> +	if (channels == 8) {
>> +		if (bit_width == 24 &&
>> +			((samp_freq != 176400) &&
>> +			(samp_freq != 192000)))
>> +			return 2;
>> +		return 1;
>> +	} else if (channels == 6) {
>> +		if ((bit_width == 32 && ((samp_freq == 176400) ||
>> +			(samp_freq == 192000))) || (bit_width == 24 &&
>> +			(samp_freq == 192000)))
>> +			return 1;
>> +		else
>> +			return 2;
>> +	}
>> +
>> +	switch (samp_freq) {
>> +	case 8000:
>> +	case 16000:
>> +	case 32000:
>> +	case 64000:
>> +		if (bit_width == 16)
>> +			return 4;
>
> Does this test have any value? the behavior is identical in all cases.
>
>> +		break;
>> +	case 48000:
>> +		if (bit_width == 24)
>> +			return 4;
>
> same.
>
>> +		break;
>> +	case 96000:
>> +	case 192000:
>> +		return 4;
>> +	case 176400:
>> +		return 2;
>> +	case 11025:
>> +	case 22050:
>> +	case 44100:
>> +	case 88200:
>> +	default:
>> +		pr_err("%s: Invalid PCM format given\n", __func__);
>> +		return LPASS_INVALID;
>> +	}
>> +
>> +	return 4;
>> +}
>> +
>> +static int lpass_cpu_mi2s_hw_params(struct snd_pcm_substream *substream,
>> +					struct snd_pcm_hw_params *params,
>> +					struct snd_soc_dai *dai)
>> +{
>> +	uint32_t ret = 0;
>> +	uint32_t bit_act;
>> +	uint16_t bit_div;
>> +	uint32_t bit_width = params_format(params);
>> +	uint32_t channels = params_channels(params);
>> +	uint32_t rate = params_rate(params);
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
>> +	struct mi2s_hw_params curr_params;
>> +
>> +	bit_act = snd_pcm_format_width(bit_width);
>> +	if (bit_act == LPASS_INVALID) {
>> +		dev_err(dai->dev, "%s: Invalid bit width given\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	prtd->pcm_stream_info.bit_width = bit_act;
>> +	curr_params.freq = rate;
>> +	curr_params.channels = channels;
>> +	curr_params.bit_width = bit_act;
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		/* disable SPKR to make sure it will start in sane state */
>> +		lpaif_cfg_i2s_playback(0, 0, LPAIF_MI2S);
>> +
>> +		/*
>> +		 * Set channel info, it will take effect only if SPKR is
>> +		 * enabled
>> +		 */
>> +		ret = lpaif_cfg_mi2s_playback_hwparams_channels(channels,
>> +						LPAIF_MI2S, bit_act);
>> +	} else {
>> +		dev_err(dai->dev, "%s: Invalid stream direction\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Make sure our channel setting was success */
>> +	if (ret) {
>> +		/* shutdown would be called where we restore stuff */
>> +		dev_err(dai->dev, "%s: Channel setting unsuccessful\n",
>> +				__func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	mi2s_params.freq = rate;
>> +	mi2s_params.channels = channels;
>> +	mi2s_params.bit_width = bit_act;
>> +
>> +	ret = lpaif_cfg_mi2s_hwparams_bit_width(bit_width, LPAIF_MI2S);
>> +	if (ret) {
>> +		dev_err(dai->dev, "%s: Could not set bit width in HW\n",
>> +				__func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	bit_div = lpass_cpu_get_bit_div(rate, bit_act, channels);
>> +	if (bit_div == LPASS_INVALID) {
>> +		dev_err(dai->dev, "%s: Could not get bit clk divider\n",
>> +				__func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = clk_set_rate(lpaif_mi2s_osr_clk,
>> +		(rate * bit_act * channels * bit_div));
>> +	if (ret) {
>> +		dev_err(dai->dev, "%s: error in setting mi2s osr clk\n",
>> +				__func__);
>> +		return ret;
>> +	}
>> +	ret = clk_prepare_enable(lpaif_mi2s_osr_clk);
>> +	if (ret) {
>> +		dev_err(dai->dev, "%s: error in enabling mi2s osr clk\n",
>> +				__func__);
>> +		return ret;
>> +	}
>> +	prtd->lpaif_clk.is_osr_clk_enabled = 1;
>> +
>> +	ret = clk_set_rate(lpaif_mi2s_bit_clk, rate * bit_act * channels);
>> +	if (ret) {
>> +		dev_err(dai->dev, "%s: error in setting mi2s bit clk\n",
>> +				__func__);
>> +		return ret;
>> +	}
>> +	ret = clk_prepare_enable(lpaif_mi2s_bit_clk);
>> +	if (ret) {
>> +		dev_err(dai->dev, "%s: error in enabling mi2s bit clk\n",
>> +				__func__);
>> +		return ret;
>> +	}
>> +	prtd->lpaif_clk.is_bit_clk_enabled = 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int lpass_cpu_mi2s_prepare(struct snd_pcm_substream *substream,
>> +					struct snd_soc_dai *dai)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int lpass_cpu_mi2s_startup(struct snd_pcm_substream *substream,
>> +					struct snd_soc_dai *dai)
>> +{
>> +
>> +	lpaif_mi2s_osr_clk = clk_get(dai->dev, "mi2s_osr_clk");
>> +	if (IS_ERR(lpaif_mi2s_osr_clk)) {
>> +		dev_err(dai->dev, "%s: Error in getting mi2s_osr_clk\n",
>> +				__func__);
>> +		return PTR_ERR(lpaif_mi2s_osr_clk);
>> +	}
>> +
>> +	lpaif_mi2s_bit_clk = clk_get(dai->dev, "mi2s_bit_clk");
>> +	if (IS_ERR(lpaif_mi2s_bit_clk)) {
>> +		dev_err(dai->dev, "%s: Error in getting mi2s_bit_clk\n",
>> +				__func__);
>> +		return PTR_ERR(lpaif_mi2s_bit_clk);
>> +	}
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		lpaif_cfg_i2s_playback(0, 0, LPAIF_MI2S);
>> +	} else {
>> +		dev_err(dai->dev, "%s: Invalid stream direction\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void lpass_cpu_mi2s_shutdown(struct snd_pcm_substream *substream,
>> +					struct snd_soc_dai *dai)
>> +{
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
>> +
>> +	if (prtd->lpaif_clk.is_osr_clk_enabled)
>> +		clk_disable_unprepare(lpaif_mi2s_osr_clk);
>> +	clk_put(lpaif_mi2s_osr_clk);
>> +
>> +	if (prtd->lpaif_clk.is_bit_clk_enabled)
>> +		clk_disable_unprepare(lpaif_mi2s_bit_clk);
>> +	clk_put(lpaif_mi2s_bit_clk);
>> +}
>> +
>> +static int lpass_cpu_mi2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct snd_soc_dai_ops lpass_cpu_mi2s_ops = {
>> +	.startup	= lpass_cpu_mi2s_startup,
>> +	.prepare	= lpass_cpu_mi2s_prepare,
>> +	.hw_params	= lpass_cpu_mi2s_hw_params,
>> +	.shutdown	= lpass_cpu_mi2s_shutdown,
>> +	.set_fmt	= lpass_cpu_mi2s_set_fmt,
>> +};
>> +
>> +static struct snd_soc_dai_driver lpass_cpu_dais[] = {
>> +	{
>> +		.playback = {
>> +			.rates		= SNDRV_PCM_RATE_8000_192000,
>> +			.formats	= SNDRV_PCM_FMTBIT_S16 |
>> +					SNDRV_PCM_FMTBIT_S24 |
>> +					SNDRV_PCM_FMTBIT_S32,
>> +			.channels_min	= 2,
>> +			.channels_max	= 2,
>> +			.rate_min	= 8000,
>> +			.rate_max	= 192000,
>> +		},
>> +		.ops    = &lpass_cpu_mi2s_ops,
>> +		.name = "lpass-mi2s-dai"
>> +	},
>> +};
>> +
>> +static const struct snd_soc_component_driver lpass_cpu_component = {
>> +	.name           = DRV_NAME,
>> +};
>> +
>> +static int lpass_cpu_dai_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +
>> +	ret = snd_soc_register_component(&pdev->dev, &lpass_cpu_component,
>> +			lpass_cpu_dais, ARRAY_SIZE(lpass_cpu_dais));
>> +	if (ret)
>> +		dev_err(&pdev->dev, "%s: error registering soc dais\n",
>> +				__func__);
>> +
>> +	return ret;
>> +}
>> +
>> +static int lpass_cpu_dai_remove(struct platform_device *pdev)
>> +{
>> +	snd_soc_unregister_component(&pdev->dev);
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id lpass_cpu_dai_dt_match[] = {
>> +	{.compatible = "qcom,lpass-cpu-dai"},
>> +	{}
>> +};
>> +
>> +static struct platform_driver lpass_cpu_dai_driver = {
>> +	.probe	= lpass_cpu_dai_probe,
>> +	.remove	= lpass_cpu_dai_remove,
>> +	.driver	= {
>> +		.name	= DRV_NAME,
>> +		.owner	= THIS_MODULE,
>> +		.of_match_table = lpass_cpu_dai_dt_match,
>> +	},
>> +};
>> +module_platform_driver(lpass_cpu_dai_driver);
>> +
>> +MODULE_DESCRIPTION("QCOM LPASS CPU DAI DRIVER");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:" DRV_NAME);
>> +MODULE_DEVICE_TABLE(of, lpass_cpu_dai_dt_match);
>> +MODULE_VERSION(DRV_VERSION);
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thank you for your comments.  I will separately address each comment shortly.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
