From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: es7134: add support for the es7154
Date: Mon, 2 Jul 2018 11:05:33 +0100
Message-ID: <20180702100533.GD18211@sirena.org.uk>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
 <20180629150924.18197-6-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180629150924.18197-6-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 29, 2018 at 05:09:24PM +0200, Jerome Brunet wrote:

>  	{ .compatible = "everest,es7134", .data = &es7134_chip },
>  	{ .compatible = "everest,es7144", .data = &es7134_chip },
> +	{ .compatible = "everest,es7154", .data = &es7154_chip },
>  	{ }

This needs to be added to the DT documentation.

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5+OwACgkQJNaLcl1U
h9C4Vwf/VXD6wsjvJICRurg1X4zocpRgWmsENAmmPsEmNx/hB+/T3gatzbRpNnGi
zrMdoZGOQ/euHQLsZ6vNvWy4//VMC5vcdzfpJ9pvJ2M8ku8ev3uZaEZWycx0HXe0
iiSWhLf5xc1mb5OwuxUqMg3NXi8UEqQVXDEWwE1eKOf2lGSpo58VM+CKCrN3Coh5
i7l7cXBKPJh95yinpI4Z8wZsxsxqb+vG0CpnqLHOUzDN6YzuChSQ9ha49VQYUE3B
TCh+b6mFud6aeJW0RJbKcwGCGN2yyQSR5C0JFn1Jddlc5gGME3PIvbsed1v9IjpU
uGGm8R9GssdwzsLImjXigWb+94Cpag==
=BtKP
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
