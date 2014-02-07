From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] sound: soc: fsl: Add support for Novena onboard audio
Date: Fri, 7 Feb 2014 18:14:33 +0000
Message-ID: <20140207181433.GM1757@sirena.org.uk>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com>
 <1391749517-11787-3-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391749517-11787-3-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2014 at 01:05:16PM +0800, Sean Cross wrote:
> Novena uses an ES8328 audio codec connected via I2S.

The CODEC looked pretty simple, can this use simple-card?

> +	/* Headphone jack detection */
> +	if (gpio_is_valid(data->jack_gpio)) {
> +		ret = snd_soc_jack_new(rtd->codec, "Headset",
> +				       SND_JACK_HEADSET | SND_JACK_BTN_0,
> +				       &headset_jack);
> +		if (ret)
> +			return ret;
> +
> +		headset_jack_gpios[0].gpio = data->jack_gpio;
> +		ret = snd_soc_jack_add_gpios(&headset_jack,
> +					     ARRAY_SIZE(headset_jack_gpios),
> +					     headset_jack_gpios);
> +	}

We'd need to add support for this but that shouldn't be too hard.

> +static int imx_set_frequency(struct imx_novena_data *data, int freq) {
> +	int ret;
> +
> +	ret = clk_set_parent(data->system_cko, data->codec_clk);
> +	if (ret) {
> +		dev_err(data->dev, "unable to set clk output");
> +		return ret;
> +	}
> +
> +	ret = clk_set_parent(data->codec_clk_sel, data->codec_clk_post_div);
> +	if (ret) {
> +		dev_err(data->dev, "unable to set clk parent");
> +		return ret;
> +	}

There's supposed to be support for this sort of thing going into the
clock API with some sort of generic binding.

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9SKGAAoJELSic+t+oim9/scP/i6DuZ1ylj8gLLneaeXllhbj
pChyxDkPtazinoVB0gRRVNuFobozXUBrnOjmcaI7Zrgj1BrxdvujNqQITy0LL7Qc
UK6UWIFO+PFsCph3VI/DnZ7YobDWgsC8bz9lAZqknLKzYJkE/3Uy2aDdmO+pRZEX
r7Ek4msVduDoiq7H1mT9Knwtw2jmbvDd6aWdplRGslZnfKAHMIsxegsi5LxK8iBS
I9Qrv3DnwKPRxrckCyJmtGcvZl29FMYhxLSbdH9zH7HmUF/8j8uNpP/P1QvRQD9J
qFrp6efTVf9H8OzPcZCqS0Oe6xtbzkyVFxkEuY54GNchJ6gaHIuevbV6Ag7t35x+
6PEtcHy8h0tMD8Yo0yf/9pXnGvTafzDqom2RRLpT6UjDq/EOvoAtmFFxJ1KlxFTS
6d709Cr1zl62xm46cQUvzYtqThYnjMhSAudjEsyzQRgQFSyXlGP+l7q2hjsiulms
MbFr7iNXc23z6q9sIA25dFo3xtLgDNLic8G+AINleFRsaIjNy6EHElg4CYiCc5W0
PRSwSHqVkqAsOhVKbXvi0XBOo2kGgT0deV3jfUEzg98+NSdjIcdn3GM1XG+/svP/
7yqR2+XO4pMXoks5vCmQrlm9dedwaxMd5ewT9Sy7YCbVTwJSGX0qyJ2AfpezkQaV
5sadpLjqhdZm8P7g40IB
=YkqB
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
