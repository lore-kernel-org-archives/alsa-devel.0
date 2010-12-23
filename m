From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH] ASoC: SAMSUNG: Cleanup dependency of
	ASOC_SAMSUNG
Date: Thu, 23 Dec 2010 17:20:26 +0900
Message-ID: <1293092426-31648-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A61D248B8
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 09:42:50 +0100 (CET)
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
Cc: Kukjin Kim <kgene.kim@samsung.com>, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds cleanup dependency of ASOC_SAMSUNG in each Samsung's audio config.

Cc: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 sound/soc/samsung/Kconfig |   46 ++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 11ff4ad..91931e1 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -34,9 +34,16 @@ config SND_SAMSUNG_SPDIF
 config SND_SAMSUNG_I2S
 	tristate
 
+config ASOC_SAMSUNG_SIMTEC
+	tristate
+	help
+	  Internal node for common S3C24XX/Simtec suppor
+
+if ASOC_SAMSUNG
+
 config ASOC_SAMSUNG_NEO1973_WM8753
 	tristate "SoC I2S Audio support for NEO1973 - WM8753"
-	depends on ASOC_SAMSUNG && MACH_NEO1973_GTA01
+	depends on MACH_NEO1973_GTA01
 	select SND_S3C24XX_I2S
 	select SND_SOC_WM8753
 	help
@@ -45,7 +52,7 @@ config ASOC_SAMSUNG_NEO1973_WM8753
 
 config ASOC_SAMSUNG_NEO1973_GTA02_WM8753
 	tristate "Audio support for the Openmoko Neo FreeRunner (GTA02)"
-	depends on ASOC_SAMSUNG && MACH_NEO1973_GTA02
+	depends on MACH_NEO1973_GTA02
 	select SND_S3C24XX_I2S
 	select SND_SOC_WM8753
 	help
@@ -54,7 +61,7 @@ config ASOC_SAMSUNG_NEO1973_GTA02_WM8753
 	  
 config ASOC_SAMSUNG_JIVE_WM8750
 	tristate "SoC I2S Audio support for Jive"
-	depends on ASOC_SAMSUNG && MACH_JIVE
+	depends on MACH_JIVE
 	select SND_SOC_WM8750
 	select SND_S3C2412_SOC_I2S
 	help
@@ -62,7 +69,7 @@ config ASOC_SAMSUNG_JIVE_WM8750
 
 config ASOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450 || MACH_SMDK6442 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450 || MACH_SMDK6442 || MACH_SMDKV210 || MACH_SMDKC110)
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
@@ -70,7 +77,7 @@ config ASOC_SAMSUNG_SMDK_WM8580
 
 config ASOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
-	depends on ASOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
+	depends on (MACH_SMDKV310 || MACH_SMDKC210)
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_I2S
 	help
@@ -78,7 +85,7 @@ config ASOC_SAMSUNG_SMDK_WM8994
 
 config ASOC_SAMSUNG_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
-	depends on ASOC_SAMSUNG && MACH_SMDK2443
+	depends on MACH_SMDK2443
 	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
@@ -89,7 +96,7 @@ config ASOC_SAMSUNG_SMDK2443_WM9710
 
 config ASOC_SAMSUNG_LN2440SBC_ALC650
 	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
-	depends on ASOC_SAMSUNG && ARCH_S3C2410
+	depends on ARCH_S3C2410
 	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
@@ -100,33 +107,28 @@ config ASOC_SAMSUNG_LN2440SBC_ALC650
 
 config ASOC_SAMSUNG_S3C24XX_UDA134X
 	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
-	depends on ASOC_SAMSUNG && ARCH_S3C2410
+	depends on ARCH_S3C2410
 	select SND_S3C24XX_I2S
 	select SND_SOC_L3
 	select SND_SOC_UDA134X
 
-config ASOC_SAMSUNG_SIMTEC
-	tristate
-	help
-	  Internal node for common S3C24XX/Simtec suppor
-
 config ASOC_SAMSUNG_SIMTEC_TLV320AIC23
 	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-	depends on ASOC_SAMSUNG && ARCH_S3C2410
+	depends on ARCH_S3C2410
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC23
 	select ASOC_SAMSUNG_SIMTEC
 
 config ASOC_SAMSUNG_SIMTEC_HERMES
 	tristate "SoC I2S Audio support for Simtec Hermes board"
-	depends on ASOC_SAMSUNG && ARCH_S3C2410
+	depends on ARCH_S3C2410
 	select SND_S3C24XX_I2S
 	select SND_SOC_TLV320AIC3X
 	select ASOC_SAMSUNG_SIMTEC
 
 config ASOC_SAMSUNG_H1940_UDA1380
 	tristate "Audio support for the HP iPAQ H1940"
-	depends on ASOC_SAMSUNG && ARCH_H1940
+	depends on ARCH_H1940
 	select SND_S3C24XX_I2S
 	select SND_SOC_UDA1380
 	help
@@ -134,7 +136,7 @@ config ASOC_SAMSUNG_H1940_UDA1380
 
 config ASOC_SAMSUNG_RX1950_UDA1380
 	tristate "Audio support for the HP iPAQ RX1950"
-	depends on ASOC_SAMSUNG && MACH_RX1950
+	depends on MACH_RX1950
 	select SND_S3C24XX_I2S
 	select SND_SOC_UDA1380
 	help
@@ -142,7 +144,7 @@ config ASOC_SAMSUNG_RX1950_UDA1380
 
 config ASOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
+	depends on (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
@@ -150,13 +152,13 @@ config ASOC_SAMSUNG_SMDK_WM9713
 
 config ASOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
-	depends on ASOC_SAMSUNG && MACH_SMARTQ
+	depends on MACH_SMARTQ
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8750
 
 config ASOC_GONI_AQUILA_WM8994
 	tristate "SoC I2S Audio support for AQUILA/GONI - WM8994"
-	depends on ASOC_SAMSUNG && (MACH_GONI || MACH_AQUILA)
+	depends on (MACH_GONI || MACH_AQUILA)
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8994
 	help
@@ -165,7 +167,9 @@ config ASOC_GONI_AQUILA_WM8994
 
 config ASOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on ASOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210)
+	depends on (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210)
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
+
+endif
-- 
1.6.2.5
