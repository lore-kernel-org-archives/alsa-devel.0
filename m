From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Push workqueue data into snd_soc_card
Date: Wed,  3 Dec 2008 13:24:49 +0000
Message-ID: <1228310694-6082-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081203132005.GA5943@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A997E1037F4
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 14:24:56 +0100 (CET)
In-Reply-To: <20081203132005.GA5943@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

ASoC v2 does not use the struct snd_soc_device at runtime, using struct
snd_soc_card as the root of the card.  Begin removing data from
snd_soc_device by pushing the workqueue data into snd_soc_card, using a
backpointer to the snd_soc_device to keep things going for the time
being.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    7 +++++--
 sound/soc/soc-core.c |   33 ++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9356c1c..359ec49 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -349,6 +349,11 @@ struct snd_soc_card {
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;
 	int num_links;
+
+	struct snd_soc_device *socdev;
+
+	struct delayed_work delayed_work;
+	struct work_struct deferred_resume_work;
 };
 
 /* SoC Device - the audio subsystem */
@@ -358,8 +363,6 @@ struct snd_soc_device {
 	struct snd_soc_platform *platform;
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_device *codec_dev;
-	struct delayed_work delayed_work;
-	struct work_struct deferred_resume_work;
 	void *codec_data;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry	*debugfs_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7eb2ea1..c4b22e6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -247,8 +247,9 @@ out:
  */
 static void close_delayed_work(struct work_struct *work)
 {
-	struct snd_soc_device *socdev =
-		container_of(work, struct snd_soc_device, delayed_work.work);
+	struct snd_soc_card *card = container_of(work, struct snd_soc_card,
+						 delayed_work.work);
+	struct snd_soc_device *socdev = card->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct snd_soc_dai *codec_dai;
 	int i;
@@ -299,6 +300,7 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_dai_link *machine = rtd->dai;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
@@ -340,7 +342,7 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* start delayed pop wq here for playback streams */
 		codec_dai->pop_wait = 1;
-		schedule_delayed_work(&socdev->delayed_work,
+		schedule_delayed_work(&card->delayed_work,
 			msecs_to_jiffies(pmdown_time));
 	} else {
 		/* capture streams can be powered down now */
@@ -366,6 +368,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_dai_link *machine = rtd->dai;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
@@ -411,7 +414,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    codec_dai->pop_wait) {
 		codec_dai->pop_wait = 0;
-		cancel_delayed_work(&socdev->delayed_work);
+		cancel_delayed_work(&card->delayed_work);
 	}
 
 	/* do we need to power up codec */
@@ -645,7 +648,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	}
 
 	/* close any waiting streams and save state */
-	run_delayed_work(&socdev->delayed_work);
+	run_delayed_work(&card->delayed_work);
 	codec->suspend_bias_level = codec->bias_level;
 
 	for (i = 0; i < codec->num_dai; i++) {
@@ -679,10 +682,10 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
  */
 static void soc_resume_deferred(struct work_struct *work)
 {
-	struct snd_soc_device *socdev = container_of(work,
-						     struct snd_soc_device,
-						     deferred_resume_work);
-	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_card *card = container_of(work,
+						 struct snd_soc_card,
+						 deferred_resume_work);
+	struct snd_soc_device *socdev = card->socdev;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 	struct snd_soc_codec *codec = socdev->codec;
@@ -746,10 +749,11 @@ static void soc_resume_deferred(struct work_struct *work)
 static int soc_resume(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = socdev->card;
 
 	dev_dbg(socdev->dev, "scheduling resume work\n");
 
-	if (!schedule_work(&socdev->deferred_resume_work))
+	if (!schedule_work(&card->deferred_resume_work))
 		dev_err(socdev->dev, "resume work item may be lost\n");
 
 	return 0;
@@ -769,6 +773,9 @@ static int soc_probe(struct platform_device *pdev)
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 
+	/* Bodge while we push things out of socdev */
+	card->socdev = socdev;
+
 	if (card->probe) {
 		ret = card->probe(pdev);
 		if (ret < 0)
@@ -797,10 +804,10 @@ static int soc_probe(struct platform_device *pdev)
 	}
 
 	/* DAPM stream work */
-	INIT_DELAYED_WORK(&socdev->delayed_work, close_delayed_work);
+	INIT_DELAYED_WORK(&card->delayed_work, close_delayed_work);
 #ifdef CONFIG_PM
 	/* deferred resume work */
-	INIT_WORK(&socdev->deferred_resume_work, soc_resume_deferred);
+	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
 #endif
 
 	return 0;
@@ -831,7 +838,7 @@ static int soc_remove(struct platform_device *pdev)
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 
-	run_delayed_work(&socdev->delayed_work);
+	run_delayed_work(&card->delayed_work);
 
 	if (platform->remove)
 		platform->remove(pdev);
-- 
1.5.6.5
