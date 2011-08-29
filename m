From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 1/3] ASoC: Add device tree binding for WM8770
Date: Mon, 29 Aug 2011 14:27:49 +0100
Message-ID: <1314624471-15381-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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
 Documentation/devicetree/bindings/sound/wm8770.txt |   16 ++++++++++++++++
 sound/soc/codecs/wm8770.c                          |    8 ++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8770.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8770.txt b/Documentation/devicetree/bindings/sound/wm8770.txt
new file mode 100644
index 0000000..866e00c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8770.txt
@@ -0,0 +1,16 @@
+WM8770 audio CODEC
+
+This device supports SPI.
+
+Required properties:
+
+  - compatible : "wlf,wm8770"
+
+  - reg : the chip select number.
+
+Example:
+
+codec: wm8770@1 {
+	compatible = "wlf,wm8770";
+	reg = <1>;
+};
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 19b92ba..aa05e65 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -14,6 +14,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
@@ -684,6 +685,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
 	.reg_cache_default = wm8770_reg_defs
 };
 
+static const struct of_device_id wm8770_of_match[] = {
+	{ .compatible = "wlf,wm8770", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8770_of_match);
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8770_spi_probe(struct spi_device *spi)
 {
@@ -715,6 +722,7 @@ static struct spi_driver wm8770_spi_driver = {
 	.driver = {
 		.name = "wm8770",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8770_of_match,
 	},
 	.probe = wm8770_spi_probe,
 	.remove = __devexit_p(wm8770_spi_remove)
-- 
1.7.5.4
