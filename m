From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Wed, 4 Nov 2015 14:29:58 +0000
Message-ID: <20151104142958.GG1717@sirena.org.uk>
References: <20151102153229.GP21326@localhost>
 <20151103112458.GO20228@sirena.org.uk>
 <20151103175708.GH12910@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3135077041150954153=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4D232606E8
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:30:10 +0100 (CET)
In-Reply-To: <20151103175708.GH12910@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3135077041150954153==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2015 at 11:27:08PM +0530, Vinod Koul wrote:
> On Tue, Nov 03, 2015 at 11:24:58AM +0000, Mark Brown wrote:

> > I'm having a hard time seeing the difference between this and what's
> > going on in sst-acpi.  They seem to be doing the same thing in slightly
> > different ways, they both match tables of CODEC IDs to machine driver
> > names with the distinction being that this doesn't provide a firmware
> > filename whereas sst-acpi does but the mechanics of mapping a CODEC to a
> > machine driver seem otherwise the same.

> I don't disagree with your observation, the code does same stuff and only
> difference is the data we require here, so commonizing becomes tricky

The only difference in data appears to be a firmware file name?

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOhZlAAoJECTWi3JdVIfQm0UH/1F/tJI0CvY1QGunYskfpky+
Ag7cMq/QYtqtRFYG0TBRk+KEdsjinCAOxjvn0jlD1BCk9AUlAFhLMqups5HOH0J5
bT9NnatZ3aniGe3sh2OLloI7jSFva76DKMTEbV1zXVpicjP3gpEYga3TjVoMS/3a
YthDRqvN5CeC93e7PpXMH9JyBVKuIsDOrYRezuxfoSUgVXeqUdxsguOfR/UzjMBI
QaRYMYAm+pVoEQUdbPjLYdDBRjvuCG8k58FBgbGJcPPmINqu5LgLrxf2jhnGXxR0
+1NklU4grH4m3/OkPvC/A3ALRZU1cTAvUPZEf+9y4f+kU1jFOMH66N+pWyIhSRA=
=ntVT
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--

--===============3135077041150954153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3135077041150954153==--
