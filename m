From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: ssm2305: Add amplifier driver
Date: Fri, 18 May 2018 09:31:30 +0100
Message-ID: <20180518083130.GA24209@sirena.org.uk>
References: <20180517135518.29345-1-m.felsch@pengutronix.de>
 <20180517170826.GV20254@sirena.org.uk>
 <20180518080711.asgrisdqxgzm3ziw@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4090056778719450929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63FA0266F4E
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 10:31:37 +0200 (CEST)
In-Reply-To: <20180518080711.asgrisdqxgzm3ziw@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4090056778719450929==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 10:07:11AM +0200, Marco Felsch wrote:
> On 18-05-17 18:08, Mark Brown wrote:

> >=20
> > Please submit a followup patch which makes the entire comment a C++ one
> > rather than mixing them in the same comment block, it makes things look
> > more intentional.

> I'm a bit confused. As documented by the=20
> Documentation/process/license-rules.rst the license header should be a C++
> comment but for all block comments the 'normal' coding style should be
> applied. I can seperate the license header and the comment to make it
> more intentional.

> // SPDX-License-Identifier: GPL-2.0
>=20
> /*
>  * Analog Devices SSM2305 Amplifier Driver
>  *
>  * Copyright (C) 2018 Pengutronix, Marco Felsch <kernel@pengutronix.de>
>  */

> Is that better?

No, that still looks like a mess.  Just make the whole thing a C++
comment.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr+j14ACgkQJNaLcl1U
h9BvFAf+NJSpSUKzANz7YjS6xLtNVNzU2XKgigvVjQZCAojOqz0GAiYZ45v8oN07
XaLTJY9YMNV30eeTmpZn5HyG1djjlRIAC/gb6CKfnGSFWtME/PzfUA4/QbMyhBhf
dXA5NovzuD7PSK6jkrAEyHnRI1f4lOmZXuBje2dkCSIMve29Mmpqm2ETV2L9vQa1
7x2kxb5eNyuTSCPbmrlji8mDPeIg2kQvJ6loQEur05IFKY6tknK0qnX2kctXq08T
YMPSRGj0JaUqgALH5jcfanQ36C95qrUW0TOYr7i57kpBwwq1pXVFZ3LIJ9ulUdrr
hc9qOAeQUbMdF1Qo6eWpkKre1tdXkg==
=JjO1
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--===============4090056778719450929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4090056778719450929==--
