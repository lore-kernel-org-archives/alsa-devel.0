From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Thu, 3 Jul 2014 12:16:27 +0100
Message-ID: <20140703111627.GX410@sirena.org.uk>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <20140701164134.GH2296@intel.com> <53B400DE.3040205@baylibre.com>
 <20140703064147.GK2296@intel.com> <53B539E8.1000301@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7832758868041632335=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DA172654BC
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 13:16:46 +0200 (CEST)
In-Reply-To: <53B539E8.1000301@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Vinod Koul <vinod.koul@intel.com>, misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7832758868041632335==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ycl1UgPPPgGZoSL"
Content-Disposition: inline


--4Ycl1UgPPPgGZoSL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2014 at 01:09:28PM +0200, Benoit Cousson wrote:
> On 03/07/2014 08:41, Vinod Koul wrote:

> >I think that will simplify it. we certainly dont expect different direction,
> >right?

> Any thought on that? Does that sound reasonable to you to use only the first
> codec_dai to figure out the direction?

Yes, it seems sensible enough to me.

--4Ycl1UgPPPgGZoSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtTuIAAoJELSic+t+oim9MzwP+wfuI3BctB/qVoHVh+Yhb5Kt
hrHH/EpZv7fmGveVutoCM5YYTzzY7r8/zrvxqoP3P3tm/5xoK4f9HesbiuoN2lNY
LMkZwo+MmSA/kOOo5Xr4sTmLqq1LLviuC9Nv7P/RMN39BI5Qo34oGmBBes6YHXUO
r5Ccd3pyg0qZ3zGprE2nc/Xws58Y5WujLBqhUlRKYB6xiNMjIr4j958u/1JZCuSI
LiczEOdl9y92YPxZnHrjj+58LWAavBg5U0WsEhodpjXT02Sg+4XvazmrrNDFEhIh
3fZS+bmj/xAbPAOlY/h/mIEslzh5iyp165eTJPk1weMt51B2FEXPBTl6vY/uelOO
rioHoiCkCfrAMchbcu9wsuelfguWQFITCsI3j9tC44K1H/4NraV1InBxmOdNi3Mt
404azgfefcxRxHNFcWV42OUpySuYu+/Lz+GT0t8fkaL0Pqx02UYMbwHV1VZbZ1OL
3W8Mue9XjlEMH4QUXcnTnd/1e7zfiZ0oS4+4EnsXumDpyjx6gscF5zZQbovcmZV1
mXEUXtB8pLaIEWpJmLVgn7z1Wyqh2RpyzCYj9iJt4SMItEQnfLkMC/IrogLQ6N89
KZKNymCS9/z09wZr7bbzr3NgQhblvl4i8eQjyuWWq4R6MuDiMe6S0s54sYKCjyeh
8w1NUN05tJYiilIJWkCo
=uu/q
-----END PGP SIGNATURE-----

--4Ycl1UgPPPgGZoSL--

--===============7832758868041632335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7832758868041632335==--
