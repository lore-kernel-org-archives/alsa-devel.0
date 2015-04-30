From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090
Date: Thu, 30 Apr 2015 10:06:52 +0530
Message-ID: <20150430043651.GJ3521@localhost>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 746102612AF
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 06:36:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, praveen.k.jain@intel.com, praveen.diwakar@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, broonie@kernel.org, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2015 at 06:43:56PM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
> 
> Add machine driver for two Intel Cherryview-based platforms, Cherrytrail
> and Braswell, with max98090 codec.
> 
> Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> ---
>  sound/soc/intel/Kconfig                   |   12 ++
>  sound/soc/intel/boards/Makefile           |    2 +
>  sound/soc/intel/boards/cht_bsw_max98090.c |  286 +++++++++++++++++++++++++++++
>  3 files changed, 300 insertions(+)
>  create mode 100644 sound/soc/intel/boards/cht_bsw_max98090.c
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index c181a6a..5789a07 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -121,3 +121,15 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
>  	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
>  	  platforms with RT5645/5650 audio codec.
>  	  If unsure select "N".
> +
> +config SND_SOC_INTEL_CHT_BSW_MAX98090_MACH
> +	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 codec"
> +	depends on X86_INTEL_LPSS
> +	select SND_SOC_MAX98090
> +	select SND_SOC_TS3A227E
> +	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_IPC_ACPI
> +	help
> +      This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
> +      platforms with MAX98090 audio codec.
> +      If unsure select "N".
> diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
> index f8237f0..51ec4d1 100644
> --- a/sound/soc/intel/boards/Makefile
> +++ b/sound/soc/intel/boards/Makefile
> @@ -5,6 +5,7 @@ snd-soc-sst-broadwell-objs := broadwell.o
>  snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
>  snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
>  snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
> +snd-soc-sst-cht-bsw-max98090-objs := cht_bsw_max98090.o
>  
>  obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
>  obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
> @@ -13,3 +14,4 @@ obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
>  obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
>  obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
>  obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
> +obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_MACH) += snd-soc-sst-cht-bsw-max98090.o
> diff --git a/sound/soc/intel/boards/cht_bsw_max98090.c b/sound/soc/intel/boards/cht_bsw_max98090.c
> new file mode 100644
> index 0000000..ccbbbc5
> --- /dev/null
> +++ b/sound/soc/intel/boards/cht_bsw_max98090.c
> @@ -0,0 +1,286 @@
> +/*
> + *  cht-bsw-max98090.c - ASoc Machine driver for Intel Cherryview-based
> + *  platforms Cherrytrail and Braswell, with max98090 codec.
> + *
> + *  Copyright (C) 2015 Intel Corp
> + *  Author: Fang, Yang A <yang.a.fang@intel.com>
> + *  This file is modified from cht_bsw_rt5645.c
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/jack.h>
> +#include "../../codecs/max98090.h"
> +#include "../atom/sst-atom-controls.h"
> +#include "../../codecs/ts3a227e.h"
> +
> +#define CHT_PLAT_CLK_3_HZ	19200000
> +#define CHT_CODEC_DAI	"HiFi"
> +
> +struct cht_mc_private {
> +	struct snd_soc_jack jack;
> +};
> +
> +static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
> +{
> +	int i;
> +
> +	for (i = 0; i < card->num_rtd; i++) {
> +		struct snd_soc_pcm_runtime *rtd;
> +
> +		rtd = card->rtd + i;
> +		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
> +			     strlen(CHT_CODEC_DAI)))
> +			return rtd->codec_dai;
> +	}
> +	return NULL;
> +}
> +
> +static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone", NULL),
> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +	SND_SOC_DAPM_MIC("Int Mic", NULL),
> +	SND_SOC_DAPM_SPK("Ext Spk", NULL),
> +};
> +
> +static const struct snd_soc_dapm_route cht_audio_map[] = {
> +	{"IN34", NULL, "Headset Mic"},
> +	{"Headset Mic", NULL, "MICBIAS"},
> +	{"DMICL", NULL, "Int Mic"},
> +	{"Headphone", NULL, "HPL"},
> +	{"Headphone", NULL, "HPR"},
> +	{"Ext Spk", NULL, "SPKL"},
> +	{"Ext Spk", NULL, "SPKR"},
> +	{"AIF1 Playback", NULL, "ssp2 Tx"},
> +	{"ssp2 Tx", NULL, "codec_out0"},
> +	{"ssp2 Tx", NULL, "codec_out1"},
> +	{"codec_in0", NULL, "ssp2 Rx" },
> +	{"codec_in1", NULL, "ssp2 Rx" },
> +	{"ssp2 Rx", NULL, "AIF1 Capture"},
> +};
> +
> +static const struct snd_kcontrol_new cht_mc_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Headphone"),
> +	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +	SOC_DAPM_PIN_SWITCH("Int Mic"),
> +	SOC_DAPM_PIN_SWITCH("Ext Spk"),
> +};
> +
> +static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, M98090_REG_SYSTEM_CLOCK,
> +				     CHT_PLAT_CLK_3_HZ, SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	int ret;
> +	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
> +	struct snd_soc_jack *jack = &ctx->jack;
> +
> +	ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
> +				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
> +				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +				SND_JACK_BTN_2 | SND_JACK_BTN_3, jack, NULL, 0);
Do you really support all those buttons?

> +
> +	if (ret) {
> +		dev_err(runtime->dev, "Headset Jack creation failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
> +			    struct snd_pcm_hw_params *params)
> +{
> +	struct snd_interval *rate = hw_param_interval(params,
> +			SNDRV_PCM_HW_PARAM_RATE);
> +	struct snd_interval *channels = hw_param_interval(params,
> +						SNDRV_PCM_HW_PARAM_CHANNELS);
> +	int ret = 0;
> +	unsigned int fmt = 0;
> +
> +	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 16);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set cpu_dai slot fmt: %d\n", ret);
> +		return ret;
> +	}
> +
> +	fmt = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF
> +				| SND_SOC_DAIFMT_CBS_CFS;
> +
> +	ret = snd_soc_dai_set_fmt(rtd->cpu_dai, fmt);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set cpu_dai set fmt: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
> +	rate->min = rate->max = 48000;
> +	channels->min = channels->max = 2;
> +
> +	/* set SSP2 to 24-bit */
> +	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
> +				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
> +				    SNDRV_PCM_FORMAT_S24_LE);
> +	return 0;
> +}
> +
> +static unsigned int rates_48000[] = {
> +	48000,
> +};
> +
> +static struct snd_pcm_hw_constraint_list constraints_48000 = {
> +	.count = ARRAY_SIZE(rates_48000),
> +	.list  = rates_48000,
> +};
> +
> +static int cht_aif1_startup(struct snd_pcm_substream *substream)
> +{
> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> +			SNDRV_PCM_HW_PARAM_RATE,
> +			&constraints_48000);
> +}
> +
> +static int cht_max98090_headset_init(struct snd_soc_component *component)
> +{
> +	struct snd_soc_card *card = component->card;
> +	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
> +
> +	return ts3a227e_enable_jack_detect(component, &ctx->jack);
> +}
> +
> +static struct snd_soc_ops cht_aif1_ops = {
> +	.startup = cht_aif1_startup,
> +};
> +
> +static struct snd_soc_ops cht_be_ssp2_ops = {
> +	.hw_params = cht_aif1_hw_params,
> +};
> +
> +static struct snd_soc_aux_dev cht_max98090_headset_dev = {
> +	.name = "Headset Chip",
> +	.init = cht_max98090_headset_init,
> +	.codec_name = "i2c-104C227E:00",
> +};
> +
> +static struct snd_soc_dai_link cht_dailink[] = {
> +	[MERR_DPCM_AUDIO] = {
> +		.name = "Audio Port",
> +		.stream_name = "Audio",
> +		.cpu_dai_name = "media-cpu-dai",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.codec_name = "snd-soc-dummy",
> +		.platform_name = "sst-mfld-platform",
> +		.nonatomic = true,
> +		.dynamic = 1,
> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +		.ops = &cht_aif1_ops,
> +	},
> +	[MERR_DPCM_COMPR] = {
> +		.name = "Compressed Port",
> +		.stream_name = "Compress",
> +		.cpu_dai_name = "compress-cpu-dai",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.codec_name = "snd-soc-dummy",
> +		.platform_name = "sst-mfld-platform",
> +	},
> +	/* back ends */
> +	{
> +		.name = "SSP2-Codec",
> +		.be_id = 1,
> +		.cpu_dai_name = "ssp2-port",
> +		.platform_name = "sst-mfld-platform",
> +		.no_pcm = 1,
> +		.codec_dai_name = "HiFi",
> +		.codec_name = "i2c-193C9890:00",
> +		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> +					| SND_SOC_DAIFMT_CBS_CFS,
> +		.init = cht_codec_init,
> +		.be_hw_params_fixup = cht_codec_fixup,
> +		.nonatomic = true,
this doesnt make sense for BEs

-- 
~Vinod

> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +		.ops = &cht_be_ssp2_ops,
> +	},
> +};
> +
> +/* SoC card */
> +static struct snd_soc_card snd_soc_card_cht = {
> +	.name = "chtmax98090",
> +	.dai_link = cht_dailink,
> +	.num_links = ARRAY_SIZE(cht_dailink),
> +	.aux_dev = &cht_max98090_headset_dev,
> +	.num_aux_devs = 1,
> +	.dapm_widgets = cht_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(cht_dapm_widgets),
> +	.dapm_routes = cht_audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(cht_audio_map),
> +	.controls = cht_mc_controls,
> +	.num_controls = ARRAY_SIZE(cht_mc_controls),
> +};
> +
> +static int snd_cht_mc_probe(struct platform_device *pdev)
> +{
> +	int ret_val = 0;
> +	struct cht_mc_private *drv;
> +
> +	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	/* register the soc card */
> +	snd_soc_card_cht.dev = &pdev->dev;
> +	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
> +	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
> +	if (ret_val) {
> +		dev_err(&pdev->dev,
> +			"snd_soc_register_card failed %d\n", ret_val);
> +		return ret_val;
> +	}
> +	platform_set_drvdata(pdev, &snd_soc_card_cht);
> +	return ret_val;
> +}
> +
> +static struct platform_driver snd_cht_mc_driver = {
> +	.driver = {
> +		.name = "cht-bsw-max98090",
> +	},
> +	.probe = snd_cht_mc_probe,
> +};
> +
> +module_platform_driver(snd_cht_mc_driver)
> +
> +MODULE_DESCRIPTION("ASoC Intel(R) Braswell Machine driver");
> +MODULE_AUTHOR("Fang, Yang A <yang.a.fang@intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:cht-bsw-max98090");
> -- 
> 1.7.9.5
> 

-- 
