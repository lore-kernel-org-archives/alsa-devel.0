From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 2/5] ASoC: Add device tree binding for WM8728
Date: Wed,  3 Aug 2011 18:40:19 +0900
Message-ID: <1312364422-8726-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 Documentation/devicetree/bindings/sound/wm8728.txt |   18 ++++++++++++++++++
 sound/soc/codecs/wm8728.c                          |    9 +++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8728.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8728.txt b/Documentation/devicetree/bindings/sound/wm8728.txt
new file mode 100644
index 0000000..a8b5c36
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8728.txt
@@ -0,0 +1,18 @@
+WM8728 audio CODEC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8728"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Example:
+
+codec: wm8728@1a {
+	compatible = "wlf,wm8728";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index c8564f7..04b027e 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -269,6 +270,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8728_intercon),
 };
 
+static const struct of_device_id wm8728_of_match[] = {
+	{ .compatible = "wlf,wm8728", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8728_of_match);
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8728_spi_probe(struct spi_device *spi)
 {
@@ -300,6 +307,7 @@ static struct spi_driver wm8728_spi_driver = {
 	.driver = {
 		.name	= "wm8728",
 		.owner	= THIS_MODULE,
+		.of_match_table = wm8728_of_match,
 	},
 	.probe		= wm8728_spi_probe,
 	.remove		= __devexit_p(wm8728_spi_remove),
@@ -344,6 +352,7 @@ static struct i2c_driver wm8728_i2c_driver = {
 	.driver = {
 		.name = "wm8728",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8728_of_match,
 	},
 	.probe =    wm8728_i2c_probe,
 	.remove =   __devexit_p(wm8728_i2c_remove),
-- 
1.7.5.4
