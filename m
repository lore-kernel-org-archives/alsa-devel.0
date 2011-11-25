From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/8] ASoC: Convert fsl directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 10:10:55 +0800
Message-ID: <1322187055.8878.6.camel@phoenix>
References: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 005F6103B5B
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 03:11:02 +0100 (CET)
Received: by yws1 with SMTP id 1so123092yws.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:11:02 -0800 (PST)
In-Reply-To: <1322186745.8878.1.camel@phoenix>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/fsl/fsl_dma.c          |   15 +--------------
 sound/soc/fsl/fsl_ssi.c          |   15 +--------------
 sound/soc/fsl/mpc5200_dma.c      |   12 +-----------
 sound/soc/fsl/mpc5200_psc_ac97.c |   16 +---------------
 sound/soc/fsl/mpc5200_psc_i2s.c  |   16 +---------------
 5 files changed, 5 insertions(+), 69 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index ef15402..4f59bba 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -992,20 +992,7 @@ static struct platform_driver fsl_soc_dma_driver = {
 	.remove = __devexit_p(fsl_soc_dma_remove),
 };
 
-static int __init fsl_soc_dma_init(void)
-{
-	pr_info("Freescale Elo DMA ASoC PCM Driver\n");
-
-	return platform_driver_register(&fsl_soc_dma_driver);
-}
-
-static void __exit fsl_soc_dma_exit(void)
-{
-	platform_driver_unregister(&fsl_soc_dma_driver);
-}
-
-module_init(fsl_soc_dma_init);
-module_exit(fsl_soc_dma_exit);
+module_platform_driver(fsl_soc_dma_driver);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM Driver");
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 17d857e..3e06696 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -793,20 +793,7 @@ static struct platform_driver fsl_ssi_driver = {
 	.remove = fsl_ssi_remove,
 };
 
-static int __init fsl_ssi_init(void)
-{
-	printk(KERN_INFO "Freescale Synchronous Serial Interface (SSI) ASoC Driver\n");
-
-	return platform_driver_register(&fsl_ssi_driver);
-}
-
-static void __exit fsl_ssi_exit(void)
-{
-	platform_driver_unregister(&fsl_ssi_driver);
-}
-
-module_init(fsl_ssi_init);
-module_exit(fsl_ssi_exit);
+module_platform_driver(fsl_ssi_driver);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale Synchronous Serial Interface (SSI) ASoC Driver");
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 5c6c245..e7803d3 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -526,17 +526,7 @@ static struct platform_driver mpc5200_hpcd_of_driver = {
 	}
 };
 
-static int __init mpc5200_hpcd_init(void)
-{
-	return platform_driver_register(&mpc5200_hpcd_of_driver);
-}
-module_init(mpc5200_hpcd_init);
-
-static void __exit mpc5200_hpcd_exit(void)
-{
-	platform_driver_unregister(&mpc5200_hpcd_of_driver);
-}
-module_exit(mpc5200_hpcd_exit);
+module_platform_driver(mpc5200_hpcd_of_driver);
 
 MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_DESCRIPTION("Freescale MPC5200 PSC in DMA mode ASoC Driver");
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 2fb388f..ffa00a2 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -325,21 +325,7 @@ static struct platform_driver psc_ac97_driver = {
 	},
 };
 
-/* ---------------------------------------------------------------------
- * Module setup and teardown; simply register the of_platform driver
- * for the PSC in AC97 mode.
- */
-static int __init psc_ac97_init(void)
-{
-	return platform_driver_register(&psc_ac97_driver);
-}
-module_init(psc_ac97_init);
-
-static void __exit psc_ac97_exit(void)
-{
-	platform_driver_unregister(&psc_ac97_driver);
-}
-module_exit(psc_ac97_exit);
+module_platform_driver(psc_ac97_driver);
 
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
 MODULE_DESCRIPTION("mpc5200 AC97 module");
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index e77a1f2..7b53032 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -222,21 +222,7 @@ static struct platform_driver psc_i2s_driver = {
 	},
 };
 
-/* ---------------------------------------------------------------------
- * Module setup and teardown; simply register the of_platform driver
- * for the PSC in I2S mode.
- */
-static int __init psc_i2s_init(void)
-{
-	return platform_driver_register(&psc_i2s_driver);
-}
-module_init(psc_i2s_init);
-
-static void __exit psc_i2s_exit(void)
-{
-	platform_driver_unregister(&psc_i2s_driver);
-}
-module_exit(psc_i2s_exit);
+module_platform_driver(psc_i2s_driver);
 
 MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_DESCRIPTION("Freescale MPC5200 PSC in I2S mode ASoC Driver");
-- 
1.7.5.4
