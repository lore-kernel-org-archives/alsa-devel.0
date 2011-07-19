From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 18:46:39 +0200
Message-ID: <20110719164639.GA22987@pengutronix.de>
References: <20110719090404.GD1951@pengutronix.de>
	<20110719151337.GG9652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6680791369779494137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9146D2435D
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 18:46:41 +0200 (CEST)
In-Reply-To: <20110719151337.GG9652@opensource.wolfsonmicro.com>
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
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>, alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============6680791369779494137==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2011 at 04:13:37PM +0100, Mark Brown wrote:
> On Tue, Jul 19, 2011 at 11:04:04AM +0200, Wolfram Sang wrote:
>=20
> > >     pls check http://comments.gmane.org/gmane.linux.alsa.devel/83781
> > >=20
> > >     I think Mark is right, sgtl5000 already declared its register_ste=
p is 2, soc_cache.c
> > >     should generate a dense cache layout instead of padding it by dri=
ver.
>=20
> > Thanks for the pointer. I can follow Mark's reasoning. In fact, I was
> > wondering why ASoC does not consider the step, but I assumed it was
> > intentional. With my holidays coming along, nothing I am going to
> > tackle in the next time, though ;)
>=20
> The only reason steps are ever used is for AC'97 devices which don't use
> the generic cache code as they're pretty much obsolete so the framework
> support is mostly just carried around as legacy.  The step size is used
> in the cache display code which does use it.  If someone was interested
> enough to convert AC'97 over that'd be nice.

I am a bit confused now: Do you want to retire the step size in the long ru=
n?
Then my sgtl-patch might be the right approach after all.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4ltO8ACgkQD27XaX1/VRsfLACfXIbPNS1nSz6ME4l2UIwVxkAE
as4An0IuscrDeAN301oanJF8QwPGlCfE
=rl8Y
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============6680791369779494137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6680791369779494137==--
