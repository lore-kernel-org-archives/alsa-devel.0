From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND 1/2] ASoC: fsl: Separation of the main
	audio options and boards
Date: Sun, 16 Mar 2014 08:21:34 +0400
Message-ID: <1394943695-22845-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp17.mail.ru (smtp17.mail.ru [94.100.176.154])
 by alsa0.perex.cz (Postfix) with ESMTP id D2E672608B7
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 05:21:50 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

This patch provide separation of the main audio options and boards.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/Kconfig | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 597962e..94c9350 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,3 +1,5 @@
+menu "SoC Audio for Freescale CPUs"
+
 config SND_SOC_FSL_SAI
 	tristate
 	select REGMAP_MMIO
@@ -17,13 +19,27 @@ config SND_SOC_FSL_ESAI
 config SND_SOC_FSL_UTILS
 	tristate
 
-menuconfig SND_POWERPC_SOC
+config SND_SOC_IMX_PCM_DMA
+	tristate
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+
+config SND_SOC_IMX_AUDMUX
+	tristate
+
+config SND_POWERPC_SOC
 	tristate "SoC Audio for Freescale PowerPC CPUs"
 	depends on FSL_SOC || PPC_MPC52xx
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the PowerPC CPUs.
 
+config SND_IMX_SOC
+	tristate "SoC Audio for Freescale i.MX CPUs"
+	depends on ARCH_MXC || COMPILE_TEST
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the i.MX CPUs.
+
 if SND_POWERPC_SOC
 
 config SND_MPC52xx_DMA
@@ -32,6 +48,8 @@ config SND_MPC52xx_DMA
 config SND_SOC_POWERPC_DMA
 	tristate
 
+comment "SoC Audio support for Freescale PPC boards:"
+
 config SND_SOC_MPC8610_HPCD
 	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
 	# I2C is necessary for the CS4270 driver
@@ -109,13 +127,6 @@ config SND_MPC52xx_SOC_EFIKA
 
 endif # SND_POWERPC_SOC
 
-menuconfig SND_IMX_SOC
-	tristate "SoC Audio for Freescale i.MX CPUs"
-	depends on ARCH_MXC || COMPILE_TEST
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the i.MX CPUs.
-
 if SND_IMX_SOC
 
 config SND_SOC_IMX_SSI
@@ -125,12 +136,7 @@ config SND_SOC_IMX_PCM_FIQ
 	tristate
 	select FIQ
 
-config SND_SOC_IMX_PCM_DMA
-	tristate
-	select SND_SOC_GENERIC_DMAENGINE_PCM
-
-config SND_SOC_IMX_AUDMUX
-	tristate
+comment "SoC Audio support for Freescale i.MX boards:"
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the i.MX31ADS with WM1133-EV1 fitted"
@@ -223,3 +229,5 @@ config SND_SOC_IMX_MC13783
 	select SND_SOC_IMX_PCM_DMA
 
 endif # SND_IMX_SOC
+
+endmenu
-- 
1.8.3.2
