From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 1/1] ASoC: mxs-saif: add record function
Date: Thu, 8 Sep 2011 23:42:10 +0200
Message-ID: <20110908214210.GB4423@pengutronix.de>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
	<CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0605607274008473365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 524BB103A9E
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 23:42:14 +0200 (CEST)
In-Reply-To: <CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Dong Aisheng <b29396@freescale.com>, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0605607274008473365==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2011 at 10:29:12PM +0100, Girdwood, Liam wrote:
>    On 7 September 2011 13:51, Dong Aisheng <b29396@freescale.com> wrote:
>=20
>      1. add different clkmux mode handling
>      SAIF can use two instances to implement full duplex (playback &
>      recording) and record saif may work on EXTMASTER mode which is
>      using other saif's BITCLK&LRCLK.
>=20
>      The clkmux mode could be set in pdata->init() in mach-specific code.
>      For generic saif driver, it only needs to know who is his master
>      and the master id is also provided in mach-specific code.
>=20
>      2. support playback and capture simutaneously however the sample
>      rates can not be different due to hw limitation.
>=20
>      Signed-off-by: Dong Aisheng <b29396@freescale.com>
>      Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>      Cc: Liam Girdwood <lrg@ti.com>
>      Cc: Sascha Hauer <s.hauer@pengutronix.de>
>      Cc: Wolfram Sang <w.sang@pengutronix.de>
>    Acked-by Liam Girdwood <lrg@ti.com>

Mark, please wait for my tag. This patch is related to the mach-specific pa=
rts
and both parts should be proper. Shouldn't take me longer than the end of t=
his
week.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5pNrIACgkQD27XaX1/VRvLHACdHpajqqQo9aNv3bHLVROOdOmL
ySIAniOd7aCqJGw0iJ5V88CuSpF9X0d1
=4Cow
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--

--===============0605607274008473365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0605607274008473365==--
