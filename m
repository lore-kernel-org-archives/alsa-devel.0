From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 1/2] ASoC: imx: Remove unused Kconfig
	SND_MXC_SOC_SSI entry
Date: Wed, 22 Jun 2011 22:21:48 +0200
Message-ID: <20110622204438.568098676@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lebrac.rtp-net.org (lebrac.rtp-net.org [88.191.135.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 1723D2437B
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 22:48:02 +0200 (CEST)
Content-Disposition: inline; filename=audio_Kconfig_fix.patch
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

SND_MXC_SOC_SSI looks to be unused, so kill it.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Index: linux-2.6-submit/sound/soc/imx/Kconfig
===================================================================
--- linux-2.6-submit.orig/sound/soc/imx/Kconfig	2011-06-22 09:20:08.000000000 +0200
+++ linux-2.6-submit/sound/soc/imx/Kconfig	2011-06-22 09:32:48.000000000 +0200
@@ -11,9 +11,6 @@ menuconfig SND_IMX_SOC
 
 if SND_IMX_SOC
 
-config SND_MXC_SOC_SSI
-	tristate
-
 config SND_MXC_SOC_FIQ
 	tristate
 
@@ -24,7 +21,6 @@ config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
 	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
-	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_FIQ
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
@@ -34,7 +30,6 @@ config SND_SOC_MX27VIS_AIC32X4
 	tristate "SoC audio support for Visstrim M10 boards"
 	depends on MACH_IMX27_VISSTRIM_M10
 	select SND_SOC_TVL320AIC32X4
-	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_MX2
 	help
 	  Say Y if you want to add support for SoC audio on Visstrim SM10
@@ -44,7 +39,6 @@ config SND_SOC_PHYCORE_AC97
 	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
 	depends on MACH_PCM043 || MACH_PCA100
 	select SND_SOC_WM9712
-	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_FIQ
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
@@ -57,7 +51,6 @@ config SND_SOC_EUKREA_TLV320
 		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
 	select SND_SOC_TLV320AIC23
-	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_FIQ
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
