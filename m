From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Add device tree binding for WM8776
Date: Mon, 29 Aug 2011 14:27:50 +0100
Message-ID: <1314624471-15381-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1314624471-15381-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F07D245D9
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 12:37:56 +0200 (CEST)
In-Reply-To: <1314624471-15381-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 Documentation/devicetree/bindings/sound/wm8776.txt |   18 ++++++++++++++++++
 sound/soc/codecs/wm8776.c                          |    9 +++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8776.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8776.txt b/Documentation/devicetree/bindings/sound/wm8776.txt
new file mode 100644
index 0000000..3b9ca49
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8776.txt
@@ -0,0 +1,18 @@
+WM8776 audio CODEC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8776"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Example:
+
+codec: wm8776@1a {
+	compatible = "wlf,wm8776";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 367a990..0cfbfc1 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
@@ -452,6 +453,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
 	.reg_cache_default = wm8776_reg,
 };
 
+static const struct of_device_id wm8776_of_match[] = {
+	{ .compatible = "wlf,wm8776", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8776_of_match);
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8776_spi_probe(struct spi_device *spi)
 {
@@ -483,6 +490,7 @@ static struct spi_driver wm8776_spi_driver = {
 	.driver = {
 		.name	= "wm8776",
 		.owner	= THIS_MODULE,
+		.of_match_table = wm8776_of_match,
 	},
 	.probe		= wm8776_spi_probe,
 	.remove		= __devexit_p(wm8776_spi_remove),
@@ -527,6 +535,7 @@ static struct i2c_driver wm8776_i2c_driver = {
 	.driver = {
 		.name = "wm8776",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8776_of_match,
 	},
 	.probe =    wm8776_i2c_probe,
 	.remove =   __devexit_p(wm8776_i2c_remove),
-- 
1.7.5.4
