From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.7
Date: Wed, 17 Oct 2012 20:27:35 +0900
Message-ID: <20121017112733.GL14199@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1725509230254437083=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72BFA2651C5
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 13:37:02 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1725509230254437083==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9911f7f7562a25381eff93fdc660a4a3b4c0f6e0:

  ASoC: codecs: Add DA9055 codec driver (2012-09-28 14:21:54 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.7

for you to fetch changes up to 9233ef6b559faa3db14144f41dea2e70d1ad0092:

  ASoC: bells: Correct typo in sub speaker DAI name for WM5110 (2012-10-17 19:01:38 +0900)

----------------------------------------------------------------
ASoC: Fixes for v3.7

Nothing too exciting except for the ams-delta change which is relatively
lerge due to the fact that the driver loading had been totally broken as
the driver needed a newer API to function.

----------------------------------------------------------------
Ashish Chavan (1):
      ASoC: codecs: da9055: Minor improvement in ALC calibration process

Chris Ball (1):
      ARM: pxa: Fix build error caused by sram.h rename

Guennadi Liakhovetski (1):
      ASoC: fsi: don't reschedule DMA from an atomic context

Janusz Krzysztofik (1):
      ASoC: ams-delta: Convert to use snd_soc_register_card()

Mark Brown (5):
      Merge branches 'asoc-twl6040' and 'asoc-omap' into for-3.7
      ASoC: bells: Correct typo in sub speaker DAI name for WM5110
      ASoC: wm2200: Use rev A register patches on rev B
      ASoC: wm2200: Fix non-inverted OUT2 mute control
      ASoC: bells: Correct typo in sub speaker DAI name for WM5110

Peter Meerwald (1):
      ASoC: fix documentation in soc-jack

Peter Ujfalusi (4):
      ASoC: twl6040: Fix Stream DAPM mapping
      ASoC: omap-abe-twl6040: Fix typo of Vibrator
      ASoC: omap-mcpdm: Remove OMAP revision check
      ASoC: dmaengine: Correct Makefile when sound is built as module

Tony Lindgren (1):
      ASoC: Fix wrong include for McPDM

 arch/arm/mach-omap1/board-ams-delta.c |   12 +++++++
 sound/soc/Makefile                    |    5 +--
 sound/soc/codecs/da9055.c             |   22 +++++++++++-
 sound/soc/codecs/twl6040.c            |    8 ++---
 sound/soc/codecs/wm2200.c             |    3 +-
 sound/soc/omap/ams-delta.c            |   63 ++++++++++++++++-----------------
 sound/soc/omap/omap-abe-twl6040.c     |    2 +-
 sound/soc/omap/omap-mcpdm.c           |    9 ++---
 sound/soc/pxa/mmp-pcm.c               |    2 +-
 sound/soc/samsung/bells.c             |    4 +--
 sound/soc/sh/fsi.c                    |   15 ++++----
 sound/soc/soc-jack.c                  |    7 ++--
 12 files changed, 90 insertions(+), 62 deletions(-)

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfpWkAAoJELSic+t+oim9GB8P/10KFuNZKBFCAyiKOgGEKyHt
6J0AESMCJ4Q2sLEk1G7a/jiEmL3TfHxsQ7E0p97fmwFchIe32i8hJCWRcuWN+Ssx
kiAypKwzy0065+raRoSh7IsQOzXSO/yXHxmalU88uT4cq0Mu4XQv5+gEPLgnqqwe
BAw/zg+oD10L00knTQ5b76X4Fwv4MX27L+x/heXS8yk7ncHSrT0DQP0LhPp5sGFU
UH1hAuHJKM5b8QYdNZhAQesQgd77FEZpzS4Otut8pmFZSugX5/S0wdUta/EFUkIB
iYyBMZCxOQR+D/GE9ZWiU8Dk3lyNqDaBK6dVCUlgHkxLl9pXrXHdptdVaXvNjqoN
YZ89hVRCtozEQNZViwacow3ApMoT8Ls0TmWPdsE4EXu2ipVNd7nN0zd3Lnc1m1hm
vQFy24Ub4T+AFCuLorqIYuuk6YOOOAwakLFn6U3cy/f6qrMwKvU4ts+spJ5/KAmq
1kdIqTx3cM0on0aN49Xd9kFHUUckdeFEKcXbFZxRFPOhw4BcUnvjhgW1zoMPZXyn
kQK/ZeCYHI5oNdDQce1cdTrifI1+OJBnfYuhB7wkC3FxczWz8JMNWR0uPRZoAYsN
5G0PeHa7uwIuDtY0YE3EK4TW/neDl8t6CNNs96x1A4mEX5m0S0WtUxs4m7OQK7GP
vGPYQn1/gLUxOV1MaZEM
=4xz9
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--

--===============1725509230254437083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1725509230254437083==--
