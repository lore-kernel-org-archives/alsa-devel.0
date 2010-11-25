From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 8/8] ASoC: phycore-ac97: fix resource leak
Date: Thu, 25 Nov 2010 15:14:03 +0800
Message-ID: <1290669243.30158.22.camel@mola>
References: <1290668785.30158.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290668785.30158.7.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix imx_phycore_init() error path and imx_phycore_exit() to properly free
allocated resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/imx/phycore-ac97.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index db157f7..a7deb5c 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -42,6 +42,7 @@ static struct snd_soc_card imx_phycore = {
 	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
 };
 
+static struct platform_device *imx_phycore_snd_ac97_device;
 static struct platform_device *imx_phycore_snd_device;
 
 static int __init imx_phycore_init(void)
@@ -52,29 +53,42 @@ static int __init imx_phycore_init(void)
 		/* return happy. We might run on a totally different machine */
 		return 0;
 
-	imx_phycore_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!imx_phycore_snd_device)
+	imx_phycore_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!imx_phycore_snd_ac97_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(imx_phycore_snd_device, &imx_phycore);
-	ret = platform_device_add(imx_phycore_snd_device);
+	platform_set_drvdata(imx_phycore_snd_ac97_device, &imx_phycore);
+	ret = platform_device_add(imx_phycore_snd_ac97_device);
+	if (ret)
+		goto fail1;
 
 	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
-	if (!imx_phycore_snd_device)
-		return -ENOMEM;
+	if (!imx_phycore_snd_device) {
+		ret = -ENOMEM;
+		goto fail2;
+	}
 	ret = platform_device_add(imx_phycore_snd_device);
 
 	if (ret) {
 		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
-		platform_device_put(imx_phycore_snd_device);
+		goto fail3;
 	}
 
+	return 0;
+
+fail3:
+	platform_device_put(imx_phycore_snd_device);
+fail2:
+	platform_device_del(imx_phycore_snd_ac97_device);
+fail1:
+	platform_device_put(imx_phycore_snd_ac97_device);
 	return ret;
 }
 
 static void __exit imx_phycore_exit(void)
 {
 	platform_device_unregister(imx_phycore_snd_device);
+	platform_device_unregister(imx_phycore_snd_ac97_device);
 }
 
 late_initcall(imx_phycore_init);
-- 
1.7.2
