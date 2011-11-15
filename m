From: Alan Tull <alan.tull@freescale.com>
Subject: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Tue, 15 Nov 2011 09:59:39 -0600
Message-ID: <1321372779-8692-1-git-send-email-alan.tull@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id EA5EF10390C
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 16:59:48 +0100 (CET)
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
functions and the other half are initialized to point directly
to ops in the platform driver.  This creates problems where
each time soc_new_pcm is called, the new platform driver's
ops would overwrite a subset of the ops.

This patch creates and populates a ops struct for each call
to soc_pcm_new.

Signed-off-by: Alan Tull <alan.tull@freescale.com>
---
 sound/soc/soc-core.c |    6 ++++++
 sound/soc/soc-pcm.c  |   48 ++++++++++++++++++++++++++++--------------------
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b085d8e..216803c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1541,6 +1541,12 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 
 	soc_cleanup_card_debugfs(card);
 
+	/* free the ops */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		kfree(rtd->ops);
+	}
+
 	/* remove the card */
 	if (card->remove)
 		card->remove(card);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2879c88..091c074 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -567,17 +567,6 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
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
@@ -586,9 +575,17 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
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
@@ -603,34 +600,45 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
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
+		soc_pcm_ops->ioctl = platform->driver->ops->ioctl;
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
