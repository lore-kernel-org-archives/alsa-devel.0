From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: New platform CherryTrail/ES8316 audio output is
 silent
Date: Fri, 13 Jan 2017 13:33:01 -0600
Message-ID: <99853b70-6677-38c7-8783-372d41d5e651@linux.intel.com>
References: <20170111190728.1824-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 44B502668A2
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2017 20:33:05 +0100 (CET)
In-Reply-To: <20170111190728.1824-1-drake@endlessm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <drake@endlessm.com>, yang.a.fang@intel.com, vinod.koul@intel.com, alsa-devel@alsa-project.org
Cc: linux@endlessm.com, yangxiaohua@everest-semi.com
List-Id: alsa-devel@alsa-project.org

On 1/11/17 1:07 PM, Daniel Drake wrote:
> Hi,
>
> I'm trying to get audio working on the Weibu F3C miniPC which has a 3.5mm
> headphone jack and 3.5mm mic jack. The SoC is Intel Cherry Trail x5-Z8300.
>
> The ES8316 codec included is not supported by Linux at the moment. I'd like
> to fix that and upstream the driver but so far am I stuck with no audio
> output, only silence. I do have a working Windows setup that I can poke at
> for more info.

the issue was already reported for other platforms at 
https://bugzilla.kernel.org/show_bug.cgi?id=189261 and I pinged people 
at everest-semi before the holiday break.

>
> I would appreciate any suggestions or ideas. Here is a description of my
> efforts so far, followed by the work in progress code:
>
> I started with the Cherry Trail ES8316 platform driver + ES8316 codec driver
> which I found in
> https://github.com/JideTechnology/remixos-kernel/tree/jide_chuwi_vi10_plus_r51
>
> First I did the required updates to get it building on Linux 4.9 including
> adding the driver for the codec's MCLK input which is done with some patches
> currently under review:
>
>     clk: x86: Add Atom PMC platform clocks
>     arch/x86/platform/atom: Move pmc_atom to drivers/platform/x86
>     platform/x86: Enable Atom PMC platform clocks

The patches don't hurt but are typically not needed on CherryTrail where 
the clock is handled by the BIOS. They are required on Baytrail where 
the BIOS is not involved and the oscillator is not 19.2MHz. If you see a 
mention in the DSDT table of CLK3 or CLK_PLT3 then this is already handled.

>
> I confirmed that I am manipulating the right clock by disabling it under
> Windows and observing that audio output suddenly stops.
>
> I created an audio loop within the codec itself, by enabling MIC1 as an input
> to the Left HP Mux, enabling the LLIN Switch, and enabling Left HP Mux as an
> input to Left Hp Mixer. Now when I make noise in the microphone, I can hear
> it on the headphone. This verifies that most of the audio path through the
> codec is working fine, and also that it is clocked.
>
> I used asoc debugfs to trace the path through the DAI, platform and
> codec DAPM graphs. Everything is On and active as expected. I confirmed that
> it is basically the same as another Cherry Trail platform I have here
> (except for the codec which is rt5645 on the other platform), including mixer
> levels.
>
> I also dumped the codec registers over I2C from Windows and set them to
> the exact same values on Linux. Still not working.
>
> At this point I am suspecting that this is likely a problem with the audio
> interface and its linkage to the codec (SSP/I2S).
>
> I modified the platform driver to use ssp1 instead of ssp2, because the
> device schematics say that I2S_1 is being used. Then I ran into
> send_ssp_cmd() complaining that ssp1 is not supported, and found a point
> of curiosity here. This code is basically to set the value of
> sst_cmd_sba_hw_set_ssp.selection which is documented as:
> 	/* 0:SSP0(def), 1:SSP1, 2:SSP2 */

That is very unusual. We have not seen any platforms use SSP1 for the 
codec connections. Are you really sure? If you can share the schematics 
privately I'd like to take a look. We don't have support upstream for 
SSP1 usage so that'd be really problematic.

