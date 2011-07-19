From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 18:52:39 +0200
Message-ID: <20110719165239.GB22987@pengutronix.de>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
	<20110719150903.GF9652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3367467519676715572=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4E8C324361
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 18:52:42 +0200 (CEST)
In-Reply-To: <20110719150903.GF9652@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============3367467519676715572==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The first patch removes code duplication
> > The second one is for user-comfort
> > The third one makes the device work
>=20
> Shouldn't we be restructuring this series so that the last change goes
> in as a critical bugfix for stable and the other two code cleanups then
> go on top of it?

Yes. That was the chronological order; I later realized this is suboptimal
here, sorry (luckily the patches are independent enough). Will take care ne=
xt
time.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4ltlcACgkQD27XaX1/VRvlrwCghxUggeE0vxFfZNZHErks8+Gh
SlIAoIl3axFrfWvQczlA+yClWpFq6WWe
=WSVg
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--

--===============3367467519676715572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3367467519676715572==--
