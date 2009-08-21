From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Fri, 21 Aug 2009 18:00:39 +0800
Message-ID: <1250848839.3928.6.camel@shinel>
References: <1250761331.4412.70.camel@shinel>
	<20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl> <20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl>  <20090820184714.GD5032@sirena.org.uk>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg94.qq.com (smtpbg94.qq.com [119.147.10.253])
	by alsa0.perex.cz (Postfix) with SMTP id 9AFC02454F
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Aug 2009 12:01:56 +0200 (CEST)
In-Reply-To: <20090820184714.GD5032@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> 
> It's called ultimately by user space; within ASoC it's always called by
> the core trigger function in the fixed order that it has.  The open()
> callback would be a safe place to do the setup - that's called before
> anything else.
> 
> 

I've finished a draft patch in the callback manner. Waiting for any
suggestion. Thanks.


-----------------------------------------------------------------

diff -Nur a/arch/arm/plat-s3c24xx/include/plat/dma-plat.h b/arch/arm/plat-s3c24xx/include/plat/dma-plat.h
--- a/arch/arm/plat-s3c24xx/include/plat/dma-plat.h	2009-08-14 06:43:34.000000000 +0800
+++ b/arch/arm/plat-s3c24xx/include/plat/dma-plat.h	2009-08-21 14:14:12.000000000 +0800
@@ -76,6 +76,27 @@
 
 extern int s3c24xx_dma_order_set(struct s3c24xx_dma_order *map);
 
+enum s3c24xx_dma_channel_event {
+	CHANNEL_EVENT_START,
+	CHANNEL_EVENT_STOP,
+	CHANNEL_EVENT_MAX,
+};
+
+struct s3c24xx_dma_channel_trigger {
+	unsigned int channel;
+	/* trigger event */
+	enum s3c24xx_dma_channel_event event;
+	/* pravate date to the callback function */
+	void *private_data;
+	/* callback funtion to generate the DMA REQ signal */
+	void (*gen_request)(void *private_data);
+	/* callback funtion to end the DMA request */
+	void (*end_request)(void *private_data);
+};
+
+/* trigger the DMA engine to start, called from the client */
+extern void s3c24xx_dma_trigger(struct s3c24xx_dma_channel_trigger *client);
+
 /* DMA init code, called from the cpu support code */
 
 extern int s3c2410_dma_init(void);
diff -Nur a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
--- a/arch/arm/plat-s3c24xx/dma.c	2009-08-14 06:43:34.000000000 +0800
+++ b/arch/arm/plat-s3c24xx/dma.c	2009-08-21 14:30:41.000000000 +0800
@@ -1008,6 +1008,34 @@
 
 EXPORT_SYMBOL(s3c2410_dma_ctrl);
 
+void s3c24xx_dma_trigger(struct s3c24xx_dma_channel_trigger *client)
+{
+	if(!client || !(client->channel < DMACH_MAX)) {
+ 		pr_debug("%s: Invalid parameter\n", __func__);
+		return;
+	}
+
+	switch(client->event) {
+	case CHANNEL_EVENT_START:
+		s3c2410_dma_ctrl(client->channel, S3C2410_DMAOP_START);
+		if(client->gen_request)
+			client->gen_request(client->private_data);
+		s3c2410_dma_ctrl(client->channel, S3C2410_DMAOP_STARTED);
+		return;
+	case CHANNEL_EVENT_STOP:
+		s3c2410_dma_ctrl(client->channel, S3C2410_DMAOP_STOP);
+		if(client->end_request)
+			client->end_request(client->private_data);
+		/* should be set to a vaild value in the next request */
+		client->channel = DMACH_MAX;
+		return;
+	default:
+		pr_debug("%s: Invalid event\n", __func__);
+	}
+}
+
+EXPORT_SYMBOL(s3c24xx_dma_trigger);
+
 /* DMA configuration for each channel
  *
  * DISRCC -> source of the DMA (AHB,APB)
diff -Nur a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-08-14 06:43:34.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-08-21 15:08:07.000000000 +0800
@@ -38,6 +38,7 @@
 
 #include <plat/regs-iis.h>
 
+#define __USE_S3C24XX_PCM_RUNTIME
 #include "s3c24xx-pcm.h"
 #include "s3c24xx-i2s.h"
 
@@ -278,6 +279,7 @@
 static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
+	struct s3c24xx_pcm_runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
 
 	pr_debug("Entered %s\n", __func__);
@@ -292,24 +294,32 @@
 				goto exit_err;
 		}
 
+		spin_lock(&prtd->lock);
+		prtd->client.private_data= (void *)1;
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			s3c24xx_snd_rxctrl(1);
+			prtd->client.gen_request = (void *)s3c24xx_snd_rxctrl;
 		else
-			s3c24xx_snd_txctrl(1);
+			prtd->client.gen_request = (void *)s3c24xx_snd_txctrl;
+		spin_unlock(&prtd->lock);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		spin_lock(&prtd->lock);
+		prtd->client.private_data= (void *)0;
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			s3c24xx_snd_rxctrl(0);
+			prtd->client.end_request = (void *)s3c24xx_snd_rxctrl;
 		else
-			s3c24xx_snd_txctrl(0);
+			prtd->client.end_request = (void *)s3c24xx_snd_txctrl;
+		spin_unlock(&prtd->lock);
 		break;
 	default:
 		ret = -EINVAL;
-		break;
+		goto exit_err;
 	}
 
+	s3c24xx_dma_trigger(&prtd->client);
+
 exit_err:
 	return ret;
 }
diff -Nur a/sound/soc/s3c24xx/s3c24xx-pcm.h b/sound/soc/s3c24xx/s3c24xx-pcm.h
--- a/sound/soc/s3c24xx/s3c24xx-pcm.h	2009-08-14 06:43:34.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.h	2009-08-21 14:40:05.000000000 +0800
@@ -22,6 +22,25 @@
 	int dma_size;			/* Size of the DMA transfer */
 };
 
