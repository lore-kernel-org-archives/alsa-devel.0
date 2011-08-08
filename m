From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add device tree binding for WM8753
Date: Mon,  8 Aug 2011 13:37:35 +0900
Message-ID: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33077103832
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 06:59:48 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/sound/wm8753.txt |   18 ++++++++++++++++++
 sound/soc/codecs/wm8753.c                          |    9 +++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8753.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8753.txt b/Documentation/devicetree/bindings/sound/wm8753.txt
new file mode 100644
index 0000000..e65277a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8753.txt
@@ -0,0 +1,18 @@
+WM8753 audio CODEC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8753"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Example:
+
+codec: wm8737@1a {
+	compatible = "wlf,wm8753";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index a702550..fe04a10 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
@@ -1490,6 +1491,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
 	.reg_cache_default = wm8753_reg,
 };
 
+static const struct of_device_id wm8753_of_match[] = {
+	{ .compatible = "wlf,wm8753", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8753_of_match);
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8753_spi_probe(struct spi_device *spi)
 {
@@ -1521,6 +1528,7 @@ static struct spi_driver wm8753_spi_driver = {
 	.driver = {
 		.name	= "wm8753",
 		.owner	= THIS_MODULE,
+		.of_match_table = wm8753_of_match,
 	},
 	.probe		= wm8753_spi_probe,
 	.remove		= __devexit_p(wm8753_spi_remove),
@@ -1565,6 +1573,7 @@ static struct i2c_driver wm8753_i2c_driver = {
 	.driver = {
 		.name = "wm8753",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8753_of_match,
 	},
 	.probe =    wm8753_i2c_probe,
 	.remove =   __devexit_p(wm8753_i2c_remove),
-- 
1.7.5.4
