From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 1/3] ASoC: sam9g20-wm8731: convert to use snd_soc_register_card()
Date: Thu, 11 Oct 2012 10:38:15 +0800
Message-ID: <1349923097-14115-2-git-send-email-voice.shen@atmel.com>
References: <1349923097-14115-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1349923097-14115-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, jm.lin@atmel.com, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |   51 ++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index c883514..e5e27db 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -195,22 +195,15 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.set_bias_level = at91sam9g20ek_set_bias_level,
 };
 
-static struct platform_device *at91sam9g20ek_snd_device;
-
-static int __init at91sam9g20ek_init(void)
+static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
 {
 	struct clk *pllb;
+	struct snd_soc_card *card = &snd_soc_at91sam9g20ek;
 	int ret;
 
 	if (!(machine_is_at91sam9g20ek() || machine_is_at91sam9g20ek_2mmc()))
 		return -ENODEV;
 
-	ret = atmel_ssc_set_audio(0);
-	if (ret != 0) {
-		pr_err("Failed to set SSC 0 for audio: %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * Codec MCLK is supplied by PCK0 - set it up.
 	 */
@@ -236,26 +229,14 @@ static int __init at91sam9g20ek_init(void)
 
 	clk_set_rate(mclk, MCLK_RATE);
 
-	at91sam9g20ek_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!at91sam9g20ek_snd_device) {
-		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
-		ret = -ENOMEM;
-		goto err_mclk;
-	}
-
-	platform_set_drvdata(at91sam9g20ek_snd_device,
-			&snd_soc_at91sam9g20ek);
-
-	ret = platform_device_add(at91sam9g20ek_snd_device);
+	card->dev = &pdev->dev;
+	ret = snd_soc_register_card(card);
 	if (ret) {
-		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
-		goto err_device_add;
+		printk(KERN_ERR "ASoC: snd_soc_register_card() failed\n");
 	}
 
 	return ret;
 
-err_device_add:
-	platform_device_put(at91sam9g20ek_snd_device);
 err_mclk:
 	clk_put(mclk);
 	mclk = NULL;
@@ -263,18 +244,30 @@ err:
 	return ret;
 }
 
-static void __exit at91sam9g20ek_exit(void)
+static int __devexit at91sam9g20ek_audio_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(at91sam9g20ek_snd_device);
-	at91sam9g20ek_snd_device = NULL;
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
 	clk_put(mclk);
 	mclk = NULL;
+
+	return 0;
 }
 
-module_init(at91sam9g20ek_init);
-module_exit(at91sam9g20ek_exit);
+static struct platform_driver at91sam9g20ek_audio_driver = {
+	.driver = {
+		.name	= "at91sam9g20ek-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= at91sam9g20ek_audio_probe,
+	.remove	= __devexit_p(at91sam9g20ek_audio_remove),
+};
+
+module_platform_driver(at91sam9g20ek_audio_driver);
 
 /* Module information */
 MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
 MODULE_DESCRIPTION("ALSA SoC AT91SAM9G20EK_WM8731");
+MODULE_ALIAS("platform:at91sam9g20ek-audio");
 MODULE_LICENSE("GPL");
-- 
1.7.9.5

