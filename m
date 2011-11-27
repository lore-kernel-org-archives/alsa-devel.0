From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM8962 to devm_kzalloc()
Date: Sun, 27 Nov 2011 21:30:58 +0000
Message-ID: <1322429458-28376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A28BD103858
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 22:31:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@tic.om>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e01232f..1ec7271 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -4182,7 +4182,8 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 	unsigned int reg;
 	int ret, i;
 
-	wm8962 = kzalloc(sizeof(struct wm8962_priv), GFP_KERNEL);
+	wm8962 = devm_kzalloc(&i2c->dev, sizeof(struct wm8962_priv),
+			      GFP_KERNEL);
 	if (wm8962 == NULL)
 		return -ENOMEM;
 
@@ -4199,7 +4200,7 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 				 wm8962->supplies);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
-		goto err_alloc;
+		goto err;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8962->supplies),
@@ -4273,8 +4274,7 @@ err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 err_get:
 	regulator_bulk_free(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
-err_alloc:
-	kfree(wm8962);
+err:
 	return ret;
 }
 
@@ -4285,7 +4285,6 @@ static __devexit int wm8962_i2c_remove(struct i2c_client *client)
 	snd_soc_unregister_codec(&client->dev);
 	regmap_exit(wm8962->regmap);
 	regulator_bulk_free(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.7.3
