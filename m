From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 0/8] Third edition of Ux500 ASoC-driver
Date: Fri, 20 Apr 2012 11:31:30 +0200
Message-ID: <1334914290-27297-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog104.obsmtp.com (eu1sys200aog104.obsmtp.com
	[207.126.144.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 24369103F40
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2012 11:32:14 +0200 (CEST)
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

This is the third version and since last version there has
been alot of rewriting and improvments. All according to
the comments of Mark.
Highlights:
- Moved all regulator and clock-code from machine into codec.
- Using DMA-engine PCM-interface.
- Removed all virtual enum-switches to pin-switches.
- Cleaned up I2S-abstraction and rearranged it in a better way.
- Moved device-initialization into mach-tree.

Kristoffer KARLSSON (2):
  ASoC: core: Add signed multi register control
  ASoC: core: Add strobe control

Ola Lilja (6):
  ASoC: core: Add debug-print helper function
  arm: ux500: Add support for MSP I2S-devices
  ASoC: Ux500: Add MSP I2S-driver
  ASoC: Ux500: Add platform-driver
  ASoC: codecs: Add AB8500 codec-driver
  ASoC: Ux500: Add machine-driver

 arch/arm/mach-ux500/Makefile           |    3 +-
 arch/arm/mach-ux500/board-mop500-msp.c |  250 +++
 arch/arm/mach-ux500/board-mop500-msp.h |   14 +
 arch/arm/mach-ux500/board-mop500.c     |    4 +
 arch/arm/mach-ux500/clock.c            |    8 +-
 arch/arm/mach-ux500/devices-db8500.h   |   10 -
 arch/arm/mach-ux500/include/mach/msp.h |   29 +
 include/sound/soc.h                    |   31 +-
 sound/soc/Kconfig                      |    1 +
 sound/soc/Makefile                     |    1 +
 sound/soc/codecs/Kconfig               |    4 +
 sound/soc/codecs/Makefile              |    3 +
 sound/soc/codecs/ab8500-codec.c        | 3028 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/ab8500-codec.h        |  603 +++++++
 sound/soc/soc-core.c                   |  181 ++
 sound/soc/soc-pcm.c                    |    9 +
 sound/soc/ux500/Kconfig                |   34 +
 sound/soc/ux500/Makefile               |   11 +
 sound/soc/ux500/u8500.c                |  118 ++
 sound/soc/ux500/ux500_ab8500.c         |  225 +++
 sound/soc/ux500/ux500_ab8500.h         |   21 +
 sound/soc/ux500/ux500_msp_dai.c        |  876 +++++++++
 sound/soc/ux500/ux500_msp_dai.h        |   80 +
 sound/soc/ux500/ux500_msp_i2s.c        |  742 ++++++++
 sound/soc/ux500/ux500_msp_i2s.h        |  553 ++++++
 sound/soc/ux500/ux500_pcm.c            |  332 ++++
 sound/soc/ux500/ux500_pcm.h            |   42 +
 27 files changed, 7198 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/msp.h
 create mode 100644 sound/soc/codecs/ab8500-codec.c
 create mode 100644 sound/soc/codecs/ab8500-codec.h
 create mode 100644 sound/soc/ux500/Kconfig
 create mode 100644 sound/soc/ux500/Makefile
 create mode 100644 sound/soc/ux500/u8500.c
 create mode 100644 sound/soc/ux500/ux500_ab8500.c
 create mode 100644 sound/soc/ux500/ux500_ab8500.h
 create mode 100644 sound/soc/ux500/ux500_msp_dai.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.h
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.c
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.h
 create mode 100644 sound/soc/ux500/ux500_pcm.c
 create mode 100644 sound/soc/ux500/ux500_pcm.h

-- 
1.7.8.3
