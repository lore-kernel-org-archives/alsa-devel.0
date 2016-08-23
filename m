From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/13] ASoC: topology: Able to create BE
	DAIs
Date: Tue, 23 Aug 2016 18:33:54 +0100
Message-ID: <20160823173354.GZ22076@sirena.org.uk>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <390c016a47953561511f529467a1985b77cfd043.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2656211193689335743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FE1E2670E3
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 19:34:07 +0200 (CEST)
In-Reply-To: <390c016a47953561511f529467a1985b77cfd043.1471599648.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2656211193689335743==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wn0J+vu9+NMIXK57"
Content-Disposition: inline


--Wn0J+vu9+NMIXK57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2016 at 06:12:35PM +0800, mengdong.lin@linux.intel.com wrote:

> Topology will check with ASoC if a BE DAI already exists by checking
> its name. If the BE DAI doesn't exist, topology will create a new one
> and the dai_load ops will be called for device specific init.

This doesn't explain in what situation we'd want to dynamically create a
back end, or why we're representing DPCM so directly in the topology -
we really need more words about what the use case is and why this makes
sense.  The expectation would be that back ends refer to physical
objects that exist in the system so it's not clear why we'd be loading
them from topologies (and that even where this makes sense there
wouldn't be any misuse by other users).  This is a bit of a theme here,
the series is adding a bunch of stuff but not explaining why.

--Wn0J+vu9+NMIXK57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvIkBAAoJECTWi3JdVIfQhR4H/1VaA/oKCxsY2EUACqK05rra
7RBIeXSUE+TUCtq7K62z8ikQT5R2DJJqMR+SY529IRpFiJr0WynOSArMm1ZUz61o
ZFbHkO9h9Ge+HYk5GDmHM9GrpmOFHwTLUjGnXMscREdws6p3SlTZLq4+JgOx+rCU
SCw+zFQ4RMovLnDiWFRyJitYIg1Jjj2TDtGSQhnLL4skpGiU7NfcVo4cHiJJqvq+
wjVlPYX0eIyHtIELR4xPrm8M0XFpbBZKAnIAOWB6ei3QUlQPpRwNNImIo0L6bx6Y
pBXh+mcEExNBFWAvteSTDeuxJNTLEX1dax7M7QYkJ/GCiFOfBBl9+nsFWoj+2Gg=
=whRH
-----END PGP SIGNATURE-----

--Wn0J+vu9+NMIXK57--

--===============2656211193689335743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2656211193689335743==--
