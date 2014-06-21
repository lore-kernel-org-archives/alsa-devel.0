From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: sh/fsi: Make one-bit bitfields
	unsigned
Date: Sat, 21 Jun 2014 21:02:28 +0100
Message-ID: <20140621200228.GN5099@sirena.org.uk>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
 <1403163631-26215-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1356932013307580104=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CBD3264EF1
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:02:48 +0200 (CEST)
In-Reply-To: <1403163631-26215-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============1356932013307580104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BlSXMmufQQBIrxDX"
Content-Disposition: inline


--BlSXMmufQQBIrxDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 19, 2014 at 09:40:31AM +0200, Lars-Peter Clausen wrote:
> One-bit signed bitfields have two possible values: 0 and -1. This sometimes
> leads to unexpected results (e.g. foo.bar = 1; foo.bar == 1 => false) which is
> why it is recommended to make one-bit bitfields unsigned.

Applied, thanks.

--BlSXMmufQQBIrxDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeTRAAoJELSic+t+oim9CZ4P+gN1S3+VWUeGfIfBRMgX9Q45
2M345TykU/UzboETlRTGmwORKTUrgZ6pE/norAEjJIMAkna2RpJhSzypLRsgZCas
WVkiVcEUn6hpAtDdTYIRT7HKcNgeMj5gTB6IhjPdWZwqr+IY6g/rlZg1JTByiYBv
uVtKhKUmohAlaWyGqFu9iNRPECUm1oe8wFD5pTkkaPgToScModbqlpHYm/JaAq2p
zxg0LGF6DbEUERprIv5xpUPpbDE4tkYb/H2esBTV86+kkDjtUf5XTE4A36qKEkcL
aKfrvQjfUOlHItaJj0KGe37vwUkclVJkmeyOfkjoAjzmo0hu/QOOaK4qKYdnbcpY
4EiHWoy3FUgD92C7LwGlQ/2JAXkgfV3KaRLhE7hbg0zbsXtUDXGYKjUZwRKrUIXj
utJHtrashliGYdt6mevS+Z53IKAbot7JcfF/dE1U2NLiqh68DTURhSUjENfMM7Qz
+Yj1myoseIMVlUpTAU1fN5jYE/a5JwQQ6NF60+aL2hy6xiUNyxb5EsYKJ9SZFb8g
XA6Nz3nqdOggU4bVF95bl6zAFwKQPg5qaNFgFCRoZzgJGKG9KdIoRBk7u8i2wjCq
yizzTWccaeeRNpsyMmIhVCJdYLrBE0hYvqM5fItBSGb2d8wzFSzI+3V39SkZo+Ec
2SaDwawTq5bEpuubNuJH
=0jgl
-----END PGP SIGNATURE-----

--BlSXMmufQQBIrxDX--

--===============1356932013307580104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1356932013307580104==--
