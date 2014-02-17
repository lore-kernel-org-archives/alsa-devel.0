From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: adav80x: Use devm_kzalloc()
Date: Mon, 17 Feb 2014 13:16:55 +0100
Message-ID: <1392639416-11293-3-git-send-email-lars@metafoo.de>
References: <1392639416-11293-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-011.synserver.de (smtp-out-234.synserver.de
 [212.40.185.234])
 by alsa0.perex.cz (Postfix) with ESMTP id D3624261A8E
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 13:16:47 +0100 (CET)
In-Reply-To: <1392639416-11293-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use devm_kzalloc() to allocate the device state struct. Saves use from having to
free it manually on the error path and in the remove callback.

Now that the adav80x_bus_probe() function is only a call to
snd_soc_unregister_codec() also inline that.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adav80x.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index f78b27a..a4bd051 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -872,27 +872,15 @@ static int adav80x_bus_probe(struct device *dev, struct regmap *regmap)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	adav80x = kzalloc(sizeof(*adav80x), GFP_KERNEL);
+	adav80x = devm_kzalloc(dev, sizeof(*adav80x), GFP_KERNEL);
 	if (!adav80x)
 		return -ENOMEM;
 
-
 	dev_set_drvdata(dev, adav80x);
 	adav80x->regmap = regmap;
 
-	ret = snd_soc_register_codec(dev, &adav80x_codec_driver,
+	return snd_soc_register_codec(dev, &adav80x_codec_driver,
 		adav80x_dais, ARRAY_SIZE(adav80x_dais));
-	if (ret)
-		kfree(adav80x);
-
-	return ret;
-}
-
-static int adav80x_bus_remove(struct device *dev)
-{
-	snd_soc_unregister_codec(dev);
-	kfree(dev_get_drvdata(dev));
-	return 0;
 }
 
 #if defined(CONFIG_SPI_MASTER)
@@ -923,7 +911,8 @@ static int adav80x_spi_probe(struct spi_device *spi)
 
 static int adav80x_spi_remove(struct spi_device *spi)
 {
-	return adav80x_bus_remove(&spi->dev);
+	snd_soc_unregister_codec(dev);
+	return 0;
 }
 
 static struct spi_driver adav80x_spi_driver = {
@@ -965,7 +954,8 @@ static int adav80x_i2c_probe(struct i2c_client *client,
 
 static int adav80x_i2c_remove(struct i2c_client *client)
 {
-	return adav80x_bus_remove(&client->dev);
+	snd_soc_unregister_codec(dev);
+	return 0;
 }
 
 static struct i2c_driver adav80x_i2c_driver = {
-- 
1.8.0
