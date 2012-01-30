From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 0/3] Support U8500/AB8500 ASoC
Date: Mon, 30 Jan 2012 15:17:50 +0100
Message-ID: <1327933070-22118-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog109.obsmtp.com (eu1sys200aog109.obsmtp.com
	[207.126.144.127])
	by alsa0.perex.cz (Postfix) with ESMTP id EF4EB103976
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 15:18:35 +0100 (CET)
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

First try to upload the ASoC-driver for ST-Ericsson U8500-platform.

The audio system in the Ux500 platform consists of an external
mixed signal ASIC called AB8500:
http://www.stericsson.com/developers/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf

The audio portions of the AB8500 are configured over I2C and
the raw data streams are sent using I2S/TDM. For this reason
the I2S/TDM drivers for the DB8500 chip are included in this
submission.

Two of the patches mainly concern adding proper DMA channels
and regulators to the Ux500 platform and may be treated
individually, but preferably all patches shall be merged
through the ASoC tree.

Since we have more codecs for related platforms named U5500
(etc) the soc directory is name ux500.

Ola Lilja (3):
  ARM: ux500: Add placeholder for clk_set_parent
  ARM: ux500: Add DMA-channels for MSP
  ASoC: Ux500: Add driver for Ux500/AB8500 platform/codec

 arch/arm/mach-ux500/Makefile                  |    3 +-
 arch/arm/mach-ux500/board-mop500-msp.c        |  195 ++
 arch/arm/mach-ux500/board-mop500-regulators.c |   28 +
 arch/arm/mach-ux500/board-mop500.c            |    7 +-
 arch/arm/mach-ux500/board-mop500.h            |    1 +
 arch/arm/mach-ux500/clock.c                   |   15 +-
 arch/arm/mach-ux500/clock.h                   |    1 +
 arch/arm/mach-ux500/devices-common.h          |    2 +-
 arch/arm/mach-ux500/devices-db8500.c          |    6 +
 arch/arm/mach-ux500/include/mach/hardware.h   |    2 +
 arch/arm/mach-ux500/include/mach/msp.h        | 1030 +++++++++
 include/sound/ux500_ab8500.h                  |   36 +
 sound/soc/Kconfig                             |    1 +
 sound/soc/Makefile                            |    1 +
 sound/soc/codecs/Kconfig                      |    4 +
 sound/soc/codecs/Makefile                     |    6 +
 sound/soc/codecs/Makefile.rej                 |   10 +
 sound/soc/codecs/ab8500_audio.c               | 2928 +++++++++++++++++++++++++
 sound/soc/codecs/ab8500_audio.h               |  673 ++++++
 sound/soc/ux500/Kconfig                       |   33 +
 sound/soc/ux500/Makefile                      |   25 +
 sound/soc/ux500/u8500.c                       |  150 ++
 sound/soc/ux500/ux500_ab8500.c                |  790 +++++++
 sound/soc/ux500/ux500_msp_dai.c               |  998 +++++++++
 sound/soc/ux500/ux500_msp_dai.h               |   83 +
 sound/soc/ux500/ux500_msp_i2s.c               | 1004 +++++++++
 sound/soc/ux500/ux500_msp_i2s.h               |   40 +
 sound/soc/ux500/ux500_pcm.c                   |  428 ++++
 sound/soc/ux500/ux500_pcm.h                   |   44 +
 29 files changed, 8535 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.c
 create mode 100644 arch/arm/mach-ux500/include/mach/msp.h
 create mode 100644 include/sound/ux500_ab8500.h
 create mode 100644 sound/soc/codecs/Makefile.rej
 create mode 100644 sound/soc/codecs/ab8500_audio.c
 create mode 100644 sound/soc/codecs/ab8500_audio.h
 create mode 100644 sound/soc/ux500/Kconfig
 create mode 100644 sound/soc/ux500/Makefile
 create mode 100644 sound/soc/ux500/u8500.c
 create mode 100644 sound/soc/ux500/ux500_ab8500.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.h
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.c
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.h
 create mode 100644 sound/soc/ux500/ux500_pcm.c
 create mode 100644 sound/soc/ux500/ux500_pcm.h

-- 
1.7.8.3
