From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Fri, 15 Oct 2010 13:29:35 +0100
Message-ID: <20101015122935.GK14782@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59E32244FB
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 14:29:37 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 0f9141c974b2dc29b7d1cf245bbf4685350521be:

  ASoC: Pay attention to driver supplied DAI IDs (2010-10-13 11:02:43 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Guennadi Liakhovetski (1):
      fbdev: sh_mobile_hdmi: fix compilation without SOUND enabled

Joe Perches (1):
      ASoC: Remove unused vol field from WM8994 access mask table

Kuninori Morimoto (2):
      ASoC: fsi: simultaneous playback/recorde support
      ASoC: ak4642: make sure name of register/value

Mika Westerberg (3):
      ASoC: add ep93xx AC97 audio driver
      ARM: ep93xx: add AC97 platform support
      ASoC: ep93xx: add Simplemachines Sim.One AC97 audio support

Peter Hsiang (1):
      ASoC: Add max98088 CODEC driver

Seungwhan Youn (2):
      ASoC: SAMSUNG: Add S/PDIF CPU driver
      ASoC: SAMSUNG: Add Machine driver for S/PDIF PCM audio

Timur Tabi (1):
      powerpc/85xx: add DIU support to the Freecale P1022DS reference board

 arch/arm/mach-ep93xx/core.c                     |   34 +
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
 arch/arm/mach-ep93xx/simone.c                   |    1 +
 arch/powerpc/configs/mpc85xx_defconfig          |    3 +
 arch/powerpc/configs/mpc85xx_smp_defconfig      |    3 +
 arch/powerpc/platforms/85xx/p1022_ds.c          |  212 ++-
 drivers/video/Kconfig                           |    2 +
 sound/soc/codecs/Kconfig                        |    4 +
 sound/soc/codecs/Makefile                       |    2 +
 sound/soc/codecs/ak4642.c                       |   64 +-
 sound/soc/codecs/max98088.c                     | 2097 +++++++++++++++
 sound/soc/codecs/max98088.h                     |  193 ++
 sound/soc/codecs/wm8994.c                       | 3147 +++++++++++------------
 sound/soc/ep93xx/Kconfig                        |   16 +-
 sound/soc/ep93xx/Makefile                       |    4 +
 sound/soc/ep93xx/ep93xx-ac97.c                  |  468 ++++
 sound/soc/ep93xx/simone.c                       |   89 +
 sound/soc/s3c24xx/Kconfig                       |   11 +
 sound/soc/s3c24xx/Makefile                      |    4 +
 sound/soc/s3c24xx/smdk_spdif.c                  |  223 ++
 sound/soc/s3c24xx/spdif.c                       |  501 ++++
 sound/soc/s3c24xx/spdif.h                       |   19 +
 sound/soc/sh/fsi.c                              |  152 +-
 24 files changed, 5598 insertions(+), 1653 deletions(-)
 create mode 100644 sound/soc/codecs/max98088.c
 create mode 100644 sound/soc/codecs/max98088.h
 create mode 100644 sound/soc/ep93xx/ep93xx-ac97.c
 create mode 100644 sound/soc/ep93xx/simone.c
 create mode 100644 sound/soc/s3c24xx/smdk_spdif.c
 create mode 100644 sound/soc/s3c24xx/spdif.c
 create mode 100644 sound/soc/s3c24xx/spdif.h
