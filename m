From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: Rename snd_soc_register_card() to
	snd_soc_init_card()
Date: Mon,  1 Dec 2008 20:07:35 +0000
Message-ID: <1228162061-14769-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081201200703.GA14376@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BD0C01037F0
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 21:07:43 +0100 (CET)
In-Reply-To: <20081201200703.GA14376@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently ASoC card initialisation is completed by a function called
snd_soc_register_card().  As part of the work to allow independant
registration of cards, codecs and machines in ASoC v2 a new function of
the same name has been added so rename the existing function to
facilitate the merge of v2.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h            |    2 +-
 sound/soc/codecs/ac97.c        |    2 +-
 sound/soc/codecs/ad1980.c      |    2 +-
 sound/soc/codecs/ad73311.c     |    2 +-
 sound/soc/codecs/ak4535.c      |    2 +-
 sound/soc/codecs/cs4270.c      |    2 +-
 sound/soc/codecs/pcm3008.c     |    2 +-
 sound/soc/codecs/ssm2602.c     |    2 +-
 sound/soc/codecs/tlv320aic23.c |    2 +-
 sound/soc/codecs/tlv320aic26.c |    2 +-
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 sound/soc/codecs/twl4030.c     |    2 +-
 sound/soc/codecs/uda134x.c     |    2 +-
 sound/soc/codecs/uda1380.c     |    2 +-
 sound/soc/codecs/wm8510.c      |    2 +-
 sound/soc/codecs/wm8580.c      |    2 +-
 sound/soc/codecs/wm8728.c      |    2 +-
 sound/soc/codecs/wm8731.c      |    2 +-
 sound/soc/codecs/wm8750.c      |    2 +-
 sound/soc/codecs/wm8753.c      |    2 +-
 sound/soc/codecs/wm8900.c      |    2 +-
 sound/soc/codecs/wm8903.c      |    2 +-
 sound/soc/codecs/wm8971.c      |    2 +-
 sound/soc/codecs/wm8990.c      |    2 +-
 sound/soc/codecs/wm9712.c      |    2 +-
 sound/soc/codecs/wm9713.c      |    2 +-
 sound/soc/soc-core.c           |    6 +++---
 27 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 444f9c2..9356c1c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -162,7 +162,7 @@ extern struct snd_ac97_bus_ops soc_ac97_ops;
 /* pcm <-> DAI connect */
 void snd_soc_free_pcms(struct snd_soc_device *socdev);
 int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid);
