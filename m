From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Mon, 23 Aug 2010 17:46:43 +0300
Message-ID: <20100823174643.f0380838.jhnikula@gmail.com>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id C519C24343
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 16:46:12 +0200 (CEST)
Received: by bwz4 with SMTP id 4so124153bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 07:46:11 -0700 (PDT)
In-Reply-To: <20100820115144.451b474f.jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Aug 2010 11:51:44 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> On Thu, 19 Aug 2010 18:20:49 +0300
> Jarkko Nikula <jhnikula@gmail.com> wrote:
> 
> > 	cpu_dai->driver->probe
> > 	codec->driver->probe
> > 	-> Codec adds controls, widgets and routes (only controls
> > 	are prefixed. E.g. "front.")
> > 	platform->driver->probe
> > 	codec_dai->driver->probe
> > 	dai_link->init
> > 	-> Machine adds controls, widgets and routes (no prefixes)
> > 	-> Machine registers stuff from extra drivers (all
> > 	controls, widgets and routes are prefixed per driver.
> > 	E.g. "front-left-amp.", "front-right-amp." )
> > 
> > Codec and machine registrations are easy to separate e.g. by some flag
> > and use only codec->kcontrol_prefix and continue using unmodified API.
> > 
> > I think extra drivers could use own variants of those registration
> > functions that have the name_prefix argument (and core would call them
> > too). Then we don't need to patch all the codec and machine drivers.
> > Does this sound feasible?
> > 
> Ok, this was easy. I added functions variants that take the prefix and
> that core calls also. So _snd_soc_add_controls,
> _snd_soc_dapm_new_control, _snd_soc_dapm_new_controls and
> _snd_soc_dapm_add_routes.
> 
> This way there is no need to patch all existing drivers and core can
> prefix nicely codec kcontrols based on codec->probed flag. Then
> external drivers can use those function variants by passing custom 
> prefix that is different than codec->kcontrol_prefix.
> 
> No other changes from previous version. I.e. dai_link->kcontrol_prefix
> hack is still here.
> 
Here's the recent version.

I removed dai_link->kcontrol_prefix hack from this version, removed one
unused spuriously added variable and added pointer to optional name
prefix map into struct snd_soc_card that is used to associate prefix to
codec.

So if there's a machine with two bar-codecs, following code associated
prefix 'b' to kcontrols of second codec.

static struct snd_soc_prefix_map foo_codec_prefix[] = {
	{
		.codec_name = "bar-codec.2",
		.kcontrol_prefix = "b",
	},
};

static struct snd_soc_card foo_sound_card = {
	.name = "FOO,
	.dai_link = foo_dai,
	.num_links = ARRAY_SIZE(foo_dai),
	.prefix_map = foo_codec_prefix,
	.num_prefixes = ARRAY_SIZE(foo_codec_prefix),
};


-- 
Jarkko

================== RFC ===============
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c4a4456..44516de 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -314,8 +314,14 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
 int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
+int _snd_soc_dapm_new_control(struct snd_soc_codec *codec,
+	const struct snd_soc_dapm_widget *widget,
+	const char *name_prefix);
 int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 	const struct snd_soc_dapm_widget *widget);
+int _snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+	const struct snd_soc_dapm_widget *widget,
+	int num, const char *name_prefix);
 int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 	const struct snd_soc_dapm_widget *widget,
 	int num);
@@ -323,6 +329,9 @@ int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec);
 void snd_soc_dapm_free(struct snd_soc_codec *codec);
+int _snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+			    const struct snd_soc_dapm_route *route, int num,
+			    const char *name_prefix);
 int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
 			    const struct snd_soc_dapm_route *route, int num);
 
