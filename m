From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] ASoC: fsl: Separation of the main audio
	options and boards
Date: Wed,  5 Feb 2014 21:31:51 +0400
Message-ID: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp43.i.mail.ru (smtp43.i.mail.ru [94.100.177.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 92372265007
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:32:03 +0100 (CET)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <Guangyu.Chen@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch provide separation of the main audio options and boards.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/Kconfig | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 07f8f14..ecc1092 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,3 +1,5 @@
+menu "SoC Audio for Freescale CPUs"
+
 config SND_SOC_FSL_SAI
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
@@ -14,13 +16,27 @@ config SND_SOC_FSL_ESAI
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
@@ -29,6 +45,8 @@ config SND_MPC52xx_DMA
 config SND_SOC_POWERPC_DMA
 	tristate
 
+comment "SoC Audio support for Freescale PPC boards:"
+
 config SND_SOC_MPC8610_HPCD
 	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
 	# I2C is necessary for the CS4270 driver
@@ -106,13 +124,6 @@ config SND_MPC52xx_SOC_EFIKA
 
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
@@ -122,12 +133,7 @@ config SND_SOC_IMX_PCM_FIQ
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
@@ -219,3 +225,5 @@ config SND_SOC_IMX_MC13783
 	select SND_SOC_IMX_PCM_DMA
 
 endif # SND_IMX_SOC
+
+endmenu
-- 
1.8.3.2
