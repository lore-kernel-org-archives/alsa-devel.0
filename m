From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: tlv320aic3x: Use driver_data field of struct
 i2c_device_id to identify models
Date: Wed, 28 Sep 2011 21:56:48 +0800
Message-ID: <1317218208.8008.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Vladimir Barinov <vova.barinov@gmail.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Save model information in driver_data so we can simplify the implementation.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 0963c4c..597abb9 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1495,9 +1495,9 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
  */
 
 static const struct i2c_device_id aic3x_i2c_id[] = {
-	[AIC3X_MODEL_3X] = { "tlv320aic3x", 0 },
-	[AIC3X_MODEL_33] = { "tlv320aic33", 0 },
-	[AIC3X_MODEL_3007] = { "tlv320aic3007", 0 },
+	{ "tlv320aic3x", AIC3X_MODEL_3X },
+	{ "tlv320aic33", AIC3X_MODEL_33 },
+	{ "tlv320aic3007", AIC3X_MODEL_3007 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
@@ -1512,7 +1512,6 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	struct aic3x_pdata *pdata = i2c->dev.platform_data;
 	struct aic3x_priv *aic3x;
 	int ret;
-	const struct i2c_device_id *tbl;
 
 	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
 	if (aic3x == NULL) {
@@ -1531,11 +1530,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		aic3x->gpio_reset = -1;
 	}
 
-	for (tbl = aic3x_i2c_id; tbl->name[0]; tbl++) {
-		if (!strcmp(tbl->name, id->name))
-			break;
-	}
-	aic3x->model = tbl - aic3x_i2c_id;
+	aic3x->model = id->driver_data;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic3x, &aic3x_dai, 1);
-- 
1.7.4.1
