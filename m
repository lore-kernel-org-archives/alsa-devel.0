From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] ASoC: pcm512x: Also support PCM514x devices
Date: Tue,  9 Dec 2014 09:28:09 +0100
Message-ID: <1418113689-21505-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/sound/pcm512x.txt |    3 ++-
 sound/soc/codecs/pcm512x-i2c.c                      |    4 ++++
 sound/soc/codecs/pcm512x-spi.c                      |    4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt b/Documentation/devicetree/bindings/sound/pcm512x.txt
index faff75e64573..98e0d34915e8 100644
--- a/Documentation/devicetree/bindings/sound/pcm512x.txt
+++ b/Documentation/devicetree/bindings/sound/pcm512x.txt
@@ -5,7 +5,8 @@ on the board).
 
 Required properties:
 
-  - compatible : One of "ti,pcm5121" or "ti,pcm5122"
+  - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141" or
+                 "ti,pcm5142"
 
   - reg : the I2C address of the device for I2C, the chip select
           number for SPI.
diff --git a/sound/soc/codecs/pcm512x-i2c.c b/sound/soc/codecs/pcm512x-i2c.c
index 4d62230bd378..08047ac952f4 100644
--- a/sound/soc/codecs/pcm512x-i2c.c
+++ b/sound/soc/codecs/pcm512x-i2c.c
@@ -41,6 +41,8 @@ static int pcm512x_i2c_remove(struct i2c_client *i2c)
 static const struct i2c_device_id pcm512x_i2c_id[] = {
 	{ "pcm5121", },
 	{ "pcm5122", },
+	{ "pcm5141", },
+	{ "pcm5142", },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcm512x_i2c_id);
@@ -48,6 +50,8 @@ MODULE_DEVICE_TABLE(i2c, pcm512x_i2c_id);
 static const struct of_device_id pcm512x_of_match[] = {
 	{ .compatible = "ti,pcm5121", },
 	{ .compatible = "ti,pcm5122", },
+	{ .compatible = "ti,pcm5141", },
+	{ .compatible = "ti,pcm5142", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm512x_of_match);
diff --git a/sound/soc/codecs/pcm512x-spi.c b/sound/soc/codecs/pcm512x-spi.c
index f297058c0038..7b64a9cef704 100644
--- a/sound/soc/codecs/pcm512x-spi.c
+++ b/sound/soc/codecs/pcm512x-spi.c
@@ -43,6 +43,8 @@ static int pcm512x_spi_remove(struct spi_device *spi)
 static const struct spi_device_id pcm512x_spi_id[] = {
 	{ "pcm5121", },
 	{ "pcm5122", },
+	{ "pcm5141", },
+	{ "pcm5142", },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, pcm512x_spi_id);
@@ -50,6 +52,8 @@ MODULE_DEVICE_TABLE(spi, pcm512x_spi_id);
 static const struct of_device_id pcm512x_of_match[] = {
 	{ .compatible = "ti,pcm5121", },
 	{ .compatible = "ti,pcm5122", },
+	{ .compatible = "ti,pcm5141", },
+	{ .compatible = "ti,pcm5142", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm512x_of_match);
-- 
1.7.10.4
