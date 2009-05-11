From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] ASoC: em-x270: make the driver support also
	eXeda and CM-X300 machines
Date: Mon, 11 May 2009 15:05:29 +0300
Message-ID: <1242043529-9501-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cathcart.site5.com (cathcart.site5.com [74.54.107.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ACE1247CD
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 14:05:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Mike Rapoport <mike@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 sound/soc/pxa/Kconfig   |    4 ++--
 sound/soc/pxa/em-x270.c |    9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index ad8a10f..f8cc974 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -89,13 +89,13 @@ config SND_PXA2XX_SOC_E800
 	  Toshiba e800 PDA
 
 config SND_PXA2XX_SOC_EM_X270
-	tristate "SoC Audio support for CompuLab EM-x270"
+	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
 	depends on SND_PXA2XX_SOC && MACH_EM_X270
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
 	  Say Y if you want to add support for SoC audio on
-	  CompuLab EM-x270.
+	  CompuLab EM-x270, eXeda and CM-X300 machines.
 
 config SND_PXA2XX_SOC_PALM27X
 	bool "SoC Audio support for Palm T|X, T5 and LifeDrive"
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index 949be9c..f4756e4 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -1,7 +1,7 @@
 /*
- * em-x270.c  --  SoC audio for EM-X270
+ * SoC audio driver for EM-X270, eXeda and CM-X300
  *
- * Copyright 2007 CompuLab, Ltd.
+ * Copyright 2007, 2009 CompuLab, Ltd.
  *
  * Author: Mike Rapoport <mike@compulab.co.il>
  *
@@ -68,7 +68,8 @@ static int __init em_x270_init(void)
 {
 	int ret;
 
-	if (!machine_is_em_x270())
+	if (!(machine_is_em_x270() || machine_is_exeda()
+	      || machine_is_cm_x300()))
 		return -ENODEV;
 
 	em_x270_snd_device = platform_device_alloc("soc-audio", -1);
@@ -95,5 +96,5 @@ module_exit(em_x270_exit);
 
 /* Module information */
 MODULE_AUTHOR("Mike Rapoport");
-MODULE_DESCRIPTION("ALSA SoC EM-X270");
+MODULE_DESCRIPTION("ALSA SoC EM-X270, eXeda and CM-X300");
 MODULE_LICENSE("GPL");
-- 
1.5.6.4
