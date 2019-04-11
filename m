From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Make boards more available
	for compile test
Date: Thu, 11 Apr 2019 12:01:15 +0100
Message-ID: <20190411110115.GC7953@sirena.org.uk>
References: <20190410163800.31376-1-broonie@kernel.org>
 <765c0d7b-8589-b1ba-3592-59ecb0cc22d0@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6716219149607595692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EC23F80716
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 13:01:18 +0200 (CEST)
In-Reply-To: <765c0d7b-8589-b1ba-3592-59ecb0cc22d0@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6716219149607595692==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 01:05:40PM -0500, Pierre-Louis Bossart wrote:
> On 4/10/19 11:38 AM, Mark Brown wrote:

> > The Intel boards have very strict dependencies which make them less
> > available for compile test than is desirable, with requirements for
> > specific drivers that are only needed at runtime but not at build time.
> > Relax this a bit if COMPILE_TEST is enabled to improve build coverage
> > for these drivers.

> It's really asking for trouble but it's the right thing to do. Let's see how
> many issues get reported...

It's probably fine, they get covered by allmodconfig already - it
certainly didn't immediately trigger any issues for me.

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyvHnsACgkQJNaLcl1U
h9BAlgf6A3PsPmvzQfpa/L2RHjz3a/c2SIh9ELVAZj/X1ITv2BO5kTqKOevvV/xq
5L/Wa61oyiI7K1KOfluQVgdDm1/5jl7FHLv22DZvHIazJdbaRGvxBxVqW0rTa6iI
AYLoj1sMKebyTAilGWntawULFIY6OGwpP+QxCqHuOtw8p9HIrL5GYBGELGFJjwxA
qaPHIpseY12xKL2ex7mVFvTbLRiPyjav7oZMupmGX0/mwyH2In7yJPc5xAj+11X2
20720GlyCHwC9hDxZJXasq9rIsXUdN79MN+eepSU1cnQk5B5cgkaIebRx+H06bGW
BVBvzp2mdFw0XIj6e1bGEvpMTcNwzw==
=R4Xg
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--

--===============6716219149607595692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6716219149607595692==--
