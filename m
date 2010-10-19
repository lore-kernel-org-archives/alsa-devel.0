From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 24/25] ASoC: Samsung: Generalize Kconfig symbols
Date: Tue, 19 Oct 2010 16:09:06 +0900
Message-ID: <1287472146-31181-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 5553A10394C
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:17:48 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Move prefixes to repesent the nature of Samsung ASoC suitably.
	SND_S3C24XX_SOC -> ASOC_SAMSUNG
	SND_S3C_SOC_PCM -> SND_SAMSUNG_PCM
	SND_S3C_SOC_AC97 -> SND_SAMSUNG_AC97
	SND_S5P_SOC_SPDIF -> SND_SAMSUNG_SPDIF
	SND_S3C24XX_SOC_I2S -> SND_S3C24XX_I2S
	SND_S3C64XX_SOC_SMARTQ -> ASOC_SMARTQ
	SND_SOC_SMDK_SPDIF -> ASOC_SAMSUNG_SMDK_SPDIF
	SND_SOC_SMDK_WM8580 -> ASOC_SAMSUNG_SMDK_WM8580
	SND_SOC_SMDK_WM9713 -> ASOC_SAMSUNG_SMDK_WM9713
	SND_SOC_GONI_AQUILA_WM8994 -> ASOC_GONI_AQUILA_WM8994

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig  |   96 ++++++++++++++++++++++----------------------
 sound/soc/s3c24xx/Makefile |   40 +++++++++---------
 2 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 4fabd62..140095e 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -1,13 +1,13 @@
-config SND_S3C24XX_SOC
-	tristate "SoC Audio for the Samsung S3CXXXX chips"
+config ASOC_SAMSUNG
+	tristate "ASoC support for Samsung"
 	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  Say Y or M if you want to add support for codecs attached to
-	  the S3C24XX AC97 or I2S interfaces. You will also need to
+	  the Samsung SoCs' Audio interfaces. You will also need to
 	  select the audio interfaces to support below.
 
-config SND_S3C24XX_SOC_I2S
+config SND_S3C24XX_I2S
 	tristate
 	select S3C2410_DMA
 
@@ -19,136 +19,136 @@ config SND_S3C2412_SOC_I2S
 	select SND_S3C_I2SV2_SOC
 	select S3C2410_DMA
 
-config SND_S3C_SOC_PCM
+config SND_SAMSUNG_PCM
 	tristate
 
-config SND_S3C_SOC_AC97
+config SND_SAMSUNG_AC97
 	tristate
 	select SND_SOC_AC97_BUS
 
-config SND_S5P_SOC_SPDIF
+config SND_SAMSUNG_SPDIF
 	tristate
 	select SND_SOC_SPDIF
 
 config SND_SAMSUNG_I2S
 	tristate
 
-config SND_S3C24XX_SOC_NEO1973_WM8753
+config ASOC_SAMSUNG_NEO1973_WM8753
 	tristate "SoC I2S Audio support for NEO1973 - WM8753"
-	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA01
-	select SND_S3C24XX_SOC_I2S
+	depends on ASOC_SAMSUNG && MACH_NEO1973_GTA01
+	select SND_S3C24XX_I2S
 	select SND_SOC_WM8753
 	help
 	  Say Y if you want to add support for SoC audio on smdk2440
 	  with the WM8753.
 
-config SND_S3C24XX_SOC_NEO1973_GTA02_WM8753
+config ASOC_SAMSUNG_NEO1973_GTA02_WM8753
 	tristate "Audio support for the Openmoko Neo FreeRunner (GTA02)"
-	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA02
-	select SND_S3C24XX_SOC_I2S
+	depends on ASOC_SAMSUNG && MACH_NEO1973_GTA02
+	select SND_S3C24XX_I2S
 	select SND_SOC_WM8753
 	help
 	  This driver provides audio support for the Openmoko Neo FreeRunner
 	  smartphone.
 	  
-config SND_S3C24XX_SOC_JIVE_WM8750
+config ASOC_SAMSUNG_JIVE_WM8750
 	tristate "SoC I2S Audio support for Jive"
-	depends on SND_S3C24XX_SOC && MACH_JIVE
+	depends on ASOC_SAMSUNG && MACH_JIVE
 	select SND_SOC_WM8750
 	select SND_S3C2412_SOC_I2S
 	help
 	  Sat Y if you want to add support for SoC audio on the Jive.
 
