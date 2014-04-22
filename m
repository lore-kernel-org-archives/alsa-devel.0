From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 1/5] ASoC: Move IO abstraction to the
	component level
Date: Tue, 22 Apr 2014 12:02:20 +0200
Message-ID: <1398160944-6661-2-git-send-email-lars@metafoo.de>
References: <1398160944-6661-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-072.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DB32261A9F
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 12:02:31 +0200 (CEST)
In-Reply-To: <1398160944-6661-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
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
Changes since v2:
	* Rename mutex to io_mutex
Changes since v1:
	* Rebased onto asoc/for-next
	* Add kernel doc for the new functions
	* Rename snd_soc_component_set_cache_io() to snd_soc_component_init_io()
	* Removed stubbed out version of snd_soc_component_init_io(), the only
	  regmap function in there that we use is regmap_get_val_bytes() and
	  that is already stubbed out perfectly fine by the regmap code (and
	  given that almost all CODECs require regmap chances that we build
	  without regmap support in the first place are quite low).
---
 include/sound/soc-dapm.h   |   1 +
 include/sound/soc.h        |  31 ++++-
 sound/soc/omap/omap-hdmi.c |   1 -
 sound/soc/soc-core.c       |  96 ++++++++++----
 sound/soc/soc-dapm.c       |  84 ++----------
 sound/soc/soc-io.c         | 322 +++++++++++++++++++++++++++++----------------
 6 files changed, 317 insertions(+), 218 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 5ec03b5..b041fc6 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -594,6 +594,7 @@ struct snd_soc_dapm_context {
 			     enum snd_soc_dapm_type, int);
 
 	struct device *dev; /* from parent - for debug */
+	struct snd_soc_component *component; /* parent component */
 	struct snd_soc_codec *codec; /* parent codec */
 	struct snd_soc_platform *platform; /* parent platform */
 	struct snd_soc_card *card; /* parent card */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index de62475..554c650 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -393,8 +393,6 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *cmpnt_drv,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
-int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       struct regmap *regmap);
 int snd_soc_cache_sync(struct snd_soc_codec *codec);
 int snd_soc_cache_init(struct snd_soc_codec *codec);
 int snd_soc_cache_exit(struct snd_soc_codec *codec);
@@ -672,6 +670,14 @@ struct snd_soc_component {
 	const struct snd_soc_component_driver *driver;
 
 	struct list_head dai_list;
+
+	int (*read)(struct snd_soc_component *, unsigned int, unsigned int *);
+	int (*write)(struct snd_soc_component *, unsigned int, unsigned int);
+
+	struct regmap *regmap;
+	int val_bytes;
+
+	struct mutex io_mutex;
 };
 
 /* SoC Audio Codec device */
@@ -696,18 +702,14 @@ struct snd_soc_codec {
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
@@ -824,7 +826,6 @@ struct snd_soc_platform {
 	int id;
 	struct device *dev;
 	const struct snd_soc_platform_driver *driver;
-	struct mutex mutex;
 
 	unsigned int suspended:1; /* platform is suspended */
 	unsigned int probed:1;
@@ -1129,6 +1130,22 @@ unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val);
 
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
+int snd_soc_component_test_bits(struct snd_soc_component *component,
+	unsigned int reg, unsigned int mask, unsigned int value);
+
+int snd_soc_component_init_io(struct snd_soc_component *component,
+	struct regmap *regmap);
+
 /* device driver data */
 
 static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 32614b4..537a1ec 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -330,7 +330,6 @@ static int omap_hdmi_probe(struct platform_device *pdev)
 
 	return omap_pcm_platform_register(&pdev->dev);
 }
-}
 
 static int omap_hdmi_remove(struct platform_device *pdev)
 {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a17c047..df3e293 100644
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
@@ -3033,7 +3033,7 @@ int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
 	struct soc_bytes *params = (void *)kcontrol->private_value;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
-	uinfo->count = params->num_regs * codec->val_bytes;
+	uinfo->count = params->num_regs * codec->component.val_bytes;
 
 	return 0;
 }
@@ -3046,16 +3046,16 @@ int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
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
@@ -3085,10 +3085,10 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	unsigned int val, mask;
 	void *data;
 
-	if (!codec->using_regmap)
+	if (!codec->component.regmap)
 		return -EINVAL;
 
-	len = params->num_regs * codec->val_bytes;
+	len = params->num_regs * codec->component.val_bytes;
 
 	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
 	if (!data)
