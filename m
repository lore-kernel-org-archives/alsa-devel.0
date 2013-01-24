From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: soc-compress: Serialise compressed
	ops
Date: Thu, 24 Jan 2013 09:44:29 +0000
Message-ID: <1359020670-25684-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1359020670-25684-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B1E62615E6
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:47:05 +0100 (CET)
In-Reply-To: <1359020670-25684-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: vinod.koul@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Use the pcm_mutex to serialise the compressed ops.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 80040f0..c48db63 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -33,6 +33,8 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
@@ -61,12 +63,15 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	codec_dai->active++;
 	rtd->codec->active++;
 
+	mutex_unlock(&rtd->pcm_mutex);
+
 	return 0;
 
 machine_err:
 	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
 		platform->driver->compr_ops->free(cstream);
 out:
+	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
@@ -78,6 +83,8 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = rtd->codec;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
 		cpu_dai->playback_active--;
 		codec_dai->playback_active--;
@@ -124,6 +131,7 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 			SND_SOC_DAPM_STREAM_STOP);
 	}
 
+	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
 }
 
@@ -135,10 +143,12 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->trigger) {
 		ret = platform->driver->compr_ops->trigger(cstream, cmd);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	if (cmd == SNDRV_PCM_TRIGGER_START)
@@ -146,6 +156,8 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	else if (cmd == SNDRV_PCM_TRIGGER_STOP)
 		snd_soc_dai_digital_mute(codec_dai, 1);
 
+out:
+	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
@@ -156,6 +168,8 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 	struct snd_soc_platform *platform = rtd->platform;
 	int ret = 0;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	/* first we call set_params for the platform driver
 	 * this should configure the soc side
 	 * if the machine has compressed ops then we call that as well
@@ -165,18 +179,20 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 	if (platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
 		ret = platform->driver->compr_ops->set_params(cstream, params);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->set_params) {
 		ret = rtd->dai_link->compr_ops->set_params(cstream);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
 				SND_SOC_DAPM_STREAM_START);
 
+out:
+	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
@@ -187,9 +203,12 @@ static int soc_compr_get_params(struct snd_compr_stream *cstream,
 	struct snd_soc_platform *platform = rtd->platform;
 	int ret = 0;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->get_params)
 		ret = platform->driver->compr_ops->get_params(cstream, params);
 
+	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
@@ -200,9 +219,12 @@ static int soc_compr_get_caps(struct snd_compr_stream *cstream,
 	struct snd_soc_platform *platform = rtd->platform;
 	int ret = 0;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->get_caps)
 		ret = platform->driver->compr_ops->get_caps(cstream, caps);
 
+	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
@@ -213,9 +235,12 @@ static int soc_compr_get_codec_caps(struct snd_compr_stream *cstream,
 	struct snd_soc_platform *platform = rtd->platform;
 	int ret = 0;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->get_codec_caps)
 		ret = platform->driver->compr_ops->get_codec_caps(cstream, codec);
 
+	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
@@ -225,9 +250,12 @@ static int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
 	struct snd_soc_platform *platform = rtd->platform;
 	int ret = 0;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->ack)
 		ret = platform->driver->compr_ops->ack(cstream, bytes);
 
+	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
@@ -237,9 +265,12 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->pointer)
 		 platform->driver->compr_ops->pointer(cstream, tstamp);
 
+	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
 }
 
-- 
1.7.2.5
