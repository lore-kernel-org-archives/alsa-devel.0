From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/17] ASoC: Intel: Skylake: More fixes and
	updates
Date: Fri, 30 Oct 2015 09:50:25 +0900
Message-ID: <20151030005025.GM28319@sirena.org.uk>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
 <20151029033434.GA31066@vkoul-mobl.iind.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8038700932718176915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5071265917
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 01:50:32 +0100 (CET)
In-Reply-To: <20151029033434.GA31066@vkoul-mobl.iind.intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8038700932718176915==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1whYXOlSGJlk+LY"
Content-Disposition: inline


--k1whYXOlSGJlk+LY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2015 at 12:34:37PM +0900, Vinod Koul wrote:

> Jeeja found two more fixes for this so I have appended these to the last
> patch. First fixes bit format on SSP port and second fixes the missing
> machine entry required as BIOS doesn't have that

> They seem to appear in this thread so easy to find :)

Please don't send new patches as followups to something in the middle of
a series, it creates confusion trying to understand what the current
version of the series is intended to be.  Please resend whatever you
want applying as a separate series.

--k1whYXOlSGJlk+LY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMr7QAAoJECTWi3JdVIfQQwkH+gKAlobUFpVd0V5NwAFEVYcO
OfLQczoPU4oTF9DDhdLgi3wa7Pwpmv1VmwftqMBhKMgAIAK/Ww5n/Kq0BfVBYZ3U
JwGyasKJxVnFxZE6CPc+Td8GwsFBIAC0mR/10+eoyKkwExNB8IN5AzkX4k8dFtV/
7n118RDhWYyHgn3gdHiB+89IF1TJmkXHq2faI4ZaLcjOs7mUu8fTwrvyTR4d/DqI
Yey63Cmr9IKhFfruYQmYR6mAdx5yrpGosT0VEnP82XNG/gXX42+Km/XSQ6JNx+oz
PxX9BH8utKTnhblLF7dCMOM1eeuqylDhG4ISA8iCSxk7GNqDRpV5SaE8FEqGvLw=
=pT8F
-----END PGP SIGNATURE-----

--k1whYXOlSGJlk+LY--

--===============8038700932718176915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8038700932718176915==--
