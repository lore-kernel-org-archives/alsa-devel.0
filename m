From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V1 08/13] Have the WM9712 driver self register
	itself
Date: Wed, 13 May 2009 21:59:16 -0400
Message-ID: <20090514015916.28145.31979.stgit@terra>
References: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 8279924360
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 03:59:26 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so720053ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 18:59:26 -0700 (PDT)
In-Reply-To: <20090514015729.28145.30483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Have the WM9712 driver self register itself. This is needed to support device tree driver binding via the soc_of_simple code.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/codecs/wm9712.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 550c903..cb0e679 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -20,6 +20,7 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/soc-of-simple.h>
 #include "wm9712.h"
 
 #define WM9712_VERSION "0.4"
@@ -740,6 +741,39 @@ struct snd_soc_codec_device soc_codec_dev_wm9712 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9712);
 
+static int __init wm9712_probe(struct platform_device *pdev)
+{
+	snd_soc_register_dais(wm9712_dai, ARRAY_SIZE(wm9712_dai));
+#if defined(CONFIG_SND_SOC_OF_SIMPLE)
+	/* Tell the of_soc helper about this codec */
+	of_snd_soc_register_codec(&soc_codec_dev_wm9712, pdev->dev.archdata.of_node,
+									wm9712_dai, ARRAY_SIZE(wm9712_dai),
+									pdev->dev.archdata.of_node);
+#endif
+	return 0;
+}
+
+static struct platform_driver wm9712_driver =
+{
+	.probe = wm9712_probe,
+	.driver = {
+			.name = "wm9712",
+	},
+};
+
+static __init int wm9712_driver_init(void)
+{
+	return platform_driver_register(&wm9712_driver);
+}
+
+static __exit void wm9712_driver_exit(void)
+{
+}
+
+module_init(wm9712_driver_init);
+module_exit(wm9712_driver_exit);
+
+
 MODULE_DESCRIPTION("ASoC WM9711/WM9712 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
