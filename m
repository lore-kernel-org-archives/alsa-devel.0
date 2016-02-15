From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] ASoC: topology: Add support for FE
	DAI & DAI links
Date: Mon, 15 Feb 2016 18:26:09 +0000
Message-ID: <20160215182609.GW18988@sirena.org.uk>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0077394374560223857=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 604F62606D1
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 19:26:19 +0100 (CET)
In-Reply-To: <cover.1452844210.git.mengdong.lin@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0077394374560223857==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WjpOG6URjntW8FAF"
Content-Disposition: inline


--WjpOG6URjntW8FAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 15, 2016 at 04:11:49PM +0800, mengdong.lin@linux.intel.com wrote:

> This series allows topology to create FE DAI and DAI links from the PCM
> topology objects defined by the user space.

Of course that'll be kind of fun at the minute since we don't currently
have a userspace ABI for topologies...  8c90503bf246beb (ASoC: topology:
Disable use from userspace) is *still* in place since v4.2 with no move
to actually finalize the ABI.

--WjpOG6URjntW8FAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwhhAAAoJECTWi3JdVIfQBLMH/ijSLY1Dk2GsiXv1Th5MvodS
tNAckUNWahNBsdzF8jSlN8UlEMxAKprhQ7W2n+A0Sff84U/RdGE9S+ByNgSdchNS
doVORF4uGZr3JMO/IgEpYrmQGkbULnRW/JayCDfRBwE7EQrLAUCdId7Mx57i1xYU
HTMv4UK6hmum6lHUiuIhP3AsbwNXF9/tZfg43Flkm5v5hsOp4OVMUAv+xx5Befrp
BvDlEKkPBnixks8cJQBGCBxLGLdi0bvQPp9Hx+hwuJV7neXMGhRDTWo4o78dgWI8
pW4fcG5YxHJJVKz9gQYkDsA1O3aGyIkG3dhz4eoAH/X1KD/wCR0j/Ehp6FDVH0A=
=0CCV
-----END PGP SIGNATURE-----

--WjpOG6URjntW8FAF--

--===============0077394374560223857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0077394374560223857==--
