From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/5] ASoC: codecs: Add msm8916-wcd analog codec
Date: Mon, 24 Oct 2016 18:00:52 +0100
Message-ID: <20161024170052.GD17252@sirena.org.uk>
References: <1476973249-14547-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1476973249-14547-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476973249-14547-2-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2016 at 03:20:45PM +0100, Srinivas Kandagatla wrote:

> +static int pm8916_wcd_analog_parse_dt(struct device *dev,
> +				       struct pm8916_wcd_analog_priv *priv)
> +{

> +	priv->mclk = devm_clk_get(dev, "mclk");
> +	if (IS_ERR(priv->mclk)) {
> +		dev_err(dev, "failed to get mclk\n");
> +		return PTR_ERR(priv->mclk);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
> +		priv->supplies[i].supply = supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
> +				    priv->supplies);

The above isn't parsing the DT, it's just requesting resources - how
those resources are mapped is hidden behind the clock and regulator
APIs.  Please send a followup fixing this.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDj5DAAoJECTWi3JdVIfQ2PkH/R/r0cT2Yn5nVCI17bn1529G
pTyHOfL+LALn+Yz4Qq/v03SAWI5RM9skZIPQNw2e9Hf/a2AiURN0spdTDywULeri
5RGPQ0fIDZnbvdjhvmSq31pXI7FyMEIaJY0tgsPC0C9xrMRaMCBltRmt9YXYSWGb
bBNOoabVotmP6SP3MuRlI/n6tAF0Hv8Jhdt41U4hqGG+Dh6anmYxllTaRq5Xz3b5
WDYMDgX083hz/6RjKWrLNW+EuQHUC1OTt3Qhm37d6EsRaU4OWmD1eSKdIkBY+isy
Sz4umrnZ6FPIhwlMwEtj+ohtbTxFbYoRdizt9RjPyS9RvUVbHelTGapKf+jKa64=
=btLn
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
