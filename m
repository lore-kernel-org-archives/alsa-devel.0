From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] ASoC: omap-mcpdm: Add device tree
	bindings
Date: Wed, 16 May 2012 14:29:55 +0300
Message-ID: <1337167796-8632-2-git-send-email-peter.ujfalusi@ti.com>
References: <1337167796-8632-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 95A1E24590
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2012 13:30:00 +0200 (CEST)
Received: by lbbgk8 with SMTP id gk8so467132lbb.12
	for <alsa-devel@alsa-project.org>; Wed, 16 May 2012 04:29:58 -0700 (PDT)
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

Device tree support for OMAP4+ McPDM cpu dai driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-mcpdm.txt       |   21 ++++++++++++++++++++
 sound/soc/omap/omap-mcpdm.c                        |    8 +++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
new file mode 100644
index 0000000..0741dff
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
@@ -0,0 +1,21 @@
+* Texas Instruments OMAP4+ McPDM
+
+Required properties:
+- compatible: "ti,omap4-mcpdm"
+- reg: Register location and size as an array:
+       <MPU access base address, size>,
+       <L3 interconnect address, size>;
+- interrupts: Interrupt number for McPDM
+- interrupt-parent: The parent interrupt controller
+- ti,hwmods: Name of the hwmod associated to the McPDM
+
+Example:
+
+mcpdm: mcpdm@40132000 {
+	compatible = "ti,omap4-mcpdm";
+	reg = <0x40132000 0x7f>, /* MPU private access */
+	      <0x49032000 0x7f>; /* L3 Interconnect */
+	interrupts = <0 112 0x4>;
+	interrupt-parent = <&gic>;
+	ti,hwmods = "mcpdm";
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
