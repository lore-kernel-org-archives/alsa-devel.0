From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 1/4] ASoC: tlv320aic32x4: Support for
	master clock
Date: Tue, 18 Feb 2014 21:46:46 +0100
Message-ID: <20140218204646.GB10590@pengutronix.de>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-2-git-send-email-mpa@pengutronix.de>
 <20140218012329.GR2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3952416971557918810=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 867082651E7
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 21:46:52 +0100 (CET)
In-Reply-To: <20140218012329.GR2669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============3952416971557918810==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 18, 2014 at 10:23:29AM +0900, Mark Brown wrote:
> On Mon, Feb 17, 2014 at 11:04:17AM +0100, Markus Pargmann wrote:
>=20
> >  Optional properties:
> >   - reset-gpios: Reset-GPIO phandle with args as described in gpio/gpio=
=2Etxt
> > + - clocks/clock-names: Clock named 'mclk' for the master clock of the =
codec.
> > +   See clock/clock-bindings.txt for information about the detailed for=
mat.
>=20
> Looking at the code the clock isn't physically optional, why not make it
> mandatory?  There's only one mainline user, it looks like it should be
> straightforward to update with a fixed clock.

The masterclock is physically optional. There are several modes to use
this codec without master clock. The PLL can use different clock inputs,
BCLK, MCLK, etc. and even the PLL is not necessary. Instead BCLK and so
on can be used as direct codec clock input. However, most of this is not
supported by the driver yet and I can't test these cases.

>=20
> > +	aic32x4->mclk =3D devm_clk_get(&i2c->dev, "mclk");
> > +	if (IS_ERR(aic32x4->mclk))
> > +		dev_info(&i2c->dev, "No mclk found, continuing without clock\n");
>=20
> This is going to break with deferred probe, we need to handle that at
> least.

Yes, I fixed this.

Thanks,

Markus


--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTA8a2AAoJEEpcgKtcEGQQ7U4P/2HBuXsLYSZ6YbM201qgFOod
kMXzD7vYoK55k7Br5JcC81I4Fc7Cxm96WSaJGyld0vXAhJta/V57Bmk3kZW+LK5d
qTWGSjI36Q4dhiHVSXIWFlG6lK7EqplIV29alrTNEoipgzmnDfVdEVPX01VL6oul
oAld8qDZFXtBNcV6VQV4FsgMix4ZpqR88WFY+0s9Q/LtE5qLniKV1LlNlXvqAc5r
xmuwXw+t4gmUeClQnioGC3JwryPthR/yJltH4v43xvair7enCdjhb5UG0mtrGrCs
O+ctGXt/HRSxeb4xNrNYz788sXEW5SrOyKMZtAgx86k3CKygwnC7E4ZZIu9HwESk
YmKTbdpdukpp3ZBYqTPPW/EHgmXkamkM/YQ1EB4KsRFUbtSY/MCwbVvw8WvCSItV
OFD3cfAEbArGJqVwtRA/wfyWqc1qcUcaMs1VGN47Dd+oXUgFMT3a3Msm3LdtF44C
Bp9K22jcWu9Ep1Kw/2SrZxnRDg1axjsYV33MqdJTqykegEIno9tt2dz/Pqlr3iaK
Zju2z8Z0OHfWUCxZsu1n3diimXXCdJc4BAUgqlSvEoVwz/tW+Cbz+jeYVpjrnwWm
B5SiHpY9Kg5DaB8biXXl55wI76pWMOJ5WtjHRiFemGrWPZHgP2RQn2w96Ur5BkWL
4HEDjT4U5/BVjUUoC0Km
=GXwL
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

--===============3952416971557918810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3952416971557918810==--
