From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dapm: fix out-of-bounds accesses
 to DAPM lookup tables
Date: Mon, 4 Feb 2019 19:24:04 +0100
Message-ID: <20190204182404.GI23441@sirena.org.uk>
References: <20190204135914.7413-1-pierre-louis.bossart@linux.intel.com>
 <s5hr2cnppnj.wl-tiwai@suse.de>
 <a199f5cb-7e56-db27-37bc-78e3e7e5daee@linux.intel.com>
 <20190204161140.GG23441@sirena.org.uk>
 <9b852c6a-4fef-3b97-6bea-7a81500ed14e@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6494132607331876658=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C6DE267459
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 19:24:07 +0100 (CET)
In-Reply-To: <9b852c6a-4fef-3b97-6bea-7a81500ed14e@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6494132607331876658==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 10:20:10AM -0600, Pierre-Louis Bossart wrote:

> It's not hard indeed, I am just not hot on changing the values at the same
> time as adding new definitions. I managed to screw-up the mic values the
> first time, this would make the changes hard to check.

> Maybe do this in a second patch, along with the array size checks?

Sure.

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYg0QACgkQJNaLcl1U
h9DaZQf/fjjpyByq0/5eJ32K6ZDdT+mWjObBmuZHqOsMNRgh/SyYIHQpZr6bHng4
+hLws+Tpgn0wV6elPf7mBUlLjlFT5fRKUJ9hdzksZEVPdhy61lumtCQAQ00Rbl1+
R0TiY2C1w2phQJNGIuOSZk+4y0314ITcoeQMAmilQMxodWXUcIcFfrsi/KdfLXKd
vAubhP0F5upKJoFNnGQOCFA+lhWBnI4eSOTioBKsqa+CH5pJ5aLBGdlV1l7LwP7d
BuhIDV3MYiU/Gj9q1Djqqno2GtHPTm596pksmf9ht4ywF8sl4ONYjbcYYoCe8eA8
a7Qu8sv2F1n0Nvk8337kqjuS2bdrfw==
=ingA
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--

--===============6494132607331876658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6494132607331876658==--
