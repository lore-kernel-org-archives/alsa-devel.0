From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Add FreeScale SGTL5000 codec
	suppor
Date: Mon, 17 Jan 2011 15:32:11 +0000
Message-ID: <20110117153210.GJ21113@opensource.wolfsonmicro.com>
References: <20110117064816.GA2158@ubuntu.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D877E10386D
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 16:32:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110117064816.GA2158@ubuntu.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zengzm.kernel@gmail.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, zhaoming.zeng@freescale.com, lrg@slimlogic.co.uk, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 17, 2011 at 02:48:54PM +0800, Zeng Zhaoming wrote:
> v1 url:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-December/034615.html
> 
> Changes since v1:
>   - Add DAPM widges as Mark and Arnaud point out.
>   - cleanup regulator code
>   - new implement dai_ops functions
>   - sort configs in Kconfig and Makefile

> From 1704fd5e7cf2540e247aa8a4f69d81ae5e6cbd4e Mon Sep 17 00:00:00 2001
> From: Zeng Zhaoming <zengzm.kernel@gmail.com>
> Date: Mon, 17 Jan 2011 10:34:42 +0800

Please submit patches in the form documented in SubmittingPatches.  In
particular please don't send as an attachement, particularly not with
extraneous stuff before the changelog.

> +struct sgtl5000_priv {
> +	int sysclk;	/* sysclk rate */
> +	int master;	/* i2s master or not? */
> +	int fmt;	/* i2s data format */
> +	int lrclk;	/* frame clock rate */
> +	int capture_channels;	/* the num of channels for capture. */
> +	int small_pop;	/* hw assistant to eliminate pop */

It's not clear why you're storing some of this stuff in the private data
- for example, capture_channels is only referred to in the place where
it is set (so you may as well use the original value) and small_pop is
set unconditionally (it looks like the intention was to have platform
data for it?).

> +static int mic_bias_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	/* change mic bias resistor to 4Kohm */
> +	snd_soc_write(w->codec, SGTL5000_CHIP_MIC_CTRL, SGTL5000_BIAS_R_4k);
> +
> +	return 0;
> +}

This seems really odd - this does the write unconditionally regardless
of event and never turns anything off.  If this can't just be set once
at startup then a comment explaining why an event is needed would be
good.

> +static int dac_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> +			SGTL5000_VAG_POWERUP|SGTL5000_DAC_POWERUP,
> +			SGTL5000_VAG_POWERUP|SGTL5000_DAC_POWERUP);
> +		break;
> +
> +	case SND_SOC_DAPM_POST_PMD:
> +		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> +			SGTL5000_DAC_POWERUP, 0);
> +		break;

Why does the powerdown not disable VAG_POWERUP?  My first thought was
that VAG_POWERUP ought to be a supply widget...

> +static int adc_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> +		SGTL5000_DAC_POWERUP,
> +		SGTL5000_DAC_POWERUP);
> +

Again, this is really unclear.

> +/* custom function to get of PCM playback volume */
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
> +
> +	/* revert it */
> +	l = 0xfc - l;
> +	r = 0xfc - r;

This is really unclear.  The lack of any comments and use of the ternery
operator isn't helping...  I'd suggest describing the register semantics
in a comment.

It also looks like you're missing some locking.

> +	l = ucontrol->value.integer.value[0];
> +	r = ucontrol->value.integer.value[1];
> +
> +	l = l < 0 ? 0 : l;
> +	l = l > 0xfc - 0x3c ? 0xfc - 0x3c : l;
> +	r = r < 0 ? 0 : r;
> +	r = r > 0xfc - 0x3c ? 0xfc - 0x3c : r;
> +	l = 0xfc - l;
> +	r = 0xfc - r;

Likewise.

> +	/* we need SOC_DOUBLE_S8_TLV with invert */
> +	{
> +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +		.name = "PCM Playback Volume",
> +		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |
> +			SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +		.info = dac_info_volsw,
> +		.get = dac_get_volsw,
> +		.put = dac_put_volsw,
> +	},

Perhaps implementing the abstract type would help with the clarity
issues?

> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBS_CFM:
> +		return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Could just have the default: case.

> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		sgtl5000->capture_channels = channels;
> +
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +		reg |= SGTL5000_ADC_POWERUP;
> +
> +		if (sgtl5000->capture_channels == 1)
> +			reg &= ~SGTL5000_ADC_STEREO;
> +		else
> +			reg |= SGTL5000_ADC_STEREO;
> +
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +	}

