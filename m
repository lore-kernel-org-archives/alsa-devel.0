From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Fix define for SGTL5000_BIAS_R_MASK
Date: Wed, 19 Oct 2011 12:05:59 +0200
Message-ID: <20111019100559.GC3217@pengutronix.de>
References: <1318992896.7128.1.camel@phoenix>
 <CABS+qY2n2xXVvK=CqOPXfH2YOYijPwSAc7tH=CYL1AJXGPxBNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABS+qY2n2xXVvK=CqOPXfH2YOYijPwSAc7tH=CYL1AJXGPxBNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Zeng Zhaoming <zhaoming.zeng@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2011 at 09:06:57AM +0100, Girdwood, Liam wrote:
> On 19 October 2011 03:54, Axel Lin <axel.lin@gmail.com> wrote:
> > According to the datasheet:
> > CHIP_MIC_CTRL 0x002A
> >
> > BITS[9:8] BIAS_RESISTOR
> > =A0 =A0 =A0 =A00x0 =3D Powerd off
> > =A0 =A0 =A0 =A00x1 =3D 2.0 kohm
> > =A0 =A0 =A0 =A00x2 =3D 4.0 kohm
> > =A0 =A0 =A0 =A00x3 =3D 8.0 kohm
> >
> > Thus SGTL5000_BIAS_R_MASK should be defined as 0x0300 instead of 0x0200.
> >
> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
> > ---
> > =A0sound/soc/codecs/sgtl5000.h | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
> > index eec3ab3..8a9f435 100644
> > --- a/sound/soc/codecs/sgtl5000.h
> > +++ b/sound/soc/codecs/sgtl5000.h
> > @@ -280,7 +280,7 @@
> > =A0/*
> > =A0* SGTL5000_CHIP_MIC_CTRL
> > =A0*/
> > -#define SGTL5000_BIAS_R_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0200
> > +#define SGTL5000_BIAS_R_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0300
> > =A0#define SGTL5000_BIAS_R_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08
> > =A0#define SGTL5000_BIAS_R_WIDTH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> > =A0#define SGTL5000_BIAS_R_off =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x0
> > --
> > 1.7.5.4
> >
> >
> >
> >
>=20
> Both
>=20
> Acked-by: Liam Girdwood <lrg@ti.com>

And

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6eoQcACgkQD27XaX1/VRuz2ACgwdQUatLKMYfyWMIR1ZD5x+vE
yNIAn3nqZ/DrzDfI9fWv6an4UGlnTitW
=zmke
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
