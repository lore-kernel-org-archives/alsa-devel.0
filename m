From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] Fix register programming in Freescale MPC8610
	HPCD sound driver
Date: Fri, 13 Jun 2008 14:02:31 -0500
Message-ID: <1213383751-17284-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 1809E103831
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 21:02:44 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m5DJ2Vv0002513
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 12:02:32 -0700 (MST)
Received: from localhost.localdomain (ld0169-tx32.am.freescale.net
	[10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5DJ2V0k010029
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 14:02:31 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix the Freescale MPC8610 HPCD sound driver so that it programs the DMACR
and PMUXCR registers in the global utilities correctly.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.26.  A similar fix has already been made in the ASOC V2
repository.  

 sound/soc/fsl/mpc8610_hpcd.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index a00aac7..8820c3f 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -58,9 +58,9 @@ static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
 		sound_device->dev.platform_data;
 
 	/* Program the signal routing between the SSI and the DMA */
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id + 1,
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
 		machine_data->dma_channel_id[0], CCSR_GUTS_DMACR_DEV_SSI);
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id + 1,
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
 		machine_data->dma_channel_id[1], CCSR_GUTS_DMACR_DEV_SSI);
 
 	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
@@ -170,9 +170,9 @@ int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
 
 	/* Restore the signal routing */
 
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id + 1,
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
 		machine_data->dma_channel_id[0], 0);
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id + 1,
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
 		machine_data->dma_channel_id[1], 0);
 
 	switch (machine_data->ssi_id) {
@@ -182,7 +182,7 @@ int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
 		break;
 	case 1:
 		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_LA);
 		break;
 	}
 
-- 
1.5.5
