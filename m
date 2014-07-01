From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v4 6/8] ASoC: compress: Add support for DAI
	multicodec
Date: Tue,  1 Jul 2014 09:47:59 +0200
Message-ID: <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 795ED2656B4
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:49:04 +0200 (CEST)
Received: by mail-wg0-f43.google.com with SMTP id k14so341217wgh.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 00:49:04 -0700 (PDT)
In-Reply-To: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Add multicodec support in soc-compress.c

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>
---
 sound/soc/soc-compress.c | 94 ++++++++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 35 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index f96fb96..cd65b12 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -155,14 +155,17 @@ static void close_delayed_work(struct work_struct *work)
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	dev_dbg(rtd->dev, "ASoC: pop wq checking: %s status: %s waiting: %s\n",
-		 codec_dai->driver->playback.stream_name,
-		 codec_dai->playback_active ? "active" : "inactive",
-		 rtd->pop_wait ? "yes" : "no");
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		dev_dbg(rtd->dev, "ASoC: pop wq checking: %s status: %s waiting: %s\n",
+			 codec_dai->driver->playback.stream_name,
+			 codec_dai->playback_active ? "active" : "inactive",
+			 rtd->pop_wait ? "yes" : "no");
+	}
 
 	/* are we waiting on this codec DAI stream */
 	if (rtd->pop_wait == 1) {
@@ -179,8 +182,7 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int stream;
+	int stream, i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -191,14 +193,18 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 
 	snd_soc_runtime_deactivate(rtd, stream);
 
-	snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+
+		snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
+
+		if (!codec_dai->active)
+			codec_dai->rate = 0;
+	}
 
 	if (!cpu_dai->active)
 		cpu_dai->rate = 0;
 
-	if (!codec_dai->active)
-		codec_dai->rate = 0;
-
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->shutdown)
 		rtd->dai_link->compr_ops->shutdown(cstream);
@@ -283,8 +289,7 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret = 0;
+	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -294,13 +299,19 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 			goto out;
 	}
 
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
-		break;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+			snd_soc_dai_digital_mute(codec_dai, 0,
+						 cstream->direction);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+			snd_soc_dai_digital_mute(codec_dai, 1,
+						 cstream->direction);
+			break;
+		}
 	}
 
 out:
@@ -622,23 +633,33 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_compr *compr;
 	struct snd_pcm *be_pcm;
 	char new_name[64];
-	int ret = 0, direction = 0;
-
-	/* check client and interface hw capabilities */
-	snprintf(new_name, sizeof(new_name), "%s %s-%d",
-			rtd->dai_link->stream_name, codec_dai->name, num);
-
-	if (codec_dai->driver->playback.channels_min)
-		direction = SND_COMPRESS_PLAYBACK;
-	else if (codec_dai->driver->capture.channels_min)
-		direction = SND_COMPRESS_CAPTURE;
-	else
-		return -EINVAL;
+	int i, ret = 0, direction = -1;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		/* check client and interface hw capabilities */
+		snprintf(new_name, sizeof(new_name), "%s %s-%d",
+			 rtd->dai_link->stream_name, codec_dai->name, num);
+
+		if (direction < 0) {
+			if (codec_dai->driver->playback.channels_min)
+				direction = SND_COMPRESS_PLAYBACK;
+			else if (codec_dai->driver->capture.channels_min)
+				direction = SND_COMPRESS_CAPTURE;
+			else
+				return -EINVAL;
+		} else {
+			if ((codec_dai->driver->playback.channels_min &&
+					direction != SND_COMPRESS_PLAYBACK) ||
+			    (codec_dai->driver->capture.channels_min &&
+					direction != SND_COMPRESS_CAPTURE))
+				return -EINVAL;
+		}
+	}
 
 	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
 	if (compr == NULL) {
@@ -692,8 +713,11 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	rtd->compr = compr;
 	compr->private_data = rtd;
 
-	printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n", codec_dai->name,
-		cpu_dai->name);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n",
+		       codec_dai->name, cpu_dai->name);
+	}
 	return ret;
 
 compr_err:
-- 
1.9.1
