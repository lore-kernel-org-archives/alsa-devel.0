From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
Date: Tue, 18 Mar 2014 09:10:19 +0100
Message-ID: <20140318081019.GJ11360@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3279153891023298740=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394894616.578942243@f331.i.mail.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3279153891023298740==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2014 at 06:43:36PM +0400, Alexander Shiyan wrote:
> =D0=A1=D1=83=D0=B1=D0=B1=D0=BE=D1=82=D0=B0, 15 =D0=BC=D0=B0=D1=80=D1=82=
=D0=B0 2014, 13:44 +01:00 =D0=BE=D1=82 Markus Pargmann <mpa@pengutronix.de>:
> > This patch replaces the ssi specific functions write_ssi, read_ssi and
> > write_ssi_mask by standard regmap function calls.
> ...
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> ...
> > +static const struct regmap_config fsl_ssi_regconfig =3D {
> > +	.max_register =3D CCSR_SSI_SACCDIS,
> > +	.reg_bits =3D 32,
> > +	.val_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +#ifdef PPC
> > +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> > +#endif
> > +};
>=20
> Why we cannot use REGMAP_ENDIAN_NATIVE here for all cases?
> Theoretically, we can use for i.MX SOCs with different endianness,
> so this will help us.

I can change and test it on i.MX, but I am not sure if it helps with the
PPC situation as I don't have the hardware.

Regards,

Markus

>=20
> ---

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTJ/9rAAoJEEpcgKtcEGQQq5EP/RegGeg0cHhKSjNGelafOgGQ
HDpFANhGi5d/Yz1Lfe6vTTlQSRWp2yauWjVzBw756uw+64K9RFImm+RyL7lh57rr
8vRTAKy6o9DlHB/pxBWCpj49Qan6sAWJCdmLhy1FUj5WWCQ0jzTIRPnOJ+4SSiq0
iPkwJhH7HuVIdSMreDSzfVdVteZKcbIW1xzMLlCvCTj8JrMNs9oGGvMw+uDEqamT
iSCgo9WTe07LiE1FZstylFpkjyWpZc4Hv1OYcJSYrS4CzxhcQWkN2VrAZf56uUpr
uIusYmkekHld1fzgG0QBBXc+ltUIqvulzZP2G+QbepOVfkVMzIRdPG8DbcbR2uNw
he+XPoyWz3X3kvv7Xe1OzyqvRnHpSws/m6y8nyKwt9K7hwG4kFKYloSYp/CulFCf
NN5Tub68I/yIR7y7JFKNhIOwUgSRh08y/mFiIQWtDfEb3+hCajJqtasFW2GlzAmj
eeTjdd14e2vlpV60UgGpDIzeXnQiAVkA3v+ZL3Hphk1rod+8FMQpDZv7So/2qXTa
ZzPaUvP5G8gwFwRdlTZk/BBhThicrTtdPZU/G9Wp7CTUpjwgUAxUnnDu/dJmVQsd
3wBzvFPdxt+c5ho35y089e8k9OiTX0uuu4msfXYIlleKcy8pEeX4KEcxSnecV2k4
GJoQAcNjQLx7Y9oSHz/P
=dx6y
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--


--===============3279153891023298740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3279153891023298740==--
