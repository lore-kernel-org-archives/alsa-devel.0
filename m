From: Jon Smirl <jonsmirl@gmail.com>
Subject: Dynamically registering a codec
Date: Wed, 13 May 2009 15:18:36 -0400
Message-ID: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7863B1038DB
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 21:18:37 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1512877qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 12:18:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On PowerPC the device tree is used to dynamically load the correct
codec module. How am I supposed to get this dynamically loaded module
registered? The WM8580 codec registers itself.

Modifying the WM9712 codec to register itself on device load works for
me. If I don't do this how am I supposed to dynamically find the DAI
pointer so that I can call snd_soc_register_dais()?

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

-- 
Jon Smirl
jonsmirl@gmail.com
