From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ALSA: ASoC V2: Improve pause/unpause
	performance in Freescale 8610 drivers
Date: Tue,  5 Aug 2008 14:37:31 -0500
Message-ID: <1217965051-14051-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CA77F24665
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 21:37:38 +0200 (CEST)
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

Add support for true pause and unpause.  Without this, mplayer will drop some
audio (less than one second, but still noticeable) when pausing playback.

Remove support for PM suspend and resume from the trigger function, since the
driver doesn't support PM anyway.

Optimize the delay after starting capture.  Instead of delaying 1ms, the driver
now polls the hardware.  The new delay is shorter by over 90% yet still
effective.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for ASoC V2 only.

 sound/soc/fsl/fsl_dma.c |    3 ++-
 sound/soc/fsl/fsl_ssi.c |   17 +++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 83f9c1d..649eac6 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -122,7 +122,8 @@ struct fsl_dma_private {
 static const struct snd_pcm_hardware fsl_dma_hardware = {
 	.info   		= SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_MMAP |
-				  SNDRV_PCM_INFO_MMAP_VALID,
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_PAUSE,
 	.formats		= FSLDMA_PCM_FORMATS,
 	.rates  		= FSLDMA_PCM_RATES,
 	.rate_min       	= 5512,
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7ccd37d..916743f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -409,28 +409,29 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
+		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 			setbits32(&ssi->scr,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
 		} else {
-			clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 			setbits32(&ssi->scr,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
 
 			/*
-			 * I think we need this delay to allow time for the SSI
-			 * to put data into its FIFO.  Without it, ALSA starts
-			 * to complain about overruns.
+			 * Wait until the SSI has filled its FIFO. Without this
+			 * delay, ALSA complains about overruns.  When the FIFO
+			 * is full, the DMA controller initiates its first
+			 * transfer.  Until then, however, the DMA's DAR
+			 * register is zero, which translates to an
+			 * out-of-bounds pointer.  This makes ALSA think an
+			 * overrun has occurred.
 			 */
-			mdelay(1);
+			while (!(in_be32(&ssi->sisr) & CCSR_SSI_SISR_RFF0));
 		}
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			clrbits32(&ssi->scr, CCSR_SSI_SCR_TE);
-- 
1.5.5
