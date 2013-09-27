From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.12
Date: Fri, 27 Sep 2013 16:42:59 +0100
Message-ID: <20130927154258.GK19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8254439511000130634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 91730265099
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 17:43:03 +0200 (CEST)
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


--===============8254439511000130634==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ENS8W0Tt0j5TmTCM"
Content-Disposition: inline


--ENS8W0Tt0j5TmTCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.12-rc2

for you to fetch changes up to 267666ea3bd6e804c2c8bbafbe628026be963d06:

  Merge remote-tracking branch 'asoc/fix/max98095' into asoc-linus (2013-09-27 14:56:24 +0100)

----------------------------------------------------------------

ASoC: Fixes for v3.12

Nothing too exciting here, all driver specific except for the fix from
Liam for DPCM systems which have both front and back end DAIs which is
not yet used by anything in mainline.

----------------------------------------------------------------
Dan Carpenter (3):
      ASoC: max98095: a couple array underflows
      ASoC: ab8500-codec: info leak in anc_status_control_put()
      ASoC: 88pm860x: array overflow in snd_soc_put_volsw_2r_st()

Liam Girdwood (1):
      ASoC: core: Only add platform DAI widgets once.

Mark Brown (6):
      Merge remote-tracking branch 'asoc/fix/88pm860x' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/ab8500' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/bfin' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/fsl' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/max98095' into asoc-linus

Philipp Zabel (2):
      ASoC: imx-sgtl5000: do not use devres on a foreign device
      ASoC: imx-sgtl5000: Fix uninitialized pointer use in error path

Valentin Ilie (1):
      ASoC: blackfin: Add missing break statement to bf6xx

 sound/soc/blackfin/bf6xx-i2s.c    | 1 +
 sound/soc/codecs/88pm860x-codec.c | 3 +++
 sound/soc/codecs/ab8500-codec.c   | 7 ++++++-
 sound/soc/codecs/max98095.c       | 4 ++--
 sound/soc/fsl/imx-sgtl5000.c      | 7 +++++--
 sound/soc/soc-core.c              | 1 -
 6 files changed, 17 insertions(+), 6 deletions(-)

--ENS8W0Tt0j5TmTCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRad/AAoJELSic+t+oim9vOIQAIcutCho4nB1QZBTdTzxzLOb
w9CW05dbq6vLSWszEX6ABwDOQ2GdZ3w/+P3hwMiTtFZbNa5xYFro7XQhhWXWXGh/
hJj/tQEvQfLaCMOYjewvlAfCmqUbLi7VWPVVd51I2wrHRKSkVYAUSI31p91DOLhM
amYJ7BYvkqQNUQia1FvmQ8F3b72uEMWXPQLoUu2U2djYdgjBca/dnH9A5jn8dNUc
Bw3baoE2zCxbxwkNZovWb8YdM6ww3zJcLVw6ntP5k8Mo+kLR6Mc7iis1upgmMpnT
hoW7tQvkurnI1nii17arShArj9rpnMB+BHENLrpEAF4boGUf6YvSJj0hNZwulDiZ
zAmRa5/iMOuPL1ZSuYN3Y3qbJOVht2SmGfpx1lZZV9hNqUlCUKQHREDzgMzp1cb7
RdAw1HTKGoVUjGBX3oaRS74lIHG4L0AJ++1RntnQuXxuGbJYiLGdwwhhLg7NPXys
FAdeYUy8o7jMuVgVHYQ++keC28hAovGIEO3G+6pEevATanL3iVQcr6GYLk3WYw1R
9t1Ge1wfOl5gb+mQnmbBDgwSLHwVD59SMfi/IUePUNygcfF1o8s2Q5H05dqPopLY
rk+ywPbjteOKEM7A+0uXw7lwPc1t+T+ScZUNZ/Nnj6eL8I6WtHUdaVvYQ54DBGS1
+hJLoNt/xbFb0tt22pJK
=+keS
-----END PGP SIGNATURE-----

--ENS8W0Tt0j5TmTCM--

--===============8254439511000130634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8254439511000130634==--
