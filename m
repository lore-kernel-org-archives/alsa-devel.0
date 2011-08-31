From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC 1/2] ASoC: imx-ssi: use dma_writecombine
	consistently
Date: Wed, 31 Aug 2011 21:33:58 +0200
Message-ID: <20110831193358.GC2197@pengutronix.de>
References: <1314280496-21826-1-git-send-email-w.sang@pengutronix.de>
	<20110825141945.GW31404@pengutronix.de> <4E56768C.4080409@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4257667136754783112=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id DCD0924474
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 21:34:01 +0200 (CEST)
In-Reply-To: <4E56768C.4080409@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4257667136754783112==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2011 at 05:21:32PM +0100, Liam Girdwood wrote:
> On 25/08/11 15:19, Sascha Hauer wrote:
> > On Thu, Aug 25, 2011 at 03:54:55PM +0200, Wolfram Sang wrote:
> >> If the channel is allocated as writecombine, then mmaping it should al=
so
> >> use writecombine. Also, add a proper device for the call. Ported from a
> >> similar fix for mach-mxs.
> >>
> >> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> >> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> >> Cc: Liam Girdwood <lrg@ti.com>
> >> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >=20
> > both:
> >=20
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
>=20
> Acked-by: Liam Girdwood <lrg@ti.com>

Mark, can you pick those two up?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5ejKYACgkQD27XaX1/VRuE3wCgy9nYEwbEeAulhCYwpz5vJaKl
8i4AoIJKKznl5QxawT63HrQxnHvGVEey
=L9Pc
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--

--===============4257667136754783112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4257667136754783112==--
