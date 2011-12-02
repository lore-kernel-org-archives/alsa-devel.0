From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 1/2] ASoC: p1022ds: add support for fsl,
	P1022 and fsl, P1022DS model names
Date: Thu, 1 Dec 2011 19:52:46 -0600
Message-ID: <1322790767-25846-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id AE23624588
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 02:52:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit ab827d97 ("powerpc/85xx: Rework P1022DS device tree") renamed the
the /model property of the P1022DS device tree from "fsl,P1022" to
"fsl,P1022DS".  To support both old and new device trees, the ASoC
machine driver for the P1022DS needs to query the /model property and
update the platform driver object dynamically.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/p1022_ds.c |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 2c064a9..3091626 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -540,12 +540,6 @@ static struct platform_driver p1022_ds_driver = {
 	.probe = p1022_ds_probe,
 	.remove = __devexit_p(p1022_ds_remove),
 	.driver = {
-		/* The name must match the 'model' property in the device tree,
-		 * in lowercase letters, but only the part after that last
-		 * comma.  This is because some model properties have a "fsl,"
-		 * prefix.
-		 */
-		.name = "snd-soc-p1022",
 		.owner = THIS_MODULE,
 	},
 };
@@ -559,13 +553,39 @@ static int __init p1022_ds_init(void)
 {
 	struct device_node *guts_np;
 	struct resource res;
+	const char *sprop;
+
+	/*
+	 * Check if we're actually running on a P1022DS.  Older device trees
+	 * have a model of "fsl,P1022" and newer ones use "fsl,P1022DS", so we
+	 * need to support both.  The SSI driver uses that property to link to
+	 * the machine driver, so have to match it.
+	 */
+	sprop = of_get_property(of_find_node_by_path("/"), "model", NULL);
+	if (!sprop) {
+		pr_err("snd-soc-p1022ds: missing /model node");
+		return -ENODEV;
+	}
+
+	pr_debug("snd-soc-p1022ds: board model name is %s\n", sprop);
 
-	pr_info("Freescale P1022 DS ALSA SoC machine driver\n");
+	/*
+	 * The name of this board, taken from the device tree.  Normally, this is a*
+	 * fixed string, but some P1022DS device trees have a /model property of
+	 * "fsl,P1022", and others have "fsl,P1022DS".
+	 */
+	if (strcasecmp(sprop, "fsl,p1022ds") == 0)
+		p1022_ds_driver.driver.name = "snd-soc-p1022ds";
+	else if (strcasecmp(sprop, "fsl,p1022") == 0)
+		p1022_ds_driver.driver.name = "snd-soc-p1022";
+	else
+		return -ENODEV;
 
 	/* Get the physical address of the global utilities registers */
 	guts_np = of_find_compatible_node(NULL, NULL, "fsl,p1022-guts");
 	if (of_address_to_resource(guts_np, 0, &res)) {
-		pr_err("p1022-ds: missing/invalid global utilities node\n");
+		pr_err("snd-soc-p1022ds: missing/invalid global utils node\n");
+		of_node_put(guts_np);
 		return -EINVAL;
 	}
 	guts_phys = res.start;
-- 
1.7.4.4
