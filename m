From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: adav80x: Add module device table for
	adav801
Date: Mon, 01 Jul 2013 16:49:04 +0800
Message-ID: <1372668544.17974.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A14326506D
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 10:49:10 +0200 (CEST)
Received: by mail-pd0-f181.google.com with SMTP id 14so2460174pdj.12
 for <alsa-devel@alsa-project.org>; Mon, 01 Jul 2013 01:49:09 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This driver can be built as module, thus add module device table for adav801 to
support module auto loading.

To make the naming consistent, also rename adav80x_id to adav80x_i2c_id.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/adav80x.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 3c839cc..15b012d0 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -868,6 +868,12 @@ static int adav80x_bus_remove(struct device *dev)
 }
 
 #if defined(CONFIG_SPI_MASTER)
+static const struct spi_device_id adav80x_spi_id[] = {
+	{ "adav801", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adav80x_spi_id);
+
 static int adav80x_spi_probe(struct spi_device *spi)
 {
 	return adav80x_bus_probe(&spi->dev, SND_SOC_SPI);
@@ -885,15 +891,16 @@ static struct spi_driver adav80x_spi_driver = {
 	},
 	.probe		= adav80x_spi_probe,
 	.remove		= adav80x_spi_remove,
+	.id_table	= adav80x_spi_id,
 };
 #endif
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static const struct i2c_device_id adav80x_id[] = {
+static const struct i2c_device_id adav80x_i2c_id[] = {
 	{ "adav803", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, adav80x_id);
+MODULE_DEVICE_TABLE(i2c, adav80x_i2c_id);
 
 static int adav80x_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
@@ -913,7 +920,7 @@ static struct i2c_driver adav80x_i2c_driver = {
 	},
 	.probe = adav80x_i2c_probe,
 	.remove = adav80x_i2c_remove,
-	.id_table = adav80x_id,
+	.id_table = adav80x_i2c_id,
 };
 #endif
 
-- 
1.8.1.2
