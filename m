From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: MPC5200: replace of_device with
	platform_device
Date: Tue, 23 Aug 2011 16:48:26 -0500
Message-ID: <1314136106-26127-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 958502441E
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 23:48:33 +0200 (CEST)
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

'struct of_device' no longer exists, and its functionality has been merged
into platform_device.  Update the MPC5200 audio DMA driver (mpc5200_dma)
accordingly.  This fixes a build break.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/mpc5200_dma.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index fd0dc46..5c6c245 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -369,7 +369,7 @@ static struct snd_soc_platform_driver mpc5200_audio_dma_platform = {
 	.pcm_free	= &psc_dma_free,
 };
 
-static int mpc5200_hpcd_probe(struct of_device *op)
+static int mpc5200_hpcd_probe(struct platform_device *op)
 {
 	phys_addr_t fifo;
 	struct psc_dma *psc_dma;
@@ -487,7 +487,7 @@ out_unmap:
 	return ret;
 }
 
-static int mpc5200_hpcd_remove(struct of_device *op)
+static int mpc5200_hpcd_remove(struct platform_device *op)
 {
 	struct psc_dma *psc_dma = dev_get_drvdata(&op->dev);
 
@@ -519,7 +519,7 @@ MODULE_DEVICE_TABLE(of, mpc5200_hpcd_match);
 static struct platform_driver mpc5200_hpcd_of_driver = {
 	.probe		= mpc5200_hpcd_probe,
 	.remove		= mpc5200_hpcd_remove,
-	.dev = {
+	.driver = {
 		.owner		= THIS_MODULE,
 		.name		= "mpc5200-pcm-audio",
 		.of_match_table    = mpc5200_hpcd_match,
-- 
1.7.3.4
