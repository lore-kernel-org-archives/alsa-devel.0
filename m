From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 09/25] ASoC: Samsung: Generalize DMA driver
	namespace
Date: Tue, 19 Oct 2010 16:06:42 +0900
Message-ID: <1287472002-27765-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id EAF1910391B
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:12:35 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Remove S3C,s3c from static defines.
	s3c_dma_ -> dma_
	s3c24xx_runtime_ -> runtime_
	s3c24xx_audio_ -> audio_
	s3c_preallocate_ -> preallocate_
	s3c24xx_soc_platform -> samsung_asoc_platform
	s3c24xx_pcm_driver -> asoc_dma_driver
	snd_s3c24xx_pcm_ -> samsung_asoc_

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/dma.c |  124 +++++++++++++++++++++++-----------------------
 1 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/sound/soc/s3c24xx/dma.c b/sound/soc/s3c24xx/dma.c
index b4c7c85..12622f3 100644
--- a/sound/soc/s3c24xx/dma.c
+++ b/sound/soc/s3c24xx/dma.c
@@ -32,7 +32,7 @@
 
 #include "dma.h"
 
-static const struct snd_pcm_hardware s3c_dma_hardware = {
+static const struct snd_pcm_hardware dma_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
 				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				    SNDRV_PCM_INFO_MMAP |
@@ -53,7 +53,7 @@ static const struct snd_pcm_hardware s3c_dma_hardware = {
 	.fifo_size		= 32,
 };
 
-struct s3c24xx_runtime_data {
+struct runtime_data {
 	spinlock_t lock;
 	int state;
 	unsigned int dma_loaded;
@@ -65,14 +65,14 @@ struct s3c24xx_runtime_data {
 	struct s3c_dma_params *params;
 };
 
-/* s3c_dma_enqueue
+/* dma_enqueue
  *
  * place a dma buffer onto the queue for the dma system
  * to handle.
 */
-static void s3c_dma_enqueue(struct snd_pcm_substream *substream)
+static void dma_enqueue(struct snd_pcm_substream *substream)
 {
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	struct runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
 	unsigned int limit;
 	int ret;
@@ -113,12 +113,12 @@ static void s3c_dma_enqueue(struct snd_pcm_substream *substream)
 	prtd->dma_pos = pos;
 }
 
-static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
+static void audio_buffdone(struct s3c2410_dma_chan *channel,
 				void *dev_id, int size,
 				enum s3c2410_dma_buffresult result)
 {
 	struct snd_pcm_substream *substream = dev_id;
-	struct s3c24xx_runtime_data *prtd;
+	struct runtime_data *prtd;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -133,17 +133,17 @@ static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
 	spin_lock(&prtd->lock);
 	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
 		prtd->dma_loaded--;
-		s3c_dma_enqueue(substream);
+		dma_enqueue(substream);
 	}
 
 	spin_unlock(&prtd->lock);
 }
 
-static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
+static int dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	struct runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	unsigned long totbytes = params_buffer_bytes(params);
 	struct s3c_dma_params *dma =
@@ -182,7 +182,7 @@ static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
-				    s3c24xx_audio_buffdone);
+				    audio_buffdone);
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
@@ -200,9 +200,9 @@ static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int s3c_dma_hw_free(struct snd_pcm_substream *substream)
+static int dma_hw_free(struct snd_pcm_substream *substream)
 {
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	struct runtime_data *prtd = substream->runtime->private_data;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -217,9 +217,9 @@ static int s3c_dma_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int s3c_dma_prepare(struct snd_pcm_substream *substream)
+static int dma_prepare(struct snd_pcm_substream *substream)
 {
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	struct runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
 
 	pr_debug("Entered %s\n", __func__);
@@ -250,14 +250,14 @@ static int s3c_dma_prepare(struct snd_pcm_substream *substream)
 	prtd->dma_pos = prtd->dma_start;
 
 	/* enqueue dma buffers */
-	s3c_dma_enqueue(substream);
+	dma_enqueue(substream);
 
 	return ret;
 }
 
-static int s3c_dma_trigger(struct snd_pcm_substream *substream, int cmd)
+static int dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	struct runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
 
 	pr_debug("Entered %s\n", __func__);
@@ -290,10 +290,10 @@ static int s3c_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 }
 
 static snd_pcm_uframes_t
-s3c_dma_pointer(struct snd_pcm_substream *substream)
+dma_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	struct runtime_data *prtd = runtime->private_data;
 	unsigned long res;
 	dma_addr_t src, dst;
 
@@ -325,17 +325,17 @@ s3c_dma_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(substream->runtime, res);
 }
 
-static int s3c_dma_open(struct snd_pcm_substream *substream)
+static int dma_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd;
+	struct runtime_data *prtd;
 
 	pr_debug("Entered %s\n", __func__);
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-	snd_soc_set_runtime_hwparams(substream, &s3c_dma_hardware);
+	snd_soc_set_runtime_hwparams(substream, &dma_hardware);
 
-	prtd = kzalloc(sizeof(struct s3c24xx_runtime_data), GFP_KERNEL);
+	prtd = kzalloc(sizeof(struct runtime_data), GFP_KERNEL);
 	if (prtd == NULL)
 		return -ENOMEM;
 
