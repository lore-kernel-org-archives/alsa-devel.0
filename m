From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] ASoC: sgtl5000: add device tree probe support
Date: Fri, 22 Jul 2011 00:28:51 +0800
Message-ID: <1311265731-23318-1-git-send-email-shawn.guo@linaro.org>
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
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Zeng Zhaoming <zhaoming.zeng-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

It adds device tree probe support for sgtl5000 driver.

Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Zeng Zhaoming <zhaoming.zeng-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 .../bindings/sound/soc/codecs/fsl-sgtl5000.txt     |   11 +++++++++++
 sound/soc/codecs/sgtl5000.c                        |    8 ++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt

diff --git a/Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt b/Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt
new file mode 100644
index 0000000..2c3cd41
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt
@@ -0,0 +1,11 @@
+* Freescale SGTL5000 Stereo Codec
+
+Required properties:
+- compatible : "fsl,sgtl5000".
+
+Example:
+
+codec: sgtl5000@0a {
+	compatible = "fsl,sgtl5000";
+	reg = <0x0a>;
+};
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 76258f2..cf6eea8 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -20,6 +20,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
 #include <sound/pcm.h>
@@ -1494,10 +1495,17 @@ static const struct i2c_device_id sgtl5000_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, sgtl5000_id);
 
+static const struct of_device_id sgtl5000_dt_ids[] = {
+	{ .compatible = "fsl,sgtl5000", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, sgtl5000_dt_ids);
+
 static struct i2c_driver sgtl5000_i2c_driver = {
 	.driver = {
 		   .name = "sgtl5000",
 		   .owner = THIS_MODULE,
+		   .of_match_table = sgtl5000_dt_ids,
 		   },
 	.probe = sgtl5000_i2c_probe,
 	.remove = __devexit_p(sgtl5000_i2c_remove),
-- 
1.7.4.1
