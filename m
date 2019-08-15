From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: Intel: common: add ACPI matching
	tables for EHL
Date: Thu, 15 Aug 2019 18:11:43 +0100
Message-ID: <20190815171142.GE4841@sirena.co.uk>
References: <20190815155749.29304-1-pierre-louis.bossart@linux.intel.com>
 <20190815155749.29304-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8644267491024884258=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com
 [209.85.128.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3676DF8044C
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 19:11:44 +0200 (CEST)
Received: by mail-wm1-f100.google.com with SMTP id o4so1868146wmh.2
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 10:11:44 -0700 (PDT)
In-Reply-To: <20190815155749.29304-4-pierre-louis.bossart@linux.intel.com>
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


--===============8644267491024884258==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2019 at 10:57:48AM -0500, Pierre-Louis Bossart wrote:

> +++ b/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * soc-apci-intel-ehl-match.c - tables and support for EHL ACPI enumeration.

Please make the entire comment a C++ one so things look more
intentional.

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Vkk4ACgkQJNaLcl1U
h9Bbqgf/fqY55m8s21S5MoWeRbo6n4iwlfQd9dR013fM5S5SZQDYdrpMRqfowv+C
M7iKzDiuxiQ2nL95NYbk0EqEh5EB75sQowFH/uor7Pmx5QqNXJQbdqJhbJSob3We
Ytvmojpw5JhF9EPDA3gzPDcEgWYWab80NvmEaTJYVG2Rt+/EaN0WmDMTh/+ChD9T
bwOSJH9Y6wR5Nw6OLGvtML/0+l1yf0IllMqpYMPIgTa0wwmipaMuChBdy52J4ICR
jiLPJ8CNvZatk+VMbPU4Yc3RC/qaWcqVpj+UM9lBJA2Vt490CqSELdzE51pwA5ih
6zkSwHrWd4prbbRAoBFrwwoytGwzng==
=Yx++
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--

--===============8644267491024884258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8644267491024884258==--
