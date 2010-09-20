From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 3/4] ASoC: tlv320aic3x: Use regulator
	notifiers for optimizing the cache sync
Date: Mon, 20 Sep 2010 10:39:13 +0300
Message-ID: <1284968354-12536-4-git-send-email-jhnikula@gmail.com>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A73CC10383D
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 09:39:27 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so1641974ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 00:39:27 -0700 (PDT)
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

There is no need to reset the codec and perform cache sync if none of the
supply regulators were not disabled. Patch registers a notifier callback for
each supply and callback then sets a flag to indicate when cache sync is
required.

HW writes are also needless when codec bias is off so cache_only flag is set
independently of actual supply regulators state.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   63 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 5f8a7c4..5356946 100644
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
 	enum snd_soc_control_type control_type;
 	struct aic3x_setup_data *setup;
 	void *control_data;
@@ -122,6 +131,8 @@ static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u8 *cache = codec->reg_cache;
 
+	if (codec->cache_only)
+		return -EINVAL;
 	if (reg >= AIC3X_CACHEREGNUM)
 		return -1;
 
@@ -1052,6 +1063,26 @@ static int aic3x_init_3007(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int aic3x_regulator_event(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	struct aic3x_disable_nb *disable_nb =
+		container_of(nb, struct aic3x_disable_nb, nb);
+	struct aic3x_priv *aic3x = disable_nb->aic3x;
+
+	if (event & REGULATOR_EVENT_DISABLE) {
+		/*
+		 * Put codec to reset and require cache sync as at least one
+		 * of the supplies was disabled
+		 */
+		if (aic3x->gpio_reset >= 0)
+			gpio_set_value(aic3x->gpio_reset, 0);
+		aic3x->codec->cache_sync = 1;
+	}
+
+	return 0;
+}
+
 static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
@@ -1064,6 +1095,13 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 		if (ret)
 			goto out;
 		aic3x->power = 1;
+		/*
+		 * Reset release and cache sync is necessary only if some
+		 * supply was off or if there were cached writes
+		 */
+		if (!codec->cache_sync)
+			goto out;
+
 		if (aic3x->gpio_reset >= 0) {
 			udelay(1);
 			gpio_set_value(aic3x->gpio_reset, 1);
@@ -1078,8 +1116,8 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 		codec->cache_sync = 0;
 	} else {
 		aic3x->power = 0;
-		if (aic3x->gpio_reset >= 0)
-			gpio_set_value(aic3x->gpio_reset, 0);
+		/* HW writes are needless when bias is off */
+		codec->cache_only = 1;
 		ret = regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies),
 					     aic3x->supplies);
 	}
@@ -1315,6 +1353,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 	int ret, i;
 
 	codec->control_data = aic3x->control_data;
+	aic3x->codec = codec;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, aic3x->control_type);
 	if (ret != 0) {
@@ -1338,6 +1377,18 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
 		goto err_get;
 	}
+	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
+		aic3x->disable_nb[i].nb.notifier_call = aic3x_regulator_event;
+		aic3x->disable_nb[i].aic3x = aic3x;
+		ret = regulator_register_notifier(aic3x->supplies[i].consumer,
+						  &aic3x->disable_nb[i].nb);
+		if (ret) {
+			dev_err(codec->dev,
+				"Failed to request regulator notifier: %d\n",
+				 ret);
+			goto err_notif;
+		}
+	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
 				    aic3x->supplies);
@@ -1372,6 +1423,10 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 	return 0;
 
 err_enable:
+err_notif:
+	while (i--)
+		regulator_unregister_notifier(aic3x->supplies[i].consumer,
+					      &aic3x->disable_nb[i].nb);
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 err_get:
 	if (aic3x->gpio_reset >= 0)
@@ -1384,6 +1439,7 @@ err_gpio:
 static int aic3x_remove(struct snd_soc_codec *codec)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	int i;
 
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	if (aic3x->gpio_reset >= 0) {
@@ -1391,6 +1447,9 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 		gpio_free(aic3x->gpio_reset);
 	}
 	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
+		regulator_unregister_notifier(aic3x->supplies[i].consumer,
+					      &aic3x->disable_nb[i].nb);
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 
 	return 0;
-- 
1.7.1