-config SND_SOC_SMDK_WM8580
+config ASOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100)
+	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100)
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
 	  Say Y if you want to add support for SoC audio on the SMDKs.
 
-config SND_S3C24XX_SOC_SMDK2443_WM9710
+config ASOC_SAMSUNG_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
-	depends on SND_S3C24XX_SOC && MACH_SMDK2443
+	depends on ASOC_SAMSUNG && MACH_SMDK2443
 	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
-	select SND_S3C_SOC_AC97
+	select SND_SAMSUNG_AC97
 	help
 	  Say Y if you want to add support for SoC audio on smdk2443
 	  with the WM9710.
 
-config SND_S3C24XX_SOC_LN2440SBC_ALC650
+config ASOC_SAMSUNG_LN2440SBC_ALC650
 	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
-	depends on SND_S3C24XX_SOC && ARCH_S3C2410
+	depends on ASOC_SAMSUNG && ARCH_S3C2410
 	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
-	select SND_S3C_SOC_AC97
+	select SND_SAMSUNG_AC97
 	help
 	  Say Y if you want to add support for SoC audio on ln2440sbc
 	  with the ALC650.
 
-config SND_S3C24XX_SOC_S3C24XX_UDA134X
+config ASOC_SAMSUNG_S3C24XX_UDA134X
 	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
-       	depends on SND_S3C24XX_SOC && ARCH_S3C2410
-       	select SND_S3C24XX_SOC_I2S
+	depends on ASOC_SAMSUNG && ARCH_S3C2410
+	select SND_S3C24XX_I2S
 	select SND_SOC_L3
-       	select SND_SOC_UDA134X
+	select SND_SOC_UDA134X
 
-config SND_S3C24XX_SOC_SIMTEC
+config ASOC_SAMSUNG_SIMTEC
 	tristate
 	help
 	  Internal node for common S3C24XX/Simtec suppor
 
-config SND_S3C24XX_SOC_SIMTEC_TLV320AIC23
+config ASOC_SAMSUNG_SIMTEC_TLV320AIC23
 	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-	depends on SND_S3C24XX_SOC && ARCH_S3C2410
-	select SND_S3C24XX_SOC_I2S
+	depends on ASOC_SAMSUNG && ARCH_S3C2410
+	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC23
-	select SND_S3C24XX_SOC_SIMTEC
+	select ASOC_SAMSUNG_SIMTEC
 
-config SND_S3C24XX_SOC_SIMTEC_HERMES
+config ASOC_SAMSUNG_SIMTEC_HERMES
 	tristate "SoC I2S Audio support for Simtec Hermes board"
-	depends on SND_S3C24XX_SOC && ARCH_S3C2410
-	select SND_S3C24XX_SOC_I2S
+	depends on ASOC_SAMSUNG && ARCH_S3C2410
+	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC3X
-	select SND_S3C24XX_SOC_SIMTEC
+	select ASOC_SAMSUNG_SIMTEC
 
-config SND_S3C24XX_SOC_RX1950_UDA1380
+config ASOC_SAMSUNG_RX1950_UDA1380
 	tristate "Audio support for the HP iPAQ RX1950"
-	depends on SND_S3C24XX_SOC && MACH_RX1950
-	select SND_S3C24XX_SOC_I2S
+	depends on ASOC_SAMSUNG && MACH_RX1950
+	select SND_S3C24XX_I2S
 	select SND_SOC_UDA1380
 	help
 	  This driver provides audio support for HP iPAQ RX1950 PDA.
 
-config SND_SOC_SMDK_WM9713
+config ASOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
 	select SND_SOC_WM9713
-	select SND_S3C_SOC_AC97
+	select SND_SAMSUNG_AC97
 	help
 	  Sat Y if you want to add support for SoC audio on the SMDK.
 
-config SND_S3C64XX_SOC_SMARTQ
+config ASOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
-	depends on SND_S3C24XX_SOC && MACH_SMARTQ
+	depends on ASOC_SAMSUNG && MACH_SMARTQ
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8750
 
-config SND_SOC_GONI_AQUILA_WM8994
+config ASOC_GONI_AQUILA_WM8994
 	tristate "SoC I2S Audio support for AQUILA/GONI - WM8994"
