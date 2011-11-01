From: Alan Tull <alan.tull@freescale.com>
Subject: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Tue, 1 Nov 2011 16:05:16 -0500
Message-ID: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id B553B244D9
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 22:05:25 +0100 (CET)
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
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, alan.tull@freescale.com
List-Id: alsa-devel@alsa-project.org

Previously, only one static struct for ops existed for all
platform DMA drivers to share.  Half of the ops are shared
functions which don't have stubs in the ALSA core.  The
other half are initialized to point directly to ops in the
platform driver.  This creates problems where each time
soc_new_pcm is called, the new platform driver's ops would
overwrite a subset of the ops.

This patch creates and populates a ops struct for each call
to soc_pcm_new.  Also creates a common soc_pcm_ioctl function
that calls all the driver components for ioctl calls.

Signed-off-by: Alan Tull <alan.tull@freescale.com>
---
 include/sound/soc-dai.h |    2 +
 include/sound/soc.h     |    1 +
 sound/soc/soc-core.c    |    1 +
 sound/soc/soc-pcm.c     |   80 +++++++++++++++++++++++++++++++++++-----------
 4 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 5ad5f3a..b3f880e 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -172,6 +172,8 @@ struct snd_soc_dai_ops {
 		struct snd_soc_dai *);
 	int (*trigger)(struct snd_pcm_substream *, int,
 		struct snd_soc_dai *);
+	int (*ioctl)(struct snd_pcm_substream *, unsigned int, void *,
+		struct snd_soc_dai *);
 	/*
 	 * For hardware based FIFO caused delay reporting.
 	 * Optional.
diff --git a/include/sound/soc.h b/include/sound/soc.h
index aa19f5a..1574325 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -517,6 +517,7 @@ struct snd_soc_ops {
 	int (*hw_free)(struct snd_pcm_substream *);
 	int (*prepare)(struct snd_pcm_substream *);
 	int (*trigger)(struct snd_pcm_substream *, int);
+	int (*ioctl)(struct snd_pcm_substream *, unsigned int, void *);
 };
 
 /* SoC cache ops */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b085d8e..1b48fc6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1547,6 +1547,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 
 	snd_soc_dapm_free(&card->dapm);
 
+	kfree(card->rtd->ops);
 	kfree(card->rtd);
 	snd_card_free(card->snd_card);
 	return 0;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2879c88..2bd7504 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -567,16 +567,39 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
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
+static int soc_pcm_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	if (rtd->dai_link->ops && rtd->dai_link->ops->ioctl) {
+		ret = rtd->dai_link->ops->ioctl(substream, cmd, arg);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (codec_dai->driver->ops->ioctl) {
+		ret = codec_dai->driver->ops->ioctl(substream, cmd, arg, codec_dai);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (platform->driver->ops->ioctl) {
+		ret = platform->driver->ops->ioctl(substream, cmd, arg);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (cpu_dai->driver->ops->ioctl) {
+		ret = cpu_dai->driver->ops->ioctl(substream, cmd, arg, cpu_dai);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
 
 /* create a new pcm */
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
@@ -586,9 +609,17 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_pcm *pcm;
+	struct snd_pcm_ops *soc_pcm_ops;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
 
+	/* ASoC PCM operations */
+	soc_pcm_ops = kzalloc(sizeof(struct snd_pcm_ops), GFP_KERNEL);
+	if (soc_pcm_ops == NULL) {
+		printk(KERN_ERR "asoc: can't create pcm ops for codec %s\n", codec->name);
+		return -ENOMEM;
+	}
+
 	/* check client and interface hw capabilities */
 	snprintf(new_name, sizeof(new_name), "%s %s-%d",
 			rtd->dai_link->stream_name, codec_dai->name, num);
@@ -603,34 +634,45 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			num, playback, capture, &pcm);
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: can't create pcm for codec %s\n", codec->name);
+		kfree(soc_pcm_ops);
 		return ret;
 	}
 
 	/* DAPM dai link stream work */
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
 
+	soc_pcm_ops->open = soc_pcm_open;
+	soc_pcm_ops->close = soc_codec_close;
+	soc_pcm_ops->hw_params = soc_pcm_hw_params;
+	soc_pcm_ops->hw_free = soc_pcm_hw_free;
+	soc_pcm_ops->prepare = soc_pcm_prepare;
+	soc_pcm_ops->pointer = soc_pcm_pointer;
+	soc_pcm_ops->trigger = soc_pcm_trigger;
+	soc_pcm_ops->ioctl = soc_pcm_ioctl;
+
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
+		soc_pcm_ops->copy = platform->driver->ops->copy;
+		soc_pcm_ops->silence = platform->driver->ops->silence;
+		soc_pcm_ops->ack = platform->driver->ops->ack;
+		soc_pcm_ops->page = platform->driver->ops->page;
 	}
 
+	rtd->ops = soc_pcm_ops;
+
 	if (playback)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, soc_pcm_ops);
 
 	if (capture)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, soc_pcm_ops);
 
 	if (platform->driver->pcm_new) {
 		ret = platform->driver->pcm_new(rtd);
 		if (ret < 0) {
 			pr_err("asoc: platform pcm constructor failed\n");
+			kfree(rtd->ops);
 			return ret;
 		}
 	}
-- 
1.6.0.4
