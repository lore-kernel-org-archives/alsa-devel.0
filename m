From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for CS35L32 Boosted Amplifier
Date: Thu, 31 Jul 2014 21:07:29 +0100
Message-ID: <20140731200729.GW17528@sirena.org.uk>
References: <1406664163-10506-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ydd9XA/RGiC514xu"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406664163-10506-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ydd9XA/RGiC514xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2014 at 03:02:42PM -0500, Brian Austin wrote:

> +	case CS35L32_LED_STATUS:
> +	case CS35L32_FLASH_MODE:
> +	case CS35L32_MOVIE_MODE:
> +	case CS35L32_FLASH_TIMER:
> +	case CS35L32_FLASH_INHIBIT:

Should this be an MFD?  Can always be refactored later if required
though.

> +static bool cs35l32_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CS35L32_DEVID_AB:
> +	case CS35L32_DEVID_CD:
> +	case CS35L32_DEVID_E:
> +	case CS35L32_FAB_ID:
> +	case CS35L32_REV_ID:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}

Should the interrupt and LED status registers not also be volatile?

> +static const struct snd_kcontrol_new cs35l32_snd_controls[] = {
> +	SOC_SINGLE_TLV("SPK Amp Volume", CS35L32_CLASSD_CTL,
> +		       3, 0x04, 1, classd_ctl_tlv),

Speaker Volume.

> +	SOC_SINGLE("Gain Zero Cross", CS35L32_CLASSD_CTL, 2, 1, 0),

Zero Cross Switch perhaps (if it's an on/off control it should be called
Switch)?

> +static int int_clear(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		snd_soc_read(codec, CS35L32_INT_STATUS_1);
> +		snd_soc_read(codec, CS35L32_INT_STATUS_2);
> +	} else {
> +		return 0;
> +	}
> +	return 0;
> +}

This seems...  icky.  Shouldn't there be an interrupt handler doing
this?

> +static int cs35l32_codec_set_sysclk(struct snd_soc_codec *codec,
> +			      int clk_id, int source, unsigned int freq, int dir)
> +{
> +
> +	switch (freq) {

> +	case CS35L32_MCLK_6144MHZ:

Not sure these defines add anything over just using the numbers and it
avoids ickyness with the fact that I bet this isn't really 6.144GHz.

> +static int cs35l32_probe(struct snd_soc_codec *codec)
> +{
> +	/* Power down the AMP */
> +	snd_soc_update_bits(codec, CS35L32_PWRCTL1, CS35L32_PDN_AMP,
> +			    CS35L32_PDN_AMP);
> +
> +	/* Clear MCLK Error Bit since we don't have the clock yet */
> +	snd_soc_read(codec, CS35L32_INT_STATUS_1);
> +
> +	return 0;
> +}

Any reason not to do these in the device level probe()?

> +static int cs35l32_remove(struct snd_soc_codec *codec)
> +{
> +	struct cs35l32_private *cs35l32 = snd_soc_codec_get_drvdata(codec);
> +
> +	regulator_bulk_free(ARRAY_SIZE(cs35l32->supplies), cs35l32->supplies);
> +	return 0;
> +}

The regulators should be being acquired and released in the device level
probe(), though this could be dropped entirely with devm.

> +	ret = regmap_register_patch(cs35l32->regmap, cs35l32_monitor_patch,
> +				    ARRAY_SIZE(cs35l32_monitor_patch));

Should either pay attention to the return value or not assign ret
(better to pay attention but it's not like it'd be the first CODEC to
ignore it).

> +	/* initialize codec */
> +	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_AB, &reg);
> +	devid = (reg & 0xFF) << 12;
> +
> +	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_CD, &reg);
> +	devid |= (reg & 0xFF) << 4;
> +
> +	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_E, &reg);
> +	devid |= (reg & 0xF0) >> 4;
> +
> +	if (devid != CS35L32_CHIP_ID) {
> +		ret = -ENODEV;
> +		dev_err(&i2c_client->dev,
> +			"CS35L32 Device ID (%X). Expected %X\n",
> +			devid, CS35L32_CHIP_ID);
> +		return ret;
> +	}

Should the ID check not be done before we register the patch in case
it's the wrong device and we do something bad to it by writing to it?

--ydd9XA/RGiC514xu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2qH+AAoJELSic+t+oim9RrUP/i82rCAAJCfAXO8pibeS3LRb
+KwphmASVpUZjyXKwN8lX4PusYfOFnWi6K3aMoVeX+B4bBZsW6vlojPmVk3h8s+E
XZ5yEWfJXJd5f9Xa7xo0SA3ZzEE0aRXx3HNHzBX1wHz/+iRbTIH8eUcXuSeEcudt
vS0+Z/2b0pyPmU9S0XKlGT1gj+IMHzbZqP6t81WT4ecoz+sYB+LhTaxsdnsIt7On
zqXPMTBvb8uZzcf/bMfCXcmocpoTr6+PkXeqNa//ZqXX8kQ3QTBYBaQ0eJ9eRBUN
iSU8/hxDaWXjNOIVKfK24l/oBlYMSgXrtymN23/LkP/fbgpObAK4FXNcqOR7yyOL
Z3wdvjaAm2PEbyPAopLK3VYcPJdurwOPiObjwY8+cdN+MsRqrwf73yMW1VRF6e51
W+hS/NX22ZMeq8sehRuqNxUPMnQhKRdfUIjgodghVFPKhCcUuAZR43qMTojrpDXg
xyhp+TFJG3rhIy0qDEGJ5HhxeWxpfQi5y4+uh4z3mJaNCkQrPV3WQ3R08OXd7cqu
RyWE+EGWJ/lePmEW0rnAQANRH/ui7STVJ3ucwyxXgk+nzcsI0qMnOlhOtmHn1Brw
NMb5JJQu9TLLZHE8AlU8QlZOOI2etwU5UKmmOJihumraWAwHFRdlWF3gdOwYryDH
IjN8b+G9W32IhfwQnaj1
=tbos
-----END PGP SIGNATURE-----

--ydd9XA/RGiC514xu--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
