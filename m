From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/2] ASoC: omap-dmic: Add device tree
	bindings
Date: Wed, 16 May 2012 14:29:56 +0300
Message-ID: <1337167796-8632-3-git-send-email-peter.ujfalusi@ti.com>
References: <1337167796-8632-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with ESMTP id 641CD2458F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2012 13:30:02 +0200 (CEST)
Received: by lahc1 with SMTP id c1so524710lah.32
	for <alsa-devel@alsa-project.org>; Wed, 16 May 2012 04:29:59 -0700 (PDT)
In-Reply-To: <1337167796-8632-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Tony Lindgren <tony@atomide.com>, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Device tree support for OMAP4+ dmic cpu dai driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-dmic.txt        |   21 ++++++++++++++++++++
 sound/soc/omap/omap-dmic.c                         |    8 +++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/omap-dmic.txt b/Documentation/devicetree/bindings/sound/omap-dmic.txt
new file mode 100644
index 0000000..fd8105f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-dmic.txt
@@ -0,0 +1,21 @@
+* Texas Instruments OMAP4+ Digital Microphone Module
+
+Required properties:
+- compatible: "ti,omap4-dmic"
+- reg: Register location and size as an array:
+       <MPU access base address, size>,
+       <L3 interconnect address, size>;
+- interrupts: Interrupt number for DMIC
+- interrupt-parent: The parent interrupt controller
+- ti,hwmods: Name of the hwmod associated with OMAP dmic IP
+
+Example:
+
+dmic: dmic@4012e000 {
+	compatible = "ti,omap4-dmic";
+	reg = <0x4012e000 0x7f>, /* MPU private access */
+	      <0x4902e000 0x7f>; /* L3 Interconnect */
+	interrupts = <0 114 0x4>;
+	interrupt-parent = <&gic>;
+	ti,hwmods = "dmic";
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
