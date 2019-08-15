From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: Intel: common: add ACPI matching
 tables for Tiger Lake
Date: Thu, 15 Aug 2019 18:10:53 +0100
Message-ID: <20190815171053.GD4841@sirena.co.uk>
References: <20190815155749.29304-1-pierre-louis.bossart@linux.intel.com>
 <20190815155749.29304-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6939487625575443314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com
 [209.85.128.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F248F8015B
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 19:10:54 +0200 (CEST)
Received: by mail-wm1-f99.google.com with SMTP id z23so1859379wmf.2
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 10:10:54 -0700 (PDT)
In-Reply-To: <20190815155749.29304-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6939487625575443314==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2019 at 10:57:46AM -0500, Pierre-Louis Bossart wrote:

> index 000000000000..57a6298d6dca
> --- /dev/null
> +++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * soc-apci-intel-tgl-match.c - tables and support for ICL ACPI enumeration.

Please make the whole header C++ style so things look more intentional.

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1VkhwACgkQJNaLcl1U
h9D+lgf/bmvFEadeRHofdgz9IIPVyh7dxAWUifXB34T0APOjfF9a8s7BzSttSq+6
VSV3rucaL7vSDKmliAd9OqV38nUWGLX33HJWuNt2aYa6EQT07qwHIGoqVzJeNbTl
wdeUrl+FtkXcMZTE0Mm6MOsYLgNx2lmcBPFR/wGkqmOGqRXmqqiJMmsKv+XZ4aXO
Lf4a2o7BcZlbZCvjsNce5jdDihXD55muU+SAbcEdvO0C8LSwPbZfnaXwOs9GYTmK
kj/pOamrEITAIsRzxNX0b/9zZFcCGKfEGXF2BxplXMEV1CrEO5fb6Hn9LwYmxdA9
PRybyiv/43gmgv3+2IpWpDAN/PfRNA==
=y2oE
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--

--===============6939487625575443314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6939487625575443314==--
