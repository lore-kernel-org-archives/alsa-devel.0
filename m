From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_spdif: Remove unnecessary
 dev_set_drvdata()
Date: Mon, 26 Aug 2013 12:53:43 +0100
Message-ID: <20130826115343.GB10783@sirena.org.uk>
References: <1377292486-7591-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0132160517002652000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 08BF5261A7A
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 13:53:54 +0200 (CEST)
In-Reply-To: <1377292486-7591-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============0132160517002652000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 06:14:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Driver core clears the driver data to NULL after device_release or on pro=
be=20
> failure, so just remove it from here.

Applied, thanks.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSG0HEAAoJELSic+t+oim9lgYP/1Ri21ptSy9RPZtfx8Du/hX2
3/Y+Syp44Gv2HQjDde0rew7XloCYRXAMuQwI6fp7/1IJ8cpWV8IuO9y+K+y3e6UZ
EnDhT6ylRLOw73y6fodkkZhOr9stVqVE+hc/ldZw16fxROveDSNBNovvEO4aioVm
vN56duSlGzPUcPmyjBG4zwFOWWyeuERyEwksgWQmRTrDU0c+7HQbAcDer+8j7dKc
KNT9rCCVso6g2vFf7s12bN5C6+206p/mGUc15mSWWlYNUnQMjhlZfcIwLWapnsH6
H/tF+6haCPcboyutMIxDIGxhntIh5qcPPahcfm65V4u/y+jDgVuOopfBUcSNAetE
yEV5IFjuh2Ei+ggwsGngCOZIebMQkesfjqDY0YlZZki1ziFFLxFugf05fee+k93y
Mk/wl9uXMCaStk8CMOCGlOHb+iv0Q1ZIO8kVFkXwVPcyeTNdD+8kmZwzViIBd+KG
lkegkgaCLcW7q5X2VwIcGsY7r1o4aSvRdjhGOTE9YLUWZ2o5KUOw1EB/4qo7gh8T
L5blDIHYFsjyoD0KqPwq93niRKVI0RyXUWuCALCtlueUtX+zdKJCgOCKCXeqiU/L
A7QjI07FAUCo/qBoyRpmYco+TqN77Q5070oJhLLxBf/7fS4CCjSFZciPy7m/Vu2S
wZwiXT2kGzxLKtjt172R
=8Oym
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--===============0132160517002652000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0132160517002652000==--
