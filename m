From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-dmic: Add device tree bindings
Date: Tue,  8 May 2012 14:59:02 +0300
Message-ID: <1336478342-27635-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 77588243A3
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 13:59:04 +0200 (CEST)
Received: by lbbgg6 with SMTP id gg6so5937606lbb.22
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 04:59:01 -0700 (PDT)
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

Device tree support for OMAP4+ dmic cpu dai driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-dmic.txt        |   17 +++++++++++++++++
 sound/soc/omap/omap-dmic.c                         |    8 ++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/omap-dmic.txt b/Documentation/devicetree/bindings/sound/omap-dmic.txt
new file mode 100644
index 0000000..1d79e3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-dmic.txt
@@ -0,0 +1,17 @@
+* Texas Instruments OMAP4+ Digital Microphone Module
+
+Required properties:
+- compatible: "ti,omap4-dmic"
+- ti,hwmods: Name of the hwmod associated with OMAP dmic IP
+
+Example:
+
+dmic: dmic@4012e000 {
+	compatible = "ti,omap4-dmic";
+	ti,hwmods = "dmic";
+};
+
+sound { /* ASoC machine dirver */
+	...
+	dai-link,dai = <&dmic>;
+};
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 4dcb5a7..75f5dca 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 #include <plat/dma.h>
 
 #include <sound/core.h>
@@ -528,10 +529,17 @@ static int __devexit asoc_dmic_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id omap_dmic_of_match[] = {
+	{ .compatible = "ti,omap4-dmic", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, omap_dmic_of_match);
+
 static struct platform_driver asoc_dmic_driver = {
 	.driver = {
 		.name = "omap-dmic",
 		.owner = THIS_MODULE,
+		.of_match_table = omap_dmic_of_match,
 	},
 	.probe = asoc_dmic_probe,
 	.remove = __devexit_p(asoc_dmic_remove),
-- 
1.7.8.6
