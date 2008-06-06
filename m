From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC V2] Update MPC8610 drivers to pick the
	right DMA channels
Date: Fri,  6 Jun 2008 11:01:53 -0500
Message-ID: <1212768113-20782-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E1E124424
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 18:01:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lg@opensource.wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On the Freescale MPC8610 SOC, SSI1 is hard-wired to DMA channels 0 and 1,
and SSI2 is hard-wired to DMA channels 2 and 3.  Fix fsl_ssi.c to reflect
that.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9d141ec..4f66e84 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -790,13 +790,13 @@ static int fsl_ssi_probe(struct of_device *ofdev,
 	/*
 	 * Get the DMA information.  If it's an older device tree (i.e. without
 	 * an "fsl,playback-dma" property), then we assume that SSI1 uses DMA1
-	 * Channels 0 and 1, and SSI2 uses DMA2 Channels 0 and 1.
+	 * Channels 0 and 1, and SSI2 uses DMA1 Channels 2 and 3.
 	 */
 	dma_ph = of_get_property(np, "fsl,playback-dma", NULL);
 	if (!dma_ph) {
 		dev_warn(&ofdev->dev, "please update your device tree\n");
-		dma_np[0] = find_dma_node(ssi_info->id, 0);
-		dma_np[1] = find_dma_node(ssi_info->id, 1);
+		dma_np[0] = find_dma_node(0, ssi_info->id ? 2 : 0);
+		dma_np[1] = find_dma_node(0, ssi_info->id ? 3 : 1);
 	} else {
 		dma_np[0] = of_find_node_by_phandle(*dma_ph);
 		dma_ph = of_get_property(np, "fsl,capture-dma", NULL);
-- 
1.5.5
