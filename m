From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Support for DT
Date: Tue,  8 May 2012 14:52:25 +0300
Message-ID: <1336477945-27460-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog131.obsmtp.com (na3sys009aog131.obsmtp.com
	[74.125.149.247])
	by alsa0.perex.cz (Postfix) with ESMTP id B491A24395
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 13:52:36 +0200 (CEST)
Received: by lahc1 with SMTP id c1so4632186lah.26
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 04:52:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Enable Device Tree based loading of the codec driver.

Example of dts section to load the twl6040-codec driver:
twl6040: twl6040@4b {
	...
	twl6040_codec: twl6040@0 {
		compatible = "ti,twl6040-codec";
		interrupts = <1>;
	};
};

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/twl6040.txt          |   26 ++++++++++++++++++++
 sound/soc/codecs/twl6040.c                         |    8 ++++++
 2 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/twl6040.txt

diff --git a/Documentation/devicetree/bindings/sound/twl6040.txt b/Documentation/devicetree/bindings/sound/twl6040.txt
new file mode 100644
index 0000000..1f3dd70
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/twl6040.txt
@@ -0,0 +1,26 @@
+ASoC codec driver for the twl6040 family
+
+The ASoC codec driver is a child of the twl6040 MFD dirver.
+Documentation/devicetree/bindings/mfd/twl6040.txt
+
+Required properties:
+- compatible : Must be "ti,twl6040-codec";
+- interrupts: 1, Jack plug detection IRQ
+
+Example:
+/*
+ * 8-channel high quality low-power audio codec
+ * http://www.ti.com/lit/ds/symlink/twl6040.pdf
+ */
+twl6040: twl6040@4b {
+	...
+	twl6040_codec: twl6040@0 {
+		compatible = "ti,twl6040-codec";
+		interrupts = <1>;
+	};
+};
+
+sound { /* ASoC machine dirver */
+	...
+	dai-link,codec = <&twl6040_codec>;
+};
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 0747260..85c6e0c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/mfd/twl6040.h>
 
@@ -1229,10 +1230,17 @@ static int __devexit twl6040_codec_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id twl6040_codec_of_match[] = {
+	{.compatible = "ti,twl6040-codec", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, twl6040_codec_of_match);
+
 static struct platform_driver twl6040_codec_driver = {
 	.driver = {
 		.name = "twl6040-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = twl6040_codec_of_match,
 	},
 	.probe = twl6040_codec_probe,
 	.remove = __devexit_p(twl6040_codec_remove),
-- 
1.7.8.6