snd_soc_update_bits().

> +	/* get devided factor of frame clock */
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

I'd expect to see this error out if it can't find an appropriate
divider?

> +	if ((clk_ctl & SGTL5000_MCLK_FREQ_MASK) == SGTL5000_MCLK_FREQ_PLL) {
> +		snd_soc_write(codec, SGTL5000_CHIP_PLL_CTRL, pll_ctl);

This looks very odd - why has pll_ctrl been precomputed if it's only
going to be used here?

> +/*
> + * set dac bias
> + * common state changes:
> + * startup:
> + * off --> standby --> prepare --> on
> + * standby --> prepare --> on
> + *
> + * stop:
> + * on --> prepare --> standby
> + */
> +static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
> +				   enum snd_soc_bias_level level)
> +{
> +	codec->bias_level = level;
> +	return 0;
> +}

May as well remove this, it does nothing.

> +#define SGTL5000_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			SNDRV_PCM_FMTBIT_S20_3LE |\
> +			SNDRV_PCM_FMTBIT_S24_LE)

Your hw_params() claimed 32 bit support too.

> +	/* setup i2c data ops */
> +	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}

Your resume code might get a bit clearer if you were able to use the
standard cache sync functionality that the generic register cache code
has.

> +	/* get and enable all regulators */
> +	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> +		struct regulator *reg;
> +		reg = regulator_get(codec->dev, supply_names[i]);
> +
> +		if (IS_ERR(reg))
> +			continue;
> +
> +		regulator_enable(reg);
> +		sgtl5000->supplies[i] = reg;
> +	}
> +
> +	/* vdda and vddio regulator must configed */
> +	if (!sgtl5000->supplies[VDDA] || !sgtl5000->supplies[VDDIO]) {
> +		dev_err(codec->dev,
> +			"Not set vdda or vddio regulator correctly\n");
> +		/* FIXME, no such platform regulator configed */
> +		return -ENODEV;
> +	}

This looks rather wrong; you're not clearing up any regulators you did
get, you're not logging any errors if you fail to get regulators and
it's *very* unusual to see any supplies being optional.  You certainly
need comments here.

> +	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA]) / 1000;
> +	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO]) / 1000;
> +
> +	if (regulator_get_voltage(sgtl5000->supplies[VDDD]))
> +		vddd = regulator_get_voltage(sgtl5000->supplies[VDDD]) / 1000;
> +	else
> +		vddd = 0;
> +
> +	/* workaround for rev 0x11: use vddd linear regulator */
> +	if (!vddd || (rev >= 0x11)) {
> +		/* set VDDD to 1.2v */
> +		lreg_ctrl |= 0x8 << SGTL5000_LINREG_VDDD_SHIFT;
> +		/* power internal linear regulator */
> +		ana_pwr |= SGTL5000_LINEREG_D_POWERUP;
> +	} else {
> +		/* turn of startup power */
> +		ana_pwr &= ~SGTL5000_STARTUP_POWERUP;
> +		ana_pwr &= ~SGTL5000_LINREG_SIMPLE_POWERUP;
> +	}

If you have an internal LDO that can optinally be used it'd probably be
better to have it visible via the regulator API.  Also, if the internal
regulator is in use surely an external supply should be left off?

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

The above block of code calculates a value for vag but does nothing with
it before it's overwritten here...

> +	if (vag <= SGTL5000_LINE_OUT_GND_BASE)
> +		vag = 0;
> +	else if (vag >= SGTL5000_LINE_OUT_GND_BASE + SGTL5000_LINE_OUT_GND_STP *
> +		 SGTL5000_LINE_OUT_GND_MAX)
> +		vag = SGTL5000_LINE_OUT_GND_MAX;
> +	else
> +		vag = (vag - SGTL5000_LINE_OUT_GND_BASE) /
> +		    SGTL5000_LINE_OUT_GND_STP;

...then there's no immediate use of this calculation either, instead we
start doing...

> +
> +	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
> +	msleep(10);
> +

...this.  It'd most likely be *much* clearer if the calculations and
register writes were kept together.

> +static const struct i2c_device_id sgtl5000_id[] = {
> +	{"sgtl5000-codec", 0},
> +	{},
> +};

Remove the -codec, it's not at all idiomatic.

> +	.driver = {
> +		   .name = "sgtl5000-codec",
> +		   .owner = THIS_MODULE,

Please remove it here too.
