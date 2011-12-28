From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Convert kirkwood-t5325 to use
 snd_soc_register_card()
Date: Wed, 28 Dec 2011 20:30:15 +0800
Message-ID: <1325075415.3601.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8742210396D
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 13:30:27 +0100 (CET)
Received: by iaae16 with SMTP id e16so21270628iaa.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 04:30:25 -0800 (PST)
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
Cc: Nicolas Pitre <nico@fluxnic.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lennert Buytenhek <kernel@wantstofly.org>, Liam@alsa-project.org, Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I don't have this hardware, I'd appreciate if someone can test this patch.
Axel
 arch/arm/mach-kirkwood/t5325-setup.c |    6 ++++
 sound/soc/kirkwood/kirkwood-t5325.c  |   47 +++++++++++++++++----------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-kirkwood/t5325-setup.c
index 966b2b3..f9d2a11 100644
--- a/arch/arm/mach-kirkwood/t5325-setup.c
+++ b/arch/arm/mach-kirkwood/t5325-setup.c
@@ -106,6 +106,11 @@ static struct platform_device hp_t5325_button_device = {
 	}
 };
 
+static struct platform_device hp_t5325_audio_device = {
+	.name		= "t5325-audio",
+	.id		= -1,
+};
+
 static unsigned int hp_t5325_mpp_config[] __initdata = {
 	MPP0_NF_IO2,
 	MPP1_SPI_MOSI,
@@ -179,6 +184,7 @@ static void __init hp_t5325_init(void)
 	kirkwood_sata_init(&hp_t5325_sata_data);
 	kirkwood_ehci_init();
 	platform_device_register(&hp_t5325_button_device);
+	platform_device_register(&hp_t5325_audio_device);
 
 	i2c_register_board_info(0, i2c_board_info, ARRAY_SIZE(i2c_board_info));
 	kirkwood_audio_init();
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 16b83e5..ce4f408 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -80,7 +80,6 @@ static struct snd_soc_dai_link t5325_dai[] = {
 },
 };
 
-
 static struct snd_soc_card t5325 = {
 	.name = "t5325",
 	.owner = THIS_MODULE,
@@ -93,38 +92,40 @@ static struct snd_soc_card t5325 = {
 	.num_dapm_routes = ARRAY_SIZE(t5325_route),
 };
 
-static struct platform_device *t5325_snd_device;
-
-static int __init t5325_init(void)
+static int __devinit t5325_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &t5325;
 	int ret;
 
-	if (!machine_is_t5325())
-		return 0;
-
-	t5325_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!t5325_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(t5325_snd_device,
-			&t5325);
-
-	ret = platform_device_add(t5325_snd_device);
-	if (ret) {
-		printk(KERN_ERR "%s: platform_device_add failed\n", __func__);
-		platform_device_put(t5325_snd_device);
-	}
+	card->dev = &pdev->dev;
 
+	ret = snd_soc_register_card(card);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
 	return ret;
 }
-module_init(t5325_init);
 
-static void __exit t5325_exit(void)
+static int __devexit t5325_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(t5325_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	return 0;
 }
-module_exit(t5325_exit);
+
+static struct platform_driver t5325_driver = {
+	.driver		= {
+		.name	= "t5325-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= t5325_probe,
+	.remove		= __devexit_p(t5325_remove),
+};
+
+module_platform_driver(t5325_driver);
 
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("ALSA SoC t5325 audio client");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:t5325-audio");
-- 
1.7.5.4
