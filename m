From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 06/11] ASoC: Add DAPM support at the
	component level
Date: Mon, 16 Jun 2014 18:13:06 +0200
Message-ID: <1402935191-18398-7-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 73362265498
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:26 +0200 (CEST)
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

This patch adds full DAPM support at the component level. Previously there was
only full DAPM support for CODECs and partial DAPM support (e.g. no Mixers nor
MUXs) for platforms. Having DAPM support at the component level will allow all
types of components to use DAPM and also help in consolidating the DAPM support
between CODECs and platforms.

Since the DAPM context is directly embedded into the snd_soc_codec and
snd_soc_platform struct and the 'dapm' field is directly referenced in a lot of
drivers moving the field just right now is not possible without causing code
churn. The approach this patch takes is to add two new fields to the component
struct. One field which is the pointer to the actual DAPM context used by the
component and one DAPM context that will be used as the default if no other
context was specified. For CODECs and platforms the pointer is initialized to
point to the CODEC or platform DAPM context. All generic code when referencing
a component's DAPM struct will go via the pointer. This will make it possible to
eventually seamlessly move the DAPM context from snd_soc_codec and
snd_soc_platform struct over once all direct references have been eliminated.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |   2 +
 include/sound/soc.h      |  30 ++++++++++++++
 sound/soc/soc-core.c     |  19 ++++++---
 sound/soc/soc-dapm.c     | 100 ++++++++++++++++++++++++++++++-----------------
 4 files changed, 110 insertions(+), 41 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3a5c4f9..e292683 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -441,6 +441,8 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list);
 
 struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol);
+struct snd_soc_dapm_context *snd_soc_dapm_kcontrol_dapm(
+	struct snd_kcontrol *kcontrol);
 
 /* dapm widget types */
 enum snd_soc_dapm_type {
diff --git a/include/sound/soc.h b/include/sound/soc.h
index f64bf94..a21dfec 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -706,6 +706,10 @@ struct snd_soc_component {
 	int val_bytes;
 
 	struct mutex io_mutex;
+
+	/* Don't use these, use snd_soc_component_get_dapm() */
+	struct snd_soc_dapm_context dapm;
+	struct snd_soc_dapm_context *dapm_ptr;
 };
 
 /* SoC Audio Codec device */
@@ -1161,6 +1165,21 @@ static inline struct snd_soc_platform *snd_soc_component_to_platform(
 }
 
 /**
+ * snd_soc_dapm_to_component() - Casts a DAPM context to the component it is
+ *  embedded in
+ * @dapm: The DAPM context to cast to the component
+ *
+ * This function must only be used on DAPM contexts that are known to be part of
+ * a component (e.g. in a component driver). Otherwise the behavior is
+ * undefined.
+ */
+static inline struct snd_soc_component *snd_soc_dapm_to_component(
+	struct snd_soc_dapm_context *dapm)
+{
+	return container_of(dapm, struct snd_soc_component, dapm);
+}
+
+/**
  * snd_soc_dapm_to_codec() - Casts a DAPM context to the CODEC it is embedded in
  * @dapm: The DAPM context to cast to the CODEC
  *
@@ -1187,6 +1206,17 @@ static inline struct snd_soc_platform *snd_soc_dapm_to_platform(
 	return container_of(dapm, struct snd_soc_platform, dapm);
 }
 
+/**
+ * snd_soc_component_get_dapm() - Returns the DAPM context associated with a
+ *  component
+ * @component: The component for which to get the DAPM context
+ */
+static inline struct snd_soc_dapm_context *snd_soc_component_get_dapm(
+	struct snd_soc_component *component)
+{
+	return component->dapm_ptr;
+}
+
 /* codec IO */
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 10e13c4..f519a9f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3997,6 +3997,8 @@ err:
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
+	struct snd_soc_dapm_context *dapm;
+
 	component->name = fmt_single_name(dev, &component->id);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
@@ -4006,6 +4008,14 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->dev = dev;
 	component->driver = driver;
 
+	if (!component->dapm_ptr)
+		component->dapm_ptr = &component->dapm;
+
+	dapm = component->dapm_ptr;
+	dapm->dev = dev;
+	dapm->component = component;
+	dapm->bias_level = SND_SOC_BIAS_OFF;
+
 	INIT_LIST_HEAD(&component->dai_list);
 	mutex_init(&component->io_mutex);
 
@@ -4131,6 +4141,8 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 {
 	int ret;
 
+	platform->component.dapm_ptr = &platform->dapm;
+
 	ret = snd_soc_component_initialize(&platform->component,
 			&platform_drv->component_driver, dev);
 	if (ret)
@@ -4138,9 +4150,7 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 
 	platform->dev = dev;
 	platform->driver = platform_drv;
-	platform->dapm.dev = dev;
 	platform->dapm.platform = platform;
-	platform->dapm.component = &platform->component;
 	platform->dapm.stream_event = platform_drv->stream_event;
 	if (platform_drv->write)
 		platform->component.write = snd_soc_platform_drv_write;
@@ -4314,6 +4324,8 @@ int snd_soc_register_codec(struct device *dev,
 	if (codec == NULL)
 		return -ENOMEM;
 
+	codec->component.dapm_ptr = &codec->dapm;
+
 	ret = snd_soc_component_initialize(&codec->component,
 			&codec_drv->component_driver, dev);
 	if (ret)
@@ -4324,10 +4336,7 @@ int snd_soc_register_codec(struct device *dev,
 	if (codec_drv->read)
 		codec->component.read = snd_soc_codec_drv_read;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
-	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
-	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
-	codec->dapm.component = &codec->component;
 	codec->dapm.seq_notifier = codec_drv->seq_notifier;
 	codec->dapm.stream_event = codec_drv->stream_event;
 	if (codec_drv->set_bias_level)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6c94a6b..4702b92 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -350,12 +350,27 @@ static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 }
 
 /**
+ * snd_soc_dapm_kcontrol_dapm() - Returns the dapm context associated to a
+ *  kcontrol
+ * @kcontrol: The kcontrol
+ *
+ * Note: This function must only be used on kcontrols that are known to have
+ * been registered for a CODEC. Otherwise the behaviour is undefined.
+ */
+struct snd_soc_dapm_context *snd_soc_dapm_kcontrol_dapm(
+	struct snd_kcontrol *kcontrol)
+{
+	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0]->dapm;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_dapm);
+
+/**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
  * @kcontrol: The kcontrol
  */
 struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol)
 {
-	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0]->codec;
+	return snd_soc_dapm_to_codec(snd_soc_dapm_kcontrol_dapm(kcontrol));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_codec);
 
