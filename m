From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/13] ASoC: Move IO abstraction to the
	component level
Date: Tue, 18 Mar 2014 09:02:13 +0100
Message-ID: <1395129736-11938-11-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C018261ADF
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:49 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We currently have two very similar IO abstractions in ASoC, one for CODECs, the
other for platforms. Moving this to the component level will allow us to unify
those two. It will also enable us to move the standard kcontrol helpers as well
as DAPM support to the component level.

The new component level abstraction layer is primarily build around regmap.
There is a per component pointer for the regmap instance for the underlying
device. There are four new function snd_soc_component_read(),
snd_soc_component_write(), snd_soc_component_update_bits() and
snd_soc_component_update_bits_async(). They have the same signature as their
regmap counter-part and will internally forward the call one-to-one to regmap.
If the component it not using regmap it will fallback to using the custom IO
callbacks. This is done to be able to support drivers that haven't been
converted to regmap yet, but it is expected that this will eventually be removed
in the future once all component drivers have been converted to regmap.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |   1 +
 include/sound/soc.h      |  24 ++++--
 sound/soc/soc-core.c     |  91 +++++++++++++++------
 sound/soc/soc-dapm.c     |  84 +++----------------
 sound/soc/soc-io.c       | 204 ++++++++++++++++++++++++++++-------------------
 5 files changed, 222 insertions(+), 182 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index ef78f56..75020f5 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -606,6 +606,7 @@ struct snd_soc_dapm_context {
 			     enum snd_soc_dapm_type, int);
 
 	struct device *dev; /* from parent - for debug */
+	struct snd_soc_component *component; /* parent component */
 	struct snd_soc_codec *codec; /* parent codec */
 	struct snd_soc_platform *platform; /* parent platform */
 	struct snd_soc_card *card; /* parent card */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 94a2dc2..c70ddbf 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -672,6 +672,14 @@ struct snd_soc_component {
 	const struct snd_soc_component_driver *driver;
 
 	struct list_head dai_list;
+
+	int (*read)(struct snd_soc_component *, unsigned int, unsigned int *);
+	int (*write)(struct snd_soc_component *, unsigned int, unsigned int);
+
+	struct regmap *regmap;
+	int val_bytes;
+
+	struct mutex mutex;
 };
 
 /* SoC Audio Codec device */
