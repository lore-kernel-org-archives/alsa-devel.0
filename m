From: Sangbeom Kim <sbkim73@samsung.com>
Subject: ASoC: Samsung: Update Kconfig for Exynos5250 and
	Exynos4412
Date: Fri, 16 Mar 2012 16:55:05 +0900
Message-ID: <0c4001cd034a$19b862f0$4d2928d0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id CC0FC243BF
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 08:55:15 +0100 (CET)
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0M0Y00LH9WN87UI0@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 16 Mar 2012 16:55:05 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.118.225])
	by mmp1.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0M0Y00CMIWNVI560@mmp1.samsung.com>
	for alsa-devel@alsa-project.org; Fri, 16 Mar 2012 16:55:07 +0900 (KST)
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>, alsa-devel@alsa-project.org
Cc: sangsu4u.park@samsung.com, sbkim01@gmail.com
List-Id: alsa-devel@alsa-project.org

Update Kconfig file to support the Exynos5250 and Exynos4412

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index f3417f2..2e790c0 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,6 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 ||
ARCH_EXYNOS4
+	depends on PLAT_SAMSUNG
 	select S3C64XX_DMA if ARCH_S3C64XX
 	select S3C2410_DMA if ARCH_S3C2410
 	help
@@ -63,7 +63,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
 
 config SND_SOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 || MACH_SMDK4212)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 || MACH_SMDK4212 ||
MACH_SMDK4412 || MACH_SMDK5250)
 	depends on I2C=y && GENERIC_HARDIRQS
 	select MFD_WM8994
 	select SND_SOC_WM8994
@@ -162,7 +162,7 @@ config SND_SOC_GONI_AQUILA_WM8994
 
 config SND_SOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210 ||
MACH_SMDKV310 || MACH_SMDK4212)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210 ||
MACH_SMDKV310 || MACH_SMDK4212 || MACH_SMDK4412 || MACH_SMDK5250)
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
@@ -177,7 +177,7 @@ config SND_SOC_SMDK_WM8580_PCM
 
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310 || MACH_SMDK4212)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310 || MACH_SMDK4212 ||
MACH_SMDK4412 || MACH_SMDK5250)
 	depends on I2C=y && GENERIC_HARDIRQS
 	select MFD_WM8994
 	select SND_SOC_WM8994
-- 
1.7.1
