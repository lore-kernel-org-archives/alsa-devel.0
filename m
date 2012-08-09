From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH 1/2] ASoC: ad1836: convert to use
	snd_soc_register_card
Date: Thu, 9 Aug 2012 18:08:39 -0400
Message-ID: <1344550120-30901-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 7591B266049
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 11:06:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, uclinux-dist-devel@blackfin.uclinux.org
Cc: Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

Cpu dai and codec name are passed in through platform data.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/bf5xx-ad1836.c |   73 +++++++++++++++++++------------------
 1 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index d542d40..16b9c9e 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -59,62 +59,63 @@ static struct snd_soc_ops bf5xx_ad1836_ops = {
 #define BF5XX_AD1836_DAIFMT (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_IF | \
 				SND_SOC_DAIFMT_CBM_CFM)
 
-static struct snd_soc_dai_link bf5xx_ad1836_dai[] = {
-	{
-		.name = "ad1836",
-		.stream_name = "AD1836",
-		.cpu_dai_name = "bfin-tdm.0",
-		.codec_dai_name = "ad1836-hifi",
-		.platform_name = "bfin-tdm-pcm-audio",
-		.codec_name = "spi0.4",
-		.ops = &bf5xx_ad1836_ops,
-		.dai_fmt = BF5XX_AD1836_DAIFMT,
-	},
-	{
-		.name = "ad1836",
-		.stream_name = "AD1836",
-		.cpu_dai_name = "bfin-tdm.1",
-		.codec_dai_name = "ad1836-hifi",
-		.platform_name = "bfin-tdm-pcm-audio",
-		.codec_name = "spi0.4",
-		.ops = &bf5xx_ad1836_ops,
-		.dai_fmt = BF5XX_AD1836_DAIFMT,
-	},
+static struct snd_soc_dai_link bf5xx_ad1836_dai = {
+	.name = "ad1836",
+	.stream_name = "AD1836",
+	.codec_dai_name = "ad1836-hifi",
+	.platform_name = "bfin-tdm-pcm-audio",
+	.ops = &bf5xx_ad1836_ops,
+	.dai_fmt = BF5XX_AD1836_DAIFMT,
 };
 
 static struct snd_soc_card bf5xx_ad1836 = {
 	.name = "bfin-ad1836",
 	.owner = THIS_MODULE,
-	.dai_link = &bf5xx_ad1836_dai[CONFIG_SND_BF5XX_SPORT_NUM],
+	.dai_link = &bf5xx_ad1836_dai,
 	.num_links = 1,
 };
 
-static struct platform_device *bfxx_ad1836_snd_device;
-
-static int __init bf5xx_ad1836_init(void)
+static __devinit int bf5xx_ad1836_driver_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &bf5xx_ad1836;
+	const char **link_name;
 	int ret;
 
-	bfxx_ad1836_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!bfxx_ad1836_snd_device)
-		return -ENOMEM;
+	link_name = pdev->dev.platform_data;
+	if (!link_name) {
+		dev_err(&pdev->dev, "No platform data supplied\n");
+		return -EINVAL;
+	}
+	bf5xx_ad1836_dai.cpu_dai_name = link_name[0];
+	bf5xx_ad1836_dai.codec_name = link_name[1];
 
-	platform_set_drvdata(bfxx_ad1836_snd_device, &bf5xx_ad1836);
-	ret = platform_device_add(bfxx_ad1836_snd_device);
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
 
+	ret = snd_soc_register_card(card);
 	if (ret)
-		platform_device_put(bfxx_ad1836_snd_device);
-
+		dev_err(&pdev->dev, "Failed to register card\n");
 	return ret;
 }
 
-static void __exit bf5xx_ad1836_exit(void)
+static int __devexit bf5xx_ad1836_driver_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(bfxx_ad1836_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	return 0;
 }
 
-module_init(bf5xx_ad1836_init);
-module_exit(bf5xx_ad1836_exit);
+static struct platform_driver bf5xx_ad1836_driver = {
+	.driver = {
+		.name = "bfin-snd-ad1836",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = bf5xx_ad1836_driver_probe,
+	.remove = __devexit_p(bf5xx_ad1836_driver_remove),
+};
+module_platform_driver(bf5xx_ad1836_driver);
 
 /* Module information */
 MODULE_AUTHOR("Barry Song");
-- 
1.7.0.4