@@ -412,6 +421,7 @@ struct snd_soc_dapm_path {
 struct snd_soc_dapm_widget {
 	enum snd_soc_dapm_type id;
 	char *name;		/* widget name */
+	bool prefixed;	/* set if widget name is prefixed */
 	char *sname;	/* stream name */
 	struct snd_soc_codec *codec;
 	struct list_head list;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index d31e8b7..06c13ec 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -310,6 +310,9 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
  */
 struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 	void *data, char *long_name);
+int _snd_soc_add_controls(struct snd_soc_codec *codec,
+	const struct snd_kcontrol_new *controls, int num_controls,
+	const char *name_prefix);
 int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
@@ -423,6 +426,7 @@ struct snd_soc_ops {
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
+	const char *kcontrol_prefix;
 	int id;
 	struct device *dev;
 	struct snd_soc_codec_driver *driver;
@@ -553,6 +557,11 @@ struct snd_soc_dai_link {
 	struct snd_soc_ops *ops;
 };
 
+struct snd_soc_prefix_map {
+	const char *codec_name;
+	const char *kcontrol_prefix;
+};
+
 /* SoC card */
 struct snd_soc_card {
 	const char *name;
@@ -587,6 +596,10 @@ struct snd_soc_card {
 	struct snd_soc_pcm_runtime *rtd;
 	int num_rtd;
 
+	/* optional map of name prefixes that are associated per codec */
+	struct snd_soc_prefix_map *prefix_map;
+	int num_prefixes;
+
 	struct work_struct deferred_resume_work;
 
 	/* lists of probed devices belonging to this card */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 65352c7..5162bbe 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1266,6 +1266,23 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 
 static void rtd_release(struct device *dev) {}
 
+static void soc_set_name_prefix(struct snd_soc_card *card,
+				struct snd_soc_codec *codec)
+{
+	int i;
+
+	if (card->prefix_map == NULL)
+		return;
+
+	for (i = 0; i < card->num_prefixes; i++) {
+		struct snd_soc_prefix_map *map = &card->prefix_map[i];
+		if (map->codec_name && !strcmp(codec->name, map->codec_name)) {
+			codec->kcontrol_prefix = map->kcontrol_prefix;
+			break;
+		}
+	}
+}
+
 static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
@@ -1306,6 +1323,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 
 	/* probe the CODEC */
 	if (!codec->probed) {
+		soc_set_name_prefix(card, codec);
 		if (codec->driver->probe) {
 			ret = codec->driver->probe(codec);
 			if (ret < 0) {
@@ -1881,34 +1899,68 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 EXPORT_SYMBOL_GPL(snd_soc_cnew);
 
 /**
- * snd_soc_add_controls - add an array of controls to a codec.
- * Convienience function to add a list of controls. Many codecs were
- * duplicating this code.
+ * _snd_soc_add_controls - add an array of controls to a codec.
+ * This varian of snd_soc_add_controls allow to specify custom name prefix to
+ * controls.
  *
  * @codec: codec to add controls to
  * @controls: array of controls to add
  * @num_controls: number of elements in the array
+ * @name_prefix: prefix to kcontrol name or NULL
  *
  * Return 0 for success, else error.
  */
-int snd_soc_add_controls(struct snd_soc_codec *codec,
-	const struct snd_kcontrol_new *controls, int num_controls)
+int _snd_soc_add_controls(struct snd_soc_codec *codec,
+	const struct snd_kcontrol_new *controls, int num_controls,
+	const char *name_prefix)
 {
 	struct snd_card *card = codec->card->snd_card;
+	char prefixed_name[44], *name;
 	int err, i;
 
 	for (i = 0; i < num_controls; i++) {
 		const struct snd_kcontrol_new *control = &controls[i];
-		err = snd_ctl_add(card, snd_soc_cnew(control, codec, NULL));
+		if (name_prefix) {
+			snprintf(prefixed_name, sizeof(prefixed_name), "%s.%s",
+				 name_prefix, control->name);
+			name = prefixed_name;
+		} else {
+			name = control->name;
+		}
+		err = snd_ctl_add(card, snd_soc_cnew(control, codec, name));
 		if (err < 0) {
 			dev_err(codec->dev, "%s: Failed to add %s\n",
-				codec->name, control->name);
+				codec->name, name);
 			return err;
 		}
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(_snd_soc_add_controls);
+
+/**
+ * snd_soc_add_controls - add an array of controls to a codec.
+ * Convienience function to add a list of controls. Many codecs were
+ * duplicating this code.
+ *
+ * @codec: codec to add controls to
+ * @controls: array of controls to add
+ * @num_controls: number of elements in the array
+ *
+ * Return 0 for success, else error.
+ */
+int snd_soc_add_controls(struct snd_soc_codec *codec,
+	const struct snd_kcontrol_new *controls, int num_controls)
+{
+	const char *prefix = NULL;
+
+	/* Only codec controls are prefixed */
+	if (!codec->probed)
+		prefix = codec->kcontrol_prefix;
+
+	return _snd_soc_add_controls(codec, controls, num_controls, prefix);
+}
 EXPORT_SYMBOL_GPL(snd_soc_add_controls);
 
 /**
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 035cab8..9a419b2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -327,6 +327,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 	int i, ret = 0;
 	size_t name_len;
 	struct snd_soc_dapm_path *path;
+	char prefix[10];
 
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
@@ -347,6 +348,13 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 			name_len = strlen(w->kcontrols[i].name) + 1;
 			if (w->id != snd_soc_dapm_mixer_named_ctl)
 				name_len += 1 + strlen(w->name);
+			if (codec->kcontrol_prefix && !w->prefixed) {
+				name_len += 1 + strlen(codec->kcontrol_prefix);
+				snprintf(prefix, sizeof(prefix), "%s.",
+					 codec->kcontrol_prefix);
+			} else {
+				prefix[0] = '\0';
+			}
 
 			path->long_name = kmalloc(name_len, GFP_KERNEL);
 
@@ -355,12 +363,12 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 
 			switch (w->id) {
 			default:
-				snprintf(path->long_name, name_len, "%s %s",
-					 w->name, w->kcontrols[i].name);
+				snprintf(path->long_name, name_len, "%s%s %s",
+					 prefix, w->name, w->kcontrols[i].name);
 				break;
 			case snd_soc_dapm_mixer_named_ctl:
-				snprintf(path->long_name, name_len, "%s",
-					 w->kcontrols[i].name);
+				snprintf(path->long_name, name_len, "%s%s",
+					 prefix, w->kcontrols[i].name);
 				break;
 			}
 
@@ -388,6 +396,7 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 {
 	struct snd_soc_dapm_path *path = NULL;
 	struct snd_kcontrol *kcontrol;
+	char prefixed_name[44], *name;
 	int ret = 0;
 
 	if (!w->num_kcontrols) {
@@ -395,7 +404,14 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name);
+	if (codec->kcontrol_prefix && !w->prefixed) {
+		snprintf(prefixed_name, sizeof(prefixed_name), "%s.%s",
+			 codec->kcontrol_prefix, w->name);
+		name = prefixed_name;
+	} else {
+		name = w->name;
+	}
+	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, name);
 	ret = snd_ctl_add(codec->card->snd_card, kcontrol);
 	if (ret < 0)
 		goto err;
@@ -406,7 +422,7 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 	return ret;
 
 err:
-	printk(KERN_ERR "asoc: failed to add kcontrol %s\n", w->name);
+	printk(KERN_ERR "asoc: failed to add kcontrol %s\n", name);
 	return ret;
 }
 
@@ -1253,6 +1269,7 @@ static void dapm_free_widgets(struct snd_soc_codec *codec)
 
 	list_for_each_entry_safe(w, next_w, &codec->dapm_widgets, list) {
 		list_del(&w->list);
+		kfree(w->name);
 		kfree(w);
 	}
 
@@ -1299,15 +1316,30 @@ int snd_soc_dapm_sync(struct snd_soc_codec *codec)
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
 static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
-				  const struct snd_soc_dapm_route *route)
+				  const struct snd_soc_dapm_route *route,
+				  const char *name_prefix)
 {
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
-	const char *sink = route->sink;
+	const char *sink;
 	const char *control = route->control;
-	const char *source = route->source;
+	const char *source;
+	char prefixed_sink[80];
+	char prefixed_source[80];
 	int ret = 0;
 
+	if (name_prefix) {
+		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s.%s",
+			 name_prefix, route->sink);
+		sink = prefixed_sink;
+		snprintf(prefixed_source, sizeof(prefixed_source), "%s.%s",
+			 name_prefix, route->source);
+		source = prefixed_source;
+	} else {
+		sink = route->sink;
+		source = route->source;
+	}
+
 	/* find src and dest widgets */
 	list_for_each_entry(w, &codec->dapm_widgets, list) {
 
@@ -1412,25 +1444,28 @@ err:
 }
 
 /**
- * snd_soc_dapm_add_routes - Add routes between DAPM widgets
+ * _snd_soc_dapm_add_routes - Add routes between DAPM widgets
  * @codec: codec
  * @route: audio routes
  * @num: number of routes
+ * @name_prefix: prefix to route name or NULL
  *
  * Connects 2 dapm widgets together via a named audio path. The sink is
  * the widget receiving the audio signal, whilst the source is the sender
- * of the audio signal.
+ * of the audio signal. This variant of snd_soc_dapm_add_routes allow to
+ * specify custom prefix to source and sink names of route.
  *
  * Returns 0 for success else error. On error all resources can be freed
  * with a call to snd_soc_card_free().
  */
-int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
-			    const struct snd_soc_dapm_route *route, int num)
+int _snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+			    const struct snd_soc_dapm_route *route, int num,
+			    const char *name_prefix)
 {
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
-		ret = snd_soc_dapm_add_route(codec, route);
+		ret = snd_soc_dapm_add_route(codec, route, name_prefix);
 		if (ret < 0) {
 			printk(KERN_ERR "Failed to add route %s->%s\n",
 			       route->source,
@@ -1442,6 +1477,26 @@ int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(_snd_soc_dapm_add_routes);
+
+/**
+ * snd_soc_dapm_add_routes - Add routes between DAPM widgets
+ * @codec: codec
+ * @route: audio routes
+ * @num: number of routes
+ *
+ * Connects 2 dapm widgets together via a named audio path. The sink is
+ * the widget receiving the audio signal, whilst the source is the sender
+ * of the audio signal.
+ *
+ * Returns 0 for success else error. On error all resources can be freed
+ * with a call to snd_soc_card_free().
+ */
+int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+			    const struct snd_soc_dapm_route *route, int num)
+{
+	return _snd_soc_dapm_add_routes(codec, route, num, NULL);
+}
 EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 
 /**
@@ -1924,22 +1979,40 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
 /**
- * snd_soc_dapm_new_control - create new dapm control
+ * _snd_soc_dapm_new_control - create new dapm control
  * @codec: audio codec
  * @widget: widget template
  *
- * Creates a new dapm control based upon the template.
+ * Creates a new dapm control based upon the template. This variant of
+ * snd_soc_dapm_new_control allow to specify custom prefix to widget name.
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
-	const struct snd_soc_dapm_widget *widget)
+int _snd_soc_dapm_new_control(struct snd_soc_codec *codec,
+	const struct snd_soc_dapm_widget *widget, const char *name_prefix)
 {
 	struct snd_soc_dapm_widget *w;
+	size_t name_len;
 
 	if ((w = dapm_cnew_widget(widget)) == NULL)
 		return -ENOMEM;
 
+	name_len = strlen(widget->name) + 1;
+	if (name_prefix)
+		name_len += 1 + strlen(name_prefix);
+	w->name = kmalloc(name_len, GFP_KERNEL);
+	if (w->name == NULL) {
+		kfree(w);
+		return -ENOMEM;
+	}
+	if (name_prefix) {
+		snprintf(w->name, name_len, "%s.%s",
+			 name_prefix, widget->name);
+		w->prefixed = 1;
+	} else {
+		snprintf(w->name, name_len, "%s", widget->name);
+	}
+
 	w->codec = codec;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
@@ -1948,28 +2021,47 @@ int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 
 	/* machine layer set ups unconnected pins and insertions */
 	w->connected = 1;
+
 	return 0;
 }
+EXPORT_SYMBOL_GPL(_snd_soc_dapm_new_control);
+
+/**
+ * snd_soc_dapm_new_control - create new dapm control
+ * @codec: audio codec
+ * @widget: widget template
+ *
+ * Creates a new dapm control based upon the template.
+ *
+ * Returns 0 for success else error.
+ */
+int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
+	const struct snd_soc_dapm_widget *widget)
+{
+	return _snd_soc_dapm_new_control(codec, widget, NULL);
+}
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
 
 /**
- * snd_soc_dapm_new_controls - create new dapm controls
+ * _snd_soc_dapm_new_controls - create new dapm controls
  * @codec: audio codec
  * @widget: widget array
  * @num: number of widgets
+ * @name_prefix: prefix to widget name or NULL
  *
- * Creates new DAPM controls based upon the templates.
+ * Creates new DAPM controls based upon the templates. This variant of
+ * snd_soc_dapm_new_controls allow to specify custom prefix to widget names.
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+int _snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 	const struct snd_soc_dapm_widget *widget,
-	int num)
+	int num, const char *name_prefix)
 {
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
-		ret = snd_soc_dapm_new_control(codec, widget);
+		ret = _snd_soc_dapm_new_control(codec, widget, name_prefix);
 		if (ret < 0) {
 			printk(KERN_ERR
 			       "ASoC: Failed to create DAPM control %s: %d\n",
@@ -1980,8 +2072,25 @@ int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
+EXPORT_SYMBOL_GPL(_snd_soc_dapm_new_controls);
 
+/**
+ * snd_soc_dapm_new_controls - create new dapm controls
+ * @codec: audio codec
+ * @widget: widget array
+ * @num: number of widgets
+ *
+ * Creates new DAPM controls based upon the templates.
+ *
+ * Returns 0 for success else error.
+ */
+int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+	const struct snd_soc_dapm_widget *widget,
+	int num)
+{
+	return _snd_soc_dapm_new_controls(codec, widget, num, NULL);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
 /**
  * snd_soc_dapm_stream_event - send a stream event to the dapm core
