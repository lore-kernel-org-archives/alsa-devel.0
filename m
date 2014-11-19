From: Zidan Wang <b50113@freescale.com>
Subject: [PATCH] ASoC: wm8960: Add shared_lrclk and capless to
	device tree
Date: Wed, 19 Nov 2014 20:36:08 +0800
Message-ID: <1416400568-7512-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0142.outbound.protection.outlook.com [157.56.111.142])
 by alsa0.perex.cz (Postfix) with ESMTP id B21A42604E7
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 13:35:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Li.Xiubo@freescale.com, Zidan Wang <b50113@freescale.com>, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

wm8960 codec has a wm8960_data struct which has two fields shared_lrclk and capless.
The wm8960_data is get from platform_data and it is reasonable to set it from device
tree when platform_data is null.
And when shared_lrclk is set, LRCM will be enabled. But the following software reset
in wm8960_probe will reset it to the default state. So LRCM operation should after
software reset.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 49 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 4dc4e85..1d56c90 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -125,6 +125,7 @@ struct wm8960_priv {
 	struct snd_soc_dapm_widget *out3;
 	bool deemph;
 	int playback_fs;
+	struct wm8960_data pdata;
 };
 
 #define wm8960_reset(c)	snd_soc_write(c, WM8960_RESET, 0)
@@ -961,17 +962,13 @@ static int wm8960_resume(struct snd_soc_codec *codec)
 static int wm8960_probe(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-	struct wm8960_data *pdata = dev_get_platdata(codec->dev);
+	struct wm8960_data *pdata = &wm8960->pdata;
 	int ret;
 
-	wm8960->set_bias_level = wm8960_set_bias_level_out3;
-
-	if (!pdata) {
-		dev_warn(codec->dev, "No platform data supplied\n");
-	} else {
-		if (pdata->capless)
-			wm8960->set_bias_level = wm8960_set_bias_level_capless;
-	}
+	if (pdata->capless)
+		wm8960->set_bias_level = wm8960_set_bias_level_capless;
+	else
+		wm8960->set_bias_level = wm8960_set_bias_level_out3;
 
 	ret = wm8960_reset(codec);
 	if (ret < 0) {
@@ -979,6 +976,14 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	if (pdata->shared_lrclk) {
+		ret = snd_soc_update_bits(codec, WM8960_ADDCTL2, 0x4, 0x4);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to enable LRCM: %d\n", ret);
+			return ret;
+		}
+	}
+
 	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
@@ -1029,6 +1034,18 @@ static const struct regmap_config wm8960_regmap = {
 	.volatile_reg = wm8960_volatile,
 };
 
+static void wm8960_set_pdata_from_of(struct i2c_client *i2c,
+				struct wm8960_data *pdata)
+{
+	const struct device_node *np = i2c->dev.of_node;
+
+	if (of_property_read_bool(np, "capless"))
+		pdata->capless = true;
+
+	if (of_property_read_bool(np, "shared_lrclk"))
+		pdata->shared_lrclk = true;
+}
+
 static int wm8960_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -1038,6 +1055,7 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 
 	wm8960 = devm_kzalloc(&i2c->dev, sizeof(struct wm8960_priv),
 			      GFP_KERNEL);
+
 	if (wm8960 == NULL)
 		return -ENOMEM;
 
@@ -1045,15 +1063,10 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(wm8960->regmap))
 		return PTR_ERR(wm8960->regmap);
 
-	if (pdata && pdata->shared_lrclk) {
-		ret = regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2,
-					 0x4, 0x4);
-		if (ret != 0) {
-			dev_err(&i2c->dev, "Failed to enable LRCM: %d\n",
-				ret);
-			return ret;
-		}
-	}
+	if (pdata)
+		memcpy(&wm8960->pdata, pdata, sizeof(struct wm8960_data));
+	else if (i2c->dev.of_node)
+		wm8960_set_pdata_from_of(i2c, &wm8960->pdata);
 
 	i2c_set_clientdata(i2c, wm8960);
 
-- 
1.9.1
