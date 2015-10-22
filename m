From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: wm8960: harmless underflow in wm8960_put_deemph()
Date: Thu, 22 Oct 2015 13:56:40 +0100
Message-ID: <20151022125640.GL8232@sirena.org.uk>
References: <20151013070938.GE31537@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9JSHP372f+2dzJ8X"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151013070938.GE31537@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Zidan Wang <zidan.wang@freescale.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--9JSHP372f+2dzJ8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 10:09:38AM +0300, Dan Carpenter wrote:
> Valid values of "deemph" are zero and one, but we accidentally allow
> negative values as well.  It's harmless but we may as well fix it.

This appears to duplicate the patch sent immediately before it?

--9JSHP372f+2dzJ8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKN0HAAoJECTWi3JdVIfQZhIH/jkRYw4KL1PTSM07JPfz97lK
z7wlYerkDdBekjNiY6rh2EoEFzEbGiVzwF7EUCw57aOwBxI81ixakDPQFP8o/ZHq
+thCu7SGZrsXtD6V/IzH6dZAaLuDjjL/V6RZAb9j4g2g1BCHYKzKvUHN9T23C7oF
Gm6phaQKO5kHH2qdp2yM3WFhcE+OCDXmGpvAh09Ui5p+uneAiaHbxEe0IgYs9/41
75qWEyNGU9hPTfS9GzgqE7so0u0TJXZGpV0l5RuR/mtJvM45ZL6HgjRxwLa09l8U
D+xL42B4kzVPYli9v4ow0KjfCIA/fZeUVeUOSmoH4iUPSdJCx3bbGZq3c3kTLXQ=
=dBak
-----END PGP SIGNATURE-----

--9JSHP372f+2dzJ8X--
