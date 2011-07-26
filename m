From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add device tree binding for WM8731
Date: Tue, 26 Jul 2011 21:02:11 +0100
Message-ID: <1311710531-25165-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2991B2442D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 22:02:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Grant Likely <grant@secretlab.ca>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, devicetree-discuss@lists.ozlabs.com
List-Id: alsa-devel@alsa-project.org

Tested with the famous "hey, look! this compiles" test plan.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/sound/wm8731.txt |   18 ++++++++++++++++++
 sound/soc/codecs/wm8731.c                          |   12 ++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8731.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8731.txt b/Documentation/devicetree/bindings/sound/wm8731.txt
new file mode 100644
index 0000000..15f7004
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8731.txt
@@ -0,0 +1,18 @@
+WM8731 audio CODEC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8731"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Example:
+
+codec: wm8731@1a {
+	compatible = "wlf,wm8731";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 76b4361..5ecc05a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -607,6 +608,11 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8731_intercon),
 };
 
+static const struct of_device_id wm8731_of_match[] = {
+	{ .compatible = "wlf,wm8731", },
+	{ }
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8731_spi_probe(struct spi_device *spi)
 {
@@ -634,10 +640,13 @@ static int __devexit wm8731_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+MODULE_DEVICE_TABLE(spi, wm8731_of_match);
+
 static struct spi_driver wm8731_spi_driver = {
 	.driver = {
 		.name	= "wm8731",
 		.owner	= THIS_MODULE,
+		.of_match_table = wm8731_of_match,
 	},
 	.probe		= wm8731_spi_probe,
 	.remove		= __devexit_p(wm8731_spi_remove),
@@ -678,10 +687,13 @@ static const struct i2c_device_id wm8731_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8731_i2c_id);
 
+MODULE_DEVICE_TABLE(i2c, wm8731_of_match);
+
 static struct i2c_driver wm8731_i2c_driver = {
 	.driver = {
 		.name = "wm8731",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8731_of_match,
 	},
 	.probe =    wm8731_i2c_probe,
 	.remove =   __devexit_p(wm8731_i2c_remove),
-- 
1.7.5.4
