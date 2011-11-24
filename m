From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert kirkwood directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 11:43:09 +0800
Message-ID: <1322106189.16201.9.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A304A103B35
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 04:43:16 +0100 (CET)
Received: by ghbg15 with SMTP id g15so1086920ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 19:43:15 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/kirkwood/kirkwood-dma.c |   12 +-----------
 sound/soc/kirkwood/kirkwood-i2s.c |   12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index cd33de1..2104382 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -388,17 +388,7 @@ static struct platform_driver kirkwood_pcm_driver = {
 	.remove = __devexit_p(kirkwood_soc_platform_remove),
 };
 
-static int __init kirkwood_pcm_init(void)
-{
-	return platform_driver_register(&kirkwood_pcm_driver);
-}
-module_init(kirkwood_pcm_init);
-
-static void __exit kirkwood_pcm_exit(void)
-{
-	platform_driver_unregister(&kirkwood_pcm_driver);
-}
-module_exit(kirkwood_pcm_exit);
+module_platform_driver(kirkwood_pcm_driver);
 
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Marvell Kirkwood Audio DMA module");
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 715e841..2ded906 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -483,17 +483,7 @@ static struct platform_driver kirkwood_i2s_driver = {
 	},
 };
 
-static int __init kirkwood_i2s_init(void)
-{
-	return platform_driver_register(&kirkwood_i2s_driver);
-}
-module_init(kirkwood_i2s_init);
-
-static void __exit kirkwood_i2s_exit(void)
-{
-	platform_driver_unregister(&kirkwood_i2s_driver);
-}
-module_exit(kirkwood_i2s_exit);
+module_platform_driver(kirkwood_i2s_driver);
 
 /* Module information */
 MODULE_AUTHOR("Arnaud Patard, <arnaud.patard@rtp-net.org>");
-- 
1.7.5.4
