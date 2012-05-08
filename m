From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 00/11] Fourth edition of Ux500 ASoC-driver
Date: Tue, 8 May 2012 15:56:18 +0200
Message-ID: <1336485378-27040-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog120.obsmtp.com (eu1sys200aog120.obsmtp.com
	[207.126.144.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 4523624471
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:56:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

This is the fourth (and hopefully last {-: ) compilation of patches
for the ST-Ericsson Ux500 ASoC-driver.
Since patch-set three there has been the following changes:
*) Introduction of a clock supply-widget in the core
*) Usage of regulator supply-widget
*) Usage of clock supply-widget
*) Board-specific settings moved to arch/arm/mach-ux500/
*) Bug-fixes for bidirectional audio
*) More usage of ASoC-core functions
*) Refactoring to get rid of non-ASoC functions
etc...

Kristoffer KARLSSON (2):
  ASoC: core: Add signed multi register control
  ASoC: core: Add strobe control

Ola Lilja (9):
  sound: core: Add debug-print helper function
  ASoC: core: Add method snd_soc_dapm_get_regulator_status
  ASoC: core: Add widget SND_SOC_DAPM_CLOCK_SUPPLY
  arm: ux500: Add support for MSP I2S-devices
  arm: ux500: Add audio-related platform-data
  ASoC: Ux500: Add MSP I2S-driver
  ASoC: Ux500: Add platform-driver
  ASoC: codecs: Add AB8500 codec-driver
  ASoC: Ux500: Add machine-driver

 arch/arm/mach-ux500/Makefile                       |    4 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |   58 +
 arch/arm/mach-ux500/board-mop500-msp.c             |  222 ++
 arch/arm/mach-ux500/board-mop500-msp.h             |   14 +
 arch/arm/mach-ux500/board-mop500.c                 |    7 +
 arch/arm/mach-ux500/board-mop500.h                 |    2 +
 arch/arm/mach-ux500/clock.c                        |    8 +-
 arch/arm/mach-ux500/devices-db8500.h               |   10 -
 .../mach-ux500/include/mach/board-mop500-audio.h   |   52 +
 .../arm/mach-ux500/include/mach/board-mop500-msp.h |   32 +
 arch/arm/mach-ux500/include/mach/msp.h             |   29 +
 include/sound/pcm.h                                |    2 +
 include/sound/soc-dapm.h                           |   12 +
 include/sound/soc.h                                |   30 +-
 sound/core/pcm.c                                   |   10 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    3 +
 sound/soc/codecs/ab8500-codec.c                    | 2852 ++++++++++++++++++++
 sound/soc/codecs/ab8500-codec.h                    |  608 +++++
 sound/soc/soc-core.c                               |  181 ++
 sound/soc/soc-dapm.c                               |   82 +
 sound/soc/ux500/Kconfig                            |   34 +
 sound/soc/ux500/Makefile                           |   10 +
 sound/soc/ux500/mop500.c                           |  117 +
 sound/soc/ux500/mop500_ab8500.c                    |  270 ++
 sound/soc/ux500/mop500_ab8500.h                    |   21 +
 sound/soc/ux500/ux500_msp_dai.c                    |  843 ++++++
 sound/soc/ux500/ux500_msp_dai.h                    |   79 +
 sound/soc/ux500/ux500_msp_i2s.c                    |  742 +++++
 sound/soc/ux500/ux500_msp_i2s.h                    |  553 ++++
 sound/soc/ux500/ux500_pcm.c                        |  320 +++
 sound/soc/ux500/ux500_pcm.h                        |   35 +
 34 files changed, 7233 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-audio.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/board-mop500-audio.h
 create mode 100644 arch/arm/mach-ux500/include/mach/board-mop500-msp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/msp.h
 create mode 100644 sound/soc/codecs/ab8500-codec.c
 create mode 100644 sound/soc/codecs/ab8500-codec.h
 create mode 100644 sound/soc/ux500/Kconfig
 create mode 100644 sound/soc/ux500/Makefile
 create mode 100644 sound/soc/ux500/mop500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.c
 create mode 100644 sound/soc/ux500/mop500_ab8500.h
 create mode 100644 sound/soc/ux500/ux500_msp_dai.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.h
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.c
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.h
 create mode 100644 sound/soc/ux500/ux500_pcm.c
 create mode 100644 sound/soc/ux500/ux500_pcm.h

-- 
1.7.8.3
