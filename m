From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/3] ASoC: Intel:
 kbl_da7219_max98357a_rt5660: Add a new codec rt5660
Date: Thu, 6 Dec 2018 09:08:04 -0600
Message-ID: <b0ff8dad-554a-2117-def3-e2ae880b3cc3@linux.intel.com>
References: <20181206145207.4477-1-hui.wang@canonical.com>
 <20181206145207.4477-2-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E608267BBB
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 16:08:08 +0100 (CET)
In-Reply-To: <20181206145207.4477-2-hui.wang@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, naveen.m@intel.com
List-Id: alsa-devel@alsa-project.org

On 12/6/18 8:52 AM, Hui Wang wrote:
> The new Dell IoT platform uses kabylake + alc3277 codec, and alc3277
> shares the driver with the codec rt5660, here we choose the
> closest machine driver kbl_da7219_max98357a, and based on this driver,
> we add a new codec rt5660 to it.
> 
> The audio design on this IoT platform is as below:
>   - Intel kabylake platform
>   - connect the codec ALC3277 via SSP0
>   - line-out and line-in with Micbias jacks
>   - line-out mute control and jack detection of line-out and line-in
>   - two HDMI ports with audio capability

I am not sure it makes sense to stuff the rt5660 support in a machine 
driver that's meant mostly for Chromebooks, and I am not sure why you 
picked this one specifically.
Since there is no reuse of the DA7219, DMIC or MAX98357a, I would argue 
that you want to define a new machine driver so that you only select and 
compile in what you need, not to mention that it'll be easier to 
maintain, both for upstream and for Chrome backports.
Thanks!
-Pierre

> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   sound/soc/intel/boards/Kconfig                |   7 +-
>   sound/soc/intel/boards/Makefile               |   4 +-
>   ...98357a.c => kbl_da7219_max98357a_rt5660.c} | 229 +++++++++++++++++-
>   .../intel/common/soc-acpi-intel-kbl-match.c   |   5 +
>   4 files changed, 237 insertions(+), 8 deletions(-)
>   rename sound/soc/intel/boards/{kbl_da7219_max98357a.c => kbl_da7219_max98357a_rt5660.c} (69%)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index b177db2a0dbb..a8db896c0760 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -268,16 +268,17 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
>             Say Y or m if you have such a device. This is a recommended option.
>             If unsure select "N".
>   
> -config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
> -	tristate "KBL with DA7219 and MAX98357A in I2S Mode"
> +config SND_SOC_INTEL_KBL_DA7219_MAX98357A_RT5660_MACH
> +	tristate "KBL with DA7219, MAX98357A and RT5660 in I2S Mode"
>   	depends on MFD_INTEL_LPSS && I2C && ACPI
>   	select SND_SOC_DA7219
>   	select SND_SOC_MAX98357A
> +	select SND_SOC_RT5660
>   	select SND_SOC_DMIC
>   	select SND_SOC_HDAC_HDMI
>   	help
>   	  This adds support for ASoC Onboard Codec I2S machine driver. This will
> -	  create an alsa sound card for DA7219 + MAX98357A I2S audio codec.
> +	  create an alsa sound card for DA7219 + MAX98357A and RT5660 I2S audio codec.
>   	  Say Y if you have such a device.
>   
>   config SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH
> diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
> index 5381e27df9cc..ec668cf4389e 100644
> --- a/sound/soc/intel/boards/Makefile
> +++ b/sound/soc/intel/boards/Makefile
> @@ -16,7 +16,7 @@ snd-soc-sst-cht-bsw-nau8824-objs := cht_bsw_nau8824.o
>   snd-soc-sst-byt-cht-da7213-objs := bytcht_da7213.o
>   snd-soc-sst-byt-cht-es8316-objs := bytcht_es8316.o
>   snd-soc-sst-byt-cht-nocodec-objs := bytcht_nocodec.o
> -snd-soc-kbl_da7219_max98357a-objs := kbl_da7219_max98357a.o
> +snd-soc-kbl_da7219_max98357a_rt5660-objs := kbl_da7219_max98357a_rt5660.o
>   snd-soc-kbl_da7219_max98927-objs := kbl_da7219_max98927.o
>   snd-soc-kbl_rt5663_max98927-objs := kbl_rt5663_max98927.o
>   snd-soc-kbl_rt5663_rt5514_max98927-objs := kbl_rt5663_rt5514_max98927.o
> @@ -42,7 +42,7 @@ obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH) += snd-soc-sst-cht-bsw-nau8824.
>   obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH) += snd-soc-sst-byt-cht-da7213.o
>   obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH) += snd-soc-sst-byt-cht-es8316.o
>   obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH) += snd-soc-sst-byt-cht-nocodec.o
> -obj-$(CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH) += snd-soc-kbl_da7219_max98357a.o
> +obj-$(CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_RT5660_MACH) += snd-soc-kbl_da7219_max98357a_rt5660.o
>   obj-$(CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH) += snd-soc-kbl_da7219_max98927.o
>   obj-$(CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH) += snd-soc-kbl_rt5663_max98927.o
>   obj-$(CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH) += snd-soc-kbl_rt5663_rt5514_max98927.o
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a_rt5660.c
> similarity index 69%
> rename from sound/soc/intel/boards/kbl_da7219_max98357a.c
> rename to sound/soc/intel/boards/kbl_da7219_max98357a_rt5660.c
> index 38f6ab74709d..6ac8163d4c35 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98357a_rt5660.c
> @@ -2,7 +2,7 @@
>   // Copyright(c) 2017-18 Intel Corporation.
>   
>   /*
> - * Intel Kabylake I2S Machine Driver with MAX98357A & DA7219 Codecs
> + * Intel Kabylake I2S Machine Driver with MAX98357A & DA7219 & RT5660 Codecs
>    *
>    * Modified from:
>    *   Intel Kabylake I2S Machine driver supporting MAXIM98927 and
> @@ -12,6 +12,7 @@
>   #include <linux/input.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
>   #include <sound/core.h>
>   #include <sound/jack.h>
>   #include <sound/pcm.h>
> @@ -21,8 +22,10 @@
>   #include "../../codecs/hdac_hdmi.h"
>   #include "../skylake/skl.h"
>   #include "../../codecs/da7219-aad.h"
> +#include "../../codecs/rt5660.h"
>   
>   #define KBL_DIALOG_CODEC_DAI "da7219-hifi"
> +#define KBL_RT5660_CODEC_DAI "rt5660-aif1"
>   #define KBL_MAXIM_CODEC_DAI "HiFi"
>   #define MAXIM_DEV0_NAME "MX98357A:00"
>   #define DUAL_CHANNEL 2
> @@ -39,6 +42,7 @@ struct kbl_hdmi_pcm {
>   
>   struct kbl_codec_private {
>   	struct snd_soc_jack kabylake_headset;
> +	struct gpio_desc *gpio_lo_mute;
>   	struct list_head hdmi_pcm_list;
>   };
>   
> @@ -137,6 +141,50 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
>   	{ "Headset Mic", NULL, "Platform Clock" },
>   };
>   
> +static int kabylake_5660_event_lineout(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *k, int event)
> +{
> +	struct snd_soc_dapm_context *dapm = w->dapm;
> +	struct kbl_codec_private *priv = snd_soc_card_get_drvdata(dapm->card);
> +
> +	gpiod_set_value_cansleep(priv->gpio_lo_mute,
> +			!(SND_SOC_DAPM_EVENT_ON(event)));
> +
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new kabylake_rt5660_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Line In"),
> +	SOC_DAPM_PIN_SWITCH("Line Out"),
> +};
> +
> +static const struct snd_soc_dapm_widget kabylake_rt5660_widgets[] = {
> +	SND_SOC_DAPM_MIC("Line In", NULL),
> +	SND_SOC_DAPM_LINE("Line Out", kabylake_5660_event_lineout),
> +	SND_SOC_DAPM_SPK("DP", NULL),
> +	SND_SOC_DAPM_SPK("HDMI", NULL),
> +};
> +
> +static const struct snd_soc_dapm_route kabylake_rt5660_map[] = {
> +	/* other jacks */
> +	{"IN1P", NULL, "Line In"},
> +	{"IN2P", NULL, "Line In"},
> +	{"Line Out", NULL, "LOUTR"},
> +	{"Line Out", NULL, "LOUTL"},
> +
> +	/* CODEC BE connections */
> +	{ "AIF1 Playback", NULL, "ssp0 Tx"},
> +	{ "ssp0 Tx", NULL, "codec0_out"},
> +
> +	{ "codec0_in", NULL, "ssp0 Rx" },
> +	{ "ssp0 Rx", NULL, "AIF1 Capture" },
> +
> +	{ "hifi2", NULL, "iDisp2 Tx"},
> +	{ "iDisp2 Tx", NULL, "iDisp2_out"},
> +	{ "hifi1", NULL, "iDisp1 Tx"},
> +	{ "iDisp1 Tx", NULL, "iDisp1_out"},
> +};
> +
>   static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
>   			struct snd_pcm_hw_params *params)
>   {
> @@ -157,6 +205,94 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
>   	return 0;
>   }
>   
> +#define GPIO_LINEOUT_MUTE_INDEX 0
> +#define GPIO_LINEOUT_DET_INDEX 3
> +#define GPIO_LINEIN_DET_INDEX 4
> +
> +static const struct acpi_gpio_params lineout_mute_gpio = { GPIO_LINEOUT_MUTE_INDEX, 0, true };
> +static const struct acpi_gpio_params lineout_det_gpio = { GPIO_LINEOUT_DET_INDEX, 0, false };
> +static const struct acpi_gpio_params mic_det_gpio = { GPIO_LINEIN_DET_INDEX, 0, false };
> +
> +
> +static const struct acpi_gpio_mapping acpi_rt5660_gpios[] = {
> +	{ "lineout-mute-gpios", &lineout_mute_gpio , 1 },
> +	{ "lineout-det-gpios", &lineout_det_gpio, 1 },
> +	{ "mic-det-gpios", &mic_det_gpio, 1 },
> +	{ NULL },
> +};
> +
> +static struct snd_soc_jack lineout_jack;
> +static struct snd_soc_jack mic_jack;
> +
> +static struct snd_soc_jack_pin lineout_jack_pin = {
> +	.pin	= "Line Out",
> +	.mask	= SND_JACK_LINEOUT,
> +};
> +
> +static struct snd_soc_jack_pin mic_jack_pin = {
> +	.pin	= "Line In",
> +	.mask	= SND_JACK_MICROPHONE,
> +};
> +
> +static struct snd_soc_jack_gpio lineout_jack_gpio = {
> +	.name			= "lineout-det",
> +	.report			= SND_JACK_LINEOUT,
> +	.debounce_time		= 200,
> +};
> +
> +static struct snd_soc_jack_gpio mic_jack_gpio = {
> +	.name			= "mic-det",
> +	.report			= SND_JACK_MICROPHONE,
> +	.debounce_time		= 200,
> +};
> +
> +static int kabylake_rt5660_codec_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	int ret;
> +	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
> +	struct snd_soc_component *component = rtd->codec_dai->component;
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +
> +	ret = devm_acpi_dev_add_driver_gpios(component->dev, acpi_rt5660_gpios);
> +	if (ret)
> +		dev_warn(component->dev, "Failed to add driver gpios\n");
> +
> +	/* Request rt5660 GPIO for lineout mute control */
> +	ctx->gpio_lo_mute = devm_gpiod_get(component->dev, "lineout-mute",
> +			GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->gpio_lo_mute)) {
> +		dev_err(component->dev, "Can't find GPIO_MUTE# gpio\n");
> +		return PTR_ERR(ctx->gpio_lo_mute);
> +	}
> +
> +	/* Create and initialize headphone jack */
> +	if (!snd_soc_card_jack_new(rtd->card, "Lineout Jack",
> +			SND_JACK_LINEOUT, &lineout_jack,
> +			&lineout_jack_pin, 1)) {
> +		lineout_jack_gpio.gpiod_dev = component->dev;
> +		if (snd_soc_jack_add_gpios(&lineout_jack, 1,
> +				&lineout_jack_gpio))
> +			dev_err(component->dev, "Can't add Lineout jack gpio\n");
> +	} else
> +		dev_err(component->dev, "Can't create Lineout jack\n");
> +
> +	/* Create and initialize mic jack */
> +	if (!snd_soc_card_jack_new(rtd->card, "Mic Jack",
> +			SND_JACK_MICROPHONE, &mic_jack,
> +			&mic_jack_pin, 1)) {
> +		mic_jack_gpio.gpiod_dev = component->dev;
> +		if (snd_soc_jack_add_gpios(&mic_jack, 1, &mic_jack_gpio))
> +			dev_err(component->dev, "Can't add mic jack gpio\n");
> +	} else
> +		dev_err(component->dev, "Can't create mic jack\n");
> +
> +	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
> +	snd_soc_dapm_force_enable_pin(dapm, "BST1");
> +	snd_soc_dapm_force_enable_pin(dapm, "BST2");
> +
> +	return ret;
> +}
> +
>   static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
>   {
>   	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
> @@ -245,6 +381,35 @@ static int kabylake_da7219_fe_init(struct snd_soc_pcm_runtime *rtd)
>   	return 0;
>   }
>   
> +static int kabylake_rt5660_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai,
> +				     RT5660_SCLK_S_PLL1, params_rate(params) * 512,
> +				     SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dai_set_pll(codec_dai, 0,
> +				  RT5660_PLL1_S_BCLK,
> +				  params_rate(params) * 50,
> +				  params_rate(params) * 512);
> +	if (ret < 0)
> +		dev_err(codec_dai->dev, "can't set codec pll: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static struct snd_soc_ops kabylake_rt5660_ops = {
> +	.hw_params = kabylake_rt5660_hw_params,
> +};
> +
>   static const unsigned int rates[] = {
>   	48000,
>   };
> @@ -519,6 +684,37 @@ static struct snd_soc_dai_link kabylake_dais[] = {
>   	},
>   };
>   
> +static struct snd_soc_dai_link be_ssp0_rt5660 = {
> +	/* SSP0 - Codec */
> +	.name = "SSP0-Codec",
> +	.id = 0,
> +	.cpu_dai_name = "SSP0 Pin",
> +	.platform_name = "0000:00:1f.3",
> +	.no_pcm = 1,
> +	.codec_name = "i2c-10EC3277:00",
> +	.codec_dai_name = KBL_RT5660_CODEC_DAI,
> +	.init = kabylake_rt5660_codec_init,
> +	.dai_fmt = SND_SOC_DAIFMT_I2S |
> +	SND_SOC_DAIFMT_NB_NF |
> +	SND_SOC_DAIFMT_CBS_CFS,
> +	.ignore_pmdown_time = 1,
> +	.be_hw_params_fixup = kabylake_ssp_fixup,
> +	.ops = &kabylake_rt5660_ops,
> +	.dpcm_playback = 1,
> +	.dpcm_capture = 1,
> +};
> +
> +static struct snd_soc_dai_link be_ssp1_dummy = {
> +	/* SSP1 - Codec */
> +	.name = "SSP1-Codec",
> +	.id = 1,
> +	.cpu_dai_name = "SSP1 Pin",
> +	.platform_name = "0000:00:1f.3",
> +	.no_pcm = 1,
> +	.codec_name = "snd-soc-dummy",
> +	.codec_dai_name = "snd-soc-dummy-dai",
> +};
> +
>   #define NAME_SIZE	32
>   static int kabylake_card_late_probe(struct snd_soc_card *card)
>   {
> @@ -570,6 +766,22 @@ static struct snd_soc_card kabylake_audio_card_da7219_m98357a = {
>   	.late_probe = kabylake_card_late_probe,
>   };
>   
> +/* kabylake audio machine driver for rt5660 */
> +static struct snd_soc_card kabylake_audio_card_rt5660 = {
> +	.name = "kblrt5660",
> +	.owner = THIS_MODULE,
> +	.dai_link = kabylake_dais,
> +	.num_links = ARRAY_SIZE(kabylake_dais),
> +	.controls = kabylake_rt5660_controls,
> +	.num_controls = ARRAY_SIZE(kabylake_rt5660_controls),
> +	.dapm_widgets = kabylake_rt5660_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(kabylake_rt5660_widgets),
> +	.dapm_routes = kabylake_rt5660_map,
> +	.num_dapm_routes = ARRAY_SIZE(kabylake_rt5660_map),
> +	.fully_routed = true,
> +	.late_probe = kabylake_card_late_probe,
> +};
> +
>   static int kabylake_audio_probe(struct platform_device *pdev)
>   {
>   	struct kbl_codec_private *ctx;
> @@ -583,6 +795,11 @@ static int kabylake_audio_probe(struct platform_device *pdev)
>   	kabylake_audio_card =
>   		(struct snd_soc_card *)pdev->id_entry->driver_data;
>   
> +	if (!strcmp(pdev->id_entry->name, "kbl_rt5660")) {
> +		kabylake_audio_card->dai_link[KBL_DPCM_AUDIO_HDMI3_PB+1] = be_ssp0_rt5660;
> +		kabylake_audio_card->dai_link[KBL_DPCM_AUDIO_HDMI3_PB+2] = be_ssp1_dummy;
> +	}
> +
>   	kabylake_audio_card->dev = &pdev->dev;
>   	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
>   	return devm_snd_soc_register_card(&pdev->dev, kabylake_audio_card);
> @@ -594,13 +811,18 @@ static const struct platform_device_id kbl_board_ids[] = {
>   		.driver_data =
>   			(kernel_ulong_t)&kabylake_audio_card_da7219_m98357a,
>   	},
> +	{
> +		.name = "kbl_rt5660",
> +		.driver_data =
> +			(kernel_ulong_t)&kabylake_audio_card_rt5660,
> +	},
>   	{ }
>   };
>   
>   static struct platform_driver kabylake_audio = {
>   	.probe = kabylake_audio_probe,
>   	.driver = {
> -		.name = "kbl_da7219_max98357a",
> +		.name = "kbl_da7219_max98357a_rt5660",
>   		.pm = &snd_soc_pm_ops,
>   	},
>   	.id_table = kbl_board_ids,
> @@ -609,7 +831,8 @@ static struct platform_driver kabylake_audio = {
>   module_platform_driver(kabylake_audio)
>   
>   /* Module information */
> -MODULE_DESCRIPTION("Audio Machine driver-DA7219 & MAX98357A in I2S mode");
> +MODULE_DESCRIPTION("Audio Machine driver-DA7219 & MAX98357A & RT5660 in I2S mode");
>   MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
>   MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("platform:kbl_da7219_max98357a");
> +MODULE_ALIAS("platform:kbl_rt5660");
> diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> index a317b7790fce..1e41c7ded9e9 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> @@ -96,6 +96,11 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
>   		.quirk_data = &kbl_7219_98927_codecs,
>   		.pdata = &skl_dmic_data
>   	},
> +	{
> +		.id = "10EC3277",
> +		.drv_name = "kbl_rt5660",
> +		.fw_filename = "intel/dsp_fw_kbl.bin",
> +	},
>   	{},
>   };
>   EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_kbl_machines);
> 
