From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 3/5] ASoC: Add device tree binding for WM8737
Date: Wed,  3 Aug 2011 18:40:20 +0900
Message-ID: <1312364422-8726-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1312364422-8726-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1312364422-8726-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/wm8737.txt |   18 ++++++++++++++++++
 sound/soc/codecs/wm8737.c                          |   10 ++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8737.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8737.txt b/Documentation/devicetree/bindings/sound/wm8737.txt
new file mode 100644
index 0000000..4bc2cea
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8737.txt
@@ -0,0 +1,18 @@
+WM8737 audio CODEC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8737"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Example:
+
+codec: wm8737@1a {
+	compatible = "wlf,wm8737";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 30c67d0..f6aef58 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -20,6 +20,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -634,6 +635,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8737 = {
 	.reg_cache_default = wm8737_reg,
 };
 
+static const struct of_device_id wm8737_of_match[] = {
+	{ .compatible = "wlf,wm8737", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, wm8737_of_match);
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8737_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
@@ -673,6 +681,7 @@ static struct i2c_driver wm8737_i2c_driver = {
 	.driver = {
 		.name = "wm8737",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8737_of_match,
 	},
 	.probe =    wm8737_i2c_probe,
 	.remove =   __devexit_p(wm8737_i2c_remove),
@@ -711,6 +720,7 @@ static struct spi_driver wm8737_spi_driver = {
 	.driver = {
 		.name	= "wm8737",
 		.owner	= THIS_MODULE,
+		.of_match_table = wm8737_of_match,
 	},
 	.probe		= wm8737_spi_probe,
 	.remove		= __devexit_p(wm8737_spi_remove),
-- 
1.7.5.4
