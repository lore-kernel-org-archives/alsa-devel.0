From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 1/1] ASoC: mxs-saif: add record function
Date: Thu, 15 Sep 2011 15:53:20 +0200
Message-ID: <20110915135320.GG2284@pengutronix.de>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
	<20110909133051.GS1912@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F77225DB00@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5419279943677842068=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 92290103B1D
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 15:53:22 +0200 (CEST)
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F77225DB00@039-SN1MPN1-003.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5419279943677842068==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I think we should use usleep_range for both udelays here? Having a rate
> > of 8000, we'd burn 250us here.
> >
> Yes, I agree that it's a bit long for 8000.
> I tried sleep way but I found the trigger function is called with
> spin_lock held, so it seems we may not be able to sleep here.
>=20
> I think the way of dynamically calculate delay suggested by Liam has
> Already minimize the affection, especially for high sample rate, it
> may work more efficiency than sleep (context switch cost).
>=20
> Do you think if it's reasonable to accept it?

Yes, it can be fixed when it becomes necessary

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5yA1AACgkQD27XaX1/VRvbfQCgs7QlNm4Z6e3kvtiwC5npnQRu
l8sAnRrzKbG7IF/PTeL/axIHHOKN8WoC
=2Go2
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--

--===============5419279943677842068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5419279943677842068==--
