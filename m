From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] ASoC: pcm179x: Add support for pcm1795 and
 pcm1796
Date: Sun, 10 Jan 2016 12:00:45 +0000
Message-ID: <20160110120045.GW6588@sirena.org.uk>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f3bMXCeKxSopGW1v"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452382685-18009-4-git-send-email-michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--f3bMXCeKxSopGW1v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 10, 2016 at 12:38:05AM +0100, Michael Trimarchi wrote:

> +	if (priv->codec_model == PCM1795)
> +		formats = PCM1795_FORMATS;

This should be a switch statement to handle any future variations.

>  static const struct of_device_id pcm179x_of_match[] = {
>  	{ .compatible = "ti,pcm1792a", },
> +	{ .compatible = "ti,pcm1796", },
> +	{ .compatible = "ti,pcm1795",
> +	  .data = &codec_model,
> +	},

Please keep tables sorted, it avoid conflicts and merge issues when
adding new entries.

--f3bMXCeKxSopGW1v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWkkfsAAoJECTWi3JdVIfQp7oH/1TnOIht9/d4Uv+FJrz2zAsc
ZuY4YyT6Xu9DCxKsOkNLufQIMcfFqRtyISrSjGk0tcKhqGoRiV+lDSpwyh7bJYJ5
iUrF38U7b9FQItVvUeIExqyLEOTrXsHhMbZjjjdBfhtIi5STfXmYhS2huiEEu5Y6
xT7tKzMYiI4Ab5IXxDqiBFYWYdAnzQLDAaZkomh3sbm+1phmyCj2lCqvaF61BCoM
x6CBxXuLFC2cks2rsNPcIaNZWVICy29oMJCiGR3+NI9wDf1E3Jz+3wb5JoHUEGow
G9YFhkwmJJoec5RX4zKnAszehNXk3ICqZ/tCx8Zfn/63VntzCfTACsSx68H+DoA=
=j0V3
-----END PGP SIGNATURE-----

--f3bMXCeKxSopGW1v--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
