From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: wm8523: Move regulator acquisition
	to I2C probe()
Date: Mon, 10 Sep 2012 17:08:00 +0800
Message-ID: <1347268082-14993-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347268082-14993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7218526507F
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 11:27:56 +0200 (CEST)
In-Reply-To: <1347268082-14993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is better style since we acquire all needed resources before we try
to do the ASoC card probe.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8523.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index af2289e..c4c64e2 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -402,7 +402,7 @@ static int wm8523_resume(struct snd_soc_codec *codec)
 static int wm8523_probe(struct snd_soc_codec *codec)
 {
 	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
-	int ret, i;
+	int ret;
 
 	wm8523->rate_constraint.list = &wm8523->rate_constraint_list[0];
 	wm8523->rate_constraint.count =
@@ -414,16 +414,6 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm8523->supplies); i++)
-		wm8523->supplies[i].supply = wm8523_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8523->supplies),
-				 wm8523->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8523->supplies),
 				    wm8523->supplies);
 	if (ret != 0) {
@@ -471,7 +461,6 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
 err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
 
 	return ret;
 }
@@ -481,7 +470,6 @@ static int wm8523_remove(struct snd_soc_codec *codec)
 	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
 
 	wm8523_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	regulator_bulk_free(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
 	return 0;
 }
 
@@ -514,13 +502,23 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8523_priv *wm8523;
-	int ret;
+	int ret, i;
 
 	wm8523 = devm_kzalloc(&i2c->dev, sizeof(struct wm8523_priv),
 			      GFP_KERNEL);
 	if (wm8523 == NULL)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(wm8523->supplies); i++)
+		wm8523->supplies[i].supply = wm8523_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8523->supplies),
+				      wm8523->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8523);
 	wm8523->control_type = SND_SOC_I2C;
 
-- 
1.7.10.4
