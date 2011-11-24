From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert s6000 directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 12:14:56 +0800
Message-ID: <1322108096.16201.17.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 892FF103B50
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 05:15:03 +0100 (CET)
Received: by yenr9 with SMTP id r9so2277888yen.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 20:15:02 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel =?ISO-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/s6000/s6000-i2s.c |   12 +-----------
 sound/soc/s6000/s6000-pcm.c |   12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
index 3052f64..4cc4181 100644
--- a/sound/soc/s6000/s6000-i2s.c
+++ b/sound/soc/s6000/s6000-i2s.c
@@ -604,17 +604,7 @@ static struct platform_driver s6000_i2s_driver = {
 	},
 };
 
-static int __init s6000_i2s_init(void)
-{
-	return platform_driver_register(&s6000_i2s_driver);
-}
-module_init(s6000_i2s_init);
-
-static void __exit s6000_i2s_exit(void)
-{
-	platform_driver_unregister(&s6000_i2s_driver);
-}
-module_exit(s6000_i2s_exit);
+module_platform_driver(s6000_i2s_driver);
 
 MODULE_AUTHOR("Daniel Gloeckner");
 MODULE_DESCRIPTION("Stretch s6000 family I2S SoC Interface");
diff --git a/sound/soc/s6000/s6000-pcm.c b/sound/soc/s6000/s6000-pcm.c
index 55efc2b..43c014f 100644
--- a/sound/soc/s6000/s6000-pcm.c
+++ b/sound/soc/s6000/s6000-pcm.c
@@ -520,17 +520,7 @@ static struct platform_driver s6000_pcm_driver = {
 	.remove = __devexit_p(s6000_soc_platform_remove),
 };
 
-static int __init snd_s6000_pcm_init(void)
-{
-	return platform_driver_register(&s6000_pcm_driver);
-}
-module_init(snd_s6000_pcm_init);
-
-static void __exit snd_s6000_pcm_exit(void)
-{
-	platform_driver_unregister(&s6000_pcm_driver);
-}
-module_exit(snd_s6000_pcm_exit);
+module_platform_driver(s6000_pcm_driver);
 
 MODULE_AUTHOR("Daniel Gloeckner");
 MODULE_DESCRIPTION("Stretch s6000 family PCM DMA module");
-- 
1.7.5.4
