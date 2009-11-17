From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCHv2 1/7] S3C AUDIO: Rename s3c24xx_pcm prefix to
	s3c_dma
Date: Tue, 17 Nov 2009 16:53:23 +0900
Message-ID: <1258444403-23606-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D9C724447
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 09:01:23 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

The s3c24xx_pcm prefix for the soc_platform is inappropriate when
some Samsung SoCs have PCM controllers which will eventually have
drivers and hence namespace ambiguities.

To resolve naming ambiguities in future the following have been
renamed in order
1) s3c24xx_pcm_dma_params -> s3c_dma_params
2) s3c24xx_pcm_preallocate_dma_buffer -> s3c_preallocate_dma_buffer
3) s3c24xx_pcm_dmamask -> s3c_dma_mask
4) s3c24xx_pcm_XXX -> s3c_dma_XXX

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c   |    2 +-
 sound/soc/s3c24xx/s3c-i2s-v2.h   |    4 +-
 sound/soc/s3c24xx/s3c2412-i2s.c  |    4 +-
 sound/soc/s3c24xx/s3c2443-ac97.c |   10 ++--
 sound/soc/s3c24xx/s3c24xx-i2s.c  |   10 ++--
 sound/soc/s3c24xx/s3c24xx-pcm.c  |   76 +++++++++++++++++++-------------------
 sound/soc/s3c24xx/s3c24xx-pcm.h  |    6 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c  |    4 +-
 8 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 28b0ab2..5a442aa 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -394,7 +394,7 @@ static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 	unsigned long irqs;
 	int ret = 0;
