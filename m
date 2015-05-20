From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: wm8741: check for error returns from
 wm8741_set_pdata()
Date: Wed, 20 May 2015 10:55:19 +0100
Message-ID: <20150520095519.GA21577@sirena.org.uk>
References: <20150520074035.GB18278@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150520074035.GB18278@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Sergej Sawazki <ce3a@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2015 at 10:40:35AM +0300, Dan Carpenter wrote:
> Static checkers complain that "ret" is always zero so the conditions are
> never true.

Applied, thanks.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXFoGAAoJECTWi3JdVIfQTSwH/0MpZcfzrsOvx6+hpYdxSMUJ
rz8GcNBvXKRLxu18QcF6UlQrKPUBMIh1jdA8CZvy2d1HG7ApQMpWJ4cKCgO6KlH/
2GTwFY67nPgLacyDnk/x+jvRsaka/65gryqBJbHLqFaIS6DwE+FhANOog+5Kdgf1
iz7EBQ5Ba0OaYBvWKTweeDMgKU0PJI5ZPBvNxkO1hcT2ZNzbVZvH9C8+wrT2sice
AMzovMfv+k6nPf775gJBP0+FlUXXrOavGHRhbp/pp24nSwrz6/E8gSIXxHUkZhLx
ucmNh2jF/ub23l4daE5BMgPF/enuTdOYW8drcreoaROXFWs1XuwsudC089W51oI=
=v+H8
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