@@ -696,18 +704,14 @@ struct snd_soc_codec {
 	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
 	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int cache_init:1; /* codec cache has been initialized */
-	unsigned int using_regmap:1; /* using regmap access */
 	u32 cache_only;  /* Suppress writes to hardware */
 	u32 cache_sync; /* Cache needs to be synced to hardware */
 
 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
 	hw_write_t hw_write;
-	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
-	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
 	void *reg_cache;
 	struct mutex cache_rw_mutex;
-	int val_bytes;
 
 	/* component */
 	struct snd_soc_component component;
@@ -823,7 +827,6 @@ struct snd_soc_platform {
 	int id;
 	struct device *dev;
 	const struct snd_soc_platform_driver *driver;
-	struct mutex mutex;
 
 	unsigned int suspended:1; /* platform is suspended */
 	unsigned int probed:1;
@@ -1128,6 +1131,17 @@ unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 unsigned int snd_soc_write(struct snd_soc_codec *codec,
 			   unsigned int reg, unsigned int val);
 
+/* component IO */
+int snd_soc_component_read(struct snd_soc_component *component,
+	unsigned int reg, unsigned int *val);
+int snd_soc_component_write(struct snd_soc_component *component,
+	unsigned int reg, unsigned int val);
+int snd_soc_component_update_bits(struct snd_soc_component *component,
+	unsigned int reg, unsigned int mask, unsigned int val);
+int snd_soc_component_update_bits_async(struct snd_soc_component *component,
+	unsigned int reg, unsigned int mask, unsigned int val);
+void snd_soc_component_async_complete(struct snd_soc_component *component);
+
 /* device driver data */
 
 static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a07e6f..cb3811a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -656,8 +656,8 @@ int snd_soc_suspend(struct device *dev)
 				codec->driver->suspend(codec);
 				codec->suspended = 1;
 				codec->cache_sync = 1;
-				if (codec->using_regmap)
-					regcache_mark_dirty(codec->control_data);
+				if (codec->component.regmap)
+					regcache_mark_dirty(codec->component.regmap);
 				/* deactivate pins to sleep state */
 				pinctrl_pm_select_sleep_state(codec->dev);
 				break;
@@ -1130,7 +1130,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	codec->dapm.idle_bias_off = driver->idle_bias_off;
 
-	if (!codec->write && dev_get_regmap(codec->dev, NULL)) {
+	if (!codec->component.write && dev_get_regmap(codec->dev, NULL)) {
 		/* Set the default I/O up try regmap */
 		ret = snd_soc_codec_set_cache_io(codec, NULL);
 		if (ret < 0) {
@@ -2972,7 +2972,7 @@ int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
 	struct soc_bytes *params = (void *)kcontrol->private_value;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
-	uinfo->count = params->num_regs * codec->val_bytes;
+	uinfo->count = params->num_regs * codec->component.val_bytes;
 
 	return 0;
 }
@@ -2985,16 +2985,16 @@ int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	int ret;
 
-	if (codec->using_regmap)
-		ret = regmap_raw_read(codec->control_data, params->base,
+	if (codec->component.regmap)
+		ret = regmap_raw_read(codec->component.regmap, params->base,
 				      ucontrol->value.bytes.data,
-				      params->num_regs * codec->val_bytes);
+				      params->num_regs * codec->component.val_bytes);
 	else
 		ret = -EINVAL;
 
 	/* Hide any masked bytes to ensure consistent data reporting */
 	if (ret == 0 && params->mask) {
-		switch (codec->val_bytes) {
+		switch (codec->component.val_bytes) {
 		case 1:
 			ucontrol->value.bytes.data[0] &= ~params->mask;
 			break;
@@ -3024,10 +3024,10 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	unsigned int val, mask;
 	void *data;
 
-	if (!codec->using_regmap)
+	if (!codec->component.regmap)
 		return -EINVAL;
 
-	len = params->num_regs * codec->val_bytes;
+	len = params->num_regs * codec->component.val_bytes;
 
 	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
 	if (!data)
@@ -3039,27 +3039,27 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	 * copy.
 	 */
 	if (params->mask) {
-		ret = regmap_read(codec->control_data, params->base, &val);
+		ret = regmap_read(codec->component.regmap, params->base, &val);
 		if (ret != 0)
 			goto out;
 
 		val &= params->mask;
 
-		switch (codec->val_bytes) {
+		switch (codec->component.val_bytes) {
 		case 1:
 			((u8 *)data)[0] &= ~params->mask;
 			((u8 *)data)[0] |= val;
 			break;
 		case 2:
 			mask = ~params->mask;
-			ret = regmap_parse_val(codec->control_data,
+			ret = regmap_parse_val(codec->component.regmap,
 							&mask, &mask);
 			if (ret != 0)
 				goto out;
 
 			((u16 *)data)[0] &= mask;
 
-			ret = regmap_parse_val(codec->control_data,
+			ret = regmap_parse_val(codec->component.regmap,
 							&val, &val);
 			if (ret != 0)
 				goto out;
@@ -3068,14 +3068,14 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 			break;
 		case 4:
 			mask = ~params->mask;
-			ret = regmap_parse_val(codec->control_data,
+			ret = regmap_parse_val(codec->component.regmap,
 							&mask, &mask);
 			if (ret != 0)
 				goto out;
 
 			((u32 *)data)[0] &= mask;
 
-			ret = regmap_parse_val(codec->control_data,
+			ret = regmap_parse_val(codec->component.regmap,
 							&val, &val);
 			if (ret != 0)
 				goto out;
@@ -3088,7 +3088,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	ret = regmap_raw_write(codec->control_data, params->base,
+	ret = regmap_raw_write(codec->component.regmap, params->base,
 			       data, len);
 
 out:
@@ -3144,7 +3144,7 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
-	unsigned int regwshift = codec->val_bytes * BITS_PER_BYTE;
+	unsigned int regwshift = codec->component.val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
@@ -3190,7 +3190,7 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
-	unsigned int regwshift = codec->val_bytes * BITS_PER_BYTE;
+	unsigned int regwshift = codec->component.val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
@@ -3838,6 +3838,8 @@ __snd_soc_register_component(struct device *dev,
 		return -ENOMEM;
 	}
 
+	mutex_init(&cmpnt->mutex);
+
 	cmpnt->name = fmt_single_name(dev, &cmpnt->id);
 	if (!cmpnt->name) {
 		dev_err(dev, "ASoC: Failed to simplifying name\n");
@@ -3918,6 +3920,24 @@ found:
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
+static int snd_soc_platform_drv_write(struct snd_soc_component *component,
+	unsigned int reg, unsigned int val)
+{
+	struct snd_soc_platform *platform = snd_soc_component_to_platform(component);
+
+	return platform->driver->write(platform, reg, val);
+}
+
+static int snd_soc_platform_drv_read(struct snd_soc_component *component,
+	unsigned int reg, unsigned int *val)
+{
+	struct snd_soc_platform *platform = snd_soc_component_to_platform(component);
+
+	*val = platform->driver->read(platform, reg);
+
+	return 0;
+}
+
 /**
  * snd_soc_add_platform - Add a platform to the ASoC core
  * @dev: The parent device for the platform
@@ -3938,8 +3958,12 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 	platform->driver = platform_drv;
 	platform->dapm.dev = dev;
 	platform->dapm.platform = platform;
+	platform->dapm.component = &platform->component;
 	platform->dapm.stream_event = platform_drv->stream_event;
-	mutex_init(&platform->mutex);
+	if (platform_drv->write)
+		platform->component.write = snd_soc_platform_drv_write;
+	if (platform_drv->read)
+		platform->component.read = snd_soc_platform_drv_read;
 
 	/* register component */
 	ret = __snd_soc_register_component(dev, &platform->component,
@@ -4068,6 +4092,24 @@ static void fixup_codec_formats(struct snd_soc_pcm_stream *stream)
 			stream->formats |= codec_format_map[i];
 }
 
+static int snd_soc_codec_drv_write(struct snd_soc_component *component,
+	unsigned int reg, unsigned int val)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	return codec->driver->write(codec, reg, val);
+}
+
+static int snd_soc_codec_drv_read(struct snd_soc_component *component,
+	unsigned int reg, unsigned int *val)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	*val = codec->driver->read(codec, reg);
+
+	return 0;
+}
+
 /**
  * snd_soc_register_codec - Register a codec with the ASoC core
  *
@@ -4094,18 +4136,21 @@ int snd_soc_register_codec(struct device *dev,
 		goto fail_codec;
 	}
 
-	codec->write = codec_drv->write;
-	codec->read = codec_drv->read;
+	if (codec_drv->write)
+		codec->component.write = snd_soc_codec_drv_write;
+	if (codec_drv->read)
+		codec->component.read = snd_soc_codec_drv_read;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
+	codec->dapm.component = &codec->component;
 	codec->dapm.seq_notifier = codec_drv->seq_notifier;
 	codec->dapm.stream_event = codec_drv->stream_event;
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->num_dai = num_dai;
-	codec->val_bytes = codec_drv->reg_word_size;
+	codec->component.val_bytes = codec_drv->reg_word_size;
 	mutex_init(&codec->mutex);
 
 	for (i = 0; i < num_dai; i++) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c8a780d..506ee73 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -379,86 +379,24 @@ static void dapm_reset(struct snd_soc_card *card)
 static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg,
 	unsigned int *value)
 {
-	if (w->codec) {
-		*value = snd_soc_read(w->codec, reg);
-		return 0;
-	} else if (w->platform) {
-		*value = snd_soc_platform_read(w->platform, reg);
-		return 0;
-	}
-
-	dev_err(w->dapm->dev, "ASoC: no valid widget read method\n");
-	return -1;
-}
-
-static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg,
-	unsigned int val)
-{
-	if (w->codec)
-		return snd_soc_write(w->codec, reg, val);
-	else if (w->platform)
-		return snd_soc_platform_write(w->platform, reg, val);
-
-	dev_err(w->dapm->dev, "ASoC: no valid widget write method\n");
-	return -1;
-}
-
-static inline void soc_widget_lock(struct snd_soc_dapm_widget *w)
-{
-	if (w->codec && !w->codec->using_regmap)
-		mutex_lock(&w->codec->mutex);
-	else if (w->platform)
-		mutex_lock(&w->platform->mutex);
+	if (!w->dapm->component)
+		return -EIO;
+	return snd_soc_component_read(w->dapm->component, reg, value);
 }
 
-static inline void soc_widget_unlock(struct snd_soc_dapm_widget *w)
+static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
+	unsigned short reg, unsigned int mask, unsigned int value)
 {
-	if (w->codec && !w->codec->using_regmap)
-		mutex_unlock(&w->codec->mutex);
-	else if (w->platform)
-		mutex_unlock(&w->platform->mutex);
+	if (!w->dapm->component)
+		return -EIO;
+	return snd_soc_component_update_bits_async(w->dapm->component, reg,
+		mask, value);
 }
 
 static void soc_dapm_async_complete(struct snd_soc_dapm_context *dapm)
 {
-	if (dapm->codec && dapm->codec->using_regmap)
-		regmap_async_complete(dapm->codec->control_data);
-}
-
-static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
-	unsigned short reg, unsigned int mask, unsigned int value)
-{
-	bool change;
-	unsigned int old, new;
-	int ret;
-
-	if (w->codec && w->codec->using_regmap) {
-		ret = regmap_update_bits_check_async(w->codec->control_data,
-						     reg, mask, value,
-						     &change);
-		if (ret != 0)
-			return ret;
-	} else {
-		soc_widget_lock(w);
-		ret = soc_widget_read(w, reg, &old);
-		if (ret < 0) {
-			soc_widget_unlock(w);
-			return ret;
-		}
-
-		new = (old & ~mask) | (value & mask);
-		change = old != new;
-		if (change) {
-			ret = soc_widget_write(w, reg, new);
-			if (ret < 0) {
-				soc_widget_unlock(w);
-				return ret;
-			}
-		}
-		soc_widget_unlock(w);
-	}
-
-	return change;
+	if (dapm->component)
+		snd_soc_component_async_complete(dapm->component);
 }
 
 /**
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index a66bc17..762bcbc 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -19,24 +19,125 @@
 
 #include <trace/events/asoc.h>
 
-unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
+int snd_soc_component_read(struct snd_soc_component *component,
+	unsigned int reg, unsigned int *val)
 {
-	unsigned int ret;
+	int ret;
+
+	if (component->regmap)
+		ret = regmap_read(component->regmap, reg, val);
+	else if (component->read)
+		ret = component->read(component, reg, val);
+	else
+		ret = -EIO;
+
+	dev_dbg(component->dev, "read %x => %x\n", reg, *val);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_read);
+
+int snd_soc_component_write(struct snd_soc_component *component,
+	unsigned int reg, unsigned int val)
+{
+	dev_dbg(component->dev, "write %x = %x\n", reg, val);
+
+	if (component->regmap)
+		return regmap_write(component->regmap, reg, val);
+	else if (component->write)
+		return component->write(component, reg, val);
+	else
+		return -EIO;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_write);
+
+static int snd_soc_component_update_bits_legacy(
+	struct snd_soc_component *component, unsigned int reg,
+	unsigned int mask, unsigned int val, bool *change)
+{
+	unsigned int old, new;
+	int ret;
+
+	if (!component->read || !component->write)
+		return -EIO;
+
+	mutex_lock(&component->mutex);
+
+	ret = component->read(component, reg, &old);
+	if (ret < 0)
+		goto out_unlock;
 
-	ret = codec->read(codec, reg);
-	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
-	trace_snd_soc_reg_read(codec, reg, ret);
+	new = (old & ~mask) | (val & mask);
+	*change = old != new;
+	if (*change)
+		ret = component->write(component, reg, new);
+out_unlock:
+	mutex_unlock(&component->mutex);
 
 	return ret;
 }
+
+int snd_soc_component_update_bits(struct snd_soc_component *component,
+	unsigned int reg, unsigned int mask, unsigned int val)
+{
+	bool change;
+	int ret;
+
+	if (component->regmap)
+		ret = regmap_update_bits_check(component->regmap, reg, mask,
+			val, &change);
+	else
+		ret = snd_soc_component_update_bits_legacy(component, reg,
+			mask, val, &change);
+
+	if (ret < 0)
+		return ret;
+	return change;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_update_bits);
+
+int snd_soc_component_update_bits_async(struct snd_soc_component *component,
+	unsigned int reg, unsigned int mask, unsigned int val)
+{
+	bool change;
+	int ret;
+
+	if (component->regmap)
+		ret = regmap_update_bits_check_async(component->regmap, reg,
+			mask, val, &change);
+	else
+		ret = snd_soc_component_update_bits_legacy(component, reg,
+			mask, val, &change);
+
+	if (ret < 0)
+		return ret;
+	return change;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_update_bits_async);
+
+void snd_soc_component_async_complete(struct snd_soc_component *component)
+{
+	if (component->regmap)
+		regmap_async_complete(component->regmap);
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_async_complete);
+
+unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	unsigned int val;
+
+	snd_soc_component_read(&codec->component, reg, &val);
+	trace_snd_soc_reg_read(codec, reg, val);
+
+	return val;
+}
 EXPORT_SYMBOL_GPL(snd_soc_read);
 
 unsigned int snd_soc_write(struct snd_soc_codec *codec,
 			   unsigned int reg, unsigned int val)
 {
-	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
 	trace_snd_soc_reg_write(codec, reg, val);
-	return codec->write(codec, reg, val);
+	return snd_soc_component_write(&codec->component, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_write);
 
@@ -54,29 +155,8 @@ EXPORT_SYMBOL_GPL(snd_soc_write);
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
 				unsigned int mask, unsigned int value)
 {
-	bool change;
-	unsigned int old, new;
-	int ret;
-
-	if (codec->using_regmap) {
-		ret = regmap_update_bits_check(codec->control_data, reg,
-					       mask, value, &change);
-	} else {
-		ret = snd_soc_read(codec, reg);
-		if (ret < 0)
-			return ret;
-
-		old = ret;
-		new = (old & ~mask) | (value & mask);
-		change = old != new;
-		if (change)
-			ret = snd_soc_write(codec, reg, new);
-	}
-
-	if (ret < 0)
-		return ret;
-
-	return change;
+	return snd_soc_component_update_bits(&codec->component, reg, mask,
+		value);
 }
 EXPORT_SYMBOL_GPL(snd_soc_update_bits);
 
@@ -95,13 +175,8 @@ int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
 			       unsigned short reg, unsigned int mask,
 			       unsigned int value)
 {
-	int change;
-
-	mutex_lock(&codec->mutex);
-	change = snd_soc_update_bits(codec, reg, mask, value);
-	mutex_unlock(&codec->mutex);
-
-	return change;
+	return snd_soc_component_update_bits(&codec->component, reg, mask,
+		value);
 }
 EXPORT_SYMBOL_GPL(snd_soc_update_bits_locked);
 
@@ -134,53 +209,25 @@ EXPORT_SYMBOL_GPL(snd_soc_test_bits);
 int snd_soc_platform_read(struct snd_soc_platform *platform,
 					unsigned int reg)
 {
-	unsigned int ret;
+	unsigned int val;
 
-	if (!platform->driver->read) {
-		dev_err(platform->dev, "ASoC: platform has no read back\n");
-		return -1;
-	}
+	snd_soc_component_read(&platform->component, reg, &val);
 
-	ret = platform->driver->read(platform, reg);
-	dev_dbg(platform->dev, "read %x => %x\n", reg, ret);
-	trace_snd_soc_preg_read(platform, reg, ret);
+	trace_snd_soc_preg_read(platform, reg, val);
 
-	return ret;
+	return val;
 }
 EXPORT_SYMBOL_GPL(snd_soc_platform_read);
 
 int snd_soc_platform_write(struct snd_soc_platform *platform,
 					 unsigned int reg, unsigned int val)
 {
-	if (!platform->driver->write) {
-		dev_err(platform->dev, "ASoC: platform has no write back\n");
-		return -1;
-	}
-
-	dev_dbg(platform->dev, "write %x = %x\n", reg, val);
 	trace_snd_soc_preg_write(platform, reg, val);
-	return platform->driver->write(platform, reg, val);
+	return snd_soc_component_write(&platform->component, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_platform_write);
 
 #ifdef CONFIG_REGMAP
-static int hw_write(struct snd_soc_codec *codec, unsigned int reg,
-		    unsigned int value)
-{
-	return regmap_write(codec->control_data, reg, value);
-}
-
-static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(codec->control_data, reg, &val);
-	if (ret != 0)
-		return -1;
-	return val;
-}
-
 /**
  * snd_soc_codec_set_cache_io: Set up standard I/O functions.
  *
@@ -205,23 +252,18 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 
 	/* Device has made its own regmap arrangements */
 	if (!regmap)
-		codec->control_data = dev_get_regmap(codec->dev, NULL);
-	else
-		codec->control_data = regmap;
-
-	if (IS_ERR(codec->control_data))
-		return PTR_ERR(codec->control_data);
+		regmap = dev_get_regmap(codec->dev, NULL);
 
-	codec->write = hw_write;
-	codec->read = hw_read;
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	ret = regmap_get_val_bytes(codec->control_data);
+	ret = regmap_get_val_bytes(regmap);
 	/* Errors are legitimate for non-integer byte
 	 * multiples */
 	if (ret > 0)
-		codec->val_bytes = ret;
+		codec->component.val_bytes = ret;
 
-	codec->using_regmap = true;
+	codec->component.regmap = regmap;
 
 	return 0;
 }
-- 
1.8.0
