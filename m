From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
Date: Fri, 4 Apr 2014 12:59:10 +0200
Message-ID: <20140404105910.GF20621@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <20140403221406.GI14763@sirena.org.uk>
 <20140404064932.GC20621@pengutronix.de>
 <CAOf5uwkDdsDzRAMHV0e2ideR-R8Tztis1HxqosQAxefVQDE3oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6514424286676943013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 424D32657CE
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 12:59:13 +0200 (CEST)
In-Reply-To: <CAOf5uwkDdsDzRAMHV0e2ideR-R8Tztis1HxqosQAxefVQDE3oA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6514424286676943013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, Apr 04, 2014 at 09:58:03AM +0200, Michael Trimarchi wrote:
> Hi Markus
>=20
> On Fri, Apr 4, 2014 at 8:49 AM, Markus Pargmann <mpa@pengutronix.de> wrot=
e:
> > Hi,
> >
> > On Thu, Apr 03, 2014 at 11:14:06PM +0100, Mark Brown wrote:
> >> On Sat, Mar 15, 2014 at 01:44:08PM +0100, Markus Pargmann wrote:
> >> > Hi,
> >> >
> >> > This new version of the cleanup is mainly a reordering of the patche=
s. It moves
> >> > the regmap patch to the end of the series so none of the other patch=
es depend
> >> > on it. This also fixes a bug I introduced in "Remove fsl_ssi_setup" =
which also
> >> > removed the switching between network and normal mode depending on t=
he number
> >> > of channels. I reversed this code removal. Another new patch was add=
ed "Fix
> >> > i2s_mode variable setup" which fixes the i2s_mode assignment in set_=
dai_fmt().
> >>
> >> It's been nearly three weeks with no response to this except for the
> >> last patch - I've got ahead and applied since it all looks sane (modulo
> >> the bugfix question), we can see if problems occur in -next after the
> >> merge window.  Thanks!
> >
> > Thanks for applying this series, but could you please drop it for the
> > moment? We found some issues with the baud clock setup for i2s master
> > mode and have some fixed patches for the series. So it would be nice to
> > get this in without fixups if that's still possible? I could send a v3
> > next week.
>=20
> We have tested a bit them on Wandboard and rebase our patches.
> I was busy in the last 2 weeks but they are fine so far.

Thank you for testing. Can I add a Tested-by tag to the commits that
didn't change for the next version of this series?

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTPpB9AAoJEEpcgKtcEGQQ6GkQAIoQCKo36zdup+2/drc4Vx5w
XbUh2B/kFVUI20qK9XxxFIUCJZ980YcfKVfeERfxTM3fafbMPWsXig6ZcAiyy8uC
Tz8Pia5I8NDrWWJxDh/5B/QYqP34XtCsuSjH+PA1l7oKJXoV+Zng/rSvNNUTexap
3J/gyaBdveRZBRnPxqSOr2BG2Kse/PkTg7xhQ7jGsHCg8+O46+gouXKgpNHjlPHA
nCY4E7KhUfBYDpNUZvdxn0Ndv2QcPd3gFtbBCnqDvEdBaZqTCN7HNM5oPFZGEm9Z
OUxUFg1cM6XI9zTUJuuITP24TP4deJnbWShBEzeV+0DPeHJm4QON1N2NDQypGWll
ZNXmFd+TgClkCX/183Y1OsGthMa0wQI+1HAJ4tevoWpnq0FHO06XXNjhkhZzndMi
cKgGKAazsWa1w9Zenm7hk9NL6x/ne4SvpVwOjbyjaSpIOABM+JpcaX3yQ2789t1c
8+y6AwIza731j1iXmPeRphlVAl7KDZkpumo7ntGpB5UnouuplIprZTm7aT32xFLk
h4P/Ll4/MDLRI9/EDz3nPsSPRfxapLDauz1J3EPNHpomK0nwSFkTfhrlGwzo2R0p
93DRar39uJKolDYWTonv/OS+LdTEto/VXFTmF6gzgmzzYit5hMQ8gd4tAkPtHtJG
WCxUB2rBYCuLbUvq7OHd
=ymO5
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--

--===============6514424286676943013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6514424286676943013==--
