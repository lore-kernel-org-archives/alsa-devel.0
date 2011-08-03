From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 5/5] ASoC: Add device tree binding for WM8750
Date: Wed,  3 Aug 2011 18:40:22 +0900
Message-ID: <1312364422-8726-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 Documentation/devicetree/bindings/sound/wm8750.txt |   18 ++++++++++++++++++
 sound/soc/codecs/wm8750.c                          |   10 ++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8750.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8750.txt b/Documentation/devicetree/bindings/sound/wm8750.txt
new file mode 100644
index 0000000..8db239f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8750.txt
@@ -0,0 +1,18 @@
+WM8750 and WM8987 audio CODECs
+
+These devices support both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8750" or "wlf,wm8987"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Example:
+
+codec: wm8750@1a {
+	compatible = "wlf,wm8750";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 6bca568..f0ccbef 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -751,6 +752,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8750 = {
 	.reg_cache_default = wm8750_reg,
 };
 
+static const struct of_device_id wm8750_of_match[] = {
+	{ .compatible = "wlf,wm8750", },
+	{ .compatible = "wlf,wm8987", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8750_of_match);
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8750_spi_probe(struct spi_device *spi)
 {
@@ -788,6 +796,7 @@ static struct spi_driver wm8750_spi_driver = {
 	.driver = {
 		.name	= "wm8750",
 		.owner	= THIS_MODULE,
+		.of_match_table = wm8750_of_match,
 	},
 	.id_table	= wm8750_spi_ids,
 	.probe		= wm8750_spi_probe,
@@ -834,6 +843,7 @@ static struct i2c_driver wm8750_i2c_driver = {
 	.driver = {
 		.name = "wm8750",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8750_of_match,
 	},
 	.probe =    wm8750_i2c_probe,
 	.remove =   __devexit_p(wm8750_i2c_remove),
-- 
1.7.5.4
