From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] asoc/multi-component: fsl: add support for
	disabled SSI nodes
Date: Wed, 4 Aug 2010 17:51:08 -0500
Message-ID: <1280962268-31407-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 905D5103881
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 00:51:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com
List-Id: alsa-devel@alsa-project.org

Add support for adding "status = disabled" to an SSI node to incidate that it
is not wired on the board.  This replaces the not-so-intuitive previous method
of omitting a codec-handle property.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Kumar, would you please ACK the device-tree portion of this patch?  I want
it to go through the ALSA tree.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |    1 +
 sound/soc/fsl/fsl_ssi.c                |   13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 9535ce6..83c3218 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -286,6 +286,7 @@
 
 		ssi@16100 {
 			compatible = "fsl,mpc8610-ssi";
+			status = "disabled";
 			cell-index = <1>;
 			reg = <0x16100 0x100>;
 			interrupt-parent = <&mpic>;
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a0e18b8..45d27b1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -636,12 +636,19 @@ static int __devinit fsl_ssi_probe(struct of_device *of_dev,
 	struct resource res;
 	char name[64];
 
-	/* We are only interested in SSIs with a codec phandle in them, so let's
-	 * make sure this SSI has one.
+	/* SSIs that are not connected on the board should have a
+	 *      status = "disabled"
+	 * property in their device tree nodes.
 	 */
-	if (!of_get_property(np, "codec-handle", NULL))
+	if (!of_device_is_available(np))
 		return -ENODEV;
 
+	/* Check for a codec-handle property. */
+	if (!of_get_property(np, "codec-handle", NULL)) {
+		dev_err(&of_dev->dev, "missing codec-handle property\n");
+		return -ENODEV;
+	}
+
 	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop || strcmp(sprop, "i2s-slave")) {
-- 
1.7.0.1
