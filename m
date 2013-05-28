From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 05/10] ASoC: blackfin: bf5xx-i2s-pcm:
	Use snd_pcm_lib_preallocate_pages_for_all()
Date: Tue, 28 May 2013 19:22:13 +0200
Message-ID: <1369761738-29503-5-git-send-email-lars@metafoo.de>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1369761738-29503-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Use snd_pcm_lib_preallocate_pages_for_all() for pre-allocating the DMA buffers
instead of re-implementing the same functionality.  Note that there is no need
to call snd_pcm_lib_free_pages_for_all() since the ALSA core takes care of this
for us.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 sound/soc/blackfin/bf5xx-i2s-pcm.c | 63 ++------------------------------------
 1 file changed, 3 insertions(+), 60 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 107c1c9..9931a18 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -209,55 +209,12 @@ static struct snd_pcm_ops bf5xx_pcm_i2s_ops = {
 	.mmap		= bf5xx_pcm_mmap,
 };
 
-static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = bf5xx_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_coherent(pcm->card->dev, size,
-			&buf->addr, GFP_KERNEL);
-	if (!buf->area) {
-		pr_err("Failed to allocate dma memory - Please increase uncached DMA memory region\n");
-		return -ENOMEM;
-	}
-	buf->bytes = size;
-
-	pr_debug("%s, area:%p, size:0x%08lx\n", __func__,
-		buf->area, buf->bytes);
-
-	return 0;
-}
-
-static void bf5xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-		dma_free_coherent(NULL, buf->bytes, buf->area, 0);
-		buf->area = NULL;
-	}
-}
-
 static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
 
 static int bf5xx_pcm_i2s_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
+	size_t size = bf5xx_pcm_hardware.buffer_bytes_max;
 
 	pr_debug("%s enter\n", __func__);
 	if (!card->dev->dma_mask)
@@ -265,27 +222,13 @@ static int bf5xx_pcm_i2s_new(struct snd_soc_pcm_runtime *rtd)
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
- out:
-	return ret;
+	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+				SNDRV_DMA_TYPE_DEV, card->dev, size, size);
 }
 
 static struct snd_soc_platform_driver bf5xx_i2s_soc_platform = {
 	.ops		= &bf5xx_pcm_i2s_ops,
 	.pcm_new	= bf5xx_pcm_i2s_new,
-	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
 
 static int bfin_i2s_soc_platform_probe(struct platform_device *pdev)
-- 
1.8.0
