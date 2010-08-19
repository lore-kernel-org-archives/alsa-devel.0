From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Thu, 19 Aug 2010 14:44:51 +0300
Message-ID: <20100819144451.1d827367.jhnikula@gmail.com>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3EB1424405
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 13:44:31 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1115517ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 04:44:30 -0700 (PDT)
In-Reply-To: <20100816110902.GA10354@sirena.org.uk>
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

On Mon, 16 Aug 2010 12:09:03 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Aug 16, 2010 at 01:53:28PM +0300, Jarkko Nikula wrote:
> 
> > Multi-DAI codecs are not so clear to me. I thought codecs are exporting
> > different controls for different DAIs? Like "foo Playback Volume" and
> > "bar Playback Volume".
> 
> No, consider CODECs which support mixing signals between the two DAIs
> like the WM9713 or WM8994.  You will normally have some controls for the
> very edge of the CODEC but for at the parts of the CODEC after mixing
> there's no way to distinguish based on the DAI.

Here's the work in progress version of this RFC before trying to patch
all the drivers. Previous version wasn't enough at all.

kcontrol or name prefix still comes from dai_link->kcontrol_prefix
(where it should be per codec as pointer by Mark). And no drivers are
patched for snd_soc_add_controls, snd_soc_dapm_new_control,
snd_soc_dapm_new_controls and snd_soc_dapm_add_routes API changes.

But core ideas are here how different drivers should call those
functions:

Codec:
- kcontrol prefix
- no widget name prefix (as they are per codec)
- no audio map prefix (as they are per codec)

Machine:
- no kcontrol prefix (they are anyway machine specific)
- no widget name prefix (they are anyway machine specific)
- no audio map prefix (since this is includes both codec widgets
  with no prefixes and extra driver widgets with prefixes)

Extra driver, e.g. amplifier registered to a codec in machine driver:
- kcontrol prefix (this must be different than codec->kcontrol_prefix)
- widget name prefix (ditto)
- audio map prefix (ditto)

So codec drivers would pass prefix to snd_soc_add_controls and NULL to
snd_soc_dapm_new_controls and snd_soc_dapm_add_routes.

Machine drivers will pass NULL to all.

Extra drivers will pass some own prefix from machine driver to all of
those functions so that multiple instances could be registered to
same codec.


-- 
Jarkko

============== HALF DONE RFC ================
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c4a4456..b0e1323 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -315,16 +315,18 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
 int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
-	const struct snd_soc_dapm_widget *widget);
+	const struct snd_soc_dapm_widget *widget,
+	const char *name_prefix);
 int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 	const struct snd_soc_dapm_widget *widget,
-	int num);
+	int num, const char *name_prefix);
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec);
 void snd_soc_dapm_free(struct snd_soc_codec *codec);
 int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
-			    const struct snd_soc_dapm_route *route, int num);
+			    const struct snd_soc_dapm_route *route, int num,
+			    const char *name_prefix);
 
 /* dapm events */
 int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
@@ -412,6 +414,7 @@ struct snd_soc_dapm_path {
 struct snd_soc_dapm_widget {
 	enum snd_soc_dapm_type id;
 	char *name;		/* widget name */
+	bool prefixed;	/* set if widget name is prefixed */
 	char *sname;	/* stream name */
 	struct snd_soc_codec *codec;
 	struct list_head list;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index d31e8b7..cc4acd9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -311,7 +311,8 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
 struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 	void *data, char *long_name);
 int snd_soc_add_controls(struct snd_soc_codec *codec,
-	const struct snd_kcontrol_new *controls, int num_controls);
+	const struct snd_kcontrol_new *controls, int num_controls,
+	const char *name_prefix);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
@@ -423,6 +424,7 @@ struct snd_soc_ops {
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
+	const char *kcontrol_prefix;
 	int id;
 	struct device *dev;
 	struct snd_soc_codec_driver *driver;
@@ -539,6 +541,7 @@ struct snd_soc_dai_link {
 	const char *platform_name;	/* for multi-platform */
 	const char *cpu_dai_name;
 	const char *codec_dai_name;
+	const char *kcontrol_prefix;	/* kcontrol prefix for multi-codec */
 
 	/* Keep DAI active over suspend */
 	unsigned int ignore_suspend:1;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7093c17..258cde4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1280,6 +1280,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	/* config components */
 	codec_dai->codec = codec;
 	codec->card = card;
+	codec->kcontrol_prefix = dai_link->kcontrol_prefix;
 	cpu_dai->platform = platform;
 	rtd->card = card;
 	rtd->dev.parent = card->dev;
@@ -1888,21 +1889,31 @@ EXPORT_SYMBOL_GPL(snd_soc_cnew);
  * @codec: codec to add controls to
  * @controls: array of controls to add
  * @num_controls: number of elements in the array
+ * @name_prefix: prefix to kcontrol name or NULL
  *
  * Return 0 for success, else error.
  */
 int snd_soc_add_controls(struct snd_soc_codec *codec,
-	const struct snd_kcontrol_new *controls, int num_controls)
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
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 035cab8..19c754f 100644
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
 
@@ -1416,6 +1448,7 @@ err:
  * @codec: codec
  * @route: audio routes
  * @num: number of routes
+ * @name_prefix: prefix to route name or NULL
  *
  * Connects 2 dapm widgets together via a named audio path. The sink is
  * the widget receiving the audio signal, whilst the source is the sender
@@ -1425,12 +1458,13 @@ err:
  * with a call to snd_soc_card_free().
  */
 int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
-			    const struct snd_soc_dapm_route *route, int num)
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
@@ -1933,13 +1967,31 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
  * Returns 0 for success else error.
  */
 int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
-	const struct snd_soc_dapm_widget *widget)
+	const struct snd_soc_dapm_widget *widget, const char *name_prefix)
 {
 	struct snd_soc_dapm_widget *w;
+	size_t name_len;
+	struct snd_soc_dapm_path *path;
 
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
@@ -1948,6 +2000,7 @@ int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 
 	/* machine layer set ups unconnected pins and insertions */
 	w->connected = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
@@ -1957,6 +2010,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
  * @codec: audio codec
  * @widget: widget array
  * @num: number of widgets
+ * @name_prefix: prefix to widget name or NULL
  *
  * Creates new DAPM controls based upon the templates.
  *
@@ -1964,12 +2018,12 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
  */
 int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 	const struct snd_soc_dapm_widget *widget,
-	int num)
+	int num, const char *name_prefix)
 {
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
-		ret = snd_soc_dapm_new_control(codec, widget);
+		ret = snd_soc_dapm_new_control(codec, widget, name_prefix);
 		if (ret < 0) {
 			printk(KERN_ERR
 			       "ASoC: Failed to create DAPM control %s: %d\n",
