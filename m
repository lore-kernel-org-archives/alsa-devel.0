From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcpdm: Add device tree bindings
Date: Tue,  8 May 2012 14:58:32 +0300
Message-ID: <1336478312-27595-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog136.obsmtp.com (na3sys009aog136.obsmtp.com
	[74.125.149.85]) by alsa0.perex.cz (Postfix) with ESMTP id A8FF8243A2
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 13:58:34 +0200 (CEST)
Received: by lahm15 with SMTP id m15so1629475lah.9
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 04:58:32 -0700 (PDT)
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

Device tree support for OMAP4+ McPDM cpu dai driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-mcpdm.txt       |   17 +++++++++++++++++
 sound/soc/omap/omap-mcpdm.c                        |    8 ++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
new file mode 100644
index 0000000..58b0e31
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
@@ -0,0 +1,17 @@
+* Texas Instruments OMAP4+ McPDM
+
+Required properties:
+- compatible: "ti,omap4-mcpdm"
+- ti,hwmods: Name of the hwmod associated to the McPDM
+
+Example:
+
+mcpdm: mcpdm@40132000 {
+	compatible = "ti,omap4-mcpdm";
+	ti,hwmods = "mcpdm";
+};
+
+sound { /* ASoC machine dirver */
+	...
+	dai-link,dai = <&mcpdm>;
+};
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 3970556..59d47ab 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -507,10 +508,17 @@ static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id omap_mcpdm_of_match[] = {
+	{ .compatible = "ti,omap4-mcpdm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, omap_mcpdm_of_match);
+
 static struct platform_driver asoc_mcpdm_driver = {
 	.driver = {
 		.name	= "omap-mcpdm",
 		.owner	= THIS_MODULE,
+		.of_match_table = omap_mcpdm_of_match,
 	},
 
 	.probe	= asoc_mcpdm_probe,
-- 
1.7.8.6
