From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.4
Date: Wed, 6 Jan 2016 17:30:25 +0000
Message-ID: <20160106173025.GA6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8855982468787321547=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD174260417
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 18:30:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8855982468787321547==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fU5tsrXreH0/dVH0"
Content-Disposition: inline


--fU5tsrXreH0/dVH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 168309855a7d1e16db751e9c647119fe2d2dc878:

  Linux 4.4-rc8 (2016-01-03 15:15:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.4-rc8

for you to fetch changes up to bc42f363da213b4bf7c15a2dc87b2b1a85cde867:

  Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus (2016-01-05 23:07:33 +0000)

----------------------------------------------------------------
ASoC: Last minute fixes for v4.4

A few final fixes for v4.4, the main one being the two patches to the
new Sky Lake drivers which fix a previous incorrect fix that went in
during an earlier -rc.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: rt5645: add sys clk detection

Charles Keepax (1):
      ASoC: Use nested lock for snd_soc_dapm_mutex_lock

Mark Brown (4):
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus

Nikesh Oswal (1):
      ASoC: arizona: Fix bclk for sample rates that are multiple of 4kHz

Vinod Koul (2):
      ASoC: Intel: Skylake: Revert previous broken fix memory leak fix
      ASoC: Intel: Skylake: Fix the memory leak

 include/sound/soc.h                    | 2 +-
 sound/soc/codecs/arizona.c             | 2 +-
 sound/soc/codecs/rt5645.c              | 4 ++++
 sound/soc/codecs/rt5645.h              | 4 ++++
 sound/soc/intel/skylake/skl-topology.c | 3 ++-
 sound/soc/intel/skylake/skl.c          | 4 ++++
 sound/soc/intel/skylake/skl.h          | 2 ++
 7 files changed, 18 insertions(+), 3 deletions(-)

--fU5tsrXreH0/dVH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjU8wAAoJECTWi3JdVIfQ7PIH/jw8QuofBkFpFqyXhVh7HQaH
oNLvH/rbhMh8aqbFwpe613yr8GDEWReOJ0YaZeI3tF2E26Vx+NulunFYB8Wnw2K7
7keeBBTkbNZoLh4WiK6NW9MOZDs8mav+QHBx80JUAgD1cZoq2Up5cEi1tpkT1L9a
OuzOz8jyk6si9Le63a5LuQsszehjQr7dGqCnP+qWBsH/iUVEgfNlgZVw/rqMQwRe
kz8d88QsmaUpSzPcXiVkpxweFuMpyJ71bH0292A1QLCVgkmWqATvEk07XaQtWiHi
sGrhlc3UpwPQ8iPiSceqtqHwrooDe372giM+wZvAr/jNtGaeNyb7H6KKM2cE8dI=
=+bfl
-----END PGP SIGNATURE-----

--fU5tsrXreH0/dVH0--

--===============8855982468787321547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8855982468787321547==--
