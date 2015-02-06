From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V4 06/10] ASoC: ipq806x: Add LPASS CPU DAI driver
Date: Sat, 7 Feb 2015 06:40:53 +0800
Message-ID: <20150206224053.GH31311@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <1423169626-22166-7-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423169626-22166-7-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 12:53:42PM -0800, Kenneth Westfield wrote:

> +	int bitwidth, ret;

> +	bitwidth = snd_pcm_format_width(format);
> +	if (bitwidth < 0) {
> +		dev_err(dai->dev, "%s() invalid bit width given\n", __func__);

Print the error code.

> +	regval = 0;
> +	regval |= LPAIF_I2SCTL_LOOPBACK_DISABLE;
> +	regval |= LPAIF_I2SCTL_WSSRC_INTERNAL;

Why not just write a single assignment statement?

> +	default:
> +		dev_err(dai->dev, "%s() invalid bitwidth given: %u\n",
> +				__func__, bitwidth);

bitwidth is a signed type but you are using an unsigned format specifier
here.

> +	reg = LPAIF_I2SCTL_REG(LPAIF_I2S_PORT_MI2S);
> +	mask = LPAIF_I2SCTL_SPKEN_MASK;
> +	val = LPAIF_I2SCTL_SPKEN_ENABLE;
> +	ret = regmap_update_bits(drvdata->lpaif_map, reg, mask, val);

None of these intermediate variables seem to be doing a lot, why not
just specify the constants directly as arguments (that's the more normal
style)?  A similar thing applies in several other places in this file.

> +#ifdef CONFIG_OF
> +static const struct of_device_id lpass_cpu_device_id[] = {
> +	{.compatible = "qcom," DRV_NAME},
> +	{}
> +};
> +#endif

Using DRV_NAME in the compatible like this makes it impossible to grep
for the driver which isn't helpful.  In general I prefer not to use
DRV_NAME at all (exactly how often do we change the driver name?) but in
this case it's actively harmful.

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1UL0AAoJECTWi3JdVIfQOyEH/iBT//c6RnPspqxa465+gMGb
X/jWLwi8T9qImPVWCX5K0NviRc6uczLfAoc7N7HP4uO5igXzD+jNeBMlUg4c1wBf
Z9djcrggnbLssQIBMC7JV8CdixThgLuS94Bdoh4F6xrlogK5Y/QQhVubpyFMEv0A
4T8VZWmq5tRWx7vo5NUrdjaVJVv/hntBjFJi/HE4UoPo+v2tl2Eg1GfpgTkOavMu
PH9nWjY2zXQQS+6Az84d1vMG9v9M53Tu3mmKXtMBzmpcPmNrikxKJ1bPnGF0SwNr
ls2l2olyryKVHVabecUoIQas2w8w4Ik1hjejubKJf3NIqrSGwhvGODhJEic+LF8=
=6ma1
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
