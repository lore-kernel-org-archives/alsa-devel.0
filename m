From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ALSA: ASoC V2: report error if DMA doesn't
	start in FSL MPC8610 sound drivers
Date: Thu,  7 Aug 2008 11:22:31 -0500
Message-ID: <1218126153-26095-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 071B82490F
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 18:22:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Return an error if the DMA's current pointer is not within the bounds of the
DMA buffer.  This can happen if the DMA controller is not programmed correctly,
or if the SSI doesn't communicate with the DMA controller correctly.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for ASoC V2.

 sound/soc/fsl/fsl_dma.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index cb1e5ae..b4ae486 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -689,6 +689,15 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 	else
 		position = in_be32(&dma_channel->dar);
 
+	if ((position < dma_private->dma_buf_phys) ||
+	    (position > dma_private->dma_buf_end)) {
+		dev_err(substream->pcm->card->dev,
+			"DMA(%u,%u) pointer is out of range, halting stream\n",
+			dma_private->dma_info->controller_id,
+			dma_private->dma_info->channel_id);
+		return SNDRV_PCM_POS_XRUN;
+	}
+
 	frames = bytes_to_frames(runtime, position - dma_private->dma_buf_phys);
 
 	/*
-- 
1.5.5
