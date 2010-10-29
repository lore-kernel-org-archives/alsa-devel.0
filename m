From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC_i/iv 1/3] ASoC: Decouple DAPM from CODECs. Part
	core (will be squashed)
Date: Fri, 29 Oct 2010 15:00:16 +0300
Message-ID: <1288353618-21753-2-git-send-email-jhnikula@gmail.com>
References: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BAA924403
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 13:59:21 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 24so1790068eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 04:59:21 -0700 (PDT)
In-Reply-To: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch de-couples DAPM from the CODEC in order for other components to
have DAPM widgets.

Core implementation:
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

[jhnikula@gmail.com: This is combined from two patches made originally by
magi.olaya@ti.com and lrg@slimlogic.co.uk in branch origin/topic/L24.9
of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git.

Author did some minor changes due changed structures in ASoC and restricted
the patch to deal only with DAPM context of codec and let subsequent patches
to add DAPM context to other components]

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc-dapm.h |   42 +++++--
 include/sound/soc.h      |    8 +-
 sound/soc/soc-core.c     |   48 +++++--
 sound/soc/soc-dapm.c     |  323 ++++++++++++++++++++++++----------------------
 sound/soc/soc-jack.c     |    6 +-
 5 files changed, 238 insertions(+), 189 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8fd3b41..c6dd14a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -324,16 +324,16 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
 int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
-int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget);
-int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num);
 
 /* dapm path setup */
-int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec);
-void snd_soc_dapm_free(struct snd_soc_codec *codec);
-int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
+void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
+int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
 
 /* dapm events */
@@ -343,15 +343,15 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
-void snd_soc_dapm_debugfs_init(struct snd_soc_codec *codec);
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm);
 
 /* dapm audio pin control and status */
-int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, const char *pin);
-int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, const char *pin);
-int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, const char *pin);
-int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, const char *pin);
-int snd_soc_dapm_sync(struct snd_soc_codec *codec);
-int snd_soc_dapm_force_enable_pin(struct snd_soc_codec *codec,
+int snd_soc_dapm_enable_pin(struct snd_soc_dapm_context *dapm, const char *pin);
+int snd_soc_dapm_disable_pin(struct snd_soc_dapm_context *dapm, const char *pin);
+int snd_soc_dapm_nc_pin(struct snd_soc_dapm_context *dapm, const char *pin);
+int snd_soc_dapm_get_pin_status(struct snd_soc_dapm_context *dapm, const char *pin);
+int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm);
+int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 				  const char *pin);
 int snd_soc_dapm_ignore_suspend(struct snd_soc_codec *codec, const char *pin);
 
@@ -425,6 +425,7 @@ struct snd_soc_dapm_widget {
 	char *sname;	/* stream name */
 	struct snd_soc_codec *codec;
 	struct list_head list;
+	struct snd_soc_dapm_context *dapm;
 
 	/* dapm control */
 	short reg;						/* negative reg = no direct dapm */
@@ -461,4 +462,21 @@ struct snd_soc_dapm_widget {
 	struct list_head power_list;
 };
 
+/* DAPM context */
+struct snd_soc_dapm_context {
+	u32 pop_time;
+	struct list_head widgets;
+	struct list_head paths;
+	enum snd_soc_bias_level bias_level;
+	enum snd_soc_bias_level suspend_bias_level;
+	struct delayed_work delayed_work;
+	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
+
+	struct device *dev; /* from parent - for debug */
+	struct snd_soc_codec *codec; /* parent codec */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_dapm;
+#endif
+};
+
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5c3bce8..6b6eff8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -238,6 +238,7 @@ struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_jack;
 struct snd_soc_jack_pin;
+struct snd_soc_dapm_context;
 
 #ifdef CONFIG_GPIOLIB
 struct snd_soc_jack_gpio;
@@ -452,12 +453,7 @@ struct snd_soc_codec {
 	void *reg_cache;
 
 	/* dapm */
-	u32 pop_time;
-	struct list_head dapm_widgets;
-	struct list_head dapm_paths;
-	enum snd_soc_bias_level bias_level;
-	enum snd_soc_bias_level suspend_bias_level;
-	struct delayed_work delayed_work;
+	struct snd_soc_dapm_context *dapm;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 70d9a73..3c1c2ac 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -251,18 +251,18 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 
 	codec->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
 						     codec->debugfs_codec_root,
-						     &codec->pop_time);
+						     &codec->dapm->pop_time);
 	if (!codec->debugfs_pop_time)
 		printk(KERN_WARNING
 		       "Failed to create pop time debugfs file\n");
 
