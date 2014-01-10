From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v3] ASoC: imx: Allow using sound with DT
	descriptions only
Date: Fri, 10 Jan 2014 17:00:27 +0400
Message-ID: <1389358827-381-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp36.i.mail.ru (smtp36.i.mail.ru [94.100.177.96])
 by alsa0.perex.cz (Postfix) with ESMTP id C653F260824
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 14:00:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch allow using generic sound cards/codecs based on DT description.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/Kconfig | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 1c7b3b7..8249000 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -7,6 +7,7 @@ config SND_SOC_FSL_SSI
 
 config SND_SOC_FSL_SPDIF
 	tristate
+	select REGMAP_MMIO
 
 config SND_SOC_FSL_UTILS
 	tristate
@@ -103,27 +104,32 @@ config SND_MPC52xx_SOC_EFIKA
 
 endif # SND_POWERPC_SOC
 
-menuconfig SND_IMX_SOC
-	tristate "SoC Audio for Freescale i.MX CPUs"
-	depends on ARCH_MXC || COMPILE_TEST
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the i.MX CPUs.
-
-if SND_IMX_SOC
-
-config SND_SOC_IMX_SSI
+config SND_SOC_IMX_AUDMUX
 	tristate
 
 config SND_SOC_IMX_PCM_FIQ
 	tristate
 	select FIQ
+	default y if SND_SOC_IMX_SSI=y || SND_SOC_FSL_SSI=y
 
 config SND_SOC_IMX_PCM_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	default y if SND_SOC_IMX_SSI=y || SND_SOC_FSL_SSI=y
 
-config SND_SOC_IMX_AUDMUX
+menuconfig SND_IMX_SOC
+	tristate "SoC Audio for Freescale i.MX CPUs"
+	depends on ARCH_MXC || COMPILE_TEST
+	select SND_SOC_FSL_SSI if OF
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_PCM_DMA
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the i.MX CPUs.
+
+if SND_IMX_SOC
+
+config SND_SOC_IMX_SSI
 	tristate
 
 config SND_MXC_SOC_WM1133_EV1
@@ -131,7 +137,6 @@ config SND_MXC_SOC_WM1133_EV1
 	depends on MACH_MX31ADS_WM1133_EV1
 	select SND_SOC_WM8350
 	select SND_SOC_IMX_PCM_FIQ
-	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
@@ -141,8 +146,6 @@ config SND_SOC_MX27VIS_AIC32X4
 	tristate "SoC audio support for Visstrim M10 boards"
 	depends on MACH_IMX27_VISSTRIM_M10 && I2C
 	select SND_SOC_TLV320AIC32X4
-	select SND_SOC_IMX_PCM_DMA
-	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	help
 	  Say Y if you want to add support for SoC audio on Visstrim SM10
@@ -154,7 +157,6 @@ config SND_SOC_PHYCORE_AC97
 	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
 	select SND_SOC_IMX_PCM_FIQ
-	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
@@ -169,7 +171,6 @@ config SND_SOC_EUKREA_TLV320
 	depends on I2C
 	select SND_SOC_TLV320AIC23
 	select SND_SOC_IMX_PCM_FIQ
-	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
@@ -179,9 +180,6 @@ config SND_SOC_IMX_WM8962
 	tristate "SoC Audio support for i.MX boards with wm8962"
 	depends on OF && I2C
 	select SND_SOC_WM8962
-	select SND_SOC_IMX_PCM_DMA
-	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_FSL_SSI
 	help
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a wm8962 codec.
@@ -190,18 +188,13 @@ config SND_SOC_IMX_SGTL5000
 	tristate "SoC Audio support for i.MX boards with sgtl5000"
 	depends on OF && I2C
 	select SND_SOC_SGTL5000
-	select SND_SOC_IMX_PCM_DMA
-	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_FSL_SSI
 	help
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a sgtl5000 codec.
 
 config SND_SOC_IMX_SPDIF
 	tristate "SoC Audio support for i.MX boards with S/PDIF"
-	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_SPDIF
-	select REGMAP_MMIO
 	help
 	  SoC Audio support for i.MX boards with S/PDIF
 	  Say Y if you want to add support for SoC audio on an i.MX board with
@@ -211,8 +204,6 @@ config SND_SOC_IMX_MC13783
 	tristate "SoC Audio support for I.MX boards with mc13783"
 	depends on MFD_MC13XXX && ARM
 	select SND_SOC_IMX_SSI
-	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_MC13783
-	select SND_SOC_IMX_PCM_DMA
 
 endif # SND_IMX_SOC
-- 
1.8.3.2
