From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-ssi: Check the return value from
 clk_prepare_enable()
Date: Thu, 5 Dec 2013 00:01:31 +0000
Message-ID: <20131205000131.GH29268@sirena.org.uk>
References: <1386196064-6199-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5426160705901352052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E13B72654CF
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 01:01:33 +0100 (CET)
In-Reply-To: <1386196064-6199-1-git-send-email-festevam@gmail.com>
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


--===============5426160705901352052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Edk6HoYKP7RsK9ib"
Content-Disposition: inline


--Edk6HoYKP7RsK9ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2013 at 08:27:44PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> clk_prepare_enable() may fail, so let's check its return value and propag=
ate it
> in the case of error.

Applied, thanks.

--Edk6HoYKP7RsK9ib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSn8JYAAoJELSic+t+oim9GLoP/0a88ioSU7ZxmDz4fihL6Sy7
BQ9/5t8VBWLzaTfKaHGMxq2Cv0Gy2SjRUc/WYi+YwAz0YpQWw0yOXqvObgYC1hwN
2V5ea2izTWJU4i5k9zjf/+EEldnGqVXrEukHus3BWHwgdno1V9E1uOKfMqzdAX7x
ilF+eJ1HkW2TfZshC/zxMs3AkHC+BWNvatulAGBNkRJ7olcXK3SOJoDio5loednk
g46VRwX92HqJUwOmFBWzmhSRAZcmPDN9KwIy0nuyaYPtBgEoI3Y/1dyFwVwqRxzv
yWVo68fH3DADtwD147OBy/l+MefNJorXN0ACttvJ/BLA4C2oA78zRNLhtGz+lwGl
PPbZ9bnl07opswKy8NZVyF3yUHPQ5vnP8ZNh6nqp1TNvGFQWFkzV3nAVjT3esJJD
UE4JUZUlEXGE2UvwawiKKTSWXQTegh6PKfHWAobdn8zDcRSUpfR3Mb3r/26xE2KF
Gj4u8ux2eLT1kWZLXNKwaWOETOZR9KVb4hBRL8q0upTl2CF7iRpR+kqfsBlpfvHG
eGv9o9pkmSgc4LAY50mWOCwp6LOQHn/2InMTnRWtleNih+Mt6Xq64FiaI9jpja44
CbgKZoK/EgBnz4j/63luSHSs8fICBEWVvsWoxmUAO4l0s7j6Ed4KwkHKAdf9FsIj
7Mf31BoSEIxZ/bJVgGk8
=Hno9
-----END PGP SIGNATURE-----

--Edk6HoYKP7RsK9ib--

--===============5426160705901352052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5426160705901352052==--
