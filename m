From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: codecs: Add da7219 codec driver
Date: Sat, 19 Sep 2015 10:44:14 -0700
Message-ID: <20150919174414.GJ30445@sirena.org.uk>
References: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
 <d709bef63c2dbef6b3d654435b50e183d1e7a1e7.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oplxJGu+Ee5xywIT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d709bef63c2dbef6b3d654435b50e183d1e7a1e7.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jason Coughlan <jason.coughlan@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--oplxJGu+Ee5xywIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2015 at 05:01:14PM +0100, Adam Thomson wrote:

> +	do {
> +		statusa = snd_soc_read(codec, DA7219_ACCDET_STATUS_A);
> +		if (statusa & DA7219_MICBIAS_UP_STS_MASK)
> +			micbias_up = true;
> +	} while (!micbias_up);

This could go into an inifinite loop.

> +static void da7219_aad_hptest_work(struct work_struct *work)
> +{
> +	struct da7219_aad_priv *da7219_aad =
> +		container_of(work, struct da7219_aad_priv, hptest_work);
> +	struct snd_soc_codec *codec = da7219_aad->codec;
> +	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
> +
> +	u8 tonegen_cfg1, tonegen_cfg2, tonegen_onper;
> +	u16 tonegen_freq1, tonegen_freq_hptest;
> +	u8 hpl_gain, hpr_gain, dacl_gain, dacr_gain, dac_filters1, dac_filters4;
> +	u8 dac_filters5, cp_ctrl, routing_dac, dacl_ctrl, dacr_ctrl;
> +	u8 mixoutl_sel, mixoutr_sel, st_outfilt_1l, st_outfilt_1r;
> +	u8 mixoutl_ctrl, mixoutr_ctrl, hpl_ctrl, hpr_ctrl, accdet_cfg8;
> +	int report = 0;
> +
> +	/* Save current settings */

This is obviously a massive reconfiguration of the device.  I'm not
seeing anything here which prevents userspace coming in and change the
configuration while we're in this function, that would obviously have
serious issues.

I'm also wondering if this might be more elegantly implemented by going
into cache bypass mode, doing the test and then using a cache resync to
restore the initial configuration.  That will at least avoid issues with
updates adding a new register but not modifying it.

> +			if (statusa & DA7219_JACK_TYPE_STS_MASK) {
> +				report |= SND_JACK_HEADSET;
> +				mask |=	SND_JACK_HEADSET | SND_JACK_LINEOUT;
> +				schedule_work(&da7219_aad->btn_det_work);
> +			} else {
> +				schedule_work(&da7219_aad->hptest_work);
> +			}

Why are we scheduling work - we're already in thread context?

> +			/* Un-drive headphones/lineout */
> +			snd_soc_update_bits(codec, DA7219_HP_R_CTRL,
> +					    DA7219_HP_R_AMP_OE_MASK, 0);
> +			snd_soc_update_bits(codec, DA7219_HP_L_CTRL,
> +					    DA7219_HP_L_AMP_OE_MASK, 0);

This looks like DAPM?

> +static enum da7219_aad_jack_ins_deb da7219_aad_of_jack_ins_deb(u32 val)
> +{
> +	switch (val) {
> +	case 5:
> +		return DA7219_AAD_JACK_INS_DEB_5MS;
> +	case 10:
> +		return DA7219_AAD_JACK_INS_DEB_10MS;
> +	case 20:
> +		return DA7219_AAD_JACK_INS_DEB_20MS;
> +	case 50:
> +		return DA7219_AAD_JACK_INS_DEB_50MS;
> +	case 100:
> +		return DA7219_AAD_JACK_INS_DEB_100MS;
> +	case 200:
> +		return DA7219_AAD_JACK_INS_DEB_200MS;
> +	case 500:
> +		return DA7219_AAD_JACK_INS_DEB_500MS;
> +	case 1000:
> +		return DA7219_AAD_JACK_INS_DEB_1S;
> +	default:
> +		return DA7219_AAD_JACK_INS_DEB_20MS;

This isn't an error?

> +/* Input/Output Enums */
> +static const char * const da7219_gain_ramp_rate_txt[] = {
> +	"nominal rate * 8", "nominal rate", "nominal rate / 8",
> +	"nominal rate / 16"
> +};

The ALSA ABI generally capitalises words.

> +/* ToneGen */
> +static int da7219_tonegen_freq_get(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
> +	struct soc_mixer_control *mixer_ctrl =
> +		(struct soc_mixer_control *) kcontrol->private_value;
> +	unsigned int reg = mixer_ctrl->reg;
> +	u16 val;
> +	int ret;
> +
> +	ret = regmap_bulk_read(da7219->regmap, reg, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	ucontrol->value.integer.value[0] = le16_to_cpu(val);

This is *weird*.  We do a bulk read for a single register using an API
that returns CPU endian data then make it CPU endian (without any
annotations on variables...).  Why not use regmap_read()?  Why swap?
Why not use raw I/O?

> +static int da7219_hpf_put(struct snd_kcontrol *kcontrol,
> +			  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
> +	unsigned int reg = enum_ctrl->reg;
> +	unsigned int sel = ucontrol->value.integer.value[0];
> +	unsigned int bits;
> +
> +	switch (sel) {
> +	case DA7219_HPF_MODE_DISABLED:
> +		bits = DA7219_HPF_DISABLED;
> +		break;
> +	case DA7219_HPF_MODE_AUDIO:
> +		bits = DA7219_HPF_AUDIO_EN;
> +		break;
> +	case DA7219_HPF_MODE_VOICE:
> +		bits = DA7219_HPF_VOICE_EN;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	snd_soc_update_bits(codec, reg, DA7219_HPF_MODE_MASK, bits);
> +
> +	return 0;
> +}

This looks like a standard enumeration with a simple mapping to the
register map?

> +
> +	/* ADCs */
> +	SOC_SINGLE_TLV("ADC Volume", DA7219_ADC_L_GAIN,
> +		       DA7219_ADC_L_DIGITAL_GAIN_SHIFT,
> +		       DA7219_ADC_L_DIGITAL_GAIN_MAX, DA7219_NO_INVERT,
> +		       da7219_adc_dig_gain_tlv),
> +	SOC_SINGLE("ADC Switch", DA7219_ADC_L_CTRL,
> +		   DA7219_ADC_L_MUTE_EN_SHIFT, DA7219_SWITCH_EN_MAX,
> +		   DA7219_INVERT),
> +	SOC_SINGLE("ADC Gain Ramp Switch", DA7219_ADC_L_CTRL,
> +		   DA7219_ADC_L_RAMP_EN_SHIFT, DA7219_SWITCH_EN_MAX,
> +		   DA7219_NO_INVERT),

Capture Digital rather than ADC.

> +	SOC_SINGLE_TLV("ALC Max Attenuation", DA7219_ALC_GAIN_LIMITS,
> +		       DA7219_ALC_ATTEN_MAX_SHIFT, DA7219_ALC_ATTEN_GAIN_MAX,
> +		       DA7219_NO_INVERT, da7219_alc_gain_tlv),
> +	SOC_SINGLE_TLV("ALC Max Gain", DA7219_ALC_GAIN_LIMITS,
> +		       DA7219_ALC_GAIN_MAX_SHIFT, DA7219_ALC_ATTEN_GAIN_MAX,
> +		       DA7219_NO_INVERT, da7219_alc_gain_tlv),
> +	SOC_SINGLE_RANGE_TLV("ALC Min Analog Gain", DA7219_ALC_ANA_GAIN_LIMITS,
> +			     DA7219_ALC_ANA_GAIN_MIN_SHIFT,
> +			     DA7219_ALC_ANA_GAIN_MIN, DA7219_ALC_ANA_GAIN_MAX,
> +			     DA7219_NO_INVERT, da7219_alc_ana_gain_tlv),
> +	SOC_SINGLE_RANGE_TLV("ALC Max Analog Gain", DA7219_ALC_ANA_GAIN_LIMITS,
> +			     DA7219_ALC_ANA_GAIN_MAX_SHIFT,
> +			     DA7219_ALC_ANA_GAIN_MIN, DA7219_ALC_ANA_GAIN_MAX,
> +			     DA7219_NO_INVERT, da7219_alc_ana_gain_tlv),

Volume not Gain.

> +	SOC_SINGLE("ToneGen DTMF Key", DA7219_TONE_GEN_CFG1,
> +		   DA7219_DTMF_REG_SHIFT, DA7219_DTMF_REG_MAX,
> +		   DA7219_NO_INVERT),

Should this be an enumeration with the DTMF digits in it (# and * aren't
numbers)?

> +	/* DACs */
> +	SOC_DOUBLE_R_TLV("DAC Volume", DA7219_DAC_L_GAIN, DA7219_DAC_R_GAIN,
> +			 DA7219_DAC_L_DIGITAL_GAIN_SHIFT,
> +			 DA7219_DAC_DIGITAL_GAIN_MAX, DA7219_NO_INVERT,
> +			 da7219_dac_dig_gain_tlv),
> +	SOC_DOUBLE_R("DAC Switch", DA7219_DAC_L_CTRL, DA7219_DAC_R_CTRL,
> +		     DA7219_DAC_L_MUTE_EN_SHIFT, DA7219_SWITCH_EN_MAX,
> +		     DA7219_INVERT),
> +	SOC_DOUBLE_R("DAC Gain Ramp Switch", DA7219_DAC_L_CTRL,
> +		     DA7219_DAC_R_CTRL, DA7219_DAC_L_RAMP_EN_SHIFT,
> +		     DA7219_SWITCH_EN_MAX, DA7219_NO_INVERT),


All the DAC controls should probably be Playback Digital instead.

> +
> +static int da7219_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				 int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (da7219->mclk_rate == freq)
> +		return 0;

Given that we also have source selection is this safe - should we also
be checking the source?

> +	if (da7219->mclk) {
> +		freq = clk_round_rate(da7219->mclk, freq);
> +		clk_set_rate(da7219->mclk, freq);
> +	}

Missing error checking.

> +			/* Internal LDO */
> +			if (da7219->use_int_ldo)
> +				snd_soc_update_bits(codec, DA7219_LDO_CTRL,
> +						    DA7219_LDO_EN_MASK,
> +						    DA7219_LDO_EN_MASK);

If there is an option to use an external supply I would expect to see
the regulator API used to discover the external LDO (and ideally also to
configure the integrated LDO).  If the driver works outside the
frameworks then it is likely this will lead to integration issues later
on.

> +		/* Internal LDO */
> +		da7219->use_int_ldo = pdata->use_internal_ldo;

This is likely to lead to surprises for example...

> +	/* Check if MCLK provided, if not the clock is NULL */
> +	da7219->mclk = devm_clk_get(codec->dev, "mclk");
> +	if (IS_ERR(da7219->mclk)) {
> +		if (PTR_ERR(da7219->mclk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		da7219->mclk = NULL;
> +	}

This should specifically look for the error code that corresponds to a
clock not being mapped and only continue silently in that case rather
than silently accepting all failures to obtain a clock - if we silently
accept all failures that will mean that actual errors will be ignored.

> +	/*
> +	 * There are multiple control bits for the input mixer.
> +	 * The following can be enabled now as it's not power related.
> +	 */
> +	snd_soc_update_bits(codec, DA7219_MIXIN_L_CTRL,
> +			    DA7219_MIXIN_L_MIX_EN_MASK,
> +			    DA7219_MIXIN_L_MIX_EN_MASK);

So the chip designers just put these in for randomness?  Fun.  It'd be
more idiomatic to do something like making these supply widgets so
they're controlled via DAPM even if they don't matter much.

> +	else if (device_may_wakeup(codec->dev))
> +		disable_irq_wake(da7219->aad->irq);

You can use dev_pm_set_wake_irq() and skip having to manage this stuff
explicitly in the driver.

--oplxJGu+Ee5xywIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/Z7tAAoJECTWi3JdVIfQJUoH/2JKWhAkt1qQJIfCJHILWuPy
Fv5+XQFvQ6LagT1r8FRkWwSSw3JZHk4gQBuG828FOF3O3vI4Vx3TK42IuHgd/Ww/
buvIia6yTZOH1xv0mBCQacmlNSLtiMjhLkqwwTWWYfCF1O6tLPoaA3op7UssZiFJ
kqSuO/47WKke6d7fW8Z9CG510tDc4vdrMLakj/MZtFpFJTZlB2SDuQRrZut4pEyC
R8kvtCI8R8GMLFDyuOOTXswlg0MddJbupAm2RacHJoMecHmTOkQWdTc3NF7KCNZq
pju6dN0PZ97fqDTZsGUBlucf2mIwkolb2yVNfwGKMyxceFHNve0TTcCNwZBPkH4=
=Hr1h
-----END PGP SIGNATURE-----

--oplxJGu+Ee5xywIT--
