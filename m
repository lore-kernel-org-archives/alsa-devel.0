From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Strip -codec from I2C and SPI driver
	names
Date: Wed, 29 Sep 2010 22:20:26 -0700
Message-ID: <1285824027-897-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B21A1038F7
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 07:20:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This was the result of cross-tree multi-component changes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/playpaq_wm8510.c               |    2 +-
 sound/soc/atmel/sam9g20_wm8731.c               |    2 +-
 sound/soc/atmel/snd-soc-afeb9260.c             |    2 +-
 sound/soc/blackfin/bf5xx-ad1836.c              |    2 +-
 sound/soc/blackfin/bf5xx-ad193x.c              |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c             |    2 +-
 sound/soc/codecs/ad1836.c                      |    2 +-
 sound/soc/codecs/ad193x.c                      |    4 ++--
 sound/soc/codecs/ak4104.c                      |    2 +-
 sound/soc/codecs/ak4535.c                      |    2 +-
 sound/soc/codecs/ak4642.c                      |    2 +-
 sound/soc/codecs/ak4671.c                      |    2 +-
 sound/soc/codecs/cs4270.c                      |    2 +-
 sound/soc/codecs/cs42l51.c                     |    2 +-
 sound/soc/codecs/da7210.c                      |    2 +-
 sound/soc/codecs/ssm2602.c                     |    2 +-
 sound/soc/codecs/tlv320aic23.c                 |    2 +-
 sound/soc/codecs/tlv320aic26.c                 |    2 +-
 sound/soc/codecs/tlv320aic3x.c                 |    2 +-
 sound/soc/codecs/tlv320dac33.c                 |    2 +-
 sound/soc/codecs/uda134x.c                     |    2 +-
 sound/soc/codecs/uda1380.c                     |    2 +-
 sound/soc/codecs/wm8510.c                      |    2 +-
 sound/soc/codecs/wm8523.c                      |    2 +-
 sound/soc/codecs/wm8727.c                      |    2 +-
 sound/soc/codecs/wm8728.c                      |    4 ++--
 sound/soc/codecs/wm8731.c                      |    4 ++--
 sound/soc/codecs/wm8741.c                      |    2 +-
 sound/soc/codecs/wm8750.c                      |    4 ++--
 sound/soc/codecs/wm8753.c                      |    4 ++--
 sound/soc/codecs/wm8776.c                      |    4 ++--
 sound/soc/codecs/wm8900.c                      |    2 +-
 sound/soc/codecs/wm8903.c                      |    2 +-
 sound/soc/codecs/wm8904.c                      |    2 +-
 sound/soc/codecs/wm8940.c                      |    2 +-
 sound/soc/codecs/wm8955.c                      |    2 +-
 sound/soc/codecs/wm8960.c                      |    2 +-
 sound/soc/codecs/wm8961.c                      |    2 +-
 sound/soc/codecs/wm8971.c                      |    2 +-
 sound/soc/codecs/wm8974.c                      |    2 +-
 sound/soc/codecs/wm8988.c                      |    2 +-
 sound/soc/codecs/wm8990.c                      |    2 +-
 sound/soc/codecs/wm8993.c                      |    2 +-
 sound/soc/codecs/wm9081.c                      |    2 +-
 sound/soc/ep93xx/snappercl15.c                 |    2 +-
 sound/soc/fsl/mpc8610_hpcd.c                   |    4 ++--
 sound/soc/fsl/p1022_ds.c                       |    4 ++--
 sound/soc/imx/eukrea-tlv320.c                  |    2 +-
 sound/soc/kirkwood/kirkwood-openrd.c           |    2 +-
 sound/soc/omap/am3517evm.c                     |    2 +-
 sound/soc/omap/n810.c                          |    2 +-
 sound/soc/omap/osk5912.c                       |    2 +-
 sound/soc/omap/rx51.c                          |    2 +-
 sound/soc/pxa/imote2.c                         |    2 +-
 sound/soc/pxa/magician.c                       |    4 ++--
 sound/soc/pxa/poodle.c                         |    2 +-
 sound/soc/pxa/raumfeld.c                       |    4 ++--
 sound/soc/pxa/spitz.c                          |    2 +-
 sound/soc/pxa/z2.c                             |    2 +-
 sound/soc/s3c24xx/jive_wm8750.c                |    2 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |    4 ++--
 sound/soc/s3c24xx/neo1973_wm8753.c             |    4 ++--
 sound/soc/s3c24xx/rx1950_uda1380.c             |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |    2 +-
 sound/soc/s3c24xx/smartq_wm8987.c              |    2 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |    4 ++--
 sound/soc/s6000/s6105-ipcam.c                  |    2 +-
 sound/soc/sh/fsi-ak4642.c                      |    4 ++--
 sound/soc/sh/fsi-da7210.c                      |    2 +-
 70 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index 5f4e59f..9d545f2 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -356,7 +356,7 @@ static struct snd_soc_dai_link playpaq_wm8510_dai = {
 	.stream_name = "WM8510 PCM",
 	.cpu_dai_name= "atmel-ssc-dai.0",
 	.platform_name = "atmel-pcm-audio",
-	.codec_name = "wm8510-codec.0-0x1a",
+	.codec_name = "wm8510.0-0x1a",
 	.codec_dai_name = "wm8510-hifi",
 	.init = playpaq_wm8510_init,
 	.ops = &playpaq_wm8510_ops,
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 293569d..eaafbfc 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -184,7 +184,7 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
 	.platform_name = "atmel-pcm-audio",
-	.codec_name = "wm8731-codec.0-001b",
+	.codec_name = "wm8731.0-001b",
 	.ops = &at91sam9g20ek_ops,
 };
 
diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index e3d2835..ff6499b 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -129,7 +129,7 @@ static struct snd_soc_dai_link afeb9260_dai = {
 	.cpu_dai_name = "atmel-ssc-dai.0",
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "atmel_pcm-audio",
-	.codec_name = "tlv320aic23-codec.0-0x1a",
+	.codec_name = "tlv320aic23.0-0x1a",
 	.init = afeb9260_tlv320aic23_init,
 	.ops = &afeb9260_ops,
 };
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 2394bff..9738269 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -86,7 +86,7 @@ static struct snd_soc_dai_link bf5xx_ad1836_dai = {
 	.cpu_dai_name = "bf5xx-tdm",
 	.codec_dai_name = "ad1836-hifi",
 	.platform_name = "bf5xx-tdm-pcm-audio",
-	.codec_name = "ad1836-codec.0",
+	.codec_name = "ad1836.0",
 	.ops = &bf5xx_ad1836_ops,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index e4a6253..fd06fee 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -100,7 +100,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai = {
 	.cpu_dai_name = "bf5xx-tdm",
 	.codec_dai_name ="ad193x-hifi",
 	.platform_name = "bf5xx-tdm-pcm-audio",
-	.codec_name = "ad193x-codec.5",
+	.codec_name = "ad193x.5",
 	.ops = &bf5xx_ad193x_ops,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 36f2769..e1fda9b 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -120,7 +120,7 @@ static struct snd_soc_dai_link bf5xx_ssm2602_dai = {
 	.cpu_dai_name = "bf5xx-i2s",
 	.codec_dai_name = "ssm2602-hifi",
 	.platform_name = "bf5xx-pcm-audio",
-	.codec_name = "ssm2602-codec.0-0x1b",
+	.codec_name = "ssm2602.0-0x1b",
 	.ops = &bf5xx_ssm2602_ops,
 };
 
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index d272534..27b6ed4 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -307,7 +307,7 @@ static int __devexit ad1836_spi_remove(struct spi_device *spi)
 
 static struct spi_driver ad1836_spi_driver = {
 	.driver = {
-		.name	= "ad1836-codec",
+		.name	= "ad1836",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad1836_spi_probe,
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index fa2834c..28b49de 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -429,7 +429,7 @@ static int __devexit ad193x_spi_remove(struct spi_device *spi)
 
 static struct spi_driver ad193x_spi_driver = {
 	.driver = {
-		.name	= "ad193x-codec",
+		.name	= "ad193x",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad193x_spi_probe,
@@ -475,7 +475,7 @@ static int __devexit ad193x_i2c_remove(struct i2c_client *client)
 
 static struct i2c_driver ad193x_i2c_driver = {
 	.driver = {
-		.name = "ad193x-codec",
+		.name = "ad193x",
 	},
 	.probe    = ad193x_i2c_probe,
 	.remove   = __devexit_p(ad193x_i2c_remove),
diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index c27f8f5..0cf17b3 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -43,7 +43,7 @@
 #define AK4104_TX_TXE			(1 << 0)
 #define AK4104_TX_V			(1 << 1)
 
-#define DRV_NAME "ak4104-codec"
+#define DRV_NAME "ak4104"
 
 struct ak4104_private {
 	enum snd_soc_control_type control_type;
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index cd88c8f..41e90a9 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -519,7 +519,7 @@ MODULE_DEVICE_TABLE(i2c, ak4535_i2c_id);
 
 static struct i2c_driver ak4535_i2c_driver = {
 	.driver = {
-		.name = "ak4535-codec",
+		.name = "ak4535",
 		.owner = THIS_MODULE,
 	},
 	.probe =    ak4535_i2c_probe,
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index a95ff4f..775a003 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -478,7 +478,7 @@ MODULE_DEVICE_TABLE(i2c, ak4642_i2c_id);
 
 static struct i2c_driver ak4642_i2c_driver = {
 	.driver = {
-		.name = "ak4642-codec",
+		.name = "ak4642",
 		.owner = THIS_MODULE,
 	},
 	.probe		= ak4642_i2c_probe,
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 24f5f49..46e03ec 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -709,7 +709,7 @@ MODULE_DEVICE_TABLE(i2c, ak4671_i2c_id);
 
 static struct i2c_driver ak4671_i2c_driver = {
 	.driver = {
-		.name = "ak4671-codec",
+		.name = "ak4671",
 		.owner = THIS_MODULE,
 	},
 	.probe = ak4671_i2c_probe,
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 5fd8e0d..944124f 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -799,7 +799,7 @@ MODULE_DEVICE_TABLE(i2c, cs4270_id);
  */
 static struct i2c_driver cs4270_i2c_driver = {
 	.driver = {
-		.name = "cs4270-codec",
+		.name = "cs4270",
 		.owner = THIS_MODULE,
 	},
 	.id_table = cs4270_id,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index cb086ea..fef7383 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -622,7 +622,7 @@ MODULE_DEVICE_TABLE(i2c, cs42l51_id);
 
 static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
-		.name = "cs42l51-codec",
+		.name = "cs42l51",
 		.owner = THIS_MODULE,
 	},
 	.id_table = cs42l51_id,
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 58bb9b9..cbc6e95 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -594,7 +594,7 @@ MODULE_DEVICE_TABLE(i2c, da7210_i2c_id);
 /* I2C codec control layer */
 static struct i2c_driver da7210_i2c_driver = {
 	.driver = {
-		.name = "da7210-codec",
+		.name = "da7210",
 		.owner = THIS_MODULE,
 	},
 	.probe		= da7210_i2c_probe,
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 6f38d61..0d17b6c 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -651,7 +651,7 @@ MODULE_DEVICE_TABLE(i2c, ssm2602_i2c_id);
 /* corgi i2c codec control layer */
 static struct i2c_driver ssm2602_i2c_driver = {
 	.driver = {
-		.name = "ssm2602-codec",
+		.name = "ssm2602",
 		.owner = THIS_MODULE,
 	},
 	.probe = ssm2602_i2c_probe,
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index e8652b1..ddd56c5 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -744,7 +744,7 @@ MODULE_DEVICE_TABLE(i2c, tlv320aic23_id);
 
 static struct i2c_driver tlv320aic23_i2c_driver = {
 	.driver = {
-		   .name = "tlv320aic23-codec",
+		   .name = "tlv320aic23",
 		   },
 	.probe = tlv320aic23_codec_probe,
 	.remove = __exit_p(tlv320aic23_i2c_remove),
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 6b7d71e..7b00237 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -439,7 +439,7 @@ static int aic26_spi_remove(struct spi_device *spi)
 
 static struct spi_driver aic26_spi = {
 	.driver = {
-		.name = "tlv320aic26-codec",
+		.name = "tlv320aic26",
 		.owner = THIS_MODULE,
 	},
 	.probe = aic26_spi_probe,
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index fc68779..e0ab55d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1516,7 +1516,7 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 /* machine i2c codec control layer */
 static struct i2c_driver aic3x_i2c_driver = {
 	.driver = {
-		.name = "tlv320aic3x-codec",
+		.name = "tlv320aic3x",
 		.owner = THIS_MODULE,
 	},
 	.probe	= aic3x_i2c_probe,
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index bf6d01f..67b3cd7 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1608,7 +1608,7 @@ static const struct i2c_device_id tlv320dac33_i2c_id[] = {
 
 static struct i2c_driver tlv320dac33_i2c_driver = {
 	.driver = {
-		.name = "tlv320dac33-codec",
+		.name = "tlv320dac33",
 		.owner = THIS_MODULE,
 	},
 	.probe		= dac33_i2c_probe,
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 7540a50..51e6568 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -619,7 +619,7 @@ static int __devexit uda134x_codec_remove(struct platform_device *pdev)
 
 static struct platform_driver uda134x_codec_driver = {
 	.driver = {
-		.name = "uda134x-codec",
+		.name = "uda134x",
 		.owner = THIS_MODULE,
 	},
 	.probe = uda134x_codec_probe,
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 0c6c725..44adb96 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -853,7 +853,7 @@ MODULE_DEVICE_TABLE(i2c, uda1380_i2c_id);
 
 static struct i2c_driver uda1380_i2c_driver = {
 	.driver = {
-		.name =  "uda1380-codec",
+		.name =  "uda1380",
 		.owner = THIS_MODULE,
 	},
 	.probe =    uda1380_i2c_probe,
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 02ecf54..1174ca7 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -670,7 +670,7 @@ MODULE_DEVICE_TABLE(i2c, wm8510_i2c_id);
 
 static struct i2c_driver wm8510_i2c_driver = {
 	.driver = {
-		.name = "wm8510-codec",
+		.name = "wm8510",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8510_i2c_probe,
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 712ef7c..14967f7 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -551,7 +551,7 @@ MODULE_DEVICE_TABLE(i2c, wm8523_i2c_id);
 
 static struct i2c_driver wm8523_i2c_driver = {
 	.driver = {
-		.name = "wm8523-codec",
+		.name = "wm8523",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8523_i2c_probe,
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index 7488082..27bcb79 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -59,7 +59,7 @@ static int __devexit wm8727_remove(struct platform_device *pdev)
 
 static struct platform_driver wm8727_codec_driver = {
 	.driver = {
-			.name = "wm8727-codec",
+			.name = "wm8727",
 			.owner = THIS_MODULE,
 	},
 
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 32eba85..f619eba 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -306,7 +306,7 @@ static int __devexit wm8728_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8728_spi_driver = {
 	.driver = {
-		.name	= "wm8728-codec",
+		.name	= "wm8728",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
@@ -351,7 +351,7 @@ MODULE_DEVICE_TABLE(i2c, wm8728_i2c_id);
 
 static struct i2c_driver wm8728_i2c_driver = {
 	.driver = {
-		.name = "wm8728-codec",
+		.name = "wm8728",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8728_i2c_probe,
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index bdce125..7039b83 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -599,7 +599,7 @@ static int __devexit wm8731_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8731_spi_driver = {
 	.driver = {
-		.name	= "wm8731-codec",
+		.name	= "wm8731",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
@@ -644,7 +644,7 @@ MODULE_DEVICE_TABLE(i2c, wm8731_i2c_id);
 
 static struct i2c_driver wm8731_i2c_driver = {
 	.driver = {
-		.name = "wm8731-codec",
+		.name = "wm8731",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8731_i2c_probe,
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 90e31e9..136c64c 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -523,7 +523,7 @@ MODULE_DEVICE_TABLE(i2c, wm8741_i2c_id);
 
 static struct i2c_driver wm8741_i2c_driver = {
 	.driver = {
-		.name = "wm8741-codec",
+		.name = "wm8741",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8741_i2c_probe,
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 4d1ec9d..75136cc 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -781,7 +781,7 @@ static int __devexit wm8750_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8750_spi_driver = {
 	.driver = {
-		.name	= "wm8750-codec",
+		.name	= "wm8750",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
@@ -827,7 +827,7 @@ MODULE_DEVICE_TABLE(i2c, wm8750_i2c_id);
 
 static struct i2c_driver wm8750_i2c_driver = {
 	.driver = {
-		.name = "wm8750-codec",
+		.name = "wm8750",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8750_i2c_probe,
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 64ea066..a59608c 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1650,7 +1650,7 @@ static int __devexit wm8753_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8753_spi_driver = {
 	.driver = {
-		.name	= "wm8753-codec",
+		.name	= "wm8753",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
@@ -1695,7 +1695,7 @@ MODULE_DEVICE_TABLE(i2c, wm8753_i2c_id);
 
 static struct i2c_driver wm8753_i2c_driver = {
 	.driver = {
-		.name = "wm8753-codec",
+		.name = "wm8753",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8753_i2c_probe,
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index c0b6917..7c032ab 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -482,7 +482,7 @@ static int __devexit wm8776_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8776_spi_driver = {
 	.driver = {
-		.name	= "wm8776-codec",
+		.name	= "wm8776",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
@@ -527,7 +527,7 @@ MODULE_DEVICE_TABLE(i2c, wm8776_i2c_id);
 
 static struct i2c_driver wm8776_i2c_driver = {
 	.driver = {
-		.name = "wm8776-codec",
+		.name = "wm8776",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8776_i2c_probe,
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 25c8ccd..f39563a 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1290,7 +1290,7 @@ static int __devexit wm8900_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8900_spi_driver = {
 	.driver = {
-		.name	= "wm8900-codec",
+		.name	= "wm8900",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 622b602..aab6040 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1801,7 +1801,7 @@ MODULE_DEVICE_TABLE(i2c, wm8903_i2c_id);
 
 static struct i2c_driver wm8903_i2c_driver = {
 	.driver = {
-		.name = "wm8903-codec",
+		.name = "wm8903",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8903_i2c_probe,
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 33be84e..1039d4c 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2553,7 +2553,7 @@ MODULE_DEVICE_TABLE(i2c, wm8904_i2c_id);
 
 static struct i2c_driver wm8904_i2c_driver = {
 	.driver = {
-		.name = "wm8904-codec",
+		.name = "wm8904",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8904_i2c_probe,
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 2cb16f8..380c171 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -791,7 +791,7 @@ MODULE_DEVICE_TABLE(i2c, wm8940_i2c_id);
 
 static struct i2c_driver wm8940_i2c_driver = {
 	.driver = {
-		.name = "wm8940-codec",
+		.name = "wm8940",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8940_i2c_probe,
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index f89ad6c..84dcfb5 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -1025,7 +1025,7 @@ MODULE_DEVICE_TABLE(i2c, wm8955_i2c_id);
 
 static struct i2c_driver wm8955_i2c_driver = {
 	.driver = {
-		.name = "wm8955-codec",
+		.name = "wm8955",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8955_i2c_probe,
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 8d5efb3..ecc50c9 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1036,7 +1036,7 @@ MODULE_DEVICE_TABLE(i2c, wm8960_i2c_id);
 
 static struct i2c_driver wm8960_i2c_driver = {
 	.driver = {
-		.name = "wm8960-codec",
+		.name = "wm8960",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8960_i2c_probe,
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 4f326f6..39cd5eb 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1116,7 +1116,7 @@ MODULE_DEVICE_TABLE(i2c, wm8961_i2c_id);
 
 static struct i2c_driver wm8961_i2c_driver = {
 	.driver = {
-		.name = "wm8961-codec",
+		.name = "wm8961",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8961_i2c_probe,
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 63f6dbf..86ac400 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -742,7 +742,7 @@ MODULE_DEVICE_TABLE(i2c, wm8971_i2c_id);
 
 static struct i2c_driver wm8971_i2c_driver = {
 	.driver = {
-		.name = "wm8971-codec",
+		.name = "wm8971",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8971_i2c_probe,
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index b4363f6..89d5ba1 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -682,7 +682,7 @@ MODULE_DEVICE_TABLE(i2c, wm8974_i2c_id);
 
 static struct i2c_driver wm8974_i2c_driver = {
 	.driver = {
-		.name = "wm8974-codec",
+		.name = "wm8974",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8974_i2c_probe,
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index d08b1fe..02a5c36 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -843,7 +843,7 @@ static int __devexit wm8988_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8988_spi_driver = {
 	.driver = {
-		.name	= "wm8988-codec",
+		.name	= "wm8988",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 264828e..bd52c24 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1429,7 +1429,7 @@ MODULE_DEVICE_TABLE(i2c, wm8990_i2c_id);
 
 static struct i2c_driver wm8990_i2c_driver = {
 	.driver = {
-		.name = "wm8990-codec",
+		.name = "wm8990",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8990_i2c_probe,
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 589e3fa..65563fb 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1627,7 +1627,7 @@ MODULE_DEVICE_TABLE(i2c, wm8993_i2c_id);
 
 static struct i2c_driver wm8993_i2c_driver = {
 	.driver = {
-		.name = "wm8993-codec",
+		.name = "wm8993",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8993_i2c_probe,
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index ecc7c37..87404fd 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1359,7 +1359,7 @@ MODULE_DEVICE_TABLE(i2c, wm9081_i2c_id);
 
 static struct i2c_driver wm9081_i2c_driver = {
 	.driver = {
-		.name = "wm9081-codec",
+		.name = "wm9081",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm9081_i2c_probe,
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index 28ab5ff..16a8d63 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -92,7 +92,7 @@ static struct snd_soc_dai_link snappercl15_dai = {
 	.stream_name	= "AIC23",
 	.cpu_dai_name	= "ep93xx-i2s",
 	.codec_dai_name	= "tlv320aic23-hifi",
-	.codec_name	= "tlv320aic23-codec.0-001a",
+	.codec_name	= "tlv320aic23.0-001a",
 	.platform_name	=  "ep93xx-pcm-audio",
 	.init		= snappercl15_tlv320aic23_init,
 	.ops		= &snappercl15_ops,
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 0d7dcf1..5a37099 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -246,7 +246,7 @@ static int get_parent_cell_index(struct device_node *np)
  * 'struct device'  It's ugly and hackish, but it works.
  *
  * The dev_name for such devices include the bus number and I2C address. For
- * example, "cs4270-codec.0-004f".
+ * example, "cs4270.0-004f".
  */
 static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 {
@@ -266,7 +266,7 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 	if (bus < 0)
 		return bus;
 
-	snprintf(buf, len, "%s-codec.%u-%04x", temp, bus, addr);
+	snprintf(buf, len, "%s.%u-%04x", temp, bus, addr);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 63b9eaa..e855863 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -249,7 +249,7 @@ static int get_parent_cell_index(struct device_node *np)
  * 'struct device'  It's ugly and hackish, but it works.
  *
  * The dev_name for such devices include the bus number and I2C address. For
- * example, "cs4270-codec.0-004f".
+ * example, "cs4270.0-004f".
  */
 static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 {
@@ -269,7 +269,7 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 	if (bus < 0)
 		return bus;
 
-	snprintf(buf, len, "%s-codec.%u-%04x", temp, bus, addr);
+	snprintf(buf, len, "%s.%u-%04x", temp, bus, addr);
 
 	return 0;
 }
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index 807f736..09406c9 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -81,7 +81,7 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.stream_name	= "TLV320AIC23",
 	.codec_dai	= "tlv320aic23-hifi",
 	.platform_name	= "imx-pcm-audio.0",
-	.codec_name	= "tlv320aic23-codec.0-001a",
+	.codec_name	= "tlv320aic23.0-001a",
 	.cpu_dai = "imx-ssi-dai.0",
 	.ops		= &eukrea_tlv320_snd_ops,
 };
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 9d7c81e..d6d90a6 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -68,7 +68,7 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 	.cpu_dai_name = "kirkwood-i2s",
 	.platform_name = "kirkwood-pcm-audio",
 	.codec_dai_name = "cs42l51-hifi",
-	.codec_name = "cs42l51-codec.0-004a",
+	.codec_name = "cs42l51.0-004a",
 	.ops = &openrd_client_ops,
 },
 };
diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 68bd902..59f3d10 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -139,7 +139,7 @@ static struct snd_soc_dai_link am3517evm_dai = {
 	.cpu_dai_name ="omap-mcbsp-dai.0",
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "omap-pcm-audio",
-	.codec_name = "tlv320aic23-codec",
+	.codec_name = "tlv320aic23",
 	.init = am3517evm_aic23_init,
 	.ops = &am3517evm_ops,
 };
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index a3b6d89..f98e8eb 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -310,7 +310,7 @@ static struct snd_soc_dai_link n810_dai = {
 	.stream_name = "AIC33",
 	.cpu_dai_name = "omap-mcbsp-dai.1",
 	.platform_name = "omap-pcm-audio",
-	.codec_name = "tlv320aic3x-codec.2-0018",
+	.codec_name = "tlv320aic3x.2-0018",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.init = n810_aic33_init,
 	.ops = &n810_ops,
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index f0e6625..60bb76a 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -140,7 +140,7 @@ static struct snd_soc_dai_link osk_dai = {
 	.cpu_dai_name = "omap-mcbsp-dai.0",
 	.codec_dai_name = "tlv320aic23-hifi",
 	.platform_name = "omap-pcm-audio",
-	.codec_name = "tlv320aic23-codec",
+	.codec_name = "tlv320aic23",
 	.init = osk_tlv320aic23_init,
 	.ops = &osk_ops,
 };
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 04b5723..e3eb0ef 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -286,7 +286,7 @@ static struct snd_soc_dai_link rx51_dai[] = {
 		.cpu_dai_name = "omap-mcbsp-dai.1",
 		.codec_dai_name = "tlv320aic3x-hifi",
 		.platform_name = "omap-pcm-audio",
-		.codec_name = "tlv320aic3x-codec.2-0018",
+		.codec_name = "tlv320aic3x.2-0018",
 		.init = rx51_aic34_init,
 		.ops = &rx51_ops,
 	},
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index 154fc6f..ecac0e3 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -66,7 +66,7 @@ static struct snd_soc_dai_link imote2_dai = {
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8940-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8940-codec.0-0034",
+	.codec_name = "wm8940.0-0034",
 	.ops = &imote2_asoc_ops,
 };
 
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index b8207ce..06ce144 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -430,7 +430,7 @@ static struct snd_soc_dai_link magician_dai[] = {
 	.cpu_dai_name = "pxa-ssp-dai.0",
 	.codec_dai_name = "uda1380-hifi-playback",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "uda1380-codec.0-0018",
+	.codec_name = "uda1380.0-0018",
 	.init = magician_uda1380_init,
 	.ops = &magician_playback_ops,
 },
@@ -440,7 +440,7 @@ static struct snd_soc_dai_link magician_dai[] = {
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "uda1380-hifi-capture",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "uda1380-codec.0-0018",
+	.codec_name = "uda1380.0-0018",
 	.ops = &magician_capture_ops,
 }
 };
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index af84ee9..5410f2f 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -269,7 +269,7 @@ static struct snd_soc_dai_link poodle_dai = {
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8731-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8731-codec.0-001a",
+	.codec_name = "wm8731.0-001a",
 	.init = poodle_wm8731_init,
 	.ops = &poodle_ops,
 };
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 2cda82b..d9904b6 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -234,7 +234,7 @@ static struct snd_soc_dai_link raumfeld_dai[] = {
 	.codec_dai_name = "ak4104-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.ops		= &raumfeld_ak4104_ops,
-	.codec_name = "ak4104-codec.0",
+	.codec_name = "ak4104.0",
 },
 {
 	.name		= "CS4270",
@@ -242,7 +242,7 @@ static struct snd_soc_dai_link raumfeld_dai[] = {
 	.cpu_dai_name = "pxa-ssp-dai.0",
 	.platform_name = "pxa-pcm-audio",
 	.codec_dai_name = "cs4270-hifi",
-	.codec_name = "cs4270-codec.0-0048",
+	.codec_name = "cs4270.0-0048",
 	.ops		= &raumfeld_cs4270_ops,
 },};
 
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index f470f36..582cb7e 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -311,7 +311,7 @@ static struct snd_soc_dai_link spitz_dai = {
 	.cpu_dai_name = "pxa-is2",
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8750-codec.0-001a",
+	.codec_name = "wm8750.0-001a",
 	.init = spitz_wm8750_init,
 	.ops = &spitz_ops,
 };
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 4cc841b..7dabeb9 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -192,7 +192,7 @@ static struct snd_soc_dai_link z2_dai = {
 	.cpu_dai_name	= "pxa2xx-i2s",
 	.codec_dai_name	= "wm8750-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name	= "wm8750-codec.0-001a",
+	.codec_name	= "wm8750.0-001a",
 	.init		= z2_wm8750_init,
 	.ops		= &z2_ops,
 };
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 49605cd..5f3ab8b 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -142,7 +142,7 @@ static struct snd_soc_dai_link jive_dai = {
 	.cpu_dai_name	= "s3c2412-i2s",
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
-	.codec_name	= "wm8750-codec.0-0x1a",
+	.codec_name	= "wm8750.0-0x1a",
 	.init		= jive_wm8750_init,
 	.ops		= &jive_ops,
 };
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index c457bfd..08b9ef7 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -401,7 +401,7 @@ static struct snd_soc_dai_link neo1973_gta02_dai[] = {
 	.codec_dai_name = "wm8753-hifi",
 	.init = neo1973_gta02_wm8753_init,
 	.platform_name = "s3c24xx-pcm-audio",
-	.codec_name = "wm8753-codec.0-0x1a",
+	.codec_name = "wm8753.0-0x1a",
 	.ops = &neo1973_gta02_hifi_ops,
 },
 { /* Voice via BT */
@@ -410,7 +410,7 @@ static struct snd_soc_dai_link neo1973_gta02_dai[] = {
 	.cpu_dai_name = "bluetooth-dai",
 	.codec_dai_name = "wm8753-voice",
 	.ops = &neo1973_gta02_voice_ops,
-	.codec_name = "wm8753-codec.0-0x1a",
+	.codec_name = "wm8753.0-0x1a",
 	.platform_name = "s3c24xx-pcm-audio",
 },
 };
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index d7a39a0..dd3fae2 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -559,7 +559,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.platform_name = "s3c24xx-pcm-audio",
 	.cpu_dai_name = "s3c24xx-i2s",
 	.codec_dai_name = "wm8753-hifi",
-	.codec_name = "wm8753-codec.0-0x1a",
+	.codec_name = "wm8753.0-0x1a",
 	.init = neo1973_wm8753_init,
 	.ops = &neo1973_hifi_ops,
 },
@@ -569,7 +569,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 	.platform_name = "s3c24xx-pcm-audio",
 	.cpu_dai_name = "bluetooth-dai",
 	.codec_dai_name = "wm8753-voice",
-	.codec_name = "wm8753-codec.0-0x1a",
+	.codec_name = "wm8753.0-0x1a",
 	.ops = &neo1973_voice_ops,
 },
 };
diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index ffd5cf2..c390907 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -97,7 +97,7 @@ static struct snd_soc_dai_link rx1950_uda1380_dai[] = {
 		.codec_dai_name	= "uda1380-hifi",
 		.init		= rx1950_uda1380_init,
 		.platform_name	= "s3c24xx-pcm-audio",
-		.codec_name	= "uda1380-codec.0-001a",
+		.codec_name	= "uda1380.0-001a",
 		.ops		= &rx1950_ops,
 	},
 };
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index f884537..6ad2144 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -96,7 +96,7 @@ static int simtec_hermes_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link simtec_dai_aic33 = {
 	.name		= "tlv320aic33",
 	.stream_name	= "TLV320AIC33",
-	.codec_name	= "tlv320aic3x-codec.0-0x1a",
+	.codec_name	= "tlv320aic3x.0-0x1a",
 	.cpu_dai_name	= "s3c24xx-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index c096759..7fd1b2a 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -85,7 +85,7 @@ static int simtec_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link simtec_dai_aic23 = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
-	.codec_name	= "tlv320aic3x-codec.0-0x1a",
+	.codec_name	= "tlv320aic3x.0-0x1a",
 	.cpu_dai_name	= "s3c24xx-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.platform_name	= "s3c24xx-pcm-audio",
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index dd20ca7..f63dab9 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -214,7 +214,7 @@ static struct snd_soc_dai_link smartq_dai[] = {
 		.cpu_dai_name	= "s3c64xx-i2s.0",
 		.codec_dai_name	= "wm8750-hifi",
 		.platform_name	= "s3c24xx-pcm-audio",
-		.codec_name	= "wm8750-codec.0-0x1a",
+		.codec_name	= "wm8750.0-0x1a",
 		.init		= smartq_wm8987_init,
 		.ops		= &smartq_hifi_ops,
 	},
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 052e499..cd27727 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -225,7 +225,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 	.cpu_dai_name = "s3c64xx-iis-v4",
 	.codec_dai_name = "wm8580-hifi-playback",
 	.platform_name = "s3c24xx-pcm-audio",
-	.codec_name = "wm8580-codec.0-001b",
+	.codec_name = "wm8580.0-001b",
 	.init = smdk64xx_wm8580_init_paifrx,
 	.ops = &smdk64xx_ops,
 },
@@ -235,7 +235,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 	.cpu_dai_name = "s3c64xx-iis-v4",
 	.codec_dai_name = "wm8580-hifi-capture",
 	.platform_name = "s3c24xx-pcm-audio",
-	.codec_name = "wm8580-codec.0-001b",
+	.codec_name = "wm8580.0-001b",
 	.init = smdk64xx_wm8580_init_paiftx,
 	.ops = &smdk64xx_ops,
 },
diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index 96c05e1..dd41219 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -179,7 +179,7 @@ static struct snd_soc_dai_link s6105_dai = {
 	.cpu_dai_name = "s6000-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.platform_name = "s6000-pcm-audio",
-	.codec_name = "tlv320aic3x-codec.0-001a",
+	.codec_name = "tlv320aic3x.0-001a",
 	.init = s6105_aic3x_init,
 	.ops = &s6105_ops,
 };
diff --git a/sound/soc/sh/fsi-ak4642.c b/sound/soc/sh/fsi-ak4642.c
index d96602d..2b00eac 100644
--- a/sound/soc/sh/fsi-ak4642.c
+++ b/sound/soc/sh/fsi-ak4642.c
@@ -33,10 +33,10 @@ static struct snd_soc_dai_link fsi_dai_link = {
 	.codec_dai_name	= "ak4642-hifi",
 #ifdef CONFIG_MACH_AP4EVB
 	.platform_name	= "sh_fsi2",
-	.codec_name	= "ak4642-codec.0-0013",
+	.codec_name	= "ak4642.0-0013",
 #else
 	.platform_name	= "sh_fsi.0",
-	.codec_name	= "ak4642-codec.0-0012",
+	.codec_name	= "ak4642.0-0012",
 #endif
 	.init		= fsi_ak4642_dai_init,
 	.ops		= NULL,
diff --git a/sound/soc/sh/fsi-da7210.c b/sound/soc/sh/fsi-da7210.c
index a6adb6e..29153ba 100644
--- a/sound/soc/sh/fsi-da7210.c
+++ b/sound/soc/sh/fsi-da7210.c
@@ -28,7 +28,7 @@ static struct snd_soc_dai_link fsi_da7210_dai = {
 	.cpu_dai_name	= "fsib-dai", /* FSI B */
 	.codec_dai_name	= "da7210-hifi",
 	.platform_name	= "sh_fsi.0",
-	.codec_name	= "da7210-codec.0-001a",
+	.codec_name	= "da7210.0-001a",
 	.init		= fsi_da7210_init,
 };
 
-- 
1.7.1
