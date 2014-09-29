From: Mark Brown <broonie@sirena.org.uk>
Subject: [GIT PULL] ASoC fixes for v3.17
Date: Mon, 29 Sep 2014 18:15:51 +0100
Message-ID: <20140929171551.GY16977@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6270225454698024700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E84B6260645
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 19:16:07 +0200 (CEST)
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


--===============6270225454698024700==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tAdHiH28s3ybHVSb"
Content-Disposition: inline


--tAdHiH28s3ybHVSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0f33be009b89d2268e94194dc4fd01a7851b6d51:

  Linux 3.17-rc6 (2014-09-21 15:43:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.17-rc6

for you to fetch changes up to 82b925c405444b760e743b55a9ad498cb3551afe:

  Merge remote-tracking branches 'asoc/fix/atmel', 'asoc/fix/compress', 'asoc/fix/core', 'asoc/fix/fsl-ssi' and 'asoc/fix/rt286' into asoc-linus (2014-09-28 12:25:12 +0100)

----------------------------------------------------------------
ASoC: Fixes for v3.17

A few small driver specific fixes and a couple of error handling fixes
in the core.

----------------------------------------------------------------
Bard Liao (2):
      ASoC: rt286: Correct default value
      ASoC: rt286: Fix sync function

Bo Shen (1):
      MAINTAINERS: add atmel audio alsa driver maintainer entry

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/atmel', 'asoc/fix/compress', 'asoc/fix/core', 'asoc/fix/fsl-ssi' and 'asoc/fix/rt286' into asoc-linus

Michael Trimarchi (1):
      ASoC: fsl_ssi: fix kernel panic in probe function

Qiao Zhou (1):
      ASoC: soc-compress: fix double unlock of fe card mutex

Xiubo Li (1):
      ASoC: core: fix possible ZERO_SIZE_PTR pointer dereferencing error.

 MAINTAINERS              |  6 ++++++
 sound/soc/codecs/rt286.c |  7 +++----
 sound/soc/fsl/fsl_ssi.c  | 12 +++++++-----
 sound/soc/soc-compress.c |  6 ++----
 sound/soc/soc-core.c     |  2 +-
 5 files changed, 19 insertions(+), 14 deletions(-)

--tAdHiH28s3ybHVSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKZPHAAoJECTWi3JdVIfQsycH/1QvhaO1oORFN2xisUtGNs0f
st2njZ5wS8g081hZl35u1dPAc0Eiyd6QtBWjM8ev6hWopB+qxio8SWqM8GYKmpw5
lKZUDjuWCRPsaRuTAptoNUk5W4olWNLxbw7PN5C2l8q2QnVl5pFsFEHhOSfCddck
OezSzqOhLpASayzH1P/n108FEEslKZcn4yRkgkwFeDO6N8B8L8h4UThO1viBHzds
779w5yQPynlN5i8MnusQiFbn7UJXoowjAABTQwMtd8LvqHbub+0jbC7AykXSmVTP
1EU4Tzc/kzeKgWePMv4OcA8qG8CJrTv2qqQ1RG1EIt+leQW6XsqQHQjv9qXUxJA=
=X/Vl
-----END PGP SIGNATURE-----

--tAdHiH28s3ybHVSb--

--===============6270225454698024700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6270225454698024700==--
