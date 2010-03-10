From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 09/20] ASoC: S3C: I2Sv2: Segregate hw_params
	callback
Date: Wed, 10 Mar 2010 16:48:58 +0900
Message-ID: <1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 99B33103821
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 08:58:03 +0100 (CET)
In-Reply-To: <1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
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

Towards having build for multiple SoCs segregate hw_params callback
for s3c2412 and s3c64xx.
Since, all new SoCs have s3c64xx like register map, we keep that as
default implementation if no SoC specific callback is already defined.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   18 +++---------------
 sound/soc/s3c24xx/s3c2412-i2s.c |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 170b3c1..0d655ab 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -312,7 +312,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
-static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
+static int s3c_i2sv2_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *socdai)
 {
@@ -332,18 +332,6 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 	iismod = readl(i2s->regs + S3C2412_IISMOD);
 	pr_debug("%s: r: IISMOD: %x\n", __func__, iismod);
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		iismod |= S3C2412_IISMOD_8BIT;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		iismod &= ~S3C2412_IISMOD_8BIT;
-		break;
-	}
-#endif
-
-#ifdef CONFIG_PLAT_S3C64XX
 	iismod &= ~S3C64XX_IISMOD_BLC_MASK;
 	/* Sample size */
 	switch (params_format(params)) {
@@ -356,7 +344,6 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 		iismod |= S3C64XX_IISMOD_BLC_24BIT;
 		break;
 	}
-#endif
 
 	writel(iismod, i2s->regs + S3C2412_IISMOD);
 	pr_debug("%s: w: IISMOD: %x\n", __func__, iismod);
@@ -716,7 +703,8 @@ int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
 	struct snd_soc_dai_ops *ops = dai->ops;
 
 	ops->trigger = s3c2412_i2s_trigger;
-	ops->hw_params = s3c2412_i2s_hw_params;
+	if (!ops->hw_params)
+		ops->hw_params = s3c_i2sv2_hw_params;
 	ops->set_fmt = s3c2412_i2s_set_fmt;
 	ops->set_clkdiv = s3c2412_i2s_set_clkdiv;
 
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 359e593..a5b21f6 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -103,6 +103,10 @@ struct clk *s3c2412_get_iisclk(void)
 }
 EXPORT_SYMBOL_GPL(s3c2412_get_iisclk);
 
+static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
+{
+	return cpu_dai->private_data;
+}
 
 static int s3c2412_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
@@ -142,6 +146,38 @@ static int s3c2412_i2s_probe(struct platform_device *pdev,
 	return 0;
 }
 
+static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *cpu_dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 iismod;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		cpu_dai->dma_data = i2s->dma_playback;
+	else
+		cpu_dai->dma_data = i2s->dma_capture;
+
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	pr_debug("%s: r: IISMOD: %x\n", __func__, iismod);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		iismod |= S3C2412_IISMOD_8BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		iismod &= ~S3C2412_IISMOD_8BIT;
+		break;
+	}
+
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
+	pr_debug("%s: w: IISMOD: %x\n", __func__, iismod);
+
+	return 0;
+}
+
 #define S3C2412_I2S_RATES \
 	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
@@ -149,6 +185,7 @@ static int s3c2412_i2s_probe(struct platform_device *pdev,
 
 static struct snd_soc_dai_ops s3c2412_i2s_dai_ops = {
 	.set_sysclk	= s3c2412_i2s_set_sysclk,
+	.hw_params	= s3c2412_i2s_hw_params,
 };
 
 struct snd_soc_dai s3c2412_i2s_dai = {
-- 
1.6.2.5
