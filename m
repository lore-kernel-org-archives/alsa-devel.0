From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Fri, 30 Oct 2009 10:49:12 +0000
Message-ID: <20091030104912.GC5345@rakim.wolfsonmicro.main>
References: <20091030104720.GB5345@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C7E6244DC
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 11:49:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091030104720.GB5345@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 3da8e6885ec2dea67321c904d721be90e00cd748:
  Mark Brown (1):
        Merge branch 'for-2.6.32' into for-2.6.33

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

This is a random collection of different updates, the largest set being
Peter's twl4030 work.

Anuj Aggarwal (3):
      ASoC: OMAP3EVM: Use the twl4030_setup_data for headset pop-removal
      ASoC: Adding OMAP3517 / AM3517 EVM support in ASOC
      ASoC: Modifying Kconfig/Makefile for AM3517 EVM

Barry Song (1):
      ASoC: Fix possible codec_dai->ops NULL pointer problems

Daniel Mack (1):
      ASoC: CS4270: export de-emphasis filter as ALSA control

Janusz Krzysztofik (3):
      ASoC: Amstrad Delta minor cleanups
      ASoC: OMAP: Don't try to set unsupported OMAP_DMA_DATA_BURST_16 on OMAP1
      ASoC: Amstrad Delta: add info about the line discipline requirement to Kconfig help text

Jari Vanhala (1):
      ASoC: TWL4030: Vibra motor stop fix when it is driven with audio

Julia Lawall (1):
      ASoC: Move dereference after NULL test

Kuninori Morimoto (2):
      ASoC: sh: FSI: Remove DMA support
      ASoC: sh: FSI: Add capture support

Manuel Lauss (2):
      ASoC: au1x: psc-ac97: verify correct codec register was read
      ASoC: au1x: psc-ac97: reorganize timeouts

Mark Brown (4):
      Merge branch 'for-2.6.32' into for-2.6.33
      ASoC: Add regulator support for WM8731
      ASoC: Minor SMDK64xx WM8580 cleanups
      Merge branch 'for-2.6.32' into for-2.6.33

Peter Ujfalusi (10):
      ASoC: TWL4030: Only update the needed bits in *set_dai_sysclk
      ASoC: tlv320dac33: typo fix in the header
      MFD: twl4030: add twl4030_codec MFD as a new child to the core
      OMAP: Platform support for twl4030_codec MFD
      ASoC: TWL4030: use the twl4030-codec.h for register descriptions
      ASoC: TWL4030: Driver registration via twl4030_codec MFD
      ASoC: TWL4030: Remove bypass tracking
      ASoC: TWL4030: Change codec_muted to apll_enabled
      ASoC: TWL4030: Change APLL powering sequence
      ASoC: TWL4030: Add APLL supply for the capture path

 arch/arm/mach-omap2/board-3430sdp.c      |    9 +
 arch/arm/mach-omap2/board-omap3beagle.c  |    9 +
 arch/arm/mach-omap2/board-omap3evm.c     |    9 +
 arch/arm/mach-omap2/board-omap3pandora.c |    9 +
 arch/arm/mach-omap2/board-overo.c        |    9 +
 arch/arm/mach-omap2/board-zoom2.c        |    9 +
 drivers/mfd/Kconfig                      |    6 +
 drivers/mfd/Makefile                     |    1 +
 drivers/mfd/twl4030-codec.c              |  241 ++++++++++++++++++
 drivers/mfd/twl4030-core.c               |   14 +
 include/linux/i2c/twl4030.h              |   18 ++
 include/linux/mfd/twl4030-codec.h        |  271 ++++++++++++++++++++
 sound/soc/au1x/psc-ac97.c                |   49 +++--
 sound/soc/codecs/Kconfig                 |    1 +
 sound/soc/codecs/cs4270.c                |    1 +
 sound/soc/codecs/tlv320dac33.h           |    2 +-
 sound/soc/codecs/twl4030.c               |  404 ++++++++++++++++--------------
 sound/soc/codecs/twl4030.h               |  242 +-----------------
 sound/soc/codecs/wm8731.c                |   51 ++++-
 sound/soc/omap/Kconfig                   |   22 ++-
 sound/soc/omap/Makefile                  |    2 +
 sound/soc/omap/am3517evm.c               |  202 +++++++++++++++
 sound/soc/omap/ams-delta.c               |    4 +-
 sound/soc/omap/omap-pcm.c                |    8 +-
 sound/soc/omap/omap3evm.c                |    7 +
 sound/soc/s3c24xx/smdk64xx_wm8580.c      |   15 +-
 sound/soc/sh/Kconfig                     |    1 -
 sound/soc/sh/fsi.c                       |  234 ++++++++----------
 sound/soc/soc-core.c                     |   11 +-
 sound/soc/soc-jack.c                     |    3 +-
 30 files changed, 1266 insertions(+), 598 deletions(-)
 create mode 100644 drivers/mfd/twl4030-codec.c
 create mode 100644 include/linux/mfd/twl4030-codec.h
 create mode 100644 sound/soc/omap/am3517evm.c
