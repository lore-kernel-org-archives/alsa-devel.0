From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/6] ASoC: tlv320aic3x: Move resource
	acquisition to I2C probe
Date: Tue, 24 Sep 2013 00:12:44 +0100
Message-ID: <1379977968-25982-2-git-send-email-broonie@kernel.org>
References: <1379977968-25982-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 41FA0261599
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 01:12:59 +0200 (CEST)
In-Reply-To: <1379977968-25982-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This is more idiomatic and interacts better with deferred probing.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic3x.c | 63 ++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 3abbff3..de17a36 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1345,23 +1345,6 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	if (gpio_is_valid(aic3x->gpio_reset) &&
-	    !aic3x_is_shared_reset(aic3x)) {
-		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
-		if (ret != 0)
-			goto err_gpio;
-		gpio_direction_output(aic3x->gpio_reset, 0);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
-		aic3x->supplies[i].supply = aic3x_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(aic3x->supplies),
-				 aic3x->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err_get;
-	}
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
 		aic3x->disable_nb[i].nb.notifier_call = aic3x_regulator_event;
 		aic3x->disable_nb[i].aic3x = aic3x;
@@ -1418,12 +1401,6 @@ err_notif:
 	while (i--)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
 					      &aic3x->disable_nb[i].nb);
-	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
-err_get:
-	if (gpio_is_valid(aic3x->gpio_reset) &&
-	    !aic3x_is_shared_reset(aic3x))
-		gpio_free(aic3x->gpio_reset);
-err_gpio:
 	return ret;
 }
 
@@ -1434,15 +1411,9 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	list_del(&aic3x->list);
-	if (gpio_is_valid(aic3x->gpio_reset) &&
-	    !aic3x_is_shared_reset(aic3x)) {
-		gpio_set_value(aic3x->gpio_reset, 0);
-		gpio_free(aic3x->gpio_reset);
-	}
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
 					      &aic3x->disable_nb[i].nb);
-	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 
 	return 0;
 }
@@ -1484,7 +1455,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	struct aic3x_priv *aic3x;
 	struct aic3x_setup_data *ai3x_setup;
 	struct device_node *np = i2c->dev.of_node;
-	int ret;
+	int ret, i;
 	u32 value;
 
 	aic3x = devm_kzalloc(&i2c->dev, sizeof(struct aic3x_priv), GFP_KERNEL);
@@ -1545,14 +1516,46 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 
 	aic3x->model = id->driver_data;
 
+	if (gpio_is_valid(aic3x->gpio_reset) &&
+	    !aic3x_is_shared_reset(aic3x)) {
+		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
+		if (ret != 0)
+			goto err;
+		gpio_direction_output(aic3x->gpio_reset, 0);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
+		aic3x->supplies[i].supply = aic3x_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(aic3x->supplies),
+				      aic3x->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		goto err_gpio;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic3x, &aic3x_dai, 1);
 	return ret;
+
+err_gpio:
+	if (gpio_is_valid(aic3x->gpio_reset) &&
+	    !aic3x_is_shared_reset(aic3x))
+		gpio_free(aic3x->gpio_reset);
+err:
+	return ret;
 }
 
 static int aic3x_i2c_remove(struct i2c_client *client)
 {
+	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
+	if (gpio_is_valid(aic3x->gpio_reset) &&
+	    !aic3x_is_shared_reset(aic3x)) {
+		gpio_set_value(aic3x->gpio_reset, 0);
+		gpio_free(aic3x->gpio_reset);
+	}
 	return 0;
 }
 
-- 
1.8.4.rc3
