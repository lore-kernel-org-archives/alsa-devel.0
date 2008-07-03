From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] ALSA: soc - fsl_ssi.c fix audio capture
Date: Thu, 3 Jul 2008 18:37:14 +0400
Message-ID: <20080703143714.GA7003@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 0629D248F6
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 16:37:20 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since we're using SSI in synchronous mode, the STCCR register controls
both the receive and transmit sections. So, when we're trying to record
anything, stccr register does not get initialized, thus the output file
filled with the white noise.

Fix this by initializing the STCCR for both playback and capture. If
TX/RX widths don't match, return that we're busy at the moment.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 sound/soc/fsl/fsl_ssi.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f588545..31f689e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -372,16 +372,24 @@ static int fsl_ssi_prepare(struct snd_pcm_substream *substream)
 
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 	u32 wl;
+	u32 cur_wl;
 
 	wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
 
-	clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
-	else
-		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+	/*
+	 * MPC8610 spec says: "The STCCR register is dedicated to the transmit
+	 * section, and the SRCCR register is dedicated to the receive section
+	 * except in Synchronous mode, in which the STCCR register controls
+	 * both the receive and transmit sections."
+	 * So, the width for TX and RX should match, otherwise we're busy with
+	 * either TX or RX.
+	 */
+	cur_wl = in_be32(&ssi->stccr) & CCSR_SSI_SxCCR_WL_MASK;
+	if (cur_wl && cur_wl != wl)
+		return -EBUSY;
 
+	clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+	clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 	setbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
 
 	return 0;
@@ -460,6 +468,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream)
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
 		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, 0);
 
 		free_irq(ssi_private->irq, ssi_private);
 	}
-- 
1.5.5.4
