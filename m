From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
Date: Wed, 13 Jul 2011 17:01:02 +0200
Message-ID: <20110713150102.GK1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
	<65EE16ACC360FA4D99C96DC085B3F7721CDC7C@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110713140038.GI1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDD7B@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2047631344=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721CDD7B@039-SN1MPN1-002.039d.mgd.msft.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============2047631344==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLauP2uySp+9cKYP"
Content-Disposition: inline


--SLauP2uySp+9cKYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2011 at 02:22:42PM +0000, Dong Aisheng-B29396 wrote:
> > -----Original Message-----
> > From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> > Sent: Wednesday, July 13, 2011 10:01 PM
> > To: Dong Aisheng-B29396
> > Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> > broonie@opensource.wolfsonmicro.com; u.kleine-koenig@pengutronix.de;
> > lrg@ti.com; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
> >=20
> > With your sgtl-patch, I can set the alsa-controls like volume. Yet the
> > WAV played via simple aplay has a massive hall (like a concert at the
> > other end of the cathedral ;)).=20
>=20
> You mean the sound is incorrect?

It was, but is fixed now. There was something wrong in our audio-path
electrically. Together with your DMA patch, music sounds fine now \o/

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--SLauP2uySp+9cKYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4dsy4ACgkQD27XaX1/VRvvewCfVkkfzJ79ozgKJlcxMtSVAA4M
Z7kAnAkKDEZXVdpC6xTL8GfBJ2qgWW4I
=0oVY
-----END PGP SIGNATURE-----

--SLauP2uySp+9cKYP--


--===============2047631344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2047631344==--
