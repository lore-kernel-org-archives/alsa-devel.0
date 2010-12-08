From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] asoc,
	codec: Add SGTL5000 codec support to asoc
Date: Wed, 08 Dec 2010 18:26:07 +0100
Message-ID: <87mxogkwgg.fsf@lechat.rtp-net.org>
References: <1291773989-22747-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 85D4B2413B
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 18:22:33 +0100 (CET)
In-Reply-To: <1291773989-22747-1-git-send-email-zhaoming.zeng@freescale.com>
	(zhaoming zeng's message of "Wed, 8 Dec 2010 10:06:29 +0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhaoming.zeng@freescale.com
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, festevam@gmail.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

<zhaoming.zeng@freescale.com> writes:

Hi,

See comments inline.

> From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
>
> Add Freescale SGTL5000 codec support.
>
> Signed-off-by: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> ---
>  sound/soc/codecs/Kconfig    |    3 +
>  sound/soc/codecs/Makefile   |    2 +
>  sound/soc/codecs/sgtl5000.c | 1052 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/sgtl5000.h |  403 +++++++++++++++++
>  4 files changed, 1460 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/sgtl5000.c
>  create mode 100644 sound/soc/codecs/sgtl5000.h
>
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 3b5690d..f12ef39 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -318,3 +318,6 @@ config SND_SOC_WM2000
>  
>  config SND_SOC_WM9090
>  	tristate
> +
> +config SND_SOC_SGTL5000
> +	tristate

I think that keeping alphabetical order is welcomed

> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index f67a2d6..116ec3d 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -65,6 +65,7 @@ snd-soc-wm9712-objs := wm9712.o
>  snd-soc-wm9713-objs := wm9713.o
>  snd-soc-wm-hubs-objs := wm_hubs.o
>  snd-soc-jz4740-codec-objs := jz4740.o
> +snd-soc-sgtl5000-objs := sgtl5000.o
>  
>  # Amp
>  snd-soc-max9877-objs := max9877.o
> @@ -139,6 +140,7 @@ obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
>  obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
>  obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
>  obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
> +obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
>  
>  # Amp
>  obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> new file mode 100644
> index 0000000..a053f19
> --- /dev/null
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -0,0 +1,1052 @@
> +/*
> + * sgtl5000.c  --  SGTL5000 ALSA SoC Audio driver
> + *
> + * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/pm.h>
> +#include <linux/i2c.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +#include <mach/hardware.h>
> +
> +#include "sgtl5000.h"
> +
> +static const u16 sgtl5000_regs[] =  {
> +	0xa011, 0x0000, 0x0000, 0x0000, 0x0008, 0x0000, 0x0010, 0x0000,
> +	0x0010, 0x0000, 0x0010, 0x0000, 0x0000, 0x0000, 0x323c, 0x0000,
> +	0x3c3c, 0x0000, 0x3c3c, 0x0000, 0x555f, 0x0000, 0x0000, 0x0000,
> +	0x0000, 0x0000, 0x0000, 0x0000, 0x408c, 0x0000, 0x0008, 0x0000,
> +	0x0000, 0x0000, 0x1818, 0x0000, 0x0111, 0x0000, 0x0000, 0x0000,
> +	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0404, 0x0000,
> +	0x7060, 0x0000, 0x5000, 0x0000, 0x0000, 0x0000, 0x0017, 0x0000,
> +	0x01c0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +};
> +
> +enum sgtl5000_regulator_supplies {
> +	VDDA,
> +	VDDIO,
> +	VDDD,
> +	SGTL5000_SUPPLY_NUM
> +};
> +
> +static const char* supply_names[SGTL5000_SUPPLY_NUM] = {
> +	"VDDA",
> +	"VDDIO",
> +	"VDDD"
> +};
> +
> +struct sgtl5000_priv {
> +	int sysclk;
> +	int master;
> +	int fmt;
> +	int rev;

iirc rev is used only in sgtl5000_probe(). What about removing it from
here ?

> +	int lrclk;
> +	int capture_channels;
> +	int playback_active;
> +	int capture_active;
> +	struct regulator *supplies[SGTL5000_SUPPLY_NUM];
> +	int regulator_volt[SGTL5000_SUPPLY_NUM];
> +	struct regulator *reg_vddio;
> +	struct regulator *reg_vdda;
> +	struct regulator *reg_vddd;
> +	int vddio;		/* voltage of VDDIO (mv) */
> +	int vdda;		/* voltage of vdda (mv) */
> +	int vddd;		/* voltage of vddd (mv), 0 if not connected */

looks like you're not using them (reg_vdd*, vdd*)

> +	struct snd_pcm_substream *master_substream;
> +	struct snd_pcm_substream *slave_substream;
> +};
> +
> +static const char *adc_mux_text[] = {
> +	"MIC_IN", "LINE_IN"
> +};
> +
> +static const char *dac_mux_text[] = {
> +	"DAC", "LINE_IN"
> +};
> +
> +static const struct soc_enum adc_enum =
> +SOC_ENUM_SINGLE(SGTL5000_CHIP_ANA_CTRL, 2, 2, adc_mux_text);
> +
> +static const struct soc_enum dac_enum =
> +SOC_ENUM_SINGLE(SGTL5000_CHIP_ANA_CTRL, 6, 2, dac_mux_text);
> +
> +static const struct snd_kcontrol_new adc_mux =
> +SOC_DAPM_ENUM("Capture Mux", adc_enum);
> +
> +static const struct snd_kcontrol_new dac_mux =
> +SOC_DAPM_ENUM("Headphone Mux", dac_enum);
> +
> +static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
> +	SND_SOC_DAPM_INPUT("LINE_IN"),
> +	SND_SOC_DAPM_INPUT("MIC_IN"),
> +
> +	SND_SOC_DAPM_OUTPUT("HP_OUT"),
> +	SND_SOC_DAPM_OUTPUT("LINE_OUT"),
> +
> +	SND_SOC_DAPM_PGA("HP", SGTL5000_CHIP_ANA_CTRL, 4, 1, NULL, 0),
> +	SND_SOC_DAPM_PGA("LO", SGTL5000_CHIP_ANA_CTRL, 8, 1, NULL, 0),
> +
> +	SND_SOC_DAPM_MUX("Capture Mux", SND_SOC_NOPM, 0, 0, &adc_mux),
> +	SND_SOC_DAPM_MUX("Headphone Mux", SND_SOC_NOPM, 0, 0, &dac_mux),
> +
> +	SND_SOC_DAPM_ADC("ADC", "Capture", SGTL5000_CHIP_DIG_POWER, 6, 0),
> +	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
> +};
> +
> +static const struct snd_soc_dapm_route audio_map[] = {
> +	{"Capture Mux", "LINE_IN", "LINE_IN"},
> +	{"Capture Mux", "MIC_IN", "MIC_IN"},
> +	{"ADC", NULL, "Capture Mux"},
> +	{"Headphone Mux", "DAC", "DAC"},
> +	{"Headphone Mux", "LINE_IN", "LINE_IN"},
> +	{"LO", NULL, "DAC"},
> +	{"HP", NULL, "Headphone Mux"},
> +	{"LINE_OUT", NULL, "LO"},
> +	{"HP_OUT", NULL, "HP"},
> +};
> +
> +static int dac_info_volsw(struct snd_kcontrol *kcontrol,
> +			  struct snd_ctl_elem_info *uinfo)
> +{
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count = 2;
> +	uinfo->value.integer.min = 0;
> +	uinfo->value.integer.max = 0xfc - 0x3c;
> +	return 0;
> +}
> +
> +static int dac_get_volsw(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	int reg, l, r;
> +
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_DAC_VOL);
> +	l = (reg & SGTL5000_DAC_VOL_LEFT_MASK) >> SGTL5000_DAC_VOL_LEFT_SHIFT;
> +	r = (reg & SGTL5000_DAC_VOL_RIGHT_MASK) >> SGTL5000_DAC_VOL_RIGHT_SHIFT;
> +	l = l < 0x3c ? 0x3c : l;
> +	l = l > 0xfc ? 0xfc : l;
> +	r = r < 0x3c ? 0x3c : r;
> +	r = r > 0xfc ? 0xfc : r;
> +	l = 0xfc - l;
> +	r = 0xfc - r;
> +
> +	ucontrol->value.integer.value[0] = l;
> +	ucontrol->value.integer.value[1] = r;
> +
> +	return 0;
> +}
> +
> +static int dac_put_volsw(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	int reg, l, r;
> +
> +	l = ucontrol->value.integer.value[0];
> +	r = ucontrol->value.integer.value[1];
> +
> +	l = l < 0 ? 0 : l;
> +	l = l > 0xfc - 0x3c ? 0xfc - 0x3c : l;
> +	r = r < 0 ? 0 : r;
> +	r = r > 0xfc - 0x3c ? 0xfc - 0x3c : r;
> +	l = 0xfc - l;
> +	r = 0xfc - r;
> +
> +	reg = l << SGTL5000_DAC_VOL_LEFT_SHIFT |
> +	    r << SGTL5000_DAC_VOL_RIGHT_SHIFT;
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_DAC_VOL, reg);
> +
> +	return 0;
> +}
> +
> +static const char *mic_gain_text[] = {
> +	"0dB", "20dB", "30dB", "40dB"
> +};
> +
> +static const char *adc_m6db_text[] = {
> +	"No Change", "Reduced by 6dB"
> +};
> +

