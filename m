From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] ASoC/mpc5200: remove duplicate identical IRQ
	handler
Date: Mon, 09 Nov 2009 09:40:09 -0700
Message-ID: <20091109163936.29231.482.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id E423C246F3
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 17:40:12 +0100 (CET)
Received: by pzk14 with SMTP id 14so2218720pzk.23
	for <alsa-devel@alsa-project.org>; Mon, 09 Nov 2009 08:40:11 -0800 (PST)
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

The TX and RX irq handlers are identical.  Merge them

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Hi Mark.  Here's one more cleanup patch.

 sound/soc/fsl/mpc5200_dma.c |   33 +++------------------------------
 1 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index ee5a606..440b749 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -66,32 +66,7 @@ static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
 }
 
 /* Bestcomm DMA irq handler */
-static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
-{
-	struct psc_dma_stream *s = _psc_dma_stream;
-
-	spin_lock(&s->psc_dma->lock);
-	/* For each finished period, dequeue the completed period buffer
-	 * and enqueue a new one in it's place. */
-	while (bcom_buffer_done(s->bcom_task)) {
-		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
-
-		s->period_current = (s->period_current+1) % s->runtime->periods;
-		s->period_count++;
-
-		psc_dma_bcom_enqueue_next_buffer(s);
-	}
-	spin_unlock(&s->psc_dma->lock);
-
-	/* If the stream is active, then also inform the PCM middle layer
-	 * of the period finished event. */
-	if (s->active)
-		snd_pcm_period_elapsed(s->stream);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t psc_dma_bcom_irq_rx(int irq, void *_psc_dma_stream)
+static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
 {
 	struct psc_dma_stream *s = _psc_dma_stream;
 
@@ -486,11 +461,9 @@ int mpc5200_audio_dma_create(struct of_device *op)
 
 	rc = request_irq(psc_dma->irq, &psc_dma_status_irq, IRQF_SHARED,
 			 "psc-dma-status", psc_dma);
-	rc |= request_irq(psc_dma->capture.irq,
-			  &psc_dma_bcom_irq_rx, IRQF_SHARED,
+	rc |= request_irq(psc_dma->capture.irq, &psc_dma_bcom_irq, IRQF_SHARED,
 			  "psc-dma-capture", &psc_dma->capture);
-	rc |= request_irq(psc_dma->playback.irq,
-			  &psc_dma_bcom_irq_tx, IRQF_SHARED,
+	rc |= request_irq(psc_dma->playback.irq, &psc_dma_bcom_irq, IRQF_SHARED,
 			  "psc-dma-playback", &psc_dma->playback);
 	if (rc) {
 		ret = -ENODEV;
