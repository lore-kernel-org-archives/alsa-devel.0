From: Shine Liu <shinel@foxmail.com>
Subject: [PATCH] ASoC: S3C platform: Fix s3c2410_dma_started()
 called at improper time
Date: Tue, 25 Aug 2009 11:04:26 +0800
Message-ID: <1251169466.4272.22.camel@shinel>
References: <1250761331.4412.70.camel@shinel>
	<20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl> <20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl> <20090820184714.GD5032@sirena.org.uk>
	<1250848839.3928.6.camel@shinel>
	<20090823102841.GA737@opensource.wolfsonmicro.com>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg77.qq.com (smtpbg77.qq.com [119.147.10.236])
	by alsa0.perex.cz (Postfix) with SMTP id 20F6B24415
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 05:05:06 +0200 (CEST)
In-Reply-To: <20090823102841.GA737@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org


Hi Mark,

    There's a candidate patch for the bug of s3c2410_dma_started()
called at improper time. This patch also covers all S3C I2C/AC97 ASoC
drivers affected by this bug.

    The previous patches try to fix this bug in the DMA callback way. It
's elegant and should be the proper way to fix the bug but the changes
is a little large and need be well discussed and tested.

     I think before we fix the bug in the callback way, we can use this
patch provisionally for a while though it seems a little ugly. 

     This patch is created against linux-2.6.31-rc7, and has been well
tested under s3c2440 platform with I2S DAI.

Best Regards,

Shine 



Signed-off-by: Shine Liu <liuxian@redflag-linux.com>
----------------------------------------------------


--- a/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-08-24 15:57:23.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c	2009-08-25 10:29:12.000000000 +0800
@@ -255,7 +255,6 @@
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		prtd->state |= ST_RUNNING;
 		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_START);
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STARTED);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-08-24 15:57:23.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c	2009-08-25 10:05:02.000000000 +0800
@@ -279,9 +279,14 @@
 			       struct snd_soc_dai *dai)
 {
 	int ret = 0;
+	int channel;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
 	pr_debug("Entered %s\n", __func__);
 
+	channel = ((struct s3c24xx_pcm_dma_params *)
+		  rtd->dai->cpu_dai->dma_data)->channel;
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -296,6 +301,13 @@
 			s3c24xx_snd_rxctrl(1);
 		else
 			s3c24xx_snd_txctrl(1);
+		/* DMA engine has just been started at this point,
+		 * load the next buffer to DMA to meet the reqirement 
+		 * of the auto reload mechanism.
+		 * Ugly here, but it is the simplest way.
+		 * Will be fixed if DMA callback API provided.
+		 */
+		s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
--- a/sound/soc/s3c24xx/s3c2443-ac97.c	2009-08-24 15:57:23.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c	2009-08-25 10:08:57.000000000 +0800
@@ -290,6 +290,9 @@
 				struct snd_soc_dai *dai)
 {
 	u32 ac_glbctrl;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int channel = ((struct s3c24xx_pcm_dma_params *)
+		  rtd->dai->cpu_dai->dma_data)->channel;
 
 	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
 	switch (cmd) {
@@ -312,6 +315,14 @@
 	}
 	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
 
+	/* DMA engine has just been started at this point,
+	 * load the next buffer to DMA to meet the reqirement 
+	 * of the auto reload mechanism.
+	 * Ugly here, but it is the simplest way.
+	 * Will be fixed if DMA callback API provided.
+	 */
+	s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
+
 	return 0;
 }
 
@@ -334,6 +345,9 @@
 				    int cmd, struct snd_soc_dai *dai)
 {
 	u32 ac_glbctrl;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int channel = ((struct s3c24xx_pcm_dma_params *)
+		  rtd->dai->cpu_dai->dma_data)->channel;
 
 	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
 	switch (cmd) {
@@ -349,6 +363,14 @@
 	}
 	writel(ac_glbctrl, s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
 
+	/* DMA engine has just been started at this point,
+	 * load the next buffer to DMA to meet the reqirement 
+	 * of the auto reload mechanism.
+	 * Ugly here, but it is the simplest way.
+	 * Will be fixed if DMA callback API provided.
+	 */
+	s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
+
 	return 0;
 }
 
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c	2009-08-25 10:25:40.000000000 +0800
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c	2009-08-25 10:15:34.000000000 +0800
@@ -387,6 +387,8 @@
 	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 	unsigned long irqs;
 	int ret = 0;
+	int channel = ((struct s3c24xx_pcm_dma_params *)
+		  rtd->dai->cpu_dai->dma_data)->channel;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -416,6 +418,18 @@
 			s3c2412_snd_txctrl(i2s, 1);
 
 		local_irq_restore(irqs);
+
+		/* DMA engine has just been started at this point,
+		 * load the next buffer to DMA to meet the reqirement 
+		 * of the auto reload mechanism.
+		 * Ugly here, but it is the simplest way.
+		 * Will be fixed if DMA callback API provided.
+		 * 
+		 * S3C64XX doesn't have the auto reload problem, 
+		 * only for S3C24XX. This call won't bother S3C64XX.
+		 */
+		s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
+
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
