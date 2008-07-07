From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 09/10] asoc: s3c24xx - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:08:24 +0100
Message-ID: <1215443304.4882.186.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E96FF10381A
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:08:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


This patch merges struct snd_soc_codec_dai and struct
snd_soc_cpu_dai into struct snd_soc_dai for the S3C24xx platform.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |   12 ++++++------
 sound/soc/s3c24xx/s3c2412-i2s.c    |   14 +++++++-------
 sound/soc/s3c24xx/s3c2412-i2s.h    |    2 +-
 sound/soc/s3c24xx/s3c2443-ac97.c   |   10 +++++-----
 sound/soc/s3c24xx/s3c24xx-ac97.h   |    2 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c    |   14 +++++++-------
 sound/soc/s3c24xx/s3c24xx-i2s.h    |    2 +-
 sound/soc/s3c24xx/s3c24xx-pcm.c    |    2 +-
 8 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index f053e85..51a4ce3 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -66,8 +66,8 @@ static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	unsigned int pll_out = 0, bclk = 0;
 	int ret = 0;
 	unsigned long iis_clkrate;
@@ -156,7 +156,7 @@ static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
 static int neo1973_hifi_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 
 	DBG("Entered %s\n", __func__);
 
@@ -176,7 +176,7 @@ static int neo1973_voice_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	unsigned int pcmdiv = 0;
 	int ret = 0;
 	unsigned long iis_clkrate;
