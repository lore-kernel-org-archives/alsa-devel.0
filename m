From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] ASoC: Intel: Skylake: Add pipe and
	modules handlers
Date: Sat, 15 Aug 2015 10:03:02 -0700
Message-ID: <20150815170302.GL10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-2-git-send-email-subhransu.s.prusty@intel.com>
 <20150814213031.GT10748@sirena.org.uk>
 <20150815125513.GC13546@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1052559328639269934=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FBA82654BD
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 19:03:37 +0200 (CEST)
In-Reply-To: <20150815125513.GC13546@localhost>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1052559328639269934==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dbdikjxO6Hyl7qA/"
Content-Disposition: inline


--dbdikjxO6Hyl7qA/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 06:25:13PM +0530, Vinod Koul wrote:
> On Fri, Aug 14, 2015 at 10:30:31PM +0100, Mark Brown wrote:

> > What are "mcps"?

> Million Clocks Per Second. This represents the compute requirement of a
> module, pipe and driver needs to track it so that we don't exceed available
> MCPS

So expand that acronym somewhere people can find  it...

--dbdikjxO6Hyl7qA/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz3DFAAoJECTWi3JdVIfQPL0H/2XeQquoCXC8r/u+nJLfZVW0
60syYJDBLGUt8oGfUvyVsGIb3gV8aOUc43tsZO5k4qmDy0UQXUJ2OHaA1NdSESsn
u5aTZ6V3RBHc/PYwqeMrjerzBN7RAfC4xFh3df+Xjv6RruhEeZVhPWhmeb90it3f
Js0lPzklSzYxYa2pOI2YPXQdAwYOfZc5YVGIFS40xFvPH7DBlASXLF8fXL2bvLWB
wleXWNKPHitUjMshf5v7u7JVf6NmS2csKmsMunrIDv3iQFqqtrpIKY74SaMRU9Tk
GSHkQ57kWsMai4AIvQaN8OhSe0rM6k9iZP8ZkJ1ogdf3lwB9s0Coj385byT0ky4=
=wiHj
-----END PGP SIGNATURE-----

--dbdikjxO6Hyl7qA/--

--===============1052559328639269934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1052559328639269934==--
