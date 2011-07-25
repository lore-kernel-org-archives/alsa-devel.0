From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH v2] ASoC: dapm - Add DAPM stream completion
	event.
Date: Mon, 25 Jul 2011 11:15:15 +0100
Message-ID: <1311588915-3402-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CB1E103827
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 12:15:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In preparation for Dynamic PCM (AKA DSP) support.

This adds a callback function to be called at the completion of a DAPM stream
event.

This can be used by DSP components to perform calculations based on DAPM graphs
after completion of stream events.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    2 ++
 include/sound/soc.h      |    6 ++++++
 sound/soc/soc-core.c     |    2 ++
 sound/soc/soc-dapm.c     |    4 ++++
 4 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e09505c..5833f01 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -518,6 +518,8 @@ struct snd_soc_dapm_context {
 	enum snd_soc_bias_level target_bias_level;
 	struct list_head list;
 
+	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dapm;
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index aa19f5a..64a9dd5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -634,6 +634,9 @@ struct snd_soc_codec_driver {
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
 
+	/* codec stream completion event */
+	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
+
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
 	int remove_order;
@@ -669,6 +672,9 @@ struct snd_soc_platform_driver {
 	/* platform stream ops */
 	struct snd_pcm_ops *ops;
 
+	/* platform stream completion event */
+	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
+
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
 	int remove_order;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e44267f..159f144 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3140,6 +3140,7 @@ int snd_soc_register_platform(struct device *dev,
 	platform->driver = platform_drv;
 	platform->dapm.dev = dev;
 	platform->dapm.platform = platform;
+	platform->dapm.stream_event = platform_drv->stream_event;
 
 	mutex_lock(&client_mutex);
 	list_add(&platform->list, &platform_list);
@@ -3252,6 +3253,7 @@ int snd_soc_register_codec(struct device *dev,
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
 	codec->dapm.seq_notifier = codec_drv->seq_notifier;
+	codec->dapm.stream_event = codec_drv->stream_event;
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->num_dai = num_dai;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fbfcda0..80f97b2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2574,6 +2574,10 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 	}
 
 	dapm_power_widgets(dapm, event);
+
+	/* do we need to notify any clients that DAPM stream is complete */
+	if (dapm->stream_event)
+		dapm->stream_event(dapm, event);
 }
 
 /**
-- 
1.7.4.1
