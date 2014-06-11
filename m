From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fixup index of src/dst mod
	when capture
Date: Thu, 12 Jun 2014 00:33:58 +0100
Message-ID: <20140611233358.GO5099@sirena.org.uk>
References: <87fvjcj6d3.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2547335562338051776=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81851265709
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 01:34:11 +0200 (CEST)
In-Reply-To: <87fvjcj6d3.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2547335562338051776==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jvwPghPpVanPi35O"
Content-Disposition: inline


--jvwPghPpVanPi35O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2014 at 11:41:03PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Index of dma name should use -1, not +1 when capture case.
> Thank you Dan.

Applied, thanks.

--jvwPghPpVanPi35O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmOdjAAoJELSic+t+oim9w8gP/3dorMWEJUnG+Pec7alq+v6U
M6ZNu2oRCvSN4df6xczyCtWMEhmvrXezHvPDugoXHSr91KSUHLbuCXvnaVSus7N0
m/Ak8P/G/9FyR2vliQHCCrwKoB7HbjErDP9WnugqnEnAY31Rkk1yor6s4tvYBYzm
ST9vjqG1jcbPY/L0kYAodmpqvtLIO2iGF6EX1slp+7vi133Ic0Lg4U2X3mEzAott
v4mgX+ffRnWMkKpvu4rxMrf9mvxPLGe56K4yjoi2WUAY3PRdZdJ3h+pu0p9D4xgp
Ir5Is/HEWfVOuurdix9MH7sODALJxdqK0FFwK7rOEcNqBBvX2VKKzM2mYyGcApNI
RUZdA2aXFv8xWmqjn3oHnc8Rr2lb2rgonoRLEWOvnz+J3hyP8o/8cGnjvRx2aNwo
lAoY8wtJZHGT90TjdZ/Xv1CTVae6SNAaaO3iXW21zeTffgEvoy8NST6P0QU9DSYU
G3vYUqtM5uiUtbya4ArPDf2aX52mtEhk8Qbom7iuhtfbCa34QvKPtnxDcTnZmMjR
2QJdogrqsqLEdBX5Gpg89rFivgepqb2l2HHWAD0E5ydhJ0WFMZoHGNB26UptXnIf
gxiaursbNfbLVqfX8v/+GEDsL5pv4hl7cujA5MlNz8ezK9mvhyd51bzl9UtejnqT
YsVU1+aqVSsL4yTEzcUi
=qt2h
-----END PGP SIGNATURE-----

--jvwPghPpVanPi35O--

--===============2547335562338051776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2547335562338051776==--
