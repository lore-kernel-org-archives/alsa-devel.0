From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: Remove snd_soc_codec dapm field
Date: Mon,  6 Jul 2015 15:38:11 +0200
Message-ID: <1436189891-15343-6-git-send-email-lars@metafoo.de>
References: <1436189891-15343-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E5002606FF
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:38:25 +0200 (CEST)
In-Reply-To: <1436189891-15343-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Yang A Fang <yang.a.fang@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Kevin Cernekee <cernekee@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

There are no more direct users of the snd_soc_codec DAPM field left. So we
can finally remove it and switch over to directly using the component DAPM
context and remove the dapm_ptr indirection.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 10 +++-------
 sound/soc/soc-core.c | 23 ++++++++++++-----------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 93df8bf..3ccd82a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -792,7 +792,6 @@ struct snd_soc_component {
 
 	/* Don't use these, use snd_soc_component_get_dapm() */
 	struct snd_soc_dapm_context dapm;
-	struct snd_soc_dapm_context *dapm_ptr;
 
 	const struct snd_kcontrol_new *controls;
 	unsigned int num_controls;
@@ -832,9 +831,6 @@ struct snd_soc_codec {
 	/* component */
 	struct snd_soc_component component;
 
-	/* Don't access this directly, use snd_soc_codec_get_dapm() */
-	struct snd_soc_dapm_context dapm;
-
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_reg;
 #endif
@@ -1277,7 +1273,7 @@ static inline struct snd_soc_component *snd_soc_dapm_to_component(
 static inline struct snd_soc_codec *snd_soc_dapm_to_codec(
 	struct snd_soc_dapm_context *dapm)
 {
-	return container_of(dapm, struct snd_soc_codec, dapm);
+	return snd_soc_component_to_codec(snd_soc_dapm_to_component(dapm));
 }
 
 /**
@@ -1302,7 +1298,7 @@ static inline struct snd_soc_platform *snd_soc_dapm_to_platform(
 static inline struct snd_soc_dapm_context *snd_soc_component_get_dapm(
 	struct snd_soc_component *component)
 {
-	return component->dapm_ptr;
+	return &component->dapm;
 }
 
 /**
@@ -1314,7 +1310,7 @@ static inline struct snd_soc_dapm_context *snd_soc_component_get_dapm(
 static inline struct snd_soc_dapm_context *snd_soc_codec_get_dapm(
 	struct snd_soc_codec *codec)
 {
-	return &codec->dapm;
+	return snd_soc_component_get_dapm(&codec->component);
 }
 
 /**
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a4a5c0..3747111 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -654,10 +654,12 @@ int snd_soc_suspend(struct device *dev)
 
 	/* suspend all CODECs */
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+		struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+
 		/* If there are paths active then the CODEC will be held with
 		 * bias _ON and should not be suspended. */
 		if (!codec->suspended) {
-			switch (codec->dapm.bias_level) {
+			switch (snd_soc_dapm_get_bias_level(dapm)) {
 			case SND_SOC_BIAS_STANDBY:
 				/*
 				 * If the CODEC is capable of idle
@@ -665,7 +667,7 @@ int snd_soc_suspend(struct device *dev)
 				 * means it's doing something,
 				 * otherwise fall through.
 				 */
-				if (codec->dapm.idle_bias_off) {
+				if (dapm->idle_bias_off) {
 					dev_dbg(codec->dev,
 						"ASoC: idle_bias_off CODEC on over suspend\n");
 					break;
@@ -2651,10 +2653,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->probe = component->driver->probe;
 	component->remove = component->driver->remove;
 
-	if (!component->dapm_ptr)
-		component->dapm_ptr = &component->dapm;
-
-	dapm = component->dapm_ptr;
+	dapm = &component->dapm;
 	dapm->dev = dev;
 	dapm->component = component;
 	dapm->bias_level = SND_SOC_BIAS_OFF;
@@ -3036,6 +3035,7 @@ int snd_soc_register_codec(struct device *dev,
 			   struct snd_soc_dai_driver *dai_drv,
 			   int num_dai)
 {
+	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_codec *codec;
 	struct snd_soc_dai *dai;
 	int ret, i;
@@ -3046,7 +3046,6 @@ int snd_soc_register_codec(struct device *dev,
 	if (codec == NULL)
 		return -ENOMEM;
 
-	codec->component.dapm_ptr = &codec->dapm;
 	codec->component.codec = codec;
 
 	ret = snd_soc_component_initialize(&codec->component,
@@ -3076,12 +3075,14 @@ int snd_soc_register_codec(struct device *dev,
 	if (codec_drv->read)
 		codec->component.read = snd_soc_codec_drv_read;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
-	codec->dapm.idle_bias_off = codec_drv->idle_bias_off;
-	codec->dapm.suspend_bias_off = codec_drv->suspend_bias_off;
+
+	dapm = snd_soc_codec_get_dapm(codec);
+	dapm->idle_bias_off = codec_drv->idle_bias_off;
+	dapm->suspend_bias_off = codec_drv->suspend_bias_off;
 	if (codec_drv->seq_notifier)
-		codec->dapm.seq_notifier = codec_drv->seq_notifier;
+		dapm->seq_notifier = codec_drv->seq_notifier;
 	if (codec_drv->set_bias_level)
-		codec->dapm.set_bias_level = snd_soc_codec_set_bias_level;
+		dapm->set_bias_level = snd_soc_codec_set_bias_level;
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->component.val_bytes = codec_drv->reg_word_size;
-- 
2.1.4
