From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/17] Add device level DAPM event
Date: Thu, 10 Jan 2008 13:17:01 +0000
Message-ID: <1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B80724590
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:20 +0100 (CET)
In-Reply-To: <1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

From: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Added a device level dapm event so that both the machine and codec are informed
when dapm events occur.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    1 +
 include/sound/soc.h      |    3 +++
 sound/soc/soc-core.c     |   23 +++++++++++------------
 sound/soc/soc-dapm.c     |   23 +++++++++++++++++++++++
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2b1ae8e..db02159 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -199,6 +199,7 @@ void snd_soc_dapm_free(struct snd_soc_device *socdev);
 /* dapm events */
 int snd_soc_dapm_stream_event(struct snd_soc_codec *codec, char *stream,
 	int event);
+int snd_soc_dapm_device_event(struct snd_soc_device *socdev, int event);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index f47ef1f..000f3e7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -426,6 +426,9 @@ struct snd_soc_machine {
 	int (*resume_pre)(struct platform_device *pdev);
 	int (*resume_post)(struct platform_device *pdev);
 
+	/* callbacks */
+	int (*dapm_event)(struct snd_soc_machine *, int event);
+
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;
 	int num_links;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e6a67b5..aaf141c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -289,15 +289,16 @@ static void close_delayed_work(struct work_struct *work)
 		if (codec_dai->pop_wait == 1) {
 
 			codec_dai->pop_wait = 0;
-			snd_soc_dapm_stream_event(codec, codec_dai->playback.stream_name,
+			snd_soc_dapm_stream_event(codec,
+				codec_dai->playback.stream_name,
 				SND_SOC_DAPM_STREAM_STOP);
 
 			/* power down the codec power domain if no longer active */
 			if (codec->active == 0) {
 				dbg("pop wq D3 %s %s\n", codec->name,
 					codec_dai->playback.stream_name);
-		 		if (codec->dapm_event)
-					codec->dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+				snd_soc_dapm_device_event(socdev,
+					SNDRV_CTL_POWER_D3hot);
 			}
 		}
 	}
@@ -353,12 +354,12 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	} else {
 		/* capture streams can be powered down now */
 		snd_soc_dapm_stream_event(codec,
-			codec_dai->capture.stream_name, SND_SOC_DAPM_STREAM_STOP);
+			codec_dai->capture.stream_name,
+			SND_SOC_DAPM_STREAM_STOP);
 
-		if (codec->active == 0 && codec_dai->pop_wait == 0){
-			if (codec->dapm_event)
-				codec->dapm_event(codec, SNDRV_CTL_POWER_D3hot);
-		}
+		if (codec->active == 0 && codec_dai->pop_wait == 0)
+			snd_soc_dapm_device_event(socdev,
+						SNDRV_CTL_POWER_D3hot);
 	}
 
 	mutex_unlock(&pcm_mutex);
@@ -433,8 +434,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		/* no delayed work - do we need to power up codec */
 		if (codec->dapm_state != SNDRV_CTL_POWER_D0) {
 
-			if (codec->dapm_event)
-				codec->dapm_event(codec, SNDRV_CTL_POWER_D1);
+			snd_soc_dapm_device_event(socdev,  SNDRV_CTL_POWER_D1);
 
 			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 				snd_soc_dapm_stream_event(codec,
@@ -445,8 +445,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 					codec_dai->capture.stream_name,
 					SND_SOC_DAPM_STREAM_START);
 
-			if (codec->dapm_event)
-				codec->dapm_event(codec, SNDRV_CTL_POWER_D0);
+			snd_soc_dapm_device_event(socdev, SNDRV_CTL_POWER_D0);
 			if (codec_dai->dai_ops.digital_mute)
 				codec_dai->dai_ops.digital_mute(codec_dai, 0);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 29a546f..0a9d192 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1280,6 +1280,29 @@ int snd_soc_dapm_stream_event(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);
 
 /**
+ * snd_soc_dapm_device_event - send a device event to the dapm core
+ * @socdev: audio device
+ * @event: device event
+ *
+ * Sends a device event to the dapm core. The core then makes any
+ * necessary machine or codec power changes..
+ *
+ * Returns 0 for success else error.
+ */
+int snd_soc_dapm_device_event(struct snd_soc_device *socdev, int event)
+{
+	struct snd_soc_codec *codec = socdev->codec;
+	struct snd_soc_machine *machine = socdev->machine;
+
+	if (machine->dapm_event)
+				machine->dapm_event(machine, event);
+	if (codec->dapm_event)
+				codec->dapm_event(codec, event);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_device_event);
+
+/**
  * snd_soc_dapm_set_endpoint - set audio endpoint status
  * @codec: audio codec
  * @endpoint: audio signal endpoint (or start point)
-- 
1.5.3.8
