From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: ssm2305: Add amplifier driver
Date: Thu, 17 May 2018 18:08:26 +0100
Message-ID: <20180517170826.GV20254@sirena.org.uk>
References: <20180517135518.29345-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7973636498156069458=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5CD2671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 19:08:30 +0200 (CEST)
In-Reply-To: <20180517135518.29345-1-m.felsch@pengutronix.de>
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


--===============7973636498156069458==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IX4edXMD7HczJcpd"
Content-Disposition: inline


--IX4edXMD7HczJcpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 17, 2018 at 03:55:18PM +0200, Marco Felsch wrote:

> +++ b/sound/soc/codecs/ssm2305.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices SSM2305 Amplifier Driver

Please submit a followup patch which makes the entire comment a C++ one
rather than mixing them in the same comment block, it makes things look
more intentional.

--IX4edXMD7HczJcpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9twoACgkQJNaLcl1U
h9AajAf/UiZ8aywvLaN3ZCWmVFKBn3bIuoD4mopj84yGqcJ6HGfqErzePPVijPQv
5iT04Hiw6YkmDV1v1AdtgpiwLlINXIE11dP5leARFZxQEyeM3KN8IAIbewR2sCj4
tud4b6SoBOCHm2FPssO0Ja8B3TkBjt9WvY42Xz2S8lGbXrKH8Janjw75Lj+5xOpo
HUSKd0ttM7FahNir3uY+4Lzt2KURBLCOU7BYXCC+c4aYKyhA6V4qwG5VSLsJmABe
aR4UqcO/zLaSk57bKO4tutnVxH5VXRwQ46DvHoyz18asd4lSoqa3alV/weI6m6dQ
Z5Ycc83N/zv6IDKIjgqfQ27MtMM2hQ==
=OMJm
-----END PGP SIGNATURE-----

--IX4edXMD7HczJcpd--

--===============7973636498156069458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7973636498156069458==--
