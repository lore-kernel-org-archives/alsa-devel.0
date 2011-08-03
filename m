From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Add device tree binding for WM8711
Date: Wed,  3 Aug 2011 18:40:18 +0900
Message-ID: <1312364422-8726-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89CAD103906
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 11:40:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/sound/wm8711.txt |   18 ++++++++++++++++++
 sound/soc/codecs/wm8711.c                          |    9 +++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8711.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8711.txt b/Documentation/devicetree/bindings/sound/wm8711.txt
new file mode 100644
index 0000000..8ed9998
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8711.txt
@@ -0,0 +1,18 @@
+WM8711 audio CODEC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8711"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Example:
+
+codec: wm8711@1a {
+	compatible = "wlf,wm8711";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index e1db7e4..8457d3c 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -414,6 +415,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8711 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8711_intercon),
 };
 
+static const struct of_device_id wm8711_of_match[] = {
+	{ .compatible = "wlf,wm8711", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8711_of_match);
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8711_spi_probe(struct spi_device *spi)
 {
@@ -445,6 +452,7 @@ static struct spi_driver wm8711_spi_driver = {
 	.driver = {
 		.name	= "wm8711",
 		.owner	= THIS_MODULE,
+		.of_match_table = wm8711_of_match,
 	},
 	.probe		= wm8711_spi_probe,
 	.remove		= __devexit_p(wm8711_spi_remove),
@@ -489,6 +497,7 @@ static struct i2c_driver wm8711_i2c_driver = {
 	.driver = {
 		.name = "wm8711",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8711_of_match,
 	},
 	.probe =    wm8711_i2c_probe,
 	.remove =   __devexit_p(wm8711_i2c_remove),
-- 
1.7.5.4
