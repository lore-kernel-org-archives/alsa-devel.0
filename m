From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: PCM: check if ops are defined before
 suspending PCM
Date: Tue, 12 Feb 2019 16:20:14 +0000
Message-ID: <20190212162014.GG20635@sirena.org.uk>
References: <20190208232953.7266-1-pierre-louis.bossart@linux.intel.com>
 <s5hwom971m9.wl-tiwai@suse.de>
 <339832c2-0072-34c7-3a11-29999969662b@linux.intel.com>
 <s5hlg2m5n0d.wl-tiwai@suse.de>
 <b19ec392-4385-a2b6-9809-1ed7267db2ec@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4292082248205784908=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D1E252673E2
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 17:20:22 +0100 (CET)
In-Reply-To: <b19ec392-4385-a2b6-9809-1ed7267db2ec@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4292082248205784908==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 11, 2019 at 10:59:49AM -0600, Pierre-Louis Bossart wrote:

> Can't disagree, we were surprised to hit this issue knowing that the SOF
> code isn't the first to use DPCM at all (same with some topology issues).
> It's very likely that there are specific initialization flows that aren't
> quite right, hopefully we'll fix them one after the other :-)

I'm fairly sure that DPCM has only been tested in very restricted use
cases, and then mostly at the system level rather than directly.
Obviously long term the component refactoring and digital domains should
improve matters here but that's going to take a while :(

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxi8j4ACgkQJNaLcl1U
h9BSkQf9FeUpKzpDthggRnGxwE1fjSQFEux4jCVvURkpplU7MOXLfGdhUpXdv5uo
7h7VwW08hCopT5q/BVjn1zvLCsopcbPOSbyOXH+zJWXnvHYTR/RAXhzZ9P1LaAPF
2s1uOSL3jLq+YfljAtB7b6mCqnkrA6EN7KAztzDx84fhfXGlLme9YIkS7vG2Wz75
SA/bCWrvgL2AKcWVO6yz2IeR5kHk+icG5whmD8T1EVCaerPqLI5m9at/IJgDCzI+
KZFygYWhpETO+Z5W7tldOxdFJPPGd62UPnuopnTUZ6VpI6szgXYvaXR6tPSg302H
CbMBE1f3BmZH7jPceXKgTl5DwMIRYA==
=/nIW
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--

--===============4292082248205784908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4292082248205784908==--
