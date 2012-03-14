From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.4
Date: Wed, 14 Mar 2012 14:07:14 +0000
Message-ID: <20120314140713.GM3133@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5406229850700579130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E5A5103AE6
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 15:07:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5406229850700579130==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F7w+4yMapWozG0Ib"
Content-Disposition: inline


--F7w+4yMapWozG0Ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 303076342b8a30aa98f8a53b539155d0b81ff0c3:

  Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into topic/asoc (2012-03-06 14:04:16 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.4

for you to fetch changes up to 5ec65ee589fdaca7298b6303fd74ad6c121a8f38:

  ASoC: mx27vis-aic32x4: Convert it to platform driver (2012-03-13 23:09:59 +0000)

----------------------------------------------------------------
Linus decided to go for another week so here's a few more updates - a
mixed bag here, a few minor diagnostic tweaks, some driver enhancements
and the dmaengine conversion for ep93xx drivers which was tested a while
ago and just waiting for a signoff.
----------------------------------------------------------------

Ashish Chavan (2):
      ASoC: da7210: Update for using I2C regmap
      ASoC: da7210: Remove extra registers from defaults list

Fabio Estevam (2):
      ASoC: imx: imx-audmux: Fix section mismatch
      ASoC: mx27vis-aic32x4: Convert it to platform driver

Lars-Peter Clausen (1):
      ASoC: ep93xx-pcm: Use dmaengine PCM helper functions

Liam Girdwood (3):
      ASoC: dapm: Use dev_warn for debugfs warning message
      ASoC: core: Add platform component mutex
      ASoC: DAPM: Make sure DAPM widget IO ops hold the component mutex

Mark Brown (5):
      ASoC: dapm: Only lock CODEC for I/O if not using regmap
      ASoC: wm8996: Remove some volatile regisers from the defaults table
      ASoC: wm8996: Remove separate output stage enable step
      ASoC: Revert widget I/O locking for 3.4
      ASoC: wm8994: Prevent ABBA deadlock with CODEC and accdet mutexes

Mika Westerberg (1):
      ASoC: dmaengine_pcm: Reset pointer position when starting a stream

Qiao Zhou (1):
      ASoC: add more sample rate for pxa-ssp

Shawn Guo (2):
      ASoC: core: missing set_fmt should not be complaint
      ASoC: fsl: check property 'compatible' for the machine name

Stephen Warren (1):
      ASoC: tegra: Remove unused variable

 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    1 +
 include/sound/soc.h                         |    1 +
 sound/soc/codecs/da7210.c                   |  146 +++++++++++++++++++-------
 sound/soc/codecs/wm8994.c                   |   69 ++++++-------
 sound/soc/codecs/wm8996.c                   |   34 ++----
 sound/soc/ep93xx/Kconfig                    |    1 +
 sound/soc/ep93xx/ep93xx-pcm.c               |  148 ++++-----------------------
 sound/soc/fsl/fsl_ssi.c                     |    6 +-
 sound/soc/fsl/mpc8610_hpcd.c                |    2 +-
 sound/soc/fsl/p1022_ds.c                    |   32 +-----
 sound/soc/imx/imx-audmux.c                  |    8 +-
 sound/soc/imx/mx27vis-aic32x4.c             |   41 ++++----
 sound/soc/pxa/pxa-ssp.c                     |    3 +-
 sound/soc/soc-core.c                        |   12 ++-
 sound/soc/soc-dapm.c                        |    2 +-
 sound/soc/soc-dmaengine-pcm.c               |    1 +
 sound/soc/tegra/tegra_alc5632.c             |    1 -
 17 files changed, 225 insertions(+), 283 deletions(-)

--F7w+4yMapWozG0Ib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYKYLAAoJEBus8iNuMP3dJVkP/04hLylrWFI9MgRZ4I9Fp7wb
2/EBot8tYpsoXxpNyOSOf8506pdNMX2AVbD6FBYxBzi/LydkUlb85KW7dIPe9v42
qesrcMtRI5NC2T5U9dZXn3E1jZNA49tvfCcb1Mdwe8do8ct7j+BIBTLcvHSDVr93
YfT7Y/DaxPbqU369hjpbiKL6EUynoP1CTnzM7bQs7z2YaMmNzrGX+gWrv1N0Brvh
0oF/TY631wGTG1AGmDoLGifi5chsk0VoqdVZE6jiCdmwEP18fg8CgE1M0dItsv5O
PimsLjFeUBK4wsBOYJH0jHrctICT0y8MSxCMdyTU4R7Y5a1nYmwq/p6bsuolNJPR
1pfiw1a8ST6lKtoHUcOkbRRjaKDuppyS3qkGLO9MM1iqjpr20i4l1+sqw1J49mBY
JCmvrJ3yhGUjvSXC+xi9/UkTF7JkJJOpXHd2ik0Wl5DRH6FlyKPMBQf1YV5MgFNf
GeBsMjA5R0BL1jw4BRbmWXjeCrEuRJ2wyshAd7hFBYBaHJDAxn2qwL3WXMNK+pke
Bid1CuNKAGD0lYqYVJ2jj9EkRXkOsPhAeoS4izJDUvn0lFdaKN4enCnJv/ME94eG
9CvyHk8H4Lpvp2xcUGdnCZSWUZgOYnyimg8i15+j8J1q/as8S4YxIcmF3mI25Jxl
8pgii9DUZdF0nIHM5TSw
=BweP
-----END PGP SIGNATURE-----

--F7w+4yMapWozG0Ib--

--===============5406229850700579130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5406229850700579130==--
