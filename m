From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] asoc: kbuild - only show menus for the current
	ASoC CPU	platform.
Date: Fri, 11 Jul 2008 14:05:17 +0100
Message-ID: <1215781517.6634.14.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46469248C2
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 15:05:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

We don't want to see ASoC platform menus for other non selected
architectures in our config.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/fsl/Kconfig  |    4 ----
 sound/soc/omap/Kconfig |    4 ----
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 19802e2..3368ace 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,5 +1,3 @@
-menu "ALSA SoC audio for Freescale SOCs"
-
 config SND_SOC_MPC8610
 	bool "ALSA SoC support for the MPC8610 SOC"
 	depends on MPC8610_HPCD
@@ -16,5 +14,3 @@ config SND_SOC_MPC8610_HPCD
 	default y if MPC8610_HPCD
 	help
 	  Say Y if you want to enable audio on the Freescale MPC8610 HPCD.
-
-endmenu
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 0230d83..aea27e7 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,5 +1,3 @@
-menu "SoC Audio for the Texas Instruments OMAP"
-
 config SND_OMAP_SOC
 	tristate "SoC Audio for the Texas Instruments OMAP chips"
 	depends on ARCH_OMAP && SND_SOC
@@ -15,5 +13,3 @@ config SND_OMAP_SOC_N810
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
-
-endmenu
-- 
1.5.4.3