-	depends on SND_S3C24XX_SOC && (MACH_GONI || MACH_AQUILA)
+	depends on ASOC_SAMSUNG && (MACH_GONI || MACH_AQUILA)
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on goni or aquila
 	  with the WM8994.
 
-config SND_SOC_SMDK_SPDIF
+config ASOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
 	depends on SND_S3C24XX_SOC && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210)
-	select SND_S5P_SOC_SPDIF
+	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 7eee57f..0d24f95 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -8,13 +8,13 @@ snd-soc-samsung-spdif-objs := spdif.o
 snd-soc-pcm-objs := pcm.o
 snd-soc-i2s-objs := i2s.o
 
-obj-$(CONFIG_SND_S3C24XX_SOC) += snd-soc-s3c24xx.o
-obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
-obj-$(CONFIG_SND_S3C_SOC_AC97) += snd-soc-ac97.o
+obj-$(CONFIG_ASOC_SAMSUNG) += snd-soc-s3c24xx.o
+obj-$(CONFIG_SND_S3C24XX_I2S) += snd-soc-s3c24xx-i2s.o
+obj-$(CONFIG_SND_SAMSUNG_AC97) += snd-soc-ac97.o
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
 obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
-obj-$(CONFIG_SND_S5P_SOC_SPDIF) += snd-soc-samsung-spdif.o
-obj-$(CONFIG_SND_S3C_SOC_PCM) += snd-soc-pcm.o
+obj-$(CONFIG_SND_SAMSUNG_SPDIF) += snd-soc-samsung-spdif.o
+obj-$(CONFIG_SND_SAMSUNG_PCM) += snd-soc-pcm.o
 obj-$(CONFIG_SND_SAMSUNG_I2S) += snd-soc-i2s.o
 
 # S3C24XX Machine Support
@@ -34,18 +34,18 @@ snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-goni-wm8994-objs := goni_wm8994.o
 snd-soc-smdk-spdif-objs := smdk_spdif.o
 
-obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
-obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
-obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_GTA02_WM8753) += snd-soc-neo1973-gta02-wm8753.o
-obj-$(CONFIG_SND_S3C24XX_SOC_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
-obj-$(CONFIG_SND_S3C24XX_SOC_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
-obj-$(CONFIG_SND_S3C24XX_SOC_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
-obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
-obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
-obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
-obj-$(CONFIG_SND_S3C24XX_SOC_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
-obj-$(CONFIG_SND_SOC_SMDK_WM8580) += snd-soc-smdk-wm8580.o
-obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
-obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
-obj-$(CONFIG_SND_SOC_SMDK_SPDIF) += snd-soc-smdk-spdif.o
-obj-$(CONFIG_SND_SOC_GONI_AQUILA_WM8994) += snd-soc-goni-wm8994.o
+obj-$(CONFIG_ASOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
+obj-$(CONFIG_ASOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
+obj-$(CONFIG_ASOC_SAMSUNG_NEO1973_GTA02_WM8753) += snd-soc-neo1973-gta02-wm8753.o
+obj-$(CONFIG_ASOC_SAMSUNG_SMDK2443_WM9710) += snd-soc-smdk2443-wm9710.o
+obj-$(CONFIG_ASOC_SAMSUNG_LN2440SBC_ALC650) += snd-soc-ln2440sbc-alc650.o
+obj-$(CONFIG_ASOC_SAMSUNG_S3C24XX_UDA134X) += snd-soc-s3c24xx-uda134x.o
+obj-$(CONFIG_ASOC_SAMSUNG_SIMTEC) += snd-soc-s3c24xx-simtec.o
+obj-$(CONFIG_ASOC_SAMSUNG_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
+obj-$(CONFIG_ASOC_SAMSUNG_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
+obj-$(CONFIG_ASOC_SAMSUNG_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
+obj-$(CONFIG_ASOC_SAMSUNG_SMDK_WM8580) += snd-soc-smdk-wm8580.o
+obj-$(CONFIG_ASOC_SAMSUNG_SMDK_WM9713) += snd-soc-smdk-wm9713.o
+obj-$(CONFIG_ASOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
+obj-$(CONFIG_ASOC_SAMSUNG_SMDK_SPDIF) += snd-soc-smdk-spdif.o
+obj-$(CONFIG_ASOC_GONI_AQUILA_WM8994) += snd-soc-goni-wm8994.o
-- 
1.6.2.5
