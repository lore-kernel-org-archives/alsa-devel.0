From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Add more natural support for no-DMA
	DAIs
Date: Wed, 27 Apr 2011 18:27:34 +0100
Message-ID: <1303925257-26920-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AEAC524386
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 19:29:43 +0200 (CEST)
In-Reply-To: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>, Lars-Peter Clausen <lars@m>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since we can now support multiple platforms allow machines to not specify
a platform in a DAI link. Since the rest of the code requires that we have
a struct device for all objects we do this by substituting in a dummy
device that we register automatically.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c  |   15 +++++++++----
 sound/soc/soc-utils.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cb93b79..e851aa7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1357,13 +1357,18 @@ find_codec:
 			dai_link->codec_name);
 
 find_platform:
-	/* do we already have the CODEC DAI for this link ? */
-	if (rtd->platform) {
+	/* do we need a platform? */
+	if (rtd->platform)
 		goto out;
-	}
-	/* no, then find CPU DAI from registered DAIs*/
+
+	/* if there's no platform we match on the empty platform */
+	platform_name = dai_link->platform_name;
+	if (!platform_name)
+		platform_name = "snd-soc-dummy";
+
+	/* no, then find one from the set of registered platforms */
 	list_for_each_entry(platform, &platform_list, list) {
-		if (!strcmp(platform->name, dai_link->platform_name)) {
+		if (!strcmp(platform->name, platform_name)) {
 			rtd->platform = platform;
 			goto out;
 		}
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 3f45e6a..2865791 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -13,6 +13,7 @@
  *  option) any later version.
  */
 
+#include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -55,3 +56,57 @@ int snd_soc_params_to_bclk(struct snd_pcm_hw_params *params)
 		return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_params_to_bclk);
+
+static struct snd_soc_platform_driver dummy_platform;
+
+static __devinit int snd_soc_dummy_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, &dummy_platform);
+}
+
+static __devexit int snd_soc_dummy_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver soc_dummy_driver = {
+	.driver = {
+		.name = "snd-soc-dummy",
+		.owner = THIS_MODULE,
+	},
+	.probe = snd_soc_dummy_probe,
+	.remove = __devexit_p(snd_soc_dummy_remove),
+};
+
+static struct platform_device *soc_dummy_dev;
+
+static int __init snd_soc_util_init(void)
+{
+	int ret;
+
+	soc_dummy_dev = platform_device_alloc("snd-soc-dummy", -1);
+	if (!soc_dummy_dev)
+		return -ENOMEM;
+
+	ret = platform_device_add(soc_dummy_dev);
+	if (ret != 0) {
+		platform_device_put(soc_dummy_dev);
+		return ret;
+	}
+
+	ret = platform_driver_register(&soc_dummy_driver);
+	if (ret != 0)
+		platform_device_unregister(soc_dummy_dev);
+
+	return ret;
+}
+module_init(snd_soc_util_init);
+
+static void __exit snd_soc_util_exit(void)
+{
+	platform_device_unregister(soc_dummy_dev);
+	platform_driver_unregister(&soc_dummy_driver);
+}
+module_exit(snd_soc_util_exit);
-- 
1.7.4.1
