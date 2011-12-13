From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: OMAP: Kconfig string cleanup
Date: Tue, 13 Dec 2011 10:30:17 +0200
Message-ID: <1323765017-31943-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FE0F103ADA
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 09:30:06 +0100 (CET)
Received: by lahi5 with SMTP id i5so2274599lah.28
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 00:30:03 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

User visible string cleanup in the config file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index fb1bf25..9329810 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,5 +1,5 @@
 config SND_OMAP_SOC
-	tristate "SoC Audio for the Texas Instruments OMAP chips"
+	tristate "SoC Audio for Texas Instruments OMAP based boards"
 	depends on ARCH_OMAP
 
 config SND_OMAP_SOC_DMIC
@@ -16,7 +16,7 @@ config SND_OMAP_SOC_HDMI
 	tristate
 
 config SND_OMAP_SOC_N810
-	tristate "SoC Audio support for Nokia N810"
+	tristate "Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
 	depends on OMAP_MUX
 	select SND_OMAP_SOC_MCBSP
@@ -25,7 +25,7 @@ config SND_OMAP_SOC_N810
 	  Say Y if you want to add support for SoC audio on Nokia N810.
 
 config SND_OMAP_SOC_RX51
-	tristate "SoC Audio support for Nokia RX-51"
+	tristate "Audio support for Nokia RX-51"
 	depends on SND_OMAP_SOC && MACH_NOKIA_RX51
 	select OMAP_MCBSP
 	select SND_OMAP_SOC_MCBSP
@@ -36,7 +36,7 @@ config SND_OMAP_SOC_RX51
 	  hardware. This is also known as Nokia N900 product.
 
 config SND_OMAP_SOC_AMS_DELTA
-	tristate "SoC Audio support for Amstrad E3 (Delta) videophone"
+	tristate "Audio support for Amstrad E3 (Delta) videophone"
 	depends on SND_OMAP_SOC && MACH_AMS_DELTA
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_CX20442
@@ -55,7 +55,7 @@ config SND_OMAP_SOC_AMS_DELTA
 				RUN+="/usr/sbin/ldattach 19 /dev/ttyS3"
 
 config SND_OMAP_SOC_OSK5912
-	tristate "SoC Audio support for omap osk5912"
+	tristate "Audio support for omap osk5912"
 	depends on SND_OMAP_SOC && MACH_OMAP_OSK && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC23
@@ -63,7 +63,7 @@ config SND_OMAP_SOC_OSK5912
 	  Say Y if you want to add support for SoC audio on osk5912.
 
 config SND_OMAP_SOC_OVERO
-	tristate "SoC Audio support for Gumstix Overo and CompuLab CM-T35"
+	tristate "Audio support for Gumstix Overo and CompuLab CM-T35"
 	depends on TWL4030_CORE && SND_OMAP_SOC && (MACH_OVERO || MACH_CM_T35)
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
@@ -72,7 +72,7 @@ config SND_OMAP_SOC_OVERO
 	  Gumstix Overo or CompuLab CM-T35
 
 config SND_OMAP_SOC_OMAP3EVM
-	tristate "SoC Audio support for OMAP3EVM board"
+	tristate "Audio support for OMAP3EVM board"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3EVM
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
@@ -80,7 +80,7 @@ config SND_OMAP_SOC_OMAP3EVM
 	  Say Y if you want to add support for SoC audio on the omap3evm board.
 
 config SND_OMAP_SOC_AM3517EVM
-	tristate "SoC Audio support for OMAP3517 / AM3517 EVM"
+	tristate "Audio support for OMAP3517 / AM3517 EVM"
 	depends on SND_OMAP_SOC && MACH_OMAP3517EVM && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC23
@@ -89,7 +89,7 @@ config SND_OMAP_SOC_AM3517EVM
 	  EVM.
 
 config SND_OMAP_SOC_SDP3430
-	tristate "SoC Audio support for Texas Instruments SDP3430"
+	tristate "Audio support for Texas Instruments SDP3430"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_3430SDP
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
@@ -98,7 +98,7 @@ config SND_OMAP_SOC_SDP3430
 	  SDP3430.
 
 config SND_OMAP_SOC_SDP4430
-	tristate "SoC Audio support for Texas Instruments SDP4430"
+	tristate "Audio support for Texas Instruments SDP4430"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
@@ -109,7 +109,7 @@ config SND_OMAP_SOC_SDP4430
 	  SDP4430.
 
 config SND_OMAP_SOC_OMAP4_HDMI
-	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
+	tristate "Audio support for Texas Instruments OMAP4 HDMI"
 	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS && ARCH_OMAP4
 	select SND_OMAP_SOC_HDMI
 	help
@@ -117,7 +117,7 @@ config SND_OMAP_SOC_OMAP4_HDMI
 	  OMAP4 chips
 
 config SND_OMAP_SOC_OMAP3_PANDORA
-	tristate "SoC Audio support for OMAP3 Pandora"
+	tristate "Audio support for OMAP3 Pandora"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
@@ -125,7 +125,7 @@ config SND_OMAP_SOC_OMAP3_PANDORA
 	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
 
 config SND_OMAP_SOC_OMAP3_BEAGLE
-	tristate "SoC Audio support for OMAP3 Beagle and Devkit8000"
+	tristate "Audio support for OMAP3 Beagle and Devkit8000"
 	depends on TWL4030_CORE && SND_OMAP_SOC
 	depends on (MACH_OMAP3_BEAGLE || MACH_DEVKIT8000)
 	select SND_OMAP_SOC_MCBSP
@@ -135,7 +135,7 @@ config SND_OMAP_SOC_OMAP3_BEAGLE
 	  the clone Devkit8000.
 
 config SND_OMAP_SOC_ZOOM2
-	tristate "SoC Audio support for Zoom2"
+	tristate "Audio support for Zoom2"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_ZOOM2
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
@@ -143,7 +143,7 @@ config SND_OMAP_SOC_ZOOM2
 	  Say Y if you want to add support for Soc audio on Zoom2 board.
 
 config SND_OMAP_SOC_IGEP0020
-	tristate "SoC Audio support for IGEP v2"
+	tristate "Audio support for IGEP v2"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_IGEP0020
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
-- 
1.7.8
