From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: SOF: Add OF DSP device support
Date: Thu, 15 Aug 2019 17:49:42 +0100
Message-ID: <20190815164942.GB4841@sirena.co.uk>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
 <20190815154500.29090-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5864071999345727624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com
 [209.85.221.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 892DBF8011F
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 18:49:44 +0200 (CEST)
Received: by mail-wr1-f98.google.com with SMTP id b16so2780613wrq.9
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 09:49:44 -0700 (PDT)
In-Reply-To: <20190815154500.29090-2-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============5864071999345727624==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2019 at 10:44:58AM -0500, Pierre-Louis Bossart wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> Add support for device tree based SOF DSP devices.

I'm not seeing any binding documentation here.  Binding documentation is
required for any new device tree bindings supported in code.

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1VjSUACgkQJNaLcl1U
h9C9ogf/azqPJo43SmwR3YnM0sdSvQEQHwfDsGNdMofxB5q4EvmkGrkamUZCew65
FNOC7HDmnb4FqsXDUJuXyE3h45cvExWvFMsYr2t5umAMWSg8E4Ak2/O8hmlhfnVS
tWHNAXSQN2TRdVTLs+uD0FlOiSUw6LZtoJ+wvc2DfxpbHlZLWDMwXQ9V5ZqMywwU
l/n0IEuJajcNIFeGuGxFiChVOGD9xl52qslU5H5EvprV0WjTjinT9O3dQFULjFxQ
78/GgAkMbxt0Q2DZD8bunviqy2ikKLqzURoS1qo0M00Hqwr5PhHz+trIlliXtGpZ
K50KGKtmcYho1CWfLFJNGinGFhmoeA==
=MXcA
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--

--===============5864071999345727624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5864071999345727624==--
