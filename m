From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC fix for 3.4
Date: Wed, 9 May 2012 12:49:04 +0100
Message-ID: <20120509114903.GL3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2614840380717247402=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE6092456D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 14:06:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2614840380717247402==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rVkomL2febZOZtGQ"
Content-Disposition: inline


--rVkomL2febZOZtGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 06412088ce98f745405b8f65cfc51ddd6b842bbf:

  ASoC: s3c2412-i2s: Fix dai registration (2012-04-30 23:45:25 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.4

for you to fetch changes up to c8587193ba511b788a9888e5e701a9747e70c0d8:

  ASoC: sh: fix migor.c compilation (2012-05-09 12:41:05 +0100)

----------------------------------------------------------------
ASoC: Build fix for SH in 3.4

An API update which wasn't sufficiently thorough in updating the tree...

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ASoC: sh: fix migor.c compilation

 sound/soc/sh/migor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--rVkomL2febZOZtGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqlmSAAoJEBus8iNuMP3d9wEP/j0n2qwBB1KKQ0ewjVsQ7K0X
ffTotSS37n/E8Ddd7dxfAe5G4Z8reoTAmrOdyPrjBl39qeBjXDW75SS40idhWjFx
z21pzrCZ8l020ZCEN13EqqqTeHhinETJtiG4W6uXFx6Q4uOnGfA6GcGQWVWdj3pt
qO6o0WuTd+3MbE0aMv7Cq0wRvFDDIA2zdZmpg4s8SsPVd0z0b3bMPb4dpoj4TERI
u5gEZrw3FBnBrzVxVSJCIns0LXU5h9rY2HzaHlOPqgH5sK2F39Z7YMErE3taCY7r
7zYeXVW2bzQ+3NHrE/FFGFcPkc6OiCphmyiC1ptVAodo9MysQULENgq3gMJtYYrG
Sk2L5nHfAvFL8BStkIiL+B/MGq2EzLa9Yg4fJotbpAl8bgS2x6wAgK1rXx25WhEG
VGgXH3h8JcNZ3rSxGnGCQn2alSJefWc1uN8P2xtj8lfuy/8pq/S5/npj4/dpUBJf
J6Ky13/v9Apn3nZD6XFH7zsBU0Mop2xwpTtvKK24iU323/TVjxgq1hXR1YnUAaDj
neRGMAOaGWyyFiD5Eg0kfehvlqjsDEf/iua5ZrNaGnAK8GWofVqZ6XQ/yCZ6kCP1
MGpx4m6XgU+BFmrf3uYI7RRe3mXaE54+6jVSvvVDIlcBCTlH9ufZGJoLdevdDmF3
vjzDsKPp04L+cj8bGMx5
=Up6N
-----END PGP SIGNATURE-----

--rVkomL2febZOZtGQ--

--===============2614840380717247402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2614840380717247402==--
