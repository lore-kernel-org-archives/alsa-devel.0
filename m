From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH v4] ASoC: Add Freescale SGTL5000 codec
	support
Date: Wed, 23 Feb 2011 08:47:48 +0100
Message-ID: <87r5az5h0b.fsf@lebrac.rtp-net.org>
References: <1298246965-22575-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lebrac.rtp-net.org (lebrac.rtp-net.org [88.191.135.105])
	by alsa0.perex.cz (Postfix) with ESMTP id A22A6103800
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 08:48:00 +0100 (CET)
In-Reply-To: <1298246965-22575-1-git-send-email-zhaoming.zeng@freescale.com>
	(zhaoming zeng's message of "Mon, 21 Feb 2011 08:09:25 +0800")
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, timur.tabi@gmail.com, zengzm.kernel@gmail.com, linuxzsc@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

<zhaoming.zeng@freescale.com> writes:

Hi,

[...]

> +/*
> + * set clock according to i2s frame clock,
> + * sgtl5000 provide 2 clock sources.
> + * 1. sys_mclk. sample freq can only configure to
> + *	1/256, 1/384, 1/512 of sys_mclk.
> + * 2. pll. can derive any audio clocks.
> + *
> + * clock setting rules:
> + * 1. in slave mode, only sys_mclk can use.
> + * 2. as constraint by sys_mclk, sample freq should
> + *	set to 32k, 44.1k and above.
> + * 3. using sys_mclk prefer to pll to save power.
> + */
> +static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
> +{
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	int clk_ctl = 0;
> +	int sys_fs;	/* sample freq */
> +
> +	/*
> +	 * sample freq should be divided by frame clock,
> +	 * if frame clock lower than 44.1khz, sample feq should set to
> +	 * 32khz or 44.1khz.
> +	 */
> +	switch (frame_rate) {
> +	case 8000:
> +	case 16000:
> +		sys_fs = 32000;
> +		break;
> +	case 11025:
> +	case 22050:
> +		sys_fs = 44100;
> +		break;
> +	default:
> +		sys_fs = frame_rate;
> +		break;
> +	}
> +
> +	/* set devided factor of frame clock */
> +	switch (sys_fs / frame_rate) {
> +	case 4:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_4 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	case 2:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_2 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	case 1:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_1 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* set the sys_fs accroding to frame rate */
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
> +		dev_err(codec->dev, "frame rate %d not supported\n",
> +			frame_rate);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * calculate the divider of mclk/sample_freq,
> +	 * factor of freq =96k can only be 256, since mclk in range (12m,27m)
> +	 */
> +	switch (sgtl5000->sysclk / sys_fs) {
> +	case 256:
> +		clk_ctl |= SGTL5000_MCLK_FREQ_256FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;
> +		break;
> +	case 384:
> +		clk_ctl |= SGTL5000_MCLK_FREQ_384FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;
> +		break;
> +	case 512:
> +		clk_ctl |= SGTL5000_MCLK_FREQ_512FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;
> +		break;
> +	default:
> +		/* if mclk not satisify the divider, use pll */
> +		if (sgtl5000->master)
> +			clk_ctl |= SGTL5000_MCLK_FREQ_PLL <<
> +				SGTL5000_MCLK_FREQ_SHIFT;
> +		else {
> +			pr_err("%s: PLL not supported in slave mode\n",
> +				__func__);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* if using pll, please check manual 6.4.2 for detail */
> +	if ((clk_ctl & SGTL5000_MCLK_FREQ_MASK) == SGTL5000_MCLK_FREQ_PLL) {
> +		u64 out, t;
> +		int div2;
> +		int pll_ctl;
> +		unsigned int in, int_div, frac_div;

btw, I don't know for other developers, but I don't like variables
declared like this.

> +
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
> +
> +		snd_soc_write(codec, SGTL5000_CHIP_PLL_CTRL, pll_ctl);
> +		if (div2)
> +			snd_soc_update_bits(codec,
> +				SGTL5000_CHIP_CLK_TOP_CTRL,
> +				SGTL5000_INPUT_FREQ_DIV2,
> +				SGTL5000_INPUT_FREQ_DIV2);
> +		else
> +			snd_soc_update_bits(codec,
> +				SGTL5000_CHIP_CLK_TOP_CTRL,
> +				SGTL5000_INPUT_FREQ_DIV2,
> +				0);
> +
> +		/* power up pll */
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> +			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP,
> +			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP);
> +	} else {
> +		/* power down pll */
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> +			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP,
> +			0);
> +	}
> +
> +	/* if using pll, clk_ctrl must be set after pll power up */
> +	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL, clk_ctl);
> +
> +	return 0;
> +}
> +

[...]

> +static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
> +{
> +	u16 reg;
> +	int ret;
> +	int rev, i;
> +	int external_vddd = 0;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
> +		sgtl5000->supplies[i].supply = supply_names[i];
> +
> +	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);

so here, you're calling '_get' for vdda, vddd, vddio.

> +	if (!ret)
> +		external_vddd = 1;
> +	else {
> +		/* set internal ldo to 1.2v */
> +		int voltage = LDO_VOLTAGE;
> +
> +		sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
> +
> +		ret = ldo_regulator_register(codec, &ldo_init_data, voltage);
> +		if (ret) {
> +			dev_err(codec->dev,
> +			"Failed to register vddd internal supplies: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		ret = regulator_bulk_get(codec->dev,
> +				ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);
> +
> +		if (ret) {
> +			ldo_regulator_remove(codec);
> +			dev_err(codec->dev,
> +				"Failed to request supplies: %d\n", ret);
> +
> +			return ret;
> +		}
> +	}
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
> +					sgtl5000->supplies);
> +	if (ret)
> +		goto err_regulator_free;
> +
> +	/* wait for all power rails bring up */
> +	udelay(10);
> +
> +	/* read chip information */
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_ID);
> +	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
> +	    SGTL5000_PARTID_PART_ID) {
> +		dev_err(codec->dev,
> +			"Device with ID register %x is not a sgtl5000\n", reg);
> +		ret = -ENODEV;
> +		goto err_regulator_disable;
> +	}
> +
> +	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
> +	dev_info(codec->dev, "sgtl5000 revision %d\n", rev);
> +
> +	/*
> +	 * workaround for revision 0x11 and later,
> +	 * roll back to use internal LDO
> +	 */
> +	if (external_vddd && rev >= 0x11) {
> +		int voltage = LDO_VOLTAGE;
> +		/* disable all regulator first */
> +		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
> +					sgtl5000->supplies);
> +		/* free VDDD regulator */
> +		regulator_put(sgtl5000->supplies[VDDD].consumer);

