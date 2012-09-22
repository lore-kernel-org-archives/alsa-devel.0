From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm2000: Convert to
	devm_regmap_init_i2c()
Date: Sat, 22 Sep 2012 18:35:38 -0400
Message-ID: <1348353339-11880-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0445226036F
 for <alsa-devel@alsa-project.org>; Sun, 23 Sep 2012 00:36:31 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 89cd6fc..6675477 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -760,7 +760,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 
 	dev_set_drvdata(&i2c->dev, wm2000);
 
-	wm2000->regmap = regmap_init_i2c(i2c, &wm2000_regmap);
+	wm2000->regmap = devm_regmap_init_i2c(i2c, &wm2000_regmap);
 	if (IS_ERR(wm2000->regmap)) {
 		ret = PTR_ERR(wm2000->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -777,7 +777,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	if (id != 0x2000) {
 		dev_err(&i2c->dev, "Device is not a WM2000 - ID %x\n", id);
 		ret = -ENODEV;
-		goto out_regmap_exit;
+		goto out;
 	}
 
 	reg = wm2000_read(i2c, WM2000_REG_REVISON);
@@ -796,7 +796,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	ret = request_firmware(&fw, filename, &i2c->dev);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to acquire ANC data: %d\n", ret);
-		goto out_regmap_exit;
+		goto out;
 	}
 
 	/* Pre-cook the concatenation of the register address onto the image */
@@ -807,7 +807,7 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	if (wm2000->anc_download == NULL) {
 		dev_err(&i2c->dev, "Out of memory\n");
 		ret = -ENOMEM;
-		goto out_regmap_exit;
+		goto out;
 	}
 
 	wm2000->anc_download[0] = 0x80;
@@ -825,8 +825,6 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	if (!ret)
 		goto out;
 
-out_regmap_exit:
-	regmap_exit(wm2000->regmap);
 out:
 	release_firmware(fw);
 	return ret;
@@ -834,10 +832,7 @@ out:
 
 static __devexit int wm2000_i2c_remove(struct i2c_client *i2c)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
-
 	snd_soc_unregister_codec(&i2c->dev);
-	regmap_exit(wm2000->regmap);
 
 	return 0;
 }
-- 
1.7.10.4
