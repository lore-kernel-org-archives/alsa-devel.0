From: Mark Brown <broonie@kernel.org>
Subject: Re: alsa-lib support for compress offload
Date: Fri, 16 Jan 2015 18:46:12 +0000
Message-ID: <20150116184612.GI3856@sirena.org.uk>
References: <54B8DF7A.6000700@imgtec.com> <s5hbnlzt3o2.wl-tiwai@suse.de>
 <54B8F485.7090603@imgtec.com> <54B9413F.805@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1263783394667487252=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B32260427
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 19:46:26 +0100 (CET)
In-Reply-To: <54B9413F.805@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--===============1263783394667487252==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UthUFkbMtH2ceUK2"
Content-Disposition: inline


--UthUFkbMtH2ceUK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2015 at 10:50:07AM -0600, Pierre-Louis Bossart wrote:

> Since there is no allowed processing/reformatting/reshuffling of compressed
> data, all the plugin system needs to be bypassed and you'd be looking at an
> alsa-lib API that interfaces directly with the ioctls, essentially
> replicating what tinycompress does. I agree it's not great to have
> independent packages, the decision to maintain tinycompress separately was
> driven by licensing concerns, not technical ones.

Well, it'd be nice to be able to support plugins for userspace output
devices like networked audio sinks or for talking to an audio server to
at least allow it to manage resource contention, or for providing soft
decode for that matter.  Currently the media frameworks do the job just
fine so it's not really a big deal though.

--UthUFkbMtH2ceUK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUuVxzAAoJECTWi3JdVIfQDOEH/0kyMa+CnJ4p9GRU+0ofYZLS
fCnPjnk2/SemsCdWyhj8Orh8yUa7EwNK7YwanA+4iSnN4Lc2f0j5ii/oz6FlYUQX
kH2nF9tR/mWI38Qt1SEKDJQ82OJOkEAfCZQzTxEo0rjpf6dCa6iCOHeNbzJmGumJ
/VuNcVMP3RVaexh180vJT7e8AZxl5yRMbVzmFgdOLhqAxEC01Dfp0Fv8v56wxxFy
nE+IgEURw25XpogBvUodOFc4OXgrHPliHzpdtKy4Y1RYP+rWYszlNnvd/HvKe0Ve
g/iirR4H2e7MPkdD+iyLcUNGi7vJgz39NNXGSZIQxqkT6bdvf7FF5vDUwiuSBHM=
=u9Ls
-----END PGP SIGNATURE-----

--UthUFkbMtH2ceUK2--

--===============1263783394667487252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1263783394667487252==--