What about using TLV controls instead of specifying db values like this?

> +static const struct soc_enum mic_gain =
> +SOC_ENUM_SINGLE(SGTL5000_CHIP_MIC_CTRL, 0, 4, mic_gain_text);
> +
> +static const struct soc_enum adc_m6db =
> +SOC_ENUM_SINGLE(SGTL5000_CHIP_ANA_ADC_CTRL, 8, 2, adc_m6db_text);
> +
> +static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
> +	SOC_ENUM("MIC GAIN", mic_gain),

"Mic Gain Volume" or "MIC GAIN Volume" please.

> +	SOC_DOUBLE("Capture Volume", SGTL5000_CHIP_ANA_ADC_CTRL, 0, 4, 0xf, 0),
> +	SOC_ENUM("Capture Vol Reduction", adc_m6db),

same here. Not Vol but somethig like Capture Reduction Volume please.
> +	{
> +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +		.name = "PCM Playback Volume",
> +		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
> +			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
> +		.info = dac_info_volsw,
> +		.get = dac_get_volsw,
> +		.put = dac_put_volsw,
> +	},
> +	SOC_DOUBLE("Headphone Playback Volume", SGTL5000_CHIP_ANA_HP_CTRL, 0, 8, 0x7f, 1),
> +};
> +
> +static int __sgtl5000_digital_mute(struct snd_soc_codec *codec, int mute)
> +{
> +	u16 adcdac_ctrl = SGTL5000_DAC_MUTE_LEFT | SGTL5000_DAC_MUTE_RIGHT;
> +
> +	if (mute)
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_ADCDAC_CTRL,
> +				adcdac_ctrl, adcdac_ctrl);
> +	else
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_ADCDAC_CTRL,
> +				adcdac_ctrl, 0);
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_digital_mute(struct snd_soc_dai *codec_dai, int mute)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +
> +	return __sgtl5000_digital_mute(codec, mute);
> +}
> +
> +static int sgtl5000_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	u16 i2sctl = 0;
> +
> +	sgtl5000->master = 0;
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		i2sctl |= SGTL5000_I2S_MASTER;
> +		sgtl5000->master = 1;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_DSP_A:
> +		i2sctl |= SGTL5000_I2S_MODE_PCM;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_B:
> +		i2sctl |= SGTL5000_I2S_MODE_PCM;
> +		i2sctl |= SGTL5000_I2S_LRALIGN;
> +		break;
> +	case SND_SOC_DAIFMT_I2S:
> +		i2sctl |= SGTL5000_I2S_MODE_I2S_LJ;
> +		break;
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		i2sctl |= SGTL5000_I2S_MODE_RJ;
> +		i2sctl |= SGTL5000_I2S_LRPOL;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		i2sctl |= SGTL5000_I2S_MODE_I2S_LJ;
> +		i2sctl |= SGTL5000_I2S_LRALIGN;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	sgtl5000->fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> +
> +	/* Clock inversion */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +	case SND_SOC_DAIFMT_NB_IF:
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +	case SND_SOC_DAIFMT_IB_NF:
> +		i2sctl |= SGTL5000_I2S_SCLK_INV;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_I2S_CTRL, i2sctl);
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				   int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (clk_id) {
> +	case SGTL5000_SYSCLK:
> +		sgtl5000->sysclk = freq;
> +		break;
> +	case SGTL5000_LRCLK:
> +		sgtl5000->lrclk = freq;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_pcm_prepare(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	int reg;
> +
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_DIG_POWER);
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		reg |= SGTL5000_I2S_IN_POWERUP;
> +	else
> +		reg |= SGTL5000_I2S_OUT_POWERUP;
> +	snd_soc_write(codec, SGTL5000_CHIP_DIG_POWER, reg);
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +		reg |= SGTL5000_ADC_POWERUP;
> +		if (sgtl5000->capture_channels == 1)
> +			reg &= ~SGTL5000_ADC_STEREO;
> +		else
> +			reg |= SGTL5000_ADC_STEREO;
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +	}