@@ -382,23 +397,31 @@ static const char *soc_dapm_prefix(struct snd_soc_dapm_context *dapm)
 	return dapm->component->name_prefix;
 }
 
-static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg,
+static int soc_dapm_read(struct snd_soc_dapm_context *dapm, int reg,
 	unsigned int *value)
 {
-	if (!w->dapm->component)
+	if (!dapm->component)
 		return -EIO;
-	return snd_soc_component_read(w->dapm->component, reg, value);
+	return snd_soc_component_read(dapm->component, reg, value);
 }
 
-static int soc_widget_update_bits(struct snd_soc_dapm_widget *w,
+static int soc_dapm_update_bits(struct snd_soc_dapm_context *dapm,
 	int reg, unsigned int mask, unsigned int value)
 {
-	if (!w->dapm->component)
+	if (!dapm->component)
 		return -EIO;
-	return snd_soc_component_update_bits_async(w->dapm->component, reg,
+	return snd_soc_component_update_bits_async(dapm->component, reg,
 		mask, value);
 }
 
+static int soc_dapm_test_bits(struct snd_soc_dapm_context *dapm,
+	int reg, unsigned int mask, unsigned int value)
+{
+	if (!dapm->component)
+		return -EIO;
+	return snd_soc_component_test_bits(dapm->component, reg, mask, value);
+}
+
 static void soc_dapm_async_complete(struct snd_soc_dapm_context *dapm)
 {
 	if (dapm->component)
@@ -454,7 +477,7 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	int i;
 
 	if (e->reg != SND_SOC_NOPM) {
-		soc_widget_read(dest, e->reg, &val);
+		soc_dapm_read(dapm, e->reg, &val);
 		val = (val >> e->shift_l) & e->mask;
 		item = snd_soc_enum_val_to_item(e, val);
 	} else {
@@ -498,7 +521,7 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_widget *w,
 	unsigned int val;
 
 	if (reg != SND_SOC_NOPM) {
-		soc_widget_read(w, reg, &val);
+		soc_dapm_read(w->dapm, reg, &val);
 		val = (val >> shift) & mask;
 		if (invert)
 			val = max - val;
@@ -1306,16 +1329,18 @@ static void dapm_seq_check_event(struct snd_soc_card *card,
 static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 				   struct list_head *pending)
 {
+	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_dapm_widget *w;
 	int reg;
 	unsigned int value = 0;
 	unsigned int mask = 0;
 
-	reg = list_first_entry(pending, struct snd_soc_dapm_widget,
-			       power_list)->reg;
+	w = list_first_entry(pending, struct snd_soc_dapm_widget, power_list);
+	reg = w->reg;
+	dapm = w->dapm;
 
 	list_for_each_entry(w, pending, power_list) {
-		WARN_ON(reg != w->reg);
+		WARN_ON(reg != w->reg || dapm != w->dapm);
 		w->power = w->new_power;
 
 		mask |= w->mask << w->shift;
@@ -1324,7 +1349,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 		else
 			value |= w->off_val << w->shift;
 
-		pop_dbg(w->dapm->dev, card->pop_time,
+		pop_dbg(dapm->dev, card->pop_time,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
 			w->name, reg, value, mask);
 
@@ -1337,14 +1362,12 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
 		/* Any widget will do, they should all be updating the
 		 * same register.
 		 */
-		w = list_first_entry(pending, struct snd_soc_dapm_widget,
-				     power_list);
 
-		pop_dbg(w->dapm->dev, card->pop_time,
+		pop_dbg(dapm->dev, card->pop_time,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
 			value, mask, reg, card->pop_time);
 		pop_wait(card->pop_time);
-		soc_widget_update_bits(w, reg, mask, value);
+		soc_dapm_update_bits(dapm, reg, mask, value);
 	}
 
 	list_for_each_entry(w, pending, power_list) {
@@ -1490,7 +1513,8 @@ static void dapm_widget_update(struct snd_soc_card *card)
 	if (!w)
 		return;
 
-	ret = soc_widget_update_bits(w, update->reg, update->mask, update->val);
+	ret = soc_dapm_update_bits(w->dapm, update->reg, update->mask,
+		update->val);
 	if (ret < 0)
 		dev_err(w->dapm->dev, "ASoC: %s DAPM update failed: %d\n",
 			w->name, ret);
@@ -2672,7 +2696,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 
 		/* Read the initial power state from the device */
 		if (w->reg >= 0) {
-			soc_widget_read(w, w->reg, &val);
+			soc_dapm_read(w->dapm, w->reg, &val);
 			val = val >> w->shift;
 			val &= w->mask;
 			if (val == w->on_val)
@@ -2703,8 +2727,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
 int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_card *card = dapm->card;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int reg = mc->reg;
@@ -2713,17 +2737,20 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val;
+	int ret = 0;
 
 	if (snd_soc_volsw_is_stereo(mc))
-		dev_warn(codec->dapm.dev,
+		dev_warn(dapm->dev,
 			 "ASoC: Control '%s' is stereo, which is not supported\n",
 			 kcontrol->id.name);
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	if (dapm_kcontrol_is_powered(kcontrol) && reg != SND_SOC_NOPM)
-		val = (snd_soc_read(codec, reg) >> shift) & mask;
-	else
+	if (dapm_kcontrol_is_powered(kcontrol) && reg != SND_SOC_NOPM) {
+		ret = soc_dapm_read(dapm, reg, &val);
+		val = (val >> shift) & mask;
+	} else {
 		val = dapm_kcontrol_get_value(kcontrol);
+	}
 	mutex_unlock(&card->dapm_mutex);
 
 	if (invert)
@@ -2731,7 +2758,7 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	else
 		ucontrol->value.integer.value[0] = val;
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_get_volsw);
 
@@ -2747,8 +2774,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_volsw);
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_card *card = dapm->card;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int reg = mc->reg;
@@ -2762,7 +2789,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	int ret = 0;
 
 	if (snd_soc_volsw_is_stereo(mc))
-		dev_warn(codec->dapm.dev,
+		dev_warn(dapm->dev,
 			 "ASoC: Control '%s' is stereo, which is not supported\n",
 			 kcontrol->id.name);
 
@@ -2780,7 +2807,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		mask = mask << shift;
 		val = val << shift;
 
-		reg_change = snd_soc_test_bits(codec, reg, mask, val);
+		reg_change = soc_dapm_test_bits(dapm, reg, mask, val);
 	}
 
 	if (change || reg_change) {
@@ -2819,12 +2846,13 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
 int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg_val, val;
+	int ret = 0;
 
 	if (e->reg != SND_SOC_NOPM)
-		reg_val = snd_soc_read(codec, e->reg);
+		ret = soc_dapm_read(dapm, e->reg, &reg_val);
 	else
 		reg_val = dapm_kcontrol_get_value(kcontrol);
 
@@ -2836,7 +2864,7 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 		ucontrol->value.enumerated.item[1] = val;
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_double);
 
@@ -2852,8 +2880,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_double);
 int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_card *card = dapm->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int *item = ucontrol->value.enumerated.item;
 	unsigned int val, change;
@@ -2876,7 +2904,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	if (e->reg != SND_SOC_NOPM)
-		change = snd_soc_test_bits(codec, e->reg, mask, val);
+		change = soc_dapm_test_bits(dapm, e->reg, mask, val);
 	else
 		change = dapm_kcontrol_set_value(kcontrol, val);
 
-- 
1.8.0
