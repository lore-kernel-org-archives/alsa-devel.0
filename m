From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 1/3] ASoC: add support for alc562[123]
	codecs
Date: Tue, 7 Sep 2010 11:21:12 +0100
Message-ID: <20100907102112.GE7886@rakim.wolfsonmicro.main>
References: <20100907070127.305740006@rtp-net.org>
	<20100907071008.224980268@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E6202449B
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 12:21:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100907071008.224980268@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2010 at 09:01:28AM +0200, Arnaud Patard wrote:
> This patch is adding support for alc562[123] codecs. It's based
> on the source code available in HP source code and other places.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

> +++ sound-2.6/sound/soc/codecs/Kconfig	2010-09-06 23:29:31.000000000 +0200
> @@ -159,6 +159,9 @@
>  config SND_SOC_PCM3008
>         tristate
>  
> +config SND_SOC_ALC5623
> +       tristate
> +

Keep this and the Makefile sorted.  Also remember to add this to
SND_SOC_ALL_CODECS.

> +#define ALC5623_VERSION "0.01"

git should provide enough tracking for version numbers.

> +static int caps_charge = 2000;
> +module_param(caps_charge, int, 0);
> +MODULE_PARM_DESC(caps_charge, "ALC5623 cap charge time (msecs)");

> +static int alc5623_write_mask(struct snd_soc_codec *codec, unsigned int reg,
> +		unsigned int value, unsigned int mask)

This is snd_soc_update_bits().

> +/*
> + * problem is :
> + * - hp mixer has 2 bits in PM reg 0x3C
> + * - adc input of the hp mixer has 2 mute bits
> + * - all the other inputs of the hp mixer have 1 bit
> + * =>  the bits for adc and pm can't be used separately
> + */
> +static int hp_mixer_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	u16 reg;
> +	u16 mask = ALC5623_PWR_ADD2_L_HP_MIXER|ALC5623_PWR_ADD2_R_HP_MIXER;
> +
> +	reg = snd_soc_read(w->codec, ALC5623_PWR_MANAG_ADD2);
> +	reg &= ~mask;
> +	if (event == SND_SOC_DAPM_POST_PMU)
> +		reg |= mask;
> +	return snd_soc_write(w->codec, ALC5623_PWR_MANAG_ADD2, reg);
> +}

It looks like it'd be simpler to do something like:

	{ "HPL", NULL, "HP" },
	{ "HPR", NULL, "HP" },

then have the two ADC channels feed into the left and right channels of
the headphone while having the single switches feed into the HP widget
(which would be a NOPM dummy widget for routing purposes).

> +static int amp_mixer_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	/* index 0x46: class-d internal register */
> +	snd_soc_write(w->codec, ALC5623_HID_CTRL_INDEX, 0x46);
> +	if (event == SND_SOC_DAPM_PRE_PMU)
> +		snd_soc_write(w->codec, ALC5623_HID_CTRL_DATA, 0xFFFF);
> +	else
> +		snd_soc_write(w->codec, ALC5623_HID_CTRL_DATA, 0);
> +	return 0;
> +}

A switch statement would be more idiomatic here.

> +static const struct soc_enum alc5623_enum[] = {
> +SOC_ENUM_SINGLE(ALC5623_OUTPUT_MIXER_CTRL, 14, 4, alc5623_spk_n_sour_sel),
> +SOC_ENUM_SINGLE(ALC5623_OUTPUT_MIXER_CTRL, 9, 2, alc5623_hpl_out_input_sel),

Don't put your enums in an array, declare them as variables.  The enum
arrays are harder to read and vastly more error prone.

> +	if (pll_div) {
> +		snd_soc_write(codec, ALC5623_GLOBAL_CLK_CTRL_REG, gbl_clk);
> +		snd_soc_write(codec, ALC5623_PLL_CTRL, pll_div);
> +		alc5623_write_mask(codec, ALC5623_PWR_MANAG_ADD2,
> +					ALC5623_PWR_ADD2_PLL,
> +					ALC5623_PWR_ADD2_PLL);
> +		gbl_clk |= ALC5623_GBL_CLK_SYS_SOUR_SEL_PLL;
> +		snd_soc_write(codec, ALC5623_GLOBAL_CLK_CTRL_REG, gbl_clk);
> +	}

Should complain if we fail to find a configuration.

> +#define ALC5623_ADD3_POWER_EN (ALC5623_PWR_ADD3_MAIN_BIAS \
> +	| ALC5623_PWR_ADD3_MIC1_BOOST_AD)

> +#define ALC5623_ADD1_POWER_EN \
> +	(ALC5623_PWR_ADD1_MAIN_I2S_EN | ALC5623_PWR_ADD1_MIC1_BIAS_EN \
> +	| ALC5623_PWR_ADD1_SHORT_CURR_DET_EN | ALC5623_PWR_ADD1_SOFTGEN_EN \
> +	| ALC5623_PWR_ADD1_DEPOP_BUF_HP | ALC5623_PWR_ADD1_HP_OUT_AMP \
> +	| ALC5623_PWR_ADD1_HP_OUT_ENH_AMP)

> +#define ALC5623_ADD1_POWER_EN_5622 \
> +	(ALC5623_PWR_ADD1_MAIN_I2S_EN | ALC5623_PWR_ADD1_MIC1_BIAS_EN \
> +	| ALC5623_PWR_ADD1_SHORT_CURR_DET_EN \
> +	| ALC5623_PWR_ADD1_HP_OUT_AMP)

Most of the stuff in here looks like it ought to be managed by DAPM?

> +static int alc5623_probe(struct snd_soc_codec *codec)
> +{
> +	struct alc5623_priv *alc5623 = snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	INIT_DELAYED_WORK(&codec->delayed_work, alc5623_work);
> +	schedule_delayed_work(&codec->delayed_work,
> +				msecs_to_jiffies(caps_charge));

Since we now support out of line resume for ASoC devices (so we don't
hold up the rest of the system) it should be possible to just do this
stuff in the set_bias_level() function rather than faffing around with
delayed work like this.  This is less racy.

> +	alc5623_reset(codec);
> +	alc5623_fill_cache(codec);

Don't we know the defaults for the device?

> +	if (alc5623->add_ctrl) {
> +		snd_soc_write(codec, ALC5623_ADD_CTRL_REG,
> +				alc5623->add_ctrl);
> +	}

Hrm?

> +	if (alc5623->jack_det_ctrl) {
> +		snd_soc_write(codec, ALC5623_JACK_DET_CTRL,
> +				alc5623->jack_det_ctrl);
> +	}

I didn't see any jack detection support in the driver, and I wouldn't
expect to see anything exported to userspace for it?

> +	if ((vid1 != 0x10ec) || (vid2 != id->driver_data)) {
> +		dev_err(&client->dev, "unknown or wrong codec\n");
> +		return -ENODEV;
> +	}

Better to say what the IDs you were looking at are, especially for id2.

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ sound-2.6/include/linux/alc5623.h	2010-09-06 23:29:31.000000000 +0200

include/sound

> @@ -0,0 +1,8 @@
> +#ifndef _INCLUDE_LINUX_ALC5623_H
> +#define _INCLUDE_LINUX_ALC5623_H
> +struct alc5623_platform_data {
> +	unsigned int add_ctrl;
> +	unsigned int jack_det_ctrl;
> +};

Some documentation explaining what these are would probably be useful.
