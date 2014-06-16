From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 08/11] ASoC: Add component level
	stream_event() and seq_notifier() support
Date: Mon, 16 Jun 2014 18:13:08 +0200
Message-ID: <1402935191-18398-9-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id CAEF426549B
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:27 +0200 (CEST)
In-Reply-To: <1402935191-18398-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds stream_event() and seq_notifier() callbacks similar to those
found in the snd_soc_codec_driver and snd_soc_platform driver struct to the
snd_soc_component_driver struct. This is meant to unify the handling of these
callbacks across different types of components and will eventually allow their
removal from the CODEC and platfrom driver structs.

The new callbacks are slightly different from the old ones in that they take a
snd_soc_component as a parameter rather than a snd_soc_dapm_context. This was
done since otherwise casting from the DAPM context to the component would
typically be the first thing to do in the callback. And the interface becomes
slightly cleaner by passing a snd_soc_component to all callbacks in the
snd_soc_component_driver struct.

The patch also already removes the stream_event() callback from the
snd_soc_codec_driver and snd_soc_platform_driver structs as it is currently
unused.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  9 +++------
 sound/soc/soc-core.c | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 84ebc07..9a5b4f6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -677,6 +677,9 @@ struct snd_soc_component_driver {
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
 				 struct of_phandle_args *args,
 				 const char **dai_name);
+	void (*seq_notifier)(struct snd_soc_component *, enum snd_soc_dapm_type,
+		int subseq);
+	int (*stream_event)(struct snd_soc_component *, int event);
 };
 
 struct snd_soc_component {
@@ -792,9 +795,6 @@ struct snd_soc_codec_driver {
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
 
-	/* codec stream completion event */
-	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
-
 	bool ignore_pmdown_time;  /* Doesn't benefit from pmdown delay */
 
 	/* probe ordering - for components with runtime dependencies */
@@ -836,9 +836,6 @@ struct snd_soc_platform_driver {
 	/* platform stream compress ops */
 	const struct snd_compr_ops *compr_ops;
 
-	/* platform stream completion event */
-	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
-
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
 	int remove_order;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 711e99c..5fe732f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3995,6 +3995,22 @@ err:
 	return ret;
 }
 
+static void snd_soc_component_seq_notifier(struct snd_soc_dapm_context *dapm,
+	enum snd_soc_dapm_type type, int subseq)
+{
+	struct snd_soc_component *component = dapm->component;
+
+	component->driver->seq_notifier(component, type, subseq);
+}
+
+static int snd_soc_component_stream_event(struct snd_soc_dapm_context *dapm,
+	int event)
+{
+	struct snd_soc_component *component = dapm->component;
+
+	return component->driver->stream_event(component, event);
+}
+
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -4016,6 +4032,10 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	dapm->dev = dev;
 	dapm->component = component;
 	dapm->bias_level = SND_SOC_BIAS_OFF;
+	if (driver->seq_notifier)
+		dapm->seq_notifier = snd_soc_component_seq_notifier;
+	if (driver->stream_event)
+		dapm->stream_event = snd_soc_component_stream_event;
 
 	INIT_LIST_HEAD(&component->dai_list);
 	mutex_init(&component->io_mutex);
@@ -4150,7 +4170,6 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 	platform->dev = dev;
 	platform->driver = platform_drv;
 	platform->component.dapm.platform = platform;
-	platform->component.dapm.stream_event = platform_drv->stream_event;
 	if (platform_drv->write)
 		platform->component.write = snd_soc_platform_drv_write;
 	if (platform_drv->read)
@@ -4336,8 +4355,8 @@ int snd_soc_register_codec(struct device *dev,
 		codec->component.read = snd_soc_codec_drv_read;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 	codec->dapm.codec = codec;
-	codec->dapm.seq_notifier = codec_drv->seq_notifier;
-	codec->dapm.stream_event = codec_drv->stream_event;
+	if (codec_drv->seq_notifier)
+		codec->dapm.seq_notifier = codec_drv->seq_notifier;
 	if (codec_drv->set_bias_level)
 		codec->dapm.set_bias_level = snd_soc_codec_set_bias_level;
 	codec->dev = dev;
-- 
1.8.0
