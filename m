From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH V2 2/2] ASoC: pxa: Convert spitz to use
	snd_soc_register_card()
Date: Wed, 22 Oct 2014 01:15:33 +0400
Message-ID: <1413926133-3566-2-git-send-email-dbaryshkov@gmail.com>
References: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EDDBD260632
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 23:15:39 +0200 (CEST)
Received: by mail-wg0-f41.google.com with SMTP id b13so2357442wgh.24
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 14:15:39 -0700 (PDT)
In-Reply-To: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

[V2: mention spitz in commit message instead of poodle.]

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/spitz.c | 52 +++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 1373b01..d7d5fb2 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -305,19 +305,15 @@ static struct snd_soc_card snd_soc_spitz = {
 	.num_dapm_routes = ARRAY_SIZE(spitz_audio_map),
 };
 
-static struct platform_device *spitz_snd_device;
-
-static int __init spitz_init(void)
+static int spitz_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &snd_soc_spitz;
 	int ret;
 
-	if (!(machine_is_spitz() || machine_is_borzoi() || machine_is_akita()))
-		return -ENODEV;
-
-	if (machine_is_borzoi() || machine_is_spitz())
-		spitz_mic_gpio = SPITZ_GPIO_MIC_BIAS;
-	else
+	if (machine_is_akita())
 		spitz_mic_gpio = AKITA_GPIO_MIC_BIAS;
+	else
+		spitz_mic_gpio = SPITZ_GPIO_MIC_BIAS;
 
 	ret = gpio_request(spitz_mic_gpio, "MIC GPIO");
 	if (ret)
@@ -327,37 +323,45 @@ static int __init spitz_init(void)
 	if (ret)
 		goto err2;
 
-	spitz_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!spitz_snd_device) {
-		ret = -ENOMEM;
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
 		goto err2;
 	}
 
-	platform_set_drvdata(spitz_snd_device, &snd_soc_spitz);
-
-	ret = platform_device_add(spitz_snd_device);
-	if (ret)
-		goto err3;
-
 	return 0;
 
-err3:
-	platform_device_put(spitz_snd_device);
 err2:
 	gpio_free(spitz_mic_gpio);
 err1:
 	return ret;
 }
 
-static void __exit spitz_exit(void)
+static int spitz_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(spitz_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
 	gpio_free(spitz_mic_gpio);
+	return 0;
 }
 
-module_init(spitz_init);
-module_exit(spitz_exit);
+static struct platform_driver spitz_driver = {
+	.driver		= {
+		.name	= "spitz-audio",
+		.owner	= THIS_MODULE,
+		.pm     = &snd_soc_pm_ops,
+	},
+	.probe		= spitz_probe,
+	.remove		= spitz_remove,
+};
+
+module_platform_driver(spitz_driver);
 
 MODULE_AUTHOR("Richard Purdie");
 MODULE_DESCRIPTION("ALSA SoC Spitz");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:spitz-audio");
-- 
2.1.1
