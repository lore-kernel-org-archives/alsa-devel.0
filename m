From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 3/3] ASoC: Add device tree support for WM8580
Date: Tue,  2 Aug 2011 14:06:55 +0900
Message-ID: <1312261615-7617-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1312261615-7617-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1312261615-7617-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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
 Documentation/devicetree/bindings/sound/wm8580.txt |   16 ++++++++++++++++
 sound/soc/codecs/wm8580.c                          |    7 +++++++
 2 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8580.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8580.txt b/Documentation/devicetree/bindings/sound/wm8580.txt
new file mode 100644
index 0000000..7d9821f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8580.txt
@@ -0,0 +1,16 @@
+WM8580 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+  - compatible : "wlf,wm8580"
+
+  - reg : the I2C address of the device.
+
+Example:
+
+codec: wm8580@1a {
+	compatible = "wlf,wm8580";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 95ac665..4664c3a 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -907,6 +908,11 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
 	.reg_cache_default = wm8580_reg,
 };
 
+static const struct of_device_id wm8580_of_match[] = {
+	{ .compatible = "wlf,wm8580" },
+	{ },
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int wm8580_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
@@ -945,6 +951,7 @@ static struct i2c_driver wm8580_i2c_driver = {
 	.driver = {
 		.name = "wm8580",
 		.owner = THIS_MODULE,
+		.of_match_table = wm8580_of_match,
 	},
 	.probe =    wm8580_i2c_probe,
 	.remove =   wm8580_i2c_remove,
-- 
1.7.5.4
