From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: Add support for NAU8825 codec to ASoC
Date: Mon, 13 Jul 2015 12:15:23 +0100
Message-ID: <20150713111523.GD11162@sirena.org.uk>
References: <55A369B2.5040500@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5IYJRsx6KNVuKrR5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55A369B2.5040500@nuvoton.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chih-Chiang Chang <ccchang12@nuvoton.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, AP MS30 Linux Kernel community <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--5IYJRsx6KNVuKrR5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2015 at 03:33:06PM +0800, Chih-Chiang Chang wrote:

> +static const struct snd_kcontrol_new nau8825_snd_controls[] = {
> +    SOC_SINGLE_TLV("MIC Volume", NAU8825_ADC_DGAIN_CTRL,
> +            NAU8825_ADC_DGAIN_SFT,
> +            NAU8825_ADC_VOL_RSCL_RANGE, 0, adc_vol_tlv),
> +    SOC_DOUBLE_TLV("HP Volume", NAU8825_HSVOL_CTRL,
> +            NAU8825_L_HSVOL_SFT, NAU8825_R_HSVOL_SFT,
> +            NAU8825_VOL_RSCL_RANGE, 1, out_hp_vol_tlv),

HP would normally be Headphone, MIC Microphone or Mic.

> +static const struct snd_kcontrol_new nau8825_hpo_mix[] = {
> +    SOC_DAPM_SINGLE("HP L Switch", NAU8825_HSVOL_CTRL,
> +            NAU8825_L_MUTE_SFT, 1, 1),
> +    SOC_DAPM_SINGLE("HP R Switch", NAU8825_HSVOL_CTRL,
> +            NAU8825_R_MUTE_SFT, 1, 1),

Left and Right please.

> +static int nau8825_dac_mute(struct snd_soc_dai *codec_dai, int mute)
> +{
> +    struct snd_soc_codec *codec = codec_dai->codec;
> +    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +    if (mute)
> +        regmap_update_bits(nau8825->regmap, NAU8825_DAC_MUTE_CTRL,
> +                NAU8825_SOFT_MUTE_MASK, NAU8825_SOFT_MUTE_EN);
> +    else
> +        regmap_update_bits(nau8825->regmap, NAU8825_DAC_MUTE_CTRL,
> +                NAU8825_SOFT_MUTE_MASK, NAU8825_SOFT_MUTE_DIS);

Please use the kernel coding style.  It also looks like you're using
spaces not tabs...  indeed now I check with checkpatch it seems you
didn't.

> +    /* interface format */
> +    switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +    case SND_SOC_DAIFMT_NB_NF:
> +        break;
> +    case SND_SOC_DAIFMT_IB_NF:
> +        reg_val |= NAU8825_I2S_BP_INV;
> +        break;
> +    default:
> +        dev_alert(codec->dev, "Invalid DAI interface format\n");

Why are you using dev_alert?

> +static void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
> +{
> +    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +    pr_debug("%s :: sys_clk=%x\n", __func__, sys_clk);

dev_dbg()

> +    case NAU8825_MCLK:
> +    default:

Why is there a default case here that's not just returning an error?

> +    switch (level) {
> +    case SND_SOC_BIAS_ON:
> +        /* All power is driven by DAPM system*/
> +        dev_dbg(codec->dev, "###nau8825_set_bias_level BIAS_ON\n");
> +        regmap_update_bits(nau8825->regmap, NAU8825_BIAS_ADJ,
> +                NAU8825_VMIDSEL_MASK, NAU8825_VMIDSEL_125KOHM);
> +        regmap_update_bits(nau8825->regmap, NAU8825_BIAS_ADJ,
> +                NAU8825_VMID_MASK, NAU8825_VMID_EN);
> +        regmap_update_bits(nau8825->regmap, NAU8825_BOOST,
> +                NAU8825_G_BIAS_MASK, NAU8825_G_BIAS_EN);
> +        break;

You appear to be enabling VMID and other supplies only when you get to
_BIAS_ON after everything else has been enabled.  In CODECs where this
is a good idea usually some delay is needed to wait for VMID to ramp
before anything tries to actually play audio otherwise you get audio
playing on a partially ramped VMID and clipping or worse.  If VMID can
be ramped quickly it is more normal to ramp it in _STANDBY.

Can you explain what's going on here?

> +static int nau8825_codec_probe(struct snd_soc_codec *codec)
> +{
> +    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +    /* bias current settings */
> +    regmap_write(nau8825->regmap, 0x0072, 0x0260);
> +    /* enable bias */
> +    nau8825_set_bias_level(codec, SND_SOC_BIAS_ON);
> +    mdelay(10);

It looks like you need a ramp...  also this appears to leave things
powered on which is not good, the device should default to idle.

> +    /* DAC digital default gain 0 dB */
> +    regmap_write(nau8825->regmap, 0x0033, 0x00cf);
> +    regmap_write(nau8825->regmap, 0x0034, 0x02cf);
> +    /* DAC driver default gain -29 dB */
> +    regmap_write(nau8825->regmap, 0x0032, 0x075d);
> +    /* ADC digital default gain 8 dB */
> +    regmap_write(nau8825->regmap, 0x0030, 0x00d2);

No, use the hardware defaults.

> +    /* enable ADC/DAC clocks */
> +    regmap_write(nau8825->regmap, 0x0001, 0x07fd);

Why is this not managed via DAPM?

> +static int ena_adc(struct nau8825_priv *nau8825)
> +{
> +    /* adc & clock settings */
> +    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
> +            NAU8825_ADC_CLK_MASK, NAU8825_ADC_CLK_EN);
> +    regmap_update_bits(nau8825->regmap, NAU8825_ENA_CTRL,
> +            NAU8825_ADC_MASK, NAU8825_ADC_EN);
> +    /* adc PGA settings */
> +    regmap_update_bits(nau8825->regmap, NAU8825_POWER_UP_CTRL,
> +            NAU8825_FEPGA_GAIN_MASK, 0x1b00);
> +    regmap_update_bits(nau8825->regmap, NAU8825_POWER_UP_CTRL,
> +            NAU8825_FEPGA_MASK, NAU8825_FEPGA_EN);
> +    /* mic bias output level (1.1V) */
> +    regmap_update_bits(nau8825->regmap, NAU8825_MIC_BIAS,
> +            NAU8825_MIC_BIAS_LVL_MSK, 0x04);
> +    /* enable mic bias */
> +    regmap_update_bits(nau8825->regmap, NAU8825_MIC_BIAS,
> +            NAU8825_MIC_POWERUP_MSK, NAU8825_MIC_POWERUP_EN);
> +    mdelay(10);
> +    return 0;
> +}

This looks like the sort of sequence DAPM can generate - why are DAPM
widgets not being used?

> +static int dis_dac(struct nau8825_priv *nau8825)
> +{
> +    /* disable charge bump */

These are more usually called a charge pump.

> +static int nau8825_trigger(struct snd_pcm_substream *substream,
> +            int cmd, struct snd_soc_dai *dai)
> +{
> +    struct snd_soc_codec *codec = dai->codec;
> +    struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +    switch (cmd) {
> +    case SNDRV_PCM_TRIGGER_START:
> +        config_fll_clk_12m(codec);
> +        set_sys_clk(codec, NAU8825_MCLK);
> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +            ena_dac(nau8825);
> +        else
> +            ena_adc(nau8825);
> +        break;

No, this is all compeltely non-idiomatic and I'm surprised it even runs
successfully for you.  This is doing I2C I/O in the trigger function
which is called from atomic context, at the very least I would expect
this to be causing lots of warnings.  You should be using DAPM to manage
the power up and down sequences (as some comments earlier in the driver
claimed it was doing).  There are quite a few serious problems here
which mostly seem to come down to trying to have power sequences outside
of DAPM, there is some DAPM code but it's obviously at best not very
complete.  Look at how other drivers handle power management.

I've not reviwed any of the rest of this driver.

--5IYJRsx6KNVuKrR5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVo53KAAoJECTWi3JdVIfQJGEH/jYbbmW/GDbJsQlnVf9AS+qQ
rJaqvAckmYELQRy115MmPTuufsI5Oywk6a/Umoahq8BgExQx01rQ+AFd760yRsFB
PZPayf7W6YYh8FbUFWGv+aRuaoHntTDRwRFZs/fi47TeFVMxMeUGY6WkE+lEVXmK
2lABywmNzvh1JjZoxcHbXVEufL0CFZ+URsYd8ouGxnd+1sw7GzAnLaxixpRZDTuZ
yNqkAmbJ4Q+hGzdgjI3RXH1HygwXwhUy8lDNns4WsHOKYCEdyYUwzjOmw63Sz3J7
pt45yzKZIVEZWEYgGkHvNiWpcCCrFFBqKLNNDa9CjXR3f2soPD1pQaHLPiDvnJY=
=vNiG
-----END PGP SIGNATURE-----

--5IYJRsx6KNVuKrR5--
