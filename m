From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
Date: Thu, 27 Feb 2014 16:23:32 +0100
Message-ID: <20140227152332.GA30791@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
 <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8515376569260879765=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7EE3B261B20
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 16:23:36 +0100 (CET)
In-Reply-To: <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8515376569260879765==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 27, 2014 at 02:08:45AM +0000, Li.Xiubo@freescale.com wrote:
>=20
> > @@ -134,6 +115,15 @@ struct fsl_ssi_rxtx_reg_val {
> >  	struct fsl_ssi_reg_val rx;
> >  	struct fsl_ssi_reg_val tx;
> >  };
> > +static const struct regmap_config fsl_ssi_regconfig =3D {
> > +	.max_register =3D CCSR_SSI_SACCDIS,
> > +	.reg_bits =3D 32,
> > +	.val_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +#ifdef PPC
> > +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> > +#endif
>=20
> Is this really needed for your PPC platforms?

I don't know if this is necessary. I don't have any PPC hardware where I
could test this driver. This is just a guess how regmap for this driver
and PPC should look like based on the previous code. So it would be
great if anyone could test this regmap config on PPC.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTD1h0AAoJEEpcgKtcEGQQZg0QAKRG/69pJA9MP8sQdelgYXDJ
gHpetZQpi2iZ4/h6eCcxCT+lu72ebnitBRIVTBypxI3eMAJAp27DASPYinFP5F0S
xhyN7EdJJKRsJZ1n2wrD332I5DF9a2nFAUqnE527h8D2gQMTffpa4lViDz+fJwGO
zBJP9uw+A3TkeKRZATDLSwMIwIzaFAZwojS2HErBpjV0jOEyFV4boRcKIpJzfjja
MHIWdxOyns4ddHfXJbhdoMLlpiy23nGWckXDEtkyiUL6CkAJrQjCNINPFUf5K6TZ
i6LFGBazo02cmXXKFkwceMrCIw4H9/F06IMAb50I39Sfjl34XXw8TqbgOk+2RMHe
Z99eSHvcYwXLq91otwgiiW3zCGAxRx+S9JK3neQbeL1N3u2y0MvwAcfZ3wcEbxiy
FDJ4EKdA4TZ3DCD3YSD/jneij5SWKW7c1Qmjhu/nHx5zjxGGqhX+wxJdj+Tu+Hc2
/h5XUU+qD9nFoSYRmOyfafaE26VSndMcsK4K7zJh4HdfK0K1aGGYLb4bj5Ds7N0S
JFJvyGGSFDfX+30TqIBnw+kMT9CzEseeHwAGFisCHTWPT8r4ZrsHUpszDH+MrYGS
KRvbXcQ0fqpJPRoMoU5tI+rZZtonE0adANWMeaeHFg4NYPcCWReFXSSep2Kj4KxM
Z/onSF9bf37kt75crYvV
=Nzsf
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

--===============8515376569260879765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8515376569260879765==--
