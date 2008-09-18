From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC V2: Remove check for fsl,
	eloplus-dma-channel from MPC8610 sound driver
Date: Thu, 18 Sep 2008 16:57:25 -0500
Message-ID: <1221775045-13290-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 66342244DD
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 23:57:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Remove the check in the Freescale MPC8610 sound driver for the "compatible"
property in the DMA channels.

Normally, the DMA channels in the device tree have "fsl,eloplus-dma-channel"
in the compatible property.  However, this allows the generic DMA driver to
claim those channels, which conflicts with the sound driver.  To resolve this,
the channels used by the sound drivers should have "fsl,ssi-dma-channel" in
the compatible property.  In order for the sound driver to work with either
value, we simply remove all checks for the compatible property.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for ASoC V2 only.

 sound/soc/fsl/fsl_ssi.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 867e770..871ba8e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -628,9 +628,6 @@ static struct device_node *find_dma_node(unsigned int controller,
 	}
 
 	for_each_child_of_node(np, np2) {
-		if (!of_device_is_compatible(np2, "fsl,eloplus-dma-channel"))
-			continue;
-
 		iprop = of_get_property(np2, "cell-index", NULL);
 		if (!iprop) {
 			pr_err("fsl-ssi: cell-index property not found\n");
@@ -640,13 +637,11 @@ static struct device_node *find_dma_node(unsigned int controller,
 			break;
 	}
 
-	if (!np2) {
+	of_node_put(np);
+
+	if (!np2)
 		pr_err("fsl-ssi: cannot find node for DMA channel %u\n",
 			channel);
-		return NULL;
-	}
-
-	of_node_put(np);
 
 	return np2;
 }
-- 
1.5.5
