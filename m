From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ALSA: fix DMA channel selection in Freescale
	MPC8610 sound drivers
Date: Wed,  6 Aug 2008 15:01:01 -0500
Message-ID: <1218052861-15903-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id A737E10392D
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 22:01:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On the Freescale MPC8610, SSI1 is hard-coded to use DMA channels 0 and 1
for playback and capture, and SSI2 is hard-coded to use DMA channels 2 and 3.
This patch fixes the fabric driver so that it uses the right channels.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/mpc8610_hpcd.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 4bdc9d8..94f89de 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -68,10 +68,6 @@ static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
 	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
 		machine_data->dma_channel_id[1], 0);
 
-	guts_set_pmuxcr_dma(machine_data->guts, 1, 0, 0);
-	guts_set_pmuxcr_dma(machine_data->guts, 1, 3, 0);
-	guts_set_pmuxcr_dma(machine_data->guts, 0, 3, 0);
-
 	switch (machine_data->ssi_id) {
 	case 0:
 		clrsetbits_be32(&machine_data->guts->pmuxcr,
@@ -230,6 +226,8 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 	struct fsl_ssi_info ssi_info;
 	struct fsl_dma_info dma_info;
 	int ret = -ENODEV;
+	unsigned int playback_dma_channel;
+	unsigned int capture_dma_channel;
 
 	machine_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
 	if (!machine_data)
@@ -381,8 +379,9 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 		goto error;
 	}
 
-	/* Find the DMA channels to use.  For now, we always use the first DMA
-	   controller. */
+	/* Find the DMA channels to use.  Both SSIs need to use the same DMA
+	 * controller, so let's use DMA#1.
+	 */
 	for_each_compatible_node(dma_np, NULL, "fsl,mpc8610-dma") {
 		iprop = of_get_property(dma_np, "cell-index", NULL);
 		if (iprop && (*iprop == 0)) {
@@ -397,14 +396,19 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 	}
 	machine_data->dma_id = *iprop;
 
+	/* SSI1 needs to use DMA Channels 0 and 1, and SSI2 needs to use DMA
+	 * channels 2 and 3.  This is just how the MPC8610 is wired
+	 * internally.
+	 */
+	playback_dma_channel = (machine_data->ssi_id == 0) ? 0 : 2;
+	capture_dma_channel = (machine_data->ssi_id == 0) ? 1 : 3;
+
 	/*
-	 * Find the DMA channels to use.  For now, we always use DMA channel 0
-	 * for playback, and DMA channel 1 for capture.
+	 * Find the DMA channels to use.
 	 */
 	while ((dma_channel_np = of_get_next_child(dma_np, dma_channel_np))) {
 		iprop = of_get_property(dma_channel_np, "cell-index", NULL);
-		/* Is it DMA channel 0? */
-		if (iprop && (*iprop == 0)) {
+		if (iprop && (*iprop == playback_dma_channel)) {
 			/* dma_channel[0] and dma_irq[0] are for playback */
 			dma_info.dma_channel[0] = of_iomap(dma_channel_np, 0);
 			dma_info.dma_irq[0] =
@@ -412,7 +416,7 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 			machine_data->dma_channel_id[0] = *iprop;
 			continue;
 		}
-		if (iprop && (*iprop == 1)) {
+		if (iprop && (*iprop == capture_dma_channel)) {
 			/* dma_channel[1] and dma_irq[1] are for capture */
 			dma_info.dma_channel[1] = of_iomap(dma_channel_np, 0);
 			dma_info.dma_irq[1] =
-- 
1.5.5