-int snd_soc_register_card(struct snd_soc_device *socdev);
+int snd_soc_init_card(struct snd_soc_device *socdev);
 
 /* set runtime hw params */
 int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index c4208c8..fb53e65 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -114,7 +114,7 @@ static int ac97_soc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto bus_err;
 
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0)
 		goto bus_err;
 	return 0;
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index a9a2681..73fdbb4 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -270,7 +270,7 @@ static int ad1980_soc_probe(struct platform_device *pdev)
 	ac97_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);
 
 	ad1980_add_controls(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "ad1980: failed to register card\n");
 		goto reset_err;
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index 59c4c8f..0f4110f 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -67,7 +67,7 @@ static int ad73311_soc_probe(struct platform_device *pdev)
 		goto pcm_err;
 	}
 
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "ad73311: failed to register card\n");
 		goto register_err;
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index c742290..23062c9 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -512,7 +512,7 @@ static int ak4535_init(struct snd_soc_device *socdev)
 
 	ak4535_add_controls(codec);
 	ak4535_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "ak4535: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 7507d46..4667a07 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -723,7 +723,7 @@ static int cs4270_probe(struct platform_device *pdev)
 	printk(KERN_INFO "cs4270: I2C disabled, using stand-alone mode\n");
 #endif
 
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: failed to register card\n");
 		goto error_del_driver;
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 651a15e..a586255 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -91,7 +91,7 @@ static int pcm3008_soc_probe(struct platform_device *pdev)
 	}
 
 	/* Register Card. */
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "pcm3008: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 0c5884e..9738449 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -624,7 +624,7 @@ static int ssm2602_init(struct snd_soc_device *socdev)
 
 	ssm2602_add_controls(codec);
 	ssm2602_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		pr_err("ssm2602: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index a4e13d0..d209bec 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -720,7 +720,7 @@ static int tlv320aic23_init(struct snd_soc_device *socdev)
 
 	tlv320aic23_add_controls(codec);
 	tlv320aic23_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "tlv320aic23: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 6b7ddfc..e33fb7e 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -359,7 +359,7 @@ static int aic26_probe(struct platform_device *pdev)
 
 	/* CODEC is setup, we can register the card now */
 	dev_dbg(&pdev->dev, "Registering card\n");
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "aic26: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 255e784..0f4067b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1187,7 +1187,7 @@ static int aic3x_init(struct snd_soc_device *socdev)
 
 	aic3x_add_controls(codec);
 	aic3x_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "aic3x: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 4136231..f3e9e59 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -764,7 +764,7 @@ static int twl4030_init(struct snd_soc_device *socdev)
 	twl4030_add_controls(codec);
 	twl4030_add_widgets(codec);
 
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "twl4030: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 91f333c..58de749 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -578,7 +578,7 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 		goto pcm_err;
 	}
 
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "UDA134X: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 330877c..4249165 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -677,7 +677,7 @@ static int uda1380_init(struct snd_soc_device *socdev, int dac_clk)
 	/* uda1380 init */
 	uda1380_add_controls(codec);
 	uda1380_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		pr_err("uda1380: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 173b66c..126c70f 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -658,7 +658,7 @@ static int wm8510_init(struct snd_soc_device *socdev)
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	wm8510_add_controls(codec);
 	wm8510_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8510: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 220d4b6..572a31d 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -869,7 +869,7 @@ static int wm8580_init(struct snd_soc_device *socdev)
 	wm8580_add_controls(codec);
 	wm8580_add_widgets(codec);
 
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8580: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 71949bd..28f12c6 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -332,7 +332,7 @@ static int wm8728_init(struct snd_soc_device *socdev)
 
 	wm8728_add_controls(codec);
 	wm8728_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8728: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c0f2770..403dea1 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -545,7 +545,7 @@ static int wm8731_init(struct snd_soc_device *socdev)
 
 	wm8731_add_controls(codec);
 	wm8731_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8731: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 860a1d5..979446f 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -818,7 +818,7 @@ static int wm8750_init(struct snd_soc_device *socdev)
 
 	wm8750_add_controls(codec);
 	wm8750_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8750: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 5e4cd3b..96c0453 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1605,7 +1605,7 @@ static int wm8753_init(struct snd_soc_device *socdev)
 
 	wm8753_add_controls(codec);
 	wm8753_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8753: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index d1326be..29cd839 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1365,7 +1365,7 @@ static int wm8900_init(struct snd_soc_device *socdev)
 	wm8900_add_controls(codec);
 	wm8900_add_widgets(codec);
 
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "Failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index efbe892..393a4c1 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1648,7 +1648,7 @@ static int wm8903_init(struct snd_soc_device *socdev)
 
 	wm8903_add_controls(codec);
 	wm8903_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "wm8903: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 26edcc9..53e6937 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -747,7 +747,7 @@ static int wm8971_init(struct snd_soc_device *socdev)
 
 	wm8971_add_controls(codec);
 	wm8971_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8971: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 1392651..5c5128b 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1462,7 +1462,7 @@ static int wm8990_init(struct snd_soc_device *socdev)
 
 	wm8990_add_controls(codec);
 	wm8990_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8990: failed to register card\n");
 		goto card_err;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 40f1406..af83d62 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -700,7 +700,7 @@ static int wm9712_soc_probe(struct platform_device *pdev)
 	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	wm9712_add_controls(codec);
 	wm9712_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9712: failed to register card\n");
 		goto reset_err;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 9dad0bf..49962a8 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1247,7 +1247,7 @@ static int wm9713_soc_probe(struct platform_device *pdev)
 
 	wm9713_add_controls(codec);
 	wm9713_add_widgets(codec);
-	ret = snd_soc_register_card(socdev);
+	ret = snd_soc_init_card(socdev);
 	if (ret < 0)
 		goto reset_err;
 	return 0;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 13b4aaf..0448708 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1233,7 +1233,7 @@ int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
 EXPORT_SYMBOL_GPL(snd_soc_new_pcms);
 
 /**
- * snd_soc_register_card - register sound card
+ * snd_soc_init_card - register sound card
  * @socdev: the SoC audio device
  *
  * Register a SoC sound card. Also registers an AC97 device if the
@@ -1241,7 +1241,7 @@ EXPORT_SYMBOL_GPL(snd_soc_new_pcms);
  *
  * Returns 0 for success, else error.
  */
-int snd_soc_register_card(struct snd_soc_device *socdev)
+int snd_soc_init_card(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->codec;
 	struct snd_soc_card *card = socdev->card;
@@ -1298,7 +1298,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 out:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(snd_soc_register_card);
+EXPORT_SYMBOL_GPL(snd_soc_init_card);
 
 /**
  * snd_soc_free_pcms - free sound card and pcms
-- 
1.5.6.5