> But other platforms like cht_bsw_rt5645 use ssp2, for which send_ssp_cmd()
> will use SSP_CODEC, which has value 3. So it looks like the above comment
> is wrong? Either way, I tried selection values 0, 1, 2, and 3, and still no
> audio output.
>
> Here's the code, apologies that it is a bit unclean, I'll continue
> improving it once I get something working. Any suggestions, or do I need to
> get a hardware scope to diganose further?
> ---
>  drivers/base/regmap/regmap-debugfs.c     |    2 +-
>  sound/soc/codecs/Kconfig                 |    4 +
>  sound/soc/codecs/Makefile                |    2 +
>  sound/soc/codecs/es8316.c                | 1386 ++++++++++++++++++++++++++++
>  sound/soc/codecs/es8316.h                |  124 +++
>  sound/soc/intel/Kconfig                  |   12 +
>  sound/soc/intel/atom/sst-atom-controls.c |    5 +-
>  sound/soc/intel/atom/sst/sst_acpi.c      |    2 +
>  sound/soc/intel/boards/Makefile          |    2 +
>  sound/soc/intel/boards/cht_es8316.c      | 1462 ++++++++++++++++++++++++++++++
>  10 files changed, 2999 insertions(+), 2 deletions(-)
>  create mode 100644 sound/soc/codecs/es8316.c
>  create mode 100644 sound/soc/codecs/es8316.h
>  create mode 100644 sound/soc/intel/boards/cht_es8316.c

<snip to jump to Intel side of things>

>
> +config SND_SOC_INTEL_CHT_ES8316_MACH
> +	tristate "ASoC Audio driver for Intel Cherrytrail with ES8316 codec"
> +	depends on X86_INTEL_LPSS && I2C && ACPI
> +	select SND_SOC_ES8316
> +	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_IPC_ACPI
> +	select SND_SOC_INTEL_SST_MATCH if ACPI
> +	help
> +	  This adds support for ASoC machine driver for Intel(R) Cherrytrail
> +	  platforms with ES8316 audio codec.
> +	  If unsure select "N".
> +
>  config SND_SOC_INTEL_SKYLAKE
>  	tristate
>  	select SND_HDA_EXT_CORE
> diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
> index 0838478..25ea25c 100644
> --- a/sound/soc/intel/atom/sst-atom-controls.c
> +++ b/sound/soc/intel/atom/sst-atom-controls.c
> @@ -21,6 +21,7 @@
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define DEBUG
>
>  #include <linux/slab.h>
>  #include <sound/soc.h>
> @@ -894,7 +895,7 @@ int sst_fill_ssp_config(struct snd_soc_dai *dai, unsigned int fmt)
>   * this can be overwritten by set_dai_xxx APIs
>   */
>  static const struct sst_ssp_config sst_ssp_configs = {
> -	.ssp_id = SSP_CODEC,
> +	.ssp_id = SSP_BT,
>  	.bits_per_slot = 24,
>  	.slots = 4,

That will definitively not work, the TDM 4 slot mode is not supported to 
the best of my knowledge on SSP1.

>  	.ssp_mode = SSP_MODE_MASTER,
> @@ -943,6 +944,8 @@ int send_ssp_cmd(struct snd_soc_dai *dai, const char *id, bool enable)
>  		ssp_id = SSP_MODEM;
>  	else if (strcmp(id, "ssp2-port") == 0)
>  		ssp_id = SSP_CODEC;
> +	else if (strcmp(id, "ssp1-port") == 0)
> +		ssp_id = SSP_BT; // FIXME what is the right ID?
>  	else {
>  		dev_dbg(dai->dev, "port %s is not supported\n", id);
>  		return -1;
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 0a88537..75997e2 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -458,6 +458,8 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
>  						&chv_platform_data },
>  	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
>  						&chv_platform_data },
> +	{"ESSX8316", "cht-es8316", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> +						&chv_platform_data },

this change is fine and should be added as a separate patch

