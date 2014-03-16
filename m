From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] ASoC: tlv320aic31xx: Don't call kfree for
 memory allocated by devm_kzalloc
Date: Sun, 16 Mar 2014 23:06:25 +0800
Message-ID: <1394982385.19788.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
 [209.85.160.48])
 by alsa0.perex.cz (Postfix) with ESMTP id C253F2610A6
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 16:06:30 +0100 (CET)
Received: by mail-pb0-f48.google.com with SMTP id md12so4626520pbc.7
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 08:06:29 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The kfree call is not necessary, but we need to call snd_soc_unregister_codec()
in remove().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d3517a9..d5d6213 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1228,7 +1228,6 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	aic31xx->regmap = devm_regmap_init_i2c(i2c, regmap_config);
-
 	if (IS_ERR(aic31xx->regmap)) {
 		ret = PTR_ERR(aic31xx->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -1241,18 +1240,14 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 
 	aic31xx_device_init(aic31xx);
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_driver_aic31xx,
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_driver_aic31xx,
 				     aic31xx_dai_driver,
 				     ARRAY_SIZE(aic31xx_dai_driver));
-
-	return ret;
 }
 
 static int aic31xx_i2c_remove(struct i2c_client *i2c)
 {
-	struct aic31xx_priv *aic31xx = dev_get_drvdata(&i2c->dev);
-
-	kfree(aic31xx);
+	snd_soc_unregister_codec(&i2c->dev);
 	return 0;
 }
 
@@ -1274,7 +1269,7 @@ static struct i2c_driver aic31xx_i2c_driver = {
 		.of_match_table = of_match_ptr(tlv320aic31xx_of_match),
 	},
 	.probe		= aic31xx_i2c_probe,
-	.remove		= (aic31xx_i2c_remove),
+	.remove		= aic31xx_i2c_remove,
 	.id_table	= aic31xx_i2c_id,
 };
 
-- 
1.8.1.2