+#ifdef __USE_S3C24XX_PCM_RUNTIME
+
+#include <plat/dma-plat.h>
+
+struct s3c24xx_pcm_runtime_data {
+	spinlock_t lock;
+	int state;
+	unsigned int dma_loaded;
+	unsigned int dma_limit;
+	unsigned int dma_period;
+	dma_addr_t dma_start;
+	dma_addr_t dma_pos;
+	dma_addr_t dma_end;
+	struct s3c24xx_pcm_dma_params *params;
+	struct s3c24xx_dma_channel_trigger client;
+};
+
+#endif
+
 #define S3C24XX_DAI_I2S			0
 
 /* platform data */
diff -Nur a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-08-14 06:43:34.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-08-21 14:47:29.000000000 +0800
@@ -31,6 +31,7 @@
 #include <mach/dma.h>
 #include <plat/audio.h>
 
+#define __USE_S3C24XX_PCM_RUNTIME
 #include "s3c24xx-pcm.h"
 
 static const struct snd_pcm_hardware s3c24xx_pcm_hardware = {
@@ -54,18 +55,6 @@
 	.fifo_size		= 32,
 };
 
-struct s3c24xx_runtime_data {
-	spinlock_t lock;
-	int state;
-	unsigned int dma_loaded;
-	unsigned int dma_limit;
-	unsigned int dma_period;
-	dma_addr_t dma_start;
-	dma_addr_t dma_pos;
-	dma_addr_t dma_end;
-	struct s3c24xx_pcm_dma_params *params;
-};
-
 /* s3c24xx_pcm_enqueue
  *
  * place a dma buffer onto the queue for the dma system
@@ -73,7 +62,7 @@
 */
 static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
 {
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	struct s3c24xx_pcm_runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
 	int ret;
 
@@ -110,7 +99,7 @@
 				enum s3c2410_dma_buffresult result)
 {
 	struct snd_pcm_substream *substream = dev_id;
-	struct s3c24xx_runtime_data *prtd;
+	struct s3c24xx_pcm_runtime_data *prtd;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -135,7 +124,7 @@
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	struct s3c24xx_pcm_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct s3c24xx_pcm_dma_params *dma = rtd->dai->cpu_dai->dma_data;
 	unsigned long totbytes = params_buffer_bytes(params);
@@ -187,7 +176,7 @@
 
 static int s3c24xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	struct s3c24xx_pcm_runtime_data *prtd = substream->runtime->private_data;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -204,7 +193,7 @@
 
 static int s3c24xx_pcm_prepare(struct snd_pcm_substream *substream)
 {
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	struct s3c24xx_pcm_runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
 
 	pr_debug("Entered %s\n", __func__);
@@ -242,7 +231,7 @@
 
 static int s3c24xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	struct s3c24xx_pcm_runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
 
 	pr_debug("Entered %s\n", __func__);
@@ -254,15 +243,15 @@
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		prtd->state |= ST_RUNNING;
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_START);
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STARTED);
+		prtd->client.channel = prtd->params->channel;
+		prtd->client.event = CHANNEL_EVENT_START;
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		prtd->state &= ~ST_RUNNING;
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STOP);
+		prtd->client.event = CHANNEL_EVENT_STOP;
 		break;
 
 	default:
@@ -279,7 +268,7 @@
 s3c24xx_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	struct s3c24xx_pcm_runtime_data *prtd = runtime->private_data;
 	unsigned long res;
 	dma_addr_t src, dst;
 
@@ -314,16 +303,18 @@
 static int s3c24xx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd;
+	struct s3c24xx_pcm_runtime_data *prtd;
 
 	pr_debug("Entered %s\n", __func__);
 
 	snd_soc_set_runtime_hwparams(substream, &s3c24xx_pcm_hardware);
 
-	prtd = kzalloc(sizeof(struct s3c24xx_runtime_data), GFP_KERNEL);
+	prtd = kzalloc(sizeof(struct s3c24xx_pcm_runtime_data), GFP_KERNEL);
 	if (prtd == NULL)
 		return -ENOMEM;
 
+	prtd->client.channel = DMACH_MAX;
+
 	spin_lock_init(&prtd->lock);
 
 	runtime->private_data = prtd;
@@ -333,7 +324,7 @@
 static int s3c24xx_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	struct s3c24xx_pcm_runtime_data *prtd = runtime->private_data;
 
 	pr_debug("Entered %s\n", __func__);