I was wondering about using DAPM for this. What do you think ?

> +
> +	return 0;
> +}
> +
> +static int sgtl5000_pcm_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	struct snd_pcm_runtime *master_runtime;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		sgtl5000->playback_active++;
> +	else
> +		sgtl5000->capture_active++;

Same here. Should dapm be used instead of all this _active++ / _active-- stuff ?

> +
> +	/* The DAI has shared clocks so if we already have a playback or
> +	 * capture going then constrain this substream to match it.
> +	 */
> +	if (sgtl5000->master_substream) {
> +		master_runtime = sgtl5000->master_substream->runtime;
> +
> +		snd_pcm_hw_constraint_minmax(substream->runtime,
> +					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> +					     master_runtime->sample_bits,
> +					     master_runtime->sample_bits);
> +
> +		sgtl5000->slave_substream = substream;
> +	} else
> +		sgtl5000->master_substream = substream;
> +
> +	return 0;
> +}
> +
> +static void sgtl5000_pcm_shutdown(struct snd_pcm_substream *substream,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	int reg, dig_pwr, ana_pwr;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		sgtl5000->playback_active--;
> +	else
> +		sgtl5000->capture_active--;
> +
> +	if (sgtl5000->master_substream == substream)
> +		sgtl5000->master_substream = sgtl5000->slave_substream;
> +
> +	sgtl5000->slave_substream = NULL;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		ana_pwr = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +		ana_pwr &= ~(SGTL5000_ADC_POWERUP | SGTL5000_ADC_STEREO);
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
> +	}
> +
> +	dig_pwr = snd_soc_read(codec, SGTL5000_CHIP_DIG_POWER);
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		dig_pwr &= ~SGTL5000_I2S_IN_POWERUP;
> +	else
> +		dig_pwr &= ~SGTL5000_I2S_OUT_POWERUP;
> +	snd_soc_write(codec, SGTL5000_CHIP_DIG_POWER, dig_pwr);
> +
> +	if (!sgtl5000->playback_active && !sgtl5000->capture_active) {
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_I2S_CTRL);
> +		reg &= ~SGTL5000_I2S_MASTER;
> +		snd_soc_write(codec, SGTL5000_CHIP_I2S_CTRL, reg);
> +	}
> +}
> +
> +/*
> + * Set PCM DAI bit size and sample rate.
> + * input: params_rate, params_fmt
> + */
> +static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
> +				  struct snd_pcm_hw_params *params,
> +				  struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	int channels = params_channels(params);
> +	int clk_ctl = 0;
> +	int pll_ctl = 0;
> +	int i2s_ctl;
> +	int div2 = 0;
> +	int reg;
> +	int sys_fs;
> +
> +	if (!sgtl5000->sysclk) {
> +		dev_err(codec->dev, "%s: set sysclk first!\n", __func__);
> +		return -EFAULT;
> +	}
> +
> +	if (substream == sgtl5000->slave_substream)
> +		return 0;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		sgtl5000->capture_channels = channels;
> +
> +	switch (sgtl5000->lrclk) {
> +	case 8000:
> +	case 16000:
> +		sys_fs = 32000;
> +		break;
> +	case 11025:
> +	case 22050:
> +		sys_fs = 44100;
> +		break;
> +	default:
> +		sys_fs = sgtl5000->lrclk;
> +		break;
> +	}
> +
> +	switch (sys_fs / sgtl5000->lrclk) {
> +	case 4:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_4 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	case 2:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_2 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (sys_fs) {
> +	case 32000:
> +		clk_ctl |= SGTL5000_SYS_FS_32k << SGTL5000_SYS_FS_SHIFT;
> +		break;
> +	case 44100:
> +		clk_ctl |= SGTL5000_SYS_FS_44_1k << SGTL5000_SYS_FS_SHIFT;
> +		break;
> +	case 48000:
> +		clk_ctl |= SGTL5000_SYS_FS_48k << SGTL5000_SYS_FS_SHIFT;
> +		break;
> +	case 96000:
> +		clk_ctl |= SGTL5000_SYS_FS_96k << SGTL5000_SYS_FS_SHIFT;
> +		break;
> +	default:
> +		dev_err(codec->dev, "sample rate %d not supported\n", sgtl5000->lrclk);
> +		return -EFAULT;
> +	}
> +
> +	/* SGTL5000 rev1 has a IC bug to prevent switching to MCLK from PLL. */
> +	if (!sgtl5000->master) {
> +		sys_fs = sgtl5000->lrclk;
> +		clk_ctl = SGTL5000_RATE_MODE_DIV_1 << SGTL5000_RATE_MODE_SHIFT;
> +		if (sys_fs * 256 == sgtl5000->sysclk)
> +			clk_ctl |= SGTL5000_MCLK_FREQ_256FS << \
> +				SGTL5000_MCLK_FREQ_SHIFT;
> +		else if (sys_fs * 384 == sgtl5000->sysclk && sys_fs != 96000)
> +			clk_ctl |= SGTL5000_MCLK_FREQ_384FS << \
> +				SGTL5000_MCLK_FREQ_SHIFT;
> +		else if (sys_fs * 512 == sgtl5000->sysclk && sys_fs != 96000)
> +			clk_ctl |= SGTL5000_MCLK_FREQ_512FS << \
> +				SGTL5000_MCLK_FREQ_SHIFT;
> +		else {
> +			pr_err("%s: PLL not supported in slave mode\n",
> +			       __func__);
> +			return -EINVAL;
> +		}
> +	} else
> +		clk_ctl |= SGTL5000_MCLK_FREQ_PLL << SGTL5000_MCLK_FREQ_SHIFT;
> +
> +	if ((clk_ctl & SGTL5000_MCLK_FREQ_MASK) == SGTL5000_MCLK_FREQ_PLL) {
> +		u64 out, t;
> +		unsigned int in, int_div, frac_div;
> +		if (sgtl5000->sysclk > 17000000) {
> +			div2 = 1;
> +			in = sgtl5000->sysclk / 2;
> +		} else {
> +			div2 = 0;
> +			in = sgtl5000->sysclk;
> +		}
> +		if (sys_fs == 44100)
> +			out = 180633600;
> +		else
> +			out = 196608000;
> +		t = do_div(out, in);
> +		int_div = out;
> +		t *= 2048;
> +		do_div(t, in);
> +		frac_div = t;
> +		pll_ctl = int_div << SGTL5000_PLL_INT_DIV_SHIFT |
> +		    frac_div << SGTL5000_PLL_FRAC_DIV_SHIFT;
> +	}
> +
> +	i2s_ctl = snd_soc_read(codec, SGTL5000_CHIP_I2S_CTRL);
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		if (sgtl5000->fmt == SND_SOC_DAIFMT_RIGHT_J)
> +			return -EINVAL;
> +		i2s_ctl |= SGTL5000_I2S_DLEN_16 << SGTL5000_I2S_DLEN_SHIFT;
> +		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_32FS <<
> +		    SGTL5000_I2S_SCLKFREQ_SHIFT;
> +		break;
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +		i2s_ctl |= SGTL5000_I2S_DLEN_20 << SGTL5000_I2S_DLEN_SHIFT;
> +		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_64FS <<
> +		    SGTL5000_I2S_SCLKFREQ_SHIFT;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		i2s_ctl |= SGTL5000_I2S_DLEN_24 << SGTL5000_I2S_DLEN_SHIFT;
> +		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_64FS <<
> +		    SGTL5000_I2S_SCLKFREQ_SHIFT;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		if (sgtl5000->fmt == SND_SOC_DAIFMT_RIGHT_J)
> +			return -EINVAL;
> +		i2s_ctl |= SGTL5000_I2S_DLEN_32 << SGTL5000_I2S_DLEN_SHIFT;
> +		i2s_ctl |= SGTL5000_I2S_SCLKFREQ_64FS <<
> +		    SGTL5000_I2S_SCLKFREQ_SHIFT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(codec->dev, "fs=%d,clk_ctl=%d,pll_ctl=%d,i2s_ctl=%d,div2=%d\n",
> +		 sgtl5000->lrclk, clk_ctl, pll_ctl, i2s_ctl, div2);
> +
> +	if ((clk_ctl & SGTL5000_MCLK_FREQ_MASK) == SGTL5000_MCLK_FREQ_PLL) {
> +		snd_soc_write(codec, SGTL5000_CHIP_PLL_CTRL, pll_ctl);
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_CLK_TOP_CTRL);
> +		if (div2)
> +			reg |= SGTL5000_INPUT_FREQ_DIV2;
> +		else
> +			reg &= ~SGTL5000_INPUT_FREQ_DIV2;
> +		snd_soc_write(codec, SGTL5000_CHIP_CLK_TOP_CTRL, reg);
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +		reg |= SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP;
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +	}
> +	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL, clk_ctl);
> +	snd_soc_write(codec, SGTL5000_CHIP_I2S_CTRL, i2s_ctl);
> +
> +	return 0;
> +}
> +
> +static void sgtl5000_mic_bias(struct snd_soc_codec *codec, int enable)
> +{
> +	int reg, bias_r = 0;
> +	if (enable)
> +		bias_r = SGTL5000_BIAS_R_4k << SGTL5000_BIAS_R_SHIFT;
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_MIC_CTRL);
> +	if ((reg & SGTL5000_BIAS_R_MASK) != bias_r) {
> +		reg &= ~SGTL5000_BIAS_R_MASK;
> +		reg |= bias_r;
> +		snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, reg);
> +	}
> +}
> +
> +static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
> +				   enum snd_soc_bias_level level)
> +{
> +	u16 reg, ana_pwr;
> +	u16 *cache = codec->reg_cache;
> +
> +	if (codec->bias_level == level)
> +		return 0;
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		sgtl5000_mic_bias(codec, 1);
> +
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
> +				SGTL5000_BIAS_R_MASK, SGTL5000_BIAS_R_MASK);
> +
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> +			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
> +
> +		__sgtl5000_digital_mute(codec, 0);
> +		break;
> +
> +	case SND_SOC_BIAS_PREPARE:	/* partial On */
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
> +				SGTL5000_BIAS_R_MASK, 0);
> +
> +		/* must power up hp/line out before vag & dac to
> +		   avoid pops. */
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +
> +		reg &= ~SGTL5000_VAG_POWERUP;
> +		reg |= SGTL5000_DAC_POWERUP;
> +		reg |= SGTL5000_HP_POWERUP;
> +		reg |= SGTL5000_LINE_OUT_POWERUP;
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_DIG_POWER,
> +			SGTL5000_DAC_EN, SGTL5000_DAC_EN);
> +
> +		break;
> +
> +	case SND_SOC_BIAS_STANDBY:
> +		/* soc calls digital_mute to unmute before record but doesn't
> +		   call digital_mute to mute after record. */
> +		__sgtl5000_digital_mute(codec, 1);
> +
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
> +				SGTL5000_BIAS_R_MASK, 0);
> +
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +		if (reg & SGTL5000_VAG_POWERUP) {
> +			reg &= ~SGTL5000_VAG_POWERUP;
> +			snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +		}
> +		reg &= ~SGTL5000_DAC_POWERUP;
> +		reg &= ~SGTL5000_HP_POWERUP;
> +		reg &= ~SGTL5000_LINE_OUT_POWERUP;
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_DIG_POWER);
> +		reg &= ~SGTL5000_DAC_EN;
> +		snd_soc_write(codec, SGTL5000_CHIP_DIG_POWER, reg);
> +
> +		break;
> +
> +	case SND_SOC_BIAS_OFF:	/* Off, without power */
> +		/* mute hp/Line_out first to avoid pops. */
> +		__sgtl5000_digital_mute(codec, 1);
> +		sgtl5000_mic_bias(codec, 0);
> +
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +		ana_pwr = reg;
> +		reg &= ~SGTL5000_VAG_POWERUP;
> +
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +
> +		reg &= ~SGTL5000_HP_POWERUP;
> +		reg &= ~SGTL5000_LINE_OUT_POWERUP;
> +		reg &= ~SGTL5000_DAC_POWERUP;
> +		reg &= ~SGTL5000_ADC_POWERUP;
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +
> +		/* save ANA POWER register value for resume */
> +		cache[SGTL5000_CHIP_ANA_POWER >> 1] = ana_pwr;
> +		break;
> +	}
> +	codec->bias_level = level;
> +	return 0;
> +}
> +
> +#define SGTL5000_RATES (SNDRV_PCM_RATE_8000 |\
> +		      SNDRV_PCM_RATE_11025 |\
> +		      SNDRV_PCM_RATE_16000 |\
> +		      SNDRV_PCM_RATE_22050 |\
> +		      SNDRV_PCM_RATE_32000 |\
> +		      SNDRV_PCM_RATE_44100 |\
> +		      SNDRV_PCM_RATE_48000 |\
> +		      SNDRV_PCM_RATE_96000)
> +

