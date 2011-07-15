From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 06/10] ARM: mxs: add saif device
Date: Fri, 15 Jul 2011 17:34:50 +0200
Message-ID: <20110715153450.GA31640@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-7-git-send-email-b29396@freescale.com>
	<20110715133241.GG2021@pengutronix.de>
	<CAA+hA=TtBrDoAMfv0fqj30_heEJuZJFH=QjTUG8zTys0G+vgvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8972161385160410145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 6CEC424336
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 17:34:55 +0200 (CEST)
In-Reply-To: <CAA+hA=TtBrDoAMfv0fqj30_heEJuZJFH=QjTUG8zTys0G+vgvA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8972161385160410145==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2011 at 11:02:36PM +0800, Dong Aisheng wrote:
> 2011/7/15 Wolfram Sang <w.sang@pengutronix.de>:
> >> +#define DIGCTRL_BASE_ADDR =A0 =A0 =A0MX28_IO_ADDRESS(MX28_DIGCTL_BASE=
_ADDR)
> >> +
> >
> > Hmm, maybe define a function mx28_set_saif_clkmux(val)?
> >
> >> + =A0 =A0 mx28_add_saif(0);
> >> + =A0 =A0 mx28_add_saif(1);
> >> +
> >> + =A0 =A0 /*set the saif clk mux, both saif0/saif1 use saif0 clk*/
> >> + =A0 =A0 __raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);
> >
> > You might overwrite previous settings here. The hardcoded numbers need
> > defines, too.
>=20
> It's correct.
> I'm originally going to do that when implement record because this
> setting may affect both
> machine driver and saif driver on recording.
> Since currently we only implement playback, so i just hardcode it.
> Do you think if that's ok?
> Or i need to do it now?

If you just do playback, do you need to mux SAIF1-clk to SAIF0-clk ? If not
(what I'd think), just leave changing DIGCTL out completely since the
reset-default for that register should work. If you do need changing DIGCTL,
some helper function like mentioned above would be better, I think.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4gXhoACgkQD27XaX1/VRuiRgCeIMyu1ZnWdAlIb10qE8r3gscB
cTwAnA5UCYDipE84bpqxDX81CTXCc+TQ
=k9+k
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

--===============8972161385160410145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8972161385160410145==--
