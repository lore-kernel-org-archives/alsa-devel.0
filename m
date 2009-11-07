From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/6] ASoC/mpc5200: Improve printk debug output
	for trigger
Date: Sat, 07 Nov 2009 01:34:18 -0700
Message-ID: <20091107083410.18908.86509.stgit@angua>
References: <20091107081631.18908.82921.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EB8D10399B
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 09:34:21 +0100 (CET)
Received: by mail-pw0-f53.google.com with SMTP id 11so454626pwj.32
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 00:34:21 -0800 (PST)
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

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |   15 ++++++++++-----
 sound/soc/fsl/mpc5200_dma.h |    1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 4e47586..658e3fa 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -77,6 +77,7 @@ static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
 		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
 
 		s->period_current = (s->period_current+1) % s->runtime->periods;
+		s->period_count++;
 
 		psc_dma_bcom_enqueue_next_buffer(s);
 	}
@@ -101,6 +102,7 @@ static irqreturn_t psc_dma_bcom_irq_rx(int irq, void *_psc_dma_stream)
 		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
 
 		s->period_current = (s->period_current+1) % s->runtime->periods;
+		s->period_count++;
 
 		psc_dma_bcom_enqueue_next_buffer(s);
 	}
@@ -142,17 +144,17 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	else
 		s = &psc_dma->playback;
 
-	dev_dbg(psc_dma->dev, "psc_dma_trigger(substream=%p, cmd=%i)"
-		" stream_id=%i\n",
-		substream, cmd, substream->pstr->stream);
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		dev_dbg(psc_dma->dev, "START: stream=%i fbits=%u ps=%u #p=%u\n",
+			substream->pstr->stream, runtime->frame_bits,
+			(int)runtime->period_size, runtime->periods);
 		s->period_bytes = frames_to_bytes(runtime,
 						  runtime->period_size);
 		s->period_next = 0;
 		s->period_current = 0;
 		s->active = 1;
+		s->period_count = 0;
 		s->runtime = runtime;
 
 		/* Fill up the bestcomm bd queue and enable DMA.
@@ -177,6 +179,8 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
+		dev_dbg(psc_dma->dev, "STOP: stream=%i periods_count=%i\n",
+			substream->pstr->stream, s->period_count);
 		s->active = 0;
 
 		spin_lock_irqsave(&psc_dma->lock, flags);
@@ -190,7 +194,8 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 
 	default:
-		dev_dbg(psc_dma->dev, "invalid command\n");
+		dev_dbg(psc_dma->dev, "unhandled trigger: stream=%i cmd=%i\n",
+			substream->pstr->stream, cmd);
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index d9c741b..c6f29e4 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -27,6 +27,7 @@ struct psc_dma_stream {
 	int period_next;
 	int period_current;
 	int period_bytes;
+	int period_count;
 };
 
 /**