> diff --git a/sound/soc/intel/boards/cht_es8316.c b/sound/soc/intel/boards/cht_es8316.c
> new file mode 100644
> index 0000000..a6e105d
> --- /dev/null
> +++ b/sound/soc/intel/boards/cht_es8316.c
> @@ -0,0 +1,1462 @@
> +/*
> + *  cht_cr_es8316.c - ASoc DPCM Machine driver
> + *  for Intel CherryTrail MID platform
> + *
> + *  Copyright (C) 2014 Intel Corp
> + *  Author: Praveen Diwakar <praveen.diwakar@intel.com>
> + *          Bhakte, GurudattaX <gurudattax.bhakte@intel.com>
> + *  This file is modified from cht_bl_dpcm_rt5672.c for cherrytrail CR
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
> +#define DEBUG
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/gpio.h>
> +#include <linux/acpi.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/mutex.h>
> +#include <linux/clk.h>
> +#include <asm/intel-mid.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/jack.h>
> +#include "../../codecs/es8316.h"
> +#include "../atom/sst-atom-controls.h"
> +
> +struct clk *mclk;
> +
> +#define CHT_PLAT_CLK_3_HZ	19200000
> +
> +#define CHT_INTR_DEBOUNCE               0    //0  /* updated by everest-david  15-3-4*/
> +#define CHT_HS_DEBOUNCE_DELAY           500//500       /* added by everest-david */
> +#define CHT_HS_INSERT_DET_DELAY         400//600
> +#define CHT_HS_REMOVE_DET_DELAY         40     //100  /* updated by everest-david  15-3-4*/
> +#define CHT_BUTTON_PRESS_DELAY          50
> +#define CHT_BUTTON_RELEASE_DELAY        50
> +#define CHT_HS_DET_POLL_INTRVL          50
> +#define CHT_BUTTON_EN_DELAY             0
> +
> +#define CHT_HS_DET_RETRY_COUNT        8
> +#define CHT_HS_DEBOUNCE_RETRY_COUNT    3        /* added by everest-david */
> +#define CHT_HS_BUTTON_PRESS_CHK_COUNT  3        /* added by everest-david */
> +#define CHT_HS_BUTTON_RELEASE_CHK_COUNT 3       /* added by everest-david */
> +#define CHT_HS_REMOVE_RETRY_COUNT 1       /* added by everest-david  15-3-4*/

the trend is to push the jack detection to the codec driver in recent 
drivers? This is a large chunk of code that makes the machine driver 
quite obscure and bloated.

> +
> +#define VLV2_PLAT_CLK_AUDIO	3
> +#define PLAT_CLK_FORCE_ON	1
> +#define PLAT_CLK_FORCE_OFF	2

those PLAT_CLK definitions are obsolete and were replaced by the clk_() APIs

<snip>

