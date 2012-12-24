From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm8993: Refactor set_pll code to
 avoid GCC warnings
Date: Mon, 24 Dec 2012 15:56:03 +0000
Message-ID: <20121224155603.GL30837@opensource.wolfsonmicro.com>
References: <1355282680-30760-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5455177152712994489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1433A261637
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 16:56:05 +0100 (CET)
In-Reply-To: <1355282680-30760-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5455177152712994489==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NPWyolIJAVLYbHY6"
Content-Disposition: inline


--NPWyolIJAVLYbHY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 01:24:40AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Refactor set_pll code to avoid the following warnings:

Applied, thanks.

--NPWyolIJAVLYbHY6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2HsKAAoJELSic+t+oim92pwP/0LAV5NVry4YSx4+0YcTDg6W
ku6t29Q5nX/N6X6oIZhlHdV7biKplF1Y6E6GMryYdbk6Qyjga30R9qAcwN8s3dBq
2/0e1rvpdCoxqmJfhYh75X8la8cBrcUwVeO4n1+PlLHYsMtPY6N2zPwI8Za5woZE
K9FGm3QyBT9XVFXxvSPJpL1O1Kmzcd0Ou7BZjDnlAXww8MpthYn5MA//6aeo96rG
PyLM63eTAVwMUvj1fJjzBuRCCsCHIbgGGkvnmvsDbW+Z/lPdnWOGNGU5PkP74Aj+
PbnbOcHhEOA4D3/7oCyix7yoZVfTp35bou8J1Vbm4WbsCAqf4Q4v0KxEqJdMinRi
uzL30pv5WZK5o7bjPCAH1eqqKjxbuRyox7HdiIyuOgB+QvaLmD3UYWe2ll4/AW6u
BkplvSHEp1CCDJ6Dc9HFgkzV9P7D81KcGMZPea2WgTsmCp7CggzASjVHmKdmIdF2
4Uezp1gsLGsR+LxXzaf3o9x40vcqXzhpXTzYUewGmeJVC3RF9fFoWeyO1tF1p1ld
nrjut/CG5X0o1wiRcWcaayjTNyXV5Fd7q2gLxrteLmQrcB7zfGs5/STZXKBBRcxm
pleW7DkcJKdRt4rUCLwG/60nRtnDcpO59RFj5mabvxTkG4tO5Z12s98PIDGPN3pn
q1lQKLC1m2Whsz0hVqIo
=wdTC
-----END PGP SIGNATURE-----

--NPWyolIJAVLYbHY6--

--===============5455177152712994489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5455177152712994489==--
