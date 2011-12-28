From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Convert kirkwood-openrd to use
 snd_soc_register_card()
Date: Wed, 28 Dec 2011 20:32:42 +0800
Message-ID: <1325075562.3601.3.camel@phoenix>
References: <1325075415.3601.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E85CA10398A
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 13:32:49 +0100 (CET)
Received: by iaae16 with SMTP id e16so21273451iaa.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 04:32:49 -0800 (PST)
In-Reply-To: <1325075415.3601.1.camel@phoenix>
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

 arch/arm/mach-kirkwood/openrd-setup.c |    6 ++++
 sound/soc/kirkwood/kirkwood-openrd.c  |   46 ++++++++++++++++----------------
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index 01f8c89..7e99c3f 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -83,6 +83,11 @@ static struct i2c_board_info i2c_board_info[] __initdata = {
 	},
 };
 
+static struct platform_device openrd_client_audio_device = {
+	.name		= "openrd-client-audio",
+	.id		= -1,
+};
+
 static int __initdata uart1;
 
 static int __init sd_uart_selection(char *str)
@@ -172,6 +177,7 @@ static void __init openrd_init(void)
 	kirkwood_i2c_init();
 
 	if (machine_is_openrd_client() || machine_is_openrd_ultimate()) {
+		platform_device_register(&openrd_client_audio_device);
 		i2c_register_board_info(0, i2c_board_info,
 			ARRAY_SIZE(i2c_board_info));
 		kirkwood_audio_init();
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 55d2ed3..80bd59c 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -71,41 +71,41 @@ static struct snd_soc_card openrd_client = {
 	.num_links = ARRAY_SIZE(openrd_client_dai),
 };
 
-static struct platform_device *openrd_client_snd_device;
-
-static int __init openrd_client_init(void)
+static int __devinit openrd_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &openrd_client;
 	int ret;
 
-	if (!machine_is_openrd_client() && !machine_is_openrd_ultimate())
-		return 0;
-
-	openrd_client_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!openrd_client_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(openrd_client_snd_device,
-			&openrd_client);
-
-	ret = platform_device_add(openrd_client_snd_device);
-	if (ret) {
-		printk(KERN_ERR "%s: platform_device_add failed\n", __func__);
-		platform_device_put(openrd_client_snd_device);
-	}
+	card->dev = &pdev->dev;
 
+	ret = snd_soc_register_card(card);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
 	return ret;
 }
 
-static void __exit openrd_client_exit(void)
+static int __devexit openrd_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(openrd_client_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	return 0;
 }
 
-module_init(openrd_client_init);
-module_exit(openrd_client_exit);
+static struct platform_driver openrd_driver = {
+	.driver		= {
+		.name	= "openrd-client-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= openrd_probe,
+	.remove		= __devexit_p(openrd_remove),
+};
+
+module_platform_driver(openrd_driver);
 
 /* Module information */
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("ALSA SoC OpenRD Client");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:soc-audio");
+MODULE_ALIAS("platform:openrd-client-audio");
-- 
1.7.5.4
