From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: SOF: core: fix undefined nocodec
	reference
Date: Wed, 8 May 2019 15:27:17 +0900
Message-ID: <20190508062717.GK14916@sirena.org.uk>
References: <20190507163236.8783-1-pierre-louis.bossart@linux.intel.com>
 <20190507163236.8783-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2080623928667349074=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FB79F807B5
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 08:27:26 +0200 (CEST)
In-Reply-To: <20190507163236.8783-3-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============2080623928667349074==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NILByKcPRZiJ7ENr"
Content-Disposition: inline


--NILByKcPRZiJ7ENr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 11:32:36AM -0500, Pierre-Louis Bossart wrote:
> The existing code mistakenly uses IS_ENABLED in C code instead of as
> in conditional compilation, leading to the following error:

> ld: sound/soc/sof/core.o: in function `sof_machine_check':
> sound/soc/sof/core.c:279: undefined reference to `sof_nocodec_setup'

There's nothing wrong with using IS_ENABLED() in C code - it can be
cleaner than using an ifdef to help the compiler eliminate unneeded
code.

--NILByKcPRZiJ7ENr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSdsUACgkQJNaLcl1U
h9DYAwf+Ig9zk0WlBw+wHjTOSc+d/0hQMkbfa1KESbPM2QIbe2V375ilLT++lfbn
v4WEXU233KLI+aEBAsECGiRSwLr9WAyNfz2baYzHzMGpeiP8J32ea1259YQpEwdC
jodvVC3BfRaTD8R5slc/oyz6TteT2nSuzlKB0jYX6X5aTLVXa5FE/dos9BOciFCT
OHeyA3fSyF1bzddv0i5jchp6P4veEmo3whksRbprbkoGgX088B/O5UxyyUqHR2ep
+EDDyjW5OSmHLPZjscuwvqy7HWiMdCJDRnGpCKFAselvZe8RYtuRa+BiEVz1hDRf
LARews8wJ3oueNKJyQdfPG2Wyzus+w==
=gQNd
-----END PGP SIGNATURE-----

--NILByKcPRZiJ7ENr--

--===============2080623928667349074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2080623928667349074==--
