From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 18/18] ASoC: omap-pcm: Drop the platform driver
	init code
Date: Wed, 16 Apr 2014 12:23:31 +0300
Message-ID: <1397640211-15447-19-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B48826531D
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:24:21 +0200 (CEST)
In-Reply-To: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

The omap-pcm no longer need to be a platform driver since all cpu_dai will
bind the platform to it's own device which we can use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 5c4bc9ae974b..4da8b542b87a 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -244,31 +244,6 @@ void omap_pcm_platform_unregister(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(omap_pcm_platform_unregister);
 
-static int omap_pcm_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_platform(&pdev->dev,
-			&omap_soc_platform);
-}
-
-static int omap_pcm_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver omap_pcm_driver = {
-	.driver = {
-			.name = "omap-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = omap_pcm_probe,
-	.remove = omap_pcm_remove,
-};
-
-module_platform_driver(omap_pcm_driver);
-
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
 MODULE_DESCRIPTION("OMAP PCM DMA module");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:omap-pcm-audio");
-- 
1.9.2
