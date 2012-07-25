From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Wed, 25 Jul 2012 15:28:34 +0200
Message-ID: <1343222915-26108-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id AC410265306
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 15:28:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Timur Tabi <timur@freescale.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Timur Tabi <timur@freescale.com>
---
 Documentation/devicetree/bindings/sound/cs4270.txt |   16 ++++++++++++++++
 sound/soc/codecs/cs4270.c                          |   11 +++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4270.txt

diff --git a/Documentation/devicetree/bindings/sound/cs4270.txt b/Documentation/devicetree/bindings/sound/cs4270.txt
new file mode 100644
index 0000000..7f0bfd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs4270.txt
@@ -0,0 +1,16 @@
+CS4270 audio CODEC
+
+The driver for this device currently only supports I2C.
+
+Required properties:
+
+  - compatible : "cirrus,cs4270"
+
+  - reg : the I2C address of the device for I2C
+
+Example:
+
+codec: cs4270@48 {
+	compatible = "cirrus,cs4270";
+	reg = <0x48>;
+};
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 047917f..4b71b01 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -29,6 +29,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_device.h>
 
 /*
  * The codec isn't really big-endian or little-endian, since the I2S
@@ -639,6 +640,15 @@ static const struct snd_soc_codec_driver soc_codec_device_cs4270 = {
 	.reg_cache_default =	cs4270_default_reg_cache,
 };
 
+/*
+ * cs4270_of_match - the device tree bindings
+ */
+static const struct of_device_id cs4270_of_match[] = {
+	{ .compatible = "cirrus,cs4270", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs4270_of_match);
+
 /**
  * cs4270_i2c_probe - initialize the I2C interface of the CS4270
  * @i2c_client: the I2C client object
@@ -718,6 +728,7 @@ static struct i2c_driver cs4270_i2c_driver = {
 	.driver = {
 		.name = "cs4270",
 		.owner = THIS_MODULE,
+		.of_match_table = cs4270_of_match,
 	},
 	.id_table = cs4270_id,
 	.probe = cs4270_i2c_probe,
-- 
1.7.10.4
