From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC v2] Fix Kconfig and Makefile for
	Freescale MPC8610 sound drivers
Date: Mon,  2 Jun 2008 13:03:33 -0500
Message-ID: <1212429813-10033-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B40310383A
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 20:03:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Fix the Kconfig for the Freescale MPC8610 sound drivers so that only the
board is selectable, but the SOC is still a Kconfig option.

Fix the Makefile so that all of the modules are named snd-soc-xxx.ko.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

My patch, "Add CS4270 i2c data to fsl_soc.c" must be applied for these drivers
to work.

 sound/soc/fsl/Kconfig  |   13 ++++++-------
 sound/soc/fsl/Makefile |    7 +++++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 257101f..056dc2f 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,20 +1,19 @@
-menu "ALSA SoC audio for Freescale SOCs"
 
 config SND_SOC_MPC8610
-	bool "ALSA SoC support for the MPC8610 SOC"
-	depends on SND_SOC && MPC8610_HPCD
-	default y if MPC8610
+	tristate
+	# ALSA SoC support for the MPC8610 SOC
+	depends on MPC8610
 	help
 	  Say Y if you want to add support for codecs attached to the SSI
           device on an MPC8610.
 
 config SND_SOC_MPC8610_HPCD
-	bool "ALSA SoC support for the Freescale MPC8610 HPCD board"
-	depends on SND_SOC_MPC8610
+	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
+	depends on SND_SOC && MPC8610_HPCD
+	select SND_SOC_MPC8610
 	select SND_SOC_CS4270
 	select SND_SOC_CS4270_VD33_ERRATA
 	default y if MPC8610_HPCD
 	help
 	  Say Y if you want to enable audio on the Freescale MPC8610 HPCD.
 
-endmenu
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 62f680a..3a2b64e 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -1,6 +1,9 @@
 # MPC8610 HPCD Machine Support
-obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += mpc8610_hpcd.o
+snd-soc-mpc8610-hpcd-objs := mpc8610_hpcd.o
+obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += snd-soc-mpc8610-hpcd.o
 
 # MPC8610 Platform Support
-obj-$(CONFIG_SND_SOC_MPC8610) += fsl_ssi.o fsl_dma.o
+snd-soc-fsl-ssi-objs := fsl_ssi.o
+snd-soc-fsl-dma-objs := fsl_dma.o
+obj-$(CONFIG_SND_SOC_MPC8610) += snd-soc-fsl-ssi.o snd-soc-fsl-dma.o
 
-- 
1.5.5