-	codec->debugfs_dapm = debugfs_create_dir("dapm",
+	codec->dapm->debugfs_dapm = debugfs_create_dir("dapm",
 						 codec->debugfs_codec_root);
-	if (!codec->debugfs_dapm)
+	if (!codec->dapm->debugfs_dapm)
 		printk(KERN_WARNING
 		       "Failed to create DAPM debugfs directory\n");
 
-	snd_soc_dapm_debugfs_init(codec);
+	snd_soc_dapm_debugfs_init(codec->dapm);
 }
 
 static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
@@ -1013,7 +1013,7 @@ static int soc_suspend(struct device *dev)
 	/* close any waiting streams and save state */
 	for (i = 0; i < card->num_rtd; i++) {
 		run_delayed_work(&card->rtd[i].delayed_work);
-		card->rtd[i].codec->suspend_bias_level = card->rtd[i].codec->bias_level;
+		card->rtd[i].codec->dapm->suspend_bias_level = card->rtd[i].codec->dapm->bias_level;
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
@@ -1037,7 +1037,7 @@ static int soc_suspend(struct device *dev)
 		/* If there are paths active then the CODEC will be held with
 		 * bias _ON and should not be suspended. */
 		if (!codec->suspended && codec->driver->suspend) {
-			switch (codec->bias_level) {
+			switch (codec->dapm->bias_level) {
 			case SND_SOC_BIAS_STANDBY:
 			case SND_SOC_BIAS_OFF:
 				codec->driver->suspend(codec, PMSG_SUSPEND);
@@ -1106,7 +1106,7 @@ static void soc_resume_deferred(struct work_struct *work)
 		 * resume.  Otherwise the suspend was suppressed.
 		 */
 		if (codec->driver->resume && codec->suspended) {
-			switch (codec->bias_level) {
+			switch (codec->dapm->bias_level) {
 			case SND_SOC_BIAS_STANDBY:
 			case SND_SOC_BIAS_OFF:
 				codec->driver->resume(codec);
@@ -1342,7 +1342,7 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 		}
 
 		/* Make sure all DAPM widgets are freed */
-		snd_soc_dapm_free(codec);
+		snd_soc_dapm_free(codec->dapm);
 
 		soc_cleanup_codec_debugfs(codec);
 		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
@@ -1466,8 +1466,8 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* Make sure all DAPM widgets are instantiated */
-	snd_soc_dapm_new_widgets(codec);
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_new_widgets(codec->dapm);
+	snd_soc_dapm_sync(codec->dapm);
 
 	/* register the rtd device */
 	rtd->dev.release = rtd_release;
@@ -2957,6 +2957,21 @@ static inline char *fmt_multiple_name(struct device *dev,
 	return kstrdup(dai_drv->name, GFP_KERNEL);
 }
 
+static struct snd_soc_dapm_context *soc_new_dapm_context(struct device *dev)
+{
+	struct snd_soc_dapm_context *dapm;
+
+	dapm = kzalloc(sizeof(struct snd_soc_dapm_context), GFP_KERNEL);
+	if (dapm) {
+		INIT_LIST_HEAD(&dapm->widgets);
+		INIT_LIST_HEAD(&dapm->paths);
+		dapm->bias_level = SND_SOC_BIAS_OFF;
+		dapm->dev = dev;
+	}
+	return dapm;
+}
+
+
 /**
  * snd_soc_register_dai - Register a DAI with the ASoC core
  *
@@ -3212,6 +3227,13 @@ int snd_soc_register_codec(struct device *dev,
 		kfree(codec);
 		return -ENOMEM;
 	}
+	codec->dapm = soc_new_dapm_context(dev);
+	if (codec->dapm == NULL) {
+		kfree(codec->name);
+		kfree(codec);
+		return -ENOMEM;
+	}
+	codec->dapm->codec = codec;
 
 	/* allocate CODEC register cache */
 	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
@@ -3225,6 +3247,7 @@ int snd_soc_register_codec(struct device *dev,
 
 		if (codec->reg_cache == NULL) {
 			kfree(codec->name);
+			kfree(codec->dapm);
 			kfree(codec);
 			return -ENOMEM;
 		}
@@ -3232,11 +3255,8 @@ int snd_soc_register_codec(struct device *dev,
 
 	codec->dev = dev;
 	codec->driver = codec_drv;
-	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->num_dai = num_dai;
 	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
@@ -3265,6 +3285,7 @@ error:
 	if (codec->reg_cache)
 		kfree(codec->reg_cache);
 	kfree(codec->name);
+	kfree(codec->dapm);
 	kfree(codec);
 	return ret;
 }
@@ -3300,6 +3321,7 @@ found:
 	if (codec->reg_cache)
 		kfree(codec->reg_cache);
 	kfree(codec->name);
+	kfree(codec->dapm);
 	kfree(codec);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_codec);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 035cab8..cee0c96 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -120,35 +120,35 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
  * Returns 0 for success else error.
  */
 static int snd_soc_dapm_set_bias_level(struct snd_soc_card *card,
-		struct snd_soc_codec *codec, enum snd_soc_bias_level level)
+		struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
 {
 	int ret = 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		dev_dbg(codec->dev, "Setting full bias\n");
+		dev_dbg(dapm->dev, "Setting full bias\n");
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		dev_dbg(codec->dev, "Setting bias prepare\n");
+		dev_dbg(dapm->dev, "Setting bias prepare\n");
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		dev_dbg(codec->dev, "Setting standby bias\n");
+		dev_dbg(dapm->dev, "Setting standby bias\n");
 		break;
 	case SND_SOC_BIAS_OFF:
-		dev_dbg(codec->dev, "Setting bias off\n");
+		dev_dbg(dapm->dev, "Setting bias off\n");
 		break;
 	default:
-		dev_err(codec->dev, "Setting invalid bias %d\n", level);
+		dev_err(dapm->dev, "Setting invalid bias %d\n", level);
 		return -EINVAL;
 	}
 
 	if (card && card->set_bias_level)
 		ret = card->set_bias_level(card, level);
 	if (ret == 0) {
-		if (codec->driver->set_bias_level)
-			ret = codec->driver->set_bias_level(codec, level);
+		if (dapm->codec && dapm->codec->driver->set_bias_level)
+			ret = dapm->codec->driver->set_bias_level(dapm->codec, level);
 		else
-			codec->bias_level = level;
+			dapm->bias_level = level;
 	}
 
 	return ret;
@@ -241,7 +241,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 }
 
 /* connect mux widget to its interconnecting audio paths */
-static int dapm_connect_mux(struct snd_soc_codec *codec,
+static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
 	struct snd_soc_dapm_path *path, const char *control_name,
 	const struct snd_kcontrol_new *kcontrol)
@@ -251,7 +251,7 @@ static int dapm_connect_mux(struct snd_soc_codec *codec,
 
 	for (i = 0; i < e->max; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
-			list_add(&path->list, &codec->dapm_paths);
+			list_add(&path->list, &dapm->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = (char*)e->texts[i];
@@ -264,7 +264,7 @@ static int dapm_connect_mux(struct snd_soc_codec *codec,
 }
 
 /* connect mixer widget to its interconnecting audio paths */
-static int dapm_connect_mixer(struct snd_soc_codec *codec,
+static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
 	struct snd_soc_dapm_path *path, const char *control_name)
 {
@@ -273,7 +273,7 @@ static int dapm_connect_mixer(struct snd_soc_codec *codec,
 	/* search for mixer kcontrol */
 	for (i = 0; i < dest->num_kcontrols; i++) {
 		if (!strcmp(control_name, dest->kcontrols[i].name)) {
-			list_add(&path->list, &codec->dapm_paths);
+			list_add(&path->list, &dapm->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = dest->kcontrols[i].name;
@@ -290,6 +290,7 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 	int change, power;
 	unsigned int old, new;
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_dapm_context *dapm = widget->dapm;
 
 	/* check for valid widgets */
 	if (widget->reg < 0 || widget->id == snd_soc_dapm_input ||
@@ -309,10 +310,10 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 
 	change = old != new;
 	if (change) {
-		pop_dbg(codec->pop_time, "pop test %s : %s in %d ms\n",
+		pop_dbg(dapm->pop_time, "pop test %s : %s in %d ms\n",
 			widget->name, widget->power ? "on" : "off",
-			codec->pop_time);
-		pop_wait(codec->pop_time);
+			dapm->pop_time);
+		pop_wait(dapm->pop_time);
 		snd_soc_write(codec, widget->reg, new);
 	}
 	pr_debug("reg %x old %x new %x change %d\n", widget->reg,
@@ -321,12 +322,13 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 }
 
 /* create new dapm mixer control */
-static int dapm_new_mixer(struct snd_soc_codec *codec,
+static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
 {
 	int i, ret = 0;
 	size_t name_len;
 	struct snd_soc_dapm_path *path;
+	struct snd_card *card = dapm->codec->card->snd_card;
 
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
@@ -368,7 +370,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 
 			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
 				path->long_name);
-			ret = snd_ctl_add(codec->card->snd_card, path->kcontrol);
+			ret = snd_ctl_add(card, path->kcontrol);
 			if (ret < 0) {
 				printk(KERN_ERR "asoc: failed to add dapm kcontrol %s: %d\n",
 				       path->long_name,
@@ -383,11 +385,12 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 }
 
 /* create new dapm mux control */
-static int dapm_new_mux(struct snd_soc_codec *codec,
+static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_path *path = NULL;
 	struct snd_kcontrol *kcontrol;
+	struct snd_card *card = dapm->codec->card->snd_card;
 	int ret = 0;
 
 	if (!w->num_kcontrols) {
@@ -396,7 +399,8 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 	}
 
 	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name);
-	ret = snd_ctl_add(codec->card->snd_card, kcontrol);
+	ret = snd_ctl_add(card, kcontrol);
+
 	if (ret < 0)
 		goto err;
 
@@ -411,7 +415,7 @@ err:
 }
 
 /* create new dapm volume control */
-static int dapm_new_pga(struct snd_soc_codec *codec,
+static int dapm_new_pga(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
 {
 	if (w->num_kcontrols)
@@ -421,11 +425,11 @@ static int dapm_new_pga(struct snd_soc_codec *codec,
 }
 
 /* reset 'walked' bit for each dapm path */
-static inline void dapm_clear_walk(struct snd_soc_codec *codec)
+static inline void dapm_clear_walk(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_path *p;
 
-	list_for_each_entry(p, &codec->dapm_paths, list)
+	list_for_each_entry(p, &dapm->paths, list)
 		p->walked = 0;
 }
 
@@ -435,7 +439,7 @@ static inline void dapm_clear_walk(struct snd_soc_codec *codec)
  */
 static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 {
-	int level = snd_power_get_state(widget->codec->card->snd_card);
+	int level = snd_power_get_state(widget->dapm->codec->card->snd_card);
 
 	switch (level) {
 	case SNDRV_CTL_POWER_D3hot:
@@ -621,9 +625,9 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	int in, out;
 
 	in = is_connected_input_ep(w);
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 	out = is_connected_output_ep(w);
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 	return out != 0 && in != 0;
 }
 
@@ -634,7 +638,7 @@ static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 
 	if (w->active) {
 		in = is_connected_input_ep(w);
-		dapm_clear_walk(w->codec);
+		dapm_clear_walk(w->dapm);
 		return in != 0;
 	} else {
 		return dapm_generic_check_power(w);
@@ -648,7 +652,7 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 
 	if (w->active) {
 		out = is_connected_output_ep(w);
-		dapm_clear_walk(w->codec);
+		dapm_clear_walk(w->dapm);
 		return out != 0;
 	} else {
 		return dapm_generic_check_power(w);
@@ -674,7 +678,7 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 		}
 	}
 
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 
 	return power;
 }
@@ -710,7 +714,7 @@ static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 }
 
 /* Apply the coalesced changes from a DAPM sequence */
-static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
+static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 				   struct list_head *pending)
 {
 	struct snd_soc_dapm_widget *w;
@@ -735,14 +739,14 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 		if (power)
 			value |= cur_mask;
 
-		pop_dbg(codec->pop_time,
+		pop_dbg(dapm->pop_time,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
 			w->name, reg, value, mask);
 
 		/* power up pre event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
-			pop_dbg(codec->pop_time, "pop test : %s PRE_PMU\n",
+			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMU\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
 			if (ret < 0)
@@ -753,7 +757,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 		/* power down pre event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
-			pop_dbg(codec->pop_time, "pop test : %s PRE_PMD\n",
+			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMD\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
 			if (ret < 0)
@@ -763,18 +767,18 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 	}
 
 	if (reg >= 0) {
-		pop_dbg(codec->pop_time,
+		pop_dbg(dapm->pop_time,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
-			value, mask, reg, codec->pop_time);
-		pop_wait(codec->pop_time);
-		snd_soc_update_bits(codec, reg, mask, value);
+			value, mask, reg, dapm->pop_time);
+		pop_wait(dapm->pop_time);
+		snd_soc_update_bits(dapm->codec, reg, mask, value);
 	}
 
 	list_for_each_entry(w, pending, power_list) {
 		/* power up post event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
-			pop_dbg(codec->pop_time, "pop test : %s POST_PMU\n",
+			pop_dbg(dapm->pop_time, "pop test : %s POST_PMU\n",
 				w->name);
 			ret = w->event(w,
 				       NULL, SND_SOC_DAPM_POST_PMU);
@@ -786,7 +790,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 		/* power down post event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
-			pop_dbg(codec->pop_time, "pop test : %s POST_PMD\n",
+			pop_dbg(dapm->pop_time, "pop test : %s POST_PMD\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
 			if (ret < 0)
@@ -804,7 +808,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
  * Currently anything that requires more than a single write is not
  * handled.
  */
-static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
+static void dapm_seq_run(struct snd_soc_dapm_context *dapm, struct list_head *list,
 			 int event, int sort[])
 {
 	struct snd_soc_dapm_widget *w, *n;
@@ -819,7 +823,7 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
 		/* Do we need to apply any queued changes? */
 		if (sort[w->id] != cur_sort || w->reg != cur_reg) {
 			if (!list_empty(&pending))
-				dapm_seq_run_coalesced(codec, &pending);
+				dapm_seq_run_coalesced(dapm, &pending);
 
 			INIT_LIST_HEAD(&pending);
 			cur_sort = -1;
@@ -877,7 +881,7 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
 	}
 
 	if (!list_empty(&pending))
-		dapm_seq_run_coalesced(codec, &pending);
+		dapm_seq_run_coalesced(dapm, &pending);
 }
 
 /*
@@ -889,9 +893,9 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
  *  o Input pin to Output pin (bypass, sidetone)
  *  o DAC to ADC (loopback).
  */
-static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
+static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 {
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = dapm->codec->card;
 	struct snd_soc_dapm_widget *w;
 	LIST_HEAD(up_list);
 	LIST_HEAD(down_list);
@@ -902,7 +906,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		switch (w->id) {
 		case snd_soc_dapm_pre:
 			dapm_seq_insert(w, &down_list, dapm_down_seq);
@@ -938,7 +942,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	/* If there are no DAPM widgets then try to figure out power from the
 	 * event type.
 	 */
-	if (list_empty(&codec->dapm_widgets)) {
+	if (list_empty(&dapm->widgets)) {
 		switch (event) {
 		case SND_SOC_DAPM_STREAM_START:
 		case SND_SOC_DAPM_STREAM_RESUME:
@@ -948,7 +952,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 			sys_power = 0;
 			break;
 		case SND_SOC_DAPM_STREAM_NOP:
-			switch (codec->bias_level) {
+			switch (dapm->bias_level) {
 				case SND_SOC_BIAS_STANDBY:
 				case SND_SOC_BIAS_OFF:
 					sys_power = 0;
@@ -963,52 +967,52 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 		}
 	}
 
-	if (sys_power && codec->bias_level == SND_SOC_BIAS_OFF) {
-		ret = snd_soc_dapm_set_bias_level(card, codec,
+	if (sys_power && dapm->bias_level == SND_SOC_BIAS_OFF) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm,
 						  SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			pr_err("Failed to turn on bias: %d\n", ret);
 	}
 
 	/* If we're changing to all on or all off then prepare */
-	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
-	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
-		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_PREPARE);
+	if ((sys_power && dapm->bias_level == SND_SOC_BIAS_STANDBY) ||
+	    (!sys_power && dapm->bias_level == SND_SOC_BIAS_ON)) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_PREPARE);
 		if (ret != 0)
 			pr_err("Failed to prepare bias: %d\n", ret);
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	dapm_seq_run(codec, &down_list, event, dapm_down_seq);
+	dapm_seq_run(dapm, &down_list, event, dapm_down_seq);
 
 	/* Now power up. */
-	dapm_seq_run(codec, &up_list, event, dapm_up_seq);
+	dapm_seq_run(dapm, &up_list, event, dapm_up_seq);
 
 	/* If we just powered the last thing off drop to standby bias */
-	if (codec->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
-		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_STANDBY);
+	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			pr_err("Failed to apply standby bias: %d\n", ret);
 	}
 
 	/* If we're in standby and can support bias off then do that */
-	if (codec->bias_level == SND_SOC_BIAS_STANDBY &&
-	    codec->idle_bias_off) {
-		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_OFF);
+	if (dapm->bias_level == SND_SOC_BIAS_STANDBY &&
+	    dapm->idle_bias_off) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_OFF);
 		if (ret != 0)
 			pr_err("Failed to turn off bias: %d\n", ret);
 	}
 
 	/* If we just powered up then move to active bias */
-	if (codec->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
-		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_ON);
+	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_ON);
 		if (ret != 0)
 			pr_err("Failed to apply active bias: %d\n", ret);
 	}
 
-	pop_dbg(codec->pop_time, "DAPM sequencing finished, waiting %dms\n",
-		codec->pop_time);
-	pop_wait(codec->pop_time);
+	pop_dbg(dapm->pop_time, "DAPM sequencing finished, waiting %dms\n",
+		dapm->pop_time);
+	pop_wait(dapm->pop_time);
 
 	return 0;
 }
@@ -1035,9 +1039,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 		return -ENOMEM;
 
 	in = is_connected_input_ep(w);
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 	out = is_connected_output_ep(w);
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 
 	ret = snprintf(buf, PAGE_SIZE, "%s: %s  in %d out %d",
 		       w->name, w->power ? "On" : "Off", in, out);
@@ -1086,20 +1090,20 @@ static const struct file_operations dapm_widget_power_fops = {
 	.read = dapm_widget_power_read_file,
 };
 
-void snd_soc_dapm_debugfs_init(struct snd_soc_codec *codec)
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 	struct dentry *d;
 
-	if (!codec->debugfs_dapm)
+	if (!dapm->debugfs_dapm)
 		return;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!w->name)
 			continue;
 
 		d = debugfs_create_file(w->name, 0444,
-					codec->debugfs_dapm, w,
+					dapm->debugfs_dapm, w,
 					&dapm_widget_power_fops);
 		if (!d)
 			printk(KERN_WARNING
@@ -1108,7 +1112,7 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_codec *codec)
 	}
 }
 #else
-void snd_soc_dapm_debugfs_init(struct snd_soc_codec *codec)
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 {
 }
 #endif
@@ -1129,7 +1133,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		return 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->codec->dapm_paths, list) {
+	list_for_each_entry(path, &widget->dapm->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1145,7 +1149,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	}
 
 	if (found)
-		dapm_power_widgets(widget->codec, SND_SOC_DAPM_STREAM_NOP);
+		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
 
 	return 0;
 }
@@ -1163,7 +1167,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		return -ENODEV;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->codec->dapm_paths, list) {
+	list_for_each_entry(path, &widget->dapm->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1174,7 +1178,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	}
 
 	if (found)
-		dapm_power_widgets(widget->codec, SND_SOC_DAPM_STREAM_NOP);
+		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
 
 	return 0;
 }
@@ -1190,7 +1194,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 	int count = 0;
 	char *state = "not set";
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &codec->dapm->widgets, list) {
 
 		/* only display widgets that burnm power */
 		switch (w->id) {
@@ -1214,7 +1218,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		}
 	}
 
-	switch (codec->bias_level) {
+	switch (codec->dapm->bias_level) {
 	case SND_SOC_BIAS_ON:
 		state = "On";
 		break;
@@ -1246,31 +1250,31 @@ static void snd_soc_dapm_sys_remove(struct device *dev)
 }
 
 /* free all dapm widgets and resources */
-static void dapm_free_widgets(struct snd_soc_codec *codec)
+static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w, *next_w;
 	struct snd_soc_dapm_path *p, *next_p;
 
-	list_for_each_entry_safe(w, next_w, &codec->dapm_widgets, list) {
+	list_for_each_entry_safe(w, next_w, &dapm->widgets, list) {
 		list_del(&w->list);
 		kfree(w);
 	}
 
-	list_for_each_entry_safe(p, next_p, &codec->dapm_paths, list) {
+	list_for_each_entry_safe(p, next_p, &dapm->paths, list) {
 		list_del(&p->list);
 		kfree(p->long_name);
 		kfree(p);
 	}
 }
 
-static int snd_soc_dapm_set_pin(struct snd_soc_codec *codec,
+static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 				const char *pin, int status)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin)) {
-			pr_debug("dapm: %s: pin %s\n", codec->name, pin);
+			pr_debug("dapm: %s: pin %s\n", dapm->codec->name, pin);
 			w->connected = status;
 			/* Allow disabling of forced pins */
 			if (status == 0)
@@ -1279,7 +1283,8 @@ static int snd_soc_dapm_set_pin(struct snd_soc_codec *codec,
 		}
 	}
 
-	pr_err("dapm: %s: configuring unknown pin %s\n", codec->name, pin);
+	pr_err("dapm: %s: configuring unknown pin %s\n",
+	       dapm->codec->name, pin);
 	return -EINVAL;
 }
 
@@ -1292,13 +1297,13 @@ static int snd_soc_dapm_set_pin(struct snd_soc_codec *codec,
  *
  * Returns 0 for success.
  */
-int snd_soc_dapm_sync(struct snd_soc_codec *codec)
+int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 {
-	return dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
+	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
-static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
+static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				  const struct snd_soc_dapm_route *route)
 {
 	struct snd_soc_dapm_path *path;
@@ -1309,7 +1314,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	int ret = 0;
 
 	/* find src and dest widgets */
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 
 		if (!wsink && !(strcmp(w->name, sink))) {
 			wsink = w;
@@ -1352,7 +1357,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 
 	/* connect static paths */
 	if (control == NULL) {
-		list_add(&path->list, &codec->dapm_paths);
+		list_add(&path->list, &dapm->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
@@ -1373,14 +1378,14 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
-		list_add(&path->list, &codec->dapm_paths);
+		list_add(&path->list, &dapm->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
 		return 0;
 	case snd_soc_dapm_mux:
 	case snd_soc_dapm_value_mux:
-		ret = dapm_connect_mux(codec, wsource, wsink, path, control,
+		ret = dapm_connect_mux(dapm, wsource, wsink, path, control,
 			&wsink->kcontrols[0]);
 		if (ret != 0)
 			goto err;
@@ -1388,7 +1393,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer:
 	case snd_soc_dapm_mixer_named_ctl:
-		ret = dapm_connect_mixer(codec, wsource, wsink, path, control);
+		ret = dapm_connect_mixer(dapm, wsource, wsink, path, control);
 		if (ret != 0)
 			goto err;
 		break;
@@ -1396,7 +1401,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_line:
 	case snd_soc_dapm_spk:
-		list_add(&path->list, &codec->dapm_paths);
+		list_add(&path->list, &dapm->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 0;
@@ -1424,13 +1429,13 @@ err:
  * Returns 0 for success else error. On error all resources can be freed
  * with a call to snd_soc_card_free().
  */
-int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num)
 {
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
-		ret = snd_soc_dapm_add_route(codec, route);
+		ret = snd_soc_dapm_add_route(dapm, route);
 		if (ret < 0) {
 			printk(KERN_ERR "Failed to add route %s->%s\n",
 			       route->source,
@@ -1452,11 +1457,11 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
  *
  * Returns 0 for success.
  */
-int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
+int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list)
+	list_for_each_entry(w, &dapm->widgets, list)
 	{
 		if (w->new)
 			continue;
@@ -1466,12 +1471,12 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_mixer(codec, w);
+			dapm_new_mixer(dapm, w);
 			break;
 		case snd_soc_dapm_mux:
 		case snd_soc_dapm_value_mux:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_mux(codec, w);
+			dapm_new_mux(dapm, w);
 			break;
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_aif_out:
@@ -1483,7 +1488,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 			break;
 		case snd_soc_dapm_pga:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_pga(codec, w);
+			dapm_new_pga(dapm, w);
 			break;
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_output:
@@ -1504,7 +1509,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 		w->new = 1;
 	}
 
-	dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
+	dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
@@ -1888,7 +1893,7 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	mutex_lock(&codec->mutex);
 
 	ucontrol->value.integer.value[0] =
-		snd_soc_dapm_get_pin_status(codec, pin);
+		snd_soc_dapm_get_pin_status(codec->dapm, pin);
 
 	mutex_unlock(&codec->mutex);
 
@@ -1911,11 +1916,11 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	mutex_lock(&codec->mutex);
 
 	if (ucontrol->value.integer.value[0])
-		snd_soc_dapm_enable_pin(codec, pin);
+		snd_soc_dapm_enable_pin(codec->dapm, pin);
 	else
-		snd_soc_dapm_disable_pin(codec, pin);
+		snd_soc_dapm_disable_pin(codec->dapm, pin);
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(codec->dapm);
 
 	mutex_unlock(&codec->mutex);
 
@@ -1932,7 +1937,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget)
 {
 	struct snd_soc_dapm_widget *w;
@@ -1940,11 +1945,12 @@ int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 	if ((w = dapm_cnew_widget(widget)) == NULL)
 		return -ENOMEM;
 
-	w->codec = codec;
+	w->dapm = dapm;
+	w->codec = dapm->codec;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
-	list_add(&w->list, &codec->dapm_widgets);
+	list_add(&w->list, &dapm->widgets);
 
 	/* machine layer set ups unconnected pins and insertions */
 	w->connected = 1;
@@ -1962,14 +1968,14 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num)
 {
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
-		ret = snd_soc_dapm_new_control(codec, widget);
+		ret = snd_soc_dapm_new_control(dapm, widget);
 		if (ret < 0) {
 			printk(KERN_ERR
 			       "ASoC: Failed to create DAPM control %s: %d\n",
@@ -1982,29 +1988,12 @@ int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
-
-/**
- * snd_soc_dapm_stream_event - send a stream event to the dapm core
- * @codec: audio codec
- * @stream: stream name
- * @event: stream event
- *
- * Sends a stream event to the dapm core. The core then makes any
- * necessary widget power changes.
- *
- * Returns 0 for success else error.
- */
-int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
+static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 	const char *stream, int event)
 {
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_widget *w;
 
-	if (stream == NULL)
-		return 0;
-
-	mutex_lock(&codec->mutex);
-	list_for_each_entry(w, &codec->dapm_widgets, list)
+	list_for_each_entry(w, &dapm->widgets, list)
 	{
 		if (!w->sname)
 			continue;
@@ -2027,7 +2016,30 @@ int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
 		}
 	}
 
-	dapm_power_widgets(codec, event);
+	dapm_power_widgets(dapm, event);
+}
+
+/**
+ * snd_soc_dapm_stream_event - send a stream event to the dapm core
+ * @rtd: PCM runtime data
+ * @stream: stream name
+ * @event: stream event
+ *
+ * Sends a stream event to the dapm core. The core then makes any
+ * necessary widget power changes.
+ *
+ * Returns 0 for success else error.
+ */
+int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
+	const char *stream, int event)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+
+	if (stream == NULL)
+		return 0;
+
+	mutex_lock(&codec->mutex);
+	soc_dapm_stream_event(codec->dapm, stream, event);
 	mutex_unlock(&codec->mutex);
 	return 0;
 }
@@ -2043,9 +2055,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_enable_pin(struct snd_soc_dapm_context *dapm, const char *pin)
 {
-	return snd_soc_dapm_set_pin(codec, pin, 1);
+	return snd_soc_dapm_set_pin(dapm, pin, 1);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_enable_pin);
 
@@ -2061,20 +2073,21 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_enable_pin);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_force_enable_pin(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm, const char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin)) {
-			pr_debug("dapm: %s: pin %s\n", codec->name, pin);
+			pr_debug("dapm: %s: pin %s\n", dapm->codec->name, pin);
 			w->connected = 1;
 			w->force = 1;
 			return 0;
 		}
 	}
 
-	pr_err("dapm: %s: configuring unknown pin %s\n", codec->name, pin);
+	pr_err("dapm: %s: configuring unknown pin %s\n",
+	       dapm->codec->name, pin);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_force_enable_pin);
@@ -2088,9 +2101,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_force_enable_pin);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_disable_pin(struct snd_soc_dapm_context *dapm, const char *pin)
 {
-	return snd_soc_dapm_set_pin(codec, pin, 0);
+	return snd_soc_dapm_set_pin(dapm, pin, 0);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_disable_pin);
 
@@ -2108,9 +2121,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_disable_pin);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_nc_pin(struct snd_soc_dapm_context *dapm, const char *pin)
 {
-	return snd_soc_dapm_set_pin(codec, pin, 0);
+	return snd_soc_dapm_set_pin(dapm, pin, 0);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_nc_pin);
 
@@ -2123,11 +2136,11 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_nc_pin);
  *
  * Returns 1 for connected otherwise 0.
  */
-int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_get_pin_status(struct snd_soc_dapm_context *dapm, const char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin))
 			return w->connected;
 	}
@@ -2151,7 +2164,7 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_codec *codec, const char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &codec->dapm->widgets, list) {
 		if (!strcmp(w->name, pin)) {
 			w->ignore_suspend = 1;
 			return 0;
@@ -2169,20 +2182,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
  *
  * Free all dapm widgets and resources.
  */
-void snd_soc_dapm_free(struct snd_soc_codec *codec)
+void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm)
 {
-	snd_soc_dapm_sys_remove(codec->dev);
-	dapm_free_widgets(codec);
+	snd_soc_dapm_sys_remove(dapm->dev);
+	dapm_free_widgets(dapm);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
-static void soc_dapm_shutdown_codec(struct snd_soc_codec *codec)
+static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 	LIST_HEAD(down_list);
 	int powerdown = 0;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (w->power) {
 			dapm_seq_insert(w, &down_list, dapm_down_seq);
 			w->power = 0;
@@ -2194,9 +2207,9 @@ static void soc_dapm_shutdown_codec(struct snd_soc_codec *codec)
 	 * standby.
 	 */
 	if (powerdown) {
-		snd_soc_dapm_set_bias_level(NULL, codec, SND_SOC_BIAS_PREPARE);
-		dapm_seq_run(codec, &down_list, 0, dapm_down_seq);
-		snd_soc_dapm_set_bias_level(NULL, codec, SND_SOC_BIAS_STANDBY);
+		snd_soc_dapm_set_bias_level(NULL, dapm, SND_SOC_BIAS_PREPARE);
+		dapm_seq_run(dapm, &down_list, 0, dapm_down_seq);
+		snd_soc_dapm_set_bias_level(NULL, dapm, SND_SOC_BIAS_STANDBY);
 	}
 }
 
@@ -2207,10 +2220,10 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
 
-	list_for_each_entry(codec, &card->codec_dev_list, list)
-		soc_dapm_shutdown_codec(codec);
-
-	snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_OFF);
+	list_for_each_entry(codec, &card->codec_dev_list, list) {
+		soc_dapm_shutdown_codec(codec->dapm);
+		snd_soc_dapm_set_bias_level(card, codec->dapm, SND_SOC_BIAS_OFF);
+	}
 }
 
 /* Module information */
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 8a0a920..3deb26e 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -88,15 +88,15 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 			enable = !enable;
 
 		if (enable)
-			snd_soc_dapm_enable_pin(codec, pin->pin);
+			snd_soc_dapm_enable_pin(codec->dapm, pin->pin);
 		else
-			snd_soc_dapm_disable_pin(codec, pin->pin);
+			snd_soc_dapm_disable_pin(codec->dapm, pin->pin);
 	}
 
 	/* Report before the DAPM sync to help users updating micbias status */
 	blocking_notifier_call_chain(&jack->notifier, status, NULL);
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(codec->dapm);
 
 	snd_jack_report(jack->jack, status);
 
-- 
1.7.2.3
