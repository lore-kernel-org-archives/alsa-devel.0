From: Sangsu Park <sangsu4u.park@samsung.com>
Subject: [PATCH v2] ASoC: soc-pcm: Allocate PCM operations
	dynamically to support multiple DAIs
Date: Mon,  2 Jan 2012 17:15:10 +0900
Message-ID: <1325492110-12743-1-git-send-email-sangsu4u.park@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D5B924667
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 14:12:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: sbkim73@samsung.com, sangsu@gmail.com, Sangsu Park <sangsu4u.park@samsung.com>
List-Id: alsa-devel@alsa-project.org

The original code does not cover the case that two DAIs(CPU) have different
ASoC core PCM operations(like mmap, pointer...). Currently we have only one
global soc_pcm_ops for ASoC core PCM operation. When two DAIs have different
pointer functions, second DAI's pointer function is set for both first DAI
and second DAI in case of original code.

This patch uses runtime's pcm_ops instead of global pcm_ops for each DAIs. So
each DAIs can have different ASoC core PCM operations. This is needed to
support multiple DAIs.
---
 sound/soc/soc-pcm.c |   38 ++++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8aa7cec..cdc860a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -598,17 +598,6 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	return offset;
 }
 
-/* ASoC PCM operations */
-static struct snd_pcm_ops soc_pcm_ops = {
-	.open		= soc_pcm_open,
-	.close		= soc_pcm_close,
-	.hw_params	= soc_pcm_hw_params,
-	.hw_free	= soc_pcm_hw_free,
-	.prepare	= soc_pcm_prepare,
-	.trigger	= soc_pcm_trigger,
-	.pointer	= soc_pcm_pointer,
-};
-
 /* create a new pcm */
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
@@ -616,10 +605,19 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_pcm_ops *soc_pcm_ops = &rtd->ops;
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
 
+	soc_pcm_ops->open	= soc_pcm_open;
+	soc_pcm_ops->close	= soc_pcm_close;
+	soc_pcm_ops->hw_params	= soc_pcm_hw_params;
+	soc_pcm_ops->hw_free	= soc_pcm_hw_free;
+	soc_pcm_ops->prepare	= soc_pcm_prepare;
+	soc_pcm_ops->trigger	= soc_pcm_trigger;
+	soc_pcm_ops->pointer	= soc_pcm_pointer;
+
 	/* check client and interface hw capabilities */
 	snprintf(new_name, sizeof(new_name), "%s %s-%d",
 			rtd->dai_link->stream_name, codec_dai->name, num);
@@ -643,20 +641,20 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	rtd->pcm = pcm;
 	pcm->private_data = rtd;
 	if (platform->driver->ops) {
-		soc_pcm_ops.mmap = platform->driver->ops->mmap;
-		soc_pcm_ops.pointer = platform->driver->ops->pointer;
-		soc_pcm_ops.ioctl = platform->driver->ops->ioctl;
-		soc_pcm_ops.copy = platform->driver->ops->copy;
-		soc_pcm_ops.silence = platform->driver->ops->silence;
-		soc_pcm_ops.ack = platform->driver->ops->ack;
-		soc_pcm_ops.page = platform->driver->ops->page;
+		soc_pcm_ops->mmap = platform->driver->ops->mmap;
+		soc_pcm_ops->pointer = platform->driver->ops->pointer;
+		soc_pcm_ops->ioctl = platform->driver->ops->ioctl;
+		soc_pcm_ops->copy = platform->driver->ops->copy;
+		soc_pcm_ops->silence = platform->driver->ops->silence;
+		soc_pcm_ops->ack = platform->driver->ops->ack;
+		soc_pcm_ops->page = platform->driver->ops->page;
 	}
 
 	if (playback)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, soc_pcm_ops);
 
 	if (capture)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, soc_pcm_ops);
 
 	if (platform->driver->pcm_new) {
 		ret = platform->driver->pcm_new(rtd);
-- 
1.7.1
