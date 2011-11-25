From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/8] ASoC: Convert atmel directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 10:05:45 +0800
Message-ID: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AD39A103B5B
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 03:05:57 +0100 (CET)
Received: by yenm6 with SMTP id m6so912617yen.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:05:57 -0800 (PST)
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
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/atmel/atmel-pcm.c     |   12 +-----------
 sound/soc/atmel/atmel_ssc_dai.c |   12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index f81d4c3..60de055 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -495,17 +495,7 @@ static struct platform_driver atmel_pcm_driver = {
 	.remove = __devexit_p(atmel_soc_platform_remove),
 };
 
-static int __init snd_atmel_pcm_init(void)
-{
-	return platform_driver_register(&atmel_pcm_driver);
-}
-module_init(snd_atmel_pcm_init);
-
-static void __exit snd_atmel_pcm_exit(void)
-{
-	platform_driver_unregister(&atmel_pcm_driver);
-}
-module_exit(snd_atmel_pcm_exit);
+module_platform_driver(atmel_pcm_driver);
 
 MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
 MODULE_DESCRIPTION("Atmel PCM module");
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index a67fc9b..354341e 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -859,17 +859,7 @@ int atmel_ssc_set_audio(int ssc_id)
 }
 EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
 
-static int __init snd_atmel_ssc_init(void)
-{
-	return platform_driver_register(&asoc_ssc_driver);
-}
-module_init(snd_atmel_ssc_init);
-
-static void __exit snd_atmel_ssc_exit(void)
-{
-	platform_driver_unregister(&asoc_ssc_driver);
-}
-module_exit(snd_atmel_ssc_exit);
+module_platform_driver(asoc_ssc_driver);
 
 /* Module information */
 MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");
-- 
1.7.5.4
