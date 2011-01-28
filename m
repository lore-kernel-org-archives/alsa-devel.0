From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/7] ASoC: Tegra: Harmony: Don't use soc-audio
	platform device
Date: Fri, 28 Jan 2011 14:26:36 -0700
Message-ID: <1296250001-6348-2-git-send-email-swarren@nvidia.com>
References: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 97D1824420
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 22:26:56 +0100 (CET)
In-Reply-To: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Previously, snd-soc-tegra-harmony internally instantiated a platform device
object whenever the module was loaded. Instead, switch to a more typical model
where arch/arm/mach-tegra defines a platform device, and snd-soc-tegra-harmony
acts as a driver for such a platform device.

Define a new struct tegra_harmony to store driver data in the future.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   94 +++++++++++++++++++++++++++++++-------------
 1 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index b160b71..2d6a15c 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -2,7 +2,7 @@
  * harmony.c - Harmony machine ASoC driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
- * Copyright (C) 2010 - NVIDIA, Inc.
+ * Copyright (C) 2010-2011 - NVIDIA, Inc.
  *
  * Based on code copyright/by:
  *
@@ -29,7 +29,11 @@
  */
 
 #include <asm/mach-types.h>
+
 #include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -40,9 +44,11 @@
 #include "tegra_pcm.h"
 #include "tegra_asoc_utils.h"
 
-#define PREFIX "ASoC Harmony: "
+#define DRV_NAME "tegra-snd-harmony"
+#define PREFIX DRV_NAME ": "
 
-static struct platform_device *harmony_snd_device;
+struct tegra_harmony {
+};
 
 static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
@@ -154,56 +160,88 @@ static struct snd_soc_card snd_soc_harmony = {
 	.num_links = 1,
 };
 
-static int __init harmony_soc_modinit(void)
+static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &snd_soc_harmony;
+	struct tegra_harmony *harmony;
 	int ret;
 
 	if (!machine_is_harmony()) {
-		pr_err(PREFIX "Not running on Tegra Harmony!\n");
+		dev_err(&pdev->dev, "Not running on Tegra Harmony!\n");
 		return -ENODEV;
 	}
 
-	ret = tegra_asoc_utils_init();
-	if (ret) {
-		return ret;
+	harmony = kzalloc(sizeof(struct tegra_harmony), GFP_KERNEL);
+	if (!harmony) {
+		dev_err(&pdev->dev, "Can't allocate tegra_harmony\n");
+		return -ENOMEM;
 	}
 
-	/*
-	 * Create and register platform device
-	 */
-	harmony_snd_device = platform_device_alloc("soc-audio", -1);
-	if (harmony_snd_device == NULL) {
-		pr_err(PREFIX "platform_device_alloc failed\n");
-		ret = -ENOMEM;
-		goto err_clock_utils;
-	}
+	ret = tegra_asoc_utils_init();
+	if (ret)
+		goto err_free_harmony;
 
-	platform_set_drvdata(harmony_snd_device, &snd_soc_harmony);
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, harmony);
 
-	ret = platform_device_add(harmony_snd_device);
+	ret = snd_soc_register_card(card);
 	if (ret) {
-		pr_err(PREFIX "platform_device_add failed (%d)\n",
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
-		goto err_device_put;
+		goto err_clear_drvdata;
 	}
 
 	return 0;
 
-err_device_put:
-	platform_device_put(harmony_snd_device);
-err_clock_utils:
+err_clear_drvdata:
+	snd_soc_card_set_drvdata(card, NULL);
+	platform_set_drvdata(pdev, NULL);
+	card->dev = NULL;
 	tegra_asoc_utils_fini();
+err_free_harmony:
+	kfree(harmony);
 	return ret;
 }
-module_init(harmony_soc_modinit);
 
-static void __exit harmony_soc_modexit(void)
+static int __devexit tegra_snd_harmony_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(harmony_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct tegra_harmony *harmony = snd_soc_card_get_drvdata(card);
+
+	snd_soc_unregister_card(card);
+
+	snd_soc_card_set_drvdata(card, NULL);
+	platform_set_drvdata(pdev, NULL);
+	card->dev = NULL;
 
 	tegra_asoc_utils_fini();
+
+	kfree(harmony);
+
+	return 0;
+}
+
+static struct platform_driver tegra_snd_harmony_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = tegra_snd_harmony_probe,
+	.remove = __devexit_p(tegra_snd_harmony_remove),
+};
+
+static int __init snd_tegra_harmony_init(void)
+{
+	return platform_driver_register(&tegra_snd_harmony_driver);
+}
+module_init(snd_tegra_harmony_init);
+
+static void __exit snd_tegra_harmony_exit(void)
+{
+	platform_driver_unregister(&tegra_snd_harmony_driver);
 }
-module_exit(harmony_soc_modexit);
+module_exit(snd_tegra_harmony_exit);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Harmony machine ASoC driver");
-- 
1.7.1
