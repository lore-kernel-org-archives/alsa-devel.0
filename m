From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: atmel-i2s: add driver for the new Atmel I2S
 controller
Date: Thu, 14 Jul 2016 17:20:59 +0100
Message-ID: <20160714162059.GB30372@sirena.org.uk>
References: <cover.1468405019.git.cyrille.pitchen@atmel.com>
 <ca944501da6c2bb6240f4a56e8d2ba5221373408.1468405019.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ca944501da6c2bb6240f4a56e8d2ba5221373408.1468405019.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 13, 2016 at 12:25:39PM +0200, Cyrille Pitchen wrote:

A few small things but otherwise this looks good:

> +	switch (params_channels(params)) {
> +	case 1:
> +		mr |= is_playback ? ATMEL_I2SC_MR_TXMONO : ATMEL_I2SC_MR_RXMONO;

Please write normal if statements, it makes things easier to read.

> +		break;
> +	case 2:
> +		break;
> +	default:
> +		dev_err(dev->dev, "unsupported number of audio channels\n");
> +		break;
> +	}

Why don't we return an error if we don't support the requested number of
channels?

> +	dev->gclk = devm_clk_get(&pdev->dev, "gclk");
> +	if (IS_ERR(dev->aclk) && IS_ERR(dev->gclk)) {
> +		/* Master Mode not supported */
> +		dev->aclk = NULL;
> +		dev->gclk = NULL;

This won't handle probe deferral properly, it'll just ignore the clocks
if we get -EPROBE_DEFER.  The driver should special case that at least.

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXh7vqAAoJECTWi3JdVIfQPhsH/jdMog1xqf1sed8sRo+uUxR+
9o8FtNAtJOFrWoUa/VJghiegqbxwvQ/mBrqY3I5fd1B/c4Vj43k7sEkXccusgy9r
19fKm9EmHshJdgdtKENNL0foBetRHUk+ujZ7cF7Uo0qkuV1C2GXfZD1Y5wT6TfZ3
0JonAXVXp8ezlMZ7zugm3cRHQLCA0SykfrUSHG4J40yC641CPh1tbbnF/+5pVK4/
RdmFqEP1nJKvsx7EtZsaPm3LYt8FkFDtcwRIJiXG4jeNyvMqky0NWx9a5Jj9Gs8p
Qc9Xr+oHK/A6GuSAnch4bNuZabTi13W4hqj2DL+4dTUGfXa1kNUijKqp9M6TwQ8=
=epbI
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
