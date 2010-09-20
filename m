From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 1/4] ASoC: tlv320aic3x: Move regulator
	management from i2c to soc domain
Date: Mon, 20 Sep 2010 10:39:11 +0300
Message-ID: <1284968354-12536-2-git-send-email-jhnikula@gmail.com>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EF11B10382C
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 09:39:17 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so1641974ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 00:39:17 -0700 (PDT)
In-Reply-To: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

It will be easier to keep regulator enable/disable calls in sync when dynamic
regulator management is added if regulator management is moved from
aic3x_i2c_probe/_remove to aic3x_probe/_remove.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |  100 ++++++++++++++++++++--------------------
 1 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6190351..c60ead9 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1266,7 +1266,7 @@ static int aic3x_init(struct snd_soc_codec *codec)
 static int aic3x_probe(struct snd_soc_codec *codec)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
-	int ret;
+	int ret, i;
 
 	codec->control_data = aic3x->control_data;
 
@@ -1276,6 +1276,35 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	if (aic3x->gpio_reset >= 0) {
+		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
+		if (ret != 0)
+			goto err_gpio;
+		gpio_direction_output(aic3x->gpio_reset, 0);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
+		aic3x->supplies[i].supply = aic3x_supply_names[i];
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(aic3x->supplies),
+				 aic3x->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		goto err_get;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
+				    aic3x->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_enable;
+	}
+
+	if (aic3x->gpio_reset >= 0) {
+		udelay(1);
+		gpio_set_value(aic3x->gpio_reset, 1);
+	}
+
 	aic3x_init(codec);
 
 	if (aic3x->setup) {
@@ -1294,11 +1323,29 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 	aic3x_add_widgets(codec);
 
 	return 0;
+
+err_enable:
+	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+err_get:
+	if (aic3x->gpio_reset >= 0)
+		gpio_free(aic3x->gpio_reset);
+err_gpio:
+	kfree(aic3x);
+	return ret;
 }
 
 static int aic3x_remove(struct snd_soc_codec *codec)
 {
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	if (aic3x->gpio_reset >= 0) {
+		gpio_set_value(aic3x->gpio_reset, 0);
+		gpio_free(aic3x->gpio_reset);
+	}
+	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+
 	return 0;
 }
 
@@ -1336,7 +1383,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 {
 	struct aic3x_pdata *pdata = i2c->dev.platform_data;
 	struct aic3x_priv *aic3x;
-	int ret, i;
+	int ret;
 	const struct i2c_device_id *tbl;
 
 	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
@@ -1356,68 +1403,21 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		aic3x->gpio_reset = -1;
 	}
 
-	if (aic3x->gpio_reset >= 0) {
-		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
-		if (ret != 0)
-			goto err_gpio;
-		gpio_direction_output(aic3x->gpio_reset, 0);
-	}
-
 	for (tbl = aic3x_i2c_id; tbl->name[0]; tbl++) {
 		if (!strcmp(tbl->name, id->name))
 			break;
 	}
 	aic3x->model = tbl - aic3x_i2c_id;
 
-	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
-		aic3x->supplies[i].supply = aic3x_supply_names[i];
-
-	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(aic3x->supplies),
-				 aic3x->supplies);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
-		goto err_get;
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
-				    aic3x->supplies);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_enable;
-	}
-
-	if (aic3x->gpio_reset >= 0) {
-		udelay(1);
-		gpio_set_value(aic3x->gpio_reset, 1);
-	}
-
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic3x, &aic3x_dai, 1);
 	if (ret < 0)
-		goto err_enable;
-	return ret;
-
-err_enable:
-	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
-err_get:
-	if (aic3x->gpio_reset >= 0)
-		gpio_free(aic3x->gpio_reset);
-err_gpio:
-	kfree(aic3x);
+		kfree(aic3x);
 	return ret;
 }
 
 static int aic3x_i2c_remove(struct i2c_client *client)
 {
-	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
-
-	if (aic3x->gpio_reset >= 0) {
-		gpio_set_value(aic3x->gpio_reset, 0);
-		gpio_free(aic3x->gpio_reset);
-	}
-	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
-	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
-
 	snd_soc_unregister_codec(&client->dev);
 	kfree(i2c_get_clientdata(client));
 	return 0;
-- 
1.7.1
