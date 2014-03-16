From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Don't call kfree for
 memory allocated by devm_kzalloc
Date: Sun, 16 Mar 2014 22:57:45 +0800
Message-ID: <1394981865.19788.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id CA7B62610A6
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 15:57:51 +0100 (CET)
Received: by mail-pd0-f182.google.com with SMTP id y10so4497924pdj.41
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 07:57:50 -0700 (PDT)
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

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d3517a9..1953184 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1248,14 +1248,6 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int aic31xx_i2c_remove(struct i2c_client *i2c)
-{
-	struct aic31xx_priv *aic31xx = dev_get_drvdata(&i2c->dev);
-
-	kfree(aic31xx);
-	return 0;
-}
-
 static const struct i2c_device_id aic31xx_i2c_id[] = {
 	{ "tlv320aic310x", AIC3100 },
 	{ "tlv320aic311x", AIC3110 },
@@ -1274,7 +1266,6 @@ static struct i2c_driver aic31xx_i2c_driver = {
 		.of_match_table = of_match_ptr(tlv320aic31xx_of_match),
 	},
 	.probe		= aic31xx_i2c_probe,
-	.remove		= (aic31xx_i2c_remove),
 	.id_table	= aic31xx_i2c_id,
 };
 
-- 
1.8.1.2
