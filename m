From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/4] ASoC: tlv320aic3x: Use regulator notifiers
	for optimizing the cache sync
Date: Fri, 10 Sep 2010 14:23:31 +0300
Message-ID: <1284117812-8618-3-git-send-email-jhnikula@gmail.com>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A468C1039AD
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:22:50 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so1541723ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 04:22:50 -0700 (PDT)
In-Reply-To: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
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

There is no need to reset the codec and perform cache sync if none of the
supply regulators were not disabled. Patch registers a notifier callback for
each supply and callback then sets a flag to indicate when cache sync is
required.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Mark, struct aic3x_disable_nb was created for getting pointer to aic3x easily.
Probably same idea could be applied to wm8962 as well?
---
 sound/soc/codecs/tlv320aic3x.c |   69 +++++++++++++++++++++++++++++++++++----
 1 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index c549b0f..d269ccf 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -61,9 +61,18 @@ static const char *aic3x_supply_names[AIC3X_NUM_SUPPLIES] = {
 	"DRVDD",	/* ADC Analog and Output Driver Voltage */
 };
 
+struct aic3x_priv;
+
+struct aic3x_disable_nb {
+	struct notifier_block nb;
+	struct aic3x_priv *aic3x;
+};
+
 /* codec private data */
 struct aic3x_priv {
+	struct snd_soc_codec *codec;
 	struct regulator_bulk_data supplies[AIC3X_NUM_SUPPLIES];
+	struct aic3x_disable_nb disable_nb[AIC3X_NUM_SUPPLIES];
 	int power;
 	enum snd_soc_control_type control_type;
 	struct aic3x_setup_data *setup;
@@ -142,7 +151,6 @@ static inline void aic3x_write_reg_cache(struct snd_soc_codec *codec,
 static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 		       unsigned int value)
 {
-	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	u8 data[2];
 
 	/* data is
@@ -153,7 +161,7 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = value & 0xff;
 
 	aic3x_write_reg_cache(codec, data[0], data[1]);
-	if (!aic3x->power ||
+	if (codec->cache_sync ||
 	    codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
 	else
@@ -166,10 +174,9 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
 		      u8 *value)
 {
-	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	*value = reg & 0xff;
 
-	if (aic3x->power) {
+	if (!codec->cache_sync) {
 		value[0] = i2c_smbus_read_byte_data(codec->control_data,
 						    value[0]);
 		aic3x_write_reg_cache(codec, reg, *value);
@@ -1068,6 +1075,27 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int aic3x_regulator_event(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	struct aic3x_disable_nb *disable_nb =
+		container_of(nb, struct aic3x_disable_nb, nb);
+	struct aic3x_priv *aic3x = disable_nb->aic3x;
+
+	if (!aic3x->codec)
+		return 0;
+
+	/*
+	 * put codec to reset and require cache sync as at least one of the
+	 * supplies was disabled
+	 */
+	if (aic3x->gpio_reset >= 0)
+		gpio_set_value(aic3x->gpio_reset, 0);
+	aic3x->codec->cache_sync = 1;
+
+	return 0;
+}
+
 static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
@@ -1080,11 +1108,18 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 					    aic3x->supplies);
 		if (ret)
 			goto out;
+		aic3x->power = 1;
+		/*
+		 * reset release and cache sync is necessary only if some
+		 * supply was off
+		 */
+		if (!codec->cache_sync)
+			goto out;
+
 		if (aic3x->gpio_reset >= 0) {
 			udelay(1);
 			gpio_set_value(aic3x->gpio_reset, 1);
 		}
-		aic3x->power = 1;
 
 		/* Sync reg_cache with the hardware */
 		for (i = 0; i < ARRAY_SIZE(aic3x_reg); i++) {
@@ -1092,10 +1127,9 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 			data[1] = cache[i];
 			codec->hw_write(codec->control_data, data, 2);
 		}
+		codec->cache_sync = 0;
 	} else {
 		aic3x->power = 0;
-		if (aic3x->gpio_reset >= 0)
-			gpio_set_value(aic3x->gpio_reset, 0);
 		ret = regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies),
 					     aic3x->supplies);
 	}
@@ -1337,6 +1371,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 
 	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->control_data = aic3x->control_data;
+	aic3x->codec = codec;
 
 	aic3x_init(codec);
 
@@ -1440,6 +1475,18 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
 		goto err_get;
 	}
+	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
+		aic3x->disable_nb[i].nb.notifier_call = aic3x_regulator_event;
+		aic3x->disable_nb[i].aic3x = aic3x;
+		ret = regulator_register_notifier(aic3x->supplies[i].consumer,
+						  &aic3x->disable_nb[i].nb);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"Failed to request regulator notifier: %d\n",
+				 ret);
+			goto err_notif;
+		}
+	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
 				    aic3x->supplies);
@@ -1461,6 +1508,10 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	return ret;
 
 err_enable:
+err_notif:
+	while (i--)
+		regulator_unregister_notifier(aic3x->supplies[i].consumer,
+					      &aic3x->disable_nb[i].nb);
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 err_get:
 	if (aic3x->gpio_reset >= 0)
@@ -1473,12 +1524,16 @@ err_gpio:
 static int aic3x_i2c_remove(struct i2c_client *client)
 {
 	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
+	int i;
 
 	if (aic3x->gpio_reset >= 0) {
 		gpio_set_value(aic3x->gpio_reset, 0);
 		gpio_free(aic3x->gpio_reset);
 	}
 	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
+		regulator_unregister_notifier(aic3x->supplies[i].consumer,
+					      &aic3x->disable_nb[i].nb);
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 
 	snd_soc_unregister_codec(&client->dev);
-- 
1.7.1
