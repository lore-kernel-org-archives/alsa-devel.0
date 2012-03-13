From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 00/16] Support U8500/AB8500 ASoC - patch-set 2
Date: Tue, 13 Mar 2012 15:51:22 +0100
Message-ID: <1331650282-16803-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 836D21042FE
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 15:51:32 +0100 (CET)
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

OK, we have done some serious rewriting of the patch-set. And it now consists
of several patches, one for each platform-driver and a few more. Generic code
is put in specific generic-patches.
All code outside the ASoC-driver has been moved to seperate patches and are
upstreamed by Linus Walleij.

I will reply to the last mail with answers to your comments.

PS. These are the full patch-set to be able to build.
The following patches has already been upstreamed by Linus Walleij:

  ARM: ux500: Add DMA-channels for MSP
  arm: ux500: Add audio-regulators

BR,
Ola

Kristoffer KARLSSON (7):
  ASoC: core: Add multi reg control struct & macros
  ASoC: core: Add 8bit multi reg control accessors
  ASoC: core: Add range of reg control accessors
  ASoC: core: Add info accessor for mreg control
  ASoC: core: Add strobe control
  ASoC: core: Add macros for 8bit hwdep multi reg cntrl
  ASoC: core: Add macro for hwdep range of regs control

Ola Lilja (9):
  ARM: ux500: Add DMA-channels for MSP
  arm: ux500: Add audio-regulators
  arm: ux500: Add support for MSP I2S-devices
  ARM: ux500: Add placeholder for clk_set_parent
  ASoC: Ux500: Add MSP I2S-driver
  ASoC: codecs: Add AB8500 codec-driver
  ASoC: Ux500: Add platform-driver
  ASoC: Ux500: Activate the Ux500 ASoC-driver
  ASoC: Ux500: Add machine-driver

 arch/arm/mach-ux500/Makefile                  |    3 +-
 arch/arm/mach-ux500/board-mop500-msp.c        |  194 ++
 arch/arm/mach-ux500/board-mop500-regulators.c |   28 +
 arch/arm/mach-ux500/board-mop500.c            |    7 +-
 arch/arm/mach-ux500/board-mop500.h            |    1 +
 arch/arm/mach-ux500/clock.c                   |   15 +-
 arch/arm/mach-ux500/clock.h                   |    1 +
 arch/arm/mach-ux500/devices-common.h          |    4 +-
 arch/arm/mach-ux500/devices-db8500.c          |    6 +
 arch/arm/mach-ux500/include/mach/hardware.h   |    2 +
 arch/arm/mach-ux500/include/mach/msp.h        |   29 +
 include/sound/soc.h                           |   86 +
 sound/soc/Kconfig                             |    1 +
 sound/soc/Makefile                            |    3 +
 sound/soc/codecs/Kconfig                      |    4 +
 sound/soc/codecs/Makefile                     |    7 +
 sound/soc/codecs/ab8500_audio.c               | 2508 +++++++++++++++++++++++++
 sound/soc/codecs/ab8500_audio.h               |  622 ++++++
 sound/soc/soc-core.c                          |  239 +++
 sound/soc/ux500/Kconfig                       |   41 +
 sound/soc/ux500/Makefile                      |   30 +
 sound/soc/ux500/u8500.c                       |  150 ++
 sound/soc/ux500/ux500_ab8500.c                |  828 ++++++++
 sound/soc/ux500/ux500_ab8500.h                |   25 +
 sound/soc/ux500/ux500_msp.h                   |  936 +++++++++
 sound/soc/ux500/ux500_msp_dai.c               |  899 +++++++++
 sound/soc/ux500/ux500_msp_dai.h               |   74 +
 sound/soc/ux500/ux500_msp_i2s.c               |  815 ++++++++
 sound/soc/ux500/ux500_msp_i2s.h               |   41 +
 sound/soc/ux500/ux500_pcm.c                   |  537 ++++++
 sound/soc/ux500/ux500_pcm.h                   |   52 +
 31 files changed, 8179 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.c
 create mode 100644 arch/arm/mach-ux500/include/mach/msp.h
 create mode 100644 sound/soc/codecs/ab8500_audio.c
 create mode 100644 sound/soc/codecs/ab8500_audio.h
 create mode 100644 sound/soc/ux500/Kconfig
 create mode 100644 sound/soc/ux500/Makefile
 create mode 100644 sound/soc/ux500/u8500.c
 create mode 100644 sound/soc/ux500/ux500_ab8500.c
 create mode 100644 sound/soc/ux500/ux500_ab8500.h
 create mode 100644 sound/soc/ux500/ux500_msp.h
 create mode 100644 sound/soc/ux500/ux500_msp_dai.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.h
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.c
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.h
 create mode 100644 sound/soc/ux500/ux500_pcm.c
 create mode 100644 sound/soc/ux500/ux500_pcm.h

-- 
1.7.8.3
