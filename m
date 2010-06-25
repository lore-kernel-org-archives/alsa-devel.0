From: =?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>
Subject: [PATCH] ASoC: SAMSUNG: Change s3c24xx directory name
	to samsung
Date: Fri, 25 Jun 2010 15:45:18 +0900
Message-ID: <4C24507E.9080805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 4338410384C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 08:45:21 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L4K005ZA5FIM2C0@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 25 Jun 2010 15:45:19 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L4K00BVJ5FIWK@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 25 Jun 2010 15:45:18 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com, jy0922.shim@samsung.com, jassi.brar@samsung.com
List-Id: alsa-devel@alsa-project.org

This patch changes s3c24xx directory name to samsung.
(sound/soc/s3c24xx -> sound/soc/samsung)

Currently, the source files related to samsung SoCs(s3c24xx & s3c64xx)
are included in sound/soc/s3c24xx. It would be better to change s3c24xx
directory name to samsung, because s3c24xx directory will support
many board based on samsung SoCs(s5p, etc).

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 sound/soc/Kconfig                              |    2 +-
 sound/soc/Makefile                             |    2 +-
 sound/soc/s3c24xx/Kconfig                      |  127 ----
 sound/soc/s3c24xx/Makefile                     |   43 --
 sound/soc/s3c24xx/jive_wm8750.c                |  196 ------
 sound/soc/s3c24xx/lm4857.h                     |   32 -
 sound/soc/s3c24xx/ln2440sbc_alc650.c           |   85 ---
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |  506 ---------------
 sound/soc/s3c24xx/neo1973_wm8753.c             |  707 ---------------------
 sound/soc/s3c24xx/regs-i2s-v2.h                |  115 ----
 sound/soc/s3c24xx/s3c-ac97.c                   |  521 ----------------
 sound/soc/s3c24xx/s3c-ac97.h                   |   23 -
 sound/soc/s3c24xx/s3c-dma.c                    |  483 ---------------
 sound/soc/s3c24xx/s3c-dma.h                    |   31 -
 sound/soc/s3c24xx/s3c-i2s-v2.c                 |  776 ------------------------
 sound/soc/s3c24xx/s3c-i2s-v2.h                 |  103 ----
 sound/soc/s3c24xx/s3c-pcm.c                    |  554 -----------------
 sound/soc/s3c24xx/s3c-pcm.h                    |  123 ----
 sound/soc/s3c24xx/s3c2412-i2s.c                |  190 ------
 sound/soc/s3c24xx/s3c2412-i2s.h                |   29 -
 sound/soc/s3c24xx/s3c24xx-i2s.c                |  503 ---------------
 sound/soc/s3c24xx/s3c24xx-i2s.h                |   37 --
 sound/soc/s3c24xx/s3c24xx_simtec.c             |  394 ------------
 sound/soc/s3c24xx/s3c24xx_simtec.h             |   22 -
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |  153 -----
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |  137 -----
 sound/soc/s3c24xx/s3c24xx_uda134x.c            |  373 ------------
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c             |  209 -------
 sound/soc/s3c24xx/s3c64xx-i2s.c                |  190 ------
 sound/soc/s3c24xx/s3c64xx-i2s.h                |   42 --
 sound/soc/s3c24xx/smdk2443_wm9710.c            |   81 ---
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |  266 --------
 sound/soc/s3c24xx/smdk_wm9713.c                |   94 ---
 sound/soc/samsung/Kconfig                      |  127 ++++
 sound/soc/samsung/Makefile                     |   43 ++
 sound/soc/samsung/jive_wm8750.c                |  196 ++++++
 sound/soc/samsung/lm4857.h                     |   32 +
 sound/soc/samsung/ln2440sbc_alc650.c           |   85 +++
 sound/soc/samsung/neo1973_gta02_wm8753.c       |  506 +++++++++++++++
 sound/soc/samsung/neo1973_wm8753.c             |  707 +++++++++++++++++++++
 sound/soc/samsung/regs-i2s-v2.h                |  115 ++++
 sound/soc/samsung/s3c-ac97.c                   |  521 ++++++++++++++++
 sound/soc/samsung/s3c-ac97.h                   |   23 +
 sound/soc/samsung/s3c-dma.c                    |  483 +++++++++++++++
 sound/soc/samsung/s3c-dma.h                    |   31 +
 sound/soc/samsung/s3c-i2s-v2.c                 |  776 ++++++++++++++++++++++++
 sound/soc/samsung/s3c-i2s-v2.h                 |  103 ++++
 sound/soc/samsung/s3c-pcm.c                    |  554 +++++++++++++++++
 sound/soc/samsung/s3c-pcm.h                    |  123 ++++
 sound/soc/samsung/s3c2412-i2s.c                |  190 ++++++
 sound/soc/samsung/s3c2412-i2s.h                |   29 +
 sound/soc/samsung/s3c24xx-i2s.c                |  503 +++++++++++++++
 sound/soc/samsung/s3c24xx-i2s.h                |   37 ++
 sound/soc/samsung/s3c24xx_simtec.c             |  394 ++++++++++++
 sound/soc/samsung/s3c24xx_simtec.h             |   22 +
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |  153 +++++
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |  137 +++++
 sound/soc/samsung/s3c24xx_uda134x.c            |  373 ++++++++++++
 sound/soc/samsung/s3c64xx-i2s-v4.c             |  209 +++++++
 sound/soc/samsung/s3c64xx-i2s.c                |  190 ++++++
 sound/soc/samsung/s3c64xx-i2s.h                |   42 ++
 sound/soc/samsung/smdk2443_wm9710.c            |   81 +++
 sound/soc/samsung/smdk64xx_wm8580.c            |  266 ++++++++
 sound/soc/samsung/smdk_wm9713.c                |   94 +++
 64 files changed, 7147 insertions(+), 7147 deletions(-)
 delete mode 100644 sound/soc/s3c24xx/Kconfig
 delete mode 100644 sound/soc/s3c24xx/Makefile
 delete mode 100644 sound/soc/s3c24xx/jive_wm8750.c
 delete mode 100644 sound/soc/s3c24xx/lm4857.h
 delete mode 100644 sound/soc/s3c24xx/ln2440sbc_alc650.c
 delete mode 100644 sound/soc/s3c24xx/neo1973_gta02_wm8753.c
 delete mode 100644 sound/soc/s3c24xx/neo1973_wm8753.c
 delete mode 100644 sound/soc/s3c24xx/regs-i2s-v2.h
 delete mode 100644 sound/soc/s3c24xx/s3c-ac97.c
 delete mode 100644 sound/soc/s3c24xx/s3c-ac97.h
 delete mode 100644 sound/soc/s3c24xx/s3c-dma.c
 delete mode 100644 sound/soc/s3c24xx/s3c-dma.h
 delete mode 100644 sound/soc/s3c24xx/s3c-i2s-v2.c
 delete mode 100644 sound/soc/s3c24xx/s3c-i2s-v2.h
 delete mode 100644 sound/soc/s3c24xx/s3c-pcm.c
 delete mode 100644 sound/soc/s3c24xx/s3c-pcm.h
 delete mode 100644 sound/soc/s3c24xx/s3c2412-i2s.c
 delete mode 100644 sound/soc/s3c24xx/s3c2412-i2s.h
 delete mode 100644 sound/soc/s3c24xx/s3c24xx-i2s.c
 delete mode 100644 sound/soc/s3c24xx/s3c24xx-i2s.h
 delete mode 100644 sound/soc/s3c24xx/s3c24xx_simtec.c
 delete mode 100644 sound/soc/s3c24xx/s3c24xx_simtec.h
 delete mode 100644 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
 delete mode 100644 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
 delete mode 100644 sound/soc/s3c24xx/s3c24xx_uda134x.c
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s-v4.c
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s.c
 delete mode 100644 sound/soc/s3c24xx/s3c64xx-i2s.h
 delete mode 100644 sound/soc/s3c24xx/smdk2443_wm9710.c
 delete mode 100644 sound/soc/s3c24xx/smdk64xx_wm8580.c
 delete mode 100644 sound/soc/s3c24xx/smdk_wm9713.c
 create mode 100644 sound/soc/samsung/Kconfig
 create mode 100644 sound/soc/samsung/Makefile
 create mode 100644 sound/soc/samsung/jive_wm8750.c
 create mode 100644 sound/soc/samsung/lm4857.h
 create mode 100644 sound/soc/samsung/ln2440sbc_alc650.c
 create mode 100644 sound/soc/samsung/neo1973_gta02_wm8753.c
 create mode 100644 sound/soc/samsung/neo1973_wm8753.c
 create mode 100644 sound/soc/samsung/regs-i2s-v2.h
 create mode 100644 sound/soc/samsung/s3c-ac97.c
 create mode 100644 sound/soc/samsung/s3c-ac97.h
 create mode 100644 sound/soc/samsung/s3c-dma.c
 create mode 100644 sound/soc/samsung/s3c-dma.h
 create mode 100644 sound/soc/samsung/s3c-i2s-v2.c
 create mode 100644 sound/soc/samsung/s3c-i2s-v2.h
 create mode 100644 sound/soc/samsung/s3c-pcm.c
 create mode 100644 sound/soc/samsung/s3c-pcm.h
 create mode 100644 sound/soc/samsung/s3c2412-i2s.c
 create mode 100644 sound/soc/samsung/s3c2412-i2s.h
 create mode 100644 sound/soc/samsung/s3c24xx-i2s.c
 create mode 100644 sound/soc/samsung/s3c24xx-i2s.h
 create mode 100644 sound/soc/samsung/s3c24xx_simtec.c
 create mode 100644 sound/soc/samsung/s3c24xx_simtec.h
 create mode 100644 sound/soc/samsung/s3c24xx_simtec_hermes.c
 create mode 100644 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
 create mode 100644 sound/soc/samsung/s3c24xx_uda134x.c
 create mode 100644 sound/soc/samsung/s3c64xx-i2s-v4.c
 create mode 100644 sound/soc/samsung/s3c64xx-i2s.c
 create mode 100644 sound/soc/samsung/s3c64xx-i2s.h
 create mode 100644 sound/soc/samsung/smdk2443_wm9710.c
 create mode 100644 sound/soc/samsung/smdk64xx_wm8580.c
 create mode 100644 sound/soc/samsung/smdk_wm9713.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index b1749bc..5d467ef 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -32,7 +32,7 @@ source "sound/soc/fsl/Kconfig"
 source "sound/soc/imx/Kconfig"
 source "sound/soc/omap/Kconfig"
 source "sound/soc/pxa/Kconfig"
-source "sound/soc/s3c24xx/Kconfig"
+source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/txx9/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 1470141..9572925 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)   += imx/
 obj-$(CONFIG_SND_SOC)	+= omap/
 obj-$(CONFIG_SND_SOC)	+= pxa/
-obj-$(CONFIG_SND_SOC)	+= s3c24xx/
+obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= txx9/
diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
deleted file mode 100644
index 2a7cc22..0000000
--- a/sound/soc/s3c24xx/Kconfig
+++ /dev/null
@@ -1,127 +0,0 @@
-config SND_S3C24XX_SOC
-	tristate "SoC Audio for the Samsung S3CXXXX chips"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX
-	select S3C64XX_DMA if ARCH_S3C64XX
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the S3C24XX AC97 or I2S interfaces. You will also need to
-	  select the audio interfaces to support below.
-
-config SND_S3C24XX_SOC_I2S
-	tristate
-	select S3C2410_DMA
-
-config SND_S3C_I2SV2_SOC
-	tristate
-
-config SND_S3C2412_SOC_I2S
-	tristate
-	select SND_S3C_I2SV2_SOC
-	select S3C2410_DMA
-
-config SND_S3C64XX_SOC_I2S
-	tristate
-	select SND_S3C_I2SV2_SOC
-	select S3C64XX_DMA
-
-config SND_S3C64XX_SOC_I2S_V4
-	tristate
-	select SND_S3C_I2SV2_SOC
-	select S3C64XX_DMA
-
-config SND_S3C_SOC_PCM
-	tristate
-
-config SND_S3C_SOC_AC97
-	tristate
-	select SND_SOC_AC97_BUS
-
-config SND_S3C24XX_SOC_NEO1973_WM8753
-	tristate "SoC I2S Audio support for NEO1973 - WM8753"
-	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA01
-	select SND_S3C24XX_SOC_I2S
-	select SND_SOC_WM8753
-	help
-	  Say Y if you want to add support for SoC audio on smdk2440
-	  with the WM8753.
-
-config SND_S3C24XX_SOC_NEO1973_GTA02_WM8753
-	tristate "Audio support for the Openmoko Neo FreeRunner (GTA02)"
-	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA02
-	select SND_S3C24XX_SOC_I2S
-	select SND_SOC_WM8753
-	help
-	  This driver provides audio support for the Openmoko Neo FreeRunner
-	  smartphone.
-	  
-config SND_S3C24XX_SOC_JIVE_WM8750
-	tristate "SoC I2S Audio support for Jive"
-	depends on SND_S3C24XX_SOC && MACH_JIVE
-	select SND_SOC_WM8750
-	select SND_S3C2412_SOC_I2S
-	help
-	  Sat Y if you want to add support for SoC audio on the Jive.
-
-config SND_S3C64XX_SOC_WM8580
-	tristate "SoC I2S Audio support for WM8580 on SMDK64XX"
-	depends on SND_S3C24XX_SOC && MACH_SMDK6410
-	select SND_SOC_WM8580
-	select SND_S3C64XX_SOC_I2S_V4
-	help
-	  Say Y if you want to add support for SoC audio on the SMDK6410.
-
-config SND_S3C24XX_SOC_SMDK2443_WM9710
-	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
-	depends on SND_S3C24XX_SOC && MACH_SMDK2443
-	select S3C2410_DMA
-	select AC97_BUS
-	select SND_SOC_AC97_CODEC
-	select SND_S3C_SOC_AC97
-	help
-	  Say Y if you want to add support for SoC audio on smdk2443
-	  with the WM9710.
-
-config SND_S3C24XX_SOC_LN2440SBC_ALC650
-	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
-	depends on SND_S3C24XX_SOC && ARCH_S3C2410
-	select S3C2410_DMA
-	select AC97_BUS
-	select SND_SOC_AC97_CODEC
-	select SND_S3C_SOC_AC97
-	help
-	  Say Y if you want to add support for SoC audio on ln2440sbc
-	  with the ALC650.
-
-config SND_S3C24XX_SOC_S3C24XX_UDA134X
-	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
-       	depends on SND_S3C24XX_SOC && ARCH_S3C2410
-       	select SND_S3C24XX_SOC_I2S
-	select SND_SOC_L3
-       	select SND_SOC_UDA134X
-
-config SND_S3C24XX_SOC_SIMTEC
-	tristate
-	help
-	  Internal node for common S3C24XX/Simtec suppor
-
-config SND_S3C24XX_SOC_SIMTEC_TLV320AIC23
-	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-	depends on SND_S3C24XX_SOC && ARCH_S3C2410
-	select SND_S3C24XX_SOC_I2S
-	select SND_SOC_TLV320AIC23
-	select SND_S3C24XX_SOC_SIMTEC
-
-config SND_S3C24XX_SOC_SIMTEC_HERMES
-	tristate "SoC I2S Audio support for Simtec Hermes board"
-	depends on SND_S3C24XX_SOC && ARCH_S3C2410
-	select SND_S3C24XX_SOC_I2S
-	select SND_SOC_TLV320AIC3X
-	select SND_S3C24XX_SOC_SIMTEC
-
-config SND_SOC_SMDK_WM9713
-	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_S3C24XX_SOC && MACH_SMDK6410
-	select SND_SOC_WM9713
-	select SND_S3C_SOC_AC97
-	help
-	  Sat Y if you want to add support for SoC audio on the SMDK.
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
deleted file mode 100644
index 81d8dc5..0000000
--- a/sound/soc/s3c24xx/Makefile
+++ /dev/null
@@ -1,43 +0,0 @@
-# S3c24XX Platform Support
-snd-soc-s3c24xx-objs := s3c-dma.o
-snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
-snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
-snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
-snd-soc-s3c-ac97-objs := s3c-ac97.o
-snd-soc-s3c64xx-i2s-v4-objs := s3c64xx-i2s-v4.o
-snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
-snd-soc-s3c-pcm-objs := s3c-pcm.o
-
-obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
-obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
-obj-$(CONFIG_SND_S3C_SOC_AC97) += snd-soc-s3c-ac97.o
-obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
-obj-$(CONFIG_SND_S3C64XX_SOC_I2S) += snd-soc-s3c64xx-i2s.o
-obj-$(CONFIG_SND_S3C64XX_SOC_I2S_V4) += snd-soc-s3c64xx-i2s-v4.o
-obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
-obj-$(CONFIG_SND_S3C_SOC_PCM) += snd-soc-s3c-pcm.o
-
-# S3C24XX Machine Support
-snd-soc-jive-wm8750-objs := jive_wm8750.o
-snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
-snd-soc-neo1973-gta02-wm8753-objs := neo1973_gta02_wm8753.o
-snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
-snd-soc-ln2440sbc-alc650-objs := ln2440sbc_alc650.o
-snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
-snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
-snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
-snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
-snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
-snd-soc-smdk-wm9713-objs := smdk_wm9713.o
-
-obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
-obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
-obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_GTA02_WM8753) += snd-soc-neo1973-gta02-wm8753.o
-obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
-obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
-obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
-obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
-obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
-obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
-obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
-obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
deleted file mode 100644
index 8c108b1..0000000
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/* sound/soc/s3c24xx/jive_wm8750.c
- *
- * Copyright 2007,2008 Simtec Electronics
- *
- * Based on sound/soc/pxa/spitz.c
- *	Copyright 2005 Wolfson Microelectronics PLC.
- *	Copyright 2005 Openedhand Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include <asm/mach-types.h>
-
-#include "s3c-dma.h"
-#include "s3c2412-i2s.h"
-
-#include "../codecs/wm8750.h"
-
-static const struct snd_soc_dapm_route audio_map[] = {
-	{ "Headphone Jack", NULL, "LOUT1" },
-	{ "Headphone Jack", NULL, "ROUT1" },
-	{ "Internal Speaker", NULL, "LOUT2" },
-	{ "Internal Speaker", NULL, "ROUT2" },
-	{ "LINPUT1", NULL, "Line Input" },
-	{ "RINPUT1", NULL, "Line Input" },
-};
-
-static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_SPK("Internal Speaker", NULL),
-	SND_SOC_DAPM_LINE("Line In", NULL),
-};
-
-static int jive_hw_params(struct snd_pcm_substream *substream,
-			  struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct s3c_i2sv2_rate_calc div;
-	unsigned int clk = 0;
-	int ret = 0;
-
-	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
-	case 48000:
-	case 96000:
-		clk = 12288000;
-		break;
-	case 11025:
-	case 22050:
-	case 44100:
-		clk = 11289600;
-		break;
-	}
-
-	s3c_i2sv2_iis_calc_rate(&div, NULL, params_rate(params),
-				s3c_i2sv2_get_clock(cpu_dai));
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
-				     SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C2412_DIV_RCLK, div.fs_div);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C2412_DIV_PRESCALER,
-				     div.clk_div - 1);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static struct snd_soc_ops jive_ops = {
-	.hw_params	= jive_hw_params,
-};
-
-static int jive_wm8750_init(struct snd_soc_codec *codec)
-{
-	int err;
-
-	/* These endpoints are not being used. */
-	snd_soc_dapm_nc_pin(codec, "LINPUT2");
-	snd_soc_dapm_nc_pin(codec, "RINPUT2");
-	snd_soc_dapm_nc_pin(codec, "LINPUT3");
-	snd_soc_dapm_nc_pin(codec, "RINPUT3");
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "MONO");
-
-	/* Add jive specific widgets */
-	err = snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
-					ARRAY_SIZE(wm8750_dapm_widgets));
-	if (err) {
-		printk(KERN_ERR "%s: failed to add widgets (%d)\n",
-		       __func__, err);
-		return err;
-	}
-
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static struct snd_soc_dai_link jive_dai = {
-	.name		= "wm8750",
-	.stream_name	= "WM8750",
-	.cpu_dai	= &s3c2412_i2s_dai,
-	.codec_dai	= &wm8750_dai,
-	.init		= jive_wm8750_init,
-	.ops		= &jive_ops,
-};
-
-/* jive audio machine driver */
-static struct snd_soc_card snd_soc_machine_jive = {
-	.name		= "Jive",
-	.platform	= &s3c24xx_soc_platform,
-	.dai_link	= &jive_dai,
-	.num_links	= 1,
-};
-
-/* jive audio subsystem */
-static struct snd_soc_device jive_snd_devdata = {
-	.card		= &snd_soc_machine_jive,
-	.codec_dev	= &soc_codec_dev_wm8750,
-};
-
-static struct platform_device *jive_snd_device;
-
-static int __init jive_init(void)
-{
-	int ret;
-
-	if (!machine_is_jive())
-		return 0;
-
-	printk("JIVE WM8750 Audio support\n");
-
-	jive_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!jive_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(jive_snd_device, &jive_snd_devdata);
-	jive_snd_devdata.dev = &jive_snd_device->dev;
-	ret = platform_device_add(jive_snd_device);
-
-	if (ret)
-		platform_device_put(jive_snd_device);
-
-	return ret;
-}
-
-static void __exit jive_exit(void)
-{
-	platform_device_unregister(jive_snd_device);
-}
-
-module_init(jive_init);
-module_exit(jive_exit);
-
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("ALSA SoC Jive Audio support");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/lm4857.h b/sound/soc/s3c24xx/lm4857.h
deleted file mode 100644
index 0cf5b70..0000000
--- a/sound/soc/s3c24xx/lm4857.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * lm4857.h  --  ALSA Soc Audio Layer
- *
- * Copyright 2007 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory
- *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  Revision history
- *    18th Jun 2007   Initial version.
- */
-
-#ifndef LM4857_H_
-#define LM4857_H_
-
-/* The register offsets in the cache array */
-#define LM4857_MVOL 0
-#define LM4857_LVOL 1
-#define LM4857_RVOL 2
-#define LM4857_CTRL 3
-
-/* the shifts required to set these bits */
-#define LM4857_3D 5
-#define LM4857_WAKEUP 5
-#define LM4857_EPGAIN 4
-
-#endif /*LM4857_H_*/
-
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
deleted file mode 100644
index ffa954f..0000000
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * SoC audio for ln2440sbc
- *
- * Copyright 2007 KonekTel, a.s.
- * Author: Ivan Kuten
- *         ivan.kuten@promwad.com
- *
- * Heavily based on smdk2443_wm9710.c
- * Copyright 2007 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory
- *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-#include <linux/module.h>
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include "../codecs/ac97.h"
-#include "s3c-dma.h"
-#include "s3c-ac97.h"
-
-static struct snd_soc_card ln2440sbc;
-
-static struct snd_soc_dai_link ln2440sbc_dai[] = {
-{
-	.name = "AC97",
-	.stream_name = "AC97 HiFi",
-	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
-	.codec_dai = &ac97_dai,
-},
-};
-
-static struct snd_soc_card ln2440sbc = {
-	.name = "LN2440SBC",
-	.platform = &s3c24xx_soc_platform,
-	.dai_link = ln2440sbc_dai,
-	.num_links = ARRAY_SIZE(ln2440sbc_dai),
-};
-
-static struct snd_soc_device ln2440sbc_snd_ac97_devdata = {
-	.card = &ln2440sbc,
-	.codec_dev = &soc_codec_dev_ac97,
-};
-
-static struct platform_device *ln2440sbc_snd_ac97_device;
-
-static int __init ln2440sbc_init(void)
-{
-	int ret;
-
-	ln2440sbc_snd_ac97_device = platform_device_alloc("soc-audio", -1);
-	if (!ln2440sbc_snd_ac97_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(ln2440sbc_snd_ac97_device,
-				&ln2440sbc_snd_ac97_devdata);
-	ln2440sbc_snd_ac97_devdata.dev = &ln2440sbc_snd_ac97_device->dev;
-	ret = platform_device_add(ln2440sbc_snd_ac97_device);
-
-	if (ret)
-		platform_device_put(ln2440sbc_snd_ac97_device);
-
-	return ret;
-}
-
-static void __exit ln2440sbc_exit(void)
-{
-	platform_device_unregister(ln2440sbc_snd_ac97_device);
-}
-
-module_init(ln2440sbc_init);
-module_exit(ln2440sbc_exit);
-
-/* Module information */
-MODULE_AUTHOR("Ivan Kuten");
-MODULE_DESCRIPTION("ALSA SoC ALC650 LN2440SBC");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
deleted file mode 100644
index 209c259..0000000
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ /dev/null
@@ -1,506 +0,0 @@
-/*
- * neo1973_gta02_wm8753.c  --  SoC audio for Openmoko Freerunner(GTA02)
- *
- * Copyright 2007 Openmoko Inc
- * Author: Graeme Gregory <graeme@openmoko.org>
- * Copyright 2007 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory <linux@wolfsonmicro.com>
- * Copyright 2009 Wolfson Microelectronics
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include <asm/mach-types.h>
-
-#include <plat/regs-iis.h>
-
-#include <mach/regs-clock.h>
-#include <asm/io.h>
-#include <mach/gta02.h>
-#include "../codecs/wm8753.h"
-#include "s3c-dma.h"
-#include "s3c24xx-i2s.h"
-
-static struct snd_soc_card neo1973_gta02;
-
-static int neo1973_gta02_hifi_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	unsigned int pll_out = 0, bclk = 0;
-	int ret = 0;
-	unsigned long iis_clkrate;
-
-	iis_clkrate = s3c24xx_i2s_get_clockrate();
-
-	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
-		pll_out = 12288000;
-		break;
-	case 48000:
-		bclk = WM8753_BCLK_DIV_4;
-		pll_out = 12288000;
-		break;
-	case 96000:
-		bclk = WM8753_BCLK_DIV_2;
-		pll_out = 12288000;
-		break;
-	case 11025:
-		bclk = WM8753_BCLK_DIV_16;
-		pll_out = 11289600;
-		break;
-	case 22050:
-		bclk = WM8753_BCLK_DIV_8;
-		pll_out = 11289600;
-		break;
-	case 44100:
-		bclk = WM8753_BCLK_DIV_4;
-		pll_out = 11289600;
-		break;
-	case 88200:
-		bclk = WM8753_BCLK_DIV_2;
-		pll_out = 11289600;
-		break;
-	}
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_MCLK, pll_out,
-		SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* set MCLK division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
-		S3C2410_IISMOD_32FS);
-	if (ret < 0)
-		return ret;
-
-	/* set codec BCLK division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(codec_dai,
-					WM8753_BCLKDIV, bclk);
-	if (ret < 0)
-		return ret;
-
-	/* set prescaler division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
-		S3C24XX_PRESCALE(4, 4));
-	if (ret < 0)
-		return ret;
-
-	/* codec PLL input is PCLK/4 */
-	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0,
-		iis_clkrate / 4, pll_out);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int neo1973_gta02_hifi_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-
-	/* disable the PLL */
-	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0, 0, 0);
-}
-
-/*
- * Neo1973 WM8753 HiFi DAI opserations.
- */
-static struct snd_soc_ops neo1973_gta02_hifi_ops = {
-	.hw_params = neo1973_gta02_hifi_hw_params,
-	.hw_free = neo1973_gta02_hifi_hw_free,
-};
-
-static int neo1973_gta02_voice_hw_params(
-	struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	unsigned int pcmdiv = 0;
-	int ret = 0;
-	unsigned long iis_clkrate;
-
-	iis_clkrate = s3c24xx_i2s_get_clockrate();
-
-	if (params_rate(params) != 8000)
-		return -EINVAL;
-	if (params_channels(params) != 1)
-		return -EINVAL;
-
-	pcmdiv = WM8753_PCM_DIV_6; /* 2.048 MHz */
-
-	/* todo: gg check mode (DSP_B) against CSR datasheet */
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_PCMCLK,
-		12288000, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* set codec PCM division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8753_PCMDIV,
-					pcmdiv);
-	if (ret < 0)
-		return ret;
-
-	/* configue and enable PLL for 12.288MHz output */
-	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0,
-		iis_clkrate / 4, 12288000);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int neo1973_gta02_voice_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-
-	/* disable the PLL */
-	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0, 0, 0);
-}
-
-static struct snd_soc_ops neo1973_gta02_voice_ops = {
-	.hw_params = neo1973_gta02_voice_hw_params,
-	.hw_free = neo1973_gta02_voice_hw_free,
-};
-
-#define LM4853_AMP 1
-#define LM4853_SPK 2
-
-static u8 lm4853_state;
-
-/* This has no effect, it exists only to maintain compatibility with
- * existing ALSA state files.
- */
-static int lm4853_set_state(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	int val = ucontrol->value.integer.value[0];
-
-	if (val)
-		lm4853_state |= LM4853_AMP;
-	else
-		lm4853_state &= ~LM4853_AMP;
-
-	return 0;
-}
-
-static int lm4853_get_state(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	ucontrol->value.integer.value[0] = lm4853_state & LM4853_AMP;
-
-	return 0;
-}
-
-static int lm4853_set_spk(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	int val = ucontrol->value.integer.value[0];
-
-	if (val) {
-		lm4853_state |= LM4853_SPK;
-		gpio_set_value(GTA02_GPIO_HP_IN, 0);
-	} else {
-		lm4853_state &= ~LM4853_SPK;
-		gpio_set_value(GTA02_GPIO_HP_IN, 1);
-	}
-
-	return 0;
-}
-
-static int lm4853_get_spk(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	ucontrol->value.integer.value[0] = (lm4853_state & LM4853_SPK) >> 1;
-
-	return 0;
-}
-
-static int lm4853_event(struct snd_soc_dapm_widget *w,
-			struct snd_kcontrol *k,
-			int event)
-{
-	gpio_set_value(GTA02_GPIO_AMP_SHUT, SND_SOC_DAPM_EVENT_OFF(value));
-
-	return 0;
-}
-
-static const struct snd_soc_dapm_widget wm8753_dapm_widgets[] = {
-	SND_SOC_DAPM_SPK("Stereo Out", lm4853_event),
-	SND_SOC_DAPM_LINE("GSM Line Out", NULL),
-	SND_SOC_DAPM_LINE("GSM Line In", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Handset Mic", NULL),
-	SND_SOC_DAPM_SPK("Handset Spk", NULL),
-};
-
-
-/* example machine audio_mapnections */
-static const struct snd_soc_dapm_route audio_map[] = {
-
-	/* Connections to the lm4853 amp */
-	{"Stereo Out", NULL, "LOUT1"},
-	{"Stereo Out", NULL, "ROUT1"},
-
-	/* Connections to the GSM Module */
-	{"GSM Line Out", NULL, "MONO1"},
-	{"GSM Line Out", NULL, "MONO2"},
-	{"RXP", NULL, "GSM Line In"},
-	{"RXN", NULL, "GSM Line In"},
-
-	/* Connections to Headset */
-	{"MIC1", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "Headset Mic"},
-
-	/* Call Mic */
-	{"MIC2", NULL, "Mic Bias"},
-	{"MIC2N", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "Handset Mic"},
-
-	/* Call Speaker */
-	{"Handset Spk", NULL, "LOUT2"},
-	{"Handset Spk", NULL, "ROUT2"},
-
-	/* Connect the ALC pins */
-	{"ACIN", NULL, "ACOP"},
-};
-
-static const struct snd_kcontrol_new wm8753_neo1973_gta02_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Stereo Out"),
-	SOC_DAPM_PIN_SWITCH("GSM Line Out"),
-	SOC_DAPM_PIN_SWITCH("GSM Line In"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Handset Mic"),
-	SOC_DAPM_PIN_SWITCH("Handset Spk"),
-
-	/* This has no effect, it exists only to maintain compatibility with
-	 * existing ALSA state files.
-	 */
-	SOC_SINGLE_EXT("Amp State Switch", 6, 0, 1, 0,
-		lm4853_get_state,
-		lm4853_set_state),
-	SOC_SINGLE_EXT("Amp Spk Switch", 7, 0, 1, 0,
-		lm4853_get_spk,
-		lm4853_set_spk),
-};
-
-/*
- * This is an example machine initialisation for a wm8753 connected to a
- * neo1973 GTA02.
- */
-static int neo1973_gta02_wm8753_init(struct snd_soc_codec *codec)
-{
-	int err;
-
-	/* set up NC codec pins */
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "OUT4");
-	snd_soc_dapm_nc_pin(codec, "LINE1");
-	snd_soc_dapm_nc_pin(codec, "LINE2");
-
-	/* Add neo1973 gta02 specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
-				  ARRAY_SIZE(wm8753_dapm_widgets));
-
-	/* add neo1973 gta02 specific controls */
-	err = snd_soc_add_controls(codec, wm8753_neo1973_gta02_controls,
-		ARRAY_SIZE(wm8753_neo1973_gta02_controls));
-
-	if (err < 0)
-		return err;
-
-	/* set up neo1973 gta02 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
-
-	/* set endpoints to default off mode */
-	snd_soc_dapm_disable_pin(codec, "Stereo Out");
-	snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-	snd_soc_dapm_disable_pin(codec, "GSM Line In");
-	snd_soc_dapm_disable_pin(codec, "Headset Mic");
-	snd_soc_dapm_disable_pin(codec, "Handset Mic");
-	snd_soc_dapm_disable_pin(codec, "Handset Spk");
-
-	/* allow audio paths from the GSM modem to run during suspend */
-	snd_soc_dapm_ignore_suspend(codec, "Stereo Out");
-	snd_soc_dapm_ignore_suspend(codec, "GSM Line Out");
-	snd_soc_dapm_ignore_suspend(codec, "GSM Line In");
-	snd_soc_dapm_ignore_suspend(codec, "Headset Mic");
-	snd_soc_dapm_ignore_suspend(codec, "Handset Mic");
-	snd_soc_dapm_ignore_suspend(codec, "Handset Spk");
-
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-/*
- * BT Codec DAI
- */
-static struct snd_soc_dai bt_dai = {
-	.name = "Bluetooth",
-	.id = 0,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-};
-
-static struct snd_soc_dai_link neo1973_gta02_dai[] = {
-{ /* Hifi Playback - for similatious use with voice below */
-	.name = "WM8753",
-	.stream_name = "WM8753 HiFi",
-	.cpu_dai = &s3c24xx_i2s_dai,
-	.codec_dai = &wm8753_dai[WM8753_DAI_HIFI],
-	.init = neo1973_gta02_wm8753_init,
-	.ops = &neo1973_gta02_hifi_ops,
-},
-{ /* Voice via BT */
-	.name = "Bluetooth",
-	.stream_name = "Voice",
-	.cpu_dai = &bt_dai,
-	.codec_dai = &wm8753_dai[WM8753_DAI_VOICE],
-	.ops = &neo1973_gta02_voice_ops,
-},
-};
-
-static struct snd_soc_card neo1973_gta02 = {
-	.name = "neo1973-gta02",
-	.platform = &s3c24xx_soc_platform,
-	.dai_link = neo1973_gta02_dai,
-	.num_links = ARRAY_SIZE(neo1973_gta02_dai),
-};
-
-static struct snd_soc_device neo1973_gta02_snd_devdata = {
-	.card = &neo1973_gta02,
-	.codec_dev = &soc_codec_dev_wm8753,
-};
-
-static struct platform_device *neo1973_gta02_snd_device;
-
-static int __init neo1973_gta02_init(void)
-{
-	int ret;
-
-	if (!machine_is_neo1973_gta02()) {
-		printk(KERN_INFO
-		       "Only GTA02 is supported by this ASoC driver\n");
-		return -ENODEV;
-	}
-
-	/* register bluetooth DAI here */
-	ret = snd_soc_register_dai(&bt_dai);
-	if (ret)
-		return ret;
-
-	neo1973_gta02_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!neo1973_gta02_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(neo1973_gta02_snd_device,
-			&neo1973_gta02_snd_devdata);
-	neo1973_gta02_snd_devdata.dev = &neo1973_gta02_snd_device->dev;
-	ret = platform_device_add(neo1973_gta02_snd_device);
-
-	if (ret) {
-		platform_device_put(neo1973_gta02_snd_device);
-		return ret;
-	}
-
-	/* Initialise GPIOs used by amp */
-	ret = gpio_request(GTA02_GPIO_HP_IN, "GTA02_HP_IN");
-	if (ret) {
-		pr_err("gta02_wm8753: Failed to register GPIO %d\n", GTA02_GPIO_HP_IN);
-		goto err_unregister_device;
-	}
-
-	ret = gpio_direction_output(GTA02_GPIO_AMP_HP_IN, 1);
-	if (ret) {
-		pr_err("gta02_wm8753: Failed to configure GPIO %d\n", GTA02_GPIO_HP_IN);
-		goto err_free_gpio_hp_in;
-	}
-
-	ret = gpio_request(GTA02_GPIO_AMP_SHUT, "GTA02_AMP_SHUT");
-	if (ret) {
-		pr_err("gta02_wm8753: Failed to register GPIO %d\n", GTA02_GPIO_AMP_SHUT);
-		goto err_free_gpio_hp_in;
-	}
-
-	ret = gpio_direction_output(GTA02_GPIO_AMP_SHUT, 1);
-	if (ret) {
-		pr_err("gta02_wm8753: Failed to configure GPIO %d\n", GTA02_GPIO_AMP_SHUT);
-		goto err_free_gpio_amp_shut;
-	}
-
-	return 0;
-
-err_free_gpio_amp_shut:
-	gpio_free(GTA02_GPIO_AMP_SHUT);
-err_free_gpio_hp_in:
-	gpio_free(GTA02_GPIO_HP_IN);
-err_unregister_device:
-	platform_device_unregister(neo1973_gta02_snd_device);
-	return ret;
-}
-module_init(neo1973_gta02_init);
-
-static void __exit neo1973_gta02_exit(void)
-{
-	snd_soc_unregister_dai(&bt_dai);
-	platform_device_unregister(neo1973_gta02_snd_device);
-	gpio_free(GTA02_GPIO_HP_IN);
-	gpio_free(GTA02_GPIO_AMP_SHUT);
-}
-module_exit(neo1973_gta02_exit);
-
-/* Module information */
-MODULE_AUTHOR("Graeme Gregory, graeme@openmoko.org");
-MODULE_DESCRIPTION("ALSA SoC WM8753 Neo1973 GTA02");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
deleted file mode 100644
index 0cb4f86..0000000
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ /dev/null
@@ -1,707 +0,0 @@
-/*
- * neo1973_wm8753.c  --  SoC audio for Neo1973
- *
- * Copyright 2007 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory
- *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <sound/tlv.h>
-
-#include <asm/mach-types.h>
-#include <asm/hardware/scoop.h>
-#include <mach/regs-clock.h>
-#include <mach/regs-gpio.h>
-#include <mach/hardware.h>
-#include <linux/io.h>
-#include <mach/spi-gpio.h>
-
-#include <plat/regs-iis.h>
-
-#include "../codecs/wm8753.h"
-#include "lm4857.h"
-#include "s3c-dma.h"
-#include "s3c24xx-i2s.h"
-
-/* define the scenarios */
-#define NEO_AUDIO_OFF			0
-#define NEO_GSM_CALL_AUDIO_HANDSET	1
-#define NEO_GSM_CALL_AUDIO_HEADSET	2
-#define NEO_GSM_CALL_AUDIO_BLUETOOTH	3
-#define NEO_STEREO_TO_SPEAKERS		4
-#define NEO_STEREO_TO_HEADPHONES	5
-#define NEO_CAPTURE_HANDSET		6
-#define NEO_CAPTURE_HEADSET		7
-#define NEO_CAPTURE_BLUETOOTH		8
-
-static struct snd_soc_card neo1973;
-static struct i2c_client *i2c;
-
-static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	unsigned int pll_out = 0, bclk = 0;
-	int ret = 0;
-	unsigned long iis_clkrate;
-
-	pr_debug("Entered %s\n", __func__);
-
-	iis_clkrate = s3c24xx_i2s_get_clockrate();
-
-	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
-		pll_out = 12288000;
-		break;
-	case 48000:
-		bclk = WM8753_BCLK_DIV_4;
-		pll_out = 12288000;
-		break;
-	case 96000:
-		bclk = WM8753_BCLK_DIV_2;
-		pll_out = 12288000;
-		break;
-	case 11025:
-		bclk = WM8753_BCLK_DIV_16;
-		pll_out = 11289600;
-		break;
-	case 22050:
-		bclk = WM8753_BCLK_DIV_8;
-		pll_out = 11289600;
-		break;
-	case 44100:
-		bclk = WM8753_BCLK_DIV_4;
-		pll_out = 11289600;
-		break;
-	case 88200:
-		bclk = WM8753_BCLK_DIV_2;
-		pll_out = 11289600;
-		break;
-	}
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_MCLK, pll_out,
-		SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* set MCLK division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
-		S3C2410_IISMOD_32FS);
-	if (ret < 0)
-		return ret;
-
-	/* set codec BCLK division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8753_BCLKDIV, bclk);
-	if (ret < 0)
-		return ret;
-
-	/* set prescaler division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
-		S3C24XX_PRESCALE(4, 4));
-	if (ret < 0)
-		return ret;
-
-	/* codec PLL input is PCLK/4 */
-	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0,
-		iis_clkrate / 4, pll_out);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int neo1973_hifi_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* disable the PLL */
-	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0, 0, 0);
-}
-
-/*
- * Neo1973 WM8753 HiFi DAI opserations.
- */
-static struct snd_soc_ops neo1973_hifi_ops = {
-	.hw_params = neo1973_hifi_hw_params,
-	.hw_free = neo1973_hifi_hw_free,
-};
-
-static int neo1973_voice_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	unsigned int pcmdiv = 0;
-	int ret = 0;
-	unsigned long iis_clkrate;
-
-	pr_debug("Entered %s\n", __func__);
-
-	iis_clkrate = s3c24xx_i2s_get_clockrate();
-
-	if (params_rate(params) != 8000)
-		return -EINVAL;
-	if (params_channels(params) != 1)
-		return -EINVAL;
-
-	pcmdiv = WM8753_PCM_DIV_6; /* 2.048 MHz */
-
-	/* todo: gg check mode (DSP_B) against CSR datasheet */
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_PCMCLK, 12288000,
-		SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* set codec PCM division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8753_PCMDIV, pcmdiv);
-	if (ret < 0)
-		return ret;
-
-	/* configue and enable PLL for 12.288MHz output */
-	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0,
-		iis_clkrate / 4, 12288000);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int neo1973_voice_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* disable the PLL */
-	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0, 0, 0);
-}
-
-static struct snd_soc_ops neo1973_voice_ops = {
-	.hw_params = neo1973_voice_hw_params,
-	.hw_free = neo1973_voice_hw_free,
-};
-
-static int neo1973_scenario;
-
-static int neo1973_get_scenario(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	ucontrol->value.integer.value[0] = neo1973_scenario;
-	return 0;
-}
-
-static int set_scenario_endpoints(struct snd_soc_codec *codec, int scenario)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	switch (neo1973_scenario) {
-	case NEO_AUDIO_OFF:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-		break;
-	case NEO_GSM_CALL_AUDIO_HANDSET:
-		snd_soc_dapm_enable_pin(codec, "Audio Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_enable_pin(codec, "Call Mic");
-		break;
-	case NEO_GSM_CALL_AUDIO_HEADSET:
-		snd_soc_dapm_enable_pin(codec, "Audio Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line In");
-		snd_soc_dapm_enable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-		break;
-	case NEO_GSM_CALL_AUDIO_BLUETOOTH:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-		break;
-	case NEO_STEREO_TO_SPEAKERS:
-		snd_soc_dapm_enable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-		break;
-	case NEO_STEREO_TO_HEADPHONES:
-		snd_soc_dapm_enable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-		break;
-	case NEO_CAPTURE_HANDSET:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_enable_pin(codec, "Call Mic");
-		break;
-	case NEO_CAPTURE_HEADSET:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_enable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-		break;
-	case NEO_CAPTURE_BLUETOOTH:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-		break;
-	default:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-	}
-
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static int neo1973_set_scenario(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (neo1973_scenario == ucontrol->value.integer.value[0])
-		return 0;
-
-	neo1973_scenario = ucontrol->value.integer.value[0];
-	set_scenario_endpoints(codec, neo1973_scenario);
-	return 1;
-}
-
-static u8 lm4857_regs[4] = {0x00, 0x40, 0x80, 0xC0};
-
-static void lm4857_write_regs(void)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	if (i2c_master_send(i2c, lm4857_regs, 4) != 4)
-		printk(KERN_ERR "lm4857: i2c write failed\n");
-}
-
-static int lm4857_get_reg(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int reg = mc->reg;
-	int shift = mc->shift;
-	int mask = mc->max;
-
-	pr_debug("Entered %s\n", __func__);
-
-	ucontrol->value.integer.value[0] = (lm4857_regs[reg] >> shift) & mask;
-	return 0;
-}
-
-static int lm4857_set_reg(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int reg = mc->reg;
-	int shift = mc->shift;
-	int mask = mc->max;
-
-	if (((lm4857_regs[reg] >> shift) & mask) ==
-		ucontrol->value.integer.value[0])
-		return 0;
-
-	lm4857_regs[reg] &= ~(mask << shift);
-	lm4857_regs[reg] |= ucontrol->value.integer.value[0] << shift;
-	lm4857_write_regs();
-	return 1;
-}
-
-static int lm4857_get_mode(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	u8 value = lm4857_regs[LM4857_CTRL] & 0x0F;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (value)
-		value -= 5;
-
-	ucontrol->value.integer.value[0] = value;
-	return 0;
-}
-
-static int lm4857_set_mode(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	u8 value = ucontrol->value.integer.value[0];
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (value)
-		value += 5;
-
-	if ((lm4857_regs[LM4857_CTRL] & 0x0F) == value)
-		return 0;
-
-	lm4857_regs[LM4857_CTRL] &= 0xF0;
-	lm4857_regs[LM4857_CTRL] |= value;
-	lm4857_write_regs();
-	return 1;
-}
-
-static const struct snd_soc_dapm_widget wm8753_dapm_widgets[] = {
-	SND_SOC_DAPM_LINE("Audio Out", NULL),
-	SND_SOC_DAPM_LINE("GSM Line Out", NULL),
-	SND_SOC_DAPM_LINE("GSM Line In", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Call Mic", NULL),
-};
-
-
-static const struct snd_soc_dapm_route dapm_routes[] = {
-
-	/* Connections to the lm4857 amp */
-	{"Audio Out", NULL, "LOUT1"},
-	{"Audio Out", NULL, "ROUT1"},
-
-	/* Connections to the GSM Module */
-	{"GSM Line Out", NULL, "MONO1"},
-	{"GSM Line Out", NULL, "MONO2"},
-	{"RXP", NULL, "GSM Line In"},
-	{"RXN", NULL, "GSM Line In"},
-
-	/* Connections to Headset */
-	{"MIC1", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "Headset Mic"},
-
-	/* Call Mic */
-	{"MIC2", NULL, "Mic Bias"},
-	{"MIC2N", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "Call Mic"},
-
-	/* Connect the ALC pins */
-	{"ACIN", NULL, "ACOP"},
-};
-
-static const char *lm4857_mode[] = {
-	"Off",
-	"Call Speaker",
-	"Stereo Speakers",
-	"Stereo Speakers + Headphones",
-	"Headphones"
-};
-
-static const struct soc_enum lm4857_mode_enum[] = {
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(lm4857_mode), lm4857_mode),
-};
-
-static const char *neo_scenarios[] = {
-	"Off",
-	"GSM Handset",
-	"GSM Headset",
-	"GSM Bluetooth",
-	"Speakers",
-	"Headphones",
-	"Capture Handset",
-	"Capture Headset",
-	"Capture Bluetooth"
-};
-
-static const struct soc_enum neo_scenario_enum[] = {
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(neo_scenarios), neo_scenarios),
-};
-
-static const DECLARE_TLV_DB_SCALE(stereo_tlv, -4050, 150, 0);
-static const DECLARE_TLV_DB_SCALE(mono_tlv, -3450, 150, 0);
-
-static const struct snd_kcontrol_new wm8753_neo1973_controls[] = {
-	SOC_SINGLE_EXT_TLV("Amp Left Playback Volume", LM4857_LVOL, 0, 31, 0,
-		lm4857_get_reg, lm4857_set_reg, stereo_tlv),
-	SOC_SINGLE_EXT_TLV("Amp Right Playback Volume", LM4857_RVOL, 0, 31, 0,
-		lm4857_get_reg, lm4857_set_reg, stereo_tlv),
-	SOC_SINGLE_EXT_TLV("Amp Mono Playback Volume", LM4857_MVOL, 0, 31, 0,
-		lm4857_get_reg, lm4857_set_reg, mono_tlv),
-	SOC_ENUM_EXT("Amp Mode", lm4857_mode_enum[0],
-		lm4857_get_mode, lm4857_set_mode),
-	SOC_ENUM_EXT("Neo Mode", neo_scenario_enum[0],
-		neo1973_get_scenario, neo1973_set_scenario),
-	SOC_SINGLE_EXT("Amp Spk 3D Playback Switch", LM4857_LVOL, 5, 1, 0,
-		lm4857_get_reg, lm4857_set_reg),
-	SOC_SINGLE_EXT("Amp HP 3d Playback Switch", LM4857_RVOL, 5, 1, 0,
-		lm4857_get_reg, lm4857_set_reg),
-	SOC_SINGLE_EXT("Amp Fast Wakeup Playback Switch", LM4857_CTRL, 5, 1, 0,
-		lm4857_get_reg, lm4857_set_reg),
-	SOC_SINGLE_EXT("Amp Earpiece 6dB Playback Switch", LM4857_CTRL, 4, 1, 0,
-		lm4857_get_reg, lm4857_set_reg),
-};
-
-/*
- * This is an example machine initialisation for a wm8753 connected to a
- * neo1973 II. It is missing logic to detect hp/mic insertions and logic
- * to re-route the audio in such an event.
- */
-static int neo1973_wm8753_init(struct snd_soc_codec *codec)
-{
-	int err;
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* set up NC codec pins */
-	snd_soc_dapm_nc_pin(codec, "LOUT2");
-	snd_soc_dapm_nc_pin(codec, "ROUT2");
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "OUT4");
-	snd_soc_dapm_nc_pin(codec, "LINE1");
-	snd_soc_dapm_nc_pin(codec, "LINE2");
-
-	/* Add neo1973 specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
-				  ARRAY_SIZE(wm8753_dapm_widgets));
-
-	/* set endpoints to default mode */
-	set_scenario_endpoints(codec, NEO_AUDIO_OFF);
-
-	/* add neo1973 specific controls */
-	err = snd_soc_add_controls(codec, wm8753_neo1973_controls,
-				ARRAY_SIZE(8753_neo1973_controls));
-	if (err < 0)
-		return err;
-
-	/* set up neo1973 specific audio routes */
-	err = snd_soc_dapm_add_routes(codec, dapm_routes,
-				      ARRAY_SIZE(dapm_routes));
-
-	snd_soc_dapm_sync(codec);
-	return 0;
-}
-
-/*
- * BT Codec DAI
- */
-static struct snd_soc_dai bt_dai = {
-	.name = "Bluetooth",
-	.id = 0,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-};
-
-static struct snd_soc_dai_link neo1973_dai[] = {
-{ /* Hifi Playback - for similatious use with voice below */
-	.name = "WM8753",
-	.stream_name = "WM8753 HiFi",
-	.cpu_dai = &s3c24xx_i2s_dai,
-	.codec_dai = &wm8753_dai[WM8753_DAI_HIFI],
-	.init = neo1973_wm8753_init,
-	.ops = &neo1973_hifi_ops,
-},
-{ /* Voice via BT */
-	.name = "Bluetooth",
-	.stream_name = "Voice",
-	.cpu_dai = &bt_dai,
-	.codec_dai = &wm8753_dai[WM8753_DAI_VOICE],
-	.ops = &neo1973_voice_ops,
-},
-};
-
-static struct snd_soc_card neo1973 = {
-	.name = "neo1973",
-	.platform = &s3c24xx_soc_platform,
-	.dai_link = neo1973_dai,
-	.num_links = ARRAY_SIZE(neo1973_dai),
-};
-
-static struct snd_soc_device neo1973_snd_devdata = {
-	.card = &neo1973,
-	.codec_dev = &soc_codec_dev_wm8753,
-};
-
-static int lm4857_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	i2c = client;
-
-	lm4857_write_regs();
-	return 0;
-}
-
-static int lm4857_i2c_remove(struct i2c_client *client)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	i2c = NULL;
-
-	return 0;
-}
-
-static u8 lm4857_state;
-
-static int lm4857_suspend(struct i2c_client *dev, pm_message_t state)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	dev_dbg(&dev->dev, "lm4857_suspend\n");
-	lm4857_state = lm4857_regs[LM4857_CTRL] & 0xf;
-	if (lm4857_state) {
-		lm4857_regs[LM4857_CTRL] &= 0xf0;
-		lm4857_write_regs();
-	}
-	return 0;
-}
-
-static int lm4857_resume(struct i2c_client *dev)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	if (lm4857_state) {
-		lm4857_regs[LM4857_CTRL] |= (lm4857_state & 0x0f);
-		lm4857_write_regs();
-	}
-	return 0;
-}
-
-static void lm4857_shutdown(struct i2c_client *dev)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	dev_dbg(&dev->dev, "lm4857_shutdown\n");
-	lm4857_regs[LM4857_CTRL] &= 0xf0;
-	lm4857_write_regs();
-}
-
-static const struct i2c_device_id lm4857_i2c_id[] = {
-	{ "neo1973_lm4857", 0 },
-	{ }
-};
-
-static struct i2c_driver lm4857_i2c_driver = {
-	.driver = {
-		.name = "LM4857 I2C Amp",
-		.owner = THIS_MODULE,
-	},
-	.suspend =        lm4857_suspend,
-	.resume	=         lm4857_resume,
-	.shutdown =       lm4857_shutdown,
-	.probe =          lm4857_i2c_probe,
-	.remove =         lm4857_i2c_remove,
-	.id_table =       lm4857_i2c_id,
-};
-
-static struct platform_device *neo1973_snd_device;
-
-static int __init neo1973_init(void)
-{
-	int ret;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (!machine_is_neo1973_gta01()) {
-		printk(KERN_INFO
-			"Only GTA01 hardware supported by ASoC driver\n");
-		return -ENODEV;
-	}
-
-	neo1973_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!neo1973_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(neo1973_snd_device, &neo1973_snd_devdata);
-	neo1973_snd_devdata.dev = &neo1973_snd_device->dev;
-	ret = platform_device_add(neo1973_snd_device);
-
-	if (ret) {
-		platform_device_put(neo1973_snd_device);
-		return ret;
-	}
-
-	ret = i2c_add_driver(&lm4857_i2c_driver);
-
-	if (ret != 0)
-		platform_device_unregister(neo1973_snd_device);
-
-	return ret;
-}
-
-static void __exit neo1973_exit(void)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	i2c_del_driver(&lm4857_i2c_driver);
-	platform_device_unregister(neo1973_snd_device);
-}
-
-module_init(neo1973_init);
-module_exit(neo1973_exit);
-
-/* Module information */
-MODULE_AUTHOR("Graeme Gregory, graeme@openmoko.org, www.openmoko.org");
-MODULE_DESCRIPTION("ALSA SoC WM8753 Neo1973");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/regs-i2s-v2.h b/sound/soc/s3c24xx/regs-i2s-v2.h
deleted file mode 100644
index 5e5e568..0000000
--- a/sound/soc/s3c24xx/regs-i2s-v2.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/* linux/include/asm-arm/plat-s3c24xx/regs-s3c2412-iis.h
- *
- * Copyright 2007 Simtec Electronics <linux@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2412 IIS register definition
-*/
-
-#ifndef __ASM_ARCH_REGS_S3C2412_IIS_H
-#define __ASM_ARCH_REGS_S3C2412_IIS_H
-
-#define S3C2412_IISCON			(0x00)
-#define S3C2412_IISMOD			(0x04)
-#define S3C2412_IISFIC			(0x08)
-#define S3C2412_IISPSR			(0x0C)
-#define S3C2412_IISTXD			(0x10)
-#define S3C2412_IISRXD			(0x14)
-
-#define S5PC1XX_IISFICS		0x18
-#define S5PC1XX_IISTXDS		0x1C
-
-#define S5PC1XX_IISCON_SW_RST		(1 << 31)
-#define S5PC1XX_IISCON_FRXOFSTATUS	(1 << 26)
-#define S5PC1XX_IISCON_FRXORINTEN	(1 << 25)
-#define S5PC1XX_IISCON_FTXSURSTAT	(1 << 24)
-#define S5PC1XX_IISCON_FTXSURINTEN	(1 << 23)
-#define S5PC1XX_IISCON_TXSDMAPAUSE	(1 << 20)
-#define S5PC1XX_IISCON_TXSDMACTIVE	(1 << 18)
-
-#define S3C64XX_IISCON_FTXURSTATUS	(1 << 17)
-#define S3C64XX_IISCON_FTXURINTEN	(1 << 16)
-#define S3C64XX_IISCON_TXFIFO2_EMPTY	(1 << 15)
-#define S3C64XX_IISCON_TXFIFO1_EMPTY	(1 << 14)
-#define S3C64XX_IISCON_TXFIFO2_FULL	(1 << 13)
-#define S3C64XX_IISCON_TXFIFO1_FULL	(1 << 12)
-
-#define S3C2412_IISCON_LRINDEX		(1 << 11)
-#define S3C2412_IISCON_TXFIFO_EMPTY	(1 << 10)
-#define S3C2412_IISCON_RXFIFO_EMPTY	(1 << 9)
-#define S3C2412_IISCON_TXFIFO_FULL	(1 << 8)
-#define S3C2412_IISCON_RXFIFO_FULL	(1 << 7)
-#define S3C2412_IISCON_TXDMA_PAUSE	(1 << 6)
-#define S3C2412_IISCON_RXDMA_PAUSE	(1 << 5)
-#define S3C2412_IISCON_TXCH_PAUSE	(1 << 4)
-#define S3C2412_IISCON_RXCH_PAUSE	(1 << 3)
-#define S3C2412_IISCON_TXDMA_ACTIVE	(1 << 2)
-#define S3C2412_IISCON_RXDMA_ACTIVE	(1 << 1)
-#define S3C2412_IISCON_IIS_ACTIVE	(1 << 0)
-
-#define S5PC1XX_IISMOD_OPCLK_CDCLK_OUT	(0 << 30)
-#define S5PC1XX_IISMOD_OPCLK_CDCLK_IN	(1 << 30)
-#define S5PC1XX_IISMOD_OPCLK_BCLK_OUT	(2 << 30)
-#define S5PC1XX_IISMOD_OPCLK_PCLK	(3 << 30)
-#define S5PC1XX_IISMOD_OPCLK_MASK	(3 << 30)
-#define S5PC1XX_IISMOD_TXS_IDMA		(1 << 28) /* Sec_TXFIFO use I-DMA */
-#define S5PC1XX_IISMOD_BLCS_MASK	0x3
-#define S5PC1XX_IISMOD_BLCS_SHIFT	26
-#define S5PC1XX_IISMOD_BLCP_MASK	0x3
-#define S5PC1XX_IISMOD_BLCP_SHIFT	24
-
-#define S3C64XX_IISMOD_C2DD_HHALF	(1 << 21) /* Discard Higher-half */
-#define S3C64XX_IISMOD_C2DD_LHALF	(1 << 20) /* Discard Lower-half */
-#define S3C64XX_IISMOD_C1DD_HHALF	(1 << 19)
-#define S3C64XX_IISMOD_C1DD_LHALF	(1 << 18)
-#define S3C64XX_IISMOD_DC2_EN		(1 << 17)
-#define S3C64XX_IISMOD_DC1_EN		(1 << 16)
-#define S3C64XX_IISMOD_BLC_16BIT	(0 << 13)
-#define S3C64XX_IISMOD_BLC_8BIT		(1 << 13)
-#define S3C64XX_IISMOD_BLC_24BIT	(2 << 13)
-#define S3C64XX_IISMOD_BLC_MASK		(3 << 13)
-
-#define S3C2412_IISMOD_IMS_SYSMUX	(1 << 10)
-#define S3C2412_IISMOD_SLAVE		(1 << 11)
-#define S3C2412_IISMOD_MODE_TXONLY	(0 << 8)
-#define S3C2412_IISMOD_MODE_RXONLY	(1 << 8)
-#define S3C2412_IISMOD_MODE_TXRX	(2 << 8)
-#define S3C2412_IISMOD_MODE_MASK	(3 << 8)
-#define S3C2412_IISMOD_LR_LLOW		(0 << 7)
-#define S3C2412_IISMOD_LR_RLOW		(1 << 7)
-#define S3C2412_IISMOD_SDF_IIS		(0 << 5)
-#define S3C2412_IISMOD_SDF_MSB		(1 << 5)
-#define S3C2412_IISMOD_SDF_LSB		(2 << 5)
-#define S3C2412_IISMOD_SDF_MASK		(3 << 5)
-#define S3C2412_IISMOD_RCLK_256FS	(0 << 3)
-#define S3C2412_IISMOD_RCLK_512FS	(1 << 3)
-#define S3C2412_IISMOD_RCLK_384FS	(2 << 3)
-#define S3C2412_IISMOD_RCLK_768FS	(3 << 3)
-#define S3C2412_IISMOD_RCLK_MASK 	(3 << 3)
-#define S3C2412_IISMOD_BCLK_32FS	(0 << 1)
-#define S3C2412_IISMOD_BCLK_48FS	(1 << 1)
-#define S3C2412_IISMOD_BCLK_16FS	(2 << 1)
-#define S3C2412_IISMOD_BCLK_24FS	(3 << 1)
-#define S3C2412_IISMOD_BCLK_MASK	(3 << 1)
-#define S3C2412_IISMOD_8BIT		(1 << 0)
-
-#define S3C64XX_IISMOD_CDCLKCON		(1 << 12)
-
-#define S3C2412_IISPSR_PSREN		(1 << 15)
-
-#define S3C64XX_IISFIC_TX2COUNT(x)	(((x) >>  24) & 0xf)
-#define S3C64XX_IISFIC_TX1COUNT(x)	(((x) >>  16) & 0xf)
-
-#define S3C2412_IISFIC_TXFLUSH		(1 << 15)
-#define S3C2412_IISFIC_RXFLUSH		(1 << 7)
-#define S3C2412_IISFIC_TXCOUNT(x)	(((x) >>  8) & 0xf)
-#define S3C2412_IISFIC_RXCOUNT(x)	(((x) >>  0) & 0xf)
-
-#define S5PC1XX_IISFICS_TXFLUSH		(1 << 15)
-#define S5PC1XX_IISFICS_TXCOUNT(x)	(((x) >>  8) & 0x7f)
-
-#endif /* __ASM_ARCH_REGS_S3C2412_IIS_H */
diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
deleted file mode 100644
index ecf4fd0..0000000
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ /dev/null
@@ -1,521 +0,0 @@
-/* sound/soc/s3c24xx/s3c-ac97.c
- *
- * ALSA SoC Audio Layer - S3C AC97 Controller driver
- * 	Evolved from s3c2443-ac97.c
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd
- * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
- * 	Credits: Graeme Gregory, Sean Choi
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-
-#include <sound/soc.h>
-
-#include <plat/regs-ac97.h>
-#include <mach/dma.h>
-#include <plat/audio.h>
-
-#include "s3c-dma.h"
-#include "s3c-ac97.h"
-
-#define AC_CMD_ADDR(x) (x << 16)
-#define AC_CMD_DATA(x) (x & 0xffff)
-
-struct s3c_ac97_info {
-	unsigned           state;
-	struct clk         *ac97_clk;
-	void __iomem	   *regs;
-	struct mutex       lock;
-	struct completion  done;
-};
-static struct s3c_ac97_info s3c_ac97;
-
-static struct s3c2410_dma_client s3c_dma_client_out = {
-	.name = "AC97 PCMOut"
-};
-
-static struct s3c2410_dma_client s3c_dma_client_in = {
-	.name = "AC97 PCMIn"
-};
-
-static struct s3c2410_dma_client s3c_dma_client_micin = {
-	.name = "AC97 MicIn"
-};
-
-static struct s3c_dma_params s3c_ac97_pcm_out = {
-	.client		= &s3c_dma_client_out,
-	.dma_size	= 4,
-};
-
-static struct s3c_dma_params s3c_ac97_pcm_in = {
-	.client		= &s3c_dma_client_in,
-	.dma_size	= 4,
-};
-
-static struct s3c_dma_params s3c_ac97_mic_in = {
-	.client		= &s3c_dma_client_micin,
-	.dma_size	= 4,
-};
-
-static void s3c_ac97_activate(struct snd_ac97 *ac97)
-{
-	u32 ac_glbctrl, stat;
-
-	stat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT) & 0x7;
-	if (stat == S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE)
-		return; /* Return if already active */
-
-	INIT_COMPLETION(s3c_ac97.done);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl = S3C_AC97_GLBCTRL_ACLINKON;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	ac_glbctrl |= S3C_AC97_GLBCTRL_TRANSFERDATAENABLE;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		printk(KERN_ERR "AC97: Unable to activate!");
-}
-
-static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
-	unsigned short reg)
-{
-	u32 ac_glbctrl, ac_codec_cmd;
-	u32 stat, addr, data;
-
-	mutex_lock(&s3c_ac97.lock);
-
-	s3c_ac97_activate(ac97);
-
-	INIT_COMPLETION(s3c_ac97.done);
-
-	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-	ac_codec_cmd = S3C_AC97_CODEC_CMD_READ | AC_CMD_ADDR(reg);
-	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-
-	udelay(50);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		printk(KERN_ERR "AC97: Unable to read!");
-
-	stat = readl(s3c_ac97.regs + S3C_AC97_STAT);
-	addr = (stat >> 16) & 0x7f;
-	data = (stat & 0xffff);
-
-	if (addr != reg)
-		printk(KERN_ERR "s3c-ac97: req addr = %02x, rep addr = %02x\n", reg, addr);
-
-	mutex_unlock(&s3c_ac97.lock);
-
-	return (unsigned short)data;
-}
-
-static void s3c_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
-	unsigned short val)
-{
-	u32 ac_glbctrl, ac_codec_cmd;
-
-	mutex_lock(&s3c_ac97.lock);
-
-	s3c_ac97_activate(ac97);
-
-	INIT_COMPLETION(s3c_ac97.done);
-
-	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-	ac_codec_cmd = AC_CMD_ADDR(reg) | AC_CMD_DATA(val);
-	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-
-	udelay(50);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		printk(KERN_ERR "AC97: Unable to write!");
-
-	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-	ac_codec_cmd |= S3C_AC97_CODEC_CMD_READ;
-	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-
-	mutex_unlock(&s3c_ac97.lock);
-}
-
-static void s3c_ac97_cold_reset(struct snd_ac97 *ac97)
-{
-	writel(S3C_AC97_GLBCTRL_COLDRESET,
-			s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	writel(0, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-}
-
-static void s3c_ac97_warm_reset(struct snd_ac97 *ac97)
-{
-	u32 stat;
-
-	stat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT) & 0x7;
-	if (stat == S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE)
-		return; /* Return if already active */
-
-	writel(S3C_AC97_GLBCTRL_WARMRESET, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	writel(0, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	s3c_ac97_activate(ac97);
-}
-
-static irqreturn_t s3c_ac97_irq(int irq, void *dev_id)
-{
-	u32 ac_glbctrl, ac_glbstat;
-
-	ac_glbstat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT);
-
-	if (ac_glbstat & S3C_AC97_GLBSTAT_CODECREADY) {
-
-		ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-		ac_glbctrl &= ~S3C_AC97_GLBCTRL_CODECREADYIE;
-		writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-		complete(&s3c_ac97.done);
-	}
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl |= (1<<30); /* Clear interrupt */
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	return IRQ_HANDLED;
-}
-
-struct snd_ac97_bus_ops soc_ac97_ops = {
-	.read       = s3c_ac97_read,
-	.write      = s3c_ac97_write,
-	.warm_reset = s3c_ac97_warm_reset,
-	.reset      = s3c_ac97_cold_reset,
-};
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
-
-static int s3c_ac97_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *params,
-				  struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct s3c_dma_params *dma_data;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = &s3c_ac97_pcm_out;
-	else
-		dma_data = &s3c_ac97_pcm_in;
-
-	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
-
-	return 0;
-}
-
-static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
-{
-	u32 ac_glbctrl;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMINTM_MASK;
-	else
-		ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMOUTTM_MASK;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			ac_glbctrl |= S3C_AC97_GLBCTRL_PCMINTM_DMA;
-		else
-			ac_glbctrl |= S3C_AC97_GLBCTRL_PCMOUTTM_DMA;
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		break;
-	}
-
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
-
-	return 0;
-}
-
-static int s3c_ac97_hw_mic_params(struct snd_pcm_substream *substream,
-				      struct snd_pcm_hw_params *params,
-				      struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		return -ENODEV;
-	else
-		snd_soc_dai_set_dma_data(cpu_dai, substream, &s3c_ac97_mic_in);
-
-	return 0;
-}
-
-static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
-				    int cmd, struct snd_soc_dai *dai)
-{
-	u32 ac_glbctrl;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl &= ~S3C_AC97_GLBCTRL_MICINTM_MASK;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ac_glbctrl |= S3C_AC97_GLBCTRL_MICINTM_DMA;
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		break;
-	}
-
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
-
-	return 0;
-}
-
-static struct snd_soc_dai_ops s3c_ac97_dai_ops = {
-	.hw_params	= s3c_ac97_hw_params,
-	.trigger	= s3c_ac97_trigger,
-};
-
-static struct snd_soc_dai_ops s3c_ac97_mic_dai_ops = {
-	.hw_params	= s3c_ac97_hw_mic_params,
-	.trigger	= s3c_ac97_mic_trigger,
-};
-
-struct snd_soc_dai s3c_ac97_dai[] = {
-	[S3C_AC97_DAI_PCM] = {
-		.name =	"s3c-ac97",
-		.id = S3C_AC97_DAI_PCM,
-		.ac97_control = 1,
-		.playback = {
-			.stream_name = "AC97 Playback",
-			.channels_min = 2,
-			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_48000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-		.capture = {
-			.stream_name = "AC97 Capture",
-			.channels_min = 2,
-			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_48000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-		.ops = &s3c_ac97_dai_ops,
-	},
-	[S3C_AC97_DAI_MIC] = {
-		.name = "s3c-ac97-mic",
-		.id = S3C_AC97_DAI_MIC,
-		.ac97_control = 1,
-		.capture = {
-			.stream_name = "AC97 Mic Capture",
-			.channels_min = 1,
-			.channels_max = 1,
-			.rates = SNDRV_PCM_RATE_8000_48000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-		.ops = &s3c_ac97_mic_dai_ops,
-	},
-};
-EXPORT_SYMBOL_GPL(s3c_ac97_dai);
-
-static __devinit int s3c_ac97_probe(struct platform_device *pdev)
-{
-	struct resource *mem_res, *dmatx_res, *dmarx_res, *dmamic_res, *irq_res;
-	struct s3c_audio_pdata *ac97_pdata;
-	int ret;
-
-	ac97_pdata = pdev->dev.platform_data;
-	if (!ac97_pdata || !ac97_pdata->cfg_gpio) {
-		dev_err(&pdev->dev, "cfg_gpio callback not provided!\n");
-		return -EINVAL;
-	}
-
-	/* Check for availability of necessary resource */
-	dmatx_res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmatx_res) {
-		dev_err(&pdev->dev, "Unable to get AC97-TX dma resource\n");
-		return -ENXIO;
-	}
-
-	dmarx_res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!dmarx_res) {
-		dev_err(&pdev->dev, "Unable to get AC97-RX dma resource\n");
-		return -ENXIO;
-	}
-
-	dmamic_res = platform_get_resource(pdev, IORESOURCE_DMA, 2);
-	if (!dmamic_res) {
-		dev_err(&pdev->dev, "Unable to get AC97-MIC dma resource\n");
-		return -ENXIO;
-	}
-
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res) {
-		dev_err(&pdev->dev, "Unable to get register resource\n");
-		return -ENXIO;
-	}
-
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq_res) {
-		dev_err(&pdev->dev, "AC97 IRQ not provided!\n");
-		return -ENXIO;
-	}
-
-	if (!request_mem_region(mem_res->start,
-				resource_size(mem_res), "s3c-ac97")) {
-		dev_err(&pdev->dev, "Unable to request register region\n");
-		return -EBUSY;
-	}
-
-	s3c_ac97_pcm_out.channel = dmatx_res->start;
-	s3c_ac97_pcm_out.dma_addr = mem_res->start + S3C_AC97_PCM_DATA;
-	s3c_ac97_pcm_in.channel = dmarx_res->start;
-	s3c_ac97_pcm_in.dma_addr = mem_res->start + S3C_AC97_PCM_DATA;
-	s3c_ac97_mic_in.channel = dmamic_res->start;
-	s3c_ac97_mic_in.dma_addr = mem_res->start + S3C_AC97_MIC_DATA;
-
-	init_completion(&s3c_ac97.done);
-	mutex_init(&s3c_ac97.lock);
-
-	s3c_ac97.regs = ioremap(mem_res->start, resource_size(mem_res));
-	if (s3c_ac97.regs == NULL) {
-		dev_err(&pdev->dev, "Unable to ioremap register region\n");
-		ret = -ENXIO;
-		goto err1;
-	}
-
-	s3c_ac97.ac97_clk = clk_get(&pdev->dev, "ac97");
-	if (IS_ERR(s3c_ac97.ac97_clk)) {
-		dev_err(&pdev->dev, "s3c-ac97 failed to get ac97_clock\n");
-		ret = -ENODEV;
-		goto err2;
-	}
-	clk_enable(s3c_ac97.ac97_clk);
-
-	if (ac97_pdata->cfg_gpio(pdev)) {
-		dev_err(&pdev->dev, "Unable to configure gpio\n");
-		ret = -EINVAL;
-		goto err3;
-	}
-
-	ret = request_irq(irq_res->start, s3c_ac97_irq,
-					IRQF_DISABLED, "AC97", NULL);
-	if (ret < 0) {
-		printk(KERN_ERR "s3c-ac97: interrupt request failed.\n");
-		goto err4;
-	}
-
-	s3c_ac97_dai[S3C_AC97_DAI_PCM].dev = &pdev->dev;
-	s3c_ac97_dai[S3C_AC97_DAI_MIC].dev = &pdev->dev;
-
-	ret = snd_soc_register_dais(s3c_ac97_dai, ARRAY_SIZE(s3c_ac97_dai));
-	if (ret)
-		goto err5;
-
-	return 0;
-
-err5:
-	free_irq(irq_res->start, NULL);
-err4:
-err3:
-	clk_disable(s3c_ac97.ac97_clk);
-	clk_put(s3c_ac97.ac97_clk);
-err2:
-	iounmap(s3c_ac97.regs);
-err1:
-	release_mem_region(mem_res->start, resource_size(mem_res));
-
-	return ret;
-}
-
-static __devexit int s3c_ac97_remove(struct platform_device *pdev)
-{
-	struct resource *mem_res, *irq_res;
-
-	snd_soc_unregister_dais(s3c_ac97_dai, ARRAY_SIZE(s3c_ac97_dai));
-
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (irq_res)
-		free_irq(irq_res->start, NULL);
-
-	clk_disable(s3c_ac97.ac97_clk);
-	clk_put(s3c_ac97.ac97_clk);
-
-	iounmap(s3c_ac97.regs);
-
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (mem_res)
-		release_mem_region(mem_res->start, resource_size(mem_res));
-
-	return 0;
-}
-
-static struct platform_driver s3c_ac97_driver = {
-	.probe  = s3c_ac97_probe,
-	.remove = s3c_ac97_remove,
-	.driver = {
-		.name = "s3c-ac97",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init s3c_ac97_init(void)
-{
-	return platform_driver_register(&s3c_ac97_driver);
-}
-module_init(s3c_ac97_init);
-
-static void __exit s3c_ac97_exit(void)
-{
-	platform_driver_unregister(&s3c_ac97_driver);
-}
-module_exit(s3c_ac97_exit);
-
-MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
-MODULE_DESCRIPTION("AC97 driver for the Samsung SoC");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c-ac97.h b/sound/soc/s3c24xx/s3c-ac97.h
deleted file mode 100644
index 2781983..0000000
--- a/sound/soc/s3c24xx/s3c-ac97.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* sound/soc/s3c24xx/s3c-ac97.h
- *
- * ALSA SoC Audio Layer - S3C AC97 Controller driver
- * 	Evolved from s3c2443-ac97.h
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd
- * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
- * 	Credits: Graeme Gregory, Sean Choi
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __S3C_AC97_H_
-#define __S3C_AC97_H_
-
-#define S3C_AC97_DAI_PCM 0
-#define S3C_AC97_DAI_MIC 1
-
-extern struct snd_soc_dai s3c_ac97_dai[];
-
-#endif /* __S3C_AC97_H_ */
diff --git a/sound/soc/s3c24xx/s3c-dma.c b/sound/soc/s3c24xx/s3c-dma.c
deleted file mode 100644
index 1b61c23..0000000
--- a/sound/soc/s3c24xx/s3c-dma.c
+++ /dev/null
@@ -1,483 +0,0 @@
-/*
- * s3c-dma.c  --  ALSA Soc Audio Layer
- *
- * (c) 2006 Wolfson Microelectronics PLC.
- * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
- *
- * Copyright 2004-2005 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/dma-mapping.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
-#include <asm/dma.h>
-#include <mach/hardware.h>
-#include <mach/dma.h>
-
-#include "s3c-dma.h"
-
-static const struct snd_pcm_hardware s3c_dma_hardware = {
-	.info			= SNDRV_PCM_INFO_INTERLEAVED |
-				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
-				    SNDRV_PCM_INFO_MMAP |
-				    SNDRV_PCM_INFO_MMAP_VALID |
-				    SNDRV_PCM_INFO_PAUSE |
-				    SNDRV_PCM_INFO_RESUME,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
-				    SNDRV_PCM_FMTBIT_U16_LE |
-				    SNDRV_PCM_FMTBIT_U8 |
-				    SNDRV_PCM_FMTBIT_S8,
-	.channels_min		= 2,
-	.channels_max		= 2,
-	.buffer_bytes_max	= 128*1024,
-	.period_bytes_min	= PAGE_SIZE,
-	.period_bytes_max	= PAGE_SIZE*2,
-	.periods_min		= 2,
-	.periods_max		= 128,
-	.fifo_size		= 32,
-};
-
-struct s3c24xx_runtime_data {
-	spinlock_t lock;
-	int state;
-	unsigned int dma_loaded;
-	unsigned int dma_limit;
-	unsigned int dma_period;
-	dma_addr_t dma_start;
-	dma_addr_t dma_pos;
-	dma_addr_t dma_end;
-	struct s3c_dma_params *params;
-};
-
-/* s3c_dma_enqueue
- *
- * place a dma buffer onto the queue for the dma system
- * to handle.
-*/
-static void s3c_dma_enqueue(struct snd_pcm_substream *substream)
-{
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
-	dma_addr_t pos = prtd->dma_pos;
-	unsigned int limit;
-	int ret;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (s3c_dma_has_circular())
-		limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
-	else
-		limit = prtd->dma_limit;
-
-	pr_debug("%s: loaded %d, limit %d\n",
-				__func__, prtd->dma_loaded, limit);
-
-	while (prtd->dma_loaded < limit) {
-		unsigned long len = prtd->dma_period;
-
-		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
-
-		if ((pos + len) > prtd->dma_end) {
-			len  = prtd->dma_end - pos;
-			pr_debug(KERN_DEBUG "%s: corrected dma len %ld\n",
-			       __func__, len);
-		}
-
-		ret = s3c2410_dma_enqueue(prtd->params->channel,
-			substream, pos, len);
-
-		if (ret == 0) {
-			prtd->dma_loaded++;
-			pos += prtd->dma_period;
-			if (pos >= prtd->dma_end)
-				pos = prtd->dma_start;
-		} else
-			break;
-	}
-
-	prtd->dma_pos = pos;
-}
-
-static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
-				void *dev_id, int size,
-				enum s3c2410_dma_buffresult result)
-{
-	struct snd_pcm_substream *substream = dev_id;
-	struct s3c24xx_runtime_data *prtd;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (result == S3C2410_RES_ABORT || result == S3C2410_RES_ERR)
-		return;
-
-	prtd = substream->runtime->private_data;
-
-	if (substream)
-		snd_pcm_period_elapsed(substream);
-
-	spin_lock(&prtd->lock);
-	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
-		prtd->dma_loaded--;
-		s3c_dma_enqueue(substream);
-	}
-
-	spin_unlock(&prtd->lock);
-}
-
-static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	unsigned long totbytes = params_buffer_bytes(params);
-	struct s3c_dma_params *dma =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
-	int ret = 0;
-
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!dma)
-		return 0;
-
-	/* this may get called several times by oss emulation
-	 * with different params -HW */
-	if (prtd->params == NULL) {
-		/* prepare DMA */
-		prtd->params = dma;
-
-		pr_debug("params %p, client %p, channel %d\n", prtd->params,
-			prtd->params->client, prtd->params->channel);
-
-		ret = s3c2410_dma_request(prtd->params->channel,
-					  prtd->params->client, NULL);
-
-		if (ret < 0) {
-			printk(KERN_ERR "failed to get dma channel\n");
-			return ret;
-		}
-
-		/* use the circular buffering if we have it available. */
-		if (s3c_dma_has_circular())
-			s3c2410_dma_setflags(prtd->params->channel,
-					     S3C2410_DMAF_CIRCULAR);
-	}
-
-	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
-				    s3c24xx_audio_buffdone);
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-
-	runtime->dma_bytes = totbytes;
-
-	spin_lock_irq(&prtd->lock);
-	prtd->dma_loaded = 0;
-	prtd->dma_limit = runtime->hw.periods_min;
-	prtd->dma_period = params_period_bytes(params);
-	prtd->dma_start = runtime->dma_addr;
-	prtd->dma_pos = prtd->dma_start;
-	prtd->dma_end = prtd->dma_start + totbytes;
-	spin_unlock_irq(&prtd->lock);
-
-	return 0;
-}
-
-static int s3c_dma_hw_free(struct snd_pcm_substream *substream)
-{
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* TODO - do we need to ensure DMA flushed */
-	snd_pcm_set_runtime_buffer(substream, NULL);
-
-	if (prtd->params) {
-		s3c2410_dma_free(prtd->params->channel, prtd->params->client);
-		prtd->params = NULL;
-	}
-
-	return 0;
-}
-
-static int s3c_dma_prepare(struct snd_pcm_substream *substream)
-{
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
-	int ret = 0;
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!prtd->params)
-		return 0;
-
-	/* channel needs configuring for mem=>device, increment memory addr,
-	 * sync to pclk, half-word transfers to the IIS-FIFO. */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		s3c2410_dma_devconfig(prtd->params->channel,
-				      S3C2410_DMASRC_MEM,
-				      prtd->params->dma_addr);
-	} else {
-		s3c2410_dma_devconfig(prtd->params->channel,
-				      S3C2410_DMASRC_HW,
-				      prtd->params->dma_addr);
-	}
-
-	s3c2410_dma_config(prtd->params->channel,
-			   prtd->params->dma_size);
-
-	/* flush the DMA channel */
-	s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_FLUSH);
-	prtd->dma_loaded = 0;
-	prtd->dma_pos = prtd->dma_start;
-
-	/* enqueue dma buffers */
-	s3c_dma_enqueue(substream);
-
-	return ret;
-}
-
-static int s3c_dma_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
-	int ret = 0;
-
-	pr_debug("Entered %s\n", __func__);
-
-	spin_lock(&prtd->lock);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		prtd->state |= ST_RUNNING;
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_START);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		prtd->state &= ~ST_RUNNING;
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STOP);
-		break;
-
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	spin_unlock(&prtd->lock);
-
-	return ret;
-}
-
-static snd_pcm_uframes_t
-s3c_dma_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
-	unsigned long res;
-	dma_addr_t src, dst;
-
-	pr_debug("Entered %s\n", __func__);
-
-	spin_lock(&prtd->lock);
-	s3c2410_dma_getposition(prtd->params->channel, &src, &dst);
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		res = dst - prtd->dma_start;
-	else
-		res = src - prtd->dma_start;
-
-	spin_unlock(&prtd->lock);
-
-	pr_debug("Pointer %x %x\n", src, dst);
-
-	/* we seem to be getting the odd error from the pcm library due
-	 * to out-of-bounds pointers. this is maybe due to the dma engine
-	 * not having loaded the new values for the channel before being
-	 * callled... (todo - fix )
-	 */
-
-	if (res >= snd_pcm_lib_buffer_bytes(substream)) {
-		if (res == snd_pcm_lib_buffer_bytes(substream))
-			res = 0;
-	}
-
-	return bytes_to_frames(substream->runtime, res);
-}
-
-static int s3c_dma_open(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd;
-
-	pr_debug("Entered %s\n", __func__);
-
-	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-	snd_soc_set_runtime_hwparams(substream, &s3c_dma_hardware);
-
-	prtd = kzalloc(sizeof(struct s3c24xx_runtime_data), GFP_KERNEL);
-	if (prtd == NULL)
-		return -ENOMEM;
-
-	spin_lock_init(&prtd->lock);
-
-	runtime->private_data = prtd;
-	return 0;
-}
-
-static int s3c_dma_close(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (!prtd)
-		pr_debug("s3c_dma_close called with prtd == NULL\n");
-
-	kfree(prtd);
-
-	return 0;
-}
-
-static int s3c_dma_mmap(struct snd_pcm_substream *substream,
-	struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	pr_debug("Entered %s\n", __func__);
-
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
-}
-
-static struct snd_pcm_ops s3c_dma_ops = {
-	.open		= s3c_dma_open,
-	.close		= s3c_dma_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= s3c_dma_hw_params,
-	.hw_free	= s3c_dma_hw_free,
-	.prepare	= s3c_dma_prepare,
-	.trigger	= s3c_dma_trigger,
-	.pointer	= s3c_dma_pointer,
-	.mmap		= s3c_dma_mmap,
-};
-
-static int s3c_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = s3c_dma_hardware.buffer_bytes_max;
-
-	pr_debug("Entered %s\n", __func__);
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-	buf->bytes = size;
-	return 0;
-}
-
-static void s3c_dma_free_dma_buffers(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	pr_debug("Entered %s\n", __func__);
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-
-static u64 s3c_dma_mask = DMA_BIT_MASK(32);
-
-static int s3c_dma_new(struct snd_card *card,
-	struct snd_soc_dai *dai, struct snd_pcm *pcm)
-{
-	int ret = 0;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &s3c_dma_mask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = 0xffffffff;
-
-	if (dai->playback.channels_min) {
-		ret = s3c_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (dai->capture.channels_min) {
-		ret = s3c_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
- out:
-	return ret;
-}
-
-struct snd_soc_platform s3c24xx_soc_platform = {
-	.name		= "s3c24xx-audio",
-	.pcm_ops 	= &s3c_dma_ops,
-	.pcm_new	= s3c_dma_new,
-	.pcm_free	= s3c_dma_free_dma_buffers,
-};
-EXPORT_SYMBOL_GPL(s3c24xx_soc_platform);
-
-static int __init s3c24xx_soc_platform_init(void)
-{
-	return snd_soc_register_platform(&s3c24xx_soc_platform);
-}
-module_init(s3c24xx_soc_platform_init);
-
-static void __exit s3c24xx_soc_platform_exit(void)
-{
-	snd_soc_unregister_platform(&s3c24xx_soc_platform);
-}
-module_exit(s3c24xx_soc_platform_exit);
-
-MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c-dma.h b/sound/soc/s3c24xx/s3c-dma.h
deleted file mode 100644
index 69bb6bf..0000000
--- a/sound/soc/s3c24xx/s3c-dma.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- *  s3c-dma.h --
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  ALSA PCM interface for the Samsung S3C24xx CPU
- */
-
-#ifndef _S3C_AUDIO_H
-#define _S3C_AUDIO_H
-
-#define ST_RUNNING		(1<<0)
-#define ST_OPENED		(1<<1)
-
-struct s3c_dma_params {
-	struct s3c2410_dma_client *client;	/* stream identifier */
-	int channel;				/* Channel ID */
-	dma_addr_t dma_addr;
-	int dma_size;			/* Size of the DMA transfer */
-};
-
-#define S3C24XX_DAI_I2S			0
-
-/* platform data */
-extern struct snd_soc_platform s3c24xx_soc_platform;
-extern struct snd_ac97_bus_ops s3c24xx_ac97_ops;
-
-#endif
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
deleted file mode 100644
index 13311c8..0000000
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ /dev/null
@@ -1,776 +0,0 @@
-/* sound/soc/s3c24xx/s3c-i2c-v2.c
- *
- * ALSA Soc Audio Layer - I2S core for newer Samsung SoCs.
- *
- * Copyright (c) 2006 Wolfson Microelectronics PLC.
- *	Graeme Gregory graeme.gregory@wolfsonmicro.com
- *	linux@wolfsonmicro.com
- *
- * Copyright (c) 2008, 2007, 2004-2005 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
-#include <mach/dma.h>
-
-#include "regs-i2s-v2.h"
-#include "s3c-i2s-v2.h"
-#include "s3c-dma.h"
-
-#undef S3C_IIS_V2_SUPPORTED
-
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
-#define S3C_IIS_V2_SUPPORTED
-#endif
-
-#ifdef CONFIG_PLAT_S3C64XX
-#define S3C_IIS_V2_SUPPORTED
-#endif
-
-#ifndef S3C_IIS_V2_SUPPORTED
-#error Unsupported CPU model
-#endif
-
-#define S3C2412_I2S_DEBUG_CON 0
-
-static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-{
-	return cpu_dai->private_data;
-}
-
-#define bit_set(v, b) (((v) & (b)) ? 1 : 0)
-
-#if S3C2412_I2S_DEBUG_CON
-static void dbg_showcon(const char *fn, u32 con)
-{
-	printk(KERN_DEBUG "%s: LRI=%d, TXFEMPT=%d, RXFEMPT=%d, TXFFULL=%d, RXFFULL=%d\n", fn,
-	       bit_set(con, S3C2412_IISCON_LRINDEX),
-	       bit_set(con, S3C2412_IISCON_TXFIFO_EMPTY),
-	       bit_set(con, S3C2412_IISCON_RXFIFO_EMPTY),
-	       bit_set(con, S3C2412_IISCON_TXFIFO_FULL),
-	       bit_set(con, S3C2412_IISCON_RXFIFO_FULL));
-
-	printk(KERN_DEBUG "%s: PAUSE: TXDMA=%d, RXDMA=%d, TXCH=%d, RXCH=%d\n",
-	       fn,
-	       bit_set(con, S3C2412_IISCON_TXDMA_PAUSE),
-	       bit_set(con, S3C2412_IISCON_RXDMA_PAUSE),
-	       bit_set(con, S3C2412_IISCON_TXCH_PAUSE),
-	       bit_set(con, S3C2412_IISCON_RXCH_PAUSE));
-	printk(KERN_DEBUG "%s: ACTIVE: TXDMA=%d, RXDMA=%d, IIS=%d\n", fn,
-	       bit_set(con, S3C2412_IISCON_TXDMA_ACTIVE),
-	       bit_set(con, S3C2412_IISCON_RXDMA_ACTIVE),
-	       bit_set(con, S3C2412_IISCON_IIS_ACTIVE));
-}
-#else
-static inline void dbg_showcon(const char *fn, u32 con)
-{
-}
-#endif
-
-
-/* Turn on or off the transmission path. */
-static void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
-{
-	void __iomem *regs = i2s->regs;
-	u32 fic, con, mod;
-
-	pr_debug("%s(%d)\n", __func__, on);
-
-	fic = readl(regs + S3C2412_IISFIC);
-	con = readl(regs + S3C2412_IISCON);
-	mod = readl(regs + S3C2412_IISMOD);
-
-	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
-
-	if (on) {
-		con |= S3C2412_IISCON_TXDMA_ACTIVE | S3C2412_IISCON_IIS_ACTIVE;
-		con &= ~S3C2412_IISCON_TXDMA_PAUSE;
-		con &= ~S3C2412_IISCON_TXCH_PAUSE;
-
-		switch (mod & S3C2412_IISMOD_MODE_MASK) {
-		case S3C2412_IISMOD_MODE_TXONLY:
-		case S3C2412_IISMOD_MODE_TXRX:
-			/* do nothing, we are in the right mode */
-			break;
-
-		case S3C2412_IISMOD_MODE_RXONLY:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			mod |= S3C2412_IISMOD_MODE_TXRX;
-			break;
-
-		default:
-			dev_err(i2s->dev, "TXEN: Invalid MODE %x in IISMOD\n",
-				mod & S3C2412_IISMOD_MODE_MASK);
-			break;
-		}
-
-		writel(con, regs + S3C2412_IISCON);
-		writel(mod, regs + S3C2412_IISMOD);
-	} else {
-		/* Note, we do not have any indication that the FIFO problems
-		 * tha the S3C2410/2440 had apply here, so we should be able
-		 * to disable the DMA and TX without resetting the FIFOS.
-		 */
-
-		con |=  S3C2412_IISCON_TXDMA_PAUSE;
-		con |=  S3C2412_IISCON_TXCH_PAUSE;
-		con &= ~S3C2412_IISCON_TXDMA_ACTIVE;
-
-		switch (mod & S3C2412_IISMOD_MODE_MASK) {
-		case S3C2412_IISMOD_MODE_TXRX:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			mod |= S3C2412_IISMOD_MODE_RXONLY;
-			break;
-
-		case S3C2412_IISMOD_MODE_TXONLY:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			con &= ~S3C2412_IISCON_IIS_ACTIVE;
-			break;
-
-		default:
-			dev_err(i2s->dev, "TXDIS: Invalid MODE %x in IISMOD\n",
-				mod & S3C2412_IISMOD_MODE_MASK);
-			break;
-		}
-
-		writel(mod, regs + S3C2412_IISMOD);
-		writel(con, regs + S3C2412_IISCON);
-	}
-
-	fic = readl(regs + S3C2412_IISFIC);
-	dbg_showcon(__func__, con);
-	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
-}
-
-static void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
-{
-	void __iomem *regs = i2s->regs;
-	u32 fic, con, mod;
-
-	pr_debug("%s(%d)\n", __func__, on);
-
-	fic = readl(regs + S3C2412_IISFIC);
-	con = readl(regs + S3C2412_IISCON);
-	mod = readl(regs + S3C2412_IISMOD);
-
-	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
-
-	if (on) {
-		con |= S3C2412_IISCON_RXDMA_ACTIVE | S3C2412_IISCON_IIS_ACTIVE;
-		con &= ~S3C2412_IISCON_RXDMA_PAUSE;
-		con &= ~S3C2412_IISCON_RXCH_PAUSE;
-
-		switch (mod & S3C2412_IISMOD_MODE_MASK) {
-		case S3C2412_IISMOD_MODE_TXRX:
-		case S3C2412_IISMOD_MODE_RXONLY:
-			/* do nothing, we are in the right mode */
-			break;
-
-		case S3C2412_IISMOD_MODE_TXONLY:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			mod |= S3C2412_IISMOD_MODE_TXRX;
-			break;
-
-		default:
-			dev_err(i2s->dev, "RXEN: Invalid MODE %x in IISMOD\n",
-				mod & S3C2412_IISMOD_MODE_MASK);
-		}
-
-		writel(mod, regs + S3C2412_IISMOD);
-		writel(con, regs + S3C2412_IISCON);
-	} else {
-		/* See txctrl notes on FIFOs. */
-
-		con &= ~S3C2412_IISCON_RXDMA_ACTIVE;
-		con |=  S3C2412_IISCON_RXDMA_PAUSE;
-		con |=  S3C2412_IISCON_RXCH_PAUSE;
-
-		switch (mod & S3C2412_IISMOD_MODE_MASK) {
-		case S3C2412_IISMOD_MODE_RXONLY:
-			con &= ~S3C2412_IISCON_IIS_ACTIVE;
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			break;
-
-		case S3C2412_IISMOD_MODE_TXRX:
-			mod &= ~S3C2412_IISMOD_MODE_MASK;
-			mod |= S3C2412_IISMOD_MODE_TXONLY;
-			break;
-
-		default:
-			dev_err(i2s->dev, "RXDIS: Invalid MODE %x in IISMOD\n",
-				mod & S3C2412_IISMOD_MODE_MASK);
-		}
-
-		writel(con, regs + S3C2412_IISCON);
-		writel(mod, regs + S3C2412_IISMOD);
-	}
-
-	fic = readl(regs + S3C2412_IISFIC);
-	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
-}
-
-#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-
-/*
- * Wait for the LR signal to allow synchronisation to the L/R clock
- * from the codec. May only be needed for slave mode.
- */
-static int s3c2412_snd_lrsync(struct s3c_i2sv2_info *i2s)
-{
-	u32 iiscon;
-	unsigned long loops = msecs_to_loops(5);
-
-	pr_debug("Entered %s\n", __func__);
-
-	while (--loops) {
-		iiscon = readl(i2s->regs + S3C2412_IISCON);
-		if (iiscon & S3C2412_IISCON_LRINDEX)
-			break;
-
-		cpu_relax();
-	}
-
-	if (!loops) {
-		printk(KERN_ERR "%s: timeout\n", __func__);
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
-/*
- * Set S3C2412 I2S DAI format
- */
-static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
-			       unsigned int fmt)
-{
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
-	u32 iismod;
-
-	pr_debug("Entered %s\n", __func__);
-
-	iismod = readl(i2s->regs + S3C2412_IISMOD);
-	pr_debug("hw_params r: IISMOD: %x \n", iismod);
-
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
-		i2s->master = 0;
-		iismod |= S3C2412_IISMOD_SLAVE;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
-		i2s->master = 1;
-		iismod &= ~S3C2412_IISMOD_SLAVE;
-		break;
-	default:
-		pr_err("unknwon master/slave format\n");
-		return -EINVAL;
-	}
-
-	iismod &= ~S3C2412_IISMOD_SDF_MASK;
-
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_RIGHT_J:
-		iismod |= S3C2412_IISMOD_LR_RLOW;
-		iismod |= S3C2412_IISMOD_SDF_MSB;
-		break;
-	case SND_SOC_DAIFMT_LEFT_J:
-		iismod |= S3C2412_IISMOD_LR_RLOW;
-		iismod |= S3C2412_IISMOD_SDF_LSB;
-		break;
-	case SND_SOC_DAIFMT_I2S:
-		iismod &= ~S3C2412_IISMOD_LR_RLOW;
-		iismod |= S3C2412_IISMOD_SDF_IIS;
-		break;
-	default:
-		pr_err("Unknown data format\n");
-		return -EINVAL;
-	}
-
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-	pr_debug("hw_params w: IISMOD: %x \n", iismod);
-	return 0;
-}
-
-static int s3c_i2sv2_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *socdai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai_link *dai = rtd->dai;
-	struct s3c_i2sv2_info *i2s = to_info(dai->cpu_dai);
-	struct s3c_dma_params *dma_data;
-	u32 iismod;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = i2s->dma_playback;
-	else
-		dma_data = i2s->dma_capture;
-
-	snd_soc_dai_set_dma_data(dai->cpu_dai, substream, dma_data);
-
-	/* Working copies of register */
-	iismod = readl(i2s->regs + S3C2412_IISMOD);
-	pr_debug("%s: r: IISMOD: %x\n", __func__, iismod);
-
-	iismod &= ~S3C64XX_IISMOD_BLC_MASK;
-	/* Sample size */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		iismod |= S3C64XX_IISMOD_BLC_8BIT;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		iismod |= S3C64XX_IISMOD_BLC_24BIT;
-		break;
-	}
-
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-	pr_debug("%s: w: IISMOD: %x\n", __func__, iismod);
-
-	return 0;
-}
-
-static int s3c_i2sv2_set_sysclk(struct snd_soc_dai *cpu_dai,
-				  int clk_id, unsigned int freq, int dir)
-{
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
-	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-	pr_debug("Entered %s\n", __func__);
-	pr_debug("%s r: IISMOD: %x\n", __func__, iismod);
-
-	switch (clk_id) {
-	case S3C_I2SV2_CLKSRC_PCLK:
-		iismod &= ~S3C2412_IISMOD_IMS_SYSMUX;
-		break;
-
-	case S3C_I2SV2_CLKSRC_AUDIOBUS:
-		iismod |= S3C2412_IISMOD_IMS_SYSMUX;
-		break;
-
-	case S3C_I2SV2_CLKSRC_CDCLK:
-		/* Error if controller doesn't have the CDCLKCON bit */
-		if (!(i2s->feature & S3C_FEATURE_CDCLKCON))
-			return -EINVAL;
-
-		switch (dir) {
-		case SND_SOC_CLOCK_IN:
-			iismod |= S3C64XX_IISMOD_CDCLKCON;
-			break;
-		case SND_SOC_CLOCK_OUT:
-			iismod &= ~S3C64XX_IISMOD_CDCLKCON;
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-	pr_debug("%s w: IISMOD: %x\n", __func__, iismod);
-
-	return 0;
-}
-
-static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
-			       struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_i2sv2_info *i2s = to_info(rtd->dai->cpu_dai);
-	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
-	unsigned long irqs;
-	int ret = 0;
-	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
-
-	pr_debug("Entered %s\n", __func__);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		/* On start, ensure that the FIFOs are cleared and reset. */
-
-		writel(capture ? S3C2412_IISFIC_RXFLUSH : S3C2412_IISFIC_TXFLUSH,
-		       i2s->regs + S3C2412_IISFIC);
-
-		/* clear again, just in case */
-		writel(0x0, i2s->regs + S3C2412_IISFIC);
-
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!i2s->master) {
-			ret = s3c2412_snd_lrsync(i2s);
-			if (ret)
-				goto exit_err;
-		}
-
-		local_irq_save(irqs);
-
-		if (capture)
-			s3c2412_snd_rxctrl(i2s, 1);
-		else
-			s3c2412_snd_txctrl(i2s, 1);
-
-		local_irq_restore(irqs);
-
-		/*
-		 * Load the next buffer to DMA to meet the reqirement
-		 * of the auto reload mechanism of S3C24XX.
-		 * This call won't bother S3C64XX.
-		 */
-		s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
-
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		local_irq_save(irqs);
-
-		if (capture)
-			s3c2412_snd_rxctrl(i2s, 0);
-		else
-			s3c2412_snd_txctrl(i2s, 0);
-
-		local_irq_restore(irqs);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-exit_err:
-	return ret;
-}
-
-/*
- * Set S3C2412 Clock dividers
- */
-static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
-				  int div_id, int div)
-{
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
-	u32 reg;
-
-	pr_debug("%s(%p, %d, %d)\n", __func__, cpu_dai, div_id, div);
-
-	switch (div_id) {
-	case S3C_I2SV2_DIV_BCLK:
-		switch (div) {
-		case 16:
-			div = S3C2412_IISMOD_BCLK_16FS;
-			break;
-
-		case 32:
-			div = S3C2412_IISMOD_BCLK_32FS;
-			break;
-
-		case 24:
-			div = S3C2412_IISMOD_BCLK_24FS;
-			break;
-
-		case 48:
-			div = S3C2412_IISMOD_BCLK_48FS;
-			break;
-
-		default:
-			return -EINVAL;
-		}
-
-		reg = readl(i2s->regs + S3C2412_IISMOD);
-		reg &= ~S3C2412_IISMOD_BCLK_MASK;
-		writel(reg | div, i2s->regs + S3C2412_IISMOD);
-
-		pr_debug("%s: MOD=%08x\n", __func__, readl(i2s->regs + S3C2412_IISMOD));
-		break;
-
-	case S3C_I2SV2_DIV_RCLK:
-		switch (div) {
-		case 256:
-			div = S3C2412_IISMOD_RCLK_256FS;
-			break;
-
-		case 384:
-			div = S3C2412_IISMOD_RCLK_384FS;
-			break;
-
-		case 512:
-			div = S3C2412_IISMOD_RCLK_512FS;
-			break;
-
-		case 768:
-			div = S3C2412_IISMOD_RCLK_768FS;
-			break;
-
-		default:
-			return -EINVAL;
-		}
-
-		reg = readl(i2s->regs + S3C2412_IISMOD);
-		reg &= ~S3C2412_IISMOD_RCLK_MASK;
-		writel(reg | div, i2s->regs + S3C2412_IISMOD);
-		pr_debug("%s: MOD=%08x\n", __func__, readl(i2s->regs + S3C2412_IISMOD));
-		break;
-
-	case S3C_I2SV2_DIV_PRESCALER:
-		if (div >= 0) {
-			writel((div << 8) | S3C2412_IISPSR_PSREN,
-			       i2s->regs + S3C2412_IISPSR);
-		} else {
-			writel(0x0, i2s->regs + S3C2412_IISPSR);
-		}
-		pr_debug("%s: PSR=%08x\n", __func__, readl(i2s->regs + S3C2412_IISPSR));
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static snd_pcm_sframes_t s3c2412_i2s_delay(struct snd_pcm_substream *substream,
-					   struct snd_soc_dai *dai)
-{
-	struct s3c_i2sv2_info *i2s = to_info(dai);
-	u32 reg = readl(i2s->regs + S3C2412_IISFIC);
-	snd_pcm_sframes_t delay;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		delay = S3C2412_IISFIC_TXCOUNT(reg);
-	else
-		delay = S3C2412_IISFIC_RXCOUNT(reg);
-
-	return delay;
-}
-
-struct clk *s3c_i2sv2_get_clock(struct snd_soc_dai *cpu_dai)
-{
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
-	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-	if (iismod & S3C2412_IISMOD_IMS_SYSMUX)
-		return i2s->iis_cclk;
-	else
-		return i2s->iis_pclk;
-}
-EXPORT_SYMBOL_GPL(s3c_i2sv2_get_clock);
-
-/* default table of all avaialable root fs divisors */
-static unsigned int iis_fs_tab[] = { 256, 512, 384, 768 };
-
-int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
-			    unsigned int *fstab,
-			    unsigned int rate, struct clk *clk)
-{
-	unsigned long clkrate = clk_get_rate(clk);
-	unsigned int div;
-	unsigned int fsclk;
-	unsigned int actual;
-	unsigned int fs;
-	unsigned int fsdiv;
-	signed int deviation = 0;
-	unsigned int best_fs = 0;
-	unsigned int best_div = 0;
-	unsigned int best_rate = 0;
-	unsigned int best_deviation = INT_MAX;
-
-	pr_debug("Input clock rate %ldHz\n", clkrate);
-
-	if (fstab == NULL)
-		fstab = iis_fs_tab;
-
-	for (fs = 0; fs < ARRAY_SIZE(iis_fs_tab); fs++) {
-		fsdiv = iis_fs_tab[fs];
-
-		fsclk = clkrate / fsdiv;
-		div = fsclk / rate;
-
-		if ((fsclk % rate) > (rate / 2))
-			div++;
-
-		if (div <= 1)
-			continue;
-
-		actual = clkrate / (fsdiv * div);
-		deviation = actual - rate;
-
-		printk(KERN_DEBUG "%ufs: div %u => result %u, deviation %d\n",
-		       fsdiv, div, actual, deviation);
-
-		deviation = abs(deviation);
-
-		if (deviation < best_deviation) {
-			best_fs = fsdiv;
-			best_div = div;
-			best_rate = actual;
-			best_deviation = deviation;
-		}
-
-		if (deviation == 0)
-			break;
-	}
-
-	printk(KERN_DEBUG "best: fs=%u, div=%u, rate=%u\n",
-	       best_fs, best_div, best_rate);
-
-	info->fs_div = best_fs;
-	info->clk_div = best_div;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(s3c_i2sv2_iis_calc_rate);
-
-int s3c_i2sv2_probe(struct platform_device *pdev,
-		    struct snd_soc_dai *dai,
-		    struct s3c_i2sv2_info *i2s,
-		    unsigned long base)
-{
-	struct device *dev = &pdev->dev;
-	unsigned int iismod;
-
-	i2s->dev = dev;
-
-	/* record our i2s structure for later use in the callbacks */
-	dai->private_data = i2s;
-
-	if (!base) {
-		struct resource *res = platform_get_resource(pdev,
-							     IORESOURCE_MEM,
-							     0);
-		if (!res) {
-			dev_err(dev, "Unable to get register resource\n");
-			return -ENXIO;
-		}
-
-		if (!request_mem_region(res->start, resource_size(res),
-					"s3c64xx-i2s-v4")) {
-			dev_err(dev, "Unable to request register region\n");
-			return -EBUSY;
-		}
-
-		base = res->start;
-	}
-
-	i2s->regs = ioremap(base, 0x100);
-	if (i2s->regs == NULL) {
-		dev_err(dev, "cannot ioremap registers\n");
-		return -ENXIO;
-	}
-
-	i2s->iis_pclk = clk_get(dev, "iis");
-	if (IS_ERR(i2s->iis_pclk)) {
-		dev_err(dev, "failed to get iis_clock\n");
-		iounmap(i2s->regs);
-		return -ENOENT;
-	}
-
-	clk_enable(i2s->iis_pclk);
-
-	/* Mark ourselves as in TXRX mode so we can run through our cleanup
-	 * process without warnings. */
-	iismod = readl(i2s->regs + S3C2412_IISMOD);
-	iismod |= S3C2412_IISMOD_MODE_TXRX;
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-	s3c2412_snd_txctrl(i2s, 0);
-	s3c2412_snd_rxctrl(i2s, 0);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(s3c_i2sv2_probe);
-
-#ifdef CONFIG_PM
-static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
-{
-	struct s3c_i2sv2_info *i2s = to_info(dai);
-	u32 iismod;
-
-	if (dai->active) {
-		i2s->suspend_iismod = readl(i2s->regs + S3C2412_IISMOD);
-		i2s->suspend_iiscon = readl(i2s->regs + S3C2412_IISCON);
-		i2s->suspend_iispsr = readl(i2s->regs + S3C2412_IISPSR);
-
-		/* some basic suspend checks */
-
-		iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-		if (iismod & S3C2412_IISCON_RXDMA_ACTIVE)
-			pr_warning("%s: RXDMA active?\n", __func__);
-
-		if (iismod & S3C2412_IISCON_TXDMA_ACTIVE)
-			pr_warning("%s: TXDMA active?\n", __func__);
-
-		if (iismod & S3C2412_IISCON_IIS_ACTIVE)
-			pr_warning("%s: IIS active\n", __func__);
-	}
-
-	return 0;
-}
-
-static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
-{
-	struct s3c_i2sv2_info *i2s = to_info(dai);
-
-	pr_info("dai_active %d, IISMOD %08x, IISCON %08x\n",
-		dai->active, i2s->suspend_iismod, i2s->suspend_iiscon);
-
-	if (dai->active) {
-		writel(i2s->suspend_iiscon, i2s->regs + S3C2412_IISCON);
-		writel(i2s->suspend_iismod, i2s->regs + S3C2412_IISMOD);
-		writel(i2s->suspend_iispsr, i2s->regs + S3C2412_IISPSR);
-
-		writel(S3C2412_IISFIC_RXFLUSH | S3C2412_IISFIC_TXFLUSH,
-		       i2s->regs + S3C2412_IISFIC);
-
-		ndelay(250);
-		writel(0x0, i2s->regs + S3C2412_IISFIC);
-	}
-
-	return 0;
-}
-#else
-#define s3c2412_i2s_suspend NULL
-#define s3c2412_i2s_resume  NULL
-#endif
-
-int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
-{
-	struct snd_soc_dai_ops *ops = dai->ops;
-
-	ops->trigger = s3c2412_i2s_trigger;
-	if (!ops->hw_params)
-		ops->hw_params = s3c_i2sv2_hw_params;
-	ops->set_fmt = s3c2412_i2s_set_fmt;
-	ops->set_clkdiv = s3c2412_i2s_set_clkdiv;
-	ops->set_sysclk = s3c_i2sv2_set_sysclk;
-
-	/* Allow overriding by (for example) IISv4 */
-	if (!ops->delay)
-		ops->delay = s3c2412_i2s_delay;
-
-	dai->suspend = s3c2412_i2s_suspend;
-	dai->resume = s3c2412_i2s_resume;
-
-	return snd_soc_register_dai(dai);
-}
-EXPORT_SYMBOL_GPL(s3c_i2sv2_register_dai);
-
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.h b/sound/soc/s3c24xx/s3c-i2s-v2.h
deleted file mode 100644
index 766f43a..0000000
--- a/sound/soc/s3c24xx/s3c-i2s-v2.h
+++ /dev/null
@@ -1,103 +0,0 @@
-/* sound/soc/s3c24xx/s3c-i2s-v2.h
- *
- * ALSA Soc Audio Layer - S3C_I2SV2 I2S driver
- *
- * Copyright (c) 2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
-*/
-
-/* This code is the core support for the I2S block found in a number of
- * Samsung SoC devices which is unofficially named I2S-V2. Currently the
- * S3C2412 and the S3C64XX series use this block to provide 1 or 2 I2S
- * channels via configurable GPIO.
- */
-
-#ifndef __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H
-#define __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H __FILE__
-
-#define S3C_I2SV2_DIV_BCLK	(1)
-#define S3C_I2SV2_DIV_RCLK	(2)
-#define S3C_I2SV2_DIV_PRESCALER	(3)
-
-#define S3C_I2SV2_CLKSRC_PCLK		0
-#define S3C_I2SV2_CLKSRC_AUDIOBUS	1
-#define S3C_I2SV2_CLKSRC_CDCLK		2
-
-/* Set this flag for I2S controllers that have the bit IISMOD[12]
- * bridge/break RCLK signal and external Xi2sCDCLK pin.
- */
-#define S3C_FEATURE_CDCLKCON	(1 << 0)
-
-/**
- * struct s3c_i2sv2_info - S3C I2S-V2 information
- * @dev: The parent device passed to use from the probe.
- * @regs: The pointer to the device registe block.
- * @feature: Set of bit-flags indicating features of the controller.
- * @master: True if the I2S core is the I2S bit clock master.
- * @dma_playback: DMA information for playback channel.
- * @dma_capture: DMA information for capture channel.
- * @suspend_iismod: PM save for the IISMOD register.
- * @suspend_iiscon: PM save for the IISCON register.
- * @suspend_iispsr: PM save for the IISPSR register.
- *
- * This is the private codec state for the hardware associated with an
- * I2S channel such as the register mappings and clock sources.
- */
-struct s3c_i2sv2_info {
-	struct device	*dev;
-	void __iomem	*regs;
-
-	u32		feature;
-
-	struct clk	*iis_pclk;
-	struct clk	*iis_cclk;
-
-	unsigned char	 master;
-
-	struct s3c_dma_params	*dma_playback;
-	struct s3c_dma_params	*dma_capture;
-
-	u32		 suspend_iismod;
-	u32		 suspend_iiscon;
-	u32		 suspend_iispsr;
-};
-
-extern struct clk *s3c_i2sv2_get_clock(struct snd_soc_dai *cpu_dai);
-
-struct s3c_i2sv2_rate_calc {
-	unsigned int	clk_div;	/* for prescaler */
-	unsigned int	fs_div;		/* for root frame clock */
-};
-
-extern int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
-				   unsigned int *fstab,
-				   unsigned int rate, struct clk *clk);
-
-/**
- * s3c_i2sv2_probe - probe for i2s device helper
- * @pdev: The platform device supplied to the original probe.
- * @dai: The ASoC DAI structure supplied to the original probe.
- * @i2s: Our local i2s structure to fill in.
- * @base: The base address for the registers.
- */
-extern int s3c_i2sv2_probe(struct platform_device *pdev,
-			   struct snd_soc_dai *dai,
-			   struct s3c_i2sv2_info *i2s,
-			   unsigned long base);
-
-/**
- * s3c_i2sv2_register_dai - register dai with soc core
- * @dai: The snd_soc_dai structure to register
- *
- * Fill in any missing fields and then register the given dai with the
- * soc core.
- */
-extern int s3c_i2sv2_register_dai(struct snd_soc_dai *dai);
-
-#endif /* __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H */
diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
deleted file mode 100644
index 326f0a9..0000000
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ /dev/null
@@ -1,554 +0,0 @@
-/* sound/soc/s3c24xx/s3c-pcm.c
- *
- * ALSA SoC Audio Layer - S3C PCM-Controller driver
- *
- * Copyright (c) 2009 Samsung Electronics Co. Ltd
- * Author: Jaswinder Singh <jassi.brar@samsung.com>
- * based upon I2S drivers by Ben Dooks.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include <plat/audio.h>
-#include <plat/dma.h>
-
-#include "s3c-dma.h"
-#include "s3c-pcm.h"
-
-static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
-	.name		= "PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c_pcm_dma_client_in = {
-	.name		= "PCM Stereo in"
-};
-
-static struct s3c_dma_params s3c_pcm_stereo_out[] = {
-	[0] = {
-		.client		= &s3c_pcm_dma_client_out,
-		.dma_size	= 4,
-	},
-	[1] = {
-		.client		= &s3c_pcm_dma_client_out,
-		.dma_size	= 4,
-	},
-};
-
-static struct s3c_dma_params s3c_pcm_stereo_in[] = {
-	[0] = {
-		.client		= &s3c_pcm_dma_client_in,
-		.dma_size	= 4,
-	},
-	[1] = {
-		.client		= &s3c_pcm_dma_client_in,
-		.dma_size	= 4,
-	},
-};
-
-static struct s3c_pcm_info s3c_pcm[2];
-
-static inline struct s3c_pcm_info *to_info(struct snd_soc_dai *cpu_dai)
-{
-	return cpu_dai->private_data;
-}
-
-static void s3c_pcm_snd_txctrl(struct s3c_pcm_info *pcm, int on)
-{
-	void __iomem *regs = pcm->regs;
-	u32 ctl, clkctl;
-
-	clkctl = readl(regs + S3C_PCM_CLKCTL);
-	ctl = readl(regs + S3C_PCM_CTL);
-	ctl &= ~(S3C_PCM_CTL_TXDIPSTICK_MASK
-			 << S3C_PCM_CTL_TXDIPSTICK_SHIFT);
-
-	if (on) {
-		ctl |= S3C_PCM_CTL_TXDMA_EN;
-		ctl |= S3C_PCM_CTL_TXFIFO_EN;
-		ctl |= S3C_PCM_CTL_ENABLE;
-		ctl |= (0x20<<S3C_PCM_CTL_TXDIPSTICK_SHIFT);
-		clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
-	} else {
-		ctl &= ~S3C_PCM_CTL_TXDMA_EN;
-		ctl &= ~S3C_PCM_CTL_TXFIFO_EN;
-
-		if (!(ctl & S3C_PCM_CTL_RXFIFO_EN)) {
-			ctl &= ~S3C_PCM_CTL_ENABLE;
-			if (!pcm->idleclk)
-				clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
-		}
-	}
-
-	writel(clkctl, regs + S3C_PCM_CLKCTL);
-	writel(ctl, regs + S3C_PCM_CTL);
-}
-
-static void s3c_pcm_snd_rxctrl(struct s3c_pcm_info *pcm, int on)
-{
-	void __iomem *regs = pcm->regs;
-	u32 ctl, clkctl;
-
-	ctl = readl(regs + S3C_PCM_CTL);
-	clkctl = readl(regs + S3C_PCM_CLKCTL);
-
-	if (on) {
-		ctl |= S3C_PCM_CTL_RXDMA_EN;
-		ctl |= S3C_PCM_CTL_RXFIFO_EN;
-		ctl |= S3C_PCM_CTL_ENABLE;
-		clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
-	} else {
-		ctl &= ~S3C_PCM_CTL_RXDMA_EN;
-		ctl &= ~S3C_PCM_CTL_RXFIFO_EN;
-
-		if (!(ctl & S3C_PCM_CTL_TXFIFO_EN)) {
-			ctl &= ~S3C_PCM_CTL_ENABLE;
-			if (!pcm->idleclk)
-				clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
-		}
-	}
-
-	writel(clkctl, regs + S3C_PCM_CLKCTL);
-	writel(ctl, regs + S3C_PCM_CTL);
-}
-
-static int s3c_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
-			       struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_pcm_info *pcm = to_info(rtd->dai->cpu_dai);
-	unsigned long flags;
-
-	dev_dbg(pcm->dev, "Entered %s\n", __func__);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		spin_lock_irqsave(&pcm->lock, flags);
-
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			s3c_pcm_snd_rxctrl(pcm, 1);
-		else
-			s3c_pcm_snd_txctrl(pcm, 1);
-
-		spin_unlock_irqrestore(&pcm->lock, flags);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		spin_lock_irqsave(&pcm->lock, flags);
-
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			s3c_pcm_snd_rxctrl(pcm, 0);
-		else
-			s3c_pcm_snd_txctrl(pcm, 0);
-
-		spin_unlock_irqrestore(&pcm->lock, flags);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *socdai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai_link *dai = rtd->dai;
-	struct s3c_pcm_info *pcm = to_info(dai->cpu_dai);
-	struct s3c_dma_params *dma_data;
-	void __iomem *regs = pcm->regs;
-	struct clk *clk;
-	int sclk_div, sync_div;
-	unsigned long flags;
-	u32 clkctl;
-
-	dev_dbg(pcm->dev, "Entered %s\n", __func__);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = pcm->dma_playback;
-	else
-		dma_data = pcm->dma_capture;
-
-	snd_soc_dai_set_dma_data(dai->cpu_dai, substream, dma_data);
-
-	/* Strictly check for sample size */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&pcm->lock, flags);
-
-	/* Get hold of the PCMSOURCE_CLK */
-	clkctl = readl(regs + S3C_PCM_CLKCTL);
-	if (clkctl & S3C_PCM_CLKCTL_SERCLKSEL_PCLK)
-		clk = pcm->pclk;
-	else
-		clk = pcm->cclk;
-
-	/* Set the SCLK divider */
-	sclk_div = clk_get_rate(clk) / pcm->sclk_per_fs /
-					params_rate(params) / 2 - 1;
-
-	clkctl &= ~(S3C_PCM_CLKCTL_SCLKDIV_MASK
-			<< S3C_PCM_CLKCTL_SCLKDIV_SHIFT);
-	clkctl |= ((sclk_div & S3C_PCM_CLKCTL_SCLKDIV_MASK)
-			<< S3C_PCM_CLKCTL_SCLKDIV_SHIFT);
-
-	/* Set the SYNC divider */
-	sync_div = pcm->sclk_per_fs - 1;
-
-	clkctl &= ~(S3C_PCM_CLKCTL_SYNCDIV_MASK
-				<< S3C_PCM_CLKCTL_SYNCDIV_SHIFT);
-	clkctl |= ((sync_div & S3C_PCM_CLKCTL_SYNCDIV_MASK)
-				<< S3C_PCM_CLKCTL_SYNCDIV_SHIFT);
-
-	writel(clkctl, regs + S3C_PCM_CLKCTL);
-
-	spin_unlock_irqrestore(&pcm->lock, flags);
-
-	dev_dbg(pcm->dev, "PCMSOURCE_CLK-%lu SCLK=%ufs SCLK_DIV=%d SYNC_DIV=%d\n",
-				clk_get_rate(clk), pcm->sclk_per_fs,
-				sclk_div, sync_div);
-
-	return 0;
-}
-
-static int s3c_pcm_set_fmt(struct snd_soc_dai *cpu_dai,
-			       unsigned int fmt)
-{
-	struct s3c_pcm_info *pcm = to_info(cpu_dai);
-	void __iomem *regs = pcm->regs;
-	unsigned long flags;
-	int ret = 0;
-	u32 ctl;
-
-	dev_dbg(pcm->dev, "Entered %s\n", __func__);
-
-	spin_lock_irqsave(&pcm->lock, flags);
-
-	ctl = readl(regs + S3C_PCM_CTL);
-
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_NF:
-		/* Nothing to do, NB_NF by default */
-		break;
-	default:
-		dev_err(pcm->dev, "Unsupported clock inversion!\n");
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
-		/* Nothing to do, Master by default */
-		break;
-	default:
-		dev_err(pcm->dev, "Unsupported master/slave format!\n");
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
-	case SND_SOC_DAIFMT_CONT:
-		pcm->idleclk = 1;
-		break;
-	case SND_SOC_DAIFMT_GATED:
-		pcm->idleclk = 0;
-		break;
-	default:
-		dev_err(pcm->dev, "Invalid Clock gating request!\n");
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_DSP_A:
-		ctl |= S3C_PCM_CTL_TXMSB_AFTER_FSYNC;
-		ctl |= S3C_PCM_CTL_RXMSB_AFTER_FSYNC;
-		break;
-	case SND_SOC_DAIFMT_DSP_B:
-		ctl &= ~S3C_PCM_CTL_TXMSB_AFTER_FSYNC;
-		ctl &= ~S3C_PCM_CTL_RXMSB_AFTER_FSYNC;
-		break;
-	default:
-		dev_err(pcm->dev, "Unsupported data format!\n");
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	writel(ctl, regs + S3C_PCM_CTL);
-
-exit:
-	spin_unlock_irqrestore(&pcm->lock, flags);
-
-	return ret;
-}
-
-static int s3c_pcm_set_clkdiv(struct snd_soc_dai *cpu_dai,
-						int div_id, int div)
-{
-	struct s3c_pcm_info *pcm = to_info(cpu_dai);
-
-	switch (div_id) {
-	case S3C_PCM_SCLK_PER_FS:
-		pcm->sclk_per_fs = div;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int s3c_pcm_set_sysclk(struct snd_soc_dai *cpu_dai,
-				  int clk_id, unsigned int freq, int dir)
-{
-	struct s3c_pcm_info *pcm = to_info(cpu_dai);
-	void __iomem *regs = pcm->regs;
-	u32 clkctl = readl(regs + S3C_PCM_CLKCTL);
-
-	switch (clk_id) {
-	case S3C_PCM_CLKSRC_PCLK:
-		clkctl |= S3C_PCM_CLKCTL_SERCLKSEL_PCLK;
-		break;
-
-	case S3C_PCM_CLKSRC_MUX:
-		clkctl &= ~S3C_PCM_CLKCTL_SERCLKSEL_PCLK;
-
-		if (clk_get_rate(pcm->cclk) != freq)
-			clk_set_rate(pcm->cclk, freq);
-
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	writel(clkctl, regs + S3C_PCM_CLKCTL);
-
-	return 0;
-}
-
-static struct snd_soc_dai_ops s3c_pcm_dai_ops = {
-	.set_sysclk	= s3c_pcm_set_sysclk,
-	.set_clkdiv	= s3c_pcm_set_clkdiv,
-	.trigger	= s3c_pcm_trigger,
-	.hw_params	= s3c_pcm_hw_params,
-	.set_fmt	= s3c_pcm_set_fmt,
-};
-
-#define S3C_PCM_RATES  SNDRV_PCM_RATE_8000_96000
-
-#define S3C_PCM_DECLARE(n)			\
-{								\
-	.name		 = "samsung-pcm",			\
-	.id		 = (n),				\
-	.symmetric_rates = 1,					\
-	.ops = &s3c_pcm_dai_ops,				\
-	.playback = {						\
-		.channels_min	= 2,				\
-		.channels_max	= 2,				\
-		.rates		= S3C_PCM_RATES,		\
-		.formats	= SNDRV_PCM_FMTBIT_S16_LE,	\
-	},							\
-	.capture = {						\
-		.channels_min	= 2,				\
-		.channels_max	= 2,				\
-		.rates		= S3C_PCM_RATES,		\
-		.formats	= SNDRV_PCM_FMTBIT_S16_LE,	\
-	},							\
-}
-
-struct snd_soc_dai s3c_pcm_dai[] = {
-	S3C_PCM_DECLARE(0),
-	S3C_PCM_DECLARE(1),
-};
-EXPORT_SYMBOL_GPL(s3c_pcm_dai);
-
-static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
-{
-	struct s3c_pcm_info *pcm;
-	struct snd_soc_dai *dai;
-	struct resource *mem_res, *dmatx_res, *dmarx_res;
-	struct s3c_audio_pdata *pcm_pdata;
-	int ret;
-
-	/* Check for valid device index */
-	if ((pdev->id < 0) || pdev->id >= ARRAY_SIZE(s3c_pcm)) {
-		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
-		return -EINVAL;
-	}
-
-	pcm_pdata = pdev->dev.platform_data;
-
-	/* Check for availability of necessary resource */
-	dmatx_res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmatx_res) {
-		dev_err(&pdev->dev, "Unable to get PCM-TX dma resource\n");
-		return -ENXIO;
-	}
-
-	dmarx_res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!dmarx_res) {
-		dev_err(&pdev->dev, "Unable to get PCM-RX dma resource\n");
-		return -ENXIO;
-	}
-
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res) {
-		dev_err(&pdev->dev, "Unable to get register resource\n");
-		return -ENXIO;
-	}
-
-	if (pcm_pdata && pcm_pdata->cfg_gpio && pcm_pdata->cfg_gpio(pdev)) {
-		dev_err(&pdev->dev, "Unable to configure gpio\n");
-		return -EINVAL;
-	}
-
-	pcm = &s3c_pcm[pdev->id];
-	pcm->dev = &pdev->dev;
-
-	spin_lock_init(&pcm->lock);
-
-	dai = &s3c_pcm_dai[pdev->id];
-	dai->dev = &pdev->dev;
-
-	/* Default is 128fs */
-	pcm->sclk_per_fs = 128;
-
-	pcm->cclk = clk_get(&pdev->dev, "audio-bus");
-	if (IS_ERR(pcm->cclk)) {
-		dev_err(&pdev->dev, "failed to get audio-bus\n");
-		ret = PTR_ERR(pcm->cclk);
-		goto err1;
-	}
-	clk_enable(pcm->cclk);
-
-	/* record our pcm structure for later use in the callbacks */
-	dai->private_data = pcm;
-
-	if (!request_mem_region(mem_res->start,
-				resource_size(mem_res), "samsung-pcm")) {
-		dev_err(&pdev->dev, "Unable to request register region\n");
-		ret = -EBUSY;
-		goto err2;
-	}
-
-	pcm->regs = ioremap(mem_res->start, 0x100);
-	if (pcm->regs == NULL) {
-		dev_err(&pdev->dev, "cannot ioremap registers\n");
-		ret = -ENXIO;
-		goto err3;
-	}
-
-	pcm->pclk = clk_get(&pdev->dev, "pcm");
-	if (IS_ERR(pcm->pclk)) {
-		dev_err(&pdev->dev, "failed to get pcm_clock\n");
-		ret = -ENOENT;
-		goto err4;
-	}
-	clk_enable(pcm->pclk);
-
-	ret = snd_soc_register_dai(dai);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "failed to get pcm_clock\n");
-		goto err5;
-	}
-
-	s3c_pcm_stereo_in[pdev->id].dma_addr = mem_res->start
-							+ S3C_PCM_RXFIFO;
-	s3c_pcm_stereo_out[pdev->id].dma_addr = mem_res->start
-							+ S3C_PCM_TXFIFO;
-
-	s3c_pcm_stereo_in[pdev->id].channel = dmarx_res->start;
-	s3c_pcm_stereo_out[pdev->id].channel = dmatx_res->start;
-
-	pcm->dma_capture = &s3c_pcm_stereo_in[pdev->id];
-	pcm->dma_playback = &s3c_pcm_stereo_out[pdev->id];
-
-	return 0;
-
-err5:
-	clk_disable(pcm->pclk);
-	clk_put(pcm->pclk);
-err4:
-	iounmap(pcm->regs);
-err3:
-	release_mem_region(mem_res->start, resource_size(mem_res));
-err2:
-	clk_disable(pcm->cclk);
-	clk_put(pcm->cclk);
-err1:
-	return ret;
-}
-
-static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
-{
-	struct s3c_pcm_info *pcm = &s3c_pcm[pdev->id];
-	struct resource *mem_res;
-
-	iounmap(pcm->regs);
-
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem_res->start, resource_size(mem_res));
-
-	clk_disable(pcm->cclk);
-	clk_disable(pcm->pclk);
-	clk_put(pcm->pclk);
-	clk_put(pcm->cclk);
-
-	return 0;
-}
-
-static struct platform_driver s3c_pcm_driver = {
-	.probe  = s3c_pcm_dev_probe,
-	.remove = s3c_pcm_dev_remove,
-	.driver = {
-		.name = "samsung-pcm",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init s3c_pcm_init(void)
-{
-	return platform_driver_register(&s3c_pcm_driver);
-}
-module_init(s3c_pcm_init);
-
-static void __exit s3c_pcm_exit(void)
-{
-	platform_driver_unregister(&s3c_pcm_driver);
-}
-module_exit(s3c_pcm_exit);
-
-/* Module information */
-MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
-MODULE_DESCRIPTION("S3C PCM Controller Driver");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c-pcm.h b/sound/soc/s3c24xx/s3c-pcm.h
deleted file mode 100644
index 69ff997..0000000
--- a/sound/soc/s3c24xx/s3c-pcm.h
+++ /dev/null
@@ -1,123 +0,0 @@
-/*  sound/soc/s3c24xx/s3c-pcm.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#ifndef __S3C_PCM_H
-#define __S3C_PCM_H __FILE__
-
-/*Register Offsets */
-#define S3C_PCM_CTL	(0x00)
-#define S3C_PCM_CLKCTL	(0x04)
-#define S3C_PCM_TXFIFO	(0x08)
-#define S3C_PCM_RXFIFO	(0x0C)
-#define S3C_PCM_IRQCTL	(0x10)
-#define S3C_PCM_IRQSTAT	(0x14)
-#define S3C_PCM_FIFOSTAT	(0x18)
-#define S3C_PCM_CLRINT	(0x20)
-
-/* PCM_CTL Bit-Fields */
-#define S3C_PCM_CTL_TXDIPSTICK_MASK		(0x3f)
-#define S3C_PCM_CTL_TXDIPSTICK_SHIFT	(13)
-#define S3C_PCM_CTL_RXDIPSTICK_MSK		(0x3f<<7)
-#define S3C_PCM_CTL_TXDMA_EN		(0x1<<6)
-#define S3C_PCM_CTL_RXDMA_EN		(0x1<<5)
-#define S3C_PCM_CTL_TXMSB_AFTER_FSYNC	(0x1<<4)
-#define S3C_PCM_CTL_RXMSB_AFTER_FSYNC	(0x1<<3)
-#define S3C_PCM_CTL_TXFIFO_EN		(0x1<<2)
-#define S3C_PCM_CTL_RXFIFO_EN		(0x1<<1)
-#define S3C_PCM_CTL_ENABLE			(0x1<<0)
-
-/* PCM_CLKCTL Bit-Fields */
-#define S3C_PCM_CLKCTL_SERCLK_EN		(0x1<<19)
-#define S3C_PCM_CLKCTL_SERCLKSEL_PCLK	(0x1<<18)
-#define S3C_PCM_CLKCTL_SCLKDIV_MASK		(0x1ff)
-#define S3C_PCM_CLKCTL_SYNCDIV_MASK		(0x1ff)
-#define S3C_PCM_CLKCTL_SCLKDIV_SHIFT	(9)
-#define S3C_PCM_CLKCTL_SYNCDIV_SHIFT	(0)
-
-/* PCM_TXFIFO Bit-Fields */
-#define S3C_PCM_TXFIFO_DVALID	(0x1<<16)
-#define S3C_PCM_TXFIFO_DATA_MSK	(0xffff<<0)
-
-/* PCM_RXFIFO Bit-Fields */
-#define S3C_PCM_RXFIFO_DVALID	(0x1<<16)
-#define S3C_PCM_RXFIFO_DATA_MSK	(0xffff<<0)
-
-/* PCM_IRQCTL Bit-Fields */
-#define S3C_PCM_IRQCTL_IRQEN		(0x1<<14)
-#define S3C_PCM_IRQCTL_WRDEN		(0x1<<12)
-#define S3C_PCM_IRQCTL_TXEMPTYEN		(0x1<<11)
-#define S3C_PCM_IRQCTL_TXALMSTEMPTYEN	(0x1<<10)
-#define S3C_PCM_IRQCTL_TXFULLEN		(0x1<<9)
-#define S3C_PCM_IRQCTL_TXALMSTFULLEN	(0x1<<8)
-#define S3C_PCM_IRQCTL_TXSTARVEN		(0x1<<7)
-#define S3C_PCM_IRQCTL_TXERROVRFLEN		(0x1<<6)
-#define S3C_PCM_IRQCTL_RXEMPTEN		(0x1<<5)
-#define S3C_PCM_IRQCTL_RXALMSTEMPTEN	(0x1<<4)
-#define S3C_PCM_IRQCTL_RXFULLEN		(0x1<<3)
-#define S3C_PCM_IRQCTL_RXALMSTFULLEN	(0x1<<2)
-#define S3C_PCM_IRQCTL_RXSTARVEN		(0x1<<1)
-#define S3C_PCM_IRQCTL_RXERROVRFLEN		(0x1<<0)
-
-/* PCM_IRQSTAT Bit-Fields */
-#define S3C_PCM_IRQSTAT_IRQPND		(0x1<<13)
-#define S3C_PCM_IRQSTAT_WRD_XFER		(0x1<<12)
-#define S3C_PCM_IRQSTAT_TXEMPTY		(0x1<<11)
-#define S3C_PCM_IRQSTAT_TXALMSTEMPTY	(0x1<<10)
-#define S3C_PCM_IRQSTAT_TXFULL		(0x1<<9)
-#define S3C_PCM_IRQSTAT_TXALMSTFULL		(0x1<<8)
-#define S3C_PCM_IRQSTAT_TXSTARV		(0x1<<7)
-#define S3C_PCM_IRQSTAT_TXERROVRFL		(0x1<<6)
-#define S3C_PCM_IRQSTAT_RXEMPT		(0x1<<5)
-#define S3C_PCM_IRQSTAT_RXALMSTEMPT		(0x1<<4)
-#define S3C_PCM_IRQSTAT_RXFULL		(0x1<<3)
-#define S3C_PCM_IRQSTAT_RXALMSTFULL		(0x1<<2)
-#define S3C_PCM_IRQSTAT_RXSTARV		(0x1<<1)
-#define S3C_PCM_IRQSTAT_RXERROVRFL		(0x1<<0)
-
-/* PCM_FIFOSTAT Bit-Fields */
-#define S3C_PCM_FIFOSTAT_TXCNT_MSK		(0x3f<<14)
-#define S3C_PCM_FIFOSTAT_TXFIFOEMPTY	(0x1<<13)
-#define S3C_PCM_FIFOSTAT_TXFIFOALMSTEMPTY	(0x1<<12)
-#define S3C_PCM_FIFOSTAT_TXFIFOFULL		(0x1<<11)
-#define S3C_PCM_FIFOSTAT_TXFIFOALMSTFULL	(0x1<<10)
-#define S3C_PCM_FIFOSTAT_RXCNT_MSK		(0x3f<<4)
-#define S3C_PCM_FIFOSTAT_RXFIFOEMPTY	(0x1<<3)
-#define S3C_PCM_FIFOSTAT_RXFIFOALMSTEMPTY	(0x1<<2)
-#define S3C_PCM_FIFOSTAT_RXFIFOFULL		(0x1<<1)
-#define S3C_PCM_FIFOSTAT_RXFIFOALMSTFULL	(0x1<<0)
-
-#define S3C_PCM_CLKSRC_PCLK	0
-#define S3C_PCM_CLKSRC_MUX	1
-
-#define S3C_PCM_SCLK_PER_FS	0
-
-/**
- * struct s3c_pcm_info - S3C PCM Controller information
- * @dev: The parent device passed to use from the probe.
- * @regs: The pointer to the device register block.
- * @dma_playback: DMA information for playback channel.
- * @dma_capture: DMA information for capture channel.
- */
-struct s3c_pcm_info {
-	spinlock_t lock;
-	struct device	*dev;
-	void __iomem	*regs;
-
-	unsigned int sclk_per_fs;
-
-	/* Whether to keep PCMSCLK enabled even when idle(no active xfer) */
-	unsigned int idleclk;
-
-	struct clk	*pclk;
-	struct clk	*cclk;
-
-	struct s3c_dma_params	*dma_playback;
-	struct s3c_dma_params	*dma_capture;
-};
-
-#endif /* __S3C_PCM_H */
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
deleted file mode 100644
index 709adef..0000000
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ /dev/null
@@ -1,190 +0,0 @@
-/* sound/soc/s3c24xx/s3c2412-i2s.c
- *
- * ALSA Soc Audio Layer - S3C2412 I2S driver
- *
- * Copyright (c) 2006 Wolfson Microelectronics PLC.
- *	Graeme Gregory graeme.gregory@wolfsonmicro.com
- *	linux@wolfsonmicro.com
- *
- * Copyright (c) 2007, 2004-2005 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/clk.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-#include <mach/hardware.h>
-
-#include <mach/regs-gpio.h>
-#include <mach/dma.h>
-
-#include "s3c-dma.h"
-#include "regs-i2s-v2.h"
-#include "s3c2412-i2s.h"
-
-#define S3C2412_I2S_DEBUG 0
-
-static struct s3c2410_dma_client s3c2412_dma_client_out = {
-	.name		= "I2S PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c2412_dma_client_in = {
-	.name		= "I2S PCM Stereo in"
-};
-
-static struct s3c_dma_params s3c2412_i2s_pcm_stereo_out = {
-	.client		= &s3c2412_dma_client_out,
-	.channel	= DMACH_I2S_OUT,
-	.dma_addr	= S3C2410_PA_IIS + S3C2412_IISTXD,
-	.dma_size	= 4,
-};
-
-static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
-	.client		= &s3c2412_dma_client_in,
-	.channel	= DMACH_I2S_IN,
-	.dma_addr	= S3C2410_PA_IIS + S3C2412_IISRXD,
-	.dma_size	= 4,
-};
-
-static struct s3c_i2sv2_info s3c2412_i2s;
-
-static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-{
-	return cpu_dai->private_data;
-}
-
-static int s3c2412_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
-{
-	int ret;
-
-	pr_debug("Entered %s\n", __func__);
-
-	ret = s3c_i2sv2_probe(pdev, dai, &s3c2412_i2s, S3C2410_PA_IIS);
-	if (ret)
-		return ret;
-
-	s3c2412_i2s.dma_capture = &s3c2412_i2s_pcm_stereo_in;
-	s3c2412_i2s.dma_playback = &s3c2412_i2s_pcm_stereo_out;
-
-	s3c2412_i2s.iis_cclk = clk_get(&pdev->dev, "i2sclk");
-	if (s3c2412_i2s.iis_cclk == NULL) {
-		pr_err("failed to get i2sclk clock\n");
-		iounmap(s3c2412_i2s.regs);
-		return -ENODEV;
-	}
-
-	/* Set MPLL as the source for IIS CLK */
-
-	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
-	clk_enable(s3c2412_i2s.iis_cclk);
-
-	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
-
-	/* Configure the I2S pins in correct mode */
-	s3c2410_gpio_cfgpin(S3C2410_GPE0, S3C2410_GPE0_I2SLRCK);
-	s3c2410_gpio_cfgpin(S3C2410_GPE1, S3C2410_GPE1_I2SSCLK);
-	s3c2410_gpio_cfgpin(S3C2410_GPE2, S3C2410_GPE2_CDCLK);
-	s3c2410_gpio_cfgpin(S3C2410_GPE3, S3C2410_GPE3_I2SSDI);
-	s3c2410_gpio_cfgpin(S3C2410_GPE4, S3C2410_GPE4_I2SSDO);
-
-	return 0;
-}
-
-static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *cpu_dai)
-{
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
-	struct s3c_dma_params *dma_data;
-	u32 iismod;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = i2s->dma_playback;
-	else
-		dma_data = i2s->dma_capture;
-
-	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
-
-	iismod = readl(i2s->regs + S3C2412_IISMOD);
-	pr_debug("%s: r: IISMOD: %x\n", __func__, iismod);
-
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		iismod |= S3C2412_IISMOD_8BIT;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		iismod &= ~S3C2412_IISMOD_8BIT;
-		break;
-	}
-
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-	pr_debug("%s: w: IISMOD: %x\n", __func__, iismod);
-
-	return 0;
-}
-
-#define S3C2412_I2S_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-static struct snd_soc_dai_ops s3c2412_i2s_dai_ops = {
-	.hw_params	= s3c2412_i2s_hw_params,
-};
-
-struct snd_soc_dai s3c2412_i2s_dai = {
-	.name		= "s3c2412-i2s",
-	.id		= 0,
-	.probe		= s3c2412_i2s_probe,
-	.playback = {
-		.channels_min	= 2,
-		.channels_max	= 2,
-		.rates		= S3C2412_I2S_RATES,
-		.formats	= SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.capture = {
-		.channels_min	= 2,
-		.channels_max	= 2,
-		.rates		= S3C2412_I2S_RATES,
-		.formats	= SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.ops = &s3c2412_i2s_dai_ops,
-};
-EXPORT_SYMBOL_GPL(s3c2412_i2s_dai);
-
-static int __init s3c2412_i2s_init(void)
-{
-	return  s3c_i2sv2_register_dai(&s3c2412_i2s_dai);
-}
-module_init(s3c2412_i2s_init);
-
-static void __exit s3c2412_i2s_exit(void)
-{
-	snd_soc_unregister_dai(&s3c2412_i2s_dai);
-}
-module_exit(s3c2412_i2s_exit);
-
-/* Module information */
-MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("S3C2412 I2S SoC Interface");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.h b/sound/soc/s3c24xx/s3c2412-i2s.h
deleted file mode 100644
index 0b5686b..0000000
--- a/sound/soc/s3c24xx/s3c2412-i2s.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* sound/soc/s3c24xx/s3c2412-i2s.c
- *
- * ALSA Soc Audio Layer - S3C2412 I2S driver
- *
- * Copyright (c) 2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
-*/
-
-#ifndef __SND_SOC_S3C24XX_S3C2412_I2S_H
-#define __SND_SOC_S3C24XX_S3C2412_I2S_H __FILE__
-
-#include "s3c-i2s-v2.h"
-
-#define S3C2412_DIV_BCLK	S3C_I2SV2_DIV_BCLK
-#define S3C2412_DIV_RCLK	S3C_I2SV2_DIV_RCLK
-#define S3C2412_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
-
-#define S3C2412_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
-#define S3C2412_CLKSRC_I2SCLK	S3C_I2SV2_CLKSRC_AUDIOBUS
-
-extern struct snd_soc_dai s3c2412_i2s_dai;
-
-#endif /* __SND_SOC_S3C24XX_S3C2412_I2S_H */
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
deleted file mode 100644
index c3ac890..0000000
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ /dev/null
@@ -1,503 +0,0 @@
-/*
- * s3c24xx-i2s.c  --  ALSA Soc Audio Layer
- *
- * (c) 2006 Wolfson Microelectronics PLC.
- * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
- *
- * Copyright 2004-2005 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/jiffies.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include <mach/hardware.h>
-#include <mach/regs-gpio.h>
-#include <mach/regs-clock.h>
-
-#include <asm/dma.h>
-#include <mach/dma.h>
-
-#include <plat/regs-iis.h>
-
-#include "s3c-dma.h"
-#include "s3c24xx-i2s.h"
-
-static struct s3c2410_dma_client s3c24xx_dma_client_out = {
-	.name = "I2S PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c24xx_dma_client_in = {
-	.name = "I2S PCM Stereo in"
-};
-
-static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_out = {
-	.client		= &s3c24xx_dma_client_out,
-	.channel	= DMACH_I2S_OUT,
-	.dma_addr	= S3C2410_PA_IIS + S3C2410_IISFIFO,
-	.dma_size	= 2,
-};
-
-static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_in = {
-	.client		= &s3c24xx_dma_client_in,
-	.channel	= DMACH_I2S_IN,
-	.dma_addr	= S3C2410_PA_IIS + S3C2410_IISFIFO,
-	.dma_size	= 2,
-};
-
-struct s3c24xx_i2s_info {
-	void __iomem	*regs;
-	struct clk	*iis_clk;
-	u32		iiscon;
-	u32		iismod;
-	u32		iisfcon;
-	u32		iispsr;
-};
-static struct s3c24xx_i2s_info s3c24xx_i2s;
-
-static void s3c24xx_snd_txctrl(int on)
-{
-	u32 iisfcon;
-	u32 iiscon;
-	u32 iismod;
-
-	pr_debug("Entered %s\n", __func__);
-
-	iisfcon = readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
-	iiscon  = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
-	iismod  = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
-
-	pr_debug("r: IISCON: %x IISMOD: %x IISFCON: %x\n", iiscon, iismod, iisfcon);
-
-	if (on) {
-		iisfcon |= S3C2410_IISFCON_TXDMA | S3C2410_IISFCON_TXENABLE;
-		iiscon  |= S3C2410_IISCON_TXDMAEN | S3C2410_IISCON_IISEN;
-		iiscon  &= ~S3C2410_IISCON_TXIDLE;
-		iismod  |= S3C2410_IISMOD_TXMODE;
-
-		writel(iismod,  s3c24xx_i2s.regs + S3C2410_IISMOD);
-		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
-		writel(iiscon,  s3c24xx_i2s.regs + S3C2410_IISCON);
-	} else {
-		/* note, we have to disable the FIFOs otherwise bad things
-		 * seem to happen when the DMA stops. According to the
-		 * Samsung supplied kernel, this should allow the DMA
-		 * engine and FIFOs to reset. If this isn't allowed, the
-		 * DMA engine will simply freeze randomly.
-		 */
-
-		iisfcon &= ~S3C2410_IISFCON_TXENABLE;
-		iisfcon &= ~S3C2410_IISFCON_TXDMA;
-		iiscon  |=  S3C2410_IISCON_TXIDLE;
-		iiscon  &= ~S3C2410_IISCON_TXDMAEN;
-		iismod  &= ~S3C2410_IISMOD_TXMODE;
-
-		writel(iiscon,  s3c24xx_i2s.regs + S3C2410_IISCON);
-		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
-		writel(iismod,  s3c24xx_i2s.regs + S3C2410_IISMOD);
-	}
-
-	pr_debug("w: IISCON: %x IISMOD: %x IISFCON: %x\n", iiscon, iismod, iisfcon);
-}
-
-static void s3c24xx_snd_rxctrl(int on)
-{
-	u32 iisfcon;
-	u32 iiscon;
-	u32 iismod;
-
-	pr_debug("Entered %s\n", __func__);
-
-	iisfcon = readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
-	iiscon  = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
-	iismod  = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
-
-	pr_debug("r: IISCON: %x IISMOD: %x IISFCON: %x\n", iiscon, iismod, iisfcon);
-
-	if (on) {
-		iisfcon |= S3C2410_IISFCON_RXDMA | S3C2410_IISFCON_RXENABLE;
-		iiscon  |= S3C2410_IISCON_RXDMAEN | S3C2410_IISCON_IISEN;
-		iiscon  &= ~S3C2410_IISCON_RXIDLE;
-		iismod  |= S3C2410_IISMOD_RXMODE;
-
-		writel(iismod,  s3c24xx_i2s.regs + S3C2410_IISMOD);
-		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
-		writel(iiscon,  s3c24xx_i2s.regs + S3C2410_IISCON);
-	} else {
-		/* note, we have to disable the FIFOs otherwise bad things
-		 * seem to happen when the DMA stops. According to the
-		 * Samsung supplied kernel, this should allow the DMA
-		 * engine and FIFOs to reset. If this isn't allowed, the
-		 * DMA engine will simply freeze randomly.
-		 */
-
-		iisfcon &= ~S3C2410_IISFCON_RXENABLE;
-		iisfcon &= ~S3C2410_IISFCON_RXDMA;
-		iiscon  |= S3C2410_IISCON_RXIDLE;
-		iiscon  &= ~S3C2410_IISCON_RXDMAEN;
-		iismod  &= ~S3C2410_IISMOD_RXMODE;
-
-		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
-		writel(iiscon,  s3c24xx_i2s.regs + S3C2410_IISCON);
-		writel(iismod,  s3c24xx_i2s.regs + S3C2410_IISMOD);
-	}
-
-	pr_debug("w: IISCON: %x IISMOD: %x IISFCON: %x\n", iiscon, iismod, iisfcon);
-}
-
-/*
- * Wait for the LR signal to allow synchronisation to the L/R clock
- * from the codec. May only be needed for slave mode.
- */
-static int s3c24xx_snd_lrsync(void)
-{
-	u32 iiscon;
-	int timeout = 50; /* 5ms */
-
-	pr_debug("Entered %s\n", __func__);
-
-	while (1) {
-		iiscon = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
-		if (iiscon & S3C2410_IISCON_LRINDEX)
-			break;
-
-		if (!timeout--)
-			return -ETIMEDOUT;
-		udelay(100);
-	}
-
-	return 0;
-}
-
-/*
- * Check whether CPU is the master or slave
- */
-static inline int s3c24xx_snd_is_clkmaster(void)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	return (readl(s3c24xx_i2s.regs + S3C2410_IISMOD) & S3C2410_IISMOD_SLAVE) ? 0:1;
-}
-
-/*
- * Set S3C24xx I2S DAI format
- */
-static int s3c24xx_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
-		unsigned int fmt)
-{
-	u32 iismod;
-
-	pr_debug("Entered %s\n", __func__);
-
-	iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
-	pr_debug("hw_params r: IISMOD: %x \n", iismod);
-
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
-		iismod |= S3C2410_IISMOD_SLAVE;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
-		iismod &= ~S3C2410_IISMOD_SLAVE;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_LEFT_J:
-		iismod |= S3C2410_IISMOD_MSB;
-		break;
-	case SND_SOC_DAIFMT_I2S:
-		iismod &= ~S3C2410_IISMOD_MSB;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	writel(iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
-	pr_debug("hw_params w: IISMOD: %x \n", iismod);
-	return 0;
-}
-
-static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_dma_params *dma_data;
-	u32 iismod;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = &s3c24xx_i2s_pcm_stereo_out;
-	else
-		dma_data = &s3c24xx_i2s_pcm_stereo_in;
-
-	snd_soc_dai_set_dma_data(rtd->dai->cpu_dai, substream, dma_data);
-
-	/* Working copies of register */
-	iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
-	pr_debug("hw_params r: IISMOD: %x\n", iismod);
-
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		iismod &= ~S3C2410_IISMOD_16BIT;
-		dma_data->dma_size = 1;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		iismod |= S3C2410_IISMOD_16BIT;
-		dma_data->dma_size = 2;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	writel(iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
-	pr_debug("hw_params w: IISMOD: %x\n", iismod);
-	return 0;
-}
-
-static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
-			       struct snd_soc_dai *dai)
-{
-	int ret = 0;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_dma_params *dma_data =
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
-
-	pr_debug("Entered %s\n", __func__);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!s3c24xx_snd_is_clkmaster()) {
-			ret = s3c24xx_snd_lrsync();
-			if (ret)
-				goto exit_err;
-		}
-
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			s3c24xx_snd_rxctrl(1);
-		else
-			s3c24xx_snd_txctrl(1);
-
-		s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			s3c24xx_snd_rxctrl(0);
-		else
-			s3c24xx_snd_txctrl(0);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-exit_err:
-	return ret;
-}
-
-/*
- * Set S3C24xx Clock source
- */
-static int s3c24xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
-	int clk_id, unsigned int freq, int dir)
-{
-	u32 iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
-
-	pr_debug("Entered %s\n", __func__);
-
-	iismod &= ~S3C2440_IISMOD_MPLL;
-
-	switch (clk_id) {
-	case S3C24XX_CLKSRC_PCLK:
-		break;
-	case S3C24XX_CLKSRC_MPLL:
-		iismod |= S3C2440_IISMOD_MPLL;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	writel(iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
-	return 0;
-}
-
-/*
- * Set S3C24xx Clock dividers
- */
-static int s3c24xx_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
-	int div_id, int div)
-{
-	u32 reg;
-
-	pr_debug("Entered %s\n", __func__);
-
-	switch (div_id) {
-	case S3C24XX_DIV_BCLK:
-		reg = readl(s3c24xx_i2s.regs + S3C2410_IISMOD) & ~S3C2410_IISMOD_FS_MASK;
-		writel(reg | div, s3c24xx_i2s.regs + S3C2410_IISMOD);
-		break;
-	case S3C24XX_DIV_MCLK:
-		reg = readl(s3c24xx_i2s.regs + S3C2410_IISMOD) & ~(S3C2410_IISMOD_384FS);
-		writel(reg | div, s3c24xx_i2s.regs + S3C2410_IISMOD);
-		break;
-	case S3C24XX_DIV_PRESCALER:
-		writel(div, s3c24xx_i2s.regs + S3C2410_IISPSR);
-		reg = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
-		writel(reg | S3C2410_IISCON_PSCEN, s3c24xx_i2s.regs + S3C2410_IISCON);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/*
- * To avoid duplicating clock code, allow machine driver to
- * get the clockrate from here.
- */
-u32 s3c24xx_i2s_get_clockrate(void)
-{
-	return clk_get_rate(s3c24xx_i2s.iis_clk);
-}
-EXPORT_SYMBOL_GPL(s3c24xx_i2s_get_clockrate);
-
-static int s3c24xx_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	s3c24xx_i2s.regs = ioremap(S3C2410_PA_IIS, 0x100);
-	if (s3c24xx_i2s.regs == NULL)
-		return -ENXIO;
-
-	s3c24xx_i2s.iis_clk = clk_get(&pdev->dev, "iis");
-	if (s3c24xx_i2s.iis_clk == NULL) {
-		pr_err("failed to get iis_clock\n");
-		iounmap(s3c24xx_i2s.regs);
-		return -ENODEV;
-	}
-	clk_enable(s3c24xx_i2s.iis_clk);
-
-	/* Configure the I2S pins in correct mode */
-	s3c2410_gpio_cfgpin(S3C2410_GPE0, S3C2410_GPE0_I2SLRCK);
-	s3c2410_gpio_cfgpin(S3C2410_GPE1, S3C2410_GPE1_I2SSCLK);
-	s3c2410_gpio_cfgpin(S3C2410_GPE2, S3C2410_GPE2_CDCLK);
-	s3c2410_gpio_cfgpin(S3C2410_GPE3, S3C2410_GPE3_I2SSDI);
-	s3c2410_gpio_cfgpin(S3C2410_GPE4, S3C2410_GPE4_I2SSDO);
-
-	writel(S3C2410_IISCON_IISEN, s3c24xx_i2s.regs + S3C2410_IISCON);
-
-	s3c24xx_snd_txctrl(0);
-	s3c24xx_snd_rxctrl(0);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int s3c24xx_i2s_suspend(struct snd_soc_dai *cpu_dai)
-{
-	pr_debug("Entered %s\n", __func__);
-
-	s3c24xx_i2s.iiscon = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
-	s3c24xx_i2s.iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
-	s3c24xx_i2s.iisfcon = readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
-	s3c24xx_i2s.iispsr = readl(s3c24xx_i2s.regs + S3C2410_IISPSR);
-
-	clk_disable(s3c24xx_i2s.iis_clk);
-
-	return 0;
-}
-
-static int s3c24xx_i2s_resume(struct snd_soc_dai *cpu_dai)
-{
-	pr_debug("Entered %s\n", __func__);
-	clk_enable(s3c24xx_i2s.iis_clk);
-
-	writel(s3c24xx_i2s.iiscon, s3c24xx_i2s.regs + S3C2410_IISCON);
-	writel(s3c24xx_i2s.iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
-	writel(s3c24xx_i2s.iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
-	writel(s3c24xx_i2s.iispsr, s3c24xx_i2s.regs + S3C2410_IISPSR);
-
-	return 0;
-}
-#else
-#define s3c24xx_i2s_suspend NULL
-#define s3c24xx_i2s_resume NULL
-#endif
-
-
-#define S3C24XX_I2S_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-static struct snd_soc_dai_ops s3c24xx_i2s_dai_ops = {
-	.trigger	= s3c24xx_i2s_trigger,
-	.hw_params	= s3c24xx_i2s_hw_params,
-	.set_fmt	= s3c24xx_i2s_set_fmt,
-	.set_clkdiv	= s3c24xx_i2s_set_clkdiv,
-	.set_sysclk	= s3c24xx_i2s_set_sysclk,
-};
-
-struct snd_soc_dai s3c24xx_i2s_dai = {
-	.name = "s3c24xx-i2s",
-	.id = 0,
-	.probe = s3c24xx_i2s_probe,
-	.suspend = s3c24xx_i2s_suspend,
-	.resume = s3c24xx_i2s_resume,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = S3C24XX_I2S_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = S3C24XX_I2S_RATES,
-		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = &s3c24xx_i2s_dai_ops,
-};
-EXPORT_SYMBOL_GPL(s3c24xx_i2s_dai);
-
-static int __init s3c24xx_i2s_init(void)
-{
-	return snd_soc_register_dai(&s3c24xx_i2s_dai);
-}
-module_init(s3c24xx_i2s_init);
-
-static void __exit s3c24xx_i2s_exit(void)
-{
-	snd_soc_unregister_dai(&s3c24xx_i2s_dai);
-}
-module_exit(s3c24xx_i2s_exit);
-
-/* Module information */
-MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("s3c24xx I2S SoC Interface");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.h b/sound/soc/s3c24xx/s3c24xx-i2s.h
deleted file mode 100644
index 726d91c..0000000
--- a/sound/soc/s3c24xx/s3c24xx-i2s.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * s3c24xx-i2s.c  --  ALSA Soc Audio Layer
- *
- * Copyright 2005 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory
- *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  Revision history
- *    10th Nov 2006   Initial version.
- */
-
-#ifndef S3C24XXI2S_H_
-#define S3C24XXI2S_H_
-
-/* clock sources */
-#define S3C24XX_CLKSRC_PCLK 0
-#define S3C24XX_CLKSRC_MPLL 1
-
-/* Clock dividers */
-#define S3C24XX_DIV_MCLK	0
-#define S3C24XX_DIV_BCLK	1
-#define S3C24XX_DIV_PRESCALER	2
-
-/* prescaler */
-#define S3C24XX_PRESCALE(a,b) \
-	(((a - 1) << S3C2410_IISPSR_INTSHIFT) | ((b - 1) << S3C2410_IISPSR_EXTSHFIT))
-
-u32 s3c24xx_i2s_get_clockrate(void);
-
-extern struct snd_soc_dai s3c24xx_i2s_dai;
-
-#endif /*S3C24XXI2S_H_*/
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.c b/sound/soc/s3c24xx/s3c24xx_simtec.c
deleted file mode 100644
index 4984754..0000000
--- a/sound/soc/s3c24xx/s3c24xx_simtec.c
+++ /dev/null
@@ -1,394 +0,0 @@
-/* sound/soc/s3c24xx/s3c24xx_simtec.c
- *
- * Copyright 2009 Simtec Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/clk.h>
-#include <linux/i2c.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include <plat/audio-simtec.h>
-
-#include "s3c-dma.h"
-#include "s3c24xx-i2s.h"
-#include "s3c24xx_simtec.h"
-
-static struct s3c24xx_audio_simtec_pdata *pdata;
-static struct clk *xtal_clk;
-
-static int spk_gain;
-static int spk_unmute;
-
-/**
- * speaker_gain_get - read the speaker gain setting.
- * @kcontrol: The control for the speaker gain.
- * @ucontrol: The value that needs to be updated.
- *
- * Read the value for the AMP gain control.
- */
-static int speaker_gain_get(struct snd_kcontrol *kcontrol,
-			    struct snd_ctl_elem_value *ucontrol)
-{
-	ucontrol->value.integer.value[0] = spk_gain;
-	return 0;
-}
-
-/**
- * speaker_gain_set - set the value of the speaker amp gain
- * @value: The value to write.
- */
-static void speaker_gain_set(int value)
-{
-	gpio_set_value_cansleep(pdata->amp_gain[0], value & 1);
-	gpio_set_value_cansleep(pdata->amp_gain[1], value >> 1);
-}
-
-/**
- * speaker_gain_put - set the speaker gain setting.
- * @kcontrol: The control for the speaker gain.
- * @ucontrol: The value that needs to be set.
- *
- * Set the value of the speaker gain from the specified
- * @ucontrol setting.
- *
- * Note, if the speaker amp is muted, then we do not set a gain value
- * as at-least one of the ICs that is fitted will try and power up even
- * if the main control is set to off.
- */
-static int speaker_gain_put(struct snd_kcontrol *kcontrol,
-			    struct snd_ctl_elem_value *ucontrol)
-{
-	int value = ucontrol->value.integer.value[0];
-
-	spk_gain = value;
-
-	if (!spk_unmute)
-		speaker_gain_set(value);
-
-	return 0;
-}
-
-static const struct snd_kcontrol_new amp_gain_controls[] = {
-	SOC_SINGLE_EXT("Speaker Gain", 0, 0, 3, 0,
-		       speaker_gain_get, speaker_gain_put),
-};
-
-/**
- * spk_unmute_state - set the unmute state of the speaker
- * @to: zero to unmute, non-zero to ununmute.
- */
-static void spk_unmute_state(int to)
-{
-	pr_debug("%s: to=%d\n", __func__, to);
-
-	spk_unmute = to;
-	gpio_set_value(pdata->amp_gpio, to);
-
-	/* if we're umuting, also re-set the gain */
-	if (to && pdata->amp_gain[0] > 0)
-		speaker_gain_set(spk_gain);
-}
-
-/**
- * speaker_unmute_get - read the speaker unmute setting.
- * @kcontrol: The control for the speaker gain.
- * @ucontrol: The value that needs to be updated.
- *
- * Read the value for the AMP gain control.
- */
-static int speaker_unmute_get(struct snd_kcontrol *kcontrol,
-			    struct snd_ctl_elem_value *ucontrol)
-{
-	ucontrol->value.integer.value[0] = spk_unmute;
-	return 0;
-}
-
-/**
- * speaker_unmute_put - set the speaker unmute setting.
- * @kcontrol: The control for the speaker gain.
- * @ucontrol: The value that needs to be set.
- *
- * Set the value of the speaker gain from the specified
- * @ucontrol setting.
- */
-static int speaker_unmute_put(struct snd_kcontrol *kcontrol,
-			    struct snd_ctl_elem_value *ucontrol)
-{
-	spk_unmute_state(ucontrol->value.integer.value[0]);
-	return 0;
-}
-
-/* This is added as a manual control as the speaker amps create clicks
- * when their power state is changed, which are far more noticeable than
- * anything produced by the CODEC itself.
- */
-static const struct snd_kcontrol_new amp_unmute_controls[] = {
-	SOC_SINGLE_EXT("Speaker Switch", 0, 0, 1, 0,
-		       speaker_unmute_get, speaker_unmute_put),
-};
-
-void simtec_audio_init(struct snd_soc_codec *codec)
-{
-	if (pdata->amp_gpio > 0) {
-		pr_debug("%s: adding amp routes\n", __func__);
-
-		snd_soc_add_controls(codec, amp_unmute_controls,
-				     ARRAY_SIZE(amp_unmute_controls));
-	}
-
-	if (pdata->amp_gain[0] > 0) {
-		pr_debug("%s: adding amp controls\n", __func__);
-		snd_soc_add_controls(codec, amp_gain_controls,
-				     ARRAY_SIZE(amp_gain_controls));
-	}
-}
-EXPORT_SYMBOL_GPL(simtec_audio_init);
-
-#define CODEC_CLOCK 12000000
-
-/**
- * simtec_hw_params - update hardware parameters
- * @substream: The audio substream instance.
- * @params: The parameters requested.
- *
- * Update the codec data routing and configuration  settings
- * from the supplied data.
- */
-static int simtec_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	int ret;
-
-	/* Set the CODEC as the bus clock master, I2S */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		pr_err("%s: failed set cpu dai format\n", __func__);
-		return ret;
-	}
-
-	/* Set the CODEC as the bus clock master */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		pr_err("%s: failed set codec dai format\n", __func__);
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
-				     CODEC_CLOCK, SND_SOC_CLOCK_IN);
-	if (ret) {
-		pr_err( "%s: failed setting codec sysclk\n", __func__);
-		return ret;
-	}
-
-	if (pdata->use_mpllin) {
-		ret = snd_soc_dai_set_sysclk(cpu_dai, S3C24XX_CLKSRC_MPLL,
-					     0, SND_SOC_CLOCK_OUT);
-
-		if (ret) {
-			pr_err("%s: failed to set MPLLin as clksrc\n",
-			       __func__);
-			return ret;
-		}
-	}
-
-	if (pdata->output_cdclk) {
-		int cdclk_scale;
-
-		cdclk_scale = clk_get_rate(xtal_clk) / CODEC_CLOCK;
-		cdclk_scale--;
-
-		ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
-					     cdclk_scale);
-	}
-
-	return 0;
-}
-
-static int simtec_call_startup(struct s3c24xx_audio_simtec_pdata *pd)
-{
-	/* call any board supplied startup code, this currently only
-	 * covers the bast/vr1000 which have a CPLD in the way of the
-	 * LRCLK */
-	if (pd->startup)
-		pd->startup();
-
-	return 0;
-}
-
-static struct snd_soc_ops simtec_snd_ops = {
-	.hw_params	= simtec_hw_params,
-};
-
-/**
- * attach_gpio_amp - get and configure the necessary gpios
- * @dev: The device we're probing.
- * @pd: The platform data supplied by the board.
- *
- * If there is a GPIO based amplifier attached to the board, claim
- * the necessary GPIO lines for it, and set default values.
- */
-static int attach_gpio_amp(struct device *dev,
-			   struct s3c24xx_audio_simtec_pdata *pd)
-{
-	int ret;
-
-	/* attach gpio amp gain (if any) */
-	if (pdata->amp_gain[0] > 0) {
-		ret = gpio_request(pd->amp_gain[0], "gpio-amp-gain0");
-		if (ret) {
-			dev_err(dev, "cannot get amp gpio gain0\n");
-			return ret;
-		}
-
-		ret = gpio_request(pd->amp_gain[1], "gpio-amp-gain1");
-		if (ret) {
-			dev_err(dev, "cannot get amp gpio gain1\n");
-			gpio_free(pdata->amp_gain[0]);
-			return ret;
-		}
-
-		gpio_direction_output(pd->amp_gain[0], 0);
-		gpio_direction_output(pd->amp_gain[1], 0);
-	}
-
-	/* note, currently we assume GPA0 isn't valid amp */
-	if (pdata->amp_gpio > 0) {
-		ret = gpio_request(pd->amp_gpio, "gpio-amp");
-		if (ret) {
-			dev_err(dev, "cannot get amp gpio %d (%d)\n",
-				pd->amp_gpio, ret);
-			goto err_amp;
-		}
-
-		/* set the amp off at startup */
-		spk_unmute_state(0);
-	}
-
-	return 0;
-
-err_amp:
-	if (pd->amp_gain[0] > 0) {
-		gpio_free(pd->amp_gain[0]);
-		gpio_free(pd->amp_gain[1]);
-	}
-
-	return ret;
-}
-
-static void detach_gpio_amp(struct s3c24xx_audio_simtec_pdata *pd)
-{
-	if (pd->amp_gain[0] > 0) {
-		gpio_free(pd->amp_gain[0]);
-		gpio_free(pd->amp_gain[1]);
-	}
-
-	if (pd->amp_gpio > 0)
-		gpio_free(pd->amp_gpio);
-}
-
-#ifdef CONFIG_PM
-int simtec_audio_resume(struct device *dev)
-{
-	simtec_call_startup(pdata);
-	return 0;
-}
-
-const struct dev_pm_ops simtec_audio_pmops = {
-	.resume	= simtec_audio_resume,
-};
-EXPORT_SYMBOL_GPL(simtec_audio_pmops);
-#endif
-
-int __devinit simtec_audio_core_probe(struct platform_device *pdev,
-				      struct snd_soc_device *socdev)
-{
-	struct platform_device *snd_dev;
-	int ret;
-
-	socdev->card->dai_link->ops = &simtec_snd_ops;
-
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data supplied\n");
-		return -EINVAL;
-	}
-
-	simtec_call_startup(pdata);
-
-	xtal_clk = clk_get(&pdev->dev, "xtal");
-	if (IS_ERR(xtal_clk)) {
-		dev_err(&pdev->dev, "could not get clkout0\n");
-		return -EINVAL;
-	}
-
-	dev_info(&pdev->dev, "xtal rate is %ld\n", clk_get_rate(xtal_clk));
-
-	ret = attach_gpio_amp(&pdev->dev, pdata);
-	if (ret)
-		goto err_clk;
-
-	snd_dev = platform_device_alloc("soc-audio", -1);
-	if (!snd_dev) {
-		dev_err(&pdev->dev, "failed to alloc soc-audio devicec\n");
-		ret = -ENOMEM;
-		goto err_gpio;
-	}
-
-	platform_set_drvdata(snd_dev, socdev);
-	socdev->dev = &snd_dev->dev;
-
-	ret = platform_device_add(snd_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add soc-audio dev\n");
-		goto err_pdev;
-	}
-
-	platform_set_drvdata(pdev, snd_dev);
-	return 0;
-
-err_pdev:
-	platform_device_put(snd_dev);
-
-err_gpio:
-	detach_gpio_amp(pdata);
-
-err_clk:
-	clk_put(xtal_clk);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(simtec_audio_core_probe);
-
-int __devexit simtec_audio_remove(struct platform_device *pdev)
-{
-	struct platform_device *snd_dev = platform_get_drvdata(pdev);
-
-	platform_device_unregister(snd_dev);
-
-	detach_gpio_amp(pdata);
-	clk_put(xtal_clk);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(simtec_audio_remove);
-
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("ALSA SoC Simtec Audio common support");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.h b/sound/soc/s3c24xx/s3c24xx_simtec.h
deleted file mode 100644
index e18faee..0000000
--- a/sound/soc/s3c24xx/s3c24xx_simtec.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* sound/soc/s3c24xx/s3c24xx_simtec.h
- *
- * Copyright 2009 Simtec Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-extern void simtec_audio_init(struct snd_soc_codec *codec);
-
-extern int simtec_audio_core_probe(struct platform_device *pdev,
-				   struct snd_soc_device *socdev);
-
-extern int simtec_audio_remove(struct platform_device *pdev);
-
-#ifdef CONFIG_PM
-extern const struct dev_pm_ops simtec_audio_pmops;
-#define simtec_audio_pm &simtec_audio_pmops
-#else
-#define simtec_audio_pm NULL
-#endif
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
deleted file mode 100644
index bdf8951..0000000
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ /dev/null
@@ -1,153 +0,0 @@
-/* sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
- *
- * Copyright 2009 Simtec Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include <plat/audio-simtec.h>
-
-#include "s3c-dma.h"
-#include "s3c24xx-i2s.h"
-#include "s3c24xx_simtec.h"
-
-#include "../codecs/tlv320aic3x.h"
-
-static const struct snd_soc_dapm_widget dapm_widgets[] = {
-	SND_SOC_DAPM_LINE("GSM Out", NULL),
-	SND_SOC_DAPM_LINE("GSM In", NULL),
-	SND_SOC_DAPM_LINE("Line In", NULL),
-	SND_SOC_DAPM_LINE("Line Out", NULL),
-	SND_SOC_DAPM_LINE("ZV", NULL),
-	SND_SOC_DAPM_MIC("Mic Jack", NULL),
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-};
-
-static const struct snd_soc_dapm_route base_map[] = {
-	/* Headphone connected to HP{L,R}OUT and HP{L,R}COM */
-
-	{ "Headphone Jack", NULL, "HPLOUT" },
-	{ "Headphone Jack", NULL, "HPLCOM" },
-	{ "Headphone Jack", NULL, "HPROUT" },
-	{ "Headphone Jack", NULL, "HPRCOM" },
-
-	/* ZV connected to Line1 */
-
-	{ "LINE1L", NULL, "ZV" },
-	{ "LINE1R", NULL, "ZV" },
-
-	/* Line In connected to Line2 */
-
-	{ "LINE2L", NULL, "Line In" },
-	{ "LINE2R", NULL, "Line In" },
-
-	/* Microphone connected to MIC3R and MIC_BIAS */
-
-	{ "MIC3L", NULL, "Mic Jack" },
-
-	/* GSM connected to MONO_LOUT and MIC3L (in) */
-
-	{ "GSM Out", NULL, "MONO_LOUT" },
-	{ "MIC3L", NULL, "GSM In" },
-
-	/* Speaker is connected to LINEOUT{LN,LP,RN,RP}, however we are
-	 * not using the DAPM to power it up and down as there it makes
-	 * a click when powering up. */
-};
-
-/**
- * simtec_hermes_init - initialise and add controls
- * @codec; The codec instance to attach to.
- *
- * Attach our controls and configure the necessary codec
- * mappings for our sound card instance.
-*/
-static int simtec_hermes_init(struct snd_soc_codec *codec)
-{
-	snd_soc_dapm_new_controls(codec, dapm_widgets,
-				  ARRAY_SIZE(dapm_widgets));
-
-	snd_soc_dapm_add_routes(codec, base_map, ARRAY_SIZE(base_map));
-
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Line In");
-	snd_soc_dapm_enable_pin(codec, "Line Out");
-	snd_soc_dapm_enable_pin(codec, "Mic Jack");
-
-	simtec_audio_init(codec);
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static struct aic3x_setup_data codec_setup = {
-};
-
-static struct snd_soc_dai_link simtec_dai_aic33 = {
-	.name		= "tlv320aic33",
-	.stream_name	= "TLV320AIC33",
-	.cpu_dai	= &s3c24xx_i2s_dai,
-	.codec_dai	= &aic3x_dai,
-	.init		= simtec_hermes_init,
-};
-
-/* simtec audio machine driver */
-static struct snd_soc_card snd_soc_machine_simtec_aic33 = {
-	.name		= "Simtec-Hermes",
-	.platform	= &s3c24xx_soc_platform,
-	.dai_link	= &simtec_dai_aic33,
-	.num_links	= 1,
-};
-
-/* simtec audio subsystem */
-static struct snd_soc_device simtec_snd_devdata_aic33 = {
-	.card		= &snd_soc_machine_simtec_aic33,
-	.codec_dev	= &soc_codec_dev_aic3x,
-	.codec_data	= &codec_setup,
-};
-
-static int __devinit simtec_audio_hermes_probe(struct platform_device *pd)
-{
-	dev_info(&pd->dev, "probing....\n");
-	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic33);
-}
-
-static struct platform_driver simtec_audio_hermes_platdrv = {
-	.driver	= {
-		.owner	= THIS_MODULE,
-		.name	= "s3c24xx-simtec-hermes-snd",
-		.pm	= simtec_audio_pm,
-	},
-	.probe	= simtec_audio_hermes_probe,
-	.remove	= __devexit_p(simtec_audio_remove),
-};
-
-MODULE_ALIAS("platform:s3c24xx-simtec-hermes-snd");
-
-static int __init simtec_hermes_modinit(void)
-{
-	return platform_driver_register(&simtec_audio_hermes_platdrv);
-}
-
-static void __exit simtec_hermes_modexit(void)
-{
-	platform_driver_unregister(&simtec_audio_hermes_platdrv);
-}
-
-module_init(simtec_hermes_modinit);
-module_exit(simtec_hermes_modexit);
-
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
deleted file mode 100644
index 185c0ac..0000000
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/* sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
- *
- * Copyright 2009 Simtec Electronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include <plat/audio-simtec.h>
-
-#include "s3c-dma.h"
-#include "s3c24xx-i2s.h"
-#include "s3c24xx_simtec.h"
-
-#include "../codecs/tlv320aic23.h"
-
-/* supported machines:
- *
- * Machine	Connections		AMP
- * -------	-----------		---
- * BAST		MIC, HPOUT, LOUT, LIN	TPA2001D1 (HPOUTL,R) (gain hardwired)
- * VR1000	HPOUT, LIN		None
- * VR2000	LIN, LOUT, MIC, HP	LM4871 (HPOUTL,R)
- * DePicture	LIN, LOUT, MIC, HP	LM4871 (HPOUTL,R)
- * Anubis	LIN, LOUT, MIC, HP	TPA2001D1 (HPOUTL,R)
- */
-
-static const struct snd_soc_dapm_widget dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_LINE("Line In", NULL),
-	SND_SOC_DAPM_LINE("Line Out", NULL),
-	SND_SOC_DAPM_MIC("Mic Jack", NULL),
-};
-
-static const struct snd_soc_dapm_route base_map[] = {
-	{ "Headphone Jack", NULL, "LHPOUT"},
-	{ "Headphone Jack", NULL, "RHPOUT"},
-
-	{ "Line Out", NULL, "LOUT" },
-	{ "Line Out", NULL, "ROUT" },
-
-	{ "LLINEIN", NULL, "Line In"},
-	{ "RLINEIN", NULL, "Line In"},
-
-	{ "MICIN", NULL, "Mic Jack"},
-};
-
-/**
- * simtec_tlv320aic23_init - initialise and add controls
- * @codec; The codec instance to attach to.
- *
- * Attach our controls and configure the necessary codec
- * mappings for our sound card instance.
-*/
-static int simtec_tlv320aic23_init(struct snd_soc_codec *codec)
-{
-	snd_soc_dapm_new_controls(codec, dapm_widgets,
-				  ARRAY_SIZE(dapm_widgets));
-
-	snd_soc_dapm_add_routes(codec, base_map, ARRAY_SIZE(base_map));
-
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Line In");
-	snd_soc_dapm_enable_pin(codec, "Line Out");
-	snd_soc_dapm_enable_pin(codec, "Mic Jack");
-
-	simtec_audio_init(codec);
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static struct snd_soc_dai_link simtec_dai_aic23 = {
-	.name		= "tlv320aic23",
-	.stream_name	= "TLV320AIC23",
-	.cpu_dai	= &s3c24xx_i2s_dai,
-	.codec_dai	= &tlv320aic23_dai,
-	.init		= simtec_tlv320aic23_init,
-};
-
-/* simtec audio machine driver */
-static struct snd_soc_card snd_soc_machine_simtec_aic23 = {
-	.name		= "Simtec",
-	.platform	= &s3c24xx_soc_platform,
-	.dai_link	= &simtec_dai_aic23,
-	.num_links	= 1,
-};
-
-/* simtec audio subsystem */
-static struct snd_soc_device simtec_snd_devdata_aic23 = {
-	.card		= &snd_soc_machine_simtec_aic23,
-	.codec_dev	= &soc_codec_dev_tlv320aic23,
-};
-
-static int __devinit simtec_audio_tlv320aic23_probe(struct platform_device *pd)
-{
-	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic23);
-}
-
-static struct platform_driver simtec_audio_tlv320aic23_platdrv = {
-	.driver	= {
-		.owner	= THIS_MODULE,
-		.name	= "s3c24xx-simtec-tlv320aic23",
-		.pm	= simtec_audio_pm,
-	},
-	.probe	= simtec_audio_tlv320aic23_probe,
-	.remove	= __devexit_p(simtec_audio_remove),
-};
-
-MODULE_ALIAS("platform:s3c24xx-simtec-tlv320aic23");
-
-static int __init simtec_tlv320aic23_modinit(void)
-{
-	return platform_driver_register(&simtec_audio_tlv320aic23_platdrv);
-}
-
-static void __exit simtec_tlv320aic23_modexit(void)
-{
-	platform_driver_unregister(&simtec_audio_tlv320aic23_platdrv);
-}
-
-module_init(simtec_tlv320aic23_modinit);
-module_exit(simtec_tlv320aic23_modexit);
-
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
deleted file mode 100644
index 052d596..0000000
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ /dev/null
@@ -1,373 +0,0 @@
-/*
- * Modifications by Christian Pellegrin <chripell@evolware.org>
- *
- * s3c24xx_uda134x.c  --  S3C24XX_UDA134X ALSA SoC Audio board driver
- *
- * Copyright 2007 Dension Audio Systems Ltd.
- * Author: Zoltan Devai
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-#include <linux/gpio.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <sound/s3c24xx_uda134x.h>
-#include <sound/uda134x.h>
-
-#include <plat/regs-iis.h>
-
-#include "s3c-dma.h"
-#include "s3c24xx-i2s.h"
-#include "../codecs/uda134x.h"
-
-
-/* #define ENFORCE_RATES 1 */
-/*
-  Unfortunately the S3C24XX in master mode has a limited capacity of
-  generating the clock for the codec. If you define this only rates
-  that are really available will be enforced. But be careful, most
-  user level application just want the usual sampling frequencies (8,
-  11.025, 22.050, 44.1 kHz) and anyway resampling is a costly
-  operation for embedded systems. So if you aren't very lucky or your
-  hardware engineer wasn't very forward-looking it's better to leave
-  this undefined. If you do so an approximate value for the requested
-  sampling rate in the range -/+ 5% will be chosen. If this in not
-  possible an error will be returned.
-*/
-
-static struct clk *xtal;
-static struct clk *pclk;
-/* this is need because we don't have a place where to keep the
- * pointers to the clocks in each substream. We get the clocks only
- * when we are actually using them so we don't block stuff like
- * frequency change or oscillator power-off */
-static int clk_users;
-static DEFINE_MUTEX(clk_lock);
-
-static unsigned int rates[33 * 2];
-#ifdef ENFORCE_RATES
-static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
-	.count	= ARRAY_SIZE(rates),
-	.list	= rates,
-	.mask	= 0,
-};
-#endif
-
-static struct platform_device *s3c24xx_uda134x_snd_device;
-
-static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
-{
-	int ret = 0;
-#ifdef ENFORCE_RATES
-	struct snd_pcm_runtime *runtime = substream->runtime;
-#endif
-
-	mutex_lock(&clk_lock);
-	pr_debug("%s %d\n", __func__, clk_users);
-	if (clk_users == 0) {
-		xtal = clk_get(&s3c24xx_uda134x_snd_device->dev, "xtal");
-		if (!xtal) {
-			printk(KERN_ERR "%s cannot get xtal\n", __func__);
-			ret = -EBUSY;
-		} else {
-			pclk = clk_get(&s3c24xx_uda134x_snd_device->dev,
-				       "pclk");
-			if (!pclk) {
-				printk(KERN_ERR "%s cannot get pclk\n",
-				       __func__);
-				clk_put(xtal);
-				ret = -EBUSY;
-			}
-		}
-		if (!ret) {
-			int i, j;
-
-			for (i = 0; i < 2; i++) {
-				int fs = i ? 256 : 384;
-
-				rates[i*33] = clk_get_rate(xtal) / fs;
-				for (j = 1; j < 33; j++)
-					rates[i*33 + j] = clk_get_rate(pclk) /
-						(j * fs);
-			}
-		}
-	}
-	clk_users += 1;
-	mutex_unlock(&clk_lock);
-	if (!ret) {
-#ifdef ENFORCE_RATES
-		ret = snd_pcm_hw_constraint_list(runtime, 0,
-						 SNDRV_PCM_HW_PARAM_RATE,
-						 &hw_constraints_rates);
-		if (ret < 0)
-			printk(KERN_ERR "%s cannot set constraints\n",
-			       __func__);
-#endif
-	}
-	return ret;
-}
-
-static void s3c24xx_uda134x_shutdown(struct snd_pcm_substream *substream)
-{
-	mutex_lock(&clk_lock);
-	pr_debug("%s %d\n", __func__, clk_users);
-	clk_users -= 1;
-	if (clk_users == 0) {
-		clk_put(xtal);
-		xtal = NULL;
-		clk_put(pclk);
-		pclk = NULL;
-	}
-	mutex_unlock(&clk_lock);
-}
-
-static int s3c24xx_uda134x_hw_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	unsigned int clk = 0;
-	int ret = 0;
-	int clk_source, fs_mode;
-	unsigned long rate = params_rate(params);
-	long err, cerr;
-	unsigned int div;
-	int i, bi;
-
-	err = 999999;
-	bi = 0;
-	for (i = 0; i < 2*33; i++) {
-		cerr = rates[i] - rate;
-		if (cerr < 0)
-			cerr = -cerr;
-		if (cerr < err) {
-			err = cerr;
-			bi = i;
-		}
-	}
-	if (bi / 33 == 1)
-		fs_mode = S3C2410_IISMOD_256FS;
-	else
-		fs_mode = S3C2410_IISMOD_384FS;
-	if (bi % 33 == 0) {
-		clk_source = S3C24XX_CLKSRC_MPLL;
-		div = 1;
-	} else {
-		clk_source = S3C24XX_CLKSRC_PCLK;
-		div = bi % 33;
-	}
-	pr_debug("%s desired rate %lu, %d\n", __func__, rate, bi);
-
-	clk = (fs_mode == S3C2410_IISMOD_384FS ? 384 : 256) * rate;
-	pr_debug("%s will use: %s %s %d sysclk %d err %ld\n", __func__,
-		 fs_mode == S3C2410_IISMOD_384FS ? "384FS" : "256FS",
-		 clk_source == S3C24XX_CLKSRC_MPLL ? "MPLLin" : "PCLK",
-		 div, clk, err);
-
-	if ((err * 100 / rate) > 5) {
-		printk(KERN_ERR "S3C24XX_UDA134X: effective frequency "
-		       "too different from desired (%ld%%)\n",
-		       err * 100 / rate);
-		return -EINVAL;
-	}
-
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_sysclk(cpu_dai, clk_source , clk,
-			SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK, fs_mode);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_BCLK,
-			S3C2410_IISMOD_32FS);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
-			S3C24XX_PRESCALE(div, div));
-	if (ret < 0)
-		return ret;
-
-	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk,
-			SND_SOC_CLOCK_OUT);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static struct snd_soc_ops s3c24xx_uda134x_ops = {
-	.startup = s3c24xx_uda134x_startup,
-	.shutdown = s3c24xx_uda134x_shutdown,
-	.hw_params = s3c24xx_uda134x_hw_params,
-};
-
-static struct snd_soc_dai_link s3c24xx_uda134x_dai_link = {
-	.name = "UDA134X",
-	.stream_name = "UDA134X",
-	.codec_dai = &uda134x_dai,
-	.cpu_dai = &s3c24xx_i2s_dai,
-	.ops = &s3c24xx_uda134x_ops,
-};
-
-static struct snd_soc_card snd_soc_s3c24xx_uda134x = {
-	.name = "S3C24XX_UDA134X",
-	.platform = &s3c24xx_soc_platform,
-	.dai_link = &s3c24xx_uda134x_dai_link,
-	.num_links = 1,
-};
-
-static struct s3c24xx_uda134x_platform_data *s3c24xx_uda134x_l3_pins;
-
-static void setdat(int v)
-{
-	gpio_set_value(s3c24xx_uda134x_l3_pins->l3_data, v > 0);
-}
-
-static void setclk(int v)
-{
-	gpio_set_value(s3c24xx_uda134x_l3_pins->l3_clk, v > 0);
-}
-
-static void setmode(int v)
-{
-	gpio_set_value(s3c24xx_uda134x_l3_pins->l3_mode, v > 0);
-}
-
-static struct uda134x_platform_data s3c24xx_uda134x = {
-	.l3 = {
-		.setdat = setdat,
-		.setclk = setclk,
-		.setmode = setmode,
-		.data_hold = 1,
-		.data_setup = 1,
-		.clock_high = 1,
-		.mode_hold = 1,
-		.mode = 1,
-		.mode_setup = 1,
-	},
-};
-
-static struct snd_soc_device s3c24xx_uda134x_snd_devdata = {
-	.card = &snd_soc_s3c24xx_uda134x,
-	.codec_dev = &soc_codec_dev_uda134x,
-	.codec_data = &s3c24xx_uda134x,
-};
-
-static int s3c24xx_uda134x_setup_pin(int pin, char *fun)
-{
-	if (gpio_request(pin, "s3c24xx_uda134x") < 0) {
-		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: "
-		       "l3 %s pin already in use", fun);
-		return -EBUSY;
-	}
-	gpio_direction_output(pin, 0);
-	return 0;
-}
-
-static int s3c24xx_uda134x_probe(struct platform_device *pdev)
-{
-	int ret;
-
-	printk(KERN_INFO "S3C24XX_UDA134X SoC Audio driver\n");
-
-	s3c24xx_uda134x_l3_pins = pdev->dev.platform_data;
-	if (s3c24xx_uda134x_l3_pins == NULL) {
-		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: "
-		       "unable to find platform data\n");
-		return -ENODEV;
-	}
-	s3c24xx_uda134x.power = s3c24xx_uda134x_l3_pins->power;
-	s3c24xx_uda134x.model = s3c24xx_uda134x_l3_pins->model;
-
-	if (s3c24xx_uda134x_setup_pin(s3c24xx_uda134x_l3_pins->l3_data,
-				      "data") < 0)
-		return -EBUSY;
-	if (s3c24xx_uda134x_setup_pin(s3c24xx_uda134x_l3_pins->l3_clk,
-				      "clk") < 0) {
-		gpio_free(s3c24xx_uda134x_l3_pins->l3_data);
-		return -EBUSY;
-	}
-	if (s3c24xx_uda134x_setup_pin(s3c24xx_uda134x_l3_pins->l3_mode,
-				      "mode") < 0) {
-		gpio_free(s3c24xx_uda134x_l3_pins->l3_data);
-		gpio_free(s3c24xx_uda134x_l3_pins->l3_clk);
-		return -EBUSY;
-	}
-
-	s3c24xx_uda134x_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!s3c24xx_uda134x_snd_device) {
-		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: "
-		       "Unable to register\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(s3c24xx_uda134x_snd_device,
-			     &s3c24xx_uda134x_snd_devdata);
-	s3c24xx_uda134x_snd_devdata.dev = &s3c24xx_uda134x_snd_device->dev;
-	ret = platform_device_add(s3c24xx_uda134x_snd_device);
-	if (ret) {
-		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: Unable to add\n");
-		platform_device_put(s3c24xx_uda134x_snd_device);
-	}
-
-	return ret;
-}
-
-static int s3c24xx_uda134x_remove(struct platform_device *pdev)
-{
-	platform_device_unregister(s3c24xx_uda134x_snd_device);
-	gpio_free(s3c24xx_uda134x_l3_pins->l3_data);
-	gpio_free(s3c24xx_uda134x_l3_pins->l3_clk);
-	gpio_free(s3c24xx_uda134x_l3_pins->l3_mode);
-	return 0;
-}
-
-static struct platform_driver s3c24xx_uda134x_driver = {
-	.probe  = s3c24xx_uda134x_probe,
-	.remove = s3c24xx_uda134x_remove,
-	.driver = {
-		.name = "s3c24xx_uda134x",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init s3c24xx_uda134x_init(void)
-{
-	return platform_driver_register(&s3c24xx_uda134x_driver);
-}
-
-static void __exit s3c24xx_uda134x_exit(void)
-{
-	platform_driver_unregister(&s3c24xx_uda134x_driver);
-}
-
-
-module_init(s3c24xx_uda134x_init);
-module_exit(s3c24xx_uda134x_exit);
-
-MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
-MODULE_DESCRIPTION("S3C24XX_UDA134X ALSA SoC audio driver");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
deleted file mode 100644
index 06db130..0000000
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ /dev/null
@@ -1,209 +0,0 @@
-/* sound/soc/s3c24xx/s3c64xx-i2s-v4.c
- *
- * ALSA SoC Audio Layer - S3C64XX I2Sv4 driver
- * Copyright (c) 2010 Samsung Electronics Co. Ltd
- * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/clk.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-
-#include <sound/soc.h>
-#include <sound/pcm_params.h>
-
-#include <mach/gpio-bank-c.h>
-#include <mach/gpio-bank-h.h>
-#include <plat/gpio-cfg.h>
-
-#include <mach/map.h>
-#include <mach/dma.h>
-
-#include "s3c-dma.h"
-#include "regs-i2s-v2.h"
-#include "s3c64xx-i2s.h"
-
-static struct s3c2410_dma_client s3c64xx_dma_client_out = {
-	.name		= "I2Sv4 PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c64xx_dma_client_in = {
-	.name		= "I2Sv4 PCM Stereo in"
-};
-
-static struct s3c_dma_params s3c64xx_i2sv4_pcm_stereo_out;
-static struct s3c_dma_params s3c64xx_i2sv4_pcm_stereo_in;
-static struct s3c_i2sv2_info s3c64xx_i2sv4;
-
-struct snd_soc_dai s3c64xx_i2s_v4_dai;
-EXPORT_SYMBOL_GPL(s3c64xx_i2s_v4_dai);
-
-static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-{
-	return cpu_dai->private_data;
-}
-
-static int s3c64xx_i2sv4_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
-{
-	/* configure GPIO for i2s port */
-	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
-	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
-	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
-	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
-
-	return 0;
-}
-
-static int s3c_i2sv4_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *cpu_dai)
-{
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
-	struct s3c_dma_params *dma_data;
-	u32 iismod;
-
-	dev_dbg(cpu_dai->dev, "Entered %s\n", __func__);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = i2s->dma_playback;
-	else
-		dma_data = i2s->dma_capture;
-
-	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
-
-	iismod = readl(i2s->regs + S3C2412_IISMOD);
-	dev_dbg(cpu_dai->dev, "%s: r: IISMOD: %x\n", __func__, iismod);
-
-	iismod &= ~S3C64XX_IISMOD_BLC_MASK;
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		iismod |= S3C64XX_IISMOD_BLC_8BIT;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		iismod |= S3C64XX_IISMOD_BLC_24BIT;
-		break;
-	}
-
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-	dev_dbg(cpu_dai->dev, "%s: w: IISMOD: %x\n", __func__, iismod);
-
-	return 0;
-}
-
-static struct snd_soc_dai_ops s3c64xx_i2sv4_dai_ops = {
-	.hw_params	= s3c_i2sv4_hw_params,
-};
-
-static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
-{
-	struct s3c_i2sv2_info *i2s;
-	struct snd_soc_dai *dai;
-	int ret;
-
-	i2s = &s3c64xx_i2sv4;
-	dai = &s3c64xx_i2s_v4_dai;
-
-	if (dai->dev) {
-		dev_dbg(dai->dev, "%s: \
-			I2Sv4 instance already registered!\n", __func__);
-		return -EBUSY;
-	}
-
-	dai->dev = &pdev->dev;
-	dai->name = "s3c64xx-i2s-v4";
-	dai->id = 0;
-	dai->symmetric_rates = 1;
-	dai->playback.channels_min = 2;
-	dai->playback.channels_max = 2;
-	dai->playback.rates = S3C64XX_I2S_RATES;
-	dai->playback.formats = S3C64XX_I2S_FMTS;
-	dai->capture.channels_min = 2;
-	dai->capture.channels_max = 2;
-	dai->capture.rates = S3C64XX_I2S_RATES;
-	dai->capture.formats = S3C64XX_I2S_FMTS;
-	dai->probe = s3c64xx_i2sv4_probe;
-	dai->ops = &s3c64xx_i2sv4_dai_ops;
-
-	i2s->feature |= S3C_FEATURE_CDCLKCON;
-
-	i2s->dma_capture = &s3c64xx_i2sv4_pcm_stereo_in;
-	i2s->dma_playback = &s3c64xx_i2sv4_pcm_stereo_out;
-
-	i2s->dma_capture->channel = DMACH_HSI_I2SV40_RX;
-	i2s->dma_capture->dma_addr = S3C64XX_PA_IISV4 + S3C2412_IISRXD;
-	i2s->dma_playback->channel = DMACH_HSI_I2SV40_TX;
-	i2s->dma_playback->dma_addr = S3C64XX_PA_IISV4 + S3C2412_IISTXD;
-
-	i2s->dma_capture->client = &s3c64xx_dma_client_in;
-	i2s->dma_capture->dma_size = 4;
-	i2s->dma_playback->client = &s3c64xx_dma_client_out;
-	i2s->dma_playback->dma_size = 4;
-
-	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
-	if (IS_ERR(i2s->iis_cclk)) {
-		dev_err(&pdev->dev, "failed to get audio-bus\n");
-		ret = PTR_ERR(i2s->iis_cclk);
-		goto err;
-	}
-
-	clk_enable(i2s->iis_cclk);
-
-	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
-	if (ret)
-		goto err_clk;
-
-	ret = s3c_i2sv2_register_dai(dai);
-	if (ret != 0)
-		goto err_i2sv2;
-
-	return 0;
-
-err_i2sv2:
-	/* Not implemented for I2Sv2 core yet */
-err_clk:
-	clk_put(i2s->iis_cclk);
-err:
-	return ret;
-}
-
-static __devexit int s3c64xx_i2sv4_dev_remove(struct platform_device *pdev)
-{
-	dev_err(&pdev->dev, "Device removal not yet supported\n");
-	return 0;
-}
-
-static struct platform_driver s3c64xx_i2sv4_driver = {
-	.probe  = s3c64xx_i2sv4_dev_probe,
-	.remove = s3c64xx_i2sv4_dev_remove,
-	.driver = {
-		.name = "s3c64xx-iis-v4",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init s3c64xx_i2sv4_init(void)
-{
-	return platform_driver_register(&s3c64xx_i2sv4_driver);
-}
-module_init(s3c64xx_i2sv4_init);
-
-static void __exit s3c64xx_i2sv4_exit(void)
-{
-	platform_driver_unregister(&s3c64xx_i2sv4_driver);
-}
-module_exit(s3c64xx_i2sv4_exit);
-
-/* Module information */
-MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
-MODULE_DESCRIPTION("S3C64XX I2Sv4 SoC Interface");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
deleted file mode 100644
index 1d85cb8..0000000
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ /dev/null
@@ -1,190 +0,0 @@
-/* sound/soc/s3c24xx/s3c64xx-i2s.c
- *
- * ALSA SoC Audio Layer - S3C64XX I2S driver
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/clk.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-
-#include <sound/soc.h>
-
-#include <mach/gpio-bank-d.h>
-#include <mach/gpio-bank-e.h>
-#include <plat/gpio-cfg.h>
-
-#include <mach/map.h>
-#include <mach/dma.h>
-
-#include "s3c-dma.h"
-#include "regs-i2s-v2.h"
-#include "s3c64xx-i2s.h"
-
-/* The value should be set to maximum of the total number
- * of I2Sv3 controllers that any supported SoC has.
- */
-#define MAX_I2SV3	2
-
-static struct s3c2410_dma_client s3c64xx_dma_client_out = {
-	.name		= "I2S PCM Stereo out"
-};
-
-static struct s3c2410_dma_client s3c64xx_dma_client_in = {
-	.name		= "I2S PCM Stereo in"
-};
-
-static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[MAX_I2SV3];
-static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[MAX_I2SV3];
-static struct s3c_i2sv2_info s3c64xx_i2s[MAX_I2SV3];
-
-struct snd_soc_dai s3c64xx_i2s_dai[MAX_I2SV3];
-EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
-
-static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-{
-	return cpu_dai->private_data;
-}
-
-static int s3c64xx_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
-{
-	/* configure GPIO for i2s port */
-	switch (dai->id) {
-	case 0:
-		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
-		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
-		break;
-	case 1:
-		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
-		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
-	}
-
-	return 0;
-}
-
-
-static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops;
-
-static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
-{
-	struct s3c_i2sv2_info *i2s;
-	struct snd_soc_dai *dai;
-	int ret;
-
-	if (pdev->id >= MAX_I2SV3) {
-		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
-		return -EINVAL;
-	}
-
-	i2s = &s3c64xx_i2s[pdev->id];
-	dai = &s3c64xx_i2s_dai[pdev->id];
-	dai->dev = &pdev->dev;
-	dai->name = "s3c64xx-i2s";
-	dai->id = pdev->id;
-	dai->symmetric_rates = 1;
-	dai->playback.channels_min = 2;
-	dai->playback.channels_max = 2;
-	dai->playback.rates = S3C64XX_I2S_RATES;
-	dai->playback.formats = S3C64XX_I2S_FMTS;
-	dai->capture.channels_min = 2;
-	dai->capture.channels_max = 2;
-	dai->capture.rates = S3C64XX_I2S_RATES;
-	dai->capture.formats = S3C64XX_I2S_FMTS;
-	dai->probe = s3c64xx_i2s_probe;
-	dai->ops = &s3c64xx_i2s_dai_ops;
-
-	i2s->feature |= S3C_FEATURE_CDCLKCON;
-
-	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
-	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
-
-	if (pdev->id == 0) {
-		i2s->dma_capture->channel = DMACH_I2S0_IN;
-		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISRXD;
-		i2s->dma_playback->channel = DMACH_I2S0_OUT;
-		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISTXD;
-	} else {
-		i2s->dma_capture->channel = DMACH_I2S1_IN;
-		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISRXD;
-		i2s->dma_playback->channel = DMACH_I2S1_OUT;
-		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISTXD;
-	}
-
-	i2s->dma_capture->client = &s3c64xx_dma_client_in;
-	i2s->dma_capture->dma_size = 4;
-	i2s->dma_playback->client = &s3c64xx_dma_client_out;
-	i2s->dma_playback->dma_size = 4;
-
-	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
-	if (IS_ERR(i2s->iis_cclk)) {
-		dev_err(&pdev->dev, "failed to get audio-bus\n");
-		ret = PTR_ERR(i2s->iis_cclk);
-		goto err;
-	}
-
-	clk_enable(i2s->iis_cclk);
-
-	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
-	if (ret)
-		goto err_clk;
-
-	ret = s3c_i2sv2_register_dai(dai);
-	if (ret != 0)
-		goto err_i2sv2;
-
-	return 0;
-
-err_i2sv2:
-	/* Not implemented for I2Sv2 core yet */
-err_clk:
-	clk_put(i2s->iis_cclk);
-err:
-	return ret;
-}
-
-static __devexit int s3c64xx_iis_dev_remove(struct platform_device *pdev)
-{
-	dev_err(&pdev->dev, "Device removal not yet supported\n");
-	return 0;
-}
-
-static struct platform_driver s3c64xx_iis_driver = {
-	.probe  = s3c64xx_iis_dev_probe,
-	.remove = s3c64xx_iis_dev_remove,
-	.driver = {
-		.name = "s3c64xx-iis",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init s3c64xx_i2s_init(void)
-{
-	return platform_driver_register(&s3c64xx_iis_driver);
-}
-module_init(s3c64xx_i2s_init);
-
-static void __exit s3c64xx_i2s_exit(void)
-{
-	platform_driver_unregister(&s3c64xx_iis_driver);
-}
-module_exit(s3c64xx_i2s_exit);
-
-/* Module information */
-MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("S3C64XX I2S SoC Interface");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
deleted file mode 100644
index 7a40f43..0000000
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* sound/soc/s3c24xx/s3c64xx-i2s.h
- *
- * ALSA SoC Audio Layer - S3C64XX I2S driver
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __SND_SOC_S3C24XX_S3C64XX_I2S_H
-#define __SND_SOC_S3C24XX_S3C64XX_I2S_H __FILE__
-
-struct clk;
-
-#include "s3c-i2s-v2.h"
-
-#define S3C64XX_DIV_BCLK	S3C_I2SV2_DIV_BCLK
-#define S3C64XX_DIV_RCLK	S3C_I2SV2_DIV_RCLK
-#define S3C64XX_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
-
-#define S3C64XX_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
-#define S3C64XX_CLKSRC_MUX	S3C_I2SV2_CLKSRC_AUDIOBUS
-#define S3C64XX_CLKSRC_CDCLK    S3C_I2SV2_CLKSRC_CDCLK
-
-#define S3C64XX_I2S_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-#define S3C64XX_I2S_FMTS \
-	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
-	 SNDRV_PCM_FMTBIT_S24_LE)
-
-extern struct snd_soc_dai s3c64xx_i2s_dai[];
-extern struct snd_soc_dai s3c64xx_i2s_v4_dai;
-
-#endif /* __SND_SOC_S3C24XX_S3C64XX_I2S_H */
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
deleted file mode 100644
index 3622588..0000000
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * smdk2443_wm9710.c  --  SoC audio for smdk2443
- *
- * Copyright 2007 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory
- *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include "../codecs/ac97.h"
-#include "s3c-dma.h"
-#include "s3c-ac97.h"
-
-static struct snd_soc_card smdk2443;
-
-static struct snd_soc_dai_link smdk2443_dai[] = {
-{
-	.name = "AC97",
-	.stream_name = "AC97 HiFi",
-	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
-	.codec_dai = &ac97_dai,
-},
-};
-
-static struct snd_soc_card smdk2443 = {
-	.name = "SMDK2443",
-	.platform = &s3c24xx_soc_platform,
-	.dai_link = smdk2443_dai,
-	.num_links = ARRAY_SIZE(smdk2443_dai),
-};
-
-static struct snd_soc_device smdk2443_snd_ac97_devdata = {
-	.card = &smdk2443,
-	.codec_dev = &soc_codec_dev_ac97,
-};
-
-static struct platform_device *smdk2443_snd_ac97_device;
-
-static int __init smdk2443_init(void)
-{
-	int ret;
-
-	smdk2443_snd_ac97_device = platform_device_alloc("soc-audio", -1);
-	if (!smdk2443_snd_ac97_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(smdk2443_snd_ac97_device,
-				&smdk2443_snd_ac97_devdata);
-	smdk2443_snd_ac97_devdata.dev = &smdk2443_snd_ac97_device->dev;
-	ret = platform_device_add(smdk2443_snd_ac97_device);
-
-	if (ret)
-		platform_device_put(smdk2443_snd_ac97_device);
-
-	return ret;
-}
-
-static void __exit smdk2443_exit(void)
-{
-	platform_device_unregister(smdk2443_snd_ac97_device);
-}
-
-module_init(smdk2443_init);
-module_exit(smdk2443_exit);
-
-/* Module information */
-MODULE_AUTHOR("Graeme Gregory, graeme.gregory@wolfsonmicro.com, www.wolfsonmicro.com");
-MODULE_DESCRIPTION("ALSA SoC WM9710 SMDK2443");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
deleted file mode 100644
index 07e8e51..0000000
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ /dev/null
@@ -1,266 +0,0 @@
-/*
- *  smdk64xx_wm8580.c
- *
- *  Copyright (c) 2009 Samsung Electronics Co. Ltd
- *  Author: Jaswinder Singh <jassi.brar@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-
-#include "../codecs/wm8580.h"
-#include "s3c-dma.h"
-#include "s3c64xx-i2s.h"
-
-/* SMDK64XX has a 12MHZ crystal attached to WM8580 */
-#define SMDK64XX_WM8580_FREQ 12000000
-
-static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	unsigned int pll_out;
-	int bfs, rfs, ret;
-
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_U8:
-	case SNDRV_PCM_FORMAT_S8:
-		bfs = 16;
-		break;
-	case SNDRV_PCM_FORMAT_U16_LE:
-	case SNDRV_PCM_FORMAT_S16_LE:
-		bfs = 32;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* The Fvco for WM8580 PLLs must fall within [90,100]MHz.
-	 * This criterion can't be met if we request PLL output
-	 * as {8000x256, 64000x256, 11025x256}Hz.
-	 * As a wayout, we rather change rfs to a minimum value that
-	 * results in (params_rate(params) * rfs), and itself, acceptable
-	 * to both - the CODEC and the CPU.
-	 */
-	switch (params_rate(params)) {
-	case 16000:
-	case 22050:
-	case 32000:
-	case 44100:
-	case 48000:
-	case 88200:
-	case 96000:
-		rfs = 256;
-		break;
-	case 64000:
-		rfs = 384;
-		break;
-	case 8000:
-	case 11025:
-		rfs = 512;
-		break;
-	default:
-		return -EINVAL;
-	}
-	pll_out = params_rate(params) * rfs;
-
-	/* Set the Codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
-					 | SND_SOC_DAIFMT_NB_NF
-					 | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* Set the AP DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
-					 | SND_SOC_DAIFMT_NB_NF
-					 | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_CDCLK,
-					0, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* We use PCLK for basic ops in SoC-Slave mode */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_PCLK,
-					0, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* Set WM8580 to drive MCLK from its PLLA */
-	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
-					WM8580_CLKSRC_PLLA);
-	if (ret < 0)
-		return ret;
-
-	/* Explicitly set WM8580-DAC to source from MCLK */
-	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_DAC_CLKSEL,
-					WM8580_CLKSRC_MCLK);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
-					SMDK64XX_WM8580_FREQ, pll_out);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_BCLK, bfs);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_RCLK, rfs);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-/*
- * SMDK64XX WM8580 DAI operations.
- */
-static struct snd_soc_ops smdk64xx_ops = {
-	.hw_params = smdk64xx_hw_params,
-};
-
-/* SMDK64xx Playback widgets */
-static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
-	SND_SOC_DAPM_HP("Front-L/R", NULL),
-	SND_SOC_DAPM_HP("Center/Sub", NULL),
-	SND_SOC_DAPM_HP("Rear-L/R", NULL),
-};
-
-/* SMDK64xx Capture widgets */
-static const struct snd_soc_dapm_widget wm8580_dapm_widgets_cpt[] = {
-	SND_SOC_DAPM_MIC("MicIn", NULL),
-	SND_SOC_DAPM_LINE("LineIn", NULL),
-};
-
-/* SMDK-PAIFTX connections */
-static const struct snd_soc_dapm_route audio_map_tx[] = {
-	/* MicIn feeds AINL */
-	{"AINL", NULL, "MicIn"},
-
-	/* LineIn feeds AINL/R */
-	{"AINL", NULL, "LineIn"},
-	{"AINR", NULL, "LineIn"},
-};
-
-/* SMDK-PAIFRX connections */
-static const struct snd_soc_dapm_route audio_map_rx[] = {
-	/* Front Left/Right are fed VOUT1L/R */
-	{"Front-L/R", NULL, "VOUT1L"},
-	{"Front-L/R", NULL, "VOUT1R"},
-
-	/* Center/Sub are fed VOUT2L/R */
-	{"Center/Sub", NULL, "VOUT2L"},
-	{"Center/Sub", NULL, "VOUT2R"},
-
-	/* Rear Left/Right are fed VOUT3L/R */
-	{"Rear-L/R", NULL, "VOUT3L"},
-	{"Rear-L/R", NULL, "VOUT3R"},
-};
-
-static int smdk64xx_wm8580_init_paiftx(struct snd_soc_codec *codec)
-{
-	/* Add smdk64xx specific Capture widgets */
-	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_cpt,
-				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
-
-	/* Set up PAIFTX audio path */
-	snd_soc_dapm_add_routes(codec, audio_map_tx, ARRAY_SIZE(audio_map_tx));
-
-	/* Enabling the microphone requires the fitting of a 0R
-	 * resistor to connect the line from the microphone jack.
-	 */
-	snd_soc_dapm_disable_pin(codec, "MicIn");
-
-	/* signal a DAPM event */
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static int smdk64xx_wm8580_init_paifrx(struct snd_soc_codec *codec)
-{
-	/* Add smdk64xx specific Playback widgets */
-	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_pbk,
-				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
-
-	/* Set up PAIFRX audio path */
-	snd_soc_dapm_add_routes(codec, audio_map_rx, ARRAY_SIZE(audio_map_rx));
-
-	/* signal a DAPM event */
-	snd_soc_dapm_sync(codec);
-
-	return 0;
-}
-
-static struct snd_soc_dai_link smdk64xx_dai[] = {
-{ /* Primary Playback i/f */
-	.name = "WM8580 PAIF RX",
-	.stream_name = "Playback",
-	.cpu_dai = &s3c64xx_i2s_v4_dai,
-	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFRX],
-	.init = smdk64xx_wm8580_init_paifrx,
-	.ops = &smdk64xx_ops,
-},
-{ /* Primary Capture i/f */
-	.name = "WM8580 PAIF TX",
-	.stream_name = "Capture",
-	.cpu_dai = &s3c64xx_i2s_v4_dai,
-	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFTX],
-	.init = smdk64xx_wm8580_init_paiftx,
-	.ops = &smdk64xx_ops,
-},
-};
-
-static struct snd_soc_card smdk64xx = {
-	.name = "smdk64xx",
-	.platform = &s3c24xx_soc_platform,
-	.dai_link = smdk64xx_dai,
-	.num_links = ARRAY_SIZE(smdk64xx_dai),
-};
-
-static struct snd_soc_device smdk64xx_snd_devdata = {
-	.card = &smdk64xx,
-	.codec_dev = &soc_codec_dev_wm8580,
-};
-
-static struct platform_device *smdk64xx_snd_device;
-
-static int __init smdk64xx_audio_init(void)
-{
-	int ret;
-
-	smdk64xx_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!smdk64xx_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(smdk64xx_snd_device, &smdk64xx_snd_devdata);
-	smdk64xx_snd_devdata.dev = &smdk64xx_snd_device->dev;
-	ret = platform_device_add(smdk64xx_snd_device);
-
-	if (ret)
-		platform_device_put(smdk64xx_snd_device);
-
-	return ret;
-}
-module_init(smdk64xx_audio_init);
-
-MODULE_AUTHOR("Jaswinder Singh, jassi.brar@samsung.com");
-MODULE_DESCRIPTION("ALSA SoC SMDK64XX WM8580");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
deleted file mode 100644
index 24fd39f..0000000
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * smdk_wm9713.c  --  SoC audio for SMDK
- *
- * Copyright 2010 Samsung Electronics Co. Ltd.
- * Author: Jaswinder Singh Brar <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <linux/device.h>
-#include <sound/soc.h>
-
-#include "../codecs/wm9713.h"
-#include "s3c-dma.h"
-#include "s3c-ac97.h"
-
-static struct snd_soc_card smdk;
-
-/*
- * Default CFG switch settings to use this driver:
- *
- *   SMDK6410: Set CFG1 1-3 On, CFG2 1-4 Off
- */
-
-/*
- Playback (HeadPhone):-
-	$ amixer sset 'Headphone' unmute
-	$ amixer sset 'Right Headphone Out Mux' 'Headphone'
-	$ amixer sset 'Left Headphone Out Mux' 'Headphone'
-	$ amixer sset 'Right HP Mixer PCM' unmute
-	$ amixer sset 'Left HP Mixer PCM' unmute
-
- Capture (LineIn):-
-	$ amixer sset 'Right Capture Source' 'Line'
-	$ amixer sset 'Left Capture Source' 'Line'
-*/
-
-static struct snd_soc_dai_link smdk_dai = {
-	.name = "AC97",
-	.stream_name = "AC97 PCM",
-	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
-	.codec_dai = &wm9713_dai[WM9713_DAI_AC97_HIFI],
-};
-
-static struct snd_soc_card smdk = {
-	.name = "SMDK",
-	.platform = &s3c24xx_soc_platform,
-	.dai_link = &smdk_dai,
-	.num_links = 1,
-};
-
-static struct snd_soc_device smdk_snd_ac97_devdata = {
-	.card = &smdk,
-	.codec_dev = &soc_codec_dev_wm9713,
-};
-
-static struct platform_device *smdk_snd_ac97_device;
-
-static int __init smdk_init(void)
-{
-	int ret;
-
-	smdk_snd_ac97_device = platform_device_alloc("soc-audio", -1);
-	if (!smdk_snd_ac97_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(smdk_snd_ac97_device,
-			     &smdk_snd_ac97_devdata);
-	smdk_snd_ac97_devdata.dev = &smdk_snd_ac97_device->dev;
-
-	ret = platform_device_add(smdk_snd_ac97_device);
-	if (ret)
-		platform_device_put(smdk_snd_ac97_device);
-
-	return ret;
-}
-
-static void __exit smdk_exit(void)
-{
-	platform_device_unregister(smdk_snd_ac97_device);
-}
-
-module_init(smdk_init);
-module_exit(smdk_exit);
-
-/* Module information */
-MODULE_AUTHOR("Jaswinder Singh Brar, jassi.brar@samsung.com");
-MODULE_DESCRIPTION("ALSA SoC SMDK+WM9713");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
new file mode 100644
index 0000000..2a7cc22
--- /dev/null
+++ b/sound/soc/samsung/Kconfig
@@ -0,0 +1,127 @@
+config SND_S3C24XX_SOC
+	tristate "SoC Audio for the Samsung S3CXXXX chips"
+	depends on ARCH_S3C2410 || ARCH_S3C64XX
+	select S3C64XX_DMA if ARCH_S3C64XX
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the S3C24XX AC97 or I2S interfaces. You will also need to
+	  select the audio interfaces to support below.
+
+config SND_S3C24XX_SOC_I2S
+	tristate
+	select S3C2410_DMA
+
+config SND_S3C_I2SV2_SOC
+	tristate
+
+config SND_S3C2412_SOC_I2S
+	tristate
+	select SND_S3C_I2SV2_SOC
+	select S3C2410_DMA
+
+config SND_S3C64XX_SOC_I2S
+	tristate
+	select SND_S3C_I2SV2_SOC
+	select S3C64XX_DMA
+
+config SND_S3C64XX_SOC_I2S_V4
+	tristate
+	select SND_S3C_I2SV2_SOC
+	select S3C64XX_DMA
+
+config SND_S3C_SOC_PCM
+	tristate
+
+config SND_S3C_SOC_AC97
+	tristate
+	select SND_SOC_AC97_BUS
+
+config SND_S3C24XX_SOC_NEO1973_WM8753
+	tristate "SoC I2S Audio support for NEO1973 - WM8753"
+	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA01
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_WM8753
+	help
+	  Say Y if you want to add support for SoC audio on smdk2440
+	  with the WM8753.
+
+config SND_S3C24XX_SOC_NEO1973_GTA02_WM8753
+	tristate "Audio support for the Openmoko Neo FreeRunner (GTA02)"
+	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA02
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_WM8753
+	help
+	  This driver provides audio support for the Openmoko Neo FreeRunner
+	  smartphone.
+	  
+config SND_S3C24XX_SOC_JIVE_WM8750
+	tristate "SoC I2S Audio support for Jive"
+	depends on SND_S3C24XX_SOC && MACH_JIVE
+	select SND_SOC_WM8750
+	select SND_S3C2412_SOC_I2S
+	help
+	  Sat Y if you want to add support for SoC audio on the Jive.
+
+config SND_S3C64XX_SOC_WM8580
+	tristate "SoC I2S Audio support for WM8580 on SMDK64XX"
+	depends on SND_S3C24XX_SOC && MACH_SMDK6410
+	select SND_SOC_WM8580
+	select SND_S3C64XX_SOC_I2S_V4
+	help
+	  Say Y if you want to add support for SoC audio on the SMDK6410.
+
+config SND_S3C24XX_SOC_SMDK2443_WM9710
+	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
+	depends on SND_S3C24XX_SOC && MACH_SMDK2443
+	select S3C2410_DMA
+	select AC97_BUS
+	select SND_SOC_AC97_CODEC
+	select SND_S3C_SOC_AC97
+	help
+	  Say Y if you want to add support for SoC audio on smdk2443
+	  with the WM9710.
+
+config SND_S3C24XX_SOC_LN2440SBC_ALC650
+	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
+	depends on SND_S3C24XX_SOC && ARCH_S3C2410
+	select S3C2410_DMA
+	select AC97_BUS
+	select SND_SOC_AC97_CODEC
+	select SND_S3C_SOC_AC97
+	help
+	  Say Y if you want to add support for SoC audio on ln2440sbc
+	  with the ALC650.
+
+config SND_S3C24XX_SOC_S3C24XX_UDA134X
+	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
+       	depends on SND_S3C24XX_SOC && ARCH_S3C2410
+       	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_L3
+       	select SND_SOC_UDA134X
+
+config SND_S3C24XX_SOC_SIMTEC
+	tristate
+	help
+	  Internal node for common S3C24XX/Simtec suppor
+
+config SND_S3C24XX_SOC_SIMTEC_TLV320AIC23
+	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
+	depends on SND_S3C24XX_SOC && ARCH_S3C2410
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_TLV320AIC23
+	select SND_S3C24XX_SOC_SIMTEC
+
+config SND_S3C24XX_SOC_SIMTEC_HERMES
+	tristate "SoC I2S Audio support for Simtec Hermes board"
+	depends on SND_S3C24XX_SOC && ARCH_S3C2410
+	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_TLV320AIC3X
+	select SND_S3C24XX_SOC_SIMTEC
+
+config SND_SOC_SMDK_WM9713
+	tristate "SoC AC97 Audio support for SMDK with WM9713"
+	depends on SND_S3C24XX_SOC && MACH_SMDK6410
+	select SND_SOC_WM9713
+	select SND_S3C_SOC_AC97
+	help
+	  Sat Y if you want to add support for SoC audio on the SMDK.
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
new file mode 100644
index 0000000..81d8dc5
--- /dev/null
+++ b/sound/soc/samsung/Makefile
@@ -0,0 +1,43 @@
+# S3c24XX Platform Support
+snd-soc-s3c24xx-objs := s3c-dma.o
+snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
+snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
+snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
+snd-soc-s3c-ac97-objs := s3c-ac97.o
+snd-soc-s3c64xx-i2s-v4-objs := s3c64xx-i2s-v4.o
+snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
+snd-soc-s3c-pcm-objs := s3c-pcm.o
+
+obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
+obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
+obj-$(CONFIG_SND_S3C_SOC_AC97) += snd-soc-s3c-ac97.o
+obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
+obj-$(CONFIG_SND_S3C64XX_SOC_I2S) += snd-soc-s3c64xx-i2s.o
+obj-$(CONFIG_SND_S3C64XX_SOC_I2S_V4) += snd-soc-s3c64xx-i2s-v4.o
+obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
+obj-$(CONFIG_SND_S3C_SOC_PCM) += snd-soc-s3c-pcm.o
+
+# S3C24XX Machine Support
+snd-soc-jive-wm8750-objs := jive_wm8750.o
+snd-soc-neo1973-wm8753-objs := neo1973_wm8753.o
+snd-soc-neo1973-gta02-wm8753-objs := neo1973_gta02_wm8753.o
+snd-soc-smdk2443-wm9710-objs := smdk2443_wm9710.o
+snd-soc-ln2440sbc-alc650-objs := ln2440sbc_alc650.o
+snd-soc-s3c24xx-uda134x-objs := s3c24xx_uda134x.o
+snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
+snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
+snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
+snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
+snd-soc-smdk-wm9713-objs := smdk_wm9713.o
+
+obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
+obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
+obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_GTA02_WM8753) += snd-soc-neo1973-gta02-wm8753.o
+obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
+obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
+obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
+obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
+obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
+obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
+obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
+obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
new file mode 100644
index 0000000..8c108b1
--- /dev/null
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -0,0 +1,196 @@
+/* sound/soc/s3c24xx/jive_wm8750.c
+ *
+ * Copyright 2007,2008 Simtec Electronics
+ *
+ * Based on sound/soc/pxa/spitz.c
+ *	Copyright 2005 Wolfson Microelectronics PLC.
+ *	Copyright 2005 Openedhand Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+
+#include "s3c-dma.h"
+#include "s3c2412-i2s.h"
+
+#include "../codecs/wm8750.h"
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{ "Headphone Jack", NULL, "LOUT1" },
+	{ "Headphone Jack", NULL, "ROUT1" },
+	{ "Internal Speaker", NULL, "LOUT2" },
+	{ "Internal Speaker", NULL, "ROUT2" },
+	{ "LINPUT1", NULL, "Line Input" },
+	{ "RINPUT1", NULL, "Line Input" },
+};
+
+static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Internal Speaker", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+};
+
+static int jive_hw_params(struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct s3c_i2sv2_rate_calc div;
+	unsigned int clk = 0;
+	int ret = 0;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		clk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+		clk = 11289600;
+		break;
+	}
+
+	s3c_i2sv2_iis_calc_rate(&div, NULL, params_rate(params),
+				s3c_i2sv2_get_clock(cpu_dai));
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C2412_DIV_RCLK, div.fs_div);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C2412_DIV_PRESCALER,
+				     div.clk_div - 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops jive_ops = {
+	.hw_params	= jive_hw_params,
+};
+
+static int jive_wm8750_init(struct snd_soc_codec *codec)
+{
+	int err;
+
+	/* These endpoints are not being used. */
+	snd_soc_dapm_nc_pin(codec, "LINPUT2");
+	snd_soc_dapm_nc_pin(codec, "RINPUT2");
+	snd_soc_dapm_nc_pin(codec, "LINPUT3");
+	snd_soc_dapm_nc_pin(codec, "RINPUT3");
+	snd_soc_dapm_nc_pin(codec, "OUT3");
+	snd_soc_dapm_nc_pin(codec, "MONO");
+
+	/* Add jive specific widgets */
+	err = snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
+					ARRAY_SIZE(wm8750_dapm_widgets));
+	if (err) {
+		printk(KERN_ERR "%s: failed to add widgets (%d)\n",
+		       __func__, err);
+		return err;
+	}
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link jive_dai = {
+	.name		= "wm8750",
+	.stream_name	= "WM8750",
+	.cpu_dai	= &s3c2412_i2s_dai,
+	.codec_dai	= &wm8750_dai,
+	.init		= jive_wm8750_init,
+	.ops		= &jive_ops,
+};
+
+/* jive audio machine driver */
+static struct snd_soc_card snd_soc_machine_jive = {
+	.name		= "Jive",
+	.platform	= &s3c24xx_soc_platform,
+	.dai_link	= &jive_dai,
+	.num_links	= 1,
+};
+
+/* jive audio subsystem */
+static struct snd_soc_device jive_snd_devdata = {
+	.card		= &snd_soc_machine_jive,
+	.codec_dev	= &soc_codec_dev_wm8750,
+};
+
+static struct platform_device *jive_snd_device;
+
+static int __init jive_init(void)
+{
+	int ret;
+
+	if (!machine_is_jive())
+		return 0;
+
+	printk("JIVE WM8750 Audio support\n");
+
+	jive_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!jive_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(jive_snd_device, &jive_snd_devdata);
+	jive_snd_devdata.dev = &jive_snd_device->dev;
+	ret = platform_device_add(jive_snd_device);
+
+	if (ret)
+		platform_device_put(jive_snd_device);
+
+	return ret;
+}
+
+static void __exit jive_exit(void)
+{
+	platform_device_unregister(jive_snd_device);
+}
+
+module_init(jive_init);
+module_exit(jive_exit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("ALSA SoC Jive Audio support");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/lm4857.h b/sound/soc/samsung/lm4857.h
new file mode 100644
index 0000000..0cf5b70
--- /dev/null
+++ b/sound/soc/samsung/lm4857.h
@@ -0,0 +1,32 @@
+/*
+ * lm4857.h  --  ALSA Soc Audio Layer
+ *
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Revision history
+ *    18th Jun 2007   Initial version.
+ */
+
+#ifndef LM4857_H_
+#define LM4857_H_
+
+/* The register offsets in the cache array */
+#define LM4857_MVOL 0
+#define LM4857_LVOL 1
+#define LM4857_RVOL 2
+#define LM4857_CTRL 3
+
+/* the shifts required to set these bits */
+#define LM4857_3D 5
+#define LM4857_WAKEUP 5
+#define LM4857_EPGAIN 4
+
+#endif /*LM4857_H_*/
+
diff --git a/sound/soc/samsung/ln2440sbc_alc650.c b/sound/soc/samsung/ln2440sbc_alc650.c
new file mode 100644
index 0000000..ffa954f
--- /dev/null
+++ b/sound/soc/samsung/ln2440sbc_alc650.c
@@ -0,0 +1,85 @@
+/*
+ * SoC audio for ln2440sbc
+ *
+ * Copyright 2007 KonekTel, a.s.
+ * Author: Ivan Kuten
+ *         ivan.kuten@promwad.com
+ *
+ * Heavily based on smdk2443_wm9710.c
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "../codecs/ac97.h"
+#include "s3c-dma.h"
+#include "s3c-ac97.h"
+
+static struct snd_soc_card ln2440sbc;
+
+static struct snd_soc_dai_link ln2440sbc_dai[] = {
+{
+	.name = "AC97",
+	.stream_name = "AC97 HiFi",
+	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
+	.codec_dai = &ac97_dai,
+},
+};
+
+static struct snd_soc_card ln2440sbc = {
+	.name = "LN2440SBC",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = ln2440sbc_dai,
+	.num_links = ARRAY_SIZE(ln2440sbc_dai),
+};
+
+static struct snd_soc_device ln2440sbc_snd_ac97_devdata = {
+	.card = &ln2440sbc,
+	.codec_dev = &soc_codec_dev_ac97,
+};
+
+static struct platform_device *ln2440sbc_snd_ac97_device;
+
+static int __init ln2440sbc_init(void)
+{
+	int ret;
+
+	ln2440sbc_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!ln2440sbc_snd_ac97_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(ln2440sbc_snd_ac97_device,
+				&ln2440sbc_snd_ac97_devdata);
+	ln2440sbc_snd_ac97_devdata.dev = &ln2440sbc_snd_ac97_device->dev;
+	ret = platform_device_add(ln2440sbc_snd_ac97_device);
+
+	if (ret)
+		platform_device_put(ln2440sbc_snd_ac97_device);
+
+	return ret;
+}
+
+static void __exit ln2440sbc_exit(void)
+{
+	platform_device_unregister(ln2440sbc_snd_ac97_device);
+}
+
+module_init(ln2440sbc_init);
+module_exit(ln2440sbc_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ivan Kuten");
+MODULE_DESCRIPTION("ALSA SoC ALC650 LN2440SBC");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/neo1973_gta02_wm8753.c b/sound/soc/samsung/neo1973_gta02_wm8753.c
new file mode 100644
index 0000000..209c259
--- /dev/null
+++ b/sound/soc/samsung/neo1973_gta02_wm8753.c
@@ -0,0 +1,506 @@
+/*
+ * neo1973_gta02_wm8753.c  --  SoC audio for Openmoko Freerunner(GTA02)
+ *
+ * Copyright 2007 Openmoko Inc
+ * Author: Graeme Gregory <graeme@openmoko.org>
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory <linux@wolfsonmicro.com>
+ * Copyright 2009 Wolfson Microelectronics
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+
+#include <plat/regs-iis.h>
+
+#include <mach/regs-clock.h>
+#include <asm/io.h>
+#include <mach/gta02.h>
+#include "../codecs/wm8753.h"
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+
+static struct snd_soc_card neo1973_gta02;
+
+static int neo1973_gta02_hifi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int pll_out = 0, bclk = 0;
+	int ret = 0;
+	unsigned long iis_clkrate;
+
+	iis_clkrate = s3c24xx_i2s_get_clockrate();
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+		pll_out = 12288000;
+		break;
+	case 48000:
+		bclk = WM8753_BCLK_DIV_4;
+		pll_out = 12288000;
+		break;
+	case 96000:
+		bclk = WM8753_BCLK_DIV_2;
+		pll_out = 12288000;
+		break;
+	case 11025:
+		bclk = WM8753_BCLK_DIV_16;
+		pll_out = 11289600;
+		break;
+	case 22050:
+		bclk = WM8753_BCLK_DIV_8;
+		pll_out = 11289600;
+		break;
+	case 44100:
+		bclk = WM8753_BCLK_DIV_4;
+		pll_out = 11289600;
+		break;
+	case 88200:
+		bclk = WM8753_BCLK_DIV_2;
+		pll_out = 11289600;
+		break;
+	}
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai,
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_MCLK, pll_out,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set MCLK division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
+		S3C2410_IISMOD_32FS);
+	if (ret < 0)
+		return ret;
+
+	/* set codec BCLK division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(codec_dai,
+					WM8753_BCLKDIV, bclk);
+	if (ret < 0)
+		return ret;
+
+	/* set prescaler division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+		S3C24XX_PRESCALE(4, 4));
+	if (ret < 0)
+		return ret;
+
+	/* codec PLL input is PCLK/4 */
+	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0,
+		iis_clkrate / 4, pll_out);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int neo1973_gta02_hifi_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	/* disable the PLL */
+	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0, 0, 0);
+}
+
+/*
+ * Neo1973 WM8753 HiFi DAI opserations.
+ */
+static struct snd_soc_ops neo1973_gta02_hifi_ops = {
+	.hw_params = neo1973_gta02_hifi_hw_params,
+	.hw_free = neo1973_gta02_hifi_hw_free,
+};
+
+static int neo1973_gta02_voice_hw_params(
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	unsigned int pcmdiv = 0;
+	int ret = 0;
+	unsigned long iis_clkrate;
+
+	iis_clkrate = s3c24xx_i2s_get_clockrate();
+
+	if (params_rate(params) != 8000)
+		return -EINVAL;
+	if (params_channels(params) != 1)
+		return -EINVAL;
+
+	pcmdiv = WM8753_PCM_DIV_6; /* 2.048 MHz */
+
+	/* todo: gg check mode (DSP_B) against CSR datasheet */
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_PCMCLK,
+		12288000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set codec PCM division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8753_PCMDIV,
+					pcmdiv);
+	if (ret < 0)
+		return ret;
+
+	/* configue and enable PLL for 12.288MHz output */
+	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0,
+		iis_clkrate / 4, 12288000);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int neo1973_gta02_voice_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	/* disable the PLL */
+	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0, 0, 0);
+}
+
+static struct snd_soc_ops neo1973_gta02_voice_ops = {
+	.hw_params = neo1973_gta02_voice_hw_params,
+	.hw_free = neo1973_gta02_voice_hw_free,
+};
+
+#define LM4853_AMP 1
+#define LM4853_SPK 2
+
+static u8 lm4853_state;
+
+/* This has no effect, it exists only to maintain compatibility with
+ * existing ALSA state files.
+ */
+static int lm4853_set_state(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	int val = ucontrol->value.integer.value[0];
+
+	if (val)
+		lm4853_state |= LM4853_AMP;
+	else
+		lm4853_state &= ~LM4853_AMP;
+
+	return 0;
+}
+
+static int lm4853_get_state(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = lm4853_state & LM4853_AMP;
+
+	return 0;
+}
+
+static int lm4853_set_spk(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	int val = ucontrol->value.integer.value[0];
+
+	if (val) {
+		lm4853_state |= LM4853_SPK;
+		gpio_set_value(GTA02_GPIO_HP_IN, 0);
+	} else {
+		lm4853_state &= ~LM4853_SPK;
+		gpio_set_value(GTA02_GPIO_HP_IN, 1);
+	}
+
+	return 0;
+}
+
+static int lm4853_get_spk(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = (lm4853_state & LM4853_SPK) >> 1;
+
+	return 0;
+}
+
+static int lm4853_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k,
+			int event)
+{
+	gpio_set_value(GTA02_GPIO_AMP_SHUT, SND_SOC_DAPM_EVENT_OFF(value));
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget wm8753_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Stereo Out", lm4853_event),
+	SND_SOC_DAPM_LINE("GSM Line Out", NULL),
+	SND_SOC_DAPM_LINE("GSM Line In", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Handset Mic", NULL),
+	SND_SOC_DAPM_SPK("Handset Spk", NULL),
+};
+
+
+/* example machine audio_mapnections */
+static const struct snd_soc_dapm_route audio_map[] = {
+
+	/* Connections to the lm4853 amp */
+	{"Stereo Out", NULL, "LOUT1"},
+	{"Stereo Out", NULL, "ROUT1"},
+
+	/* Connections to the GSM Module */
+	{"GSM Line Out", NULL, "MONO1"},
+	{"GSM Line Out", NULL, "MONO2"},
+	{"RXP", NULL, "GSM Line In"},
+	{"RXN", NULL, "GSM Line In"},
+
+	/* Connections to Headset */
+	{"MIC1", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Headset Mic"},
+
+	/* Call Mic */
+	{"MIC2", NULL, "Mic Bias"},
+	{"MIC2N", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Handset Mic"},
+
+	/* Call Speaker */
+	{"Handset Spk", NULL, "LOUT2"},
+	{"Handset Spk", NULL, "ROUT2"},
+
+	/* Connect the ALC pins */
+	{"ACIN", NULL, "ACOP"},
+};
+
+static const struct snd_kcontrol_new wm8753_neo1973_gta02_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Stereo Out"),
+	SOC_DAPM_PIN_SWITCH("GSM Line Out"),
+	SOC_DAPM_PIN_SWITCH("GSM Line In"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Handset Mic"),
+	SOC_DAPM_PIN_SWITCH("Handset Spk"),
+
+	/* This has no effect, it exists only to maintain compatibility with
+	 * existing ALSA state files.
+	 */
+	SOC_SINGLE_EXT("Amp State Switch", 6, 0, 1, 0,
+		lm4853_get_state,
+		lm4853_set_state),
+	SOC_SINGLE_EXT("Amp Spk Switch", 7, 0, 1, 0,
+		lm4853_get_spk,
+		lm4853_set_spk),
+};
+
+/*
+ * This is an example machine initialisation for a wm8753 connected to a
+ * neo1973 GTA02.
+ */
+static int neo1973_gta02_wm8753_init(struct snd_soc_codec *codec)
+{
+	int err;
+
+	/* set up NC codec pins */
+	snd_soc_dapm_nc_pin(codec, "OUT3");
+	snd_soc_dapm_nc_pin(codec, "OUT4");
+	snd_soc_dapm_nc_pin(codec, "LINE1");
+	snd_soc_dapm_nc_pin(codec, "LINE2");
+
+	/* Add neo1973 gta02 specific widgets */
+	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
+				  ARRAY_SIZE(wm8753_dapm_widgets));
+
+	/* add neo1973 gta02 specific controls */
+	err = snd_soc_add_controls(codec, wm8753_neo1973_gta02_controls,
+		ARRAY_SIZE(wm8753_neo1973_gta02_controls));
+
+	if (err < 0)
+		return err;
+
+	/* set up neo1973 gta02 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	/* set endpoints to default off mode */
+	snd_soc_dapm_disable_pin(codec, "Stereo Out");
+	snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+	snd_soc_dapm_disable_pin(codec, "GSM Line In");
+	snd_soc_dapm_disable_pin(codec, "Headset Mic");
+	snd_soc_dapm_disable_pin(codec, "Handset Mic");
+	snd_soc_dapm_disable_pin(codec, "Handset Spk");
+
+	/* allow audio paths from the GSM modem to run during suspend */
+	snd_soc_dapm_ignore_suspend(codec, "Stereo Out");
+	snd_soc_dapm_ignore_suspend(codec, "GSM Line Out");
+	snd_soc_dapm_ignore_suspend(codec, "GSM Line In");
+	snd_soc_dapm_ignore_suspend(codec, "Headset Mic");
+	snd_soc_dapm_ignore_suspend(codec, "Handset Mic");
+	snd_soc_dapm_ignore_suspend(codec, "Handset Spk");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+/*
+ * BT Codec DAI
+ */
+static struct snd_soc_dai bt_dai = {
+	.name = "Bluetooth",
+	.id = 0,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+};
+
+static struct snd_soc_dai_link neo1973_gta02_dai[] = {
+{ /* Hifi Playback - for similatious use with voice below */
+	.name = "WM8753",
+	.stream_name = "WM8753 HiFi",
+	.cpu_dai = &s3c24xx_i2s_dai,
+	.codec_dai = &wm8753_dai[WM8753_DAI_HIFI],
+	.init = neo1973_gta02_wm8753_init,
+	.ops = &neo1973_gta02_hifi_ops,
+},
+{ /* Voice via BT */
+	.name = "Bluetooth",
+	.stream_name = "Voice",
+	.cpu_dai = &bt_dai,
+	.codec_dai = &wm8753_dai[WM8753_DAI_VOICE],
+	.ops = &neo1973_gta02_voice_ops,
+},
+};
+
+static struct snd_soc_card neo1973_gta02 = {
+	.name = "neo1973-gta02",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = neo1973_gta02_dai,
+	.num_links = ARRAY_SIZE(neo1973_gta02_dai),
+};
+
+static struct snd_soc_device neo1973_gta02_snd_devdata = {
+	.card = &neo1973_gta02,
+	.codec_dev = &soc_codec_dev_wm8753,
+};
+
+static struct platform_device *neo1973_gta02_snd_device;
+
+static int __init neo1973_gta02_init(void)
+{
+	int ret;
+
+	if (!machine_is_neo1973_gta02()) {
+		printk(KERN_INFO
+		       "Only GTA02 is supported by this ASoC driver\n");
+		return -ENODEV;
+	}
+
+	/* register bluetooth DAI here */
+	ret = snd_soc_register_dai(&bt_dai);
+	if (ret)
+		return ret;
+
+	neo1973_gta02_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!neo1973_gta02_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(neo1973_gta02_snd_device,
+			&neo1973_gta02_snd_devdata);
+	neo1973_gta02_snd_devdata.dev = &neo1973_gta02_snd_device->dev;
+	ret = platform_device_add(neo1973_gta02_snd_device);
+
+	if (ret) {
+		platform_device_put(neo1973_gta02_snd_device);
+		return ret;
+	}
+
+	/* Initialise GPIOs used by amp */
+	ret = gpio_request(GTA02_GPIO_HP_IN, "GTA02_HP_IN");
+	if (ret) {
+		pr_err("gta02_wm8753: Failed to register GPIO %d\n", GTA02_GPIO_HP_IN);
+		goto err_unregister_device;
+	}
+
+	ret = gpio_direction_output(GTA02_GPIO_AMP_HP_IN, 1);
+	if (ret) {
+		pr_err("gta02_wm8753: Failed to configure GPIO %d\n", GTA02_GPIO_HP_IN);
+		goto err_free_gpio_hp_in;
+	}
+
+	ret = gpio_request(GTA02_GPIO_AMP_SHUT, "GTA02_AMP_SHUT");
+	if (ret) {
+		pr_err("gta02_wm8753: Failed to register GPIO %d\n", GTA02_GPIO_AMP_SHUT);
+		goto err_free_gpio_hp_in;
+	}
+
+	ret = gpio_direction_output(GTA02_GPIO_AMP_SHUT, 1);
+	if (ret) {
+		pr_err("gta02_wm8753: Failed to configure GPIO %d\n", GTA02_GPIO_AMP_SHUT);
+		goto err_free_gpio_amp_shut;
+	}
+
+	return 0;
+
+err_free_gpio_amp_shut:
+	gpio_free(GTA02_GPIO_AMP_SHUT);
+err_free_gpio_hp_in:
+	gpio_free(GTA02_GPIO_HP_IN);
+err_unregister_device:
+	platform_device_unregister(neo1973_gta02_snd_device);
+	return ret;
+}
+module_init(neo1973_gta02_init);
+
+static void __exit neo1973_gta02_exit(void)
+{
+	snd_soc_unregister_dai(&bt_dai);
+	platform_device_unregister(neo1973_gta02_snd_device);
+	gpio_free(GTA02_GPIO_HP_IN);
+	gpio_free(GTA02_GPIO_AMP_SHUT);
+}
+module_exit(neo1973_gta02_exit);
+
+/* Module information */
+MODULE_AUTHOR("Graeme Gregory, graeme@openmoko.org");
+MODULE_DESCRIPTION("ALSA SoC WM8753 Neo1973 GTA02");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
new file mode 100644
index 0000000..0cb4f86
--- /dev/null
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -0,0 +1,707 @@
+/*
+ * neo1973_wm8753.c  --  SoC audio for Neo1973
+ *
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#include <asm/mach-types.h>
+#include <asm/hardware/scoop.h>
+#include <mach/regs-clock.h>
+#include <mach/regs-gpio.h>
+#include <mach/hardware.h>
+#include <linux/io.h>
+#include <mach/spi-gpio.h>
+
+#include <plat/regs-iis.h>
+
+#include "../codecs/wm8753.h"
+#include "lm4857.h"
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+
+/* define the scenarios */
+#define NEO_AUDIO_OFF			0
+#define NEO_GSM_CALL_AUDIO_HANDSET	1
+#define NEO_GSM_CALL_AUDIO_HEADSET	2
+#define NEO_GSM_CALL_AUDIO_BLUETOOTH	3
+#define NEO_STEREO_TO_SPEAKERS		4
+#define NEO_STEREO_TO_HEADPHONES	5
+#define NEO_CAPTURE_HANDSET		6
+#define NEO_CAPTURE_HEADSET		7
+#define NEO_CAPTURE_BLUETOOTH		8
+
+static struct snd_soc_card neo1973;
+static struct i2c_client *i2c;
+
+static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int pll_out = 0, bclk = 0;
+	int ret = 0;
+	unsigned long iis_clkrate;
+
+	pr_debug("Entered %s\n", __func__);
+
+	iis_clkrate = s3c24xx_i2s_get_clockrate();
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+		pll_out = 12288000;
+		break;
+	case 48000:
+		bclk = WM8753_BCLK_DIV_4;
+		pll_out = 12288000;
+		break;
+	case 96000:
+		bclk = WM8753_BCLK_DIV_2;
+		pll_out = 12288000;
+		break;
+	case 11025:
+		bclk = WM8753_BCLK_DIV_16;
+		pll_out = 11289600;
+		break;
+	case 22050:
+		bclk = WM8753_BCLK_DIV_8;
+		pll_out = 11289600;
+		break;
+	case 44100:
+		bclk = WM8753_BCLK_DIV_4;
+		pll_out = 11289600;
+		break;
+	case 88200:
+		bclk = WM8753_BCLK_DIV_2;
+		pll_out = 11289600;
+		break;
+	}
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai,
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_MCLK, pll_out,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set MCLK division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
+		S3C2410_IISMOD_32FS);
+	if (ret < 0)
+		return ret;
+
+	/* set codec BCLK division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8753_BCLKDIV, bclk);
+	if (ret < 0)
+		return ret;
+
+	/* set prescaler division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+		S3C24XX_PRESCALE(4, 4));
+	if (ret < 0)
+		return ret;
+
+	/* codec PLL input is PCLK/4 */
+	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0,
+		iis_clkrate / 4, pll_out);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int neo1973_hifi_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* disable the PLL */
+	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0, 0, 0);
+}
+
+/*
+ * Neo1973 WM8753 HiFi DAI opserations.
+ */
+static struct snd_soc_ops neo1973_hifi_ops = {
+	.hw_params = neo1973_hifi_hw_params,
+	.hw_free = neo1973_hifi_hw_free,
+};
+
+static int neo1973_voice_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	unsigned int pcmdiv = 0;
+	int ret = 0;
+	unsigned long iis_clkrate;
+
+	pr_debug("Entered %s\n", __func__);
+
+	iis_clkrate = s3c24xx_i2s_get_clockrate();
+
+	if (params_rate(params) != 8000)
+		return -EINVAL;
+	if (params_channels(params) != 1)
+		return -EINVAL;
+
+	pcmdiv = WM8753_PCM_DIV_6; /* 2.048 MHz */
+
+	/* todo: gg check mode (DSP_B) against CSR datasheet */
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_PCMCLK, 12288000,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* set codec PCM division for sample rate */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8753_PCMDIV, pcmdiv);
+	if (ret < 0)
+		return ret;
+
+	/* configue and enable PLL for 12.288MHz output */
+	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0,
+		iis_clkrate / 4, 12288000);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int neo1973_voice_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* disable the PLL */
+	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0, 0, 0);
+}
+
+static struct snd_soc_ops neo1973_voice_ops = {
+	.hw_params = neo1973_voice_hw_params,
+	.hw_free = neo1973_voice_hw_free,
+};
+
+static int neo1973_scenario;
+
+static int neo1973_get_scenario(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = neo1973_scenario;
+	return 0;
+}
+
+static int set_scenario_endpoints(struct snd_soc_codec *codec, int scenario)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	switch (neo1973_scenario) {
+	case NEO_AUDIO_OFF:
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		break;
+	case NEO_GSM_CALL_AUDIO_HANDSET:
+		snd_soc_dapm_enable_pin(codec, "Audio Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_enable_pin(codec, "Call Mic");
+		break;
+	case NEO_GSM_CALL_AUDIO_HEADSET:
+		snd_soc_dapm_enable_pin(codec, "Audio Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line In");
+		snd_soc_dapm_enable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		break;
+	case NEO_GSM_CALL_AUDIO_BLUETOOTH:
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		break;
+	case NEO_STEREO_TO_SPEAKERS:
+		snd_soc_dapm_enable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		break;
+	case NEO_STEREO_TO_HEADPHONES:
+		snd_soc_dapm_enable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		break;
+	case NEO_CAPTURE_HANDSET:
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_enable_pin(codec, "Call Mic");
+		break;
+	case NEO_CAPTURE_HEADSET:
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_enable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		break;
+	case NEO_CAPTURE_BLUETOOTH:
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		break;
+	default:
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
+	}
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static int neo1973_set_scenario(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (neo1973_scenario == ucontrol->value.integer.value[0])
+		return 0;
+
+	neo1973_scenario = ucontrol->value.integer.value[0];
+	set_scenario_endpoints(codec, neo1973_scenario);
+	return 1;
+}
+
+static u8 lm4857_regs[4] = {0x00, 0x40, 0x80, 0xC0};
+
+static void lm4857_write_regs(void)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	if (i2c_master_send(i2c, lm4857_regs, 4) != 4)
+		printk(KERN_ERR "lm4857: i2c write failed\n");
+}
+
+static int lm4857_get_reg(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int reg = mc->reg;
+	int shift = mc->shift;
+	int mask = mc->max;
+
+	pr_debug("Entered %s\n", __func__);
+
+	ucontrol->value.integer.value[0] = (lm4857_regs[reg] >> shift) & mask;
+	return 0;
+}
+
+static int lm4857_set_reg(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int reg = mc->reg;
+	int shift = mc->shift;
+	int mask = mc->max;
+
+	if (((lm4857_regs[reg] >> shift) & mask) ==
+		ucontrol->value.integer.value[0])
+		return 0;
+
+	lm4857_regs[reg] &= ~(mask << shift);
+	lm4857_regs[reg] |= ucontrol->value.integer.value[0] << shift;
+	lm4857_write_regs();
+	return 1;
+}
+
+static int lm4857_get_mode(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	u8 value = lm4857_regs[LM4857_CTRL] & 0x0F;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (value)
+		value -= 5;
+
+	ucontrol->value.integer.value[0] = value;
+	return 0;
+}
+
+static int lm4857_set_mode(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	u8 value = ucontrol->value.integer.value[0];
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (value)
+		value += 5;
+
+	if ((lm4857_regs[LM4857_CTRL] & 0x0F) == value)
+		return 0;
+
+	lm4857_regs[LM4857_CTRL] &= 0xF0;
+	lm4857_regs[LM4857_CTRL] |= value;
+	lm4857_write_regs();
+	return 1;
+}
+
+static const struct snd_soc_dapm_widget wm8753_dapm_widgets[] = {
+	SND_SOC_DAPM_LINE("Audio Out", NULL),
+	SND_SOC_DAPM_LINE("GSM Line Out", NULL),
+	SND_SOC_DAPM_LINE("GSM Line In", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Call Mic", NULL),
+};
+
+
+static const struct snd_soc_dapm_route dapm_routes[] = {
+
+	/* Connections to the lm4857 amp */
+	{"Audio Out", NULL, "LOUT1"},
+	{"Audio Out", NULL, "ROUT1"},
+
+	/* Connections to the GSM Module */
+	{"GSM Line Out", NULL, "MONO1"},
+	{"GSM Line Out", NULL, "MONO2"},
+	{"RXP", NULL, "GSM Line In"},
+	{"RXN", NULL, "GSM Line In"},
+
+	/* Connections to Headset */
+	{"MIC1", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Headset Mic"},
+
+	/* Call Mic */
+	{"MIC2", NULL, "Mic Bias"},
+	{"MIC2N", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Call Mic"},
+
+	/* Connect the ALC pins */
+	{"ACIN", NULL, "ACOP"},
+};
+
+static const char *lm4857_mode[] = {
+	"Off",
+	"Call Speaker",
+	"Stereo Speakers",
+	"Stereo Speakers + Headphones",
+	"Headphones"
+};
+
+static const struct soc_enum lm4857_mode_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(lm4857_mode), lm4857_mode),
+};
+
+static const char *neo_scenarios[] = {
+	"Off",
+	"GSM Handset",
+	"GSM Headset",
+	"GSM Bluetooth",
+	"Speakers",
+	"Headphones",
+	"Capture Handset",
+	"Capture Headset",
+	"Capture Bluetooth"
+};
+
+static const struct soc_enum neo_scenario_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(neo_scenarios), neo_scenarios),
+};
+
+static const DECLARE_TLV_DB_SCALE(stereo_tlv, -4050, 150, 0);
+static const DECLARE_TLV_DB_SCALE(mono_tlv, -3450, 150, 0);
+
+static const struct snd_kcontrol_new wm8753_neo1973_controls[] = {
+	SOC_SINGLE_EXT_TLV("Amp Left Playback Volume", LM4857_LVOL, 0, 31, 0,
+		lm4857_get_reg, lm4857_set_reg, stereo_tlv),
+	SOC_SINGLE_EXT_TLV("Amp Right Playback Volume", LM4857_RVOL, 0, 31, 0,
+		lm4857_get_reg, lm4857_set_reg, stereo_tlv),
+	SOC_SINGLE_EXT_TLV("Amp Mono Playback Volume", LM4857_MVOL, 0, 31, 0,
+		lm4857_get_reg, lm4857_set_reg, mono_tlv),
+	SOC_ENUM_EXT("Amp Mode", lm4857_mode_enum[0],
+		lm4857_get_mode, lm4857_set_mode),
+	SOC_ENUM_EXT("Neo Mode", neo_scenario_enum[0],
+		neo1973_get_scenario, neo1973_set_scenario),
+	SOC_SINGLE_EXT("Amp Spk 3D Playback Switch", LM4857_LVOL, 5, 1, 0,
+		lm4857_get_reg, lm4857_set_reg),
+	SOC_SINGLE_EXT("Amp HP 3d Playback Switch", LM4857_RVOL, 5, 1, 0,
+		lm4857_get_reg, lm4857_set_reg),
+	SOC_SINGLE_EXT("Amp Fast Wakeup Playback Switch", LM4857_CTRL, 5, 1, 0,
+		lm4857_get_reg, lm4857_set_reg),
+	SOC_SINGLE_EXT("Amp Earpiece 6dB Playback Switch", LM4857_CTRL, 4, 1, 0,
+		lm4857_get_reg, lm4857_set_reg),
+};
+
+/*
+ * This is an example machine initialisation for a wm8753 connected to a
+ * neo1973 II. It is missing logic to detect hp/mic insertions and logic
+ * to re-route the audio in such an event.
+ */
+static int neo1973_wm8753_init(struct snd_soc_codec *codec)
+{
+	int err;
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* set up NC codec pins */
+	snd_soc_dapm_nc_pin(codec, "LOUT2");
+	snd_soc_dapm_nc_pin(codec, "ROUT2");
+	snd_soc_dapm_nc_pin(codec, "OUT3");
+	snd_soc_dapm_nc_pin(codec, "OUT4");
+	snd_soc_dapm_nc_pin(codec, "LINE1");
+	snd_soc_dapm_nc_pin(codec, "LINE2");
+
+	/* Add neo1973 specific widgets */
+	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
+				  ARRAY_SIZE(wm8753_dapm_widgets));
+
+	/* set endpoints to default mode */
+	set_scenario_endpoints(codec, NEO_AUDIO_OFF);
+
+	/* add neo1973 specific controls */
+	err = snd_soc_add_controls(codec, wm8753_neo1973_controls,
+				ARRAY_SIZE(8753_neo1973_controls));
+	if (err < 0)
+		return err;
+
+	/* set up neo1973 specific audio routes */
+	err = snd_soc_dapm_add_routes(codec, dapm_routes,
+				      ARRAY_SIZE(dapm_routes));
+
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+/*
+ * BT Codec DAI
+ */
+static struct snd_soc_dai bt_dai = {
+	.name = "Bluetooth",
+	.id = 0,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+};
+
+static struct snd_soc_dai_link neo1973_dai[] = {
+{ /* Hifi Playback - for similatious use with voice below */
+	.name = "WM8753",
+	.stream_name = "WM8753 HiFi",
+	.cpu_dai = &s3c24xx_i2s_dai,
+	.codec_dai = &wm8753_dai[WM8753_DAI_HIFI],
+	.init = neo1973_wm8753_init,
+	.ops = &neo1973_hifi_ops,
+},
+{ /* Voice via BT */
+	.name = "Bluetooth",
+	.stream_name = "Voice",
+	.cpu_dai = &bt_dai,
+	.codec_dai = &wm8753_dai[WM8753_DAI_VOICE],
+	.ops = &neo1973_voice_ops,
+},
+};
+
+static struct snd_soc_card neo1973 = {
+	.name = "neo1973",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = neo1973_dai,
+	.num_links = ARRAY_SIZE(neo1973_dai),
+};
+
+static struct snd_soc_device neo1973_snd_devdata = {
+	.card = &neo1973,
+	.codec_dev = &soc_codec_dev_wm8753,
+};
+
+static int lm4857_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	i2c = client;
+
+	lm4857_write_regs();
+	return 0;
+}
+
+static int lm4857_i2c_remove(struct i2c_client *client)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	i2c = NULL;
+
+	return 0;
+}
+
+static u8 lm4857_state;
+
+static int lm4857_suspend(struct i2c_client *dev, pm_message_t state)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	dev_dbg(&dev->dev, "lm4857_suspend\n");
+	lm4857_state = lm4857_regs[LM4857_CTRL] & 0xf;
+	if (lm4857_state) {
+		lm4857_regs[LM4857_CTRL] &= 0xf0;
+		lm4857_write_regs();
+	}
+	return 0;
+}
+
+static int lm4857_resume(struct i2c_client *dev)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	if (lm4857_state) {
+		lm4857_regs[LM4857_CTRL] |= (lm4857_state & 0x0f);
+		lm4857_write_regs();
+	}
+	return 0;
+}
+
+static void lm4857_shutdown(struct i2c_client *dev)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	dev_dbg(&dev->dev, "lm4857_shutdown\n");
+	lm4857_regs[LM4857_CTRL] &= 0xf0;
+	lm4857_write_regs();
+}
+
+static const struct i2c_device_id lm4857_i2c_id[] = {
+	{ "neo1973_lm4857", 0 },
+	{ }
+};
+
+static struct i2c_driver lm4857_i2c_driver = {
+	.driver = {
+		.name = "LM4857 I2C Amp",
+		.owner = THIS_MODULE,
+	},
+	.suspend =        lm4857_suspend,
+	.resume	=         lm4857_resume,
+	.shutdown =       lm4857_shutdown,
+	.probe =          lm4857_i2c_probe,
+	.remove =         lm4857_i2c_remove,
+	.id_table =       lm4857_i2c_id,
+};
+
+static struct platform_device *neo1973_snd_device;
+
+static int __init neo1973_init(void)
+{
+	int ret;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (!machine_is_neo1973_gta01()) {
+		printk(KERN_INFO
+			"Only GTA01 hardware supported by ASoC driver\n");
+		return -ENODEV;
+	}
+
+	neo1973_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!neo1973_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(neo1973_snd_device, &neo1973_snd_devdata);
+	neo1973_snd_devdata.dev = &neo1973_snd_device->dev;
+	ret = platform_device_add(neo1973_snd_device);
+
+	if (ret) {
+		platform_device_put(neo1973_snd_device);
+		return ret;
+	}
+
+	ret = i2c_add_driver(&lm4857_i2c_driver);
+
+	if (ret != 0)
+		platform_device_unregister(neo1973_snd_device);
+
+	return ret;
+}
+
+static void __exit neo1973_exit(void)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	i2c_del_driver(&lm4857_i2c_driver);
+	platform_device_unregister(neo1973_snd_device);
+}
+
+module_init(neo1973_init);
+module_exit(neo1973_exit);
+
+/* Module information */
+MODULE_AUTHOR("Graeme Gregory, graeme@openmoko.org, www.openmoko.org");
+MODULE_DESCRIPTION("ALSA SoC WM8753 Neo1973");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/regs-i2s-v2.h b/sound/soc/samsung/regs-i2s-v2.h
new file mode 100644
index 0000000..5e5e568
--- /dev/null
+++ b/sound/soc/samsung/regs-i2s-v2.h
@@ -0,0 +1,115 @@
+/* linux/include/asm-arm/plat-s3c24xx/regs-s3c2412-iis.h
+ *
+ * Copyright 2007 Simtec Electronics <linux@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2412 IIS register definition
+*/
+
+#ifndef __ASM_ARCH_REGS_S3C2412_IIS_H
+#define __ASM_ARCH_REGS_S3C2412_IIS_H
+
+#define S3C2412_IISCON			(0x00)
+#define S3C2412_IISMOD			(0x04)
+#define S3C2412_IISFIC			(0x08)
+#define S3C2412_IISPSR			(0x0C)
+#define S3C2412_IISTXD			(0x10)
+#define S3C2412_IISRXD			(0x14)
+
+#define S5PC1XX_IISFICS		0x18
+#define S5PC1XX_IISTXDS		0x1C
+
+#define S5PC1XX_IISCON_SW_RST		(1 << 31)
+#define S5PC1XX_IISCON_FRXOFSTATUS	(1 << 26)
+#define S5PC1XX_IISCON_FRXORINTEN	(1 << 25)
+#define S5PC1XX_IISCON_FTXSURSTAT	(1 << 24)
+#define S5PC1XX_IISCON_FTXSURINTEN	(1 << 23)
+#define S5PC1XX_IISCON_TXSDMAPAUSE	(1 << 20)
+#define S5PC1XX_IISCON_TXSDMACTIVE	(1 << 18)
+
+#define S3C64XX_IISCON_FTXURSTATUS	(1 << 17)
+#define S3C64XX_IISCON_FTXURINTEN	(1 << 16)
+#define S3C64XX_IISCON_TXFIFO2_EMPTY	(1 << 15)
+#define S3C64XX_IISCON_TXFIFO1_EMPTY	(1 << 14)
+#define S3C64XX_IISCON_TXFIFO2_FULL	(1 << 13)
+#define S3C64XX_IISCON_TXFIFO1_FULL	(1 << 12)
+
+#define S3C2412_IISCON_LRINDEX		(1 << 11)
+#define S3C2412_IISCON_TXFIFO_EMPTY	(1 << 10)
+#define S3C2412_IISCON_RXFIFO_EMPTY	(1 << 9)
+#define S3C2412_IISCON_TXFIFO_FULL	(1 << 8)
+#define S3C2412_IISCON_RXFIFO_FULL	(1 << 7)
+#define S3C2412_IISCON_TXDMA_PAUSE	(1 << 6)
+#define S3C2412_IISCON_RXDMA_PAUSE	(1 << 5)
+#define S3C2412_IISCON_TXCH_PAUSE	(1 << 4)
+#define S3C2412_IISCON_RXCH_PAUSE	(1 << 3)
+#define S3C2412_IISCON_TXDMA_ACTIVE	(1 << 2)
+#define S3C2412_IISCON_RXDMA_ACTIVE	(1 << 1)
+#define S3C2412_IISCON_IIS_ACTIVE	(1 << 0)
+
+#define S5PC1XX_IISMOD_OPCLK_CDCLK_OUT	(0 << 30)
+#define S5PC1XX_IISMOD_OPCLK_CDCLK_IN	(1 << 30)
+#define S5PC1XX_IISMOD_OPCLK_BCLK_OUT	(2 << 30)
+#define S5PC1XX_IISMOD_OPCLK_PCLK	(3 << 30)
+#define S5PC1XX_IISMOD_OPCLK_MASK	(3 << 30)
+#define S5PC1XX_IISMOD_TXS_IDMA		(1 << 28) /* Sec_TXFIFO use I-DMA */
+#define S5PC1XX_IISMOD_BLCS_MASK	0x3
+#define S5PC1XX_IISMOD_BLCS_SHIFT	26
+#define S5PC1XX_IISMOD_BLCP_MASK	0x3
+#define S5PC1XX_IISMOD_BLCP_SHIFT	24
+
+#define S3C64XX_IISMOD_C2DD_HHALF	(1 << 21) /* Discard Higher-half */
+#define S3C64XX_IISMOD_C2DD_LHALF	(1 << 20) /* Discard Lower-half */
+#define S3C64XX_IISMOD_C1DD_HHALF	(1 << 19)
+#define S3C64XX_IISMOD_C1DD_LHALF	(1 << 18)
+#define S3C64XX_IISMOD_DC2_EN		(1 << 17)
+#define S3C64XX_IISMOD_DC1_EN		(1 << 16)
+#define S3C64XX_IISMOD_BLC_16BIT	(0 << 13)
+#define S3C64XX_IISMOD_BLC_8BIT		(1 << 13)
+#define S3C64XX_IISMOD_BLC_24BIT	(2 << 13)
+#define S3C64XX_IISMOD_BLC_MASK		(3 << 13)
+
+#define S3C2412_IISMOD_IMS_SYSMUX	(1 << 10)
+#define S3C2412_IISMOD_SLAVE		(1 << 11)
+#define S3C2412_IISMOD_MODE_TXONLY	(0 << 8)
+#define S3C2412_IISMOD_MODE_RXONLY	(1 << 8)
+#define S3C2412_IISMOD_MODE_TXRX	(2 << 8)
+#define S3C2412_IISMOD_MODE_MASK	(3 << 8)
+#define S3C2412_IISMOD_LR_LLOW		(0 << 7)
+#define S3C2412_IISMOD_LR_RLOW		(1 << 7)
+#define S3C2412_IISMOD_SDF_IIS		(0 << 5)
+#define S3C2412_IISMOD_SDF_MSB		(1 << 5)
+#define S3C2412_IISMOD_SDF_LSB		(2 << 5)
+#define S3C2412_IISMOD_SDF_MASK		(3 << 5)
+#define S3C2412_IISMOD_RCLK_256FS	(0 << 3)
+#define S3C2412_IISMOD_RCLK_512FS	(1 << 3)
+#define S3C2412_IISMOD_RCLK_384FS	(2 << 3)
+#define S3C2412_IISMOD_RCLK_768FS	(3 << 3)
+#define S3C2412_IISMOD_RCLK_MASK 	(3 << 3)
+#define S3C2412_IISMOD_BCLK_32FS	(0 << 1)
+#define S3C2412_IISMOD_BCLK_48FS	(1 << 1)
+#define S3C2412_IISMOD_BCLK_16FS	(2 << 1)
+#define S3C2412_IISMOD_BCLK_24FS	(3 << 1)
+#define S3C2412_IISMOD_BCLK_MASK	(3 << 1)
+#define S3C2412_IISMOD_8BIT		(1 << 0)
+
+#define S3C64XX_IISMOD_CDCLKCON		(1 << 12)
+
+#define S3C2412_IISPSR_PSREN		(1 << 15)
+
+#define S3C64XX_IISFIC_TX2COUNT(x)	(((x) >>  24) & 0xf)
+#define S3C64XX_IISFIC_TX1COUNT(x)	(((x) >>  16) & 0xf)
+
+#define S3C2412_IISFIC_TXFLUSH		(1 << 15)
+#define S3C2412_IISFIC_RXFLUSH		(1 << 7)
+#define S3C2412_IISFIC_TXCOUNT(x)	(((x) >>  8) & 0xf)
+#define S3C2412_IISFIC_RXCOUNT(x)	(((x) >>  0) & 0xf)
+
+#define S5PC1XX_IISFICS_TXFLUSH		(1 << 15)
+#define S5PC1XX_IISFICS_TXCOUNT(x)	(((x) >>  8) & 0x7f)
+
+#endif /* __ASM_ARCH_REGS_S3C2412_IIS_H */
diff --git a/sound/soc/samsung/s3c-ac97.c b/sound/soc/samsung/s3c-ac97.c
new file mode 100644
index 0000000..ecf4fd0
--- /dev/null
+++ b/sound/soc/samsung/s3c-ac97.c
@@ -0,0 +1,521 @@
+/* sound/soc/s3c24xx/s3c-ac97.c
+ *
+ * ALSA SoC Audio Layer - S3C AC97 Controller driver
+ * 	Evolved from s3c2443-ac97.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co. Ltd
+ * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
+ * 	Credits: Graeme Gregory, Sean Choi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+
+#include <sound/soc.h>
+
+#include <plat/regs-ac97.h>
+#include <mach/dma.h>
+#include <plat/audio.h>
+
+#include "s3c-dma.h"
+#include "s3c-ac97.h"
+
+#define AC_CMD_ADDR(x) (x << 16)
+#define AC_CMD_DATA(x) (x & 0xffff)
+
+struct s3c_ac97_info {
+	unsigned           state;
+	struct clk         *ac97_clk;
+	void __iomem	   *regs;
+	struct mutex       lock;
+	struct completion  done;
+};
+static struct s3c_ac97_info s3c_ac97;
+
+static struct s3c2410_dma_client s3c_dma_client_out = {
+	.name = "AC97 PCMOut"
+};
+
+static struct s3c2410_dma_client s3c_dma_client_in = {
+	.name = "AC97 PCMIn"
+};
+
+static struct s3c2410_dma_client s3c_dma_client_micin = {
+	.name = "AC97 MicIn"
+};
+
+static struct s3c_dma_params s3c_ac97_pcm_out = {
+	.client		= &s3c_dma_client_out,
+	.dma_size	= 4,
+};
+
+static struct s3c_dma_params s3c_ac97_pcm_in = {
+	.client		= &s3c_dma_client_in,
+	.dma_size	= 4,
+};
+
+static struct s3c_dma_params s3c_ac97_mic_in = {
+	.client		= &s3c_dma_client_micin,
+	.dma_size	= 4,
+};
+
+static void s3c_ac97_activate(struct snd_ac97 *ac97)
+{
+	u32 ac_glbctrl, stat;
+
+	stat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT) & 0x7;
+	if (stat == S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE)
+		return; /* Return if already active */
+
+	INIT_COMPLETION(s3c_ac97.done);
+
+	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl = S3C_AC97_GLBCTRL_ACLINKON;
+	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	msleep(1);
+
+	ac_glbctrl |= S3C_AC97_GLBCTRL_TRANSFERDATAENABLE;
+	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	msleep(1);
+
+	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
+	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+
+	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
+		printk(KERN_ERR "AC97: Unable to activate!");
+}
+
+static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
+	unsigned short reg)
+{
+	u32 ac_glbctrl, ac_codec_cmd;
+	u32 stat, addr, data;
+
+	mutex_lock(&s3c_ac97.lock);
+
+	s3c_ac97_activate(ac97);
+
+	INIT_COMPLETION(s3c_ac97.done);
+
+	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
+	ac_codec_cmd = S3C_AC97_CODEC_CMD_READ | AC_CMD_ADDR(reg);
+	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
+
+	udelay(50);
+
+	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
+	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+
+	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
+		printk(KERN_ERR "AC97: Unable to read!");
+
+	stat = readl(s3c_ac97.regs + S3C_AC97_STAT);
+	addr = (stat >> 16) & 0x7f;
+	data = (stat & 0xffff);
+
+	if (addr != reg)
+		printk(KERN_ERR "s3c-ac97: req addr = %02x, rep addr = %02x\n", reg, addr);
+
+	mutex_unlock(&s3c_ac97.lock);
+
+	return (unsigned short)data;
+}
+
+static void s3c_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+	unsigned short val)
+{
+	u32 ac_glbctrl, ac_codec_cmd;
+
+	mutex_lock(&s3c_ac97.lock);
+
+	s3c_ac97_activate(ac97);
+
+	INIT_COMPLETION(s3c_ac97.done);
+
+	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
+	ac_codec_cmd = AC_CMD_ADDR(reg) | AC_CMD_DATA(val);
+	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
+
+	udelay(50);
+
+	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
+	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+
+	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
+		printk(KERN_ERR "AC97: Unable to write!");
+
+	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
+	ac_codec_cmd |= S3C_AC97_CODEC_CMD_READ;
+	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
+
+	mutex_unlock(&s3c_ac97.lock);
+}
+
+static void s3c_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+	writel(S3C_AC97_GLBCTRL_COLDRESET,
+			s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	msleep(1);
+
+	writel(0, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	msleep(1);
+}
+
+static void s3c_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	u32 stat;
+
+	stat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT) & 0x7;
+	if (stat == S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE)
+		return; /* Return if already active */
+
+	writel(S3C_AC97_GLBCTRL_WARMRESET, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	msleep(1);
+
+	writel(0, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	msleep(1);
+
+	s3c_ac97_activate(ac97);
+}
+
+static irqreturn_t s3c_ac97_irq(int irq, void *dev_id)
+{
+	u32 ac_glbctrl, ac_glbstat;
+
+	ac_glbstat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT);
+
+	if (ac_glbstat & S3C_AC97_GLBSTAT_CODECREADY) {
+
+		ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
+		ac_glbctrl &= ~S3C_AC97_GLBCTRL_CODECREADYIE;
+		writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+
+		complete(&s3c_ac97.done);
+	}
+
+	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl |= (1<<30); /* Clear interrupt */
+	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+
+	return IRQ_HANDLED;
+}
+
+struct snd_ac97_bus_ops soc_ac97_ops = {
+	.read       = s3c_ac97_read,
+	.write      = s3c_ac97_write,
+	.warm_reset = s3c_ac97_warm_reset,
+	.reset      = s3c_ac97_cold_reset,
+};
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+static int s3c_ac97_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct s3c_dma_params *dma_data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = &s3c_ac97_pcm_out;
+	else
+		dma_data = &s3c_ac97_pcm_in;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
+
+	return 0;
+}
+
+static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	u32 ac_glbctrl;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+
+	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMINTM_MASK;
+	else
+		ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMOUTTM_MASK;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			ac_glbctrl |= S3C_AC97_GLBCTRL_PCMINTM_DMA;
+		else
+			ac_glbctrl |= S3C_AC97_GLBCTRL_PCMOUTTM_DMA;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+	}
+
+	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+
+	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+
+	return 0;
+}
+
+static int s3c_ac97_hw_mic_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return -ENODEV;
+	else
+		snd_soc_dai_set_dma_data(cpu_dai, substream, &s3c_ac97_mic_in);
+
+	return 0;
+}
+
+static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
+				    int cmd, struct snd_soc_dai *dai)
+{
+	u32 ac_glbctrl;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+
+	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
+	ac_glbctrl &= ~S3C_AC97_GLBCTRL_MICINTM_MASK;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ac_glbctrl |= S3C_AC97_GLBCTRL_MICINTM_DMA;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+	}
+
+	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
+
+	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops s3c_ac97_dai_ops = {
+	.hw_params	= s3c_ac97_hw_params,
+	.trigger	= s3c_ac97_trigger,
+};
+
+static struct snd_soc_dai_ops s3c_ac97_mic_dai_ops = {
+	.hw_params	= s3c_ac97_hw_mic_params,
+	.trigger	= s3c_ac97_mic_trigger,
+};
+
+struct snd_soc_dai s3c_ac97_dai[] = {
+	[S3C_AC97_DAI_PCM] = {
+		.name =	"s3c-ac97",
+		.id = S3C_AC97_DAI_PCM,
+		.ac97_control = 1,
+		.playback = {
+			.stream_name = "AC97 Playback",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.capture = {
+			.stream_name = "AC97 Capture",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.ops = &s3c_ac97_dai_ops,
+	},
+	[S3C_AC97_DAI_MIC] = {
+		.name = "s3c-ac97-mic",
+		.id = S3C_AC97_DAI_MIC,
+		.ac97_control = 1,
+		.capture = {
+			.stream_name = "AC97 Mic Capture",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+		.ops = &s3c_ac97_mic_dai_ops,
+	},
+};
+EXPORT_SYMBOL_GPL(s3c_ac97_dai);
+
+static __devinit int s3c_ac97_probe(struct platform_device *pdev)
+{
+	struct resource *mem_res, *dmatx_res, *dmarx_res, *dmamic_res, *irq_res;
+	struct s3c_audio_pdata *ac97_pdata;
+	int ret;
+
+	ac97_pdata = pdev->dev.platform_data;
+	if (!ac97_pdata || !ac97_pdata->cfg_gpio) {
+		dev_err(&pdev->dev, "cfg_gpio callback not provided!\n");
+		return -EINVAL;
+	}
+
+	/* Check for availability of necessary resource */
+	dmatx_res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!dmatx_res) {
+		dev_err(&pdev->dev, "Unable to get AC97-TX dma resource\n");
+		return -ENXIO;
+	}
+
+	dmarx_res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!dmarx_res) {
+		dev_err(&pdev->dev, "Unable to get AC97-RX dma resource\n");
+		return -ENXIO;
+	}
+
+	dmamic_res = platform_get_resource(pdev, IORESOURCE_DMA, 2);
+	if (!dmamic_res) {
+		dev_err(&pdev->dev, "Unable to get AC97-MIC dma resource\n");
+		return -ENXIO;
+	}
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem_res) {
+		dev_err(&pdev->dev, "Unable to get register resource\n");
+		return -ENXIO;
+	}
+
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq_res) {
+		dev_err(&pdev->dev, "AC97 IRQ not provided!\n");
+		return -ENXIO;
+	}
+
+	if (!request_mem_region(mem_res->start,
+				resource_size(mem_res), "s3c-ac97")) {
+		dev_err(&pdev->dev, "Unable to request register region\n");
+		return -EBUSY;
+	}
+
+	s3c_ac97_pcm_out.channel = dmatx_res->start;
+	s3c_ac97_pcm_out.dma_addr = mem_res->start + S3C_AC97_PCM_DATA;
+	s3c_ac97_pcm_in.channel = dmarx_res->start;
+	s3c_ac97_pcm_in.dma_addr = mem_res->start + S3C_AC97_PCM_DATA;
+	s3c_ac97_mic_in.channel = dmamic_res->start;
+	s3c_ac97_mic_in.dma_addr = mem_res->start + S3C_AC97_MIC_DATA;
+
+	init_completion(&s3c_ac97.done);
+	mutex_init(&s3c_ac97.lock);
+
+	s3c_ac97.regs = ioremap(mem_res->start, resource_size(mem_res));
+	if (s3c_ac97.regs == NULL) {
+		dev_err(&pdev->dev, "Unable to ioremap register region\n");
+		ret = -ENXIO;
+		goto err1;
+	}
+
+	s3c_ac97.ac97_clk = clk_get(&pdev->dev, "ac97");
+	if (IS_ERR(s3c_ac97.ac97_clk)) {
+		dev_err(&pdev->dev, "s3c-ac97 failed to get ac97_clock\n");
+		ret = -ENODEV;
+		goto err2;
+	}
+	clk_enable(s3c_ac97.ac97_clk);
+
+	if (ac97_pdata->cfg_gpio(pdev)) {
+		dev_err(&pdev->dev, "Unable to configure gpio\n");
+		ret = -EINVAL;
+		goto err3;
+	}
+
+	ret = request_irq(irq_res->start, s3c_ac97_irq,
+					IRQF_DISABLED, "AC97", NULL);
+	if (ret < 0) {
+		printk(KERN_ERR "s3c-ac97: interrupt request failed.\n");
+		goto err4;
+	}
+
+	s3c_ac97_dai[S3C_AC97_DAI_PCM].dev = &pdev->dev;
+	s3c_ac97_dai[S3C_AC97_DAI_MIC].dev = &pdev->dev;
+
+	ret = snd_soc_register_dais(s3c_ac97_dai, ARRAY_SIZE(s3c_ac97_dai));
+	if (ret)
+		goto err5;
+
+	return 0;
+
+err5:
+	free_irq(irq_res->start, NULL);
+err4:
+err3:
+	clk_disable(s3c_ac97.ac97_clk);
+	clk_put(s3c_ac97.ac97_clk);
+err2:
+	iounmap(s3c_ac97.regs);
+err1:
+	release_mem_region(mem_res->start, resource_size(mem_res));
+
+	return ret;
+}
+
+static __devexit int s3c_ac97_remove(struct platform_device *pdev)
+{
+	struct resource *mem_res, *irq_res;
+
+	snd_soc_unregister_dais(s3c_ac97_dai, ARRAY_SIZE(s3c_ac97_dai));
+
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (irq_res)
+		free_irq(irq_res->start, NULL);
+
+	clk_disable(s3c_ac97.ac97_clk);
+	clk_put(s3c_ac97.ac97_clk);
+
+	iounmap(s3c_ac97.regs);
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (mem_res)
+		release_mem_region(mem_res->start, resource_size(mem_res));
+
+	return 0;
+}
+
+static struct platform_driver s3c_ac97_driver = {
+	.probe  = s3c_ac97_probe,
+	.remove = s3c_ac97_remove,
+	.driver = {
+		.name = "s3c-ac97",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init s3c_ac97_init(void)
+{
+	return platform_driver_register(&s3c_ac97_driver);
+}
+module_init(s3c_ac97_init);
+
+static void __exit s3c_ac97_exit(void)
+{
+	platform_driver_unregister(&s3c_ac97_driver);
+}
+module_exit(s3c_ac97_exit);
+
+MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
+MODULE_DESCRIPTION("AC97 driver for the Samsung SoC");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c-ac97.h b/sound/soc/samsung/s3c-ac97.h
new file mode 100644
index 0000000..2781983
--- /dev/null
+++ b/sound/soc/samsung/s3c-ac97.h
@@ -0,0 +1,23 @@
+/* sound/soc/s3c24xx/s3c-ac97.h
+ *
+ * ALSA SoC Audio Layer - S3C AC97 Controller driver
+ * 	Evolved from s3c2443-ac97.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co. Ltd
+ * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
+ * 	Credits: Graeme Gregory, Sean Choi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __S3C_AC97_H_
+#define __S3C_AC97_H_
+
+#define S3C_AC97_DAI_PCM 0
+#define S3C_AC97_DAI_MIC 1
+
+extern struct snd_soc_dai s3c_ac97_dai[];
+
+#endif /* __S3C_AC97_H_ */
diff --git a/sound/soc/samsung/s3c-dma.c b/sound/soc/samsung/s3c-dma.c
new file mode 100644
index 0000000..1b61c23
--- /dev/null
+++ b/sound/soc/samsung/s3c-dma.c
@@ -0,0 +1,483 @@
+/*
+ * s3c-dma.c  --  ALSA Soc Audio Layer
+ *
+ * (c) 2006 Wolfson Microelectronics PLC.
+ * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ * Copyright 2004-2005 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/dma.h>
+#include <mach/hardware.h>
+#include <mach/dma.h>
+
+#include "s3c-dma.h"
+
+static const struct snd_pcm_hardware s3c_dma_hardware = {
+	.info			= SNDRV_PCM_INFO_INTERLEAVED |
+				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				    SNDRV_PCM_INFO_MMAP |
+				    SNDRV_PCM_INFO_MMAP_VALID |
+				    SNDRV_PCM_INFO_PAUSE |
+				    SNDRV_PCM_INFO_RESUME,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
+				    SNDRV_PCM_FMTBIT_U16_LE |
+				    SNDRV_PCM_FMTBIT_U8 |
+				    SNDRV_PCM_FMTBIT_S8,
+	.channels_min		= 2,
+	.channels_max		= 2,
+	.buffer_bytes_max	= 128*1024,
+	.period_bytes_min	= PAGE_SIZE,
+	.period_bytes_max	= PAGE_SIZE*2,
+	.periods_min		= 2,
+	.periods_max		= 128,
+	.fifo_size		= 32,
+};
+
+struct s3c24xx_runtime_data {
+	spinlock_t lock;
+	int state;
+	unsigned int dma_loaded;
+	unsigned int dma_limit;
+	unsigned int dma_period;
+	dma_addr_t dma_start;
+	dma_addr_t dma_pos;
+	dma_addr_t dma_end;
+	struct s3c_dma_params *params;
+};
+
+/* s3c_dma_enqueue
+ *
+ * place a dma buffer onto the queue for the dma system
+ * to handle.
+*/
+static void s3c_dma_enqueue(struct snd_pcm_substream *substream)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	dma_addr_t pos = prtd->dma_pos;
+	unsigned int limit;
+	int ret;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (s3c_dma_has_circular())
+		limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
+	else
+		limit = prtd->dma_limit;
+
+	pr_debug("%s: loaded %d, limit %d\n",
+				__func__, prtd->dma_loaded, limit);
+
+	while (prtd->dma_loaded < limit) {
+		unsigned long len = prtd->dma_period;
+
+		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
+
+		if ((pos + len) > prtd->dma_end) {
+			len  = prtd->dma_end - pos;
+			pr_debug(KERN_DEBUG "%s: corrected dma len %ld\n",
+			       __func__, len);
+		}
+
+		ret = s3c2410_dma_enqueue(prtd->params->channel,
+			substream, pos, len);
+
+		if (ret == 0) {
+			prtd->dma_loaded++;
+			pos += prtd->dma_period;
+			if (pos >= prtd->dma_end)
+				pos = prtd->dma_start;
+		} else
+			break;
+	}
+
+	prtd->dma_pos = pos;
+}
+
+static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
+				void *dev_id, int size,
+				enum s3c2410_dma_buffresult result)
+{
+	struct snd_pcm_substream *substream = dev_id;
+	struct s3c24xx_runtime_data *prtd;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (result == S3C2410_RES_ABORT || result == S3C2410_RES_ERR)
+		return;
+
+	prtd = substream->runtime->private_data;
+
+	if (substream)
+		snd_pcm_period_elapsed(substream);
+
+	spin_lock(&prtd->lock);
+	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
+		prtd->dma_loaded--;
+		s3c_dma_enqueue(substream);
+	}
+
+	spin_unlock(&prtd->lock);
+}
+
+static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned long totbytes = params_buffer_bytes(params);
+	struct s3c_dma_params *dma =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	int ret = 0;
+
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	if (!dma)
+		return 0;
+
+	/* this may get called several times by oss emulation
+	 * with different params -HW */
+	if (prtd->params == NULL) {
+		/* prepare DMA */
+		prtd->params = dma;
+
+		pr_debug("params %p, client %p, channel %d\n", prtd->params,
+			prtd->params->client, prtd->params->channel);
+
+		ret = s3c2410_dma_request(prtd->params->channel,
+					  prtd->params->client, NULL);
+
+		if (ret < 0) {
+			printk(KERN_ERR "failed to get dma channel\n");
+			return ret;
+		}
+
+		/* use the circular buffering if we have it available. */
+		if (s3c_dma_has_circular())
+			s3c2410_dma_setflags(prtd->params->channel,
+					     S3C2410_DMAF_CIRCULAR);
+	}
+
+	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
+				    s3c24xx_audio_buffdone);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	runtime->dma_bytes = totbytes;
+
+	spin_lock_irq(&prtd->lock);
+	prtd->dma_loaded = 0;
+	prtd->dma_limit = runtime->hw.periods_min;
+	prtd->dma_period = params_period_bytes(params);
+	prtd->dma_start = runtime->dma_addr;
+	prtd->dma_pos = prtd->dma_start;
+	prtd->dma_end = prtd->dma_start + totbytes;
+	spin_unlock_irq(&prtd->lock);
+
+	return 0;
+}
+
+static int s3c_dma_hw_free(struct snd_pcm_substream *substream)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* TODO - do we need to ensure DMA flushed */
+	snd_pcm_set_runtime_buffer(substream, NULL);
+
+	if (prtd->params) {
+		s3c2410_dma_free(prtd->params->channel, prtd->params->client);
+		prtd->params = NULL;
+	}
+
+	return 0;
+}
+
+static int s3c_dma_prepare(struct snd_pcm_substream *substream)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	int ret = 0;
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	if (!prtd->params)
+		return 0;
+
+	/* channel needs configuring for mem=>device, increment memory addr,
+	 * sync to pclk, half-word transfers to the IIS-FIFO. */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		s3c2410_dma_devconfig(prtd->params->channel,
+				      S3C2410_DMASRC_MEM,
+				      prtd->params->dma_addr);
+	} else {
+		s3c2410_dma_devconfig(prtd->params->channel,
+				      S3C2410_DMASRC_HW,
+				      prtd->params->dma_addr);
+	}
+
+	s3c2410_dma_config(prtd->params->channel,
+			   prtd->params->dma_size);
+
+	/* flush the DMA channel */
+	s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_FLUSH);
+	prtd->dma_loaded = 0;
+	prtd->dma_pos = prtd->dma_start;
+
+	/* enqueue dma buffers */
+	s3c_dma_enqueue(substream);
+
+	return ret;
+}
+
+static int s3c_dma_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	int ret = 0;
+
+	pr_debug("Entered %s\n", __func__);
+
+	spin_lock(&prtd->lock);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		prtd->state |= ST_RUNNING;
+		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_START);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		prtd->state &= ~ST_RUNNING;
+		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STOP);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	spin_unlock(&prtd->lock);
+
+	return ret;
+}
+
+static snd_pcm_uframes_t
+s3c_dma_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	unsigned long res;
+	dma_addr_t src, dst;
+
+	pr_debug("Entered %s\n", __func__);
+
+	spin_lock(&prtd->lock);
+	s3c2410_dma_getposition(prtd->params->channel, &src, &dst);
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		res = dst - prtd->dma_start;
+	else
+		res = src - prtd->dma_start;
+
+	spin_unlock(&prtd->lock);
+
+	pr_debug("Pointer %x %x\n", src, dst);
+
+	/* we seem to be getting the odd error from the pcm library due
+	 * to out-of-bounds pointers. this is maybe due to the dma engine
+	 * not having loaded the new values for the channel before being
+	 * callled... (todo - fix )
+	 */
+
+	if (res >= snd_pcm_lib_buffer_bytes(substream)) {
+		if (res == snd_pcm_lib_buffer_bytes(substream))
+			res = 0;
+	}
+
+	return bytes_to_frames(substream->runtime, res);
+}
+
+static int s3c_dma_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct s3c24xx_runtime_data *prtd;
+
+	pr_debug("Entered %s\n", __func__);
+
+	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	snd_soc_set_runtime_hwparams(substream, &s3c_dma_hardware);
+
+	prtd = kzalloc(sizeof(struct s3c24xx_runtime_data), GFP_KERNEL);
+	if (prtd == NULL)
+		return -ENOMEM;
+
+	spin_lock_init(&prtd->lock);
+
+	runtime->private_data = prtd;
+	return 0;
+}
+
+static int s3c_dma_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (!prtd)
+		pr_debug("s3c_dma_close called with prtd == NULL\n");
+
+	kfree(prtd);
+
+	return 0;
+}
+
+static int s3c_dma_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	pr_debug("Entered %s\n", __func__);
+
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
+}
+
+static struct snd_pcm_ops s3c_dma_ops = {
+	.open		= s3c_dma_open,
+	.close		= s3c_dma_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= s3c_dma_hw_params,
+	.hw_free	= s3c_dma_hw_free,
+	.prepare	= s3c_dma_prepare,
+	.trigger	= s3c_dma_trigger,
+	.pointer	= s3c_dma_pointer,
+	.mmap		= s3c_dma_mmap,
+};
+
+static int s3c_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = s3c_dma_hardware.buffer_bytes_max;
+
+	pr_debug("Entered %s\n", __func__);
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->bytes = size;
+	return 0;
+}
+
+static void s3c_dma_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	pr_debug("Entered %s\n", __func__);
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_writecombine(pcm->card->dev, buf->bytes,
+				      buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+static u64 s3c_dma_mask = DMA_BIT_MASK(32);
+
+static int s3c_dma_new(struct snd_card *card,
+	struct snd_soc_dai *dai, struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &s3c_dma_mask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		ret = s3c_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (dai->capture.channels_min) {
+		ret = s3c_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+ out:
+	return ret;
+}
+
+struct snd_soc_platform s3c24xx_soc_platform = {
+	.name		= "s3c24xx-audio",
+	.pcm_ops 	= &s3c_dma_ops,
+	.pcm_new	= s3c_dma_new,
+	.pcm_free	= s3c_dma_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(s3c24xx_soc_platform);
+
+static int __init s3c24xx_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&s3c24xx_soc_platform);
+}
+module_init(s3c24xx_soc_platform_init);
+
+static void __exit s3c24xx_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&s3c24xx_soc_platform);
+}
+module_exit(s3c24xx_soc_platform_exit);
+
+MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c-dma.h b/sound/soc/samsung/s3c-dma.h
new file mode 100644
index 0000000..69bb6bf
--- /dev/null
+++ b/sound/soc/samsung/s3c-dma.h
@@ -0,0 +1,31 @@
+/*
+ *  s3c-dma.h --
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  ALSA PCM interface for the Samsung S3C24xx CPU
+ */
+
+#ifndef _S3C_AUDIO_H
+#define _S3C_AUDIO_H
+
+#define ST_RUNNING		(1<<0)
+#define ST_OPENED		(1<<1)
+
+struct s3c_dma_params {
+	struct s3c2410_dma_client *client;	/* stream identifier */
+	int channel;				/* Channel ID */
+	dma_addr_t dma_addr;
+	int dma_size;			/* Size of the DMA transfer */
+};
+
+#define S3C24XX_DAI_I2S			0
+
+/* platform data */
+extern struct snd_soc_platform s3c24xx_soc_platform;
+extern struct snd_ac97_bus_ops s3c24xx_ac97_ops;
+
+#endif
diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
new file mode 100644
index 0000000..13311c8
--- /dev/null
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -0,0 +1,776 @@
+/* sound/soc/s3c24xx/s3c-i2c-v2.c
+ *
+ * ALSA Soc Audio Layer - I2S core for newer Samsung SoCs.
+ *
+ * Copyright (c) 2006 Wolfson Microelectronics PLC.
+ *	Graeme Gregory graeme.gregory@wolfsonmicro.com
+ *	linux@wolfsonmicro.com
+ *
+ * Copyright (c) 2008, 2007, 2004-2005 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <mach/dma.h>
+
+#include "regs-i2s-v2.h"
+#include "s3c-i2s-v2.h"
+#include "s3c-dma.h"
+
+#undef S3C_IIS_V2_SUPPORTED
+
+#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
+#define S3C_IIS_V2_SUPPORTED
+#endif
+
+#ifdef CONFIG_PLAT_S3C64XX
+#define S3C_IIS_V2_SUPPORTED
+#endif
+
+#ifndef S3C_IIS_V2_SUPPORTED
+#error Unsupported CPU model
+#endif
+
+#define S3C2412_I2S_DEBUG_CON 0
+
+static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
+{
+	return cpu_dai->private_data;
+}
+
+#define bit_set(v, b) (((v) & (b)) ? 1 : 0)
+
+#if S3C2412_I2S_DEBUG_CON
+static void dbg_showcon(const char *fn, u32 con)
+{
+	printk(KERN_DEBUG "%s: LRI=%d, TXFEMPT=%d, RXFEMPT=%d, TXFFULL=%d, RXFFULL=%d\n", fn,
+	       bit_set(con, S3C2412_IISCON_LRINDEX),
+	       bit_set(con, S3C2412_IISCON_TXFIFO_EMPTY),
+	       bit_set(con, S3C2412_IISCON_RXFIFO_EMPTY),
+	       bit_set(con, S3C2412_IISCON_TXFIFO_FULL),
+	       bit_set(con, S3C2412_IISCON_RXFIFO_FULL));
+
+	printk(KERN_DEBUG "%s: PAUSE: TXDMA=%d, RXDMA=%d, TXCH=%d, RXCH=%d\n",
+	       fn,
+	       bit_set(con, S3C2412_IISCON_TXDMA_PAUSE),
+	       bit_set(con, S3C2412_IISCON_RXDMA_PAUSE),
+	       bit_set(con, S3C2412_IISCON_TXCH_PAUSE),
+	       bit_set(con, S3C2412_IISCON_RXCH_PAUSE));
+	printk(KERN_DEBUG "%s: ACTIVE: TXDMA=%d, RXDMA=%d, IIS=%d\n", fn,
+	       bit_set(con, S3C2412_IISCON_TXDMA_ACTIVE),
+	       bit_set(con, S3C2412_IISCON_RXDMA_ACTIVE),
+	       bit_set(con, S3C2412_IISCON_IIS_ACTIVE));
+}
+#else
+static inline void dbg_showcon(const char *fn, u32 con)
+{
+}
+#endif
+
+
+/* Turn on or off the transmission path. */
+static void s3c2412_snd_txctrl(struct s3c_i2sv2_info *i2s, int on)
+{
+	void __iomem *regs = i2s->regs;
+	u32 fic, con, mod;
+
+	pr_debug("%s(%d)\n", __func__, on);
+
+	fic = readl(regs + S3C2412_IISFIC);
+	con = readl(regs + S3C2412_IISCON);
+	mod = readl(regs + S3C2412_IISMOD);
+
+	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
+
+	if (on) {
+		con |= S3C2412_IISCON_TXDMA_ACTIVE | S3C2412_IISCON_IIS_ACTIVE;
+		con &= ~S3C2412_IISCON_TXDMA_PAUSE;
+		con &= ~S3C2412_IISCON_TXCH_PAUSE;
+
+		switch (mod & S3C2412_IISMOD_MODE_MASK) {
+		case S3C2412_IISMOD_MODE_TXONLY:
+		case S3C2412_IISMOD_MODE_TXRX:
+			/* do nothing, we are in the right mode */
+			break;
+
+		case S3C2412_IISMOD_MODE_RXONLY:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			mod |= S3C2412_IISMOD_MODE_TXRX;
+			break;
+
+		default:
+			dev_err(i2s->dev, "TXEN: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
+			break;
+		}
+
+		writel(con, regs + S3C2412_IISCON);
+		writel(mod, regs + S3C2412_IISMOD);
+	} else {
+		/* Note, we do not have any indication that the FIFO problems
+		 * tha the S3C2410/2440 had apply here, so we should be able
+		 * to disable the DMA and TX without resetting the FIFOS.
+		 */
+
+		con |=  S3C2412_IISCON_TXDMA_PAUSE;
+		con |=  S3C2412_IISCON_TXCH_PAUSE;
+		con &= ~S3C2412_IISCON_TXDMA_ACTIVE;
+
+		switch (mod & S3C2412_IISMOD_MODE_MASK) {
+		case S3C2412_IISMOD_MODE_TXRX:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			mod |= S3C2412_IISMOD_MODE_RXONLY;
+			break;
+
+		case S3C2412_IISMOD_MODE_TXONLY:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			con &= ~S3C2412_IISCON_IIS_ACTIVE;
+			break;
+
+		default:
+			dev_err(i2s->dev, "TXDIS: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
+			break;
+		}
+
+		writel(mod, regs + S3C2412_IISMOD);
+		writel(con, regs + S3C2412_IISCON);
+	}
+
+	fic = readl(regs + S3C2412_IISFIC);
+	dbg_showcon(__func__, con);
+	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
+}
+
+static void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
+{
+	void __iomem *regs = i2s->regs;
+	u32 fic, con, mod;
+
+	pr_debug("%s(%d)\n", __func__, on);
+
+	fic = readl(regs + S3C2412_IISFIC);
+	con = readl(regs + S3C2412_IISCON);
+	mod = readl(regs + S3C2412_IISMOD);
+
+	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
+
+	if (on) {
+		con |= S3C2412_IISCON_RXDMA_ACTIVE | S3C2412_IISCON_IIS_ACTIVE;
+		con &= ~S3C2412_IISCON_RXDMA_PAUSE;
+		con &= ~S3C2412_IISCON_RXCH_PAUSE;
+
+		switch (mod & S3C2412_IISMOD_MODE_MASK) {
+		case S3C2412_IISMOD_MODE_TXRX:
+		case S3C2412_IISMOD_MODE_RXONLY:
+			/* do nothing, we are in the right mode */
+			break;
+
+		case S3C2412_IISMOD_MODE_TXONLY:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			mod |= S3C2412_IISMOD_MODE_TXRX;
+			break;
+
+		default:
+			dev_err(i2s->dev, "RXEN: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
+		}
+
+		writel(mod, regs + S3C2412_IISMOD);
+		writel(con, regs + S3C2412_IISCON);
+	} else {
+		/* See txctrl notes on FIFOs. */
+
+		con &= ~S3C2412_IISCON_RXDMA_ACTIVE;
+		con |=  S3C2412_IISCON_RXDMA_PAUSE;
+		con |=  S3C2412_IISCON_RXCH_PAUSE;
+
+		switch (mod & S3C2412_IISMOD_MODE_MASK) {
+		case S3C2412_IISMOD_MODE_RXONLY:
+			con &= ~S3C2412_IISCON_IIS_ACTIVE;
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			break;
+
+		case S3C2412_IISMOD_MODE_TXRX:
+			mod &= ~S3C2412_IISMOD_MODE_MASK;
+			mod |= S3C2412_IISMOD_MODE_TXONLY;
+			break;
+
+		default:
+			dev_err(i2s->dev, "RXDIS: Invalid MODE %x in IISMOD\n",
+				mod & S3C2412_IISMOD_MODE_MASK);
+		}
+
+		writel(con, regs + S3C2412_IISCON);
+		writel(mod, regs + S3C2412_IISMOD);
+	}
+
+	fic = readl(regs + S3C2412_IISFIC);
+	pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
+}
+
+#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
+
+/*
+ * Wait for the LR signal to allow synchronisation to the L/R clock
+ * from the codec. May only be needed for slave mode.
+ */
+static int s3c2412_snd_lrsync(struct s3c_i2sv2_info *i2s)
+{
+	u32 iiscon;
+	unsigned long loops = msecs_to_loops(5);
+
+	pr_debug("Entered %s\n", __func__);
+
+	while (--loops) {
+		iiscon = readl(i2s->regs + S3C2412_IISCON);
+		if (iiscon & S3C2412_IISCON_LRINDEX)
+			break;
+
+		cpu_relax();
+	}
+
+	if (!loops) {
+		printk(KERN_ERR "%s: timeout\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/*
+ * Set S3C2412 I2S DAI format
+ */
+static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+			       unsigned int fmt)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 iismod;
+
+	pr_debug("Entered %s\n", __func__);
+
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	pr_debug("hw_params r: IISMOD: %x \n", iismod);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		i2s->master = 0;
+		iismod |= S3C2412_IISMOD_SLAVE;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s->master = 1;
+		iismod &= ~S3C2412_IISMOD_SLAVE;
+		break;
+	default:
+		pr_err("unknwon master/slave format\n");
+		return -EINVAL;
+	}
+
+	iismod &= ~S3C2412_IISMOD_SDF_MASK;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		iismod |= S3C2412_IISMOD_LR_RLOW;
+		iismod |= S3C2412_IISMOD_SDF_MSB;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iismod |= S3C2412_IISMOD_LR_RLOW;
+		iismod |= S3C2412_IISMOD_SDF_LSB;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		iismod &= ~S3C2412_IISMOD_LR_RLOW;
+		iismod |= S3C2412_IISMOD_SDF_IIS;
+		break;
+	default:
+		pr_err("Unknown data format\n");
+		return -EINVAL;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	pr_debug("hw_params w: IISMOD: %x \n", iismod);
+	return 0;
+}
+
+static int s3c_i2sv2_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *socdai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_link *dai = rtd->dai;
+	struct s3c_i2sv2_info *i2s = to_info(dai->cpu_dai);
+	struct s3c_dma_params *dma_data;
+	u32 iismod;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = i2s->dma_playback;
+	else
+		dma_data = i2s->dma_capture;
+
+	snd_soc_dai_set_dma_data(dai->cpu_dai, substream, dma_data);
+
+	/* Working copies of register */
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	pr_debug("%s: r: IISMOD: %x\n", __func__, iismod);
+
+	iismod &= ~S3C64XX_IISMOD_BLC_MASK;
+	/* Sample size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		iismod |= S3C64XX_IISMOD_BLC_8BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iismod |= S3C64XX_IISMOD_BLC_24BIT;
+		break;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	pr_debug("%s: w: IISMOD: %x\n", __func__, iismod);
+
+	return 0;
+}
+
+static int s3c_i2sv2_set_sysclk(struct snd_soc_dai *cpu_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
+
+	pr_debug("Entered %s\n", __func__);
+	pr_debug("%s r: IISMOD: %x\n", __func__, iismod);
+
+	switch (clk_id) {
+	case S3C_I2SV2_CLKSRC_PCLK:
+		iismod &= ~S3C2412_IISMOD_IMS_SYSMUX;
+		break;
+
+	case S3C_I2SV2_CLKSRC_AUDIOBUS:
+		iismod |= S3C2412_IISMOD_IMS_SYSMUX;
+		break;
+
+	case S3C_I2SV2_CLKSRC_CDCLK:
+		/* Error if controller doesn't have the CDCLKCON bit */
+		if (!(i2s->feature & S3C_FEATURE_CDCLKCON))
+			return -EINVAL;
+
+		switch (dir) {
+		case SND_SOC_CLOCK_IN:
+			iismod |= S3C64XX_IISMOD_CDCLKCON;
+			break;
+		case SND_SOC_CLOCK_OUT:
+			iismod &= ~S3C64XX_IISMOD_CDCLKCON;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	pr_debug("%s w: IISMOD: %x\n", __func__, iismod);
+
+	return 0;
+}
+
+static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c_i2sv2_info *i2s = to_info(rtd->dai->cpu_dai);
+	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
+	unsigned long irqs;
+	int ret = 0;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+
+	pr_debug("Entered %s\n", __func__);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* On start, ensure that the FIFOs are cleared and reset. */
+
+		writel(capture ? S3C2412_IISFIC_RXFLUSH : S3C2412_IISFIC_TXFLUSH,
+		       i2s->regs + S3C2412_IISFIC);
+
+		/* clear again, just in case */
+		writel(0x0, i2s->regs + S3C2412_IISFIC);
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (!i2s->master) {
+			ret = s3c2412_snd_lrsync(i2s);
+			if (ret)
+				goto exit_err;
+		}
+
+		local_irq_save(irqs);
+
+		if (capture)
+			s3c2412_snd_rxctrl(i2s, 1);
+		else
+			s3c2412_snd_txctrl(i2s, 1);
+
+		local_irq_restore(irqs);
+
+		/*
+		 * Load the next buffer to DMA to meet the reqirement
+		 * of the auto reload mechanism of S3C24XX.
+		 * This call won't bother S3C64XX.
+		 */
+		s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		local_irq_save(irqs);
+
+		if (capture)
+			s3c2412_snd_rxctrl(i2s, 0);
+		else
+			s3c2412_snd_txctrl(i2s, 0);
+
+		local_irq_restore(irqs);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+exit_err:
+	return ret;
+}
+
+/*
+ * Set S3C2412 Clock dividers
+ */
+static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
+				  int div_id, int div)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 reg;
+
+	pr_debug("%s(%p, %d, %d)\n", __func__, cpu_dai, div_id, div);
+
+	switch (div_id) {
+	case S3C_I2SV2_DIV_BCLK:
+		switch (div) {
+		case 16:
+			div = S3C2412_IISMOD_BCLK_16FS;
+			break;
+
+		case 32:
+			div = S3C2412_IISMOD_BCLK_32FS;
+			break;
+
+		case 24:
+			div = S3C2412_IISMOD_BCLK_24FS;
+			break;
+
+		case 48:
+			div = S3C2412_IISMOD_BCLK_48FS;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		reg = readl(i2s->regs + S3C2412_IISMOD);
+		reg &= ~S3C2412_IISMOD_BCLK_MASK;
+		writel(reg | div, i2s->regs + S3C2412_IISMOD);
+
+		pr_debug("%s: MOD=%08x\n", __func__, readl(i2s->regs + S3C2412_IISMOD));
+		break;
+
+	case S3C_I2SV2_DIV_RCLK:
+		switch (div) {
+		case 256:
+			div = S3C2412_IISMOD_RCLK_256FS;
+			break;
+
+		case 384:
+			div = S3C2412_IISMOD_RCLK_384FS;
+			break;
+
+		case 512:
+			div = S3C2412_IISMOD_RCLK_512FS;
+			break;
+
+		case 768:
+			div = S3C2412_IISMOD_RCLK_768FS;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		reg = readl(i2s->regs + S3C2412_IISMOD);
+		reg &= ~S3C2412_IISMOD_RCLK_MASK;
+		writel(reg | div, i2s->regs + S3C2412_IISMOD);
+		pr_debug("%s: MOD=%08x\n", __func__, readl(i2s->regs + S3C2412_IISMOD));
+		break;
+
+	case S3C_I2SV2_DIV_PRESCALER:
+		if (div >= 0) {
+			writel((div << 8) | S3C2412_IISPSR_PSREN,
+			       i2s->regs + S3C2412_IISPSR);
+		} else {
+			writel(0x0, i2s->regs + S3C2412_IISPSR);
+		}
+		pr_debug("%s: PSR=%08x\n", __func__, readl(i2s->regs + S3C2412_IISPSR));
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_sframes_t s3c2412_i2s_delay(struct snd_pcm_substream *substream,
+					   struct snd_soc_dai *dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(dai);
+	u32 reg = readl(i2s->regs + S3C2412_IISFIC);
+	snd_pcm_sframes_t delay;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		delay = S3C2412_IISFIC_TXCOUNT(reg);
+	else
+		delay = S3C2412_IISFIC_RXCOUNT(reg);
+
+	return delay;
+}
+
+struct clk *s3c_i2sv2_get_clock(struct snd_soc_dai *cpu_dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
+
+	if (iismod & S3C2412_IISMOD_IMS_SYSMUX)
+		return i2s->iis_cclk;
+	else
+		return i2s->iis_pclk;
+}
+EXPORT_SYMBOL_GPL(s3c_i2sv2_get_clock);
+
+/* default table of all avaialable root fs divisors */
+static unsigned int iis_fs_tab[] = { 256, 512, 384, 768 };
+
+int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
+			    unsigned int *fstab,
+			    unsigned int rate, struct clk *clk)
+{
+	unsigned long clkrate = clk_get_rate(clk);
+	unsigned int div;
+	unsigned int fsclk;
+	unsigned int actual;
+	unsigned int fs;
+	unsigned int fsdiv;
+	signed int deviation = 0;
+	unsigned int best_fs = 0;
+	unsigned int best_div = 0;
+	unsigned int best_rate = 0;
+	unsigned int best_deviation = INT_MAX;
+
+	pr_debug("Input clock rate %ldHz\n", clkrate);
+
+	if (fstab == NULL)
+		fstab = iis_fs_tab;
+
+	for (fs = 0; fs < ARRAY_SIZE(iis_fs_tab); fs++) {
+		fsdiv = iis_fs_tab[fs];
+
+		fsclk = clkrate / fsdiv;
+		div = fsclk / rate;
+
+		if ((fsclk % rate) > (rate / 2))
+			div++;
+
+		if (div <= 1)
+			continue;
+
+		actual = clkrate / (fsdiv * div);
+		deviation = actual - rate;
+
+		printk(KERN_DEBUG "%ufs: div %u => result %u, deviation %d\n",
+		       fsdiv, div, actual, deviation);
+
+		deviation = abs(deviation);
+
+		if (deviation < best_deviation) {
+			best_fs = fsdiv;
+			best_div = div;
+			best_rate = actual;
+			best_deviation = deviation;
+		}
+
+		if (deviation == 0)
+			break;
+	}
+
+	printk(KERN_DEBUG "best: fs=%u, div=%u, rate=%u\n",
+	       best_fs, best_div, best_rate);
+
+	info->fs_div = best_fs;
+	info->clk_div = best_div;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s3c_i2sv2_iis_calc_rate);
+
+int s3c_i2sv2_probe(struct platform_device *pdev,
+		    struct snd_soc_dai *dai,
+		    struct s3c_i2sv2_info *i2s,
+		    unsigned long base)
+{
+	struct device *dev = &pdev->dev;
+	unsigned int iismod;
+
+	i2s->dev = dev;
+
+	/* record our i2s structure for later use in the callbacks */
+	dai->private_data = i2s;
+
+	if (!base) {
+		struct resource *res = platform_get_resource(pdev,
+							     IORESOURCE_MEM,
+							     0);
+		if (!res) {
+			dev_err(dev, "Unable to get register resource\n");
+			return -ENXIO;
+		}
+
+		if (!request_mem_region(res->start, resource_size(res),
+					"s3c64xx-i2s-v4")) {
+			dev_err(dev, "Unable to request register region\n");
+			return -EBUSY;
+		}
+
+		base = res->start;
+	}
+
+	i2s->regs = ioremap(base, 0x100);
+	if (i2s->regs == NULL) {
+		dev_err(dev, "cannot ioremap registers\n");
+		return -ENXIO;
+	}
+
+	i2s->iis_pclk = clk_get(dev, "iis");
+	if (IS_ERR(i2s->iis_pclk)) {
+		dev_err(dev, "failed to get iis_clock\n");
+		iounmap(i2s->regs);
+		return -ENOENT;
+	}
+
+	clk_enable(i2s->iis_pclk);
+
+	/* Mark ourselves as in TXRX mode so we can run through our cleanup
+	 * process without warnings. */
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	iismod |= S3C2412_IISMOD_MODE_TXRX;
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	s3c2412_snd_txctrl(i2s, 0);
+	s3c2412_snd_rxctrl(i2s, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s3c_i2sv2_probe);
+
+#ifdef CONFIG_PM
+static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(dai);
+	u32 iismod;
+
+	if (dai->active) {
+		i2s->suspend_iismod = readl(i2s->regs + S3C2412_IISMOD);
+		i2s->suspend_iiscon = readl(i2s->regs + S3C2412_IISCON);
+		i2s->suspend_iispsr = readl(i2s->regs + S3C2412_IISPSR);
+
+		/* some basic suspend checks */
+
+		iismod = readl(i2s->regs + S3C2412_IISMOD);
+
+		if (iismod & S3C2412_IISCON_RXDMA_ACTIVE)
+			pr_warning("%s: RXDMA active?\n", __func__);
+
+		if (iismod & S3C2412_IISCON_TXDMA_ACTIVE)
+			pr_warning("%s: TXDMA active?\n", __func__);
+
+		if (iismod & S3C2412_IISCON_IIS_ACTIVE)
+			pr_warning("%s: IIS active\n", __func__);
+	}
+
+	return 0;
+}
+
+static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(dai);
+
+	pr_info("dai_active %d, IISMOD %08x, IISCON %08x\n",
+		dai->active, i2s->suspend_iismod, i2s->suspend_iiscon);
+
+	if (dai->active) {
+		writel(i2s->suspend_iiscon, i2s->regs + S3C2412_IISCON);
+		writel(i2s->suspend_iismod, i2s->regs + S3C2412_IISMOD);
+		writel(i2s->suspend_iispsr, i2s->regs + S3C2412_IISPSR);
+
+		writel(S3C2412_IISFIC_RXFLUSH | S3C2412_IISFIC_TXFLUSH,
+		       i2s->regs + S3C2412_IISFIC);
+
+		ndelay(250);
+		writel(0x0, i2s->regs + S3C2412_IISFIC);
+	}
+
+	return 0;
+}
+#else
+#define s3c2412_i2s_suspend NULL
+#define s3c2412_i2s_resume  NULL
+#endif
+
+int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
+{
+	struct snd_soc_dai_ops *ops = dai->ops;
+
+	ops->trigger = s3c2412_i2s_trigger;
+	if (!ops->hw_params)
+		ops->hw_params = s3c_i2sv2_hw_params;
+	ops->set_fmt = s3c2412_i2s_set_fmt;
+	ops->set_clkdiv = s3c2412_i2s_set_clkdiv;
+	ops->set_sysclk = s3c_i2sv2_set_sysclk;
+
+	/* Allow overriding by (for example) IISv4 */
+	if (!ops->delay)
+		ops->delay = s3c2412_i2s_delay;
+
+	dai->suspend = s3c2412_i2s_suspend;
+	dai->resume = s3c2412_i2s_resume;
+
+	return snd_soc_register_dai(dai);
+}
+EXPORT_SYMBOL_GPL(s3c_i2sv2_register_dai);
+
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
new file mode 100644
index 0000000..766f43a
--- /dev/null
+++ b/sound/soc/samsung/s3c-i2s-v2.h
@@ -0,0 +1,103 @@
+/* sound/soc/s3c24xx/s3c-i2s-v2.h
+ *
+ * ALSA Soc Audio Layer - S3C_I2SV2 I2S driver
+ *
+ * Copyright (c) 2007 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+*/
+
+/* This code is the core support for the I2S block found in a number of
+ * Samsung SoC devices which is unofficially named I2S-V2. Currently the
+ * S3C2412 and the S3C64XX series use this block to provide 1 or 2 I2S
+ * channels via configurable GPIO.
+ */
+
+#ifndef __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H
+#define __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H __FILE__
+
+#define S3C_I2SV2_DIV_BCLK	(1)
+#define S3C_I2SV2_DIV_RCLK	(2)
+#define S3C_I2SV2_DIV_PRESCALER	(3)
+
+#define S3C_I2SV2_CLKSRC_PCLK		0
+#define S3C_I2SV2_CLKSRC_AUDIOBUS	1
+#define S3C_I2SV2_CLKSRC_CDCLK		2
+
+/* Set this flag for I2S controllers that have the bit IISMOD[12]
+ * bridge/break RCLK signal and external Xi2sCDCLK pin.
+ */
+#define S3C_FEATURE_CDCLKCON	(1 << 0)
+
+/**
+ * struct s3c_i2sv2_info - S3C I2S-V2 information
+ * @dev: The parent device passed to use from the probe.
+ * @regs: The pointer to the device registe block.
+ * @feature: Set of bit-flags indicating features of the controller.
+ * @master: True if the I2S core is the I2S bit clock master.
+ * @dma_playback: DMA information for playback channel.
+ * @dma_capture: DMA information for capture channel.
+ * @suspend_iismod: PM save for the IISMOD register.
+ * @suspend_iiscon: PM save for the IISCON register.
+ * @suspend_iispsr: PM save for the IISPSR register.
+ *
+ * This is the private codec state for the hardware associated with an
+ * I2S channel such as the register mappings and clock sources.
+ */
+struct s3c_i2sv2_info {
+	struct device	*dev;
+	void __iomem	*regs;
+
+	u32		feature;
+
+	struct clk	*iis_pclk;
+	struct clk	*iis_cclk;
+
+	unsigned char	 master;
+
+	struct s3c_dma_params	*dma_playback;
+	struct s3c_dma_params	*dma_capture;
+
+	u32		 suspend_iismod;
+	u32		 suspend_iiscon;
+	u32		 suspend_iispsr;
+};
+
+extern struct clk *s3c_i2sv2_get_clock(struct snd_soc_dai *cpu_dai);
+
+struct s3c_i2sv2_rate_calc {
+	unsigned int	clk_div;	/* for prescaler */
+	unsigned int	fs_div;		/* for root frame clock */
+};
+
+extern int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
+				   unsigned int *fstab,
+				   unsigned int rate, struct clk *clk);
+
+/**
+ * s3c_i2sv2_probe - probe for i2s device helper
+ * @pdev: The platform device supplied to the original probe.
+ * @dai: The ASoC DAI structure supplied to the original probe.
+ * @i2s: Our local i2s structure to fill in.
+ * @base: The base address for the registers.
+ */
+extern int s3c_i2sv2_probe(struct platform_device *pdev,
+			   struct snd_soc_dai *dai,
+			   struct s3c_i2sv2_info *i2s,
+			   unsigned long base);
+
+/**
+ * s3c_i2sv2_register_dai - register dai with soc core
+ * @dai: The snd_soc_dai structure to register
+ *
+ * Fill in any missing fields and then register the given dai with the
+ * soc core.
+ */
+extern int s3c_i2sv2_register_dai(struct snd_soc_dai *dai);
+
+#endif /* __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H */
diff --git a/sound/soc/samsung/s3c-pcm.c b/sound/soc/samsung/s3c-pcm.c
new file mode 100644
index 0000000..326f0a9
--- /dev/null
+++ b/sound/soc/samsung/s3c-pcm.c
@@ -0,0 +1,554 @@
+/* sound/soc/s3c24xx/s3c-pcm.c
+ *
+ * ALSA SoC Audio Layer - S3C PCM-Controller driver
+ *
+ * Copyright (c) 2009 Samsung Electronics Co. Ltd
+ * Author: Jaswinder Singh <jassi.brar@samsung.com>
+ * based upon I2S drivers by Ben Dooks.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <plat/audio.h>
+#include <plat/dma.h>
+
+#include "s3c-dma.h"
+#include "s3c-pcm.h"
+
+static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
+	.name		= "PCM Stereo out"
+};
+
+static struct s3c2410_dma_client s3c_pcm_dma_client_in = {
+	.name		= "PCM Stereo in"
+};
+
+static struct s3c_dma_params s3c_pcm_stereo_out[] = {
+	[0] = {
+		.client		= &s3c_pcm_dma_client_out,
+		.dma_size	= 4,
+	},
+	[1] = {
+		.client		= &s3c_pcm_dma_client_out,
+		.dma_size	= 4,
+	},
+};
+
+static struct s3c_dma_params s3c_pcm_stereo_in[] = {
+	[0] = {
+		.client		= &s3c_pcm_dma_client_in,
+		.dma_size	= 4,
+	},
+	[1] = {
+		.client		= &s3c_pcm_dma_client_in,
+		.dma_size	= 4,
+	},
+};
+
+static struct s3c_pcm_info s3c_pcm[2];
+
+static inline struct s3c_pcm_info *to_info(struct snd_soc_dai *cpu_dai)
+{
+	return cpu_dai->private_data;
+}
+
+static void s3c_pcm_snd_txctrl(struct s3c_pcm_info *pcm, int on)
+{
+	void __iomem *regs = pcm->regs;
+	u32 ctl, clkctl;
+
+	clkctl = readl(regs + S3C_PCM_CLKCTL);
+	ctl = readl(regs + S3C_PCM_CTL);
+	ctl &= ~(S3C_PCM_CTL_TXDIPSTICK_MASK
+			 << S3C_PCM_CTL_TXDIPSTICK_SHIFT);
+
+	if (on) {
+		ctl |= S3C_PCM_CTL_TXDMA_EN;
+		ctl |= S3C_PCM_CTL_TXFIFO_EN;
+		ctl |= S3C_PCM_CTL_ENABLE;
+		ctl |= (0x20<<S3C_PCM_CTL_TXDIPSTICK_SHIFT);
+		clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
+	} else {
+		ctl &= ~S3C_PCM_CTL_TXDMA_EN;
+		ctl &= ~S3C_PCM_CTL_TXFIFO_EN;
+
+		if (!(ctl & S3C_PCM_CTL_RXFIFO_EN)) {
+			ctl &= ~S3C_PCM_CTL_ENABLE;
+			if (!pcm->idleclk)
+				clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
+		}
+	}
+
+	writel(clkctl, regs + S3C_PCM_CLKCTL);
+	writel(ctl, regs + S3C_PCM_CTL);
+}
+
+static void s3c_pcm_snd_rxctrl(struct s3c_pcm_info *pcm, int on)
+{
+	void __iomem *regs = pcm->regs;
+	u32 ctl, clkctl;
+
+	ctl = readl(regs + S3C_PCM_CTL);
+	clkctl = readl(regs + S3C_PCM_CLKCTL);
+
+	if (on) {
+		ctl |= S3C_PCM_CTL_RXDMA_EN;
+		ctl |= S3C_PCM_CTL_RXFIFO_EN;
+		ctl |= S3C_PCM_CTL_ENABLE;
+		clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
+	} else {
+		ctl &= ~S3C_PCM_CTL_RXDMA_EN;
+		ctl &= ~S3C_PCM_CTL_RXFIFO_EN;
+
+		if (!(ctl & S3C_PCM_CTL_TXFIFO_EN)) {
+			ctl &= ~S3C_PCM_CTL_ENABLE;
+			if (!pcm->idleclk)
+				clkctl |= S3C_PCM_CLKCTL_SERCLK_EN;
+		}
+	}
+
+	writel(clkctl, regs + S3C_PCM_CLKCTL);
+	writel(ctl, regs + S3C_PCM_CTL);
+}
+
+static int s3c_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c_pcm_info *pcm = to_info(rtd->dai->cpu_dai);
+	unsigned long flags;
+
+	dev_dbg(pcm->dev, "Entered %s\n", __func__);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		spin_lock_irqsave(&pcm->lock, flags);
+
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			s3c_pcm_snd_rxctrl(pcm, 1);
+		else
+			s3c_pcm_snd_txctrl(pcm, 1);
+
+		spin_unlock_irqrestore(&pcm->lock, flags);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		spin_lock_irqsave(&pcm->lock, flags);
+
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			s3c_pcm_snd_rxctrl(pcm, 0);
+		else
+			s3c_pcm_snd_txctrl(pcm, 0);
+
+		spin_unlock_irqrestore(&pcm->lock, flags);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *socdai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_link *dai = rtd->dai;
+	struct s3c_pcm_info *pcm = to_info(dai->cpu_dai);
+	struct s3c_dma_params *dma_data;
+	void __iomem *regs = pcm->regs;
+	struct clk *clk;
+	int sclk_div, sync_div;
+	unsigned long flags;
+	u32 clkctl;
+
+	dev_dbg(pcm->dev, "Entered %s\n", __func__);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = pcm->dma_playback;
+	else
+		dma_data = pcm->dma_capture;
+
+	snd_soc_dai_set_dma_data(dai->cpu_dai, substream, dma_data);
+
+	/* Strictly check for sample size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&pcm->lock, flags);
+
+	/* Get hold of the PCMSOURCE_CLK */
+	clkctl = readl(regs + S3C_PCM_CLKCTL);
+	if (clkctl & S3C_PCM_CLKCTL_SERCLKSEL_PCLK)
+		clk = pcm->pclk;
+	else
+		clk = pcm->cclk;
+
+	/* Set the SCLK divider */
+	sclk_div = clk_get_rate(clk) / pcm->sclk_per_fs /
+					params_rate(params) / 2 - 1;
+
+	clkctl &= ~(S3C_PCM_CLKCTL_SCLKDIV_MASK
+			<< S3C_PCM_CLKCTL_SCLKDIV_SHIFT);
+	clkctl |= ((sclk_div & S3C_PCM_CLKCTL_SCLKDIV_MASK)
+			<< S3C_PCM_CLKCTL_SCLKDIV_SHIFT);
+
+	/* Set the SYNC divider */
+	sync_div = pcm->sclk_per_fs - 1;
+
+	clkctl &= ~(S3C_PCM_CLKCTL_SYNCDIV_MASK
+				<< S3C_PCM_CLKCTL_SYNCDIV_SHIFT);
+	clkctl |= ((sync_div & S3C_PCM_CLKCTL_SYNCDIV_MASK)
+				<< S3C_PCM_CLKCTL_SYNCDIV_SHIFT);
+
+	writel(clkctl, regs + S3C_PCM_CLKCTL);
+
+	spin_unlock_irqrestore(&pcm->lock, flags);
+
+	dev_dbg(pcm->dev, "PCMSOURCE_CLK-%lu SCLK=%ufs SCLK_DIV=%d SYNC_DIV=%d\n",
+				clk_get_rate(clk), pcm->sclk_per_fs,
+				sclk_div, sync_div);
+
+	return 0;
+}
+
+static int s3c_pcm_set_fmt(struct snd_soc_dai *cpu_dai,
+			       unsigned int fmt)
+{
+	struct s3c_pcm_info *pcm = to_info(cpu_dai);
+	void __iomem *regs = pcm->regs;
+	unsigned long flags;
+	int ret = 0;
+	u32 ctl;
+
+	dev_dbg(pcm->dev, "Entered %s\n", __func__);
+
+	spin_lock_irqsave(&pcm->lock, flags);
+
+	ctl = readl(regs + S3C_PCM_CTL);
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		/* Nothing to do, NB_NF by default */
+		break;
+	default:
+		dev_err(pcm->dev, "Unsupported clock inversion!\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Nothing to do, Master by default */
+		break;
+	default:
+		dev_err(pcm->dev, "Unsupported master/slave format!\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
+	case SND_SOC_DAIFMT_CONT:
+		pcm->idleclk = 1;
+		break;
+	case SND_SOC_DAIFMT_GATED:
+		pcm->idleclk = 0;
+		break;
+	default:
+		dev_err(pcm->dev, "Invalid Clock gating request!\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		ctl |= S3C_PCM_CTL_TXMSB_AFTER_FSYNC;
+		ctl |= S3C_PCM_CTL_RXMSB_AFTER_FSYNC;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ctl &= ~S3C_PCM_CTL_TXMSB_AFTER_FSYNC;
+		ctl &= ~S3C_PCM_CTL_RXMSB_AFTER_FSYNC;
+		break;
+	default:
+		dev_err(pcm->dev, "Unsupported data format!\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	writel(ctl, regs + S3C_PCM_CTL);
+
+exit:
+	spin_unlock_irqrestore(&pcm->lock, flags);
+
+	return ret;
+}
+
+static int s3c_pcm_set_clkdiv(struct snd_soc_dai *cpu_dai,
+						int div_id, int div)
+{
+	struct s3c_pcm_info *pcm = to_info(cpu_dai);
+
+	switch (div_id) {
+	case S3C_PCM_SCLK_PER_FS:
+		pcm->sclk_per_fs = div;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int s3c_pcm_set_sysclk(struct snd_soc_dai *cpu_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct s3c_pcm_info *pcm = to_info(cpu_dai);
+	void __iomem *regs = pcm->regs;
+	u32 clkctl = readl(regs + S3C_PCM_CLKCTL);
+
+	switch (clk_id) {
+	case S3C_PCM_CLKSRC_PCLK:
+		clkctl |= S3C_PCM_CLKCTL_SERCLKSEL_PCLK;
+		break;
+
+	case S3C_PCM_CLKSRC_MUX:
+		clkctl &= ~S3C_PCM_CLKCTL_SERCLKSEL_PCLK;
+
+		if (clk_get_rate(pcm->cclk) != freq)
+			clk_set_rate(pcm->cclk, freq);
+
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel(clkctl, regs + S3C_PCM_CLKCTL);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops s3c_pcm_dai_ops = {
+	.set_sysclk	= s3c_pcm_set_sysclk,
+	.set_clkdiv	= s3c_pcm_set_clkdiv,
+	.trigger	= s3c_pcm_trigger,
+	.hw_params	= s3c_pcm_hw_params,
+	.set_fmt	= s3c_pcm_set_fmt,
+};
+
+#define S3C_PCM_RATES  SNDRV_PCM_RATE_8000_96000
+
+#define S3C_PCM_DECLARE(n)			\
+{								\
+	.name		 = "samsung-pcm",			\
+	.id		 = (n),				\
+	.symmetric_rates = 1,					\
+	.ops = &s3c_pcm_dai_ops,				\
+	.playback = {						\
+		.channels_min	= 2,				\
+		.channels_max	= 2,				\
+		.rates		= S3C_PCM_RATES,		\
+		.formats	= SNDRV_PCM_FMTBIT_S16_LE,	\
+	},							\
+	.capture = {						\
+		.channels_min	= 2,				\
+		.channels_max	= 2,				\
+		.rates		= S3C_PCM_RATES,		\
+		.formats	= SNDRV_PCM_FMTBIT_S16_LE,	\
+	},							\
+}
+
+struct snd_soc_dai s3c_pcm_dai[] = {
+	S3C_PCM_DECLARE(0),
+	S3C_PCM_DECLARE(1),
+};
+EXPORT_SYMBOL_GPL(s3c_pcm_dai);
+
+static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
+{
+	struct s3c_pcm_info *pcm;
+	struct snd_soc_dai *dai;
+	struct resource *mem_res, *dmatx_res, *dmarx_res;
+	struct s3c_audio_pdata *pcm_pdata;
+	int ret;
+
+	/* Check for valid device index */
+	if ((pdev->id < 0) || pdev->id >= ARRAY_SIZE(s3c_pcm)) {
+		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
+		return -EINVAL;
+	}
+
+	pcm_pdata = pdev->dev.platform_data;
+
+	/* Check for availability of necessary resource */
+	dmatx_res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!dmatx_res) {
+		dev_err(&pdev->dev, "Unable to get PCM-TX dma resource\n");
+		return -ENXIO;
+	}
+
+	dmarx_res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!dmarx_res) {
+		dev_err(&pdev->dev, "Unable to get PCM-RX dma resource\n");
+		return -ENXIO;
+	}
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem_res) {
+		dev_err(&pdev->dev, "Unable to get register resource\n");
+		return -ENXIO;
+	}
+
+	if (pcm_pdata && pcm_pdata->cfg_gpio && pcm_pdata->cfg_gpio(pdev)) {
+		dev_err(&pdev->dev, "Unable to configure gpio\n");
+		return -EINVAL;
+	}
+
+	pcm = &s3c_pcm[pdev->id];
+	pcm->dev = &pdev->dev;
+
+	spin_lock_init(&pcm->lock);
+
+	dai = &s3c_pcm_dai[pdev->id];
+	dai->dev = &pdev->dev;
+
+	/* Default is 128fs */
+	pcm->sclk_per_fs = 128;
+
+	pcm->cclk = clk_get(&pdev->dev, "audio-bus");
+	if (IS_ERR(pcm->cclk)) {
+		dev_err(&pdev->dev, "failed to get audio-bus\n");
+		ret = PTR_ERR(pcm->cclk);
+		goto err1;
+	}
+	clk_enable(pcm->cclk);
+
+	/* record our pcm structure for later use in the callbacks */
+	dai->private_data = pcm;
+
+	if (!request_mem_region(mem_res->start,
+				resource_size(mem_res), "samsung-pcm")) {
+		dev_err(&pdev->dev, "Unable to request register region\n");
+		ret = -EBUSY;
+		goto err2;
+	}
+
+	pcm->regs = ioremap(mem_res->start, 0x100);
+	if (pcm->regs == NULL) {
+		dev_err(&pdev->dev, "cannot ioremap registers\n");
+		ret = -ENXIO;
+		goto err3;
+	}
+
+	pcm->pclk = clk_get(&pdev->dev, "pcm");
+	if (IS_ERR(pcm->pclk)) {
+		dev_err(&pdev->dev, "failed to get pcm_clock\n");
+		ret = -ENOENT;
+		goto err4;
+	}
+	clk_enable(pcm->pclk);
+
+	ret = snd_soc_register_dai(dai);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "failed to get pcm_clock\n");
+		goto err5;
+	}
+
+	s3c_pcm_stereo_in[pdev->id].dma_addr = mem_res->start
+							+ S3C_PCM_RXFIFO;
+	s3c_pcm_stereo_out[pdev->id].dma_addr = mem_res->start
+							+ S3C_PCM_TXFIFO;
+
+	s3c_pcm_stereo_in[pdev->id].channel = dmarx_res->start;
+	s3c_pcm_stereo_out[pdev->id].channel = dmatx_res->start;
+
+	pcm->dma_capture = &s3c_pcm_stereo_in[pdev->id];
+	pcm->dma_playback = &s3c_pcm_stereo_out[pdev->id];
+
+	return 0;
+
+err5:
+	clk_disable(pcm->pclk);
+	clk_put(pcm->pclk);
+err4:
+	iounmap(pcm->regs);
+err3:
+	release_mem_region(mem_res->start, resource_size(mem_res));
+err2:
+	clk_disable(pcm->cclk);
+	clk_put(pcm->cclk);
+err1:
+	return ret;
+}
+
+static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
+{
+	struct s3c_pcm_info *pcm = &s3c_pcm[pdev->id];
+	struct resource *mem_res;
+
+	iounmap(pcm->regs);
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem_res->start, resource_size(mem_res));
+
+	clk_disable(pcm->cclk);
+	clk_disable(pcm->pclk);
+	clk_put(pcm->pclk);
+	clk_put(pcm->cclk);
+
+	return 0;
+}
+
+static struct platform_driver s3c_pcm_driver = {
+	.probe  = s3c_pcm_dev_probe,
+	.remove = s3c_pcm_dev_remove,
+	.driver = {
+		.name = "samsung-pcm",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init s3c_pcm_init(void)
+{
+	return platform_driver_register(&s3c_pcm_driver);
+}
+module_init(s3c_pcm_init);
+
+static void __exit s3c_pcm_exit(void)
+{
+	platform_driver_unregister(&s3c_pcm_driver);
+}
+module_exit(s3c_pcm_exit);
+
+/* Module information */
+MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
+MODULE_DESCRIPTION("S3C PCM Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c-pcm.h b/sound/soc/samsung/s3c-pcm.h
new file mode 100644
index 0000000..69ff997
--- /dev/null
+++ b/sound/soc/samsung/s3c-pcm.h
@@ -0,0 +1,123 @@
+/*  sound/soc/s3c24xx/s3c-pcm.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __S3C_PCM_H
+#define __S3C_PCM_H __FILE__
+
+/*Register Offsets */
+#define S3C_PCM_CTL	(0x00)
+#define S3C_PCM_CLKCTL	(0x04)
+#define S3C_PCM_TXFIFO	(0x08)
+#define S3C_PCM_RXFIFO	(0x0C)
+#define S3C_PCM_IRQCTL	(0x10)
+#define S3C_PCM_IRQSTAT	(0x14)
+#define S3C_PCM_FIFOSTAT	(0x18)
+#define S3C_PCM_CLRINT	(0x20)
+
+/* PCM_CTL Bit-Fields */
+#define S3C_PCM_CTL_TXDIPSTICK_MASK		(0x3f)
+#define S3C_PCM_CTL_TXDIPSTICK_SHIFT	(13)
+#define S3C_PCM_CTL_RXDIPSTICK_MSK		(0x3f<<7)
+#define S3C_PCM_CTL_TXDMA_EN		(0x1<<6)
+#define S3C_PCM_CTL_RXDMA_EN		(0x1<<5)
+#define S3C_PCM_CTL_TXMSB_AFTER_FSYNC	(0x1<<4)
+#define S3C_PCM_CTL_RXMSB_AFTER_FSYNC	(0x1<<3)
+#define S3C_PCM_CTL_TXFIFO_EN		(0x1<<2)
+#define S3C_PCM_CTL_RXFIFO_EN		(0x1<<1)
+#define S3C_PCM_CTL_ENABLE			(0x1<<0)
+
+/* PCM_CLKCTL Bit-Fields */
+#define S3C_PCM_CLKCTL_SERCLK_EN		(0x1<<19)
+#define S3C_PCM_CLKCTL_SERCLKSEL_PCLK	(0x1<<18)
+#define S3C_PCM_CLKCTL_SCLKDIV_MASK		(0x1ff)
+#define S3C_PCM_CLKCTL_SYNCDIV_MASK		(0x1ff)
+#define S3C_PCM_CLKCTL_SCLKDIV_SHIFT	(9)
+#define S3C_PCM_CLKCTL_SYNCDIV_SHIFT	(0)
+
+/* PCM_TXFIFO Bit-Fields */
+#define S3C_PCM_TXFIFO_DVALID	(0x1<<16)
+#define S3C_PCM_TXFIFO_DATA_MSK	(0xffff<<0)
+
+/* PCM_RXFIFO Bit-Fields */
+#define S3C_PCM_RXFIFO_DVALID	(0x1<<16)
+#define S3C_PCM_RXFIFO_DATA_MSK	(0xffff<<0)
+
+/* PCM_IRQCTL Bit-Fields */
+#define S3C_PCM_IRQCTL_IRQEN		(0x1<<14)
+#define S3C_PCM_IRQCTL_WRDEN		(0x1<<12)
+#define S3C_PCM_IRQCTL_TXEMPTYEN		(0x1<<11)
+#define S3C_PCM_IRQCTL_TXALMSTEMPTYEN	(0x1<<10)
+#define S3C_PCM_IRQCTL_TXFULLEN		(0x1<<9)
+#define S3C_PCM_IRQCTL_TXALMSTFULLEN	(0x1<<8)
+#define S3C_PCM_IRQCTL_TXSTARVEN		(0x1<<7)
+#define S3C_PCM_IRQCTL_TXERROVRFLEN		(0x1<<6)
+#define S3C_PCM_IRQCTL_RXEMPTEN		(0x1<<5)
+#define S3C_PCM_IRQCTL_RXALMSTEMPTEN	(0x1<<4)
+#define S3C_PCM_IRQCTL_RXFULLEN		(0x1<<3)
+#define S3C_PCM_IRQCTL_RXALMSTFULLEN	(0x1<<2)
+#define S3C_PCM_IRQCTL_RXSTARVEN		(0x1<<1)
+#define S3C_PCM_IRQCTL_RXERROVRFLEN		(0x1<<0)
+
+/* PCM_IRQSTAT Bit-Fields */
+#define S3C_PCM_IRQSTAT_IRQPND		(0x1<<13)
+#define S3C_PCM_IRQSTAT_WRD_XFER		(0x1<<12)
+#define S3C_PCM_IRQSTAT_TXEMPTY		(0x1<<11)
+#define S3C_PCM_IRQSTAT_TXALMSTEMPTY	(0x1<<10)
+#define S3C_PCM_IRQSTAT_TXFULL		(0x1<<9)
+#define S3C_PCM_IRQSTAT_TXALMSTFULL		(0x1<<8)
+#define S3C_PCM_IRQSTAT_TXSTARV		(0x1<<7)
+#define S3C_PCM_IRQSTAT_TXERROVRFL		(0x1<<6)
+#define S3C_PCM_IRQSTAT_RXEMPT		(0x1<<5)
+#define S3C_PCM_IRQSTAT_RXALMSTEMPT		(0x1<<4)
+#define S3C_PCM_IRQSTAT_RXFULL		(0x1<<3)
+#define S3C_PCM_IRQSTAT_RXALMSTFULL		(0x1<<2)
+#define S3C_PCM_IRQSTAT_RXSTARV		(0x1<<1)
+#define S3C_PCM_IRQSTAT_RXERROVRFL		(0x1<<0)
+
+/* PCM_FIFOSTAT Bit-Fields */
+#define S3C_PCM_FIFOSTAT_TXCNT_MSK		(0x3f<<14)
+#define S3C_PCM_FIFOSTAT_TXFIFOEMPTY	(0x1<<13)
+#define S3C_PCM_FIFOSTAT_TXFIFOALMSTEMPTY	(0x1<<12)
+#define S3C_PCM_FIFOSTAT_TXFIFOFULL		(0x1<<11)
+#define S3C_PCM_FIFOSTAT_TXFIFOALMSTFULL	(0x1<<10)
+#define S3C_PCM_FIFOSTAT_RXCNT_MSK		(0x3f<<4)
+#define S3C_PCM_FIFOSTAT_RXFIFOEMPTY	(0x1<<3)
+#define S3C_PCM_FIFOSTAT_RXFIFOALMSTEMPTY	(0x1<<2)
+#define S3C_PCM_FIFOSTAT_RXFIFOFULL		(0x1<<1)
+#define S3C_PCM_FIFOSTAT_RXFIFOALMSTFULL	(0x1<<0)
+
+#define S3C_PCM_CLKSRC_PCLK	0
+#define S3C_PCM_CLKSRC_MUX	1
+
+#define S3C_PCM_SCLK_PER_FS	0
+
+/**
+ * struct s3c_pcm_info - S3C PCM Controller information
+ * @dev: The parent device passed to use from the probe.
+ * @regs: The pointer to the device register block.
+ * @dma_playback: DMA information for playback channel.
+ * @dma_capture: DMA information for capture channel.
+ */
+struct s3c_pcm_info {
+	spinlock_t lock;
+	struct device	*dev;
+	void __iomem	*regs;
+
+	unsigned int sclk_per_fs;
+
+	/* Whether to keep PCMSCLK enabled even when idle(no active xfer) */
+	unsigned int idleclk;
+
+	struct clk	*pclk;
+	struct clk	*cclk;
+
+	struct s3c_dma_params	*dma_playback;
+	struct s3c_dma_params	*dma_capture;
+};
+
+#endif /* __S3C_PCM_H */
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
new file mode 100644
index 0000000..709adef
--- /dev/null
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -0,0 +1,190 @@
+/* sound/soc/s3c24xx/s3c2412-i2s.c
+ *
+ * ALSA Soc Audio Layer - S3C2412 I2S driver
+ *
+ * Copyright (c) 2006 Wolfson Microelectronics PLC.
+ *	Graeme Gregory graeme.gregory@wolfsonmicro.com
+ *	linux@wolfsonmicro.com
+ *
+ * Copyright (c) 2007, 2004-2005 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <mach/hardware.h>
+
+#include <mach/regs-gpio.h>
+#include <mach/dma.h>
+
+#include "s3c-dma.h"
+#include "regs-i2s-v2.h"
+#include "s3c2412-i2s.h"
+
+#define S3C2412_I2S_DEBUG 0
+
+static struct s3c2410_dma_client s3c2412_dma_client_out = {
+	.name		= "I2S PCM Stereo out"
+};
+
+static struct s3c2410_dma_client s3c2412_dma_client_in = {
+	.name		= "I2S PCM Stereo in"
+};
+
+static struct s3c_dma_params s3c2412_i2s_pcm_stereo_out = {
+	.client		= &s3c2412_dma_client_out,
+	.channel	= DMACH_I2S_OUT,
+	.dma_addr	= S3C2410_PA_IIS + S3C2412_IISTXD,
+	.dma_size	= 4,
+};
+
+static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
+	.client		= &s3c2412_dma_client_in,
+	.channel	= DMACH_I2S_IN,
+	.dma_addr	= S3C2410_PA_IIS + S3C2412_IISRXD,
+	.dma_size	= 4,
+};
+
+static struct s3c_i2sv2_info s3c2412_i2s;
+
+static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
+{
+	return cpu_dai->private_data;
+}
+
+static int s3c2412_i2s_probe(struct platform_device *pdev,
+			     struct snd_soc_dai *dai)
+{
+	int ret;
+
+	pr_debug("Entered %s\n", __func__);
+
+	ret = s3c_i2sv2_probe(pdev, dai, &s3c2412_i2s, S3C2410_PA_IIS);
+	if (ret)
+		return ret;
+
+	s3c2412_i2s.dma_capture = &s3c2412_i2s_pcm_stereo_in;
+	s3c2412_i2s.dma_playback = &s3c2412_i2s_pcm_stereo_out;
+
+	s3c2412_i2s.iis_cclk = clk_get(&pdev->dev, "i2sclk");
+	if (s3c2412_i2s.iis_cclk == NULL) {
+		pr_err("failed to get i2sclk clock\n");
+		iounmap(s3c2412_i2s.regs);
+		return -ENODEV;
+	}
+
+	/* Set MPLL as the source for IIS CLK */
+
+	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
+	clk_enable(s3c2412_i2s.iis_cclk);
+
+	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
+
+	/* Configure the I2S pins in correct mode */
+	s3c2410_gpio_cfgpin(S3C2410_GPE0, S3C2410_GPE0_I2SLRCK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE1, S3C2410_GPE1_I2SSCLK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE2, S3C2410_GPE2_CDCLK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE3, S3C2410_GPE3_I2SSDI);
+	s3c2410_gpio_cfgpin(S3C2410_GPE4, S3C2410_GPE4_I2SSDO);
+
+	return 0;
+}
+
+static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *cpu_dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	struct s3c_dma_params *dma_data;
+	u32 iismod;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = i2s->dma_playback;
+	else
+		dma_data = i2s->dma_capture;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
+
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	pr_debug("%s: r: IISMOD: %x\n", __func__, iismod);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		iismod |= S3C2412_IISMOD_8BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		iismod &= ~S3C2412_IISMOD_8BIT;
+		break;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	pr_debug("%s: w: IISMOD: %x\n", __func__, iismod);
+
+	return 0;
+}
+
+#define S3C2412_I2S_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+static struct snd_soc_dai_ops s3c2412_i2s_dai_ops = {
+	.hw_params	= s3c2412_i2s_hw_params,
+};
+
+struct snd_soc_dai s3c2412_i2s_dai = {
+	.name		= "s3c2412-i2s",
+	.id		= 0,
+	.probe		= s3c2412_i2s_probe,
+	.playback = {
+		.channels_min	= 2,
+		.channels_max	= 2,
+		.rates		= S3C2412_I2S_RATES,
+		.formats	= SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.channels_min	= 2,
+		.channels_max	= 2,
+		.rates		= S3C2412_I2S_RATES,
+		.formats	= SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &s3c2412_i2s_dai_ops,
+};
+EXPORT_SYMBOL_GPL(s3c2412_i2s_dai);
+
+static int __init s3c2412_i2s_init(void)
+{
+	return  s3c_i2sv2_register_dai(&s3c2412_i2s_dai);
+}
+module_init(s3c2412_i2s_init);
+
+static void __exit s3c2412_i2s_exit(void)
+{
+	snd_soc_unregister_dai(&s3c2412_i2s_dai);
+}
+module_exit(s3c2412_i2s_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("S3C2412 I2S SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c2412-i2s.h b/sound/soc/samsung/s3c2412-i2s.h
new file mode 100644
index 0000000..0b5686b
--- /dev/null
+++ b/sound/soc/samsung/s3c2412-i2s.h
@@ -0,0 +1,29 @@
+/* sound/soc/s3c24xx/s3c2412-i2s.c
+ *
+ * ALSA Soc Audio Layer - S3C2412 I2S driver
+ *
+ * Copyright (c) 2007 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+*/
+
+#ifndef __SND_SOC_S3C24XX_S3C2412_I2S_H
+#define __SND_SOC_S3C24XX_S3C2412_I2S_H __FILE__
+
+#include "s3c-i2s-v2.h"
+
+#define S3C2412_DIV_BCLK	S3C_I2SV2_DIV_BCLK
+#define S3C2412_DIV_RCLK	S3C_I2SV2_DIV_RCLK
+#define S3C2412_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
+
+#define S3C2412_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
+#define S3C2412_CLKSRC_I2SCLK	S3C_I2SV2_CLKSRC_AUDIOBUS
+
+extern struct snd_soc_dai s3c2412_i2s_dai;
+
+#endif /* __SND_SOC_S3C24XX_S3C2412_I2S_H */
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
new file mode 100644
index 0000000..c3ac890
--- /dev/null
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -0,0 +1,503 @@
+/*
+ * s3c24xx-i2s.c  --  ALSA Soc Audio Layer
+ *
+ * (c) 2006 Wolfson Microelectronics PLC.
+ * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ * Copyright 2004-2005 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <mach/hardware.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-clock.h>
+
+#include <asm/dma.h>
+#include <mach/dma.h>
+
+#include <plat/regs-iis.h>
+
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+
+static struct s3c2410_dma_client s3c24xx_dma_client_out = {
+	.name = "I2S PCM Stereo out"
+};
+
+static struct s3c2410_dma_client s3c24xx_dma_client_in = {
+	.name = "I2S PCM Stereo in"
+};
+
+static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_out = {
+	.client		= &s3c24xx_dma_client_out,
+	.channel	= DMACH_I2S_OUT,
+	.dma_addr	= S3C2410_PA_IIS + S3C2410_IISFIFO,
+	.dma_size	= 2,
+};
+
+static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_in = {
+	.client		= &s3c24xx_dma_client_in,
+	.channel	= DMACH_I2S_IN,
+	.dma_addr	= S3C2410_PA_IIS + S3C2410_IISFIFO,
+	.dma_size	= 2,
+};
+
+struct s3c24xx_i2s_info {
+	void __iomem	*regs;
+	struct clk	*iis_clk;
+	u32		iiscon;
+	u32		iismod;
+	u32		iisfcon;
+	u32		iispsr;
+};
+static struct s3c24xx_i2s_info s3c24xx_i2s;
+
+static void s3c24xx_snd_txctrl(int on)
+{
+	u32 iisfcon;
+	u32 iiscon;
+	u32 iismod;
+
+	pr_debug("Entered %s\n", __func__);
+
+	iisfcon = readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
+	iiscon  = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
+	iismod  = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
+
+	pr_debug("r: IISCON: %x IISMOD: %x IISFCON: %x\n", iiscon, iismod, iisfcon);
+
+	if (on) {
+		iisfcon |= S3C2410_IISFCON_TXDMA | S3C2410_IISFCON_TXENABLE;
+		iiscon  |= S3C2410_IISCON_TXDMAEN | S3C2410_IISCON_IISEN;
+		iiscon  &= ~S3C2410_IISCON_TXIDLE;
+		iismod  |= S3C2410_IISMOD_TXMODE;
+
+		writel(iismod,  s3c24xx_i2s.regs + S3C2410_IISMOD);
+		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
+		writel(iiscon,  s3c24xx_i2s.regs + S3C2410_IISCON);
+	} else {
+		/* note, we have to disable the FIFOs otherwise bad things
+		 * seem to happen when the DMA stops. According to the
+		 * Samsung supplied kernel, this should allow the DMA
+		 * engine and FIFOs to reset. If this isn't allowed, the
+		 * DMA engine will simply freeze randomly.
+		 */
+
+		iisfcon &= ~S3C2410_IISFCON_TXENABLE;
+		iisfcon &= ~S3C2410_IISFCON_TXDMA;
+		iiscon  |=  S3C2410_IISCON_TXIDLE;
+		iiscon  &= ~S3C2410_IISCON_TXDMAEN;
+		iismod  &= ~S3C2410_IISMOD_TXMODE;
+
+		writel(iiscon,  s3c24xx_i2s.regs + S3C2410_IISCON);
+		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
+		writel(iismod,  s3c24xx_i2s.regs + S3C2410_IISMOD);
+	}
+
+	pr_debug("w: IISCON: %x IISMOD: %x IISFCON: %x\n", iiscon, iismod, iisfcon);
+}
+
+static void s3c24xx_snd_rxctrl(int on)
+{
+	u32 iisfcon;
+	u32 iiscon;
+	u32 iismod;
+
+	pr_debug("Entered %s\n", __func__);
+
+	iisfcon = readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
+	iiscon  = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
+	iismod  = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
+
+	pr_debug("r: IISCON: %x IISMOD: %x IISFCON: %x\n", iiscon, iismod, iisfcon);
+
+	if (on) {
+		iisfcon |= S3C2410_IISFCON_RXDMA | S3C2410_IISFCON_RXENABLE;
+		iiscon  |= S3C2410_IISCON_RXDMAEN | S3C2410_IISCON_IISEN;
+		iiscon  &= ~S3C2410_IISCON_RXIDLE;
+		iismod  |= S3C2410_IISMOD_RXMODE;
+
+		writel(iismod,  s3c24xx_i2s.regs + S3C2410_IISMOD);
+		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
+		writel(iiscon,  s3c24xx_i2s.regs + S3C2410_IISCON);
+	} else {
+		/* note, we have to disable the FIFOs otherwise bad things
+		 * seem to happen when the DMA stops. According to the
+		 * Samsung supplied kernel, this should allow the DMA
+		 * engine and FIFOs to reset. If this isn't allowed, the
+		 * DMA engine will simply freeze randomly.
+		 */
+
+		iisfcon &= ~S3C2410_IISFCON_RXENABLE;
+		iisfcon &= ~S3C2410_IISFCON_RXDMA;
+		iiscon  |= S3C2410_IISCON_RXIDLE;
+		iiscon  &= ~S3C2410_IISCON_RXDMAEN;
+		iismod  &= ~S3C2410_IISMOD_RXMODE;
+
+		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
+		writel(iiscon,  s3c24xx_i2s.regs + S3C2410_IISCON);
+		writel(iismod,  s3c24xx_i2s.regs + S3C2410_IISMOD);
+	}
+
+	pr_debug("w: IISCON: %x IISMOD: %x IISFCON: %x\n", iiscon, iismod, iisfcon);
+}
+
+/*
+ * Wait for the LR signal to allow synchronisation to the L/R clock
+ * from the codec. May only be needed for slave mode.
+ */
+static int s3c24xx_snd_lrsync(void)
+{
+	u32 iiscon;
+	int timeout = 50; /* 5ms */
+
+	pr_debug("Entered %s\n", __func__);
+
+	while (1) {
+		iiscon = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
+		if (iiscon & S3C2410_IISCON_LRINDEX)
+			break;
+
+		if (!timeout--)
+			return -ETIMEDOUT;
+		udelay(100);
+	}
+
+	return 0;
+}
+
+/*
+ * Check whether CPU is the master or slave
+ */
+static inline int s3c24xx_snd_is_clkmaster(void)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	return (readl(s3c24xx_i2s.regs + S3C2410_IISMOD) & S3C2410_IISMOD_SLAVE) ? 0:1;
+}
+
+/*
+ * Set S3C24xx I2S DAI format
+ */
+static int s3c24xx_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	u32 iismod;
+
+	pr_debug("Entered %s\n", __func__);
+
+	iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
+	pr_debug("hw_params r: IISMOD: %x \n", iismod);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		iismod |= S3C2410_IISMOD_SLAVE;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		iismod &= ~S3C2410_IISMOD_SLAVE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_LEFT_J:
+		iismod |= S3C2410_IISMOD_MSB;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		iismod &= ~S3C2410_IISMOD_MSB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
+	pr_debug("hw_params w: IISMOD: %x \n", iismod);
+	return 0;
+}
+
+static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c_dma_params *dma_data;
+	u32 iismod;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = &s3c24xx_i2s_pcm_stereo_out;
+	else
+		dma_data = &s3c24xx_i2s_pcm_stereo_in;
+
+	snd_soc_dai_set_dma_data(rtd->dai->cpu_dai, substream, dma_data);
+
+	/* Working copies of register */
+	iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
+	pr_debug("hw_params r: IISMOD: %x\n", iismod);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		iismod &= ~S3C2410_IISMOD_16BIT;
+		dma_data->dma_size = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		iismod |= S3C2410_IISMOD_16BIT;
+		dma_data->dma_size = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
+	pr_debug("hw_params w: IISMOD: %x\n", iismod);
+	return 0;
+}
+
+static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			       struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+
+	pr_debug("Entered %s\n", __func__);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (!s3c24xx_snd_is_clkmaster()) {
+			ret = s3c24xx_snd_lrsync();
+			if (ret)
+				goto exit_err;
+		}
+
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			s3c24xx_snd_rxctrl(1);
+		else
+			s3c24xx_snd_txctrl(1);
+
+		s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			s3c24xx_snd_rxctrl(0);
+		else
+			s3c24xx_snd_txctrl(0);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+exit_err:
+	return ret;
+}
+
+/*
+ * Set S3C24xx Clock source
+ */
+static int s3c24xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
+	int clk_id, unsigned int freq, int dir)
+{
+	u32 iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
+
+	pr_debug("Entered %s\n", __func__);
+
+	iismod &= ~S3C2440_IISMOD_MPLL;
+
+	switch (clk_id) {
+	case S3C24XX_CLKSRC_PCLK:
+		break;
+	case S3C24XX_CLKSRC_MPLL:
+		iismod |= S3C2440_IISMOD_MPLL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
+	return 0;
+}
+
+/*
+ * Set S3C24xx Clock dividers
+ */
+static int s3c24xx_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
+	int div_id, int div)
+{
+	u32 reg;
+
+	pr_debug("Entered %s\n", __func__);
+
+	switch (div_id) {
+	case S3C24XX_DIV_BCLK:
+		reg = readl(s3c24xx_i2s.regs + S3C2410_IISMOD) & ~S3C2410_IISMOD_FS_MASK;
+		writel(reg | div, s3c24xx_i2s.regs + S3C2410_IISMOD);
+		break;
+	case S3C24XX_DIV_MCLK:
+		reg = readl(s3c24xx_i2s.regs + S3C2410_IISMOD) & ~(S3C2410_IISMOD_384FS);
+		writel(reg | div, s3c24xx_i2s.regs + S3C2410_IISMOD);
+		break;
+	case S3C24XX_DIV_PRESCALER:
+		writel(div, s3c24xx_i2s.regs + S3C2410_IISPSR);
+		reg = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
+		writel(reg | S3C2410_IISCON_PSCEN, s3c24xx_i2s.regs + S3C2410_IISCON);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * To avoid duplicating clock code, allow machine driver to
+ * get the clockrate from here.
+ */
+u32 s3c24xx_i2s_get_clockrate(void)
+{
+	return clk_get_rate(s3c24xx_i2s.iis_clk);
+}
+EXPORT_SYMBOL_GPL(s3c24xx_i2s_get_clockrate);
+
+static int s3c24xx_i2s_probe(struct platform_device *pdev,
+			     struct snd_soc_dai *dai)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	s3c24xx_i2s.regs = ioremap(S3C2410_PA_IIS, 0x100);
+	if (s3c24xx_i2s.regs == NULL)
+		return -ENXIO;
+
+	s3c24xx_i2s.iis_clk = clk_get(&pdev->dev, "iis");
+	if (s3c24xx_i2s.iis_clk == NULL) {
+		pr_err("failed to get iis_clock\n");
+		iounmap(s3c24xx_i2s.regs);
+		return -ENODEV;
+	}
+	clk_enable(s3c24xx_i2s.iis_clk);
+
+	/* Configure the I2S pins in correct mode */
+	s3c2410_gpio_cfgpin(S3C2410_GPE0, S3C2410_GPE0_I2SLRCK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE1, S3C2410_GPE1_I2SSCLK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE2, S3C2410_GPE2_CDCLK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE3, S3C2410_GPE3_I2SSDI);
+	s3c2410_gpio_cfgpin(S3C2410_GPE4, S3C2410_GPE4_I2SSDO);
+
+	writel(S3C2410_IISCON_IISEN, s3c24xx_i2s.regs + S3C2410_IISCON);
+
+	s3c24xx_snd_txctrl(0);
+	s3c24xx_snd_rxctrl(0);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int s3c24xx_i2s_suspend(struct snd_soc_dai *cpu_dai)
+{
+	pr_debug("Entered %s\n", __func__);
+
+	s3c24xx_i2s.iiscon = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
+	s3c24xx_i2s.iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
+	s3c24xx_i2s.iisfcon = readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
+	s3c24xx_i2s.iispsr = readl(s3c24xx_i2s.regs + S3C2410_IISPSR);
+
+	clk_disable(s3c24xx_i2s.iis_clk);
+
+	return 0;
+}
+
+static int s3c24xx_i2s_resume(struct snd_soc_dai *cpu_dai)
+{
+	pr_debug("Entered %s\n", __func__);
+	clk_enable(s3c24xx_i2s.iis_clk);
+
+	writel(s3c24xx_i2s.iiscon, s3c24xx_i2s.regs + S3C2410_IISCON);
+	writel(s3c24xx_i2s.iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
+	writel(s3c24xx_i2s.iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
+	writel(s3c24xx_i2s.iispsr, s3c24xx_i2s.regs + S3C2410_IISPSR);
+
+	return 0;
+}
+#else
+#define s3c24xx_i2s_suspend NULL
+#define s3c24xx_i2s_resume NULL
+#endif
+
+
+#define S3C24XX_I2S_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+static struct snd_soc_dai_ops s3c24xx_i2s_dai_ops = {
+	.trigger	= s3c24xx_i2s_trigger,
+	.hw_params	= s3c24xx_i2s_hw_params,
+	.set_fmt	= s3c24xx_i2s_set_fmt,
+	.set_clkdiv	= s3c24xx_i2s_set_clkdiv,
+	.set_sysclk	= s3c24xx_i2s_set_sysclk,
+};
+
+struct snd_soc_dai s3c24xx_i2s_dai = {
+	.name = "s3c24xx-i2s",
+	.id = 0,
+	.probe = s3c24xx_i2s_probe,
+	.suspend = s3c24xx_i2s_suspend,
+	.resume = s3c24xx_i2s_resume,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = S3C24XX_I2S_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = S3C24XX_I2S_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE,},
+	.ops = &s3c24xx_i2s_dai_ops,
+};
+EXPORT_SYMBOL_GPL(s3c24xx_i2s_dai);
+
+static int __init s3c24xx_i2s_init(void)
+{
+	return snd_soc_register_dai(&s3c24xx_i2s_dai);
+}
+module_init(s3c24xx_i2s_init);
+
+static void __exit s3c24xx_i2s_exit(void)
+{
+	snd_soc_unregister_dai(&s3c24xx_i2s_dai);
+}
+module_exit(s3c24xx_i2s_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("s3c24xx I2S SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c24xx-i2s.h b/sound/soc/samsung/s3c24xx-i2s.h
new file mode 100644
index 0000000..726d91c
--- /dev/null
+++ b/sound/soc/samsung/s3c24xx-i2s.h
@@ -0,0 +1,37 @@
+/*
+ * s3c24xx-i2s.c  --  ALSA Soc Audio Layer
+ *
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Revision history
+ *    10th Nov 2006   Initial version.
+ */
+
+#ifndef S3C24XXI2S_H_
+#define S3C24XXI2S_H_
+
+/* clock sources */
+#define S3C24XX_CLKSRC_PCLK 0
+#define S3C24XX_CLKSRC_MPLL 1
+
+/* Clock dividers */
+#define S3C24XX_DIV_MCLK	0
+#define S3C24XX_DIV_BCLK	1
+#define S3C24XX_DIV_PRESCALER	2
+
+/* prescaler */
+#define S3C24XX_PRESCALE(a,b) \
+	(((a - 1) << S3C2410_IISPSR_INTSHIFT) | ((b - 1) << S3C2410_IISPSR_EXTSHFIT))
+
+u32 s3c24xx_i2s_get_clockrate(void);
+
+extern struct snd_soc_dai s3c24xx_i2s_dai;
+
+#endif /*S3C24XXI2S_H_*/
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
new file mode 100644
index 0000000..4984754
--- /dev/null
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -0,0 +1,394 @@
+/* sound/soc/s3c24xx/s3c24xx_simtec.c
+ *
+ * Copyright 2009 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <plat/audio-simtec.h>
+
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+#include "s3c24xx_simtec.h"
+
+static struct s3c24xx_audio_simtec_pdata *pdata;
+static struct clk *xtal_clk;
+
+static int spk_gain;
+static int spk_unmute;
+
+/**
+ * speaker_gain_get - read the speaker gain setting.
+ * @kcontrol: The control for the speaker gain.
+ * @ucontrol: The value that needs to be updated.
+ *
+ * Read the value for the AMP gain control.
+ */
+static int speaker_gain_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = spk_gain;
+	return 0;
+}
+
+/**
+ * speaker_gain_set - set the value of the speaker amp gain
+ * @value: The value to write.
+ */
+static void speaker_gain_set(int value)
+{
+	gpio_set_value_cansleep(pdata->amp_gain[0], value & 1);
+	gpio_set_value_cansleep(pdata->amp_gain[1], value >> 1);
+}
+
+/**
+ * speaker_gain_put - set the speaker gain setting.
+ * @kcontrol: The control for the speaker gain.
+ * @ucontrol: The value that needs to be set.
+ *
+ * Set the value of the speaker gain from the specified
+ * @ucontrol setting.
+ *
+ * Note, if the speaker amp is muted, then we do not set a gain value
+ * as at-least one of the ICs that is fitted will try and power up even
+ * if the main control is set to off.
+ */
+static int speaker_gain_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	int value = ucontrol->value.integer.value[0];
+
+	spk_gain = value;
+
+	if (!spk_unmute)
+		speaker_gain_set(value);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new amp_gain_controls[] = {
+	SOC_SINGLE_EXT("Speaker Gain", 0, 0, 3, 0,
+		       speaker_gain_get, speaker_gain_put),
+};
+
+/**
+ * spk_unmute_state - set the unmute state of the speaker
+ * @to: zero to unmute, non-zero to ununmute.
+ */
+static void spk_unmute_state(int to)
+{
+	pr_debug("%s: to=%d\n", __func__, to);
+
+	spk_unmute = to;
+	gpio_set_value(pdata->amp_gpio, to);
+
+	/* if we're umuting, also re-set the gain */
+	if (to && pdata->amp_gain[0] > 0)
+		speaker_gain_set(spk_gain);
+}
+
+/**
+ * speaker_unmute_get - read the speaker unmute setting.
+ * @kcontrol: The control for the speaker gain.
+ * @ucontrol: The value that needs to be updated.
+ *
+ * Read the value for the AMP gain control.
+ */
+static int speaker_unmute_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = spk_unmute;
+	return 0;
+}
+
+/**
+ * speaker_unmute_put - set the speaker unmute setting.
+ * @kcontrol: The control for the speaker gain.
+ * @ucontrol: The value that needs to be set.
+ *
+ * Set the value of the speaker gain from the specified
+ * @ucontrol setting.
+ */
+static int speaker_unmute_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	spk_unmute_state(ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+/* This is added as a manual control as the speaker amps create clicks
+ * when their power state is changed, which are far more noticeable than
+ * anything produced by the CODEC itself.
+ */
+static const struct snd_kcontrol_new amp_unmute_controls[] = {
+	SOC_SINGLE_EXT("Speaker Switch", 0, 0, 1, 0,
+		       speaker_unmute_get, speaker_unmute_put),
+};
+
+void simtec_audio_init(struct snd_soc_codec *codec)
+{
+	if (pdata->amp_gpio > 0) {
+		pr_debug("%s: adding amp routes\n", __func__);
+
+		snd_soc_add_controls(codec, amp_unmute_controls,
+				     ARRAY_SIZE(amp_unmute_controls));
+	}
+
+	if (pdata->amp_gain[0] > 0) {
+		pr_debug("%s: adding amp controls\n", __func__);
+		snd_soc_add_controls(codec, amp_gain_controls,
+				     ARRAY_SIZE(amp_gain_controls));
+	}
+}
+EXPORT_SYMBOL_GPL(simtec_audio_init);
+
+#define CODEC_CLOCK 12000000
+
+/**
+ * simtec_hw_params - update hardware parameters
+ * @substream: The audio substream instance.
+ * @params: The parameters requested.
+ *
+ * Update the codec data routing and configuration  settings
+ * from the supplied data.
+ */
+static int simtec_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* Set the CODEC as the bus clock master, I2S */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret) {
+		pr_err("%s: failed set cpu dai format\n", __func__);
+		return ret;
+	}
+
+	/* Set the CODEC as the bus clock master */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret) {
+		pr_err("%s: failed set codec dai format\n", __func__);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
+				     CODEC_CLOCK, SND_SOC_CLOCK_IN);
+	if (ret) {
+		pr_err( "%s: failed setting codec sysclk\n", __func__);
+		return ret;
+	}
+
+	if (pdata->use_mpllin) {
+		ret = snd_soc_dai_set_sysclk(cpu_dai, S3C24XX_CLKSRC_MPLL,
+					     0, SND_SOC_CLOCK_OUT);
+
+		if (ret) {
+			pr_err("%s: failed to set MPLLin as clksrc\n",
+			       __func__);
+			return ret;
+		}
+	}
+
+	if (pdata->output_cdclk) {
+		int cdclk_scale;
+
+		cdclk_scale = clk_get_rate(xtal_clk) / CODEC_CLOCK;
+		cdclk_scale--;
+
+		ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+					     cdclk_scale);
+	}
+
+	return 0;
+}
+
+static int simtec_call_startup(struct s3c24xx_audio_simtec_pdata *pd)
+{
+	/* call any board supplied startup code, this currently only
+	 * covers the bast/vr1000 which have a CPLD in the way of the
+	 * LRCLK */
+	if (pd->startup)
+		pd->startup();
+
+	return 0;
+}
+
+static struct snd_soc_ops simtec_snd_ops = {
+	.hw_params	= simtec_hw_params,
+};
+
+/**
+ * attach_gpio_amp - get and configure the necessary gpios
+ * @dev: The device we're probing.
+ * @pd: The platform data supplied by the board.
+ *
+ * If there is a GPIO based amplifier attached to the board, claim
+ * the necessary GPIO lines for it, and set default values.
+ */
+static int attach_gpio_amp(struct device *dev,
+			   struct s3c24xx_audio_simtec_pdata *pd)
+{
+	int ret;
+
+	/* attach gpio amp gain (if any) */
+	if (pdata->amp_gain[0] > 0) {
+		ret = gpio_request(pd->amp_gain[0], "gpio-amp-gain0");
+		if (ret) {
+			dev_err(dev, "cannot get amp gpio gain0\n");
+			return ret;
+		}
+
+		ret = gpio_request(pd->amp_gain[1], "gpio-amp-gain1");
+		if (ret) {
+			dev_err(dev, "cannot get amp gpio gain1\n");
+			gpio_free(pdata->amp_gain[0]);
+			return ret;
+		}
+
+		gpio_direction_output(pd->amp_gain[0], 0);
+		gpio_direction_output(pd->amp_gain[1], 0);
+	}
+
+	/* note, currently we assume GPA0 isn't valid amp */
+	if (pdata->amp_gpio > 0) {
+		ret = gpio_request(pd->amp_gpio, "gpio-amp");
+		if (ret) {
+			dev_err(dev, "cannot get amp gpio %d (%d)\n",
+				pd->amp_gpio, ret);
+			goto err_amp;
+		}
+
+		/* set the amp off at startup */
+		spk_unmute_state(0);
+	}
+
+	return 0;
+
+err_amp:
+	if (pd->amp_gain[0] > 0) {
+		gpio_free(pd->amp_gain[0]);
+		gpio_free(pd->amp_gain[1]);
+	}
+
+	return ret;
+}
+
+static void detach_gpio_amp(struct s3c24xx_audio_simtec_pdata *pd)
+{
+	if (pd->amp_gain[0] > 0) {
+		gpio_free(pd->amp_gain[0]);
+		gpio_free(pd->amp_gain[1]);
+	}
+
+	if (pd->amp_gpio > 0)
+		gpio_free(pd->amp_gpio);
+}
+
+#ifdef CONFIG_PM
+int simtec_audio_resume(struct device *dev)
+{
+	simtec_call_startup(pdata);
+	return 0;
+}
+
+const struct dev_pm_ops simtec_audio_pmops = {
+	.resume	= simtec_audio_resume,
+};
+EXPORT_SYMBOL_GPL(simtec_audio_pmops);
+#endif
+
+int __devinit simtec_audio_core_probe(struct platform_device *pdev,
+				      struct snd_soc_device *socdev)
+{
+	struct platform_device *snd_dev;
+	int ret;
+
+	socdev->card->dai_link->ops = &simtec_snd_ops;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data supplied\n");
+		return -EINVAL;
+	}
+
+	simtec_call_startup(pdata);
+
+	xtal_clk = clk_get(&pdev->dev, "xtal");
+	if (IS_ERR(xtal_clk)) {
+		dev_err(&pdev->dev, "could not get clkout0\n");
+		return -EINVAL;
+	}
+
+	dev_info(&pdev->dev, "xtal rate is %ld\n", clk_get_rate(xtal_clk));
+
+	ret = attach_gpio_amp(&pdev->dev, pdata);
+	if (ret)
+		goto err_clk;
+
+	snd_dev = platform_device_alloc("soc-audio", -1);
+	if (!snd_dev) {
+		dev_err(&pdev->dev, "failed to alloc soc-audio devicec\n");
+		ret = -ENOMEM;
+		goto err_gpio;
+	}
+
+	platform_set_drvdata(snd_dev, socdev);
+	socdev->dev = &snd_dev->dev;
+
+	ret = platform_device_add(snd_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add soc-audio dev\n");
+		goto err_pdev;
+	}
+
+	platform_set_drvdata(pdev, snd_dev);
+	return 0;
+
+err_pdev:
+	platform_device_put(snd_dev);
+
+err_gpio:
+	detach_gpio_amp(pdata);
+
+err_clk:
+	clk_put(xtal_clk);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(simtec_audio_core_probe);
+
+int __devexit simtec_audio_remove(struct platform_device *pdev)
+{
+	struct platform_device *snd_dev = platform_get_drvdata(pdev);
+
+	platform_device_unregister(snd_dev);
+
+	detach_gpio_amp(pdata);
+	clk_put(xtal_clk);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(simtec_audio_remove);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("ALSA SoC Simtec Audio common support");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c24xx_simtec.h b/sound/soc/samsung/s3c24xx_simtec.h
new file mode 100644
index 0000000..e18faee
--- /dev/null
+++ b/sound/soc/samsung/s3c24xx_simtec.h
@@ -0,0 +1,22 @@
+/* sound/soc/s3c24xx/s3c24xx_simtec.h
+ *
+ * Copyright 2009 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+extern void simtec_audio_init(struct snd_soc_codec *codec);
+
+extern int simtec_audio_core_probe(struct platform_device *pdev,
+				   struct snd_soc_device *socdev);
+
+extern int simtec_audio_remove(struct platform_device *pdev);
+
+#ifdef CONFIG_PM
+extern const struct dev_pm_ops simtec_audio_pmops;
+#define simtec_audio_pm &simtec_audio_pmops
+#else
+#define simtec_audio_pm NULL
+#endif
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
new file mode 100644
index 0000000..bdf8951
--- /dev/null
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -0,0 +1,153 @@
+/* sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+ *
+ * Copyright 2009 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <plat/audio-simtec.h>
+
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+#include "s3c24xx_simtec.h"
+
+#include "../codecs/tlv320aic3x.h"
+
+static const struct snd_soc_dapm_widget dapm_widgets[] = {
+	SND_SOC_DAPM_LINE("GSM Out", NULL),
+	SND_SOC_DAPM_LINE("GSM In", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_LINE("ZV", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route base_map[] = {
+	/* Headphone connected to HP{L,R}OUT and HP{L,R}COM */
+
+	{ "Headphone Jack", NULL, "HPLOUT" },
+	{ "Headphone Jack", NULL, "HPLCOM" },
+	{ "Headphone Jack", NULL, "HPROUT" },
+	{ "Headphone Jack", NULL, "HPRCOM" },
+
+	/* ZV connected to Line1 */
+
+	{ "LINE1L", NULL, "ZV" },
+	{ "LINE1R", NULL, "ZV" },
+
+	/* Line In connected to Line2 */
+
+	{ "LINE2L", NULL, "Line In" },
+	{ "LINE2R", NULL, "Line In" },
+
+	/* Microphone connected to MIC3R and MIC_BIAS */
+
+	{ "MIC3L", NULL, "Mic Jack" },
+
+	/* GSM connected to MONO_LOUT and MIC3L (in) */
+
+	{ "GSM Out", NULL, "MONO_LOUT" },
+	{ "MIC3L", NULL, "GSM In" },
+
+	/* Speaker is connected to LINEOUT{LN,LP,RN,RP}, however we are
+	 * not using the DAPM to power it up and down as there it makes
+	 * a click when powering up. */
+};
+
+/**
+ * simtec_hermes_init - initialise and add controls
+ * @codec; The codec instance to attach to.
+ *
+ * Attach our controls and configure the necessary codec
+ * mappings for our sound card instance.
+*/
+static int simtec_hermes_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, dapm_widgets,
+				  ARRAY_SIZE(dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, base_map, ARRAY_SIZE(base_map));
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Line Out");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	simtec_audio_init(codec);
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct aic3x_setup_data codec_setup = {
+};
+
+static struct snd_soc_dai_link simtec_dai_aic33 = {
+	.name		= "tlv320aic33",
+	.stream_name	= "TLV320AIC33",
+	.cpu_dai	= &s3c24xx_i2s_dai,
+	.codec_dai	= &aic3x_dai,
+	.init		= simtec_hermes_init,
+};
+
+/* simtec audio machine driver */
+static struct snd_soc_card snd_soc_machine_simtec_aic33 = {
+	.name		= "Simtec-Hermes",
+	.platform	= &s3c24xx_soc_platform,
+	.dai_link	= &simtec_dai_aic33,
+	.num_links	= 1,
+};
+
+/* simtec audio subsystem */
+static struct snd_soc_device simtec_snd_devdata_aic33 = {
+	.card		= &snd_soc_machine_simtec_aic33,
+	.codec_dev	= &soc_codec_dev_aic3x,
+	.codec_data	= &codec_setup,
+};
+
+static int __devinit simtec_audio_hermes_probe(struct platform_device *pd)
+{
+	dev_info(&pd->dev, "probing....\n");
+	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic33);
+}
+
+static struct platform_driver simtec_audio_hermes_platdrv = {
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c24xx-simtec-hermes-snd",
+		.pm	= simtec_audio_pm,
+	},
+	.probe	= simtec_audio_hermes_probe,
+	.remove	= __devexit_p(simtec_audio_remove),
+};
+
+MODULE_ALIAS("platform:s3c24xx-simtec-hermes-snd");
+
+static int __init simtec_hermes_modinit(void)
+{
+	return platform_driver_register(&simtec_audio_hermes_platdrv);
+}
+
+static void __exit simtec_hermes_modexit(void)
+{
+	platform_driver_unregister(&simtec_audio_hermes_platdrv);
+}
+
+module_init(simtec_hermes_modinit);
+module_exit(simtec_hermes_modexit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
new file mode 100644
index 0000000..185c0ac
--- /dev/null
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -0,0 +1,137 @@
+/* sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+ *
+ * Copyright 2009 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <plat/audio-simtec.h>
+
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+#include "s3c24xx_simtec.h"
+
+#include "../codecs/tlv320aic23.h"
+
+/* supported machines:
+ *
+ * Machine	Connections		AMP
+ * -------	-----------		---
+ * BAST		MIC, HPOUT, LOUT, LIN	TPA2001D1 (HPOUTL,R) (gain hardwired)
+ * VR1000	HPOUT, LIN		None
+ * VR2000	LIN, LOUT, MIC, HP	LM4871 (HPOUTL,R)
+ * DePicture	LIN, LOUT, MIC, HP	LM4871 (HPOUTL,R)
+ * Anubis	LIN, LOUT, MIC, HP	TPA2001D1 (HPOUTL,R)
+ */
+
+static const struct snd_soc_dapm_widget dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route base_map[] = {
+	{ "Headphone Jack", NULL, "LHPOUT"},
+	{ "Headphone Jack", NULL, "RHPOUT"},
+
+	{ "Line Out", NULL, "LOUT" },
+	{ "Line Out", NULL, "ROUT" },
+
+	{ "LLINEIN", NULL, "Line In"},
+	{ "RLINEIN", NULL, "Line In"},
+
+	{ "MICIN", NULL, "Mic Jack"},
+};
+
+/**
+ * simtec_tlv320aic23_init - initialise and add controls
+ * @codec; The codec instance to attach to.
+ *
+ * Attach our controls and configure the necessary codec
+ * mappings for our sound card instance.
+*/
+static int simtec_tlv320aic23_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, dapm_widgets,
+				  ARRAY_SIZE(dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, base_map, ARRAY_SIZE(base_map));
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Line Out");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	simtec_audio_init(codec);
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link simtec_dai_aic23 = {
+	.name		= "tlv320aic23",
+	.stream_name	= "TLV320AIC23",
+	.cpu_dai	= &s3c24xx_i2s_dai,
+	.codec_dai	= &tlv320aic23_dai,
+	.init		= simtec_tlv320aic23_init,
+};
+
+/* simtec audio machine driver */
+static struct snd_soc_card snd_soc_machine_simtec_aic23 = {
+	.name		= "Simtec",
+	.platform	= &s3c24xx_soc_platform,
+	.dai_link	= &simtec_dai_aic23,
+	.num_links	= 1,
+};
+
+/* simtec audio subsystem */
+static struct snd_soc_device simtec_snd_devdata_aic23 = {
+	.card		= &snd_soc_machine_simtec_aic23,
+	.codec_dev	= &soc_codec_dev_tlv320aic23,
+};
+
+static int __devinit simtec_audio_tlv320aic23_probe(struct platform_device *pd)
+{
+	return simtec_audio_core_probe(pd, &simtec_snd_devdata_aic23);
+}
+
+static struct platform_driver simtec_audio_tlv320aic23_platdrv = {
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c24xx-simtec-tlv320aic23",
+		.pm	= simtec_audio_pm,
+	},
+	.probe	= simtec_audio_tlv320aic23_probe,
+	.remove	= __devexit_p(simtec_audio_remove),
+};
+
+MODULE_ALIAS("platform:s3c24xx-simtec-tlv320aic23");
+
+static int __init simtec_tlv320aic23_modinit(void)
+{
+	return platform_driver_register(&simtec_audio_tlv320aic23_platdrv);
+}
+
+static void __exit simtec_tlv320aic23_modexit(void)
+{
+	platform_driver_unregister(&simtec_audio_tlv320aic23_platdrv);
+}
+
+module_init(simtec_tlv320aic23_modinit);
+module_exit(simtec_tlv320aic23_modexit);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
new file mode 100644
index 0000000..052d596
--- /dev/null
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -0,0 +1,373 @@
+/*
+ * Modifications by Christian Pellegrin <chripell@evolware.org>
+ *
+ * s3c24xx_uda134x.c  --  S3C24XX_UDA134X ALSA SoC Audio board driver
+ *
+ * Copyright 2007 Dension Audio Systems Ltd.
+ * Author: Zoltan Devai
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <linux/gpio.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/s3c24xx_uda134x.h>
+#include <sound/uda134x.h>
+
+#include <plat/regs-iis.h>
+
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+#include "../codecs/uda134x.h"
+
+
+/* #define ENFORCE_RATES 1 */
+/*
+  Unfortunately the S3C24XX in master mode has a limited capacity of
+  generating the clock for the codec. If you define this only rates
+  that are really available will be enforced. But be careful, most
+  user level application just want the usual sampling frequencies (8,
+  11.025, 22.050, 44.1 kHz) and anyway resampling is a costly
+  operation for embedded systems. So if you aren't very lucky or your
+  hardware engineer wasn't very forward-looking it's better to leave
+  this undefined. If you do so an approximate value for the requested
+  sampling rate in the range -/+ 5% will be chosen. If this in not
+  possible an error will be returned.
+*/
+
+static struct clk *xtal;
+static struct clk *pclk;
+/* this is need because we don't have a place where to keep the
+ * pointers to the clocks in each substream. We get the clocks only
+ * when we are actually using them so we don't block stuff like
+ * frequency change or oscillator power-off */
+static int clk_users;
+static DEFINE_MUTEX(clk_lock);
+
+static unsigned int rates[33 * 2];
+#ifdef ENFORCE_RATES
+static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+	.count	= ARRAY_SIZE(rates),
+	.list	= rates,
+	.mask	= 0,
+};
+#endif
+
+static struct platform_device *s3c24xx_uda134x_snd_device;
+
+static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
+{
+	int ret = 0;
+#ifdef ENFORCE_RATES
+	struct snd_pcm_runtime *runtime = substream->runtime;
+#endif
+
+	mutex_lock(&clk_lock);
+	pr_debug("%s %d\n", __func__, clk_users);
+	if (clk_users == 0) {
+		xtal = clk_get(&s3c24xx_uda134x_snd_device->dev, "xtal");
+		if (!xtal) {
+			printk(KERN_ERR "%s cannot get xtal\n", __func__);
+			ret = -EBUSY;
+		} else {
+			pclk = clk_get(&s3c24xx_uda134x_snd_device->dev,
+				       "pclk");
+			if (!pclk) {
+				printk(KERN_ERR "%s cannot get pclk\n",
+				       __func__);
+				clk_put(xtal);
+				ret = -EBUSY;
+			}
+		}
+		if (!ret) {
+			int i, j;
+
+			for (i = 0; i < 2; i++) {
+				int fs = i ? 256 : 384;
+
+				rates[i*33] = clk_get_rate(xtal) / fs;
+				for (j = 1; j < 33; j++)
+					rates[i*33 + j] = clk_get_rate(pclk) /
+						(j * fs);
+			}
+		}
+	}
+	clk_users += 1;
+	mutex_unlock(&clk_lock);
+	if (!ret) {
+#ifdef ENFORCE_RATES
+		ret = snd_pcm_hw_constraint_list(runtime, 0,
+						 SNDRV_PCM_HW_PARAM_RATE,
+						 &hw_constraints_rates);
+		if (ret < 0)
+			printk(KERN_ERR "%s cannot set constraints\n",
+			       __func__);
+#endif
+	}
+	return ret;
+}
+
+static void s3c24xx_uda134x_shutdown(struct snd_pcm_substream *substream)
+{
+	mutex_lock(&clk_lock);
+	pr_debug("%s %d\n", __func__, clk_users);
+	clk_users -= 1;
+	if (clk_users == 0) {
+		clk_put(xtal);
+		xtal = NULL;
+		clk_put(pclk);
+		pclk = NULL;
+	}
+	mutex_unlock(&clk_lock);
+}
+
+static int s3c24xx_uda134x_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int clk = 0;
+	int ret = 0;
+	int clk_source, fs_mode;
+	unsigned long rate = params_rate(params);
+	long err, cerr;
+	unsigned int div;
+	int i, bi;
+
+	err = 999999;
+	bi = 0;
+	for (i = 0; i < 2*33; i++) {
+		cerr = rates[i] - rate;
+		if (cerr < 0)
+			cerr = -cerr;
+		if (cerr < err) {
+			err = cerr;
+			bi = i;
+		}
+	}
+	if (bi / 33 == 1)
+		fs_mode = S3C2410_IISMOD_256FS;
+	else
+		fs_mode = S3C2410_IISMOD_384FS;
+	if (bi % 33 == 0) {
+		clk_source = S3C24XX_CLKSRC_MPLL;
+		div = 1;
+	} else {
+		clk_source = S3C24XX_CLKSRC_PCLK;
+		div = bi % 33;
+	}
+	pr_debug("%s desired rate %lu, %d\n", __func__, rate, bi);
+
+	clk = (fs_mode == S3C2410_IISMOD_384FS ? 384 : 256) * rate;
+	pr_debug("%s will use: %s %s %d sysclk %d err %ld\n", __func__,
+		 fs_mode == S3C2410_IISMOD_384FS ? "384FS" : "256FS",
+		 clk_source == S3C24XX_CLKSRC_MPLL ? "MPLLin" : "PCLK",
+		 div, clk, err);
+
+	if ((err * 100 / rate) > 5) {
+		printk(KERN_ERR "S3C24XX_UDA134X: effective frequency "
+		       "too different from desired (%ld%%)\n",
+		       err * 100 / rate);
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, clk_source , clk,
+			SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK, fs_mode);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_BCLK,
+			S3C2410_IISMOD_32FS);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+			S3C24XX_PRESCALE(div, div));
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk,
+			SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops s3c24xx_uda134x_ops = {
+	.startup = s3c24xx_uda134x_startup,
+	.shutdown = s3c24xx_uda134x_shutdown,
+	.hw_params = s3c24xx_uda134x_hw_params,
+};
+
+static struct snd_soc_dai_link s3c24xx_uda134x_dai_link = {
+	.name = "UDA134X",
+	.stream_name = "UDA134X",
+	.codec_dai = &uda134x_dai,
+	.cpu_dai = &s3c24xx_i2s_dai,
+	.ops = &s3c24xx_uda134x_ops,
+};
+
+static struct snd_soc_card snd_soc_s3c24xx_uda134x = {
+	.name = "S3C24XX_UDA134X",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = &s3c24xx_uda134x_dai_link,
+	.num_links = 1,
+};
+
+static struct s3c24xx_uda134x_platform_data *s3c24xx_uda134x_l3_pins;
+
+static void setdat(int v)
+{
+	gpio_set_value(s3c24xx_uda134x_l3_pins->l3_data, v > 0);
+}
+
+static void setclk(int v)
+{
+	gpio_set_value(s3c24xx_uda134x_l3_pins->l3_clk, v > 0);
+}
+
+static void setmode(int v)
+{
+	gpio_set_value(s3c24xx_uda134x_l3_pins->l3_mode, v > 0);
+}
+
+static struct uda134x_platform_data s3c24xx_uda134x = {
+	.l3 = {
+		.setdat = setdat,
+		.setclk = setclk,
+		.setmode = setmode,
+		.data_hold = 1,
+		.data_setup = 1,
+		.clock_high = 1,
+		.mode_hold = 1,
+		.mode = 1,
+		.mode_setup = 1,
+	},
+};
+
+static struct snd_soc_device s3c24xx_uda134x_snd_devdata = {
+	.card = &snd_soc_s3c24xx_uda134x,
+	.codec_dev = &soc_codec_dev_uda134x,
+	.codec_data = &s3c24xx_uda134x,
+};
+
+static int s3c24xx_uda134x_setup_pin(int pin, char *fun)
+{
+	if (gpio_request(pin, "s3c24xx_uda134x") < 0) {
+		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: "
+		       "l3 %s pin already in use", fun);
+		return -EBUSY;
+	}
+	gpio_direction_output(pin, 0);
+	return 0;
+}
+
+static int s3c24xx_uda134x_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	printk(KERN_INFO "S3C24XX_UDA134X SoC Audio driver\n");
+
+	s3c24xx_uda134x_l3_pins = pdev->dev.platform_data;
+	if (s3c24xx_uda134x_l3_pins == NULL) {
+		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: "
+		       "unable to find platform data\n");
+		return -ENODEV;
+	}
+	s3c24xx_uda134x.power = s3c24xx_uda134x_l3_pins->power;
+	s3c24xx_uda134x.model = s3c24xx_uda134x_l3_pins->model;
+
+	if (s3c24xx_uda134x_setup_pin(s3c24xx_uda134x_l3_pins->l3_data,
+				      "data") < 0)
+		return -EBUSY;
+	if (s3c24xx_uda134x_setup_pin(s3c24xx_uda134x_l3_pins->l3_clk,
+				      "clk") < 0) {
+		gpio_free(s3c24xx_uda134x_l3_pins->l3_data);
+		return -EBUSY;
+	}
+	if (s3c24xx_uda134x_setup_pin(s3c24xx_uda134x_l3_pins->l3_mode,
+				      "mode") < 0) {
+		gpio_free(s3c24xx_uda134x_l3_pins->l3_data);
+		gpio_free(s3c24xx_uda134x_l3_pins->l3_clk);
+		return -EBUSY;
+	}
+
+	s3c24xx_uda134x_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!s3c24xx_uda134x_snd_device) {
+		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: "
+		       "Unable to register\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(s3c24xx_uda134x_snd_device,
+			     &s3c24xx_uda134x_snd_devdata);
+	s3c24xx_uda134x_snd_devdata.dev = &s3c24xx_uda134x_snd_device->dev;
+	ret = platform_device_add(s3c24xx_uda134x_snd_device);
+	if (ret) {
+		printk(KERN_ERR "S3C24XX_UDA134X SoC Audio: Unable to add\n");
+		platform_device_put(s3c24xx_uda134x_snd_device);
+	}
+
+	return ret;
+}
+
+static int s3c24xx_uda134x_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(s3c24xx_uda134x_snd_device);
+	gpio_free(s3c24xx_uda134x_l3_pins->l3_data);
+	gpio_free(s3c24xx_uda134x_l3_pins->l3_clk);
+	gpio_free(s3c24xx_uda134x_l3_pins->l3_mode);
+	return 0;
+}
+
+static struct platform_driver s3c24xx_uda134x_driver = {
+	.probe  = s3c24xx_uda134x_probe,
+	.remove = s3c24xx_uda134x_remove,
+	.driver = {
+		.name = "s3c24xx_uda134x",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init s3c24xx_uda134x_init(void)
+{
+	return platform_driver_register(&s3c24xx_uda134x_driver);
+}
+
+static void __exit s3c24xx_uda134x_exit(void)
+{
+	platform_driver_unregister(&s3c24xx_uda134x_driver);
+}
+
+
+module_init(s3c24xx_uda134x_init);
+module_exit(s3c24xx_uda134x_exit);
+
+MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
+MODULE_DESCRIPTION("S3C24XX_UDA134X ALSA SoC audio driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c64xx-i2s-v4.c b/sound/soc/samsung/s3c64xx-i2s-v4.c
new file mode 100644
index 0000000..06db130
--- /dev/null
+++ b/sound/soc/samsung/s3c64xx-i2s-v4.c
@@ -0,0 +1,209 @@
+/* sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+ *
+ * ALSA SoC Audio Layer - S3C64XX I2Sv4 driver
+ * Copyright (c) 2010 Samsung Electronics Co. Ltd
+ * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include <mach/gpio-bank-c.h>
+#include <mach/gpio-bank-h.h>
+#include <plat/gpio-cfg.h>
+
+#include <mach/map.h>
+#include <mach/dma.h>
+
+#include "s3c-dma.h"
+#include "regs-i2s-v2.h"
+#include "s3c64xx-i2s.h"
+
+static struct s3c2410_dma_client s3c64xx_dma_client_out = {
+	.name		= "I2Sv4 PCM Stereo out"
+};
+
+static struct s3c2410_dma_client s3c64xx_dma_client_in = {
+	.name		= "I2Sv4 PCM Stereo in"
+};
+
+static struct s3c_dma_params s3c64xx_i2sv4_pcm_stereo_out;
+static struct s3c_dma_params s3c64xx_i2sv4_pcm_stereo_in;
+static struct s3c_i2sv2_info s3c64xx_i2sv4;
+
+struct snd_soc_dai s3c64xx_i2s_v4_dai;
+EXPORT_SYMBOL_GPL(s3c64xx_i2s_v4_dai);
+
+static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
+{
+	return cpu_dai->private_data;
+}
+
+static int s3c64xx_i2sv4_probe(struct platform_device *pdev,
+			     struct snd_soc_dai *dai)
+{
+	/* configure GPIO for i2s port */
+	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
+	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
+	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
+	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
+	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
+	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
+	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
+
+	return 0;
+}
+
+static int s3c_i2sv4_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *cpu_dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	struct s3c_dma_params *dma_data;
+	u32 iismod;
+
+	dev_dbg(cpu_dai->dev, "Entered %s\n", __func__);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data = i2s->dma_playback;
+	else
+		dma_data = i2s->dma_capture;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
+
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	dev_dbg(cpu_dai->dev, "%s: r: IISMOD: %x\n", __func__, iismod);
+
+	iismod &= ~S3C64XX_IISMOD_BLC_MASK;
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		iismod |= S3C64XX_IISMOD_BLC_8BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iismod |= S3C64XX_IISMOD_BLC_24BIT;
+		break;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	dev_dbg(cpu_dai->dev, "%s: w: IISMOD: %x\n", __func__, iismod);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops s3c64xx_i2sv4_dai_ops = {
+	.hw_params	= s3c_i2sv4_hw_params,
+};
+
+static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
+{
+	struct s3c_i2sv2_info *i2s;
+	struct snd_soc_dai *dai;
+	int ret;
+
+	i2s = &s3c64xx_i2sv4;
+	dai = &s3c64xx_i2s_v4_dai;
+
+	if (dai->dev) {
+		dev_dbg(dai->dev, "%s: \
+			I2Sv4 instance already registered!\n", __func__);
+		return -EBUSY;
+	}
+
+	dai->dev = &pdev->dev;
+	dai->name = "s3c64xx-i2s-v4";
+	dai->id = 0;
+	dai->symmetric_rates = 1;
+	dai->playback.channels_min = 2;
+	dai->playback.channels_max = 2;
+	dai->playback.rates = S3C64XX_I2S_RATES;
+	dai->playback.formats = S3C64XX_I2S_FMTS;
+	dai->capture.channels_min = 2;
+	dai->capture.channels_max = 2;
+	dai->capture.rates = S3C64XX_I2S_RATES;
+	dai->capture.formats = S3C64XX_I2S_FMTS;
+	dai->probe = s3c64xx_i2sv4_probe;
+	dai->ops = &s3c64xx_i2sv4_dai_ops;
+
+	i2s->feature |= S3C_FEATURE_CDCLKCON;
+
+	i2s->dma_capture = &s3c64xx_i2sv4_pcm_stereo_in;
+	i2s->dma_playback = &s3c64xx_i2sv4_pcm_stereo_out;
+
+	i2s->dma_capture->channel = DMACH_HSI_I2SV40_RX;
+	i2s->dma_capture->dma_addr = S3C64XX_PA_IISV4 + S3C2412_IISRXD;
+	i2s->dma_playback->channel = DMACH_HSI_I2SV40_TX;
+	i2s->dma_playback->dma_addr = S3C64XX_PA_IISV4 + S3C2412_IISTXD;
+
+	i2s->dma_capture->client = &s3c64xx_dma_client_in;
+	i2s->dma_capture->dma_size = 4;
+	i2s->dma_playback->client = &s3c64xx_dma_client_out;
+	i2s->dma_playback->dma_size = 4;
+
+	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
+	if (IS_ERR(i2s->iis_cclk)) {
+		dev_err(&pdev->dev, "failed to get audio-bus\n");
+		ret = PTR_ERR(i2s->iis_cclk);
+		goto err;
+	}
+
+	clk_enable(i2s->iis_cclk);
+
+	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
+	if (ret)
+		goto err_clk;
+
+	ret = s3c_i2sv2_register_dai(dai);
+	if (ret != 0)
+		goto err_i2sv2;
+
+	return 0;
+
+err_i2sv2:
+	/* Not implemented for I2Sv2 core yet */
+err_clk:
+	clk_put(i2s->iis_cclk);
+err:
+	return ret;
+}
+
+static __devexit int s3c64xx_i2sv4_dev_remove(struct platform_device *pdev)
+{
+	dev_err(&pdev->dev, "Device removal not yet supported\n");
+	return 0;
+}
+
+static struct platform_driver s3c64xx_i2sv4_driver = {
+	.probe  = s3c64xx_i2sv4_dev_probe,
+	.remove = s3c64xx_i2sv4_dev_remove,
+	.driver = {
+		.name = "s3c64xx-iis-v4",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init s3c64xx_i2sv4_init(void)
+{
+	return platform_driver_register(&s3c64xx_i2sv4_driver);
+}
+module_init(s3c64xx_i2sv4_init);
+
+static void __exit s3c64xx_i2sv4_exit(void)
+{
+	platform_driver_unregister(&s3c64xx_i2sv4_driver);
+}
+module_exit(s3c64xx_i2sv4_exit);
+
+/* Module information */
+MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
+MODULE_DESCRIPTION("S3C64XX I2Sv4 SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c64xx-i2s.c b/sound/soc/samsung/s3c64xx-i2s.c
new file mode 100644
index 0000000..1d85cb8
--- /dev/null
+++ b/sound/soc/samsung/s3c64xx-i2s.c
@@ -0,0 +1,190 @@
+/* sound/soc/s3c24xx/s3c64xx-i2s.c
+ *
+ * ALSA SoC Audio Layer - S3C64XX I2S driver
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *      Ben Dooks <ben@simtec.co.uk>
+ *      http://armlinux.simtec.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <sound/soc.h>
+
+#include <mach/gpio-bank-d.h>
+#include <mach/gpio-bank-e.h>
+#include <plat/gpio-cfg.h>
+
+#include <mach/map.h>
+#include <mach/dma.h>
+
+#include "s3c-dma.h"
+#include "regs-i2s-v2.h"
+#include "s3c64xx-i2s.h"
+
+/* The value should be set to maximum of the total number
+ * of I2Sv3 controllers that any supported SoC has.
+ */
+#define MAX_I2SV3	2
+
+static struct s3c2410_dma_client s3c64xx_dma_client_out = {
+	.name		= "I2S PCM Stereo out"
+};
+
+static struct s3c2410_dma_client s3c64xx_dma_client_in = {
+	.name		= "I2S PCM Stereo in"
+};
+
+static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[MAX_I2SV3];
+static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[MAX_I2SV3];
+static struct s3c_i2sv2_info s3c64xx_i2s[MAX_I2SV3];
+
+struct snd_soc_dai s3c64xx_i2s_dai[MAX_I2SV3];
+EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
+
+static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
+{
+	return cpu_dai->private_data;
+}
+
+static int s3c64xx_i2s_probe(struct platform_device *pdev,
+			     struct snd_soc_dai *dai)
+{
+	/* configure GPIO for i2s port */
+	switch (dai->id) {
+	case 0:
+		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
+		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
+		break;
+	case 1:
+		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
+		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
+	}
+
+	return 0;
+}
+
+
+static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops;
+
+static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
+{
+	struct s3c_i2sv2_info *i2s;
+	struct snd_soc_dai *dai;
+	int ret;
+
+	if (pdev->id >= MAX_I2SV3) {
+		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
+		return -EINVAL;
+	}
+
+	i2s = &s3c64xx_i2s[pdev->id];
+	dai = &s3c64xx_i2s_dai[pdev->id];
+	dai->dev = &pdev->dev;
+	dai->name = "s3c64xx-i2s";
+	dai->id = pdev->id;
+	dai->symmetric_rates = 1;
+	dai->playback.channels_min = 2;
+	dai->playback.channels_max = 2;
+	dai->playback.rates = S3C64XX_I2S_RATES;
+	dai->playback.formats = S3C64XX_I2S_FMTS;
+	dai->capture.channels_min = 2;
+	dai->capture.channels_max = 2;
+	dai->capture.rates = S3C64XX_I2S_RATES;
+	dai->capture.formats = S3C64XX_I2S_FMTS;
+	dai->probe = s3c64xx_i2s_probe;
+	dai->ops = &s3c64xx_i2s_dai_ops;
+
+	i2s->feature |= S3C_FEATURE_CDCLKCON;
+
+	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
+	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
+
+	if (pdev->id == 0) {
+		i2s->dma_capture->channel = DMACH_I2S0_IN;
+		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISRXD;
+		i2s->dma_playback->channel = DMACH_I2S0_OUT;
+		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISTXD;
+	} else {
+		i2s->dma_capture->channel = DMACH_I2S1_IN;
+		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISRXD;
+		i2s->dma_playback->channel = DMACH_I2S1_OUT;
+		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISTXD;
+	}
+
+	i2s->dma_capture->client = &s3c64xx_dma_client_in;
+	i2s->dma_capture->dma_size = 4;
+	i2s->dma_playback->client = &s3c64xx_dma_client_out;
+	i2s->dma_playback->dma_size = 4;
+
+	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
+	if (IS_ERR(i2s->iis_cclk)) {
+		dev_err(&pdev->dev, "failed to get audio-bus\n");
+		ret = PTR_ERR(i2s->iis_cclk);
+		goto err;
+	}
+
+	clk_enable(i2s->iis_cclk);
+
+	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
+	if (ret)
+		goto err_clk;
+
+	ret = s3c_i2sv2_register_dai(dai);
+	if (ret != 0)
+		goto err_i2sv2;
+
+	return 0;
+
+err_i2sv2:
+	/* Not implemented for I2Sv2 core yet */
+err_clk:
+	clk_put(i2s->iis_cclk);
+err:
+	return ret;
+}
+
+static __devexit int s3c64xx_iis_dev_remove(struct platform_device *pdev)
+{
+	dev_err(&pdev->dev, "Device removal not yet supported\n");
+	return 0;
+}
+
+static struct platform_driver s3c64xx_iis_driver = {
+	.probe  = s3c64xx_iis_dev_probe,
+	.remove = s3c64xx_iis_dev_remove,
+	.driver = {
+		.name = "s3c64xx-iis",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init s3c64xx_i2s_init(void)
+{
+	return platform_driver_register(&s3c64xx_iis_driver);
+}
+module_init(s3c64xx_i2s_init);
+
+static void __exit s3c64xx_i2s_exit(void)
+{
+	platform_driver_unregister(&s3c64xx_iis_driver);
+}
+module_exit(s3c64xx_i2s_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("S3C64XX I2S SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c64xx-i2s.h b/sound/soc/samsung/s3c64xx-i2s.h
new file mode 100644
index 0000000..7a40f43
--- /dev/null
+++ b/sound/soc/samsung/s3c64xx-i2s.h
@@ -0,0 +1,42 @@
+/* sound/soc/s3c24xx/s3c64xx-i2s.h
+ *
+ * ALSA SoC Audio Layer - S3C64XX I2S driver
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *      Ben Dooks <ben@simtec.co.uk>
+ *      http://armlinux.simtec.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SND_SOC_S3C24XX_S3C64XX_I2S_H
+#define __SND_SOC_S3C24XX_S3C64XX_I2S_H __FILE__
+
+struct clk;
+
+#include "s3c-i2s-v2.h"
+
+#define S3C64XX_DIV_BCLK	S3C_I2SV2_DIV_BCLK
+#define S3C64XX_DIV_RCLK	S3C_I2SV2_DIV_RCLK
+#define S3C64XX_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
+
+#define S3C64XX_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
+#define S3C64XX_CLKSRC_MUX	S3C_I2SV2_CLKSRC_AUDIOBUS
+#define S3C64XX_CLKSRC_CDCLK    S3C_I2SV2_CLKSRC_CDCLK
+
+#define S3C64XX_I2S_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+#define S3C64XX_I2S_FMTS \
+	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
+	 SNDRV_PCM_FMTBIT_S24_LE)
+
+extern struct snd_soc_dai s3c64xx_i2s_dai[];
+extern struct snd_soc_dai s3c64xx_i2s_v4_dai;
+
+#endif /* __SND_SOC_S3C24XX_S3C64XX_I2S_H */
diff --git a/sound/soc/samsung/smdk2443_wm9710.c b/sound/soc/samsung/smdk2443_wm9710.c
new file mode 100644
index 0000000..3622588
--- /dev/null
+++ b/sound/soc/samsung/smdk2443_wm9710.c
@@ -0,0 +1,81 @@
+/*
+ * smdk2443_wm9710.c  --  SoC audio for smdk2443
+ *
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "../codecs/ac97.h"
+#include "s3c-dma.h"
+#include "s3c-ac97.h"
+
+static struct snd_soc_card smdk2443;
+
+static struct snd_soc_dai_link smdk2443_dai[] = {
+{
+	.name = "AC97",
+	.stream_name = "AC97 HiFi",
+	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
+	.codec_dai = &ac97_dai,
+},
+};
+
+static struct snd_soc_card smdk2443 = {
+	.name = "SMDK2443",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = smdk2443_dai,
+	.num_links = ARRAY_SIZE(smdk2443_dai),
+};
+
+static struct snd_soc_device smdk2443_snd_ac97_devdata = {
+	.card = &smdk2443,
+	.codec_dev = &soc_codec_dev_ac97,
+};
+
+static struct platform_device *smdk2443_snd_ac97_device;
+
+static int __init smdk2443_init(void)
+{
+	int ret;
+
+	smdk2443_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk2443_snd_ac97_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk2443_snd_ac97_device,
+				&smdk2443_snd_ac97_devdata);
+	smdk2443_snd_ac97_devdata.dev = &smdk2443_snd_ac97_device->dev;
+	ret = platform_device_add(smdk2443_snd_ac97_device);
+
+	if (ret)
+		platform_device_put(smdk2443_snd_ac97_device);
+
+	return ret;
+}
+
+static void __exit smdk2443_exit(void)
+{
+	platform_device_unregister(smdk2443_snd_ac97_device);
+}
+
+module_init(smdk2443_init);
+module_exit(smdk2443_exit);
+
+/* Module information */
+MODULE_AUTHOR("Graeme Gregory, graeme.gregory@wolfsonmicro.com, www.wolfsonmicro.com");
+MODULE_DESCRIPTION("ALSA SoC WM9710 SMDK2443");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/smdk64xx_wm8580.c b/sound/soc/samsung/smdk64xx_wm8580.c
new file mode 100644
index 0000000..07e8e51
--- /dev/null
+++ b/sound/soc/samsung/smdk64xx_wm8580.c
@@ -0,0 +1,266 @@
+/*
+ *  smdk64xx_wm8580.c
+ *
+ *  Copyright (c) 2009 Samsung Electronics Co. Ltd
+ *  Author: Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "../codecs/wm8580.h"
+#include "s3c-dma.h"
+#include "s3c64xx-i2s.h"
+
+/* SMDK64XX has a 12MHZ crystal attached to WM8580 */
+#define SMDK64XX_WM8580_FREQ 12000000
+
+static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	unsigned int pll_out;
+	int bfs, rfs, ret;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_S8:
+		bfs = 16;
+		break;
+	case SNDRV_PCM_FORMAT_U16_LE:
+	case SNDRV_PCM_FORMAT_S16_LE:
+		bfs = 32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* The Fvco for WM8580 PLLs must fall within [90,100]MHz.
+	 * This criterion can't be met if we request PLL output
+	 * as {8000x256, 64000x256, 11025x256}Hz.
+	 * As a wayout, we rather change rfs to a minimum value that
+	 * results in (params_rate(params) * rfs), and itself, acceptable
+	 * to both - the CODEC and the CPU.
+	 */
+	switch (params_rate(params)) {
+	case 16000:
+	case 22050:
+	case 32000:
+	case 44100:
+	case 48000:
+	case 88200:
+	case 96000:
+		rfs = 256;
+		break;
+	case 64000:
+		rfs = 384;
+		break;
+	case 8000:
+	case 11025:
+		rfs = 512;
+		break;
+	default:
+		return -EINVAL;
+	}
+	pll_out = params_rate(params) * rfs;
+
+	/* Set the Codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* Set the AP DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_CDCLK,
+					0, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* We use PCLK for basic ops in SoC-Slave mode */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_PCLK,
+					0, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* Set WM8580 to drive MCLK from its PLLA */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
+					WM8580_CLKSRC_PLLA);
+	if (ret < 0)
+		return ret;
+
+	/* Explicitly set WM8580-DAC to source from MCLK */
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_DAC_CLKSEL,
+					WM8580_CLKSRC_MCLK);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
+					SMDK64XX_WM8580_FREQ, pll_out);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_BCLK, bfs);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_RCLK, rfs);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * SMDK64XX WM8580 DAI operations.
+ */
+static struct snd_soc_ops smdk64xx_ops = {
+	.hw_params = smdk64xx_hw_params,
+};
+
+/* SMDK64xx Playback widgets */
+static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
+	SND_SOC_DAPM_HP("Front-L/R", NULL),
+	SND_SOC_DAPM_HP("Center/Sub", NULL),
+	SND_SOC_DAPM_HP("Rear-L/R", NULL),
+};
+
+/* SMDK64xx Capture widgets */
+static const struct snd_soc_dapm_widget wm8580_dapm_widgets_cpt[] = {
+	SND_SOC_DAPM_MIC("MicIn", NULL),
+	SND_SOC_DAPM_LINE("LineIn", NULL),
+};
+
+/* SMDK-PAIFTX connections */
+static const struct snd_soc_dapm_route audio_map_tx[] = {
+	/* MicIn feeds AINL */
+	{"AINL", NULL, "MicIn"},
+
+	/* LineIn feeds AINL/R */
+	{"AINL", NULL, "LineIn"},
+	{"AINR", NULL, "LineIn"},
+};
+
+/* SMDK-PAIFRX connections */
+static const struct snd_soc_dapm_route audio_map_rx[] = {
+	/* Front Left/Right are fed VOUT1L/R */
+	{"Front-L/R", NULL, "VOUT1L"},
+	{"Front-L/R", NULL, "VOUT1R"},
+
+	/* Center/Sub are fed VOUT2L/R */
+	{"Center/Sub", NULL, "VOUT2L"},
+	{"Center/Sub", NULL, "VOUT2R"},
+
+	/* Rear Left/Right are fed VOUT3L/R */
+	{"Rear-L/R", NULL, "VOUT3L"},
+	{"Rear-L/R", NULL, "VOUT3R"},
+};
+
+static int smdk64xx_wm8580_init_paiftx(struct snd_soc_codec *codec)
+{
+	/* Add smdk64xx specific Capture widgets */
+	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_cpt,
+				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
+
+	/* Set up PAIFTX audio path */
+	snd_soc_dapm_add_routes(codec, audio_map_tx, ARRAY_SIZE(audio_map_tx));
+
+	/* Enabling the microphone requires the fitting of a 0R
+	 * resistor to connect the line from the microphone jack.
+	 */
+	snd_soc_dapm_disable_pin(codec, "MicIn");
+
+	/* signal a DAPM event */
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static int smdk64xx_wm8580_init_paifrx(struct snd_soc_codec *codec)
+{
+	/* Add smdk64xx specific Playback widgets */
+	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_pbk,
+				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
+
+	/* Set up PAIFRX audio path */
+	snd_soc_dapm_add_routes(codec, audio_map_rx, ARRAY_SIZE(audio_map_rx));
+
+	/* signal a DAPM event */
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link smdk64xx_dai[] = {
+{ /* Primary Playback i/f */
+	.name = "WM8580 PAIF RX",
+	.stream_name = "Playback",
+	.cpu_dai = &s3c64xx_i2s_v4_dai,
+	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFRX],
+	.init = smdk64xx_wm8580_init_paifrx,
+	.ops = &smdk64xx_ops,
+},
+{ /* Primary Capture i/f */
+	.name = "WM8580 PAIF TX",
+	.stream_name = "Capture",
+	.cpu_dai = &s3c64xx_i2s_v4_dai,
+	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFTX],
+	.init = smdk64xx_wm8580_init_paiftx,
+	.ops = &smdk64xx_ops,
+},
+};
+
+static struct snd_soc_card smdk64xx = {
+	.name = "smdk64xx",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = smdk64xx_dai,
+	.num_links = ARRAY_SIZE(smdk64xx_dai),
+};
+
+static struct snd_soc_device smdk64xx_snd_devdata = {
+	.card = &smdk64xx,
+	.codec_dev = &soc_codec_dev_wm8580,
+};
+
+static struct platform_device *smdk64xx_snd_device;
+
+static int __init smdk64xx_audio_init(void)
+{
+	int ret;
+
+	smdk64xx_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk64xx_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk64xx_snd_device, &smdk64xx_snd_devdata);
+	smdk64xx_snd_devdata.dev = &smdk64xx_snd_device->dev;
+	ret = platform_device_add(smdk64xx_snd_device);
+
+	if (ret)
+		platform_device_put(smdk64xx_snd_device);
+
+	return ret;
+}
+module_init(smdk64xx_audio_init);
+
+MODULE_AUTHOR("Jaswinder Singh, jassi.brar@samsung.com");
+MODULE_DESCRIPTION("ALSA SoC SMDK64XX WM8580");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
new file mode 100644
index 0000000..24fd39f
--- /dev/null
+++ b/sound/soc/samsung/smdk_wm9713.c
@@ -0,0 +1,94 @@
+/*
+ * smdk_wm9713.c  --  SoC audio for SMDK
+ *
+ * Copyright 2010 Samsung Electronics Co. Ltd.
+ * Author: Jaswinder Singh Brar <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/soc.h>
+
+#include "../codecs/wm9713.h"
+#include "s3c-dma.h"
+#include "s3c-ac97.h"
+
+static struct snd_soc_card smdk;
+
+/*
+ * Default CFG switch settings to use this driver:
+ *
+ *   SMDK6410: Set CFG1 1-3 On, CFG2 1-4 Off
+ */
+
+/*
+ Playback (HeadPhone):-
+	$ amixer sset 'Headphone' unmute
+	$ amixer sset 'Right Headphone Out Mux' 'Headphone'
+	$ amixer sset 'Left Headphone Out Mux' 'Headphone'
+	$ amixer sset 'Right HP Mixer PCM' unmute
+	$ amixer sset 'Left HP Mixer PCM' unmute
+
+ Capture (LineIn):-
+	$ amixer sset 'Right Capture Source' 'Line'
+	$ amixer sset 'Left Capture Source' 'Line'
+*/
+
+static struct snd_soc_dai_link smdk_dai = {
+	.name = "AC97",
+	.stream_name = "AC97 PCM",
+	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
+	.codec_dai = &wm9713_dai[WM9713_DAI_AC97_HIFI],
+};
+
+static struct snd_soc_card smdk = {
+	.name = "SMDK",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = &smdk_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device smdk_snd_ac97_devdata = {
+	.card = &smdk,
+	.codec_dev = &soc_codec_dev_wm9713,
+};
+
+static struct platform_device *smdk_snd_ac97_device;
+
+static int __init smdk_init(void)
+{
+	int ret;
+
+	smdk_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk_snd_ac97_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk_snd_ac97_device,
+			     &smdk_snd_ac97_devdata);
+	smdk_snd_ac97_devdata.dev = &smdk_snd_ac97_device->dev;
+
+	ret = platform_device_add(smdk_snd_ac97_device);
+	if (ret)
+		platform_device_put(smdk_snd_ac97_device);
+
+	return ret;
+}
+
+static void __exit smdk_exit(void)
+{
+	platform_device_unregister(smdk_snd_ac97_device);
+}
+
+module_init(smdk_init);
+module_exit(smdk_exit);
+
+/* Module information */
+MODULE_AUTHOR("Jaswinder Singh Brar, jassi.brar@samsung.com");
+MODULE_DESCRIPTION("ALSA SoC SMDK+WM9713");
+MODULE_LICENSE("GPL");
-- 
1.6.3.3
