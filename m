From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 3/7] ASoC: pxa: move some functions to
	pxa2xx-lib
Date: Wed, 27 Jun 2018 21:33:55 +0200
Message-ID: <20180627193359.26631-4-daniel@zonque.org>
References: <20180627193359.26631-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D8F52679A6
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 21:34:11 +0200 (CEST)
In-Reply-To: <20180627193359.26631-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

To get rid of some intermediate platform layers, move pxa2xx_soc_pcm_new()
and pxa2xx_pcm_ops in pxa2xx-lib.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 include/sound/pxa2xx-lib.h |  3 +++
 sound/arm/pxa2xx-ac97.c    |  6 ++---
 sound/arm/pxa2xx-pcm-lib.c | 41 ++++++++++++++++++++++++++++
 sound/soc/pxa/pxa2xx-pcm.c | 55 --------------------------------------
 4 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
index b43de38de8b2..6758fc12fa84 100644
--- a/include/sound/pxa2xx-lib.h
+++ b/include/sound/pxa2xx-lib.h
@@ -8,6 +8,7 @@
 /* PCM */
 struct snd_pcm_substream;
 struct snd_pcm_hw_params;
+struct snd_soc_pcm_runtime;
 struct snd_pcm;
 
 extern int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
@@ -22,6 +23,8 @@ extern int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma);
 extern int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream);
 extern void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm);
+extern int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd);
+extern const struct snd_pcm_ops pxa2xx_pcm_ops;
 
 /* AC97 */
 
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 0d624337857b..1f72672262d0 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -174,7 +174,7 @@ static int pxa2xx_ac97_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pxa2xx_ac97_pm_ops, pxa2xx_ac97_suspend, pxa2xx_ac97_resume);
 #endif
 
-static const struct snd_pcm_ops pxa2xx_pcm_ops = {
+static const struct snd_pcm_ops pxa2xx_ac97_pcm_ops = {
 	.open		= pxa2xx_ac97_pcm_open,
 	.close		= pxa2xx_ac97_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
@@ -203,13 +203,13 @@ static int pxa2xx_ac97_pcm_new(struct snd_card *card)
 		goto out;
 
 	stream = SNDRV_PCM_STREAM_PLAYBACK;
-	snd_pcm_set_ops(pcm, stream, &pxa2xx_pcm_ops);
+	snd_pcm_set_ops(pcm, stream, &pxa2xx_ac97_pcm_ops);
 	ret = pxa2xx_pcm_preallocate_dma_buffer(pcm, stream);
 	if (ret)
 		goto out;
 
 	stream = SNDRV_PCM_STREAM_CAPTURE;
-	snd_pcm_set_ops(pcm, stream, &pxa2xx_pcm_ops);
+	snd_pcm_set_ops(pcm, stream, &pxa2xx_ac97_pcm_ops);
 	ret = pxa2xx_pcm_preallocate_dma_buffer(pcm, stream);
 	if (ret)
 		goto out;
diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index dc56dbebf441..add23d9b4ef6 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -179,6 +179,47 @@ void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 }
 EXPORT_SYMBOL(pxa2xx_pcm_free_dma_buffers);
 
+int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_card *card = rtd->card->snd_card;
+	struct snd_pcm *pcm = rtd->pcm;
+	int ret;
+
+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
+		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
+		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+ out:
+	return ret;
+}
+EXPORT_SYMBOL(pxa2xx_soc_pcm_new);
+
+const struct snd_pcm_ops pxa2xx_pcm_ops = {
+	.open		= pxa2xx_pcm_open,
+	.close		= pxa2xx_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= pxa2xx_pcm_hw_params,
+	.hw_free	= pxa2xx_pcm_hw_free,
+	.prepare	= pxa2xx_pcm_prepare,
+	.trigger	= pxa2xx_pcm_trigger,
+	.pointer	= pxa2xx_pcm_pointer,
+	.mmap		= pxa2xx_pcm_mmap,
+};
+EXPORT_SYMBOL(pxa2xx_pcm_ops);
+
 MODULE_AUTHOR("Nicolas Pitre");
 MODULE_DESCRIPTION("Intel PXA2xx sound library");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index da252d1f732e..a1df4ec76cbd 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -20,61 +20,6 @@
 #include <sound/pxa2xx-lib.h>
 #include <sound/dmaengine_pcm.h>
 
-static int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_dmaengine_dai_dma_data *dma;
-
-	dma = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!dma)
-		return 0;
-
-	return pxa2xx_pcm_hw_params(substream, params);
-}
-
-static const struct snd_pcm_ops pxa2xx_pcm_ops = {
-	.open		= pxa2xx_pcm_open,
-	.close		= pxa2xx_pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= __pxa2xx_pcm_hw_params,
-	.hw_free	= pxa2xx_pcm_hw_free,
-	.prepare	= pxa2xx_pcm_prepare,
-	.trigger	= pxa2xx_pcm_trigger,
-	.pointer	= pxa2xx_pcm_pointer,
-	.mmap		= pxa2xx_pcm_mmap,
-};
-
-static int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret;
-
-	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
- out:
-	return ret;
-}
-
 static const struct snd_soc_component_driver pxa2xx_soc_platform = {
 	.ops		= &pxa2xx_pcm_ops,
 	.pcm_new	= pxa2xx_soc_pcm_new,
-- 
2.17.1