-	int channel = ((struct s3c24xx_pcm_dma_params *)
+	int channel = ((struct s3c_dma_params *)
 		  rtd->dai->cpu_dai->dma_data)->channel;
 
 	pr_debug("Entered %s\n", __func__);
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.h b/sound/soc/s3c24xx/s3c-i2s-v2.h
index f66854a..ecf8eaa 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.h
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.h
@@ -49,8 +49,8 @@ struct s3c_i2sv2_info {
 
 	unsigned char	 master;
 
-	struct s3c24xx_pcm_dma_params	*dma_playback;
-	struct s3c24xx_pcm_dma_params	*dma_capture;
+	struct s3c_dma_params	*dma_playback;
+	struct s3c_dma_params	*dma_capture;
 
 	u32		 suspend_iismod;
 	u32		 suspend_iiscon;
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index ac5e47b..23718ea 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -50,14 +50,14 @@ static struct s3c2410_dma_client s3c2412_dma_client_in = {
 	.name		= "I2S PCM Stereo in"
 };
 
-static struct s3c24xx_pcm_dma_params s3c2412_i2s_pcm_stereo_out = {
+static struct s3c_dma_params s3c2412_i2s_pcm_stereo_out = {
 	.client		= &s3c2412_dma_client_out,
 	.channel	= DMACH_I2S_OUT,
 	.dma_addr	= S3C2410_PA_IIS + S3C2412_IISTXD,
 	.dma_size	= 4,
 };
 
-static struct s3c24xx_pcm_dma_params s3c2412_i2s_pcm_stereo_in = {
+static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
 	.client		= &s3c2412_dma_client_in,
 	.channel	= DMACH_I2S_IN,
 	.dma_addr	= S3C2410_PA_IIS + S3C2412_IISRXD,
diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
index b25e9f9..678b176 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -188,21 +188,21 @@ static struct s3c2410_dma_client s3c2443_dma_client_micin = {
 	.name = "AC97 Mic Mono in"
 };
 
-static struct s3c24xx_pcm_dma_params s3c2443_ac97_pcm_stereo_out = {
+static struct s3c_dma_params s3c2443_ac97_pcm_stereo_out = {
 	.client		= &s3c2443_dma_client_out,
 	.channel	= DMACH_PCM_OUT,
 	.dma_addr	= S3C2440_PA_AC97 + S3C_AC97_PCM_DATA,
 	.dma_size	= 4,
 };
 
-static struct s3c24xx_pcm_dma_params s3c2443_ac97_pcm_stereo_in = {
+static struct s3c_dma_params s3c2443_ac97_pcm_stereo_in = {
 	.client		= &s3c2443_dma_client_in,
 	.channel	= DMACH_PCM_IN,
 	.dma_addr	= S3C2440_PA_AC97 + S3C_AC97_PCM_DATA,
 	.dma_size	= 4,
 };
 
-static struct s3c24xx_pcm_dma_params s3c2443_ac97_mic_mono_in = {
+static struct s3c_dma_params s3c2443_ac97_mic_mono_in = {
 	.client		= &s3c2443_dma_client_micin,
 	.channel	= DMACH_MIC_IN,
 	.dma_addr	= S3C2440_PA_AC97 + S3C_AC97_MIC_DATA,
@@ -290,7 +290,7 @@ static int s3c2443_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	u32 ac_glbctrl;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int channel = ((struct s3c24xx_pcm_dma_params *)
+	int channel = ((struct s3c_dma_params *)
 		  rtd->dai->cpu_dai->dma_data)->channel;
 
 	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
@@ -339,7 +339,7 @@ static int s3c2443_ac97_mic_trigger(struct snd_pcm_substream *substream,
 {
 	u32 ac_glbctrl;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int channel = ((struct s3c24xx_pcm_dma_params *)
+	int channel = ((struct s3c_dma_params *)
 		  rtd->dai->cpu_dai->dma_data)->channel;
 
 	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index c76b8bb..afb4bc9 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -49,14 +49,14 @@ static struct s3c2410_dma_client s3c24xx_dma_client_in = {
 	.name = "I2S PCM Stereo in"
 };
 
-static struct s3c24xx_pcm_dma_params s3c24xx_i2s_pcm_stereo_out = {
+static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_out = {
 	.client		= &s3c24xx_dma_client_out,
 	.channel	= DMACH_I2S_OUT,
 	.dma_addr	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	.dma_size	= 2,
 };
 
-static struct s3c24xx_pcm_dma_params s3c24xx_i2s_pcm_stereo_in = {
+static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_in = {
 	.client		= &s3c24xx_dma_client_in,
 	.channel	= DMACH_I2S_IN,
 	.dma_addr	= S3C2410_PA_IIS + S3C2410_IISFIFO,
@@ -258,12 +258,12 @@ static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		iismod &= ~S3C2410_IISMOD_16BIT;
-		((struct s3c24xx_pcm_dma_params *)
+		((struct s3c_dma_params *)
 		  rtd->dai->cpu_dai->dma_data)->dma_size = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		iismod |= S3C2410_IISMOD_16BIT;
-		((struct s3c24xx_pcm_dma_params *)
+		((struct s3c_dma_params *)
 		  rtd->dai->cpu_dai->dma_data)->dma_size = 2;
 		break;
 	default:
@@ -280,7 +280,7 @@ static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int channel = ((struct s3c24xx_pcm_dma_params *)
+	int channel = ((struct s3c_dma_params *)
 		  rtd->dai->cpu_dai->dma_data)->channel;
 
 	pr_debug("Entered %s\n", __func__);
diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index 151a694..cb49400 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -32,7 +32,7 @@
 
 #include "s3c24xx-pcm.h"
 
-static const struct snd_pcm_hardware s3c24xx_pcm_hardware = {
+static const struct snd_pcm_hardware s3c_dma_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
 				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				    SNDRV_PCM_INFO_MMAP |
@@ -62,15 +62,15 @@ struct s3c24xx_runtime_data {
 	dma_addr_t dma_start;
 	dma_addr_t dma_pos;
 	dma_addr_t dma_end;
-	struct s3c24xx_pcm_dma_params *params;
+	struct s3c_dma_params *params;
 };
 
-/* s3c24xx_pcm_enqueue
+/* s3c_dma_enqueue
  *
  * place a dma buffer onto the queue for the dma system
  * to handle.
 */
-static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
+static void s3c_dma_enqueue(struct snd_pcm_substream *substream)
 {
 	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
@@ -132,19 +132,19 @@ static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
 	spin_lock(&prtd->lock);
 	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
 		prtd->dma_loaded--;
-		s3c24xx_pcm_enqueue(substream);
+		s3c_dma_enqueue(substream);
 	}
 
 	spin_unlock(&prtd->lock);
 }
 
-static int s3c24xx_pcm_hw_params(struct snd_pcm_substream *substream,
+static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s3c24xx_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c24xx_pcm_dma_params *dma = rtd->dai->cpu_dai->dma_data;
+	struct s3c_dma_params *dma = rtd->dai->cpu_dai->dma_data;
 	unsigned long totbytes = params_buffer_bytes(params);
 	int ret = 0;
 
@@ -197,7 +197,7 @@ static int s3c24xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int s3c24xx_pcm_hw_free(struct snd_pcm_substream *substream)
+static int s3c_dma_hw_free(struct snd_pcm_substream *substream)
 {
 	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
 
@@ -214,7 +214,7 @@ static int s3c24xx_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int s3c24xx_pcm_prepare(struct snd_pcm_substream *substream)
+static int s3c_dma_prepare(struct snd_pcm_substream *substream)
 {
 	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
@@ -247,12 +247,12 @@ static int s3c24xx_pcm_prepare(struct snd_pcm_substream *substream)
 	prtd->dma_pos = prtd->dma_start;
 
 	/* enqueue dma buffers */
-	s3c24xx_pcm_enqueue(substream);
+	s3c_dma_enqueue(substream);
 
 	return ret;
 }
 
-static int s3c24xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+static int s3c_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
@@ -287,7 +287,7 @@ static int s3c24xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 }
 
 static snd_pcm_uframes_t
-s3c24xx_pcm_pointer(struct snd_pcm_substream *substream)
+s3c_dma_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s3c24xx_runtime_data *prtd = runtime->private_data;
@@ -322,7 +322,7 @@ s3c24xx_pcm_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(substream->runtime, res);
 }
 
-static int s3c24xx_pcm_open(struct snd_pcm_substream *substream)
+static int s3c_dma_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s3c24xx_runtime_data *prtd;
@@ -330,7 +330,7 @@ static int s3c24xx_pcm_open(struct snd_pcm_substream *substream)
 	pr_debug("Entered %s\n", __func__);
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-	snd_soc_set_runtime_hwparams(substream, &s3c24xx_pcm_hardware);
+	snd_soc_set_runtime_hwparams(substream, &s3c_dma_hardware);
 
 	prtd = kzalloc(sizeof(struct s3c24xx_runtime_data), GFP_KERNEL);
 	if (prtd == NULL)
@@ -342,7 +342,7 @@ static int s3c24xx_pcm_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int s3c24xx_pcm_close(struct snd_pcm_substream *substream)
+static int s3c_dma_close(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s3c24xx_runtime_data *prtd = runtime->private_data;
@@ -350,14 +350,14 @@ static int s3c24xx_pcm_close(struct snd_pcm_substream *substream)
 	pr_debug("Entered %s\n", __func__);
 
 	if (!prtd)
-		pr_debug("s3c24xx_pcm_close called with prtd == NULL\n");
+		pr_debug("s3c_dma_close called with prtd == NULL\n");
 
 	kfree(prtd);
 
 	return 0;
 }
 
-static int s3c24xx_pcm_mmap(struct snd_pcm_substream *substream,
+static int s3c_dma_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -370,23 +370,23 @@ static int s3c24xx_pcm_mmap(struct snd_pcm_substream *substream,
 				     runtime->dma_bytes);
 }
 
-static struct snd_pcm_ops s3c24xx_pcm_ops = {
-	.open		= s3c24xx_pcm_open,
-	.close		= s3c24xx_pcm_close,
+static struct snd_pcm_ops s3c_dma_ops = {
+	.open		= s3c_dma_open,
+	.close		= s3c_dma_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= s3c24xx_pcm_hw_params,
-	.hw_free	= s3c24xx_pcm_hw_free,
-	.prepare	= s3c24xx_pcm_prepare,
-	.trigger	= s3c24xx_pcm_trigger,
-	.pointer	= s3c24xx_pcm_pointer,
-	.mmap		= s3c24xx_pcm_mmap,
+	.hw_params	= s3c_dma_hw_params,
+	.hw_free	= s3c_dma_hw_free,
+	.prepare	= s3c_dma_prepare,
+	.trigger	= s3c_dma_trigger,
+	.pointer	= s3c_dma_pointer,
+	.mmap		= s3c_dma_mmap,
 };
 
-static int s3c24xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+static int s3c_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 {
 	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = s3c24xx_pcm_hardware.buffer_bytes_max;
+	size_t size = s3c_dma_hardware.buffer_bytes_max;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -401,7 +401,7 @@ static int s3c24xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	return 0;
 }
 
-static void s3c24xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
+static void s3c_dma_free_dma_buffers(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
 	struct snd_dma_buffer *buf;
@@ -424,9 +424,9 @@ static void s3c24xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-static u64 s3c24xx_pcm_dmamask = DMA_BIT_MASK(32);
+static u64 s3c_dma_mask = DMA_BIT_MASK(32);
 
-static int s3c24xx_pcm_new(struct snd_card *card,
+static int s3c_dma_new(struct snd_card *card,
 	struct snd_soc_dai *dai, struct snd_pcm *pcm)
 {
 	int ret = 0;
@@ -434,19 +434,19 @@ static int s3c24xx_pcm_new(struct snd_card *card,
 	pr_debug("Entered %s\n", __func__);
 
 	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &s3c24xx_pcm_dmamask;
+		card->dev->dma_mask = &s3c_dma_mask;
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
 	if (dai->playback.channels_min) {
-		ret = s3c24xx_pcm_preallocate_dma_buffer(pcm,
+		ret = s3c_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
 	if (dai->capture.channels_min) {
-		ret = s3c24xx_pcm_preallocate_dma_buffer(pcm,
+		ret = s3c_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
 			goto out;
@@ -457,9 +457,9 @@ static int s3c24xx_pcm_new(struct snd_card *card,
 
 struct snd_soc_platform s3c24xx_soc_platform = {
 	.name		= "s3c24xx-audio",
-	.pcm_ops 	= &s3c24xx_pcm_ops,
-	.pcm_new	= s3c24xx_pcm_new,
-	.pcm_free	= s3c24xx_pcm_free_dma_buffers,
+	.pcm_ops 	= &s3c_dma_ops,
+	.pcm_new	= s3c_dma_new,
+	.pcm_free	= s3c_dma_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(s3c24xx_soc_platform);
 
@@ -476,5 +476,5 @@ static void __exit s3c24xx_soc_platform_exit(void)
 module_exit(s3c24xx_soc_platform_exit);
 
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("Samsung S3C24XX PCM DMA module");
+MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.h b/sound/soc/s3c24xx/s3c24xx-pcm.h
index 0088c79..8cbc071 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.h
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.h
@@ -9,13 +9,13 @@
  *  ALSA PCM interface for the Samsung S3C24xx CPU
  */
 
-#ifndef _S3C24XX_PCM_H
-#define _S3C24XX_PCM_H
+#ifndef _S3C_AUDIO_H
+#define _S3C_AUDIO_H
 
 #define ST_RUNNING		(1<<0)
 #define ST_OPENED		(1<<1)
 
-struct s3c24xx_pcm_dma_params {
+struct s3c_dma_params {
 	struct s3c2410_dma_client *client;	/* stream identifier */
 	int channel;				/* Channel ID */
 	dma_addr_t dma_addr;
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index d68cae1..719d63c 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -46,7 +46,7 @@ static struct s3c2410_dma_client s3c64xx_dma_client_in = {
 	.name		= "I2S PCM Stereo in"
 };
 
-static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_out[2] = {
+static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[2] = {
 	[0] = {
 		.channel	= DMACH_I2S0_OUT,
 		.client		= &s3c64xx_dma_client_out,
@@ -61,7 +61,7 @@ static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_out[2] = {
 	},
 };
 
-static struct s3c24xx_pcm_dma_params s3c64xx_i2s_pcm_stereo_in[2] = {
+static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[2] = {
 	[0] = {
 		.channel	= DMACH_I2S0_IN,
 		.client		= &s3c64xx_dma_client_in,
-- 
1.6.2.5
