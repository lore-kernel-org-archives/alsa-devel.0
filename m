From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/5] ASoC: pxa: Convert imote2 to use
	snd_soc_register_card()
Date: Thu, 15 Dec 2011 10:55:24 +0800
Message-ID: <1323917724.28019.5.camel@phoenix>
References: <1323917478.28019.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E84C1038EB
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 03:55:31 +0100 (CET)
Received: by vcbf13 with SMTP id f13so171210vcb.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 18:55:30 -0800 (PST)
In-Reply-To: <1323917478.28019.1.camel@phoenix>
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
Cc: Ian Molton <spyro@f2s.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-pxa/stargate2.c |    6 ++++++
 sound/soc/pxa/imote2.c        |   41 ++++++++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index d8a2467..b0656e15 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -593,10 +593,16 @@ static struct pxa2xx_udc_mach_info imote2_udc_info __initdata = {
 	.udc_command		= sg2_udc_command,
 };
 
+static struct platform_device imote2_audio_device = {
+	.name = "imote2-audio",
+	.id   = -1,
+};
+
 static struct platform_device *imote2_devices[] = {
 	&stargate2_flash_device,
 	&imote2_leds,
 	&sht15,
+	&imote2_audio_device,
 };
 
 static void __init imote2_init(void)
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index 154fc6f..97d3aec 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -70,39 +70,46 @@ static struct snd_soc_dai_link imote2_dai = {
 	.ops = &imote2_asoc_ops,
 };
 
-static struct snd_soc_card snd_soc_imote2 = {
+static struct snd_soc_card imote2 = {
 	.name = "Imote2",
 	.dai_link = &imote2_dai,
 	.num_links = 1,
 };
 
-static struct platform_device *imote2_snd_device;
-
-static int __init imote2_asoc_init(void)
+static int __devinit imote2_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &imote2;
 	int ret;
 
-	if (!machine_is_intelmote2())
-		return -ENODEV;
-	imote2_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!imote2_snd_device)
-		return -ENOMEM;
+	card->dev = &pdev->dev;
 
-	platform_set_drvdata(imote2_snd_device, &snd_soc_imote2);
-	ret = platform_device_add(imote2_snd_device);
+	ret = snd_soc_register_card(card);
 	if (ret)
-		platform_device_put(imote2_snd_device);
-
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
 	return ret;
 }
-module_init(imote2_asoc_init);
 
-static void __exit imote2_asoc_exit(void)
+static int __devexit imote2_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(imote2_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	return 0;
 }
-module_exit(imote2_asoc_exit);
+
+static struct platform_driver imote2_driver = {
+	.driver		= {
+		.name	= "imote2-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= imote2_probe,
+	.remove		= __devexit_p(imote2_remove),
+};
+
+module_platform_driver(imote2_driver);
 
 MODULE_AUTHOR("Jonathan Cameron");
 MODULE_DESCRIPTION("ALSA SoC Imote 2");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imote2-audio");
-- 
1.7.5.4
