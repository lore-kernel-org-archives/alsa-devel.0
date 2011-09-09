From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 1/3] ARM: mx28evk: add platform data for
	saif
Date: Fri, 9 Sep 2011 15:41:05 +0200
Message-ID: <20110909134105.GT1912@pengutronix.de>
References: <1315403858-9904-1-git-send-email-b29396@freescale.com>
	<1315403858-9904-2-git-send-email-b29396@freescale.com>
	<20110907181811.GX28816@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F77223C8CB@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1133865734337519013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 801C22417D
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 15:41:10 +0200 (CEST)
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F77223C8CB@039-SN1MPN1-003.039d.mgd.msft.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1133865734337519013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/FJxnyttrH06HRq2"
Content-Disposition: inline


--/FJxnyttrH06HRq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +static unsigned int saif_clkmux;

Can't we just read the register in get_master and spare the static
variable?

> > and is it intended that if you do:
> >=20
> > 	mxs_saif_clkmux_select(1);
> > 	mxs_saif_clkmux_select(2);
> >=20
> > the SAIF_CLKMUX_SEL bitfield ends up being 3?
> Yes, it ends up being 3.

Needs to be fixed, of course. The function will need locking then.

> > >  extern const struct mxs_saif_data mx28_saif_data[] __initconst;
> > > -#define mx28_add_saif(id)
> > mxs_add_saif(&mx28_saif_data[id])
> > > +#define mx28_add_saif(id, pdata) \
> > > +	mxs_add_saif(&mx28_saif_data[id], pdata)
> > should it be a seperate patch to add pdata for saif devices?
> How do you suggest to separate?
> All changes are mainly to add saif pdata.
> You mean to move DIGCTL related saif pdata function to another patch?

I think he meant one patch for adding the functions in clock-mx28.c and
one patch to use the stuff when adding the pdata. Uwe?

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/FJxnyttrH06HRq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5qF3EACgkQD27XaX1/VRufXACfQjxfxyr7eEImuAC25/wRXdGG
IJ4AoJj7A3erleKJgZDhvwMUWsWQ7qjl
=VtHu
-----END PGP SIGNATURE-----

--/FJxnyttrH06HRq2--

--===============1133865734337519013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1133865734337519013==--
