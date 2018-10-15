From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Boards: Add KBL Dialog Maxim
 I2S machine driver
Date: Mon, 15 Oct 2018 12:01:09 +0100
Message-ID: <20181015110109.GA12949@sirena.org.uk>
References: <1539070547-14240-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4801016831337130308=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 15A0C267737
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 13:01:12 +0200 (CEST)
In-Reply-To: <1539070547-14240-1-git-send-email-mac.chiang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mac.chiang@intel.com
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4801016831337130308==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2018 at 03:35:47PM +0800, mac.chiang@intel.com wrote:

> @@ -0,0 +1,983 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(c) 2018 Intel Corporation.
> +
> +/*
> + * Intel Kabylake I2S Machine Driver with MAX98927 & DA7219 Codecs
> + *
> + * Modified from:
> + *   Intel Kabylake I2S Machine driver supporting MAX98927 and
> + *   RT5663 codecs
> + */

Please don't mix C and C++ comment styles, just make the entire block
C++ style so it looks more consistent.  However this looks otherwise
good so I'll go ahead and apply - please send a followup patch fixing
things up.

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvEc3QACgkQJNaLcl1U
h9BKnwf7BueQUuTiPerTD0qsMjzOaSI/ayrS/w2Vuv+UZxgqOKfS5nDRogYzXYLJ
lr/oI8xa0ZPVUt54/TfXZmYyzfFN9aA9fNZXeHoS1DgvIMi481TxC68J9WBJvzZV
NaXm+0S1rJzImMt/Trj6JW6O0KJJRgS/LIfvbkpRe16j2m/j4fAjzU1a9zNzBkjz
4we2GBuK5xjerfMvYx2LvcNZYr76h4cEuK7wFdCTFijanza97fM8M/0lpgvdtPmY
RrJusmTST8sT7kuGBG+F+vsj5NuQ2bTrAZJ7+faIB2nGFbPkvbZWmUG3rEpXcmDx
tEvkFH3T72MdbmlZVOKmWWRjKPGL4Q==
=bYGL
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

--===============4801016831337130308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4801016831337130308==--
