From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 09/11] ASoC: Add component level
	set_bias_level() support
Date: Mon, 16 Jun 2014 18:13:09 +0200
Message-ID: <1402935191-18398-10-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D97726549C
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:28 +0200 (CEST)
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

This patch adds a set_bias_level() callback to the snd_soc_component_driver
struct similar to that found in the snd_soc_codec_driver struct. This will allow
any component type and not just CODECs to implement such a callback.

The semantics of the component driver and CODEC driver set_bias_level()
callbacks slightly differ. While the CODEC driver callback only takes the target
bias level, the component driver callback takes both the current and the target
bias level. Also for the component driver callback the current bias level will
be automatically updated to the target bias level if the callback does not
return an error, whereas with the CODEC bias level callback this has to be done
in every callback by hand. The change in semantics was implement because the new
semantics more closly match what drivers need. Most drivers are interested in
both the current and the target bias level and all drivers update the current to
the target bias level in case there is no error.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  4 ++++
 sound/soc/soc-core.c | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9a5b4f6..e560b6f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -680,6 +680,10 @@ struct snd_soc_component_driver {
 	void (*seq_notifier)(struct snd_soc_component *, enum snd_soc_dapm_type,
 		int subseq);
 	int (*stream_event)(struct snd_soc_component *, int event);
+	int (*set_bias_level)(struct snd_soc_component *component,
+		enum snd_soc_bias_level current_level,
+		enum snd_soc_bias_level target_level);
+	bool idle_bias_off;
 };
 
 struct snd_soc_component {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5fe732f..a414689 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4011,6 +4011,20 @@ static int snd_soc_component_stream_event(struct snd_soc_dapm_context *dapm,
 	return component->driver->stream_event(component, event);
 }
 
+static int snd_soc_component_set_bias_level(struct snd_soc_dapm_context *dapm,
+	enum snd_soc_bias_level target_level)
+{
+	struct snd_soc_component *component = dapm->component;
+	int ret;
+
+	ret = component->driver->set_bias_level(component, dapm->bias_level,
+		target_level);
+	if (ret == 0)
+		dapm->bias_level = target_level;
+
+	return ret;
+}
+
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -4032,10 +4046,13 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	dapm->dev = dev;
 	dapm->component = component;
 	dapm->bias_level = SND_SOC_BIAS_OFF;
+	dapm->idle_bias_off = driver->idle_bias_off;
 	if (driver->seq_notifier)
 		dapm->seq_notifier = snd_soc_component_seq_notifier;
 	if (driver->stream_event)
 		dapm->stream_event = snd_soc_component_stream_event;
+	if (driver->set_bias_level)
+		dapm->set_bias_level = snd_soc_component_set_bias_level;
 
 	INIT_LIST_HEAD(&component->dai_list);
 	mutex_init(&component->io_mutex);
-- 
1.8.0
