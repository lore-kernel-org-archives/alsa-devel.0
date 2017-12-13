From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: tlv320aic32x4: Remove filename
 from header and switch to SPDX
Date: Wed, 13 Dec 2017 12:28:24 +0000
Message-ID: <20171213122824.GI6416@sirena.org.uk>
References: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2368067292627390866=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A64DB266B67
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 13:28:26 +0100 (CET)
In-Reply-To: <20171212224311.24045-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2368067292627390866==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2017 at 04:43:02PM -0600, Andrew F. Davis wrote:

> @@ -1,21 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * linux/sound/soc/codecs/tlv320aic32x4-i2c.c
> - *
>   * Copyright 2011 NW Digital Radio
>   *

Having the C++ comment next to a C comment is very ugly, if you're going
to do this convert the entire comment block to C++ style.

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxHOgACgkQJNaLcl1U
h9DCyQf/dEQZAxTkPFqmF9VkG+jLjJ8s0+Z8/fcQ2GfU+XR66FuwmEOZJMosnRbY
rw3jB+Hb6sTUfuaWOWMsyZbw9tz4Wxhhu6GDzvCwY50CBl97m6uixil+P2HtvBCN
BJT0oTFWMhN/diJnxozLI6wAJh+q0WD8tZW3SdyjN/ONlTXSqHvyTs7hFfBbedzk
4ADYrCSaeN3j02z8QX3UKHt+h9dynZwGSY9DBMO5vodB+5lk2168B7TatOnS0v1+
BFQCj1MeKyh1lyXJfL5rt9HNW4nauFjkueBTHc0ACoyFFBDBQSebsecocXpVKYl7
VSH0Z0JbOoY3ZOUTlTNrYm+S+IK9eQ==
=r8IY
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--

--===============2368067292627390866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2368067292627390866==--