Looks like it the same as SNDRV_PCM_RATE_8000_96000

> +#define SGTL5000_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			SNDRV_PCM_FMTBIT_S20_3LE |\
> +			SNDRV_PCM_FMTBIT_S24_LE)
> +
> +struct snd_soc_dai_ops sgtl5000_ops = {
> +	.prepare = sgtl5000_pcm_prepare,
> +	.startup = sgtl5000_pcm_startup,
> +	.shutdown = sgtl5000_pcm_shutdown,
> +	.hw_params = sgtl5000_pcm_hw_params,
> +	.digital_mute = sgtl5000_digital_mute,
> +	.set_fmt = sgtl5000_set_dai_fmt,
> +	.set_sysclk = sgtl5000_set_dai_sysclk,
> +};
> +
> +static struct snd_soc_dai_driver sgtl5000_dai = {
> +	.name = "sgtl5000",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = SGTL5000_RATES,
> +		.formats = SGTL5000_FORMATS,
> +	},
> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = SGTL5000_RATES,
> +		.formats = SGTL5000_FORMATS,
> +	},
> +	.ops = &sgtl5000_ops,
> +	.symmetric_rates = 1,
> +};
> +
> +static int sgtl5000_volatile_register(unsigned int reg)
> +{
> +	if (reg == SGTL5000_CHIP_ID ||
> +	    reg == SGTL5000_CHIP_ADCDAC_CTRL ||
> +	    reg == SGTL5000_CHIP_ANA_STATUS)
> +		return 1;
> +	return 0;
> +}
> +
> +static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t state)
> +{
> +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_restore_reg(struct snd_soc_codec *codec, unsigned int reg)
> +{
> +	u16 *cache = codec->reg_cache;
> +
> +	return snd_soc_write(codec, reg, cache[reg >> 1]);
> +}
> +
> +static int sgtl5000_resume(struct snd_soc_codec *codec)
> +{
> +	int i;
> +
> +	/* Restore refs first in same order as in sgtl5000_probe */
> +	sgtl5000_restore_reg(codec, SGTL5000_CHIP_LINREG_CTRL);
> +	sgtl5000_restore_reg(codec, SGTL5000_CHIP_ANA_POWER);
> +	msleep(10);
> +	sgtl5000_restore_reg(codec, SGTL5000_CHIP_REF_CTRL);
> +	sgtl5000_restore_reg(codec, SGTL5000_CHIP_LINE_OUT_CTRL);
> +
> +	/* Restore everythine else */
> +	for (i = 0; i < ARRAY_SIZE(sgtl5000_regs); i++)
> +		sgtl5000_restore_reg(codec, i);
> +
> +	snd_soc_write(codec, SGTL5000_DAP_CTRL, 0);
> +
> +	/* Bring the codec back up to standby first to minimise pop/clicks */
> +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
> +		sgtl5000_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
> +	sgtl5000_set_bias_level(codec, codec->suspend_bias_level);
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_probe(struct snd_soc_codec *codec)
> +{
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	u16 reg, ana_pwr, lreg_ctrl;
> +	int vag;
> +	int ret;
> +	int vddd, vdda, vddio;
> +
> +	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +
> +	vddd = sgtl5000->regulator_volt[VDDD];
> +	vdda = sgtl5000->regulator_volt[VDDA];
> +	vddio = sgtl5000->regulator_volt[VDDIO];
> +
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_ID);
> +	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
> +	    SGTL5000_PARTID_PART_ID) {
> +		dev_err(codec->dev, "Device with ID register %x is not a sgtl5000\n", reg);
> +		return -ENODEV;
> +	}
> +
> +	sgtl5000->rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
> +	dev_info(codec->dev, "sgtl5000 revision %d\n", sgtl5000->rev);
> +
> +	/* reset value */
> +	ana_pwr = SGTL5000_DAC_STEREO |
> +		SGTL5000_LINREG_SIMPLE_POWERUP |
> +		SGTL5000_STARTUP_POWERUP |
> +		SGTL5000_ADC_STEREO | SGTL5000_REFTOP_POWERUP;
> +	lreg_ctrl = 0;
> +
> +	/* workaround for rev 0x11: use vddd linear regulator */
> +	if (!vddd || (sgtl5000->rev >= 0x11)) {
> +		/* set VDDD to 1.2v */
> +		lreg_ctrl |= 0x8 << SGTL5000_LINREG_VDDD_SHIFT;
> +		/* power internal linear regulator */
> +		ana_pwr |= SGTL5000_LINEREG_D_POWERUP;
> +	} else {
> +		/* turn of startup power */
> +		ana_pwr &= ~SGTL5000_STARTUP_POWERUP;
> +		ana_pwr &= ~SGTL5000_LINREG_SIMPLE_POWERUP;
> +	}
> +
> +	if (vddio < 3100 && vdda < 3100) {
> +		/* Enable VDDC charge pump */
> +		ana_pwr |= SGTL5000_VDDC_CHRGPMP_POWERUP;
> +	}
> +
> +	if (vddio >= 3100 && vdda >= 3100) {
> +		/* VDDC use VDDIO rail */
> +		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
> +		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
> +			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
> +	}
> +
> +	/* If PLL is powered up (such as on power cycle) leave it on. */
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +	ana_pwr |= reg & (SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP);
> +
> +	/* set ADC/DAC ref voltage to vdda / 2 */
> +	vag = vdda / 2;
> +	if (vag <= SGTL5000_ANA_GND_BASE)
> +		vag = 0;
> +	else if (vag >= SGTL5000_ANA_GND_BASE + SGTL5000_ANA_GND_STP *
> +		 (SGTL5000_ANA_GND_MASK >> SGTL5000_ANA_GND_SHIFT))
> +		vag = SGTL5000_ANA_GND_MASK >> SGTL5000_ANA_GND_SHIFT;
> +	else
> +		vag = (vag - SGTL5000_ANA_GND_BASE) / SGTL5000_ANA_GND_STP;
> +
> +	/* set line out ref voltage to vddio / 2 */
> +	vag = vddio / 2;
> +	if (vag <= SGTL5000_LINE_OUT_GND_BASE)
> +		vag = 0;
> +	else if (vag >= SGTL5000_LINE_OUT_GND_BASE + SGTL5000_LINE_OUT_GND_STP *
> +		 SGTL5000_LINE_OUT_GND_MAX)
> +		vag = SGTL5000_LINE_OUT_GND_MAX;
> +	else
> +		vag = (vag - SGTL5000_LINE_OUT_GND_BASE) /
> +		    SGTL5000_LINE_OUT_GND_STP;
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
> +	msleep(10);
> +
> +	/* For rev 0x11, if vddd linear reg has been enabled, we have
> +	   to disable simple reg to get proper VDDD voltage.  */
> +	if ((ana_pwr & SGTL5000_LINEREG_D_POWERUP) && (sgtl5000->rev >= 0x11)) {
> +		ana_pwr &= ~SGTL5000_LINREG_SIMPLE_POWERUP;
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
> +		msleep(10);
> +	}
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
> +			vag << SGTL5000_ANA_GND_SHIFT);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
> +			vag << SGTL5000_LINE_OUT_GND_SHIFT |
> +			SGTL5000_LINE_OUT_CURRENT_360u <<
> +				SGTL5000_LINE_OUT_CURRENT_SHIFT);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_SHORT_CTRL, 0);
> +	snd_soc_write(codec, SGTL5000_CHIP_SSS_CTRL,
> +			SGTL5000_DAC_SEL_I2S_IN << SGTL5000_DAC_SEL_SHIFT);
> +	snd_soc_write(codec, SGTL5000_CHIP_DIG_POWER, 0);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_ADCDAC_CTRL, 
> +			SGTL5000_DAC_VOL_RAMP_EN |
> +			SGTL5000_DAC_MUTE_RIGHT |
> +			SGTL5000_DAC_MUTE_LEFT);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x015f);
> +
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_ADC_CTRL);
> +	reg &= ~SGTL5000_ADC_VOL_M6DB;
> +	reg &= ~(SGTL5000_ADC_VOL_LEFT_MASK | SGTL5000_ADC_VOL_RIGHT_MASK);
> +	reg |= (0xf << SGTL5000_ADC_VOL_LEFT_SHIFT)
> +	    | (0xf << SGTL5000_ADC_VOL_RIGHT_SHIFT);
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_ADC_CTRL, reg);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
> +			SGTL5000_LINE_OUT_MUTE |
> +			SGTL5000_HP_MUTE |
> +			SGTL5000_HP_ZCD_EN |
> +			SGTL5000_ADC_ZCD_EN);