@@ -222,7 +222,7 @@ static int neo1973_voice_hw_params(struct snd_pcm_substream *substream,
 static int neo1973_voice_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 
 	DBG("Entered %s\n", __func__);
 
@@ -546,7 +546,7 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 /*
  * BT Codec DAI
  */
-static struct snd_soc_cpu_dai bt_dai = {
+static struct snd_soc_dai bt_dai = {
 	.name = "Bluetooth",
 	.id = 0,
 	.type = SND_SOC_DAI_PCM,
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index c463a82..ee4676e 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -295,7 +295,7 @@ static inline int s3c2412_snd_is_clkmaster(void)
 /*
  * Set S3C2412 I2S DAI format
  */
-static int s3c2412_i2s_set_fmt(struct snd_soc_cpu_dai *cpu_dai,
+static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 			       unsigned int fmt)
 {
 	u32 iismod;
@@ -500,7 +500,7 @@ EXPORT_SYMBOL_GPL(s3c2412_iis_calc_rate);
 /*
  * Set S3C2412 Clock source
  */
-static int s3c2412_i2s_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+static int s3c2412_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
 	u32 iismod = readl(s3c2412_i2s.regs + S3C2412_IISMOD);
@@ -528,7 +528,7 @@ static int s3c2412_i2s_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 /*
  * Set S3C2412 Clock dividers
  */
-static int s3c2412_i2s_set_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
+static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
 				  int div_id, int div)
 {
 	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
@@ -602,7 +602,7 @@ EXPORT_SYMBOL_GPL(s3c2412_get_iisclk);
 
 
 static int s3c2412_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_cpu_dai *dai)
+			     struct snd_soc_dai *dai)
 {
 	DBG("Entered %s\n", __func__);
 
@@ -648,7 +648,7 @@ static int s3c2412_i2s_probe(struct platform_device *pdev,
 
 #ifdef CONFIG_PM
 static int s3c2412_i2s_suspend(struct platform_device *dev,
-			      struct snd_soc_cpu_dai *dai)
+			      struct snd_soc_dai *dai)
 {
 	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
 	u32 iismod;
@@ -676,7 +676,7 @@ static int s3c2412_i2s_suspend(struct platform_device *dev,
 }
 
 static int s3c2412_i2s_resume(struct platform_device *pdev,
-			      struct snd_soc_cpu_dai *dai)
+			      struct snd_soc_dai *dai)
 {
 	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
 
@@ -708,7 +708,7 @@ static int s3c2412_i2s_resume(struct platform_device *pdev,
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
 	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
-struct snd_soc_cpu_dai s3c2412_i2s_dai = {
+struct snd_soc_dai s3c2412_i2s_dai = {
 	.name	= "s3c2412-i2s",
 	.id	= 0,
 	.type	= SND_SOC_DAI_I2S,
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.h b/sound/soc/s3c24xx/s3c2412-i2s.h
index 27f48e1..aac08a2 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.h
+++ b/sound/soc/s3c24xx/s3c2412-i2s.h
@@ -24,7 +24,7 @@
 
 extern struct clk *s3c2412_get_iisclk(void);
 
-extern struct snd_soc_cpu_dai s3c2412_i2s_dai;
+extern struct snd_soc_dai s3c2412_i2s_dai;
 
 struct s3c2412_rate_calc {
 	unsigned int	clk_div;	/* for prescaler */
diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
index 533565b..783349b 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -210,7 +210,7 @@ static struct s3c24xx_pcm_dma_params s3c2443_ac97_mic_mono_in = {
 };
 
 static int s3c2443_ac97_probe(struct platform_device *pdev,
-			      struct snd_soc_cpu_dai *dai)
+			      struct snd_soc_dai *dai)
 {
 	int ret;
 	u32 ac_glbctrl;
@@ -262,7 +262,7 @@ static int s3c2443_ac97_probe(struct platform_device *pdev,
 }
 
 static void s3c2443_ac97_remove(struct platform_device *pdev,
-				struct snd_soc_cpu_dai *dai)
+				struct snd_soc_dai *dai)
 {
 	free_irq(IRQ_S3C244x_AC97, NULL);
 	clk_disable(s3c24xx_ac97.ac97_clk);
@@ -274,7 +274,7 @@ static int s3c2443_ac97_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		cpu_dai->dma_data = &s3c2443_ac97_pcm_stereo_out;
@@ -316,7 +316,7 @@ static int s3c2443_ac97_hw_mic_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
@@ -352,7 +352,7 @@ static int s3c2443_ac97_mic_trigger(struct snd_pcm_substream *substream,
 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
 		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
 
-struct snd_soc_cpu_dai s3c2443_ac97_dai[] = {
+struct snd_soc_dai s3c2443_ac97_dai[] = {
 {
 	.name = "s3c2443-ac97",
 	.id = 0,
diff --git a/sound/soc/s3c24xx/s3c24xx-ac97.h b/sound/soc/s3c24xx/s3c24xx-ac97.h
index bf03e8e..a96dcad 100644
--- a/sound/soc/s3c24xx/s3c24xx-ac97.h
+++ b/sound/soc/s3c24xx/s3c24xx-ac97.h
@@ -26,6 +26,6 @@
 #define IRQ_S3C244x_AC97 IRQ_S3C2443_AC97
 #endif
 
-extern struct snd_soc_cpu_dai s3c2443_ac97_dai[];
+extern struct snd_soc_dai s3c2443_ac97_dai[];
 
 #endif /*S3C24XXAC97_H_*/
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 42e96b5..3975242 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -205,7 +205,7 @@ static inline int s3c24xx_snd_is_clkmaster(void)
 /*
  * Set S3C24xx I2S DAI format
  */
-static int s3c24xx_i2s_set_fmt(struct snd_soc_cpu_dai *cpu_dai,
+static int s3c24xx_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
 	u32 iismod;
@@ -313,7 +313,7 @@ exit_err:
 /*
  * Set S3C24xx Clock source
  */
-static int s3c24xx_i2s_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+static int s3c24xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 	int clk_id, unsigned int freq, int dir)
 {
 	u32 iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
@@ -339,7 +339,7 @@ static int s3c24xx_i2s_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 /*
  * Set S3C24xx Clock dividers
  */
-static int s3c24xx_i2s_set_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
+static int s3c24xx_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
 	int div_id, int div)
 {
 	u32 reg;
@@ -378,7 +378,7 @@ u32 s3c24xx_i2s_get_clockrate(void)
 EXPORT_SYMBOL_GPL(s3c24xx_i2s_get_clockrate);
 
 static int s3c24xx_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_cpu_dai *dai)
+			     struct snd_soc_dai *dai)
 {
 	DBG("Entered %s\n", __func__);
 
@@ -411,7 +411,7 @@ static int s3c24xx_i2s_probe(struct platform_device *pdev,
 
 #ifdef CONFIG_PM
 static int s3c24xx_i2s_suspend(struct platform_device *pdev,
-		struct snd_soc_cpu_dai *cpu_dai)
+		struct snd_soc_dai *cpu_dai)
 {
 	DBG("Entered %s\n", __func__);
 
@@ -426,7 +426,7 @@ static int s3c24xx_i2s_suspend(struct platform_device *pdev,
 }
 
 static int s3c24xx_i2s_resume(struct platform_device *pdev,
-		struct snd_soc_cpu_dai *cpu_dai)
+		struct snd_soc_dai *cpu_dai)
 {
 	DBG("Entered %s\n", __func__);
 	clk_enable(s3c24xx_i2s.iis_clk);
@@ -449,7 +449,7 @@ static int s3c24xx_i2s_resume(struct platform_device *pdev,
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
 	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
-struct snd_soc_cpu_dai s3c24xx_i2s_dai = {
+struct snd_soc_dai s3c24xx_i2s_dai = {
 	.name = "s3c24xx-i2s",
 	.id = 0,
 	.type = SND_SOC_DAI_I2S,
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.h b/sound/soc/s3c24xx/s3c24xx-i2s.h
index 537b4ec..726d91c 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.h
@@ -32,6 +32,6 @@
 
 u32 s3c24xx_i2s_get_clockrate(void);
 
-extern struct snd_soc_cpu_dai s3c24xx_i2s_dai;
+extern struct snd_soc_dai s3c24xx_i2s_dai;
 
 #endif /*S3C24XXI2S_H_*/
diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index ef59974..cef79b3 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -429,7 +429,7 @@ static void s3c24xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 static u64 s3c24xx_pcm_dmamask = DMA_32BIT_MASK;
 
 static int s3c24xx_pcm_new(struct snd_card *card,
-	struct snd_soc_codec_dai *dai, struct snd_pcm *pcm)
+	struct snd_soc_dai *dai, struct snd_pcm *pcm)
 {
 	int ret = 0;
 
-- 
1.5.4.2
