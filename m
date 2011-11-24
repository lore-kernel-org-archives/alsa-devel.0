From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert nuc900 directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 10:45:32 +0800
Message-ID: <1322102732.16201.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CED7103B1C
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 03:45:39 +0100 (CET)
Received: by ywp27 with SMTP id 27so2172366ywp.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 18:45:38 -0800 (PST)
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
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wan ZongShun <mcuos.com@gmail.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/nuc900/nuc900-ac97.c |   13 +------------
 sound/soc/nuc900/nuc900-pcm.c  |   12 +-----------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 9c0edad..d9343ee 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -405,18 +405,7 @@ static struct platform_driver nuc900_ac97_driver = {
 	.remove		= __devexit_p(nuc900_ac97_drvremove),
 };
 
-static int __init nuc900_ac97_init(void)
-{
-	return platform_driver_register(&nuc900_ac97_driver);
-}
-
-static void __exit nuc900_ac97_exit(void)
-{
-	platform_driver_unregister(&nuc900_ac97_driver);
-}
-
-module_init(nuc900_ac97_init);
-module_exit(nuc900_ac97_exit);
+module_platform_driver(nuc900_ac97_driver);
 
 MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
 MODULE_DESCRIPTION("NUC900 AC97 SoC driver!");
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index ae8d680..37585b4 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -358,17 +358,7 @@ static struct platform_driver nuc900_pcm_driver = {
 	.remove = __devexit_p(nuc900_soc_platform_remove),
 };
 
-static int __init nuc900_pcm_init(void)
-{
-	return platform_driver_register(&nuc900_pcm_driver);
-}
-module_init(nuc900_pcm_init);
-
-static void __exit nuc900_pcm_exit(void)
-{
-	platform_driver_unregister(&nuc900_pcm_driver);
-}
-module_exit(nuc900_pcm_exit);
+module_platform_driver(nuc900_pcm_driver);
 
 MODULE_AUTHOR("Wan ZongShun, <mcuos.com@gmail.com>");
 MODULE_DESCRIPTION("nuc900 Audio DMA module");
-- 
1.7.5.4
