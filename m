From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add Freescale SGTL5000 codec
	support
Date: Wed, 16 Feb 2011 19:53:14 +0000
Message-ID: <20110216195314.GA29547@opensource.wolfsonmicro.com>
References: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 660DE103858
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 20:53:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, zengzm.kernel@gmail.com, lrg@slimlogic.co.uk, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 16, 2011 at 06:56:16AM +0800, zhaoming.zeng@freescale.com wrote:

> +static int mic_bias_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	/* change mic bias resistor to 4Kohm */
> +	snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
> +			SGTL5000_BIAS_R_4k, SGTL5000_BIAS_R_4k);
> +
> +	return 0;
> +}

I'd expect something to power off the mic bias when there's a power off
event.

> +	reg = snd_soc_read(codec, SGTL5000_CHIP_DAC_VOL);
> +	l = (reg & SGTL5000_DAC_VOL_LEFT_MASK) >> SGTL5000_DAC_VOL_LEFT_SHIFT;
> +	r = (reg & SGTL5000_DAC_VOL_RIGHT_MASK) >> SGTL5000_DAC_VOL_RIGHT_SHIFT;
> +	l = l < 0x3c ? 0x3c : l;
> +	l = l > 0xfc ? 0xfc : l;
> +	r = r < 0x3c ? 0x3c : r;
> +	r = r > 0xfc ? 0xfc : r;

My previous comments about the lebility of this still stand.

> +/* need SOC_DOUBLE_S8_TLV with invert */
> +#define SGTL5000_PCM_PLAYBACK_CONTROL	\
> +	 {			\
> +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,	\
> +		.name = "PCM Playback Volume",		\
> +		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |	\
> +			SNDRV_CTL_ELEM_ACCESS_READWRITE,	\
> +		.info = dac_info_volsw,				\
> +		.get = dac_get_volsw,				\
> +		.put = dac_put_volsw,				\
> +	}

Since there's no macro arguments this could just be defined directly in
line.

> +	SOC_SINGLE("Capture Attenuate Switch (-6db)",
> +		SGTL5000_CHIP_ANA_ADC_CTRL,
> +		8, 1, 0),

This should be a TLV control (-6 to 0 in steps of 6 dB) with Volume
rather than Switch.

> +	/* set devided factor of frame clock */
> +	switch (sys_fs / frame_rate) {
> +	case 4:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_4 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	case 2:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_2 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	/*
> +	 * this implict case 1:
> +	 * because default: sys_fs = lrclk;
> +	 */
> +	default:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_1 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	}

This would be much better off as case 1: with a default returning an
error in case the user has misclocked the device.  For example, if the
ratio were to wind up as 8 then we'd accept that.

> +	/*
> +	 * calculate the divider of mclk/sample_freq,
> +	 * factor of freq =96k can only be 256, since mclk in range (12m,27m)
> +	 */
> +	if (sys_fs * 256 == sgtl5000->sysclk)
> +		clk_ctl |= SGTL5000_MCLK_FREQ_256FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;
> +	else if (sys_fs * 384 == sgtl5000->sysclk)
> +		clk_ctl |= SGTL5000_MCLK_FREQ_384FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;
> +	else if (sys_fs * 512 == sgtl5000->sysclk)
> +		clk_ctl |= SGTL5000_MCLK_FREQ_512FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;

This'd be clearer as a switch on sysfs / sysclk with this:

> +	else {
> +		/* if mclk not satisify the divider, using pll */
> +		if (sgtl5000->master)
> +			clk_ctl |= SGTL5000_MCLK_FREQ_PLL <<
> +				SGTL5000_MCLK_FREQ_SHIFT;
> +		else {
> +			pr_err("%s: PLL not supported in slave mode\n",
> +				__func__);
> +			return -EINVAL;
> +		}

as the default.

> +	} else
> +		/* power down pll */
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> +			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP,
> +			0);

Use { } for the else case if the main case uses them.

> +	case SND_SOC_BIAS_STANDBY:
> +		if (codec->bias_level == SND_SOC_BIAS_OFF) {
> +			for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> +				if (!sgtl5000->supplies[i])
> +					continue;
> +				regulator_enable(sgtl5000->supplies[i]);

Why are the supplies optional?

> +	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA]) / 1000;
> +	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO]) / 1000;

You're not checking these for errors.

> +	if (sgtl5000->supplies[VDDD])
> +		vddd = regulator_get_voltage(sgtl5000->supplies[VDDD]) / 1000;
> +	else
> +		vddd = 0;

If VDD is optional it'd seem easier to substitute in a fixed voltage
regulator when it's not detected.  It'd make the code much more
idiomatic and save having to special case missing regulators everywhere.

> +	if (!vddd) {
> +		/* set VDDD to 1.2v */
> +		lreg_ctrl |= 0x8 << SGTL5000_LINREG_VDDD_SHIFT;
> +		/* power up internal linear regulator */
> +		ana_pwr |= SGTL5000_LINEREG_D_POWERUP |
> +				SGTL5000_LINREG_SIMPLE_POWERUP |
> +				SGTL5000_STARTUP_POWERUP;
> +	}

Or even implement an actual regulator driver for it.

> +	/* set default volume of adc */
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_ADC_CTRL);
> +	reg &= ~SGTL5000_ADC_VOL_M6DB;
> +	reg &= ~(SGTL5000_ADC_VOL_LEFT_MASK | SGTL5000_ADC_VOL_RIGHT_MASK);
> +	reg |= (0xf << SGTL5000_ADC_VOL_LEFT_SHIFT)
> +	    | (0xf << SGTL5000_ADC_VOL_RIGHT_SHIFT);
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_ADC_CTRL, reg);

Leave this up to userspace.
