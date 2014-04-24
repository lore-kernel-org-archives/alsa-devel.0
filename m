From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] ASoC: imx-sgtl5000.c: Add support for
 specifying PDCR_TXRXEN
Date: Thu, 24 Apr 2014 11:32:29 +0200
Message-ID: <20140424093229.GE7361@pengutronix.de>
References: <1398268218-31897-1-git-send-email-david@protonic.nl>
 <20140424084630.GD7361@pengutronix.de>
 <20140424110936.78300197@archvile>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6288764892254994871=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9D7002651F2
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 11:32:33 +0200 (CEST)
In-Reply-To: <20140424110936.78300197@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, David Jander <david@protonic.nl>
List-Id: alsa-devel@alsa-project.org


--===============6288764892254994871==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2014 at 11:09:36AM +0200, David Jander wrote:
> On Thu, 24 Apr 2014 10:46:30 +0200
> Markus Pargmann <mpa@pengutronix.de> wrote:
>=20
> > Hi,
> >=20
> > On Wed, Apr 23, 2014 at 05:50:18PM +0200, David Jander wrote:
> > > This enables effectively swapping RX/TX pins on the external audio po=
rt
> > >=20
> > > Signed-off-by: David Jander <david@protonic.nl>
> > > ---
> > >  Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt | 4 +=
+++
> > >  sound/soc/fsl/imx-sgtl5000.c                                   | 5 +=
+++-
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> > > b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt index
> > > e4acdd8..3afea85 100644 ---
> > > a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt +++
> > > b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt @@ -=
29,6
> > > +29,10 @@ Required properties:
> > >  - mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
> > >  - mux-ext-port : The external port of the i.MX audio muxer
> > > =20
> > > +Optional properties:
> > > +- ext-port-txrxen : Flag. Set to swap RX/TX signals on external port=
 (set
> > > the
> > > +  IMX_AUDMUX_V2_PDCR_TXRXEN bit in the PDC register of the external =
port)
> > > +
> > >  Note: The AUDMUX port numbering should start at 1, which is consiste=
nt
> > > with hardware manual.
> >=20
> > You could also try to use the simple sound card and use DT properties to
> > setup audmux.
> >=20
> > This is a configuration example for the audmux:
> > &audmux {
> >         status =3D "okay";
> >=20
> >         aud4 {
> >                 fsl,audmux-port =3D <MX31_AUDMUX_PORT4_SSI_PINS_4>;
> >                 fsl,port-config =3D <
> >                         (IMX_AUDMUX_V2_PTCR_SYN |
> >                                 IMX_AUDMUX_V2_PTCR_TFSDIR |
> >                                 IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PO=
RT1_SSI0)
> > | IMX_AUDMUX_V2_PTCR_TCLKDIR |
> >                                 IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PO=
RT1_SSI0))
> >                         IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI=
0)
> >                 >;
> >         };
> > };
>=20
> I tried this, but the glue driver imx-sgtl5000.c changes the port setting=
s to
> its own knowledge.... and that includes hard-coded clearing of the
> IMX_AUDMUX_V2_PDCR_TXRXEN bit.
>=20
> How can I avoid the imx-sgtl5000.c driver from clearing the settings I sp=
ecify
> in the AUDMUX driver?

You can use the simple sound card (sound/soc/generic/simple-card.c). The
sound card properties have to be described in the DT. See
Documentation/devicetree/bindings/sound/simple-card.txt

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTWNosAAoJEEpcgKtcEGQQRF0P/0VIVBggw0jwCgNkCBW0wUpv
XcWetZaallUclsodkU9iD0JfyXIvCWSOxkRFLLCJ0KcatcAyOOojzsk/s8PVqLH6
nbtNcaPKNUIuJ9KjPYI5kIjoirSf/9htRRYAROZ8oCRxauaWmqfguqQLbbgnoZFL
7V8uza/uYJkA7neS5UXxH8Q6akvHD3EWs1++7Qr5eRK8gU5ZONjhqXdOfoBSnTgu
a0EBzNQag9fXhjZatWdOmAfT2uwt8ZqTK/OASpAwzWbbn7Bn7DUx0+Vyh+R2eJId
nDXjax9KgqNQxwXTQyYFyMnWTk7mc/Odgv81abUcuPDU0THM/xE2cuIKxT+fs+WP
2MRAEMr0OXkhgZSGdjZfTAP7yDfYBiWXmblDfgv9GVoim1kpxUplXvSOFoJgTbAI
BQ+XOddT+OtEj2/+lmL4HtJpcxoTSih7XjcRJwMOAUVoLUvtwTj8SI3I+aNDJg5B
8AvTowkTr+URUFVIL/3AymgY/OR3mxDUN6K0icGTQYdHuYjma7/UTy8v2ZJ5ZXPu
d0zj+sJYNnpGfUWw5HAHJGoqWM7S3fU+OHyPmse4o408oZOiuVasHIY8RqMy+wUl
7AfMDyrjUB0z3GDCsG/iAJDmRiYi7UmvTz/Bvi1+ZRZuFYw1BaV4iIHjARj7yNNk
C3kjZLgzd8ymRaPbYPVY
=Dm9F
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--

--===============6288764892254994871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6288764892254994871==--
