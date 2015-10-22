From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: es8328: harmless underflow in es8328_put_deemph()
Date: Thu, 22 Oct 2015 13:58:37 +0100
Message-ID: <20151022125837.GM8232@sirena.org.uk>
References: <20151013071109.GH31537@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sWvRP97dwRHm9fX+"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151013071109.GH31537@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--sWvRP97dwRHm9fX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 10:11:09AM +0300, Dan Carpenter wrote:
> Valid values for "deemph" are zero and one but we accidentally allow
> negative values as well.  It's harmless but it causes static checker
> warnings and we may as well clean it up.

Thanks for all these fixes.  It almost feels like someone should
volunteer to implement these deemphasis controls in some generic
fashion!  :)

--sWvRP97dwRHm9fX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKN18AAoJECTWi3JdVIfQ36wH/iBwa85a0OGiqZvPBjmOZjEl
LTzvV9LZL+KsBV9b7QNTTdJb47OTSUgpzfdbP/VT2qpnGRfnVQvCNBOeqR89zqO8
nlzm3OMuUg3Oj40WksUWsKVr9VQepyhpz6x512b6D7cKfzLPUznjTzTqEWZLJyL7
jXsnR285BZCj+s5nuqETk7PGQEk0SyyDkTDaMfgvK/E9x1jd5GP8v3gUEYJCs6+3
ujX1BAxIfkRePdjaGT7jsbGYy8IzMdMtYS+O+U05k1D3MbjWGFEpga+lejXUWe1H
XUYI0d5EQz8XhoWTCrAv3+5o3bCUE7H2x9omJLrzSt6ME5gW1ziIxf0pNKPRK6g=
=EaEx
-----END PGP SIGNATURE-----

--sWvRP97dwRHm9fX+--
