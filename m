From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
Date: Fri, 21 Mar 2014 09:45:37 +0100
Message-ID: <20140321084537.GA30910@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru>
 <20140318081019.GJ11360@pengutronix.de>
 <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
 <532B04D1.9000405@tabi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8684112471360935705=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AEA7D265314
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 09:45:50 +0100 (CET)
In-Reply-To: <532B04D1.9000405@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander Shiyan <shc_work@mail.ru>, Mark Brown <broonie@kernel.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8684112471360935705==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 20, 2014 at 10:10:09AM -0500, Timur Tabi wrote:
> On 03/20/2014 01:07 AM, Li.Xiubo@freescale.com wrote:
> >While for the scenario like our LS1(ARM) platform.
> >CPU		SSI
> >LE		BE	then should we set the .val_format_endian to
> >			REGMAP_ENDIAN_BIG
> >
> >
> >And so not only for PowerPC, but also maybe for ARM platforms.
> >So here how about just adding one Boolean property like 'big-endian' in =
DT node
> >to learn the endianness of the devices dynamically ?
>=20
> That's not a bad idea.  The property should be something like,
> "fsl,ssi-endian" and is should be set to "big", "little", or
> "native". In the absence of the property, it should default to
> native endian.

Perhaps it is better to create some generic binding for that? There may
be other drivers/components that have the same strange combinations and
need a similar binding to use for regmap.

We could use something like an "endian" property with "big", "little"
and "native" which is then parsed by some function of the regmap
framework. It could directly fill those information into the
struct regmap_config.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTK/wxAAoJEEpcgKtcEGQQOMEP/Rnrl7d4jLhjhyUYkMm1vkbj
guwSk5xKFFYX5lmMEIQlOCdU3tqzOV9SBG1sM/U7BoCYW+OXE4DN+lbQzVi4et7g
RrWywA6PjiM+XHxg+Wfjz415m0sKAGya4Aj5qWzPGRI3pn7jc2MB54eM6gTFTPJi
NEB4M529a+j2UtzJQjAtuXOfaT3kP8zpO3xg0U26mOznKY/zB5b6dtOuCbivWtVB
i/V6fVooPSjqzlzIp1xu+oj5T4Stv8RKzUxLrGDjpOLCD4EdOc1p0jLOaIOQHVyS
9XRN/rlPfQqfvJEBOJxqNFlUBJTsAxUPKqKTyF7qbzovR3k/rwUQagQrnr82GjRE
OvlKLyznZ8r6JyGRXnXwczgziNeAm6txuduC2UQ7iVPBSbd2dHxbK+QwvjgQRE+/
J0sdTMHZUZ5ZVcXxrSDQnKBN3tHL3fZr4PCfiiiTGAQM4maW+C8kZOuuRj84drca
gHt1p2zDBz7xbYfWE6t9Za+nADFuJmhwHzzvLyVbmtyaJxdCSp7BrYl7j6MiwAfa
pVZj1z58tW5JeXZOgHFlU2iFWSpnEX/H3InriAGj0BIF48Q7exN6xMTPBUjilfTt
Ssn5Si5bZ3Zi6vsNC5XspKfhCjcipr0kKZ6WO+ZQsjkoTW5BPqcmkDcTmrCRsvZJ
12uxmKGGvnCiqwNT+7bv
=DuLI
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

--===============8684112471360935705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8684112471360935705==--
