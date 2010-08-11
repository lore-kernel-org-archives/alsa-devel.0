From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 00/14] ASoC: multi-component platform support
Date: Wed, 11 Aug 2010 09:46:19 +0100
Message-ID: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B6F6910384A
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:46:46 +0200 (CEST)
Received: by wyb42 with SMTP id 42so11847202wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 01:46:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This is the third and final part part of the multi-component series and focuses
on ASoC multi-component SoC platform support.

I've split this series up per platform. All the patches will be rebased
together at merge time so we don't break bisect.

Most platform drivers were extremely straight forward with changes mainly
limited to their probe() and remove() sections. Although some platforms
(like ppc, samsung and i.MX) did require a little extra work and this is marked
in their commit messages (this has been fixed by Samsung and Timur, Sascha is
currently looking at the i.MX changes).

Again, it's not a one man effort. I've had help from the folks mentioned in
the cover email for the core. 

Liam Girdwood (14):
  ASoC: multi-component - TI OMAP Platform
  ASoC: multi-component - Atmel Platform
  ASoC: multi-component - TI DaVinci Platform
  ASoC: multi-component - Freescale i.MX Platform
  ASoC: multi-component - Toshiba Txx9 Platform
  ASoC: multi-component - Renasas SuperH Platform
  ASoC: multi-component - S6000 Platform
  ASoC: multi-component - Freescale PPC Platform
  ASoC: multi-component - RMI Alchemy AU1x Platform
  ASoC: multi-component - Analog Devices Blackfin Platform
  ASoC: multi-component - Cirrus Logic ep93xx Platform
  ASoC: multi-component - Marvell Kirkwood Platform
  ASoC: multi-component - Winbond/Nuvoton NUC900 Platform
  ASoC: multi-component - Ingenic J4740 Platform

 arch/arm/mach-davinci/da830.c                 |    6 +-
 arch/arm/mach-davinci/da850.c                 |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c         |    4 +-
 arch/arm/mach-davinci/devices.c               |   13 +
 arch/arm/mach-davinci/dm355.c                 |    6 +-
 arch/arm/mach-davinci/dm365.c                 |    4 +-
 arch/arm/mach-davinci/dm644x.c                |    4 +-
 arch/arm/mach-davinci/dm646x.c                |    8 +-
 arch/arm/mach-ep93xx/clock.c                  |    6 +-
 arch/arm/mach-ep93xx/core.c                   |    8 +-
 arch/arm/mach-kirkwood/common.c               |    6 +
 arch/arm/mach-omap1/devices.c                 |   26 +
 arch/arm/mach-omap2/board-n8x0.c              |   15 +
 arch/arm/mach-omap2/board-rx51-peripherals.c  |   14 +-
 arch/arm/mach-omap2/board-zoom2.c             |   28 +-
 arch/arm/mach-omap2/devices.c                 |   39 ++
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +
 arch/arm/plat-omap/include/plat/mcbsp.h       |    7 +
 drivers/input/misc/twl4030-vibra.c            |    4 +-
 drivers/mfd/twl-core.c                        |    6 +-
 drivers/mfd/twl4030-codec.c                   |    8 +-
 include/linux/i2c/twl.h                       |    6 +-
 include/sound/sh_fsi.h                        |    4 +-
 include/sound/soc-of-simple.h                 |   25 -
 sound/soc/atmel/atmel-pcm.c                   |   59 ++-
 sound/soc/atmel/atmel-pcm.h                   |    3 -
 sound/soc/atmel/atmel_ssc_dai.c               |   97 +++-
 sound/soc/atmel/atmel_ssc_dai.h               |    1 -
 sound/soc/atmel/playpaq_wm8510.c              |   65 +--
 sound/soc/atmel/sam9g20_wm8731.c              |   51 +--
 sound/soc/atmel/snd-soc-afeb9260.c            |   35 +-
 sound/soc/au1x/db1200.c                       |   35 +-
 sound/soc/au1x/dbdma2.c                       |   19 +-
 sound/soc/au1x/psc-ac97.c                     |   20 +-
 sound/soc/au1x/psc-i2s.c                      |   21 +-
 sound/soc/au1x/psc.h                          |    3 -
 sound/soc/blackfin/bf5xx-ac97-pcm.c           |   43 ++-
 sound/soc/blackfin/bf5xx-ac97-pcm.h           |    3 -
 sound/soc/blackfin/bf5xx-ac97.c               |   41 ++-
 sound/soc/blackfin/bf5xx-ac97.h               |    2 -
 sound/soc/blackfin/bf5xx-ad1836.c             |   23 +-
 sound/soc/blackfin/bf5xx-ad193x.c             |   23 +-
 sound/soc/blackfin/bf5xx-ad1980.c             |   19 +-
 sound/soc/blackfin/bf5xx-ad73311.c            |   22 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c            |   44 ++-
 sound/soc/blackfin/bf5xx-i2s-pcm.h            |    3 -
 sound/soc/blackfin/bf5xx-i2s.c                |   45 ++-
 sound/soc/blackfin/bf5xx-i2s.h                |   14 -
 sound/soc/blackfin/bf5xx-ssm2602.c            |   38 +--
 sound/soc/blackfin/bf5xx-tdm-pcm.c            |   43 ++-
 sound/soc/blackfin/bf5xx-tdm-pcm.h            |    3 -
 sound/soc/blackfin/bf5xx-tdm.c                |   17 +-
 sound/soc/blackfin/bf5xx-tdm.h                |    2 -
 sound/soc/davinci/davinci-evm.c               |  109 ++---
 sound/soc/davinci/davinci-i2s.c               |   44 +-
 sound/soc/davinci/davinci-i2s.h               |    2 -
 sound/soc/davinci/davinci-mcasp.c             |   34 +-
 sound/soc/davinci/davinci-mcasp.h             |    2 -
 sound/soc/davinci/davinci-pcm.c               |   45 ++-
 sound/soc/davinci/davinci-pcm.h               |    3 -
 sound/soc/davinci/davinci-sffsdr.c            |   27 +-
 sound/soc/davinci/davinci-vcif.c              |   25 +-
 sound/soc/davinci/davinci-vcif.h              |   28 -
 sound/soc/ep93xx/ep93xx-i2s.c                 |   38 +-
 sound/soc/ep93xx/ep93xx-i2s.h                 |   18 -
 sound/soc/ep93xx/ep93xx-pcm.c                 |   37 +-
 sound/soc/ep93xx/ep93xx-pcm.h                 |    2 -
 sound/soc/ep93xx/snappercl15.c                |   24 +-
 sound/soc/fsl/Kconfig                         |    3 -
 sound/soc/fsl/Makefile                        |    3 -
 sound/soc/fsl/efika-audio-fabric.c            |   20 +-
 sound/soc/fsl/fsl_dma.c                       |  312 +++++++-----
 sound/soc/fsl/fsl_dma.h                       |   20 -
 sound/soc/fsl/fsl_ssi.c                       |  249 ++++++----
 sound/soc/fsl/fsl_ssi.h                       |   26 -
 sound/soc/fsl/mpc5200_dma.c                   |   66 ++-
 sound/soc/fsl/mpc5200_dma.h                   |    5 -
 sound/soc/fsl/mpc5200_psc_ac97.c              |   34 +-
 sound/soc/fsl/mpc5200_psc_ac97.h              |    2 -
 sound/soc/fsl/mpc5200_psc_i2s.c               |   19 +-
 sound/soc/fsl/mpc8610_hpcd.c                  |  658 ++++++++++++-------------
 sound/soc/fsl/pcm030-audio-fabric.c           |   21 +-
 sound/soc/fsl/soc-of-simple.c                 |  170 -------
 sound/soc/imx/Kconfig                         |   16 +
 sound/soc/imx/Makefile                        |   10 +-
 sound/soc/imx/eukrea-tlv320.c                 |   16 +-
 sound/soc/imx/imx-pcm-dma-mx2.c               |   43 ++-
 sound/soc/imx/imx-pcm-fiq.c                   |   81 ++-
 sound/soc/imx/imx-ssi.c                       |  111 ++---
 sound/soc/imx/imx-ssi.h                       |    5 +-
 sound/soc/imx/phycore-ac97.c                  |   16 +-
 sound/soc/imx/wm1133-ev1.c                    |   27 +-
 sound/soc/jz4740/jz4740-i2s.c                 |  108 ++--
 sound/soc/jz4740/jz4740-i2s.h                 |    2 -
 sound/soc/jz4740/jz4740-pcm.c                 |   18 +-
 sound/soc/jz4740/jz4740-pcm.h                 |    2 -
 sound/soc/jz4740/qi_lb60.c                    |   20 +-
 sound/soc/kirkwood/kirkwood-dma.c             |   64 ++-
 sound/soc/kirkwood/kirkwood-dma.h             |   17 -
 sound/soc/kirkwood/kirkwood-i2s.c             |   54 ++-
 sound/soc/kirkwood/kirkwood-i2s.h             |   17 -
 sound/soc/kirkwood/kirkwood-openrd.c          |   21 +-
 sound/soc/nuc900/nuc900-ac97.c                |   12 +-
 sound/soc/nuc900/nuc900-audio.c               |   16 +-
 sound/soc/nuc900/nuc900-audio.h               |    4 -
 sound/soc/nuc900/nuc900-pcm.c                 |   38 +-
 sound/soc/omap/am3517evm.c                    |   25 +-
 sound/soc/omap/ams-delta.c                    |   53 +--
 sound/soc/omap/igep0020.c                     |   22 +-
 sound/soc/omap/mcpdm.c                        |   19 +-
 sound/soc/omap/mcpdm.h                        |    2 +
 sound/soc/omap/n810.c                         |   42 +--
 sound/soc/omap/omap-mcbsp.c                   |  123 +++---
 sound/soc/omap/omap-mcbsp.h                   |    2 -
 sound/soc/omap/omap-mcpdm.c                   |   71 ++-
 sound/soc/omap/omap-mcpdm.h                   |   29 --
 sound/soc/omap/omap-pcm.c                     |   47 ++-
 sound/soc/omap/omap-pcm.h                     |    2 -
 sound/soc/omap/omap2evm.c                     |   25 +-
 sound/soc/omap/omap3beagle.c                  |   23 +-
 sound/soc/omap/omap3evm.c                     |   30 +-
 sound/soc/omap/omap3pandora.c                 |   36 +-
 sound/soc/omap/osk5912.c                      |   24 +-
 sound/soc/omap/overo.c                        |   22 +-
 sound/soc/omap/rx51.c                         |   37 +-
 sound/soc/omap/sdp3430.c                      |   56 +--
 sound/soc/omap/sdp4430.c                      |   23 +-
 sound/soc/omap/zoom2.c                        |   64 +--
 sound/soc/s6000/s6000-i2s.c                   |   58 +--
 sound/soc/s6000/s6000-i2s.h                   |    2 -
 sound/soc/s6000/s6000-pcm.c                   |  100 +++--
 sound/soc/s6000/s6000-pcm.h                   |    2 -
 sound/soc/s6000/s6105-ipcam.c                 |   31 +-
 sound/soc/sh/dma-sh7760.c                     |   53 ++-
 sound/soc/sh/fsi-ak4642.c                     |   24 +-
 sound/soc/sh/fsi-da7210.c                     |   22 +-
 sound/soc/sh/fsi.c                            |   47 +--
 sound/soc/sh/hac.c                            |   46 ++-
 sound/soc/sh/migor.c                          |   29 +-
 sound/soc/sh/sh7760-ac97.c                    |   25 +-
 sound/soc/sh/siu.h                            |    5 +-
 sound/soc/sh/siu_dai.c                        |   66 ++--
 sound/soc/sh/siu_pcm.c                        |   32 +-
 sound/soc/sh/ssi.c                            |   55 ++-
 sound/soc/txx9/txx9aclc-ac97.c                |   57 +--
 sound/soc/txx9/txx9aclc-generic.c             |   24 +-
 sound/soc/txx9/txx9aclc.c                     |  141 +++---
 sound/soc/txx9/txx9aclc.h                     |   13 +-
 148 files changed, 2555 insertions(+), 2863 deletions(-)
 delete mode 100644 include/sound/soc-of-simple.h
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s.h
 delete mode 100644 sound/soc/davinci/davinci-vcif.h
 delete mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
 delete mode 100644 sound/soc/fsl/soc-of-simple.c
 delete mode 100644 sound/soc/kirkwood/kirkwood-dma.h
 delete mode 100644 sound/soc/kirkwood/kirkwood-i2s.h
 delete mode 100644 sound/soc/omap/omap-mcpdm.h
