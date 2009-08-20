From: Shine Liu <shinel@foxmail.com>
Subject: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Thu, 20 Aug 2009 17:42:11 +0800
Message-ID: <1250761331.4412.70.camel@shinel>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg74.qq.com (smtpbg74.qq.com [119.147.10.233])
	by alsa0.perex.cz (Postfix) with SMTP id DE805103838
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 11:42:42 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

s3c24xx dma has the auto reload feature, when the the trnasfer is done,
CURR_TC(DSTAT[19:0], current value of transfer count) reaches 0, and DMA
ACK becomes 1, and then, TC(DCON[19:0]) will be loaded into CURR_TC. So
the transmission is repeated.

IRQ is issued while auto reload occurs. We change the DISRC and
DCON[19:0] in the ISR, but at this time, the auto reload has been
performed already. The first block is being re-transmitted by the DMA.

So we need rewrite the DISRC and DCON[19:0] for the next block
immediatly after the this block has been started to be transported.

The function s3c2410_dma_started() is for this perpose, which is called
in the form of "s3c2410_dma_ctrl(prtd->params->channel,
S3C2410_DMAOP_STARTED);" in s3c24xx_pcm_trigger().

But it is not correct. DMA transmission won't start until DMA REQ signal
arrived, it is the time s3c24xx_snd_txctrl(1) or s3c24xx_snd_rxctrl(1)
is called in s3c24xx_i2s_trigger().

In the current framework, s3c24xx_pcm_trigger() is always called before
s3c24xx_pcm_trigger(). So the s3c2410_dma_started() should be called in
s3c24xx_pcm_trigger() after s3c24xx_snd_txctrl(1) or
s3c24xx_snd_rxctrl(1) is called in this function.

However, s3c2410_dma_started() is dma related, to call this function we
should provide the channel number, which is given by
substream->runtime->private_data->params->channel. The private_data
points to a struct s3c24xx_runtime_data object, which is define in
s3c24xx_pcm.c, so s3c2410_dma_started() can't be called in s3c24xx_i2s.c

To move the struct s3c24xx_runtime_data defination to s3c24xx-pcm.h is
one solution.

If not moved, the patch shold be like:


Signed-off-by: Shine Liu <shinel@foxmail.com>
----------------------------------------------------------------

--- a/sound/soc/s3c24xx/s3c24xx-pcm.h	2009-08-14 06:43:34.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.h	2009-08-20 16:06:14.000000000 +0800
@@ -28,4 +28,6 @@
 extern struct snd_soc_platform s3c24xx_soc_platform;
 extern struct snd_ac97_bus_ops s3c24xx_ac97_ops;
 
+void s3c24xx_pcm_dma_started(struct snd_pcm_substream *substream);
+
 #endif
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-08-14 06:43:34.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-08-20 15:56:46.000000000 +0800
@@ -66,6 +66,28 @@
 	struct s3c24xx_pcm_dma_params *params;
 };
 
+/* s3c24xx_pcm_dma_started
+ *
+ * To load the second dma buffer immediately after the 
+ * first dma buffer has been started transferring, so that 
+ * in the dma autoreload situation, the first data block
+ * won't be re-transferred after the first irq issued.
+ * 
+ * This function is called in the s3c24xx-i2s-trigger() of 
+ * s3c24xx-i2s.c, just after the dma transfer is really started.
+ *
+ * It's ugly here. Need a elegant way to fix this bug.
+ * FIXME
+ *
+ */
+
+void s3c24xx_pcm_dma_started(struct snd_pcm_substream *substream)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STARTED);
+
+}
+
 /* s3c24xx_pcm_enqueue
  *
  * place a dma buffer onto the queue for the dma system
@@ -255,7 +277,6 @@
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		prtd->state |= ST_RUNNING;
 		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_START);
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STARTED);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-08-14 06:43:34.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-08-20 16:08:06.000000000 +0800
@@ -296,6 +296,9 @@
 			s3c24xx_snd_rxctrl(1);
 		else
 			s3c24xx_snd_txctrl(1);
+
+		/* DMA transfer is really started, equeue the next buffer */
+		s3c24xx_pcm_dma_started(substream);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
