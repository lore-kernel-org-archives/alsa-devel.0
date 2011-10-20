From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: ASoC driver parts probing order (MPC5200/MPC5121)
Date: Thu, 20 Oct 2011 14:13:03 +0200
Message-ID: <20111020121303.GE2379@pengutronix.de>
References: <20111020122317.6c705289@archvile>
	<20111020105940.GB2379@pengutronix.de>
	<20111020133758.27011ac7@archvile>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2496842207027403124=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5A4A524765
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 14:13:06 +0200 (CEST)
In-Reply-To: <20111020133758.27011ac7@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2496842207027403124==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I think I was not clear enough. I meant sound/soc/fsl/mpc5200_dma.c, not =
the
> actual Bestcom DMA driver.

Ah, okay, sorry misunderstood that.

> Btw, I am writing a DMA-less driver for the MPC5121e for now. It uses the=
 PSC
> FIFO and FIFO alarm interrupts. DMA support could be added later, when de
> MPC5121 DMA driver becomes capable of doing device IO.

OK, seems sensible for a start. MPC5121 does not get much love, so small
steps are definately a good idea.

> > > 1.- I can't test it on a MPC5200B, so therefor I need help.
> >=20
> > I can do tests.
>=20
> If you could try out latest mainline, to see if the driver still works,
> that would be great for a start. I am almost certain it either doesn't wo=
rk
> anymore, or you have a 50% chance it crashes while booting.

OK, I will leave for Prague in the next hours, so until I return, I can
do only remote testing. But I should see OOPSes this way nonetheless.
Might take a few days, though...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6gEE8ACgkQD27XaX1/VRujCQCeORGR9ItDvvTlZp4XM0obZ10s
RJ4An0F0bVUaZX9coRumSrnQVMF1kART
=qgWo
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--

--===============2496842207027403124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2496842207027403124==--