@@ -3100,27 +3100,27 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
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
@@ -3129,14 +3129,14 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
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
@@ -3149,7 +3149,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	ret = regmap_raw_write(codec->control_data, params->base,
+	ret = regmap_raw_write(codec->component.regmap, params->base,
 			       data, len);
 
 out:
@@ -3205,7 +3205,7 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
-	unsigned int regwshift = codec->val_bytes * BITS_PER_BYTE;
+	unsigned int regwshift = codec->component.val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
@@ -3251,7 +3251,7 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
-	unsigned int regwshift = codec->val_bytes * BITS_PER_BYTE;
+	unsigned int regwshift = codec->component.val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
@@ -3899,6 +3899,8 @@ __snd_soc_register_component(struct device *dev,
 		return -ENOMEM;
 	}
 
+	mutex_init(&cmpnt->io_mutex);
+
 	cmpnt->name = fmt_single_name(dev, &cmpnt->id);
 	if (!cmpnt->name) {
 		dev_err(dev, "ASoC: Failed to simplifying name\n");
@@ -3979,6 +3981,24 @@ found:
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
@@ -3999,8 +4019,12 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
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
@@ -4129,6 +4153,24 @@ static void fixup_codec_formats(struct snd_soc_pcm_stream *stream)
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
@@ -4156,29 +4198,33 @@ int snd_soc_register_codec(struct device *dev,
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
 
-	if (!codec->write) {
+	if (!codec->component.write) {
 		if (codec_drv->get_regmap)
 			regmap = codec_drv->get_regmap(dev);
 		else
 			regmap = dev_get_regmap(dev, NULL);
 
 		if (regmap) {
-			ret = snd_soc_codec_set_cache_io(codec, regmap);
-			if (ret && ret != -ENOTSUPP) {
+			ret = snd_soc_component_init_io(&codec->component,
+				regmap);
+			if (ret) {
 				dev_err(codec->dev,
 						"Failed to set cache I/O:%d\n",
 						ret);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index cdd5115..85a594f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -378,86 +378,24 @@ static void dapm_reset(struct snd_soc_card *card)
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
+	int reg, unsigned int mask, unsigned int value)
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
-	int reg, unsigned int mask, unsigned int value)
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
index dc0c09d..ac64fd7 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -19,24 +19,205 @@
 
 #include <trace/events/asoc.h>
 
-unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
+/**
+ * snd_soc_component_read() - Read register value
+ * @component: Component to read from
+ * @reg: Register to read
+ * @val: Pointer to where the read value is stored
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int snd_soc_component_read(struct snd_soc_component *component,
+	unsigned int reg, unsigned int *val)
+{
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
+/**
+ * snd_soc_component_write() - Write register value
+ * @component: Component to write to
+ * @reg: Register to write
+ * @val: Value to write to the register
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int snd_soc_component_write(struct snd_soc_component *component,
+	unsigned int reg, unsigned int val)
 {
-	unsigned int ret;
+	dev_dbg(component->dev, "write %x = %x\n", reg, val);
 
-	ret = codec->read(codec, reg);
-	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
-	trace_snd_soc_reg_read(codec, reg, ret);
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
+	mutex_lock(&component->io_mutex);
+
+	ret = component->read(component, reg, &old);
+	if (ret < 0)
+		goto out_unlock;
+
+	new = (old & ~mask) | (val & mask);
+	*change = old != new;
+	if (*change)
+		ret = component->write(component, reg, new);
+out_unlock:
+	mutex_unlock(&component->io_mutex);
 
 	return ret;
 }
+
+/**
+ * snd_soc_component_update_bits() - Perform read/modify/write cycle
+ * @component: Component to update
+ * @reg: Register to update
+ * @mask: Mask that specifies which bits to update
+ * @val: New value for the bits specified by mask
+ *
+ * Return: 1 if the operation was successful and the value of the register
+ * changed, 0 if the operation was successful, but the value did not change.
+ * Returns a negative error code otherwise.
+ */
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
+/**
+ * snd_soc_component_update_bits_async() - Perform asynchronous
+ *  read/modify/write cycle
+ * @component: Component to update
+ * @reg: Register to update
+ * @mask: Mask that specifies which bits to update
+ * @val: New value for the bits specified by mask
+ *
+ * This function is similar to snd_soc_component_update_bits(), but the update
+ * operation is scheduled asynchronously. This means it may not be completed
+ * when the function returns. To make sure that all scheduled updates have been
+ * completed snd_soc_component_async_complete() must be called.
+ *
+ * Return: 1 if the operation was successful and the value of the register
+ * changed, 0 if the operation was successful, but the value did not change.
+ * Returns a negative error code otherwise.
+ */
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
+/**
+ * snd_soc_component_async_complete() - Ensure asynchronous I/O has completed
+ * @component: Component for which to wait
+ *
+ * This function blocks until all asynchronous I/O which has previously been
+ * scheduled using snd_soc_component_update_bits_async() has completed.
+ */
+void snd_soc_component_async_complete(struct snd_soc_component *component)
+{
+	if (component->regmap)
+		regmap_async_complete(component->regmap);
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_async_complete);
+
+/**
+ * snd_soc_component_test_bits - Test register for change
+ * @component: component
+ * @reg: Register to test
+ * @mask: Mask that specifies which bits to test
+ * @value: Value to test against
+ *
+ * Tests a register with a new value and checks if the new value is
+ * different from the old value.
+ *
+ * Return: 1 for change, otherwise 0.
+ */
+int snd_soc_component_test_bits(struct snd_soc_component *component,
+	unsigned int reg, unsigned int mask, unsigned int value)
+{
+	unsigned int old, new;
+	int ret;
+
+	ret = snd_soc_component_read(component, reg, &old);
+	if (ret < 0)
+		return ret;
+	new = (old & ~mask) | value;
+	return old != new;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_test_bits);
+
+unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	unsigned int val;
+	int ret;
+
+	ret = snd_soc_component_read(&codec->component, reg, &val);
+	if (ret < 0)
+		return -1;
+	trace_snd_soc_reg_read(codec, reg, val);
+
+	return val;
+}
 EXPORT_SYMBOL_GPL(snd_soc_read);
 
 int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
-	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
 	trace_snd_soc_reg_write(codec, reg, val);
-	return codec->write(codec, reg, val);
+	return snd_soc_component_write(&codec->component, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_write);
 
@@ -54,29 +235,8 @@ EXPORT_SYMBOL_GPL(snd_soc_write);
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned int reg,
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
 
@@ -95,13 +255,8 @@ int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
 			       unsigned int reg, unsigned int mask,
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
 
@@ -120,115 +275,58 @@ EXPORT_SYMBOL_GPL(snd_soc_update_bits_locked);
 int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value)
 {
-	int change;
-	unsigned int old, new;
-
-	old = snd_soc_read(codec, reg);
-	new = (old & ~mask) | value;
-	change = old != new;
-
-	return change;
+	return snd_soc_component_test_bits(&codec->component, reg, mask, value);
 }
 EXPORT_SYMBOL_GPL(snd_soc_test_bits);
 
 int snd_soc_platform_read(struct snd_soc_platform *platform,
 					unsigned int reg)
 {
-	unsigned int ret;
+	unsigned int val;
+	int ret;
 
-	if (!platform->driver->read) {
-		dev_err(platform->dev, "ASoC: platform has no read back\n");
+	ret = snd_soc_component_read(&platform->component, reg, &val);
+	if (ret < 0)
 		return -1;
-	}
 
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
 
-#ifdef CONFIG_REGMAP
-static int hw_write(struct snd_soc_codec *codec, unsigned int reg,
-		    unsigned int value)
-{
-	return regmap_write(codec->control_data, reg, value);
-}
-
-static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(codec->control_data, reg, &val);
-	if (ret == 0)
-		return val;
-	else
-		return -1;
-}
-
 /**
- * snd_soc_codec_set_cache_io: Set up standard I/O functions.
- *
- * @codec: CODEC to configure.
- * @map: Register map to write to
+ * snd_soc_component_init_io() - Initialize regmap IO
  *
- * Register formats are frequently shared between many I2C and SPI
- * devices.  In order to promote code reuse the ASoC core provides
- * some standard implementations of CODEC read and write operations
- * which can be set up using this function.
+ * @component: component to initialize
+ * @regmap: regmap instance to use for IO operations
  *
- * The caller is responsible for allocating and initialising the
- * actual cache.
- *
- * Note that at present this code cannot be used by CODECs with
- * volatile registers.
+ * Return: 0 on success, a negative error code otherwise
  */
-int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       struct regmap *regmap)
+int snd_soc_component_init_io(struct snd_soc_component *component,
+	struct regmap *regmap)
 {
 	int ret;
 
 	if (!regmap)
 		return -EINVAL;
 
-	/* Device has made its own regmap arrangements */
-	codec->control_data = regmap;
-
-	codec->write = hw_write;
-	codec->read = hw_read;
-
-	ret = regmap_get_val_bytes(codec->control_data);
+	ret = regmap_get_val_bytes(regmap);
 	/* Errors are legitimate for non-integer byte
 	 * multiples */
 	if (ret > 0)
-		codec->val_bytes = ret;
+		component->val_bytes = ret;
 
-	codec->using_regmap = true;
+	component->regmap = regmap;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
-#else
-int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       struct regmap *regmap)
-{
-	return -ENOTSUPP;
-}
-EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
-#endif
+EXPORT_SYMBOL_GPL(snd_soc_component_init_io);
-- 
1.8.0