are theses volumes/mute stuff really needed ?

> +
> +	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 0);
> +	snd_soc_write(codec, SGTL5000_CHIP_CLK_TOP_CTRL, 0);
> +
> +	/* disable DAP */
> +	snd_soc_write(codec, SGTL5000_DAP_CTRL, 0);
> +
> +	snd_soc_add_controls(codec, sgtl5000_snd_controls,
> +			     ARRAY_SIZE(sgtl5000_snd_controls));
> +
> +	snd_soc_dapm_new_controls(codec, sgtl5000_dapm_widgets,
> +				  ARRAY_SIZE(sgtl5000_dapm_widgets));
> +
> +	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
> +
> +	snd_soc_dapm_new_widgets(codec);
> +
> +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_remove(struct snd_soc_codec *codec)
> +{
> +	if (codec->control_data)
> +		sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	snd_soc_dapm_free(codec);
> +	
> +	return 0;
> +}
> +
> +struct snd_soc_codec_driver sgtl5000_driver = {
> +	.probe = sgtl5000_probe,
> +	.remove = sgtl5000_remove,
> +	.suspend = sgtl5000_suspend,
> +	.resume = sgtl5000_resume,
> +	.set_bias_level = sgtl5000_set_bias_level,
> +	.reg_cache_size = ARRAY_SIZE(sgtl5000_regs),
> +	.reg_word_size = sizeof(u16),
> +	.reg_cache_default = sgtl5000_regs,

missing ".reg_cache_step = 2,"

> +	.volatile_register = sgtl5000_volatile_register,
> +};
> +
> +static __devinit int sgtl5000_i2c_probe(struct i2c_client *client,
> +					const struct i2c_device_id *id)
> +{
> +	struct sgtl5000_priv *sgtl5000;
> +	int ret;
> +	int i;
> +
> +	sgtl5000 = kzalloc(sizeof(struct sgtl5000_priv), GFP_KERNEL);
> +	if (!sgtl5000)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, sgtl5000);
> +
> +	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> +		struct regulator *reg;
> +		reg = regulator_get(&client->dev, supply_names[i]);
> +		if (IS_ERR(reg))
> +			continue;
> +
> +		sgtl5000->regulator_volt[i] = regulator_get_voltage(reg) / 1000;
> +		regulator_enable(reg);
> +
> +		sgtl5000->supplies[i] = reg;
> +	}
> +
> +	sgtl5000->regulator_volt[VDDA] = 3300;
> +	sgtl5000->regulator_volt[VDDIO] = 3300;

uh ? if you have some regulator declared for vdda/vddio why overriding
their value ? 1.8V is also a valid voltage value.


Arnaud
