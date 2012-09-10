From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: sta32x: Move regulator acquisition
	to I2C probe
Date: Mon, 10 Sep 2012 11:01:42 +0800
Message-ID: <1347246103-10010-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24097264F15
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 05:01:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is better style as it ensures we don't try to do the ASoC probe
without required resources. Also convert to devm_ while we're at it,
saving a bit of code, and fix a leak of enable on error.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sta32x.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 51b7313..039597e 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -825,22 +825,11 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 	sta32x->codec = codec;
 	sta32x->pdata = dev_get_platdata(codec->dev);
 
-	/* regulators */
-	for (i = 0; i < ARRAY_SIZE(sta32x->supplies); i++)
-		sta32x->supplies[i].supply = sta32x_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sta32x->supplies),
-				 sta32x->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
-	}
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
 				    sta32x->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
+		return ret;
 	}
 
 	/* Tell ASoC what kind of I/O to use to read the registers.  ASoC will
@@ -849,7 +838,7 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
 	if (ret < 0) {
 		dev_err(codec->dev, "failed to set cache I/O (ret=%i)\n", ret);
-		return ret;
+		goto err;
 	}
 
 	/* Chip documentation explicitly requires that the reset values
@@ -915,9 +904,8 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 
 	return 0;
 
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 err:
+	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 	return ret;
 }
 
@@ -928,7 +916,6 @@ static int sta32x_remove(struct snd_soc_codec *codec)
 	sta32x_watchdog_stop(sta32x);
 	sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
-	regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 
 	return 0;
 }
@@ -966,13 +953,24 @@ static __devinit int sta32x_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct sta32x_priv *sta32x;
-	int ret;
+	int ret, i;
 
 	sta32x = devm_kzalloc(&i2c->dev, sizeof(struct sta32x_priv),
 			      GFP_KERNEL);
 	if (!sta32x)
 		return -ENOMEM;
 
+	/* regulators */
+	for (i = 0; i < ARRAY_SIZE(sta32x->supplies); i++)
+		sta32x->supplies[i].supply = sta32x_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(sta32x->supplies),
+				      sta32x->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, sta32x);
 
 	ret = snd_soc_register_codec(&i2c->dev, &sta32x_codec, &sta32x_dai, 1);
-- 
1.7.10.4
