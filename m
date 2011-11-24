From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert jz4740 directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 10:13:03 +0800
Message-ID: <1322100783.16201.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CDAC91039E0
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 03:13:18 +0100 (CET)
Received: by yenr9 with SMTP id r9so2197867yen.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 18:13:16 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c |   12 +-----------
 sound/soc/jz4740/jz4740-pcm.c |   12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index cd22a54..fbcdd51 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -519,17 +519,7 @@ static struct platform_driver jz4740_i2s_driver = {
 	},
 };
 
-static int __init jz4740_i2s_init(void)
-{
-	return platform_driver_register(&jz4740_i2s_driver);
-}
-module_init(jz4740_i2s_init);
-
-static void __exit jz4740_i2s_exit(void)
-{
-	platform_driver_unregister(&jz4740_i2s_driver);
-}
-module_exit(jz4740_i2s_exit);
+module_platform_driver(jz4740_i2s_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen, <lars@metafoo.de>");
 MODULE_DESCRIPTION("Ingenic JZ4740 SoC I2S driver");
diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
index d1989cd..50cda9e 100644
--- a/sound/soc/jz4740/jz4740-pcm.c
+++ b/sound/soc/jz4740/jz4740-pcm.c
@@ -356,17 +356,7 @@ static struct platform_driver jz4740_pcm_driver = {
 	},
 };
 
-static int __init jz4740_soc_platform_init(void)
-{
-	return platform_driver_register(&jz4740_pcm_driver);
-}
-module_init(jz4740_soc_platform_init);
-
-static void __exit jz4740_soc_platform_exit(void)
-{
-	return platform_driver_unregister(&jz4740_pcm_driver);
-}
-module_exit(jz4740_soc_platform_exit);
+module_platform_driver(jz4740_pcm_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Ingenic SoC JZ4740 PCM driver");
-- 
1.7.5.4
