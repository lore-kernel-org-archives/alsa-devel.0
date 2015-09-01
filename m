From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: pxa: Convert to
	devm_snd_soc_register_card
Date: Tue, 01 Sep 2015 10:32:59 +0800
Message-ID: <1441074779.12012.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EF7A261A57
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 04:33:04 +0200 (CEST)
Received: by paczk9 with SMTP id zk9so10913168pac.0
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 19:33:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Leo Yan <leoy@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Only compile tested.
 sound/soc/pxa/brownstone.c     |  9 +--------
 sound/soc/pxa/corgi.c          | 11 +----------
 sound/soc/pxa/e740_wm9705.c    |  5 +----
 sound/soc/pxa/e750_wm9705.c    |  5 +----
 sound/soc/pxa/e800_wm9712.c    |  5 +----
 sound/soc/pxa/hx4700.c         |  4 +---
 sound/soc/pxa/imote2.c         | 11 +----------
 sound/soc/pxa/mioa701_wm9713.c | 11 +----------
 sound/soc/pxa/palm27x.c        |  9 +--------
 sound/soc/pxa/poodle.c         | 11 +----------
 sound/soc/pxa/spitz.c          |  5 +----
 sound/soc/pxa/tosa.c           |  5 +----
 sound/soc/pxa/ttc-dkb.c        | 12 +-----------
 13 files changed, 13 insertions(+), 90 deletions(-)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 2b26318..6147e86 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -116,26 +116,19 @@ static int brownstone_probe(struct platform_device *pdev)
 	int ret;
 
 	brownstone.dev = &pdev->dev;
-	ret = snd_soc_register_card(&brownstone);
+	ret = devm_snd_soc_register_card(&pdev->dev, &brownstone);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 				ret);
 	return ret;
 }
 
-static int brownstone_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&brownstone);
-	return 0;
-}
-
 static struct platform_driver mmp_driver = {
 	.driver		= {
 		.name	= "brownstone-audio",
 		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= brownstone_probe,
-	.remove		= brownstone_remove,
 };
 
 module_platform_driver(mmp_driver);
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 3580d10..c97dc13 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -295,28 +295,19 @@ static int corgi_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
 	return ret;
 }
 
-static int corgi_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
 static struct platform_driver corgi_driver = {
 	.driver		= {
 		.name	= "corgi-audio",
 		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= corgi_probe,
-	.remove		= corgi_remove,
 };
 
 module_platform_driver(corgi_driver);
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index d72e124..1de8765 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -138,7 +138,7 @@ static int e740_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
@@ -149,10 +149,7 @@ static int e740_probe(struct platform_device *pdev)
 
 static int e740_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
 	gpio_free_array(e740_audio_gpios, ARRAY_SIZE(e740_audio_gpios));
-	snd_soc_unregister_card(card);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 48f2d7c..b7eb7cd 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -120,7 +120,7 @@ static int e750_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
@@ -131,10 +131,7 @@ static int e750_probe(struct platform_device *pdev)
 
 static int e750_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
 	gpio_free_array(e750_audio_gpios, ARRAY_SIZE(e750_audio_gpios));
-	snd_soc_unregister_card(card);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 45d4bd4..41bf714 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -119,7 +119,7 @@ static int e800_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
@@ -130,10 +130,7 @@ static int e800_probe(struct platform_device *pdev)
 
 static int e800_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
 	gpio_free_array(e800_audio_gpios, ARRAY_SIZE(e800_audio_gpios));
-	snd_soc_unregister_card(card);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 9f8be7c..ecbf287 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -193,7 +193,7 @@ static int hx4700_audio_probe(struct platform_device *pdev)
 		return ret;
 
 	snd_soc_card_hx4700.dev = &pdev->dev;
-	ret = snd_soc_register_card(&snd_soc_card_hx4700);
+	ret = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_hx4700);
 	if (ret)
 		gpio_free_array(hx4700_audio_gpios,
 				ARRAY_SIZE(hx4700_audio_gpios));
@@ -203,8 +203,6 @@ static int hx4700_audio_probe(struct platform_device *pdev)
 
 static int hx4700_audio_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_card(&snd_soc_card_hx4700);
-
 	gpio_set_value(GPIO92_HX4700_HP_DRIVER, 0);
 	gpio_set_value(GPIO107_HX4700_SPK_nSD, 0);
 
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index 29fabbf..9d0e407 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -72,28 +72,19 @@ static int imote2_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
 	return ret;
 }
 
-static int imote2_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
 static struct platform_driver imote2_driver = {
 	.driver		= {
 		.name	= "imote2-audio",
 		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= imote2_probe,
-	.remove		= imote2_remove,
 };
 
 module_platform_driver(imote2_driver);
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index a9615a57..29bc60e8 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -181,7 +181,7 @@ static int mioa701_wm9713_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	mioa701.dev = &pdev->dev;
-	rc =  snd_soc_register_card(&mioa701);
+	rc = devm_snd_soc_register_card(&pdev->dev, &mioa701);
 	if (!rc)
 		dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will"
 			 "lead to overheating and possible destruction of your device."
@@ -189,17 +189,8 @@ static int mioa701_wm9713_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int mioa701_wm9713_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
 static struct platform_driver mioa701_wm9713_driver = {
 	.probe		= mioa701_wm9713_probe,
-	.remove		= mioa701_wm9713_remove,
 	.driver		= {
 		.name		= "mioa701-wm9713",
 		.pm     = &snd_soc_pm_ops,
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index c20bbc0..4e74d95 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -140,22 +140,15 @@ static int palm27x_asoc_probe(struct platform_device *pdev)
 
 	palm27x_asoc.dev = &pdev->dev;
 
-	ret = snd_soc_register_card(&palm27x_asoc);
+	ret = devm_snd_soc_register_card(&pdev->dev, &palm27x_asoc);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
 	return ret;
 }
 
-static int palm27x_asoc_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&palm27x_asoc);
-	return 0;
-}
-
 static struct platform_driver palm27x_wm9712_driver = {
 	.probe		= palm27x_asoc_probe,
-	.remove		= palm27x_asoc_remove,
 	.driver		= {
 		.name		= "palm27x-asoc",
 		.pm     = &snd_soc_pm_ops,
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 80b457a..84d0e2e 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -267,28 +267,19 @@ static int poodle_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
 	return ret;
 }
 
-static int poodle_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
 static struct platform_driver poodle_driver = {
 	.driver		= {
 		.name	= "poodle-audio",
 		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= poodle_probe,
-	.remove		= poodle_remove,
 };
 
 module_platform_driver(poodle_driver);
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 461123a..b002226 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -305,7 +305,7 @@ static int spitz_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
@@ -322,9 +322,6 @@ err1:
 
 static int spitz_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
 	gpio_free(spitz_mic_gpio);
 	return 0;
 }
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index f59f566..49518dd 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -233,7 +233,7 @@ static int tosa_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
@@ -244,10 +244,7 @@ static int tosa_probe(struct platform_device *pdev)
 
 static int tosa_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
 	gpio_free(TOSA_GPIO_L_MUTE);
-	snd_soc_unregister_card(card);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index 1753c7d..65c20f7 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -128,7 +128,7 @@ static int ttc_dkb_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
@@ -136,22 +136,12 @@ static int ttc_dkb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ttc_dkb_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
-}
-
 static struct platform_driver ttc_dkb_driver = {
 	.driver		= {
 		.name	= "ttc-dkb-audio",
 		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= ttc_dkb_probe,
-	.remove		= ttc_dkb_remove,
 };
 
 module_platform_driver(ttc_dkb_driver);
-- 
2.1.0
