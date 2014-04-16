From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 20/20] ASoC: omap-pcm: Drop the platform
	driver init code
Date: Wed, 16 Apr 2014 15:46:30 +0300
Message-ID: <1397652390-852-21-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 709BA2654D1
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:47:27 +0200 (CEST)
In-Reply-To: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

The omap-pcm no longer need to be a platform driver since all cpu_dai will
bind the platform to it's own device which we can use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index c3711b582d5f..8d809f8509c8 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -238,31 +238,6 @@ int omap_pcm_platform_register(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(omap_pcm_platform_register);
 
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
