From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Allow platform drivers to have no
	ops structure
Date: Wed, 27 Apr 2011 18:27:33 +0100
Message-ID: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA01824396
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 19:29:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>, Lars-Peter Clausen <lars@m>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   49 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a6f37d4..cb93b79 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -545,6 +545,12 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 
 	mutex_lock(&pcm_mutex);
 
+	/* CODEC<->CODEC DAI link, no CPU interface */
+	if (rtd->dai_link->no_cpu) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* startup the audio subsystem */
 	if (cpu_dai->driver->ops->startup) {
 		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
@@ -555,7 +561,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (platform->driver->ops->open) {
+	if (platform->driver->ops && platform->driver->ops->open) {
 		ret = platform->driver->ops->open(substream);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open platform %s\n", platform->name);
@@ -685,7 +691,7 @@ machine_err:
 		codec_dai->driver->ops->shutdown(substream, codec_dai);
 
 codec_dai_err:
-	if (platform->driver->ops->close)
+	if (platform->driver->ops && platform->driver->ops->close)
 		platform->driver->ops->close(substream);
 
 platform_err:
@@ -767,7 +773,7 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	if (rtd->dai_link->ops && rtd->dai_link->ops->shutdown)
 		rtd->dai_link->ops->shutdown(substream);
 
-	if (platform->driver->ops->close)
+	if (platform->driver->ops && platform->driver->ops->close)
 		platform->driver->ops->close(substream);
 	cpu_dai->runtime = NULL;
 
@@ -810,7 +816,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (platform->driver->ops->prepare) {
+	if (platform->driver->ops && platform->driver->ops->prepare) {
 		ret = platform->driver->ops->prepare(substream);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: platform prepare error\n");
@@ -899,7 +905,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (platform->driver->ops->hw_params) {
+	if (platform->driver->ops && platform->driver->ops->hw_params) {
 		ret = platform->driver->ops->hw_params(substream, params);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: platform %s hw params failed\n",
@@ -952,7 +958,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		rtd->dai_link->ops->hw_free(substream);
 
 	/* free any DMA resources */
-	if (platform->driver->ops->hw_free)
+	if (platform->driver->ops && platform->driver->ops->hw_free)
 		platform->driver->ops->hw_free(substream);
 
 	/* now free hw params for the DAIs  */
@@ -980,7 +986,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			return ret;
 	}
 
-	if (platform->driver->ops->trigger) {
+	if (platform->driver->ops && platform->driver->ops->trigger) {
 		ret = platform->driver->ops->trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
@@ -1009,7 +1015,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t offset = 0;
 	snd_pcm_sframes_t delay = 0;
 
-	if (platform->driver->ops->pointer)
+	if (platform->driver->ops && platform->driver->ops->pointer)
 		offset = platform->driver->ops->pointer(substream);
 
 	if (cpu_dai->driver->ops->delay)
@@ -2125,13 +2131,15 @@ static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 	rtd->pcm = pcm;
 	pcm->private_data = rtd;
-	soc_pcm_ops.mmap = platform->driver->ops->mmap;
-	soc_pcm_ops.pointer = platform->driver->ops->pointer;
-	soc_pcm_ops.ioctl = platform->driver->ops->ioctl;
-	soc_pcm_ops.copy = platform->driver->ops->copy;
-	soc_pcm_ops.silence = platform->driver->ops->silence;
-	soc_pcm_ops.ack = platform->driver->ops->ack;
-	soc_pcm_ops.page = platform->driver->ops->page;
+	if (platform->driver->ops) {
+		soc_pcm_ops.mmap = platform->driver->ops->mmap;
+		soc_pcm_ops.pointer = platform->driver->ops->pointer;
+		soc_pcm_ops.ioctl = platform->driver->ops->ioctl;
+		soc_pcm_ops.copy = platform->driver->ops->copy;
+		soc_pcm_ops.silence = platform->driver->ops->silence;
+		soc_pcm_ops.ack = platform->driver->ops->ack;
+		soc_pcm_ops.page = platform->driver->ops->page;
+	}
 
 	if (playback)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
@@ -2139,10 +2147,13 @@ static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (capture)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
 
-	ret = platform->driver->pcm_new(rtd->card->snd_card, codec_dai, pcm);
-	if (ret < 0) {
-		printk(KERN_ERR "asoc: platform pcm constructor failed\n");
-		return ret;
+	if (platform->driver->pcm_new) {
+		ret = platform->driver->pcm_new(rtd->card->snd_card,
+						codec_dai, pcm);
+		if (ret < 0) {
+			pr_err("asoc: platform pcm constructor failed\n");
+			return ret;
+		}
 	}
 
 	pcm->private_free = platform->driver->pcm_free;
-- 
1.7.4.1
