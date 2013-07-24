From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.11
Date: Wed, 24 Jul 2013 10:38:22 +0100
Message-ID: <20130724093822.GX9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3613196138953681608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 03252265251
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 11:38:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@Gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3613196138953681608==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FcqbpLOAFGOf/VCz"
Content-Disposition: inline


--FcqbpLOAFGOf/VCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.11-rc2

for you to fetch changes up to c5ae4dca11523dff15cfb1763b64a71b805976aa:

  Merge remote-tracking branch 'asoc/fix/tegra' into asoc-linus (2013-07-23 19:17:11 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.11

A few small updates again, the sgtl5000 one fixes some newly triggered
issues due to some probe ordering changes which were introduced in the
last merge window.

----------------------------------------------------------------
Boris BREZILLON (1):
      ASoC: atmel-ssc: remove clk_disable_unprepare call from critical section

Chih-Chung Chang (1):
      ASoC: max98088 - fix element type of the register cache.

Dan Carpenter (1):
      ASoC: core: double free in snd_soc_add_platform()

H Hartley Sweeten (1):
      ASoC: ep93xx: fix build of ep93xx-ac97.c

Mark Brown (6):
      Merge remote-tracking branch 'asoc/fix/atmel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/ep93xx' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/max98088' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/sgtl5000' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/tegra' into asoc-linus

Richard Zhao (1):
      ASoC: tegra: correct playback_dma_data setup

Shawn Guo (1):
      ASoC: sgtl5000: defer the probe if clock is not found

 drivers/misc/atmel-ssc.c        | 11 ++++++++---
 sound/soc/cirrus/ep93xx-ac97.c  |  4 ++--
 sound/soc/codecs/max98088.c     |  2 +-
 sound/soc/codecs/sgtl5000.c     |  3 +++
 sound/soc/soc-core.c            |  4 +---
 sound/soc/tegra/tegra20_ac97.c  |  6 +++---
 sound/soc/tegra/tegra20_spdif.c |  4 ++--
 7 files changed, 20 insertions(+), 14 deletions(-)

--FcqbpLOAFGOf/VCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR76CLAAoJELSic+t+oim9ficP/j2fajU75f49YD6MjJ1TqCfI
MetjyCp/+HwuTiaB5n+siDI+7iZVQ+FwyyS5hjmchs1jQRc4gGi2Rkb0IyxbPvA+
HbwFlhgQr6cdjX1Ztgoj7PBVXkZCI09VtDdseE/TiVLnmHebhxGiad8I2xmU/m0U
I79EMNGTslnF48aD8yTiXLFqxiVKIS7yV2hR2mIF9l3Suvi4qNqITA4ny4QgGW0/
YMIHPLVuupUrKRqwo/r3ee1lqe6QN0uTzftf3q1nxBrjxHuOx5cAj9MSh4gWeocu
t39n3lUQXY6pKNiTg+Cy9mNsvh5Eew+erlcPLjcUVMHfRJamWWsPANDtGloM4FsR
YeVf1xodRcbPLCJHbJL4BkV55YCdttH38VtLbDGPg+JFR3c0glG9VtK1LJ2OUbBi
u1sJRKSkPHReB8d1HaLYzRr3zIfcKDYy83czDMnSGiMFxjLllnzh8MCCsyYpYWOT
AQXehCdkN5ClzcjrQ4DRPU0Z3IO1k93f9zZorNrFTyFa8mHZZHI/RyfkYkLSYFJd
rPEw+p6Ahg0uFOxBar3aTVkaw0/rOtFp1R0YbjI6SyyXfJgPZFkwseWVklfoKZVG
RkeGdrgRswz2qD2pSwS6vND2AQ5uPhL8JV8npUzWE26/a0udbzvuFNQGneTDAJ/B
CGuR++4oZv9B0WPs8Y98
=X6nm
-----END PGP SIGNATURE-----

--FcqbpLOAFGOf/VCz--

--===============3613196138953681608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3613196138953681608==--
