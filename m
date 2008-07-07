From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 03/10] asoc: at91 - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:07:37 +0100
Message-ID: <1215443257.4882.180.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E545924615
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:07:38 +0200 (CEST)
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
snd_soc_cpu_dai into struct snd_soc_dai for the AT91 platform.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/at91/at91-pcm.c      |    6 +++---
 sound/soc/at91/at91-ssc.c      |   12 ++++++------
 sound/soc/at91/at91-ssc.h      |    2 +-
 sound/soc/at91/eti_b1_wm8731.c |    8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/at91/at91-pcm.c b/sound/soc/at91/at91-pcm.c
index ccac6bd..d47492b 100644
--- a/sound/soc/at91/at91-pcm.c
+++ b/sound/soc/at91/at91-pcm.c
@@ -318,7 +318,7 @@ static int at91_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 static u64 at91_pcm_dmamask = 0xffffffff;
 
 static int at91_pcm_new(struct snd_card *card,
-	struct snd_soc_codec_dai *dai, struct snd_pcm *pcm)
+	struct snd_soc_dai *dai, struct snd_pcm *pcm)
 {
 	int ret = 0;
 
@@ -367,7 +367,7 @@ static void at91_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 #ifdef CONFIG_PM
 static int at91_pcm_suspend(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
+	struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = dai->runtime;
 	struct at91_runtime_data *prtd;
@@ -392,7 +392,7 @@ static int at91_pcm_suspend(struct platform_device *pdev,
 }
 
 static int at91_pcm_resume(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
+	struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = dai->runtime;
 	struct at91_runtime_data *prtd;
diff --git a/sound/soc/at91/at91-ssc.c b/sound/soc/at91/at91-ssc.c
index bc35d00..c3625b6 100644
--- a/sound/soc/at91/at91-ssc.c
+++ b/sound/soc/at91/at91-ssc.c
@@ -281,7 +281,7 @@ static void at91_ssc_shutdown(struct snd_pcm_substream *substream)
 /*
  * Record the SSC system clock rate.
  */
-static int at91_ssc_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+static int at91_ssc_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	/*
@@ -303,7 +303,7 @@ static int at91_ssc_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 /*
  * Record the DAI format for use in hw_params().
  */
-static int at91_ssc_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+static int at91_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
 	struct at91_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
@@ -315,7 +315,7 @@ static int at91_ssc_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
 /*
  * Record SSC clock dividers for use in hw_params().
  */
-static int at91_ssc_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
+static int at91_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	int div_id, int div)
 {
 	struct at91_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
@@ -634,7 +634,7 @@ static int at91_ssc_prepare(struct snd_pcm_substream *substream)
 
 #ifdef CONFIG_PM
 static int at91_ssc_suspend(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *cpu_dai)
+	struct snd_soc_dai *cpu_dai)
 {
 	struct at91_ssc_info *ssc_p;
 
@@ -662,7 +662,7 @@ static int at91_ssc_suspend(struct platform_device *pdev,
 }
 
 static int at91_ssc_resume(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *cpu_dai)
+	struct snd_soc_dai *cpu_dai)
 {
 	struct at91_ssc_info *ssc_p;
 
@@ -700,7 +700,7 @@ static int at91_ssc_resume(struct platform_device *pdev,
 #define AT91_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
 			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-struct snd_soc_cpu_dai at91_ssc_dai[NUM_SSC_DEVICES] = {
+struct snd_soc_dai at91_ssc_dai[NUM_SSC_DEVICES] = {
 	{	.name = "at91-ssc0",
 		.id = 0,
 		.type = SND_SOC_DAI_PCM,
diff --git a/sound/soc/at91/at91-ssc.h b/sound/soc/at91/at91-ssc.h
index b188f97..6b7bf38 100644
--- a/sound/soc/at91/at91-ssc.h
+++ b/sound/soc/at91/at91-ssc.h
@@ -21,7 +21,7 @@
 #define AT91SSC_TCMR_PERIOD	1 /* BCLK divider for transmit FS */
 #define AT91SSC_RCMR_PERIOD	2 /* BCLK divider for receive FS */
 
-extern struct snd_soc_cpu_dai at91_ssc_dai[];
+extern struct snd_soc_dai at91_ssc_dai[];
 
 #endif /* _AT91_SSC_H */
 
diff --git a/sound/soc/at91/eti_b1_wm8731.c b/sound/soc/at91/eti_b1_wm8731.c
index ad971e7..9d42139 100644
--- a/sound/soc/at91/eti_b1_wm8731.c
+++ b/sound/soc/at91/eti_b1_wm8731.c
@@ -53,8 +53,8 @@ static struct clk *pllb_clk;
 static int eti_b1_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret;
 
 	/* cpu clock is the AT91 master clock sent to the SSC */
@@ -87,8 +87,8 @@ static int eti_b1_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret;
 
 #ifdef CONFIG_SND_AT91_SOC_ETI_SLAVE
-- 
1.5.4.2