@@ -345,22 +345,22 @@ static int s3c_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int s3c_dma_close(struct snd_pcm_substream *substream)
+static int dma_close(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	struct runtime_data *prtd = runtime->private_data;
 
 	pr_debug("Entered %s\n", __func__);
 
 	if (!prtd)
-		pr_debug("s3c_dma_close called with prtd == NULL\n");
+		pr_debug("dma_close called with prtd == NULL\n");
 
 	kfree(prtd);
 
 	return 0;
 }
 
-static int s3c_dma_mmap(struct snd_pcm_substream *substream,
+static int dma_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -373,23 +373,23 @@ static int s3c_dma_mmap(struct snd_pcm_substream *substream,
 				     runtime->dma_bytes);
 }
 
-static struct snd_pcm_ops s3c_dma_ops = {
-	.open		= s3c_dma_open,
-	.close		= s3c_dma_close,
+static struct snd_pcm_ops dma_ops = {
+	.open		= dma_open,
+	.close		= dma_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= s3c_dma_hw_params,
-	.hw_free	= s3c_dma_hw_free,
-	.prepare	= s3c_dma_prepare,
-	.trigger	= s3c_dma_trigger,
-	.pointer	= s3c_dma_pointer,
-	.mmap		= s3c_dma_mmap,
+	.hw_params	= dma_hw_params,
+	.hw_free	= dma_hw_free,
+	.prepare	= dma_prepare,
+	.trigger	= dma_trigger,
+	.pointer	= dma_pointer,
+	.mmap		= dma_mmap,
 };
 
-static int s3c_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+static int preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 {
 	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = s3c_dma_hardware.buffer_bytes_max;
+	size_t size = dma_hardware.buffer_bytes_max;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -404,7 +404,7 @@ static int s3c_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	return 0;
 }
 
-static void s3c_dma_free_dma_buffers(struct snd_pcm *pcm)
+static void dma_free_dma_buffers(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
 	struct snd_dma_buffer *buf;
@@ -427,9 +427,9 @@ static void s3c_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-static u64 s3c_dma_mask = DMA_BIT_MASK(32);
+static u64 dma_mask = DMA_BIT_MASK(32);
 
-static int s3c_dma_new(struct snd_card *card,
+static int dma_new(struct snd_card *card,
 	struct snd_soc_dai *dai, struct snd_pcm *pcm)
 {
 	int ret = 0;
@@ -437,19 +437,19 @@ static int s3c_dma_new(struct snd_card *card,
 	pr_debug("Entered %s\n", __func__);
 
 	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &s3c_dma_mask;
+		card->dev->dma_mask = &dma_mask;
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
 	if (dai->driver->playback.channels_min) {
-		ret = s3c_preallocate_dma_buffer(pcm,
+		ret = preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
 	if (dai->driver->capture.channels_min) {
-		ret = s3c_preallocate_dma_buffer(pcm,
+		ret = preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
 			goto out;
@@ -458,46 +458,46 @@ out:
 	return ret;
 }
 
-static struct snd_soc_platform_driver s3c24xx_soc_platform = {
-	.ops		= &s3c_dma_ops,
-	.pcm_new	= s3c_dma_new,
-	.pcm_free	= s3c_dma_free_dma_buffers,
+static struct snd_soc_platform_driver samsung_asoc_platform = {
+	.ops		= &dma_ops,
+	.pcm_new	= dma_new,
+	.pcm_free	= dma_free_dma_buffers,
 };
 
-static int __devinit s3c24xx_soc_platform_probe(struct platform_device *pdev)
+static int __devinit samsung_asoc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &s3c24xx_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, &samsung_asoc_platform);
 }
 
-static int __devexit s3c24xx_soc_platform_remove(struct platform_device *pdev)
+static int __devexit samsung_asoc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
 }
 
-static struct platform_driver s3c24xx_pcm_driver = {
+static struct platform_driver asoc_dma_driver = {
 	.driver = {
 		.name = "samsung-audio",
 		.owner = THIS_MODULE,
 	},
 
-	.probe = s3c24xx_soc_platform_probe,
-	.remove = __devexit_p(s3c24xx_soc_platform_remove),
+	.probe = samsung_asoc_platform_probe,
+	.remove = __devexit_p(samsung_asoc_platform_remove),
 };
 
-static int __init snd_s3c24xx_pcm_init(void)
+static int __init samsung_asoc_init(void)
 {
-	return platform_driver_register(&s3c24xx_pcm_driver);
+	return platform_driver_register(&asoc_dma_driver);
 }
-module_init(snd_s3c24xx_pcm_init);
+module_init(samsung_asoc_init);
 
-static void __exit snd_s3c24xx_pcm_exit(void)
+static void __exit samsung_asoc_exit(void)
 {
-	platform_driver_unregister(&s3c24xx_pcm_driver);
+	platform_driver_unregister(&asoc_dma_driver);
 }
-module_exit(snd_s3c24xx_pcm_exit);
+module_exit(samsung_asoc_exit);
 
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
+MODULE_DESCRIPTION("Samsung ASoC DMA Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:samsung-audio");
-- 
1.6.2.5
