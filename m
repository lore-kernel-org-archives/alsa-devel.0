From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 09/11] ASoC: S3C: I2S: Move set_sysclk to
	common code
Date: Tue, 27 Apr 2010 15:57:05 +0900
Message-ID: <1272351425-3946-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F52524832
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 09:00:24 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Now that we can specify feature of a particular controller, we can
avoid multiple copies of same code by defining the CDCLKCON bit
feature in controller specific code and detecting that flag in the
code common to all controllers.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   47 +++++++++++++++++++++++++++++++++++++++
 sound/soc/s3c24xx/s3c2412-i2s.c |   27 ----------------------
 sound/soc/s3c24xx/s3c64xx-i2s.c |   43 ++---------------------------------
 3 files changed, 50 insertions(+), 67 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index ac153ca..13311c8 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -342,6 +342,52 @@ static int s3c_i2sv2_hw_params(struct snd_pcm_substream *substream,
 
 	writel(iismod, i2s->regs + S3C2412_IISMOD);
 	pr_debug("%s: w: IISMOD: %x\n", __func__, iismod);
+
+	return 0;
+}
+
+static int s3c_i2sv2_set_sysclk(struct snd_soc_dai *cpu_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
+
+	pr_debug("Entered %s\n", __func__);
+	pr_debug("%s r: IISMOD: %x\n", __func__, iismod);
+
+	switch (clk_id) {
+	case S3C_I2SV2_CLKSRC_PCLK:
+		iismod &= ~S3C2412_IISMOD_IMS_SYSMUX;
+		break;
+
+	case S3C_I2SV2_CLKSRC_AUDIOBUS:
+		iismod |= S3C2412_IISMOD_IMS_SYSMUX;
+		break;
+
+	case S3C_I2SV2_CLKSRC_CDCLK:
+		/* Error if controller doesn't have the CDCLKCON bit */
+		if (!(i2s->feature & S3C_FEATURE_CDCLKCON))
+			return -EINVAL;
+
+		switch (dir) {
+		case SND_SOC_CLOCK_IN:
+			iismod |= S3C64XX_IISMOD_CDCLKCON;
+			break;
+		case SND_SOC_CLOCK_OUT:
+			iismod &= ~S3C64XX_IISMOD_CDCLKCON;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	pr_debug("%s w: IISMOD: %x\n", __func__, iismod);
+
 	return 0;
 }
 
@@ -714,6 +760,7 @@ int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
 		ops->hw_params = s3c_i2sv2_hw_params;
 	ops->set_fmt = s3c2412_i2s_set_fmt;
 	ops->set_clkdiv = s3c2412_i2s_set_clkdiv;
+	ops->set_sysclk = s3c_i2sv2_set_sysclk;
 
 	/* Allow overriding by (for example) IISv4 */
 	if (!ops->delay)
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 6b884d7..709adef 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -65,32 +65,6 @@ static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
 
 static struct s3c_i2sv2_info s3c2412_i2s;
 
-/*
- * Set S3C2412 Clock source
- */
-static int s3c2412_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
-				  int clk_id, unsigned int freq, int dir)
-{
-	u32 iismod = readl(s3c2412_i2s.regs + S3C2412_IISMOD);
-
-	pr_debug("%s(%p, %d, %u, %d)\n", __func__, cpu_dai, clk_id,
-	    freq, dir);
-
-	switch (clk_id) {
-	case S3C2412_CLKSRC_PCLK:
-		iismod &= ~S3C2412_IISMOD_IMS_SYSMUX;
-		break;
-	case S3C2412_CLKSRC_I2SCLK:
-		iismod |= S3C2412_IISMOD_IMS_SYSMUX;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	writel(iismod, s3c2412_i2s.regs + S3C2412_IISMOD);
-	return 0;
-}
-
 static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
 {
 	return cpu_dai->private_data;
@@ -175,7 +149,6 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 static struct snd_soc_dai_ops s3c2412_i2s_dai_ops = {
-	.set_sysclk	= s3c2412_i2s_set_sysclk,
 	.hw_params	= s3c2412_i2s_hw_params,
 };
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 6d49bd9..1d85cb8 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -54,43 +54,6 @@ static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
 	return cpu_dai->private_data;
 }
 
-static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
-				  int clk_id, unsigned int freq, int dir)
-{
-	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
-	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-	switch (clk_id) {
-	case S3C64XX_CLKSRC_PCLK:
-		iismod &= ~S3C2412_IISMOD_IMS_SYSMUX;
-		break;
-
-	case S3C64XX_CLKSRC_MUX:
-		iismod |= S3C2412_IISMOD_IMS_SYSMUX;
-		break;
-
-	case S3C64XX_CLKSRC_CDCLK:
-		switch (dir) {
-		case SND_SOC_CLOCK_IN:
-			iismod |= S3C64XX_IISMOD_CDCLKCON;
-			break;
-		case SND_SOC_CLOCK_OUT:
-			iismod &= ~S3C64XX_IISMOD_CDCLKCON;
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	writel(iismod, i2s->regs + S3C2412_IISMOD);
-
-	return 0;
-}
-
 static int s3c64xx_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
 {
@@ -115,9 +78,7 @@ static int s3c64xx_i2s_probe(struct platform_device *pdev,
 }
 
 
-static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops = {
-	.set_sysclk	= s3c64xx_i2s_set_sysclk,	
-};
+static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops;
 
 static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 {
@@ -147,6 +108,8 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 	dai->probe = s3c64xx_i2s_probe;
 	dai->ops = &s3c64xx_i2s_dai_ops;
 
+	i2s->feature |= S3C_FEATURE_CDCLKCON;
+
 	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
 	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
 
-- 
1.6.2.5
