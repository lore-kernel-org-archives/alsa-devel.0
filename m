From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.29] ASoC: Allow Freescale MPC8610 audio
	drivers to be compiled as modules
Date: Mon, 19 Jan 2009 11:57:46 -0600
Message-ID: <1232387866-14365-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E0065103802
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 18:58:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Change the Kconfig and Makefile options for Freescale MPC8610 audio drivers
so that they can be compiled as modules, and simplify the Kconfig choices
so that only the platform is selected.

Also fix the naming of the driver files to conform to ALSA standards.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/Kconfig  |   16 ++++++++--------
 sound/soc/fsl/Makefile |    7 +++++--
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 95c12b2..bd6974e 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,17 +1,17 @@
 config SND_SOC_OF_SIMPLE
 	tristate
 
+# ASoC platform support for the Freescale MPC8610 SOC.  This compiles drivers
+# for the SSI and the Elo DMA controller.  You will still need to select
+# a platform driver and a codec driver.
 config SND_SOC_MPC8610
-	bool "ALSA SoC support for the MPC8610 SOC"
-	depends on MPC8610_HPCD
-	default y if MPC8610
-	help
-	  Say Y if you want to add support for codecs attached to the SSI
-          device on an MPC8610.
+	tristate
+	depends on MPC8610
 
 config SND_SOC_MPC8610_HPCD
-	bool "ALSA SoC support for the Freescale MPC8610 HPCD board"
-	depends on SND_SOC_MPC8610
+	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
+	depends on SND_SOC && MPC8610_HPCD
+	select SND_SOC_MPC8610
 	select SND_SOC_CS4270
 	select SND_SOC_CS4270_VD33_ERRATA
 	default y if MPC8610_HPCD
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 035da4a..f85134c 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -2,10 +2,13 @@
 obj-$(CONFIG_SND_SOC_OF_SIMPLE) += soc-of-simple.o
 
 # MPC8610 HPCD Machine Support
-obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += mpc8610_hpcd.o
+snd-soc-mpc8610-hpcd-objs := mpc8610_hpcd.o
+obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += snd-soc-mpc8610-hpcd.o
 
 # MPC8610 Platform Support
-obj-$(CONFIG_SND_SOC_MPC8610) += fsl_ssi.o fsl_dma.o
+snd-soc-fsl-ssi-objs := fsl_ssi.o
+snd-soc-fsl-dma-objs := fsl_dma.o
+obj-$(CONFIG_SND_SOC_MPC8610) += snd-soc-fsl-ssi.o snd-soc-fsl-dma.o
 
 obj-$(CONFIG_SND_SOC_MPC5200_I2S) += mpc5200_psc_i2s.o
 
-- 
1.5.5
