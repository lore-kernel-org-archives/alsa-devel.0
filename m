From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 04/10] asoc: davinci - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:07:42 +0100
Message-ID: <1215443262.4882.181.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 181C710381D
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:07:44 +0200 (CEST)
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
snd_soc_cpu_dai into struct snd_soc_dai for the DaVinci platform.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/davinci/davinci-evm.c |    4 ++--
 sound/soc/davinci/davinci-i2s.c |   14 +++++++-------
 sound/soc/davinci/davinci-i2s.h |    2 +-
 sound/soc/davinci/davinci-pcm.c |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 091eae3..4249e6a 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -33,8 +33,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret = 0;
 
 	/* set codec DAI configuration */
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index c3b545c..5ebf1ff 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -147,7 +147,7 @@ static void davinci_mcbsp_stop(struct snd_pcm_substream *substream)
 static int davinci_i2s_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 
 	cpu_dai->dma_data = dev->dma_params[substream->stream];
@@ -155,7 +155,7 @@ static int davinci_i2s_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int davinci_i2s_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				   unsigned int fmt)
 {
 	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
@@ -296,11 +296,11 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
 }
 
 static int davinci_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_cpu_dai *dai)
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_machine *machine = socdev->machine;
-	struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[pdev->id].cpu_dai;
+	struct snd_soc_dai *cpu_dai = machine->dai_link[pdev->id].cpu_dai;
 	struct davinci_mcbsp_dev *dev;
 	struct resource *mem, *ioarea;
 	struct evm_snd_platform_data *pdata;
@@ -358,11 +358,11 @@ err_release_region:
 }
 
 static void davinci_i2s_remove(struct platform_device *pdev,
-			       struct snd_soc_cpu_dai *dai)
+			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_machine *machine = socdev->machine;
-	struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[pdev->id].cpu_dai;
+	struct snd_soc_dai *cpu_dai = machine->dai_link[pdev->id].cpu_dai;
 	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
 	struct resource *mem;
 
@@ -378,7 +378,7 @@ static void davinci_i2s_remove(struct platform_device *pdev,
 
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
 
-struct snd_soc_cpu_dai davinci_i2s_dai = {
+struct snd_soc_dai davinci_i2s_dai = {
 	.name = "davinci-i2s",
 	.id = 0,
 	.type = SND_SOC_DAI_I2S,
diff --git a/sound/soc/davinci/davinci-i2s.h b/sound/soc/davinci/davinci-i2s.h
index 9592d17..c5b0918 100644
--- a/sound/soc/davinci/davinci-i2s.h
+++ b/sound/soc/davinci/davinci-i2s.h
@@ -12,6 +12,6 @@
 #ifndef _DAVINCI_I2S_H
 #define _DAVINCI_I2S_H
 
-extern struct snd_soc_cpu_dai davinci_i2s_dai;
+extern struct snd_soc_dai davinci_i2s_dai;
 
 #endif
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 6a76927..6a5e56a 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -350,7 +350,7 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
 static u64 davinci_pcm_dmamask = 0xffffffff;
 
 static int davinci_pcm_new(struct snd_card *card,
-			   struct snd_soc_codec_dai *dai, struct snd_pcm *pcm)
+			   struct snd_soc_dai *dai, struct snd_pcm *pcm)
 {
 	int ret;
 
-- 
1.5.4.2
