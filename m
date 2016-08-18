From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/17] Baytrail audio fixes
Date: Thu, 18 Aug 2016 10:29:29 +0100
Message-ID: <20160818092929.GM9347@sirena.org.uk>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <928a31f5-d032-c06c-f59d-04d0d7ef1220@linux.intel.com>
 <20160817105032.GJ9347@sirena.org.uk>
 <5a448c3a-3f72-f753-e92f-43442c48f3e7@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7549745517505051625=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CADA7265A2A
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 11:29:41 +0200 (CEST)
In-Reply-To: <5a448c3a-3f72-f753-e92f-43442c48f3e7@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7549745517505051625==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/k2pzXB1sdSS/P9"
Content-Disposition: inline


--W/k2pzXB1sdSS/P9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2016 at 01:26:02PM -0500, Pierre-Louis Bossart wrote:
> On 8/17/16 5:50 AM, Mark Brown wrote:

> > You need to at least send clock API patches to the clock maintainers,
> > since there's no build time dependency the normal thing would be that
> > things will go through the clock tree.

> so would you rebase your tree on the clock tree then? the longer this takes
> the more reports we'll get of broken audio in for-next due to this missing
> MCLK support.

No, if there's any need to do a merge we'll do a merge.  Does this
actively break existing boards?

--W/k2pzXB1sdSS/P9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtX/3AAoJECTWi3JdVIfQ1ugH/3iR8h9UlTxa1ptx3HLvZyEg
BLWBQLBMKOywvk//G2lHpNQE0fDqyLfemznVypXVmtAxByJtb849sYAfuddywXY/
uMtgu2GbfKSKWZhmqXshalprC1MIio3r+fm5s1C8QMwsQU41KkApacmvtxOOEjD3
sAr0uSCLEhbq4uKKMZ4v6Rhyu7EwxYpyXmIBC6QSYBirPdUNjybZDORkSZ4QVFvJ
zsEhvrLlNc1DDRsqla5AWVuJ3vh56/ay4KgPV6Teg6nzhtIkIbhSftSnZ8agw/e6
4wsZbPRfd92ssHyafwJ7uQ4TKKN8F3wjoPG7uAn5K7knfFinBMf5x1Qi74Mvgys=
=B0sR
-----END PGP SIGNATURE-----

--W/k2pzXB1sdSS/P9--

--===============7549745517505051625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7549745517505051625==--
