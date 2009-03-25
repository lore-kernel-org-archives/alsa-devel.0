From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.30] ASoC: remove trigger delay in Freescale
	MPC8610 sound driver
Date: Wed, 25 Mar 2009 18:20:37 -0500
Message-ID: <1238023237-28558-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AAB9103857
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2009 00:21:07 +0100 (CET)
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

Remove the delay from the trigger function in the Freescale MPC8610 sound
driver when capture is started.  This delay was used to ensure that the DMA
controller was active when ALSA call the .pointer function to request a
DMA transfer status.  A better approach is for the .pointer function to detect
that DMA has not started, and return zero instead.  This change eliminates
the need for the delay.

Also add some related code to check for a DMA programming error, and report
XRUN if it occurs.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c |   17 +++++++++++++++++
 sound/soc/fsl/fsl_ssi.c |   20 ++------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index b3eb857..2c4892c 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -697,6 +697,23 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 	else
 		position = in_be32(&dma_channel->dar);
 
+	/*
+	 * When capture is started, the SSI immediately starts to fill its FIFO.
+	 * This means that the DMA controller is not started until the FIFO is
+	 * full.  However, ALSA calls this function before that happens, when
+	 * MR.DAR is still zero.  In this case, just return zero to indicate
+	 * that nothing has been received yet.
+	 */
+	if (!position)
+		return 0;
+
+	if ((position < dma_private->dma_buf_phys) ||
+	    (position > dma_private->dma_buf_end)) {
+		dev_err(substream->pcm->card->dev,
+			"dma pointer is out of range, halting stream\n");
+		return SNDRV_PCM_POS_XRUN;
+	}
+
 	frames = bytes_to_frames(runtime, position - dma_private->dma_buf_phys);
 
 	/*
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 169bca2..72823a2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -466,28 +466,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			setbits32(&ssi->scr,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
-		} else {
-			long timeout = jiffies + 10;
-
+		else
 			setbits32(&ssi->scr,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
-
-			/* Wait until the SSI has filled its FIFO. Without this
-			 * delay, ALSA complains about overruns.  When the FIFO
-			 * is full, the DMA controller initiates its first
-			 * transfer.  Until then, however, the DMA's DAR
-			 * register is zero, which translates to an
-			 * out-of-bounds pointer.  This makes ALSA think an
-			 * overrun has occurred.
-			 */
-			while (!(in_be32(&ssi->sisr) & CCSR_SSI_SISR_RFF0) &&
-			       (jiffies < timeout));
-			if (!(in_be32(&ssi->sisr) & CCSR_SSI_SISR_RFF0))
-				return -EIO;
-		}
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
1.6.0.6