so you call put for vddd only and in regulator_put there's a line doing
kfree(....consumer) so now sgtl5000->supplies[VDDD].consumer is null.

> +
> +		sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
> +
> +		ret = ldo_regulator_register(codec, &ldo_init_data, voltage);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_bulk_get(codec->dev,
> +				ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);

and here you're calling 'get' for vdda, vddio and vddd_lo. This means
that in this code path, you're requesting 2 times vdda/vddio. It's a
bug. You should call only regulator_get for vddd_lo and set
sgtl5000->supplies[VDDD].consumer in case of success. If you don't set
it, calling regulator_bulk_enable will result in a oops as .consumer is
null.


> +		if (ret) {
> +			ldo_regulator_remove(codec);
> +			dev_err(codec->dev,
> +				"Failed to request supplies: %d\n", ret);
> +
> +			return ret;
> +		}
> +
> +		ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
> +						sgtl5000->supplies);
> +		if (ret)
> +			goto err_regulator_free;
> +	}
> +
> +	return 0;
> +
> +err_regulator_disable:
> +	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);
> +err_regulator_free:
> +	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);
> +	if (external_vddd)
> +		ldo_regulator_remove(codec);
> +	return ret;
> +
> +}
> +static int sgtl5000_probe(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +
> +	/* setup i2c data ops */
> +	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = sgtl5000_enable_regulators(codec);
> +	if (ret)
> +		return ret;
> +
> +	/* power up sgtl5000 */
> +	ret = sgtl5000_set_power_regs(codec);
> +	if (ret)
> +		return ret;
> +
> +	/* enable small pop, introduce 400ms delay in turning off */
> +	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
> +				SGTL5000_SMALL_POP,
> +				SGTL5000_SMALL_POP);
> +
> +	/* disable short cut detector */
> +	snd_soc_write(codec, SGTL5000_CHIP_SHORT_CTRL, 0);
> +
> +	/*
> +	 * set i2s as default input of sound switch
> +	 * TODO: add sound switch to control and dapm widge.
> +	 */
> +	snd_soc_write(codec, SGTL5000_CHIP_SSS_CTRL,
> +			SGTL5000_DAC_SEL_I2S_IN << SGTL5000_DAC_SEL_SHIFT);
> +	snd_soc_write(codec, SGTL5000_CHIP_DIG_POWER,
> +			SGTL5000_ADC_EN | SGTL5000_DAC_EN);
> +
> +	/* enable dac volume ramp by default */
> +	snd_soc_write(codec, SGTL5000_CHIP_ADCDAC_CTRL,
> +			SGTL5000_DAC_VOL_RAMP_EN |
> +			SGTL5000_DAC_MUTE_RIGHT |
> +			SGTL5000_DAC_MUTE_LEFT);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x015f);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
> +			SGTL5000_HP_ZCD_EN |
> +			SGTL5000_ADC_ZCD_EN);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 0);
> +
> +	/*
> +	 * disable DAP
> +	 * TODO:
> +	 * Enable DAP in kcontrol and dapm.
> +	 */
> +	snd_soc_write(codec, SGTL5000_DAP_CTRL, 0);
> +
> +	/* leading to standby state */
> +	ret = sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	if (ret)
> +		return ret;
> +
> +	snd_soc_add_controls(codec, sgtl5000_snd_controls,
> +			     ARRAY_SIZE(sgtl5000_snd_controls));
> +
> +	snd_soc_dapm_new_controls(&codec->dapm, sgtl5000_dapm_widgets,
> +				  ARRAY_SIZE(sgtl5000_dapm_widgets));
> +
> +	snd_soc_dapm_add_routes(&codec->dapm, audio_map,
> +				ARRAY_SIZE(audio_map));
> +
> +	snd_soc_dapm_new_widgets(&codec->dapm);
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_remove(struct snd_soc_codec *codec)
> +{
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	snd_soc_dapm_free(&codec->dapm);

someone will have to check but iirc, the core is calling
snd_soc_dapm_free() for you after calling the remove() hook.


Arnaud
