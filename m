From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/RFT PATCH] Revert "ASoC: fsl_esai: ETDR and TX0~5 registers
 are non volatile"
Date: Fri, 7 Jun 2019 12:12:44 +0100
Message-ID: <20190607111244.GE2456@sirena.org.uk>
References: <20190606230105.4385-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cnnC1+vf4lqgEF19"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190606230105.4385-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: shengjiu.wang@nxp.com, timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--cnnC1+vf4lqgEF19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2019 at 04:01:05PM -0700, Nicolin Chen wrote:
> This reverts commit 8973112aa41b8ad956a5b47f2fe17bc2a5cf2645.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

> 1) Though ETDR and TX0~5 are not volatile but write-only registers,
>    they should not be cached either. According to the definition of
>    "volatile_reg", one should be put in the volatile list if it can
>    not be cached.

There's no problem with caching write only registers, having a cache
allows one to do read/modify/write cycles on them and can help with
debugging.  The original reason we had cache code in ASoC was for write
only devices.

--cnnC1+vf4lqgEF19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6RqkACgkQJNaLcl1U
h9Co7Qf7Bkg3ndyaPGB0nY7y53/txpehf1drjHOKGiWoZ0+zJMVKS1VxMRflVs5s
/jl1lph0ebC8gfz/UipI3j7ZrLPd1tRsasfmuIpa4aDTAd5h3ekJe2uMHyxDiATf
+riYjRV5ZiBQ5EFVZQN2j9VMvtJGfaLsDD6Wkc4laIvAevPThDKrs5YLyiH/ncrn
q1RktO/C3gfdAuUd0x0oGbHOlpXuMw8AaT0I6NNonOM5GlLqDq0jUw9Or/WdOepk
UMskpFmlTMYNm9AcJGvZ2JemvZ+fYCZUs+1nU2h6+MgEBIs1DqvdYagwnFXb4K1J
ZkaAUBJ2IdDf+r2aYfr+BVFEUIjuPA==
=AgxG
-----END PGP SIGNATURE-----

--cnnC1+vf4lqgEF19--