> +static int platform_clock_control(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *k, int  event)
> +{
> +	struct snd_soc_dapm_context *dapm = w->dapm;
> +	struct snd_soc_card *card = dapm->card;
> +	struct snd_soc_codec *codec;
> +	
> +	codec = cht_get_codec(card);
> +	if (!codec) {
> +		pr_err("Codec not found; Unable to set platform clock\n");
> +		return -EIO;
> +	}
> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		//vlv2_plat_configure_clock(VLV2_PLAT_CLK_AUDIO,
> +		//		PLAT_CLK_FORCE_ON);
> +clk_prepare_enable(mclk);
> +		pr_info("Platform clk turned ON\n");
> +	} else {
> +		/* Set codec clock source to internal clock before
> +		 * turning off the platform clock. Codec needs clock
> +		 * for Jack detection and button press
> +		 */
> +		//vlv2_plat_configure_clock(VLV2_PLAT_CLK_AUDIO,
> +		//		PLAT_CLK_FORCE_ON);
> +		clk_disable_unprepare(mclk);

you need to check if the codec can work without the mclock here. Other 
codecs require the system clock to be changed to use an internal oscillator

> +		pr_info("Platform clk turned OFF\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone", NULL),
> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +	SND_SOC_DAPM_MIC("Internal Mic", NULL),
> +	SND_SOC_DAPM_MIC("D-MIC", NULL),
> +	SND_SOC_DAPM_SPK("Ext Spk", NULL),
> +	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
> +			platform_clock_control, SND_SOC_DAPM_PRE_PMU|
> +			SND_SOC_DAPM_POST_PMD),
> +};
> +
> +static const struct snd_soc_dapm_route cht_audio_map[] = {
> +#if 0
> +		{"Headphone", NULL, "HPL"},
> +		{"Headphone", NULL, "HPR"},
> +		{"Ext Spk", NULL, "SPKOUTL"},
> +		{"Ext Spk", NULL, "SPKOUTR"},
> +		/* AMIC */
> +	/*
> +		Don't use RVP resource
> +		for HP detection issue on RVP
> +	*/
> +		{"Headset AMIC", NULL, "MIC Bias"},
> +		{"MONOINP", NULL, "Headset AMIC"},
> +		{"MONOINN", NULL, "Headset AMIC"},
> +
> +		{"AMIC", NULL, "MIC Bias"},
> +		{"MIC", NULL, "AMIC"},
> +#else
> +		{"Ext Spk", NULL, "SPKOL"},
> +		{"Ext Spk", NULL, "SPKOR"},
> +		
> +		{"D-MIC", NULL, "micbias"},
> +		{"Headset Mic", NULL, "micbias"},
> +		{"Internal Mic", NULL, "micbias"},	
> +		/* Headset Mic: Headset Mic with bias */
> +		{"MIC1", NULL, "Headset Mic"},
> +		{"MIC2", NULL, "Internal Mic"},
> +		{"DMIC", NULL, "D-MIC"},
> +		
> +		/* Headset Stereophone(Headphone): HSOL, HSOR */
> +		{"Headphone", NULL, "HPOL"},
> +		{"Headphone", NULL, "HPOR"},
> +		
> +		{"Headphone", NULL, "Platform Clock"},
> +		{"Headset Mic", NULL, "Platform Clock"},
> +		{"D-MIC", NULL, "Platform Clock"},
> +		{"Internal Mic", NULL, "Platform Clock"},
> +		{"Ext Spk", NULL, "Platform Clock"},
> +#endif
> +		{"Playback", NULL, "ssp1 Tx"},
> +		{"ssp1 Tx", NULL, "codec_out0"},
> +		{"ssp1 Tx", NULL, "codec_out1"},

I don't think the last two lines can work. Codec_out0/1 are implicitly 
wired to SSP2

> +		{"codec_in0", NULL, "ssp1 Rx"},
> +		{"codec_in1", NULL, "ssp1 Rx"},
> +		{"ssp1 Rx", NULL, "Capture"},
> +		{"ssp0 Tx", NULL, "modem_out"},
> +		{"Playback", NULL, "Platform Clock"},
> +		{"Capture", NULL, "Platform Clock"},
> +};
> +
> +static const struct snd_kcontrol_new cht_mc_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Headphone"),
> +	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +	SOC_DAPM_PIN_SWITCH("Internal Mic"),
> +	SOC_DAPM_PIN_SWITCH("D-MIC"),
> +	SOC_DAPM_PIN_SWITCH("Ext Spk"),
> +};
> +
> +
> +static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
> +			struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	unsigned int fmt;
> +	int ret;
> +
> +	pr_debug("Enter:%s", __func__);
> +
> +	//add for voip call no sound by zm 1211
> +	if (strncmp(codec_dai->name, "ES8316 HiFi", 11))
> +                return 0;
> +
> +	/* I2S Slave Mode*/
> +	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_CBS_CFS;
> +
> +	/* Set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> +	if (ret < 0) {
> +		pr_err("can't set codec DAI configuration %d\n", ret);
> +		return ret;
> +	}
> +
> +#if 0
> +	ret = snd_soc_dai_set_pll(codec_dai, 0, ES8316_PLL_SRC_FRM_MCLK,
> +				CHT_PLAT_CLK_3_HZ, params_rate(params) * 256);
> +	if (ret < 0) {
> +		pr_err("can't set codec pll***********: %d\n", ret);
> +		return ret;
> +	}
> +
> +
> +	if (codec_dai->driver && codec_dai->driver->ops->hw_params)
> +		codec_dai->driver->ops->hw_params(substream, params, codec_dai);
> +
> +	snd_soc_dai_set_sysclk(codec_dai, ES8316_CLKID_PLLO, CHT_PLAT_CLK_3_HZ, 0);
> +#endif
> +#if 0
> +	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
> +			params_rate(params) * 512, SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		pr_err("can't set codec sysclk: %d\n", ret);
> +		return ret;
> +	}
> +#endif

weird, the PLL doesn't seem to be set, only the value for the system clk?

> +	snd_soc_dai_set_sysclk(codec_dai, ES8316_CLKID_PLLO, CHT_PLAT_CLK_3_HZ, 0);
> +
> +	return 0;
> +}
> +
> +static int cht_compr_set_params(struct snd_compr_stream *cstream)
> +{
> +	return 0;
> +}
> +
> +static const struct snd_soc_pcm_stream cht_dai_params = {
> +	.formats = SNDRV_PCM_FMTBIT_S24_LE,
> +	.rate_min = 48000,
> +	.rate_max = 48000,
> +	.channels_min = 2,
> +	.channels_max = 2,
> +};
> +
> +static struct snd_soc_compr_ops cht_compr_ops = {
> +	.set_params = cht_compr_set_params,
> +};
> +
> +static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
> +			    struct snd_pcm_hw_params *params)
> +{
> +	struct snd_interval *rate = hw_param_interval(params,
> +			SNDRV_PCM_HW_PARAM_RATE);
> +	struct snd_interval *channels = hw_param_interval(params,
> +						SNDRV_PCM_HW_PARAM_CHANNELS);
> +
> +	pr_debug("Invoked %s for dailink %s\n", __func__, rtd->dai_link->name);
> +
> +	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
> +	rate->min = rate->max = 48000;
> +	channels->min = channels->max = 4;//2

again that part is wild

> +	/* set SSP2 to 24-bit */
> +	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
> +				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
> +				    SNDRV_PCM_FORMAT_S24_LE);
> +	return 0;
> +}
> +
> +static int cht_set_bias_level(struct snd_soc_card *card,
> +				struct snd_soc_dapm_context *dapm,
> +				enum snd_soc_bias_level level)
> +{
> +	int ret = 0;
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +	case SND_SOC_BIAS_STANDBY:
> +	case SND_SOC_BIAS_OFF:
> +		card->dapm.bias_level = level;
> +		pr_debug("card(%s)->bias_level %u\n", card->name,
> +				card->dapm.bias_level);
> +		break;
> +	default:
> +		pr_err("%s: Invalid bias level=%d\n", __func__, level);
> +		ret =  -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cht_audio_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	int ret;
> + 	int ReadBuffer,ReadBuffer1,ReadBuffer2;
> +	struct snd_soc_codec *codec;
> +	struct snd_soc_card *card = runtime->card;
> +	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
> +	struct gpio_desc *desc;
> +	pr_debug("Enter:%s", __func__);
> +
> +	codec = cht_get_codec(card);
> +	if (!codec) {
> +		pr_err("Codec not found: %s:failed\n", __func__);
> +		return -EIO;
> +	}
> +	ctx->codec = codec;
> +	desc = devm_gpiod_get_index(codec->dev, NULL, 1, 0);
> +	if (!IS_ERR(desc)) {
> +		hs_gpio.gpio = 307;//desc_to_gpio(desc);
> +		devm_gpiod_put(codec->dev, desc);
> +		pr_info("cht-cr GPIOs - JD/BP-int: %d\n", hs_gpio.gpio);
> +	} else {
> +		hs_gpio.gpio = 307;
> +		pr_err("Failed to get gpio desc for Jack det\n");
> +	}
> +	pr_err("hs codec gpio %d\n", hs_gpio.gpio);
> +
> +	/* Set codec bias level */
> +	cht_set_bias_level(card, &card->dapm, SND_SOC_BIAS_OFF);
> +	card->dapm.idle_bias_off = true;
> +
> +	/* Headset jack detection */
> +	ret = snd_soc_card_jack_new(card, "Headset Jack",
> +			SND_JACK_HEADSET | SND_JACK_HEADPHONE | SND_JACK_BTN_0,
> +			 &ctx->jack, NULL, 0);
> +	if (ret) {
> +		pr_err("Jack creation failed\n");
> +// todo		return ret;
> +	}
> +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
> +
> +	ret = snd_soc_jack_add_gpios(&ctx->jack, 1, &hs_gpio);
> +	if (ret) {
> +		pr_err("Adding jack GPIO failed with error %d\n", ret);
> +//todo		return ret;
> +	}
> +
> +
> +	ret = snd_soc_add_card_controls(card, cht_mc_controls,
> +					ARRAY_SIZE(cht_mc_controls));
> +	if (ret) {
> +		pr_err("unable to add card controls\n");
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dapm_sync(&card->dapm);
> +	if (ret) {
> +		pr_err("unable to sync dapm\n");
> +		return ret;
> +	}
> +
> +	ReadBuffer = snd_soc_read(codec, ES8316_GPIO_DEBUNCE_INT_REG4E);
> +       // printk("===probe ReadBuffer: 0x%x\n",ReadBuffer);
> +        ReadBuffer1=ReadBuffer | 0xFE;
> +        ReadBuffer2=ReadBuffer1 & 0x01;
> +         if (ReadBuffer2 & 0x01)
> +        {
> +               // printk("===11111111 ReadBuffer2: 0x%x\n",ReadBuffer2);
> +                snd_soc_write(codec, 0X4E, 0xF2);
> +        }
> +         else
> +        {
> +                //printk("===22222222 ReadBuffer2: 0x%x\n",ReadBuffer2);
> +                snd_soc_write(codec, 0X4E, 0xF3);
> +        }
> +         mdelay(10);
> +        snd_soc_write(codec, 0X4E, 0xF3);
> +        ret = snd_soc_read(codec, 0x4F);
> +        //printk("===read 0x4F reg: 0x%x\n", ret);
> +
> +
> +	return ret;
> +}
> +
> +static unsigned int rates_8000_16000[] = {
> +	8000,
> +	16000,
> +};
> +
> +static struct snd_pcm_hw_constraint_list constraints_8000_16000 = {
> +	.count = ARRAY_SIZE(rates_8000_16000),
> +	.list  = rates_8000_16000,
> +};
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
> +static struct snd_soc_ops cht_aif1_ops = {
> +	.startup = cht_aif1_startup,
> +};
> +
> +static int cht_8k_16k_startup(struct snd_pcm_substream *substream)
> +{
> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> +			SNDRV_PCM_HW_PARAM_RATE,
> +			&constraints_8000_16000);
> +}
> +
> +static struct snd_soc_ops cht_be_ssp2_ops = {
> +	.hw_params = cht_aif1_hw_params,
> +};
> +
> +
> +static struct snd_soc_dai_link cht_dailink[] = {
> +	[MERR_DPCM_AUDIO] = {
> +		.name = "Audio Port",
> +		.stream_name = "Audio",
> +		.cpu_dai_name = "media-cpu-dai",
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.platform_name = "sst-mfld-platform",
> +		.nonatomic = true,
> +		.dynamic = 1,
> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +		.ops = &cht_aif1_ops,
> +		.init = cht_audio_init,
> +		.ignore_suspend = 1,
> +	},
> +	[MERR_DPCM_DEEP_BUFFER] = {
> +		.name = "Deep-Buffer Audio Port",
> +		.stream_name = "Deep-Buffer Audio",
> +		.cpu_dai_name = "deepbuffer-cpu-dai",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.codec_name = "snd-soc-dummy",
> +		.platform_name = "sst-mfld-platform",
> +		.nonatomic = true,
> +		.dynamic = 1,
> +		.dpcm_playback = 1,
> +		.ops = &cht_aif1_ops,
> +		.ignore_suspend = 1,
> +	},
> +	[MERR_DPCM_COMPR] = {
> +		.name = "Compressed Port",
> +		.stream_name = "Compress",
> +		.cpu_dai_name = "compress-cpu-dai",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.codec_name = "snd-soc-dummy",
> +		.platform_name = "sst-mfld-platform",
> +		.ignore_suspend = 1,
> +		.compr_ops = &cht_compr_ops,
> +	},
> +	/* Back ends */
> +	{
> +		.name = "SSP2-Codec",
> +		.id = 1,
> +		.cpu_dai_name = "ssp1-port",
> +		.platform_name = "sst-mfld-platform",
> +		.no_pcm = 1,
> +		.codec_dai_name = "ES8316 HiFi",
> +		.codec_name = "i2c-ESSX8316:00",
> +		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
> +					| SND_SOC_DAIFMT_CBS_CFS,

the format here is not consistent with what you are asking the codec dai 
to do, and it's not consistent either with the Intel side which doesn't 
use this mode.
