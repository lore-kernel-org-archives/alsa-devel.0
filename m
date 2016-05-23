From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/2] ASoC: wm8985: add support for WM8758
Date: Mon, 23 May 2016 15:55:39 +0100
Message-ID: <20160523145539.GD20422@localhost.localdomain>
References: <1464012685-1142-1-git-send-email-petr@barix.com>
 <1464012685-1142-3-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id DFA0B2651E3
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 16:55:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1464012685-1142-3-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: plamen@barix.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2016 at 04:11:25PM +0200, Petr Kulhavy wrote:
> The WM8758 chip is almost identical to WM8985 with the difference that it
> doesn't feature the AUX input. This patch adds the WM8758 support into the
> WM8985 driver.
> 
> The chip selection is done by the I2C name. The SPI probe supports only
> the WM8985.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
> v1: initial
> v2: use chip type enum instead of chip structure
>     do not copy the complete controls, widget, routes but only the differences and 
>     add widgets dynamically using add_widgets()
> v3: merge the wm8985_xxx_snd_controls into wm8985_common_snd_controls and wm8985_specific_snd_controls
>     in order to reduce the number of structures
>     use the static initialization in snd_soc_codec_driver for the common part
> 
>  sound/soc/codecs/Kconfig  |   2 +-
>  sound/soc/codecs/wm8985.c | 160 +++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 123 insertions(+), 39 deletions(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 649e92a252ae..5947e0c94d02 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -933,7 +933,7 @@ config SND_SOC_WM8983
>  	tristate
>  
>  config SND_SOC_WM8985
> -	tristate
> +	tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
>  
>  config SND_SOC_WM8988
>  	tristate
> diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
> index 42696e709580..232f4b2418d7 100644
> --- a/sound/soc/codecs/wm8985.c
> +++ b/sound/soc/codecs/wm8985.c
> @@ -1,10 +1,13 @@
>  /*
> - * wm8985.c  --  WM8985 ALSA SoC Audio driver
> + * wm8985.c  --  WM8985 / WM8758 ALSA SoC Audio driver
>   *
>   * Copyright 2010 Wolfson Microelectronics plc
> - *
>   * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
>   *
> + * WM8758 support:
> + * Copyright: 2016 Barix AG
> + * Author: Petr Kulhavy <petr@barix.com>
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> @@ -40,6 +43,11 @@ static const char *wm8985_supply_names[WM8985_NUM_SUPPLIES] = {
>  	"AVDD2"
>  };
>  
> +enum wm8985_type {
> +	WM8985,
> +	WM8758,
> +};
> +
>  static const struct reg_default wm8985_reg_defaults[] = {
>  	{ 1,  0x0000 },     /* R1  - Power management 1 */
>  	{ 2,  0x0000 },     /* R2  - Power management 2 */
> @@ -181,6 +189,7 @@ static const int volume_update_regs[] = {
>  struct wm8985_priv {
>  	struct regmap *regmap;
>  	struct regulator_bulk_data supplies[WM8985_NUM_SUPPLIES];
> +	enum wm8985_type dev_type;
>  	unsigned int pllout;	/* input rate to the MCLKDIV divider */
>  };
>  
> @@ -283,7 +292,7 @@ static const char *depth_3d_text[] = {
>  static const SOC_ENUM_SINGLE_DECL(depth_3d, WM8985_3D_CONTROL, 0,
>  				  depth_3d_text);
>  
> -static const struct snd_kcontrol_new wm8985_snd_controls[] = {
> +static const struct snd_kcontrol_new wm8985_common_snd_controls[] = {
>  	SOC_SINGLE("Digital Loopback Switch", WM8985_COMPANDING_CONTROL,
>  		0, 1, 0),
>  
> @@ -317,6 +326,10 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
>  	SOC_DOUBLE("ADC Inversion Switch", WM8985_ADC_CONTROL, 0, 1, 1, 0),
>  	SOC_SINGLE("ADC 128x Oversampling Switch", WM8985_ADC_CONTROL, 8, 1, 0),
>  
> +	SOC_SINGLE("High Pass Filter Switch", WM8985_ADC_CONTROL, 8, 1, 0),
> +	SOC_ENUM("High Pass Filter Mode", filter_mode),
> +	SOC_SINGLE("High Pass Filter Cutoff", WM8985_ADC_CONTROL, 4, 7, 0),
> +

Why are these moving? Eases review to keep unrelated changes out
of the patch.

>  	SOC_DOUBLE_R_TLV("Playback Volume", WM8985_LEFT_DAC_DIGITAL_VOL,
>  		WM8985_RIGHT_DAC_DIGITAL_VOL, 0, 255, 0, dac_tlv),
>  
> @@ -344,15 +357,6 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
>  		WM8985_ROUT2_SPK_VOLUME_CTRL, 7, 1, 0),
>  	SOC_DOUBLE_R("Speaker Switch", WM8985_LOUT2_SPK_VOLUME_CTRL,
>  		WM8985_ROUT2_SPK_VOLUME_CTRL, 6, 1, 1),
> -
> -	SOC_SINGLE("High Pass Filter Switch", WM8985_ADC_CONTROL, 8, 1, 0),
> -	SOC_ENUM("High Pass Filter Mode", filter_mode),
> -	SOC_SINGLE("High Pass Filter Cutoff", WM8985_ADC_CONTROL, 4, 7, 0),
> -
> -	SOC_DOUBLE_R_TLV("Aux Bypass Volume",
> -		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 6, 7, 0,
> -		aux_tlv),
> -
>  	SOC_DOUBLE_R_TLV("Input PGA Bypass Volume",
>  		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 2, 7, 0,
>  		bypass_tlv),
> @@ -373,6 +377,12 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
>  	SOC_SINGLE_TLV("EQ5 Volume", WM8985_EQ5_HIGH_SHELF, 0, 24, 1, eq_tlv),
>  
>  	SOC_ENUM("3D Depth", depth_3d),
> +};
> +
> +static const struct snd_kcontrol_new wm8985_specific_snd_controls[] = {
> +	SOC_DOUBLE_R_TLV("Aux Bypass Volume",
> +		WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 6, 7, 0,
> +		aux_tlv),
>  
>  	SOC_ENUM("Speaker Mode", speaker_mode)
>  };
> @@ -389,6 +399,16 @@ static const struct snd_kcontrol_new right_out_mixer[] = {
>  	SOC_DAPM_SINGLE("PCM Switch", WM8985_RIGHT_MIXER_CTRL, 0, 1, 0),
>  };
>  
> +static const struct snd_kcontrol_new wm8758_left_out_mixer[] = {
> +	SOC_DAPM_SINGLE("Line Switch", WM8985_LEFT_MIXER_CTRL, 1, 1, 0),
> +	SOC_DAPM_SINGLE("PCM Switch", WM8985_LEFT_MIXER_CTRL, 0, 1, 0),
> +};
> +
> +static const struct snd_kcontrol_new wm8758_right_out_mixer[] = {
> +	SOC_DAPM_SINGLE("Line Switch", WM8985_RIGHT_MIXER_CTRL, 1, 1, 0),
> +	SOC_DAPM_SINGLE("PCM Switch", WM8985_RIGHT_MIXER_CTRL, 0, 1, 0),
> +};
> +

I would be tempted to put the "Aux Switch" at the end of the
existing array and then just specifying different sizes for each
part in the SND_SOC_DAPM_MIXER macro, saves the need to duplicate
these.

>  static const struct snd_kcontrol_new left_input_mixer[] = {
>  	SOC_DAPM_SINGLE("L2 Switch", WM8985_INPUT_CTRL, 2, 1, 0),
>  	SOC_DAPM_SINGLE("MicN Switch", WM8985_INPUT_CTRL, 1, 1, 0),
> @@ -401,6 +421,16 @@ static const struct snd_kcontrol_new right_input_mixer[] = {
>  	SOC_DAPM_SINGLE("MicP Switch", WM8985_INPUT_CTRL, 4, 1, 0),
>  };
>  
> +static const struct snd_kcontrol_new wm8758_left_boost_mixer[] = {
> +	SOC_DAPM_SINGLE_TLV("L2 Volume", WM8985_LEFT_ADC_BOOST_CTRL,
> +		4, 7, 0, boost_tlv),
> +};
> +
> +static const struct snd_kcontrol_new wm8758_right_boost_mixer[] = {
> +	SOC_DAPM_SINGLE_TLV("R2 Volume", WM8985_RIGHT_ADC_BOOST_CTRL,
> +		4, 7, 0, boost_tlv),
> +};

Ditto.

Apart from those minor comments this looks good to me though.

Thanks,
Charles
