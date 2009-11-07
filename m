From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
Date: Sat, 07 Nov 2009 01:34:05 -0700
Message-ID: <20091107083358.18908.10635.stgit@angua>
References: <20091107081631.18908.82921.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f185.google.com (mail-px0-f185.google.com
	[209.85.216.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 29187103807
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 09:34:08 +0100 (CET)
Received: by pxi15 with SMTP id 15so1208088pxi.23
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 00:34:08 -0800 (PST)
In-Reply-To: <20091107081631.18908.82921.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
Cc: lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Sound drivers PCM DMA is supposed to free-run until told to stop
by the trigger callback.  The current code tries to track appl_ptr,
to avoid stale buffer data getting played out at the end of the
data stream.  Unfortunately it also results in race conditions
which can cause the audio to stall.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |   52 +++++++------------------------------------
 sound/soc/fsl/mpc5200_dma.h |    2 --
 2 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 986d3c8..4e47586 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -65,36 +65,6 @@ static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
 	s->period_next = (s->period_next + 1) % s->runtime->periods;
 }
 
-static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
-{
-	if (s->appl_ptr > s->runtime->control->appl_ptr) {
-		/*
-		 * In this case s->runtime->control->appl_ptr has wrapped around.
-		 * Play the data to the end of the boundary, then wrap our own
-		 * appl_ptr back around.
-		 */
-		while (s->appl_ptr < s->runtime->boundary) {
-			if (bcom_queue_full(s->bcom_task))
-				return;
-
-			s->appl_ptr += s->runtime->period_size;
-
-			psc_dma_bcom_enqueue_next_buffer(s);
-		}
-		s->appl_ptr -= s->runtime->boundary;
-	}
-
-	while (s->appl_ptr < s->runtime->control->appl_ptr) {
-
-		if (bcom_queue_full(s->bcom_task))
-			return;
-
-		s->appl_ptr += s->runtime->period_size;
-
-		psc_dma_bcom_enqueue_next_buffer(s);
-	}
-}
-
 /* Bestcomm DMA irq handler */
 static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
 {
@@ -107,8 +77,9 @@ static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
 		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
 
 		s->period_current = (s->period_current+1) % s->runtime->periods;
+
+		psc_dma_bcom_enqueue_next_buffer(s);
 	}
-	psc_dma_bcom_enqueue_tx(s);
 	spin_unlock(&s->psc_dma->lock);
 
 	/* If the stream is active, then also inform the PCM middle layer
@@ -182,28 +153,21 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		s->period_next = 0;
 		s->period_current = 0;
 		s->active = 1;
-
-		/* track appl_ptr so that we have a better chance of detecting
-		 * end of stream and not over running it.
-		 */
 		s->runtime = runtime;
-		s->appl_ptr = s->runtime->control->appl_ptr -
-				(runtime->period_size * runtime->periods);
 
 		/* Fill up the bestcomm bd queue and enable DMA.
 		 * This will begin filling the PSC's fifo.
 		 */
 		spin_lock_irqsave(&psc_dma->lock, flags);
 
-		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
 			bcom_gen_bd_rx_reset(s->bcom_task);
-			for (i = 0; i < runtime->periods; i++)
-				if (!bcom_queue_full(s->bcom_task))
-					psc_dma_bcom_enqueue_next_buffer(s);
-		} else {
+		else
 			bcom_gen_bd_tx_reset(s->bcom_task);
-			psc_dma_bcom_enqueue_tx(s);
-		}
+
+		for (i = 0; i < runtime->periods; i++)
+			if (!bcom_queue_full(s->bcom_task))
+				psc_dma_bcom_enqueue_next_buffer(s);
 
 		bcom_enable(s->bcom_task);
 		spin_unlock_irqrestore(&psc_dma->lock, flags);
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index 529f7a0..d9c741b 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -19,8 +19,6 @@
  */
 struct psc_dma_stream {
 	struct snd_pcm_runtime *runtime;
-	snd_pcm_uframes_t appl_ptr;
-
 	int active;
 	struct psc_dma *psc_dma;
 	struct bcom_task *bcom_task;
