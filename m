From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v1 5/9] ASoC: msm8x16: add codec intialization setup
Date: Tue, 16 Feb 2016 19:23:46 +0000
Message-ID: <20160216192346.GF7544@sirena.org.uk>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455643983-1827-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455643983-1827-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 05:33:03PM +0000, Srinivas Kandagatla wrote:

> +	if (micbias1 && micbias2) {
> +		if ((wcd->micbias1_cap_mode == MICBIAS_EXT_BYP_CAP) ||
> +		    (wcd->micbias2_cap_mode == MICBIAS_EXT_BYP_CAP))
> +			snd_soc_update_bits(codec,
> +				MSM8X16_WCD_A_ANALOG_MICB_1_EN,
> +				0x40, (MICBIAS_EXT_BYP_CAP << 6));
> +		else
> +			snd_soc_update_bits(codec,
> +				MSM8X16_WCD_A_ANALOG_MICB_1_EN,
> +				0x40, (MICBIAS_NO_EXT_BYP_CAP << 6));

This is a bit of an exciting combination of magic numbers and #defines.

> +#define VDDIO_VOL_MIN	1800000 /* uV */
> +#define VDDIO_VOL_MAX	1800000 /* uV */

> +		mclk_rate = clk_get_rate(msm8x16_wcd->mclk);
> +
> +		if (mclk_rate == 12288000)
> +			snd_soc_update_bits(codec,
> +				MSM8X16_WCD_A_CDC_TOP_CTL, 0x01, 0x00);
> +		else if (mclk_rate == 9600000)
> +			snd_soc_update_bits(codec,
> +				MSM8X16_WCD_A_CDC_TOP_CTL, 0x01, 0x01);

This looks like it should be a switch statement.

> +static const struct msm8x16_wcd_reg_mask_val
> +	msm8x16_wcd_codec_reg_init_val[] = {

We use these tables...

> +	snd_soc_write(codec, MSM8X16_WCD_A_DIGITAL_PERPH_RESET_CTL4, 0x01);
> +	snd_soc_write(codec, MSM8X16_WCD_A_ANALOG_PERPH_RESET_CTL4, 0x01);
> +
> +	for (reg = 0; reg < ARRAY_SIZE(msm8x16_wcd_reset_reg_defaults); reg++)
> +		if (msm8x16_wcd_reg_readable[reg])
> +			msm8x16_wcd_write(codec,
> +				reg, msm8x16_wcd_reset_reg_defaults[reg]);

...and also sequences of explicit register writes somewhat at random as
far as I can see.  What is going on?

> +	/* delay is required to make sure sound card state updated */
> +	usleep_range(5000, 5100);
> +
> +	for (reg = 0; reg < ARRAY_SIZE(msm8x16_wcd_codec_reg_init_val); reg++)
> +		snd_soc_update_bits(codec,
> +				    msm8x16_wcd_codec_reg_init_val[reg].reg,
> +				    msm8x16_wcd_codec_reg_init_val[reg].mask,
> +				    msm8x16_wcd_codec_reg_init_val[reg].val);

It looks like you need delays in the table.  Perhaps using the regmap
sequence code might be a better fit?

> +	msm8x16_wcd_codec_enable_clock_block(codec, 1);

Separate enable and disable functions if you are going to do this though
with one caller each it's not clear why this is a separate function.

> +static int msm8x16_wcd_codec_probe(struct snd_soc_codec *codec)
> +{
> +	struct msm8x16_wcd_chip *chip = dev_get_drvdata(codec->dev);
> +	int err;
> +
> +	regulator_set_voltage(chip->vddio, VDDIO_VOL_MIN, VDDIO_VOL_MAX);

Why are we doing a _set_voltage() here?  We never vary the voltage, we
support only one value and apparently we don't even care if it worked.

> +	err = regulator_enable(chip->vddio);
> +	if (err < 0) {
> +		dev_err(codec->dev, "failed to enable VDDIO regulator\n");
> +		return err;
> +	}
> +
> +	err = regulator_enable(chip->vdd_tx_rx);
> +	if (err < 0) {
> +		dev_err(codec->dev, "failed to enable VDD_TX_RX regulator\n");
> +		return err;
> +	}

These two look like they should be handled with bulk operations (the bit
getting the regulators is in a completely different patch...).  There's
also no disable code.

> +	chip->pmic_rev = snd_soc_read(codec, MSM8X16_WCD_A_DIGITAL_REVISION1);
> +	dev_info(codec->dev, "%s :PMIC REV: %d", __func__, chip->pmic_rev);

Please format the log messages so the look like normal kernel output.

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWw3dBAAoJECTWi3JdVIfQA7AH/2IE9i0HUnjIkeLFoiJPNxii
IeJRwiZ3UXOBNUPEcJggjzwMhRbOG+iaXFFufMqgxM5MtV68DezLt9VQUrEq8NYm
Zx7A1NO9leysGose/i66b0EDH0vizu7GpctRFDg75dk5c6ijdHjwI557SF1thtEL
T7Nye3bIR5t8ean0rGeREm8z5tnVaTX7on4KBuNDchw5qb2zFMB3WqqlWl1+BUXI
Ns100nTELXhvmNt/omkCB0T3CZJgg05g0oj2ppEOut9NiGYbpF0cqDZWBlYOjFkC
QABJSitBJx3UbTp4LJYWLUrHTktctuT5hZvUy8PMPhJf8ahqvULh62Dn/cLJxJs=
=RqiL
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
