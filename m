From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 02/10] asoc: at32 - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:07:29 +0100
Message-ID: <1215443249.4882.179.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 298E610380B
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:07:31 +0200 (CEST)
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

This patch series merges struct snd_soc_codec_dai and struct
snd_soc_cpu_dai into struct snd_soc_dai for AT32 platform.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/at32/at32-pcm.c       |    6 +++---
 sound/soc/at32/at32-ssc.c       |   12 ++++++------
 sound/soc/at32/at32-ssc.h       |    2 +-
 sound/soc/at32/playpaq_wm8510.c |    6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/at32/at32-pcm.c b/sound/soc/at32/at32-pcm.c
index cf76e89..435f1da 100644
--- a/sound/soc/at32/at32-pcm.c
+++ b/sound/soc/at32/at32-pcm.c
@@ -366,7 +366,7 @@ static struct snd_pcm_ops at32_pcm_ops = {
 static u64 at32_pcm_dmamask = 0xffffffff;
 
 static int at32_pcm_new(struct snd_card *card,
-			struct snd_soc_codec_dai *dai,
+			struct snd_soc_dai *dai,
 			struct snd_pcm *pcm)
 {
 	int ret = 0;
@@ -422,7 +422,7 @@ static void at32_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 #ifdef CONFIG_PM
 static int at32_pcm_suspend(struct platform_device *pdev,
-			    struct snd_soc_cpu_dai *dai)
+			    struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = dai->runtime;
 	struct at32_runtime_data *prtd;
@@ -447,7 +447,7 @@ static int at32_pcm_suspend(struct platform_device *pdev,
 
 
 static int at32_pcm_resume(struct platform_device *pdev,
-			   struct snd_soc_cpu_dai *dai)
+			   struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = dai->runtime;
 	struct at32_runtime_data *prtd;
diff --git a/sound/soc/at32/at32-ssc.c b/sound/soc/at32/at32-ssc.c
index 0ca4410..4ef6492 100644
--- a/sound/soc/at32/at32-ssc.c
+++ b/sound/soc/at32/at32-ssc.c
@@ -336,7 +336,7 @@ static void at32_ssc_shutdown(struct snd_pcm_substream *substream)
 /*
  * Set the SSC system clock rate
  */
-static int at32_ssc_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+static int at32_ssc_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 				   int clk_id, unsigned int freq, int dir)
 {
 	/* TODO: What the heck do I do here? */
@@ -348,7 +348,7 @@ static int at32_ssc_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 /*
  * Record DAI format for use by hw_params()
  */
-static int at32_ssc_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+static int at32_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				unsigned int fmt)
 {
 	struct at32_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
@@ -362,7 +362,7 @@ static int at32_ssc_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
 /*
  * Record SSC clock dividers for use in hw_params()
  */
-static int at32_ssc_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
+static int at32_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 				   int div_id, int div)
 {
 	struct at32_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
@@ -670,7 +670,7 @@ static int at32_ssc_prepare(struct snd_pcm_substream *substream)
 
 #ifdef CONFIG_PM
 static int at32_ssc_suspend(struct platform_device *pdev,
-			    struct snd_soc_cpu_dai *cpu_dai)
+			    struct snd_soc_dai *cpu_dai)
 {
 	struct at32_ssc_info *ssc_p;
 
@@ -699,7 +699,7 @@ static int at32_ssc_suspend(struct platform_device *pdev,
 
 
 static int at32_ssc_resume(struct platform_device *pdev,
-			   struct snd_soc_cpu_dai *cpu_dai)
+			   struct snd_soc_dai *cpu_dai)
 {
 	struct at32_ssc_info *ssc_p;
 	u32 cr;
@@ -746,7 +746,7 @@ static int at32_ssc_resume(struct platform_device *pdev,
      SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_S32)
 
 
-struct snd_soc_cpu_dai at32_ssc_dai[NUM_SSC_DEVICES] = {
+struct snd_soc_dai at32_ssc_dai[NUM_SSC_DEVICES] = {
 	{
 	 .name = "at32-ssc0",
 	 .id = 0,
diff --git a/sound/soc/at32/at32-ssc.h b/sound/soc/at32/at32-ssc.h
index 3c6901a..3c052db 100644
--- a/sound/soc/at32/at32-ssc.h
+++ b/sound/soc/at32/at32-ssc.h
@@ -52,7 +52,7 @@ struct at32_ssc_info {
 #define AT32_SSC_RCMR_PERIOD    2	/* BCLK divider for receive FS */
 
 
-extern struct snd_soc_cpu_dai at32_ssc_dai[];
+extern struct snd_soc_dai at32_ssc_dai[];
 
 
 
diff --git a/sound/soc/at32/playpaq_wm8510.c b/sound/soc/at32/playpaq_wm8510.c
index d6b9fd5..18ac7d7 100644
--- a/sound/soc/at32/playpaq_wm8510.c
+++ b/sound/soc/at32/playpaq_wm8510.c
@@ -82,7 +82,7 @@ static struct clk *_pll0;
 #if defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
 static struct ssc_clock_data playpaq_wm8510_calc_ssc_clock(
 	struct snd_pcm_hw_params *params,
-	struct snd_soc_cpu_dai *cpu_dai)
+	struct snd_soc_dai *cpu_dai)
 {
 	struct at32_ssc_info *ssc_p = cpu_dai->private_data;
 	struct ssc_device *ssc = ssc_p->ssc;
@@ -132,8 +132,8 @@ static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct at32_ssc_info *ssc_p = cpu_dai->private_data;
 	struct ssc_device *ssc = ssc_p->ssc;
 	unsigned int pll_out = 0, bclk = 0, mclk_div = 0;
-- 
1.5.4.2
