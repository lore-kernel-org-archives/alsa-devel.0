From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert mid-x86 directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 11:51:56 +0800
Message-ID: <1322106716.16201.13.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C940103B50
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 04:52:03 +0100 (CET)
Received: by ggnq2 with SMTP id q2so2246878ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 19:52:02 -0800 (PST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Lu Guanqun <guanqun.lu@intel.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/mid-x86/mfld_machine.c |   14 +-------------
 sound/soc/mid-x86/sst_platform.c |   14 +-------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index cca693a..e53f8e4 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -428,19 +428,7 @@ static struct platform_driver snd_mfld_mc_driver = {
 	.remove = __devexit_p(snd_mfld_mc_remove),
 };
 
-static int __init snd_mfld_driver_init(void)
-{
-	pr_debug("snd_mfld_driver_init called\n");
-	return platform_driver_register(&snd_mfld_mc_driver);
-}
-module_init(snd_mfld_driver_init);
-
-static void __exit snd_mfld_driver_exit(void)
-{
-	pr_debug("snd_mfld_driver_exit called\n");
-	platform_driver_unregister(&snd_mfld_mc_driver);
-}
-module_exit(snd_mfld_driver_exit);
+module_platform_driver(snd_mfld_mc_driver);
 
 MODULE_DESCRIPTION("ASoC Intel(R) MID Machine driver");
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 2305702..94f70b3 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -472,19 +472,7 @@ static struct platform_driver sst_platform_driver = {
 	.remove		= sst_platform_remove,
 };
 
-static int __init sst_soc_platform_init(void)
-{
-	pr_debug("sst_soc_platform_init called\n");
-	return platform_driver_register(&sst_platform_driver);
-}
-module_init(sst_soc_platform_init);
-
-static void __exit sst_soc_platform_exit(void)
-{
-	platform_driver_unregister(&sst_platform_driver);
-	pr_debug("sst_soc_platform_exit success\n");
-}
-module_exit(sst_soc_platform_exit);
+module_platform_driver(sst_platform_driver);
 
 MODULE_DESCRIPTION("ASoC Intel(R) MID Platform driver");
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
-- 
1.7.5.4
