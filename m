From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 08/10] asoc: pxa - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:08:11 +0100
Message-ID: <1215443291.4882.185.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8148610382A
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:08:12 +0200 (CEST)
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
snd_soc_cpu_dai into struct snd_soc_dai for the PXA platform.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/corgi.c       |    4 ++--
 sound/soc/pxa/poodle.c      |    4 ++--
 sound/soc/pxa/pxa2xx-ac97.c |   14 +++++++-------
 sound/soc/pxa/pxa2xx-ac97.h |    2 +-
 sound/soc/pxa/pxa2xx-i2s.c  |   14 +++++++-------
 sound/soc/pxa/pxa2xx-i2s.h  |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c  |    2 +-
 sound/soc/pxa/spitz.c       |    4 ++--
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index db18ef6..782afbf 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -123,8 +123,8 @@ static int corgi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	unsigned int clk = 0;
 	int ret = 0;
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 36cbf69..ce25b6b 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -102,8 +102,8 @@ static int poodle_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	unsigned int clk = 0;
 	int ret = 0;
 
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index cb94795..b458667 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -283,7 +283,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_mic_mono_in = {
 
 #ifdef CONFIG_PM
 static int pxa2xx_ac97_suspend(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
+	struct snd_soc_dai *dai)
 {
 	GCR |= GCR_ACLINK_OFF;
 	clk_disable(ac97_clk);
@@ -291,7 +291,7 @@ static int pxa2xx_ac97_suspend(struct platform_device *pdev,
 }
 
 static int pxa2xx_ac97_resume(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
+	struct snd_soc_dai *dai)
 {
 	pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
 	pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
@@ -311,7 +311,7 @@ static int pxa2xx_ac97_resume(struct platform_device *pdev,
 #endif
 
 static int pxa2xx_ac97_probe(struct platform_device *pdev,
-			     struct snd_soc_cpu_dai *dai)
+			     struct snd_soc_dai *dai)
 {
 	int ret;
 
@@ -373,7 +373,7 @@ static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		cpu_dai->dma_data = &pxa2xx_ac97_pcm_stereo_out;
@@ -387,7 +387,7 @@ static int pxa2xx_ac97_hw_aux_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		cpu_dai->dma_data = &pxa2xx_ac97_pcm_aux_mono_out;
@@ -401,7 +401,7 @@ static int pxa2xx_ac97_hw_mic_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
@@ -419,7 +419,7 @@ static int pxa2xx_ac97_hw_mic_params(struct snd_pcm_substream *substream,
  * There is only 1 physical AC97 interface for pxa2xx, but it
  * has extra fifo's that can be used for aux DACs and ADCs.
  */
-struct snd_soc_cpu_dai pxa_ac97_dai[] = {
+struct snd_soc_dai pxa_ac97_dai[] = {
 {
 	.name = "pxa2xx-ac97",
 	.id = 0,
diff --git a/sound/soc/pxa/pxa2xx-ac97.h b/sound/soc/pxa/pxa2xx-ac97.h
index b8ccfee..e390de8 100644
--- a/sound/soc/pxa/pxa2xx-ac97.h
+++ b/sound/soc/pxa/pxa2xx-ac97.h
@@ -14,7 +14,7 @@
 #define PXA2XX_DAI_AC97_AUX		1
 #define PXA2XX_DAI_AC97_MIC		2
 
-extern struct snd_soc_cpu_dai pxa_ac97_dai[3];
+extern struct snd_soc_dai pxa_ac97_dai[3];
 
 /* platform data */
 extern struct snd_ac97_bus_ops pxa2xx_ac97_ops;
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 35090c2..9c06553 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -77,7 +77,7 @@ static struct pxa2xx_gpio gpio_bus[] = {
 static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (!cpu_dai->active) {
 		SACR0 |= SACR0_RST;
@@ -98,7 +98,7 @@ static int pxa_i2s_wait(void)
 	return 0;
 }
 
-static int pxa2xx_i2s_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+static int pxa2xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
 	/* interface format */
@@ -124,7 +124,7 @@ static int pxa2xx_i2s_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
 	return 0;
 }
 
-static int pxa2xx_i2s_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+static int pxa2xx_i2s_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	if (clk_id != PXA2XX_I2S_SYSCLK)
@@ -140,7 +140,7 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	pxa_gpio_mode(gpio_bus[pxa_i2s.master].rx);
 	pxa_gpio_mode(gpio_bus[pxa_i2s.master].tx);
@@ -237,7 +237,7 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream)
 
 #ifdef CONFIG_PM
 static int pxa2xx_i2s_suspend(struct platform_device *dev,
-	struct snd_soc_cpu_dai *dai)
+	struct snd_soc_dai *dai)
 {
 	if (!dai->active)
 		return 0;
@@ -255,7 +255,7 @@ static int pxa2xx_i2s_suspend(struct platform_device *dev,
 }
 
 static int pxa2xx_i2s_resume(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
+	struct snd_soc_dai *dai)
 {
 	if (!dai->active)
 		return 0;
@@ -280,7 +280,7 @@ static int pxa2xx_i2s_resume(struct platform_device *pdev,
 		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
 		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
 
-struct snd_soc_cpu_dai pxa_i2s_dai = {
+struct snd_soc_dai pxa_i2s_dai = {
 	.name = "pxa2xx-i2s",
 	.id = 0,
 	.type = SND_SOC_DAI_I2S,
diff --git a/sound/soc/pxa/pxa2xx-i2s.h b/sound/soc/pxa/pxa2xx-i2s.h
index 4435bd9..e2def44 100644
--- a/sound/soc/pxa/pxa2xx-i2s.h
+++ b/sound/soc/pxa/pxa2xx-i2s.h
@@ -15,6 +15,6 @@
 /* I2S clock */
 #define PXA2XX_I2S_SYSCLK		0
 
-extern struct snd_soc_cpu_dai pxa_i2s_dai;
+extern struct snd_soc_dai pxa_i2s_dai;
 
 #endif
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 01ad7bf..2df03ee 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -330,7 +330,7 @@ static void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 static u64 pxa2xx_pcm_dmamask = DMA_32BIT_MASK;
 
-int pxa2xx_pcm_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
+int pxa2xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	struct snd_pcm *pcm)
 {
 	int ret = 0;
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index ec18163..fd1abc7 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -121,8 +121,8 @@ static int spitz_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	unsigned int clk = 0;
 	int ret = 0;
 
-- 
1.5.4.2
