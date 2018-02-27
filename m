From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Subject: [PATCH v1 1/4] ASoC: codecs: pcm179x: Add PCM1789 id
Date: Tue, 27 Feb 2018 22:24:30 +0100
Message-ID: <20180227212433.2189-2-mylene.josserand@bootlin.com>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227212433.2189-1-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com, alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com
List-Id: alsa-devel@alsa-project.org

To prepare the support for the PCM1789, add a new compatible
and use the i2c_id to handle, later, the differences between
these two DACs even if they are pretty similar.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 Documentation/devicetree/bindings/sound/pcm179x.txt | 2 +-
 sound/soc/codecs/pcm179x-i2c.c                      | 6 ++++--
 sound/soc/codecs/pcm179x.c                          | 3 ++-
 sound/soc/codecs/pcm179x.h                          | 8 +++++++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm179x.txt b/Documentation/devicetree/bindings/sound/pcm179x.txt
index 436c2b247693..bf725d302958 100644
--- a/Documentation/devicetree/bindings/sound/pcm179x.txt
+++ b/Documentation/devicetree/bindings/sound/pcm179x.txt
@@ -4,7 +4,7 @@ This driver supports both the I2C and SPI bus.
 
 Required properties:
 
- - compatible: "ti,pcm1792a"
+ - compatible: "ti,pcm1792a" or "ti,pcm1789"
 
 For required properties on SPI, please consult
 Documentation/devicetree/bindings/spi/spi-bus.txt
diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
index 03747966c6bc..795a0657c097 100644
--- a/sound/soc/codecs/pcm179x-i2c.c
+++ b/sound/soc/codecs/pcm179x-i2c.c
@@ -36,17 +36,19 @@ static int pcm179x_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	return pcm179x_common_init(&client->dev, regmap);
+	return pcm179x_common_init(&client->dev, regmap, id->driver_data);
 }
 
 static const struct of_device_id pcm179x_of_match[] = {
 	{ .compatible = "ti,pcm1792a", },
+	{ .compatible = "ti,pcm1789", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm179x_of_match);
 
 static const struct i2c_device_id pcm179x_i2c_ids[] = {
-	{ "pcm179x", 0 },
+	{ "pcm179x", PCM179X },
+	{ "pcm1789", PCM1789 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcm179x_i2c_ids);
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 4b311c06f97d..81cbf09319f6 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -218,7 +218,8 @@ static const struct snd_soc_component_driver soc_component_dev_pcm179x = {
 	.non_legacy_dai_naming	= 1,
 };
 
-int pcm179x_common_init(struct device *dev, struct regmap *regmap)
+int pcm179x_common_init(struct device *dev, struct regmap *regmap,
+			enum pcm17xx_type type)
 {
 	struct pcm179x_private *pcm179x;
 
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index cf8681c9a373..8c08689e3b8b 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -17,11 +17,17 @@
 #ifndef __PCM179X_H__
 #define __PCM179X_H__
 
+enum pcm17xx_type {
+	PCM179X,
+	PCM1789,
+};
+
 #define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
 			  SNDRV_PCM_FMTBIT_S16_LE)
 
 extern const struct regmap_config pcm179x_regmap_config;
 
-int pcm179x_common_init(struct device *dev, struct regmap *regmap);
+int pcm179x_common_init(struct device *dev, struct regmap *regmap,
+			enum pcm17xx_type type);
 
 #endif
-- 
2.11.0
