From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC_iv/iv 1/1] ASoC: Add optional name_prefix to
 struct snd_soc_dev_map
Date: Sun, 31 Oct 2010 20:12:43 +0200
Message-ID: <20101031201243.3ef62461.jhnikula@gmail.com>
References: <1288353823-22075-1-git-send-email-jhnikula@gmail.com>
	<20101029214244.GK3921@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A2D010381E
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 19:11:21 +0100 (CET)
Received: by mail-ew0-f51.google.com with SMTP id 22so2430312ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 11:11:21 -0700 (PDT)
In-Reply-To: <20101029214244.GK3921@opensource.wolfsonmicro.com>
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

On Fri, 29 Oct 2010 14:42:45 -0700
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Oct 29, 2010 at 03:03:43PM +0300, Jarkko Nikula wrote:
> 
> > @@ -547,6 +548,9 @@ struct snd_soc_dev_map {
> >  
> >  	/* machine stream operations */
> >  	struct snd_soc_ops *ops;
> > +
> > +	/* optional name prefix for kcontrols and widgets */
> > +	const char *name_prefix;
> 
> This is another issue with using the DAI links to map these things - as
> previously discussed we want to be able to support CODEC<->CODEC DAI
> links, and we don't have a way to associate controls with specific DAI
> links on multi-DAI devices.

Indeed, I forgot these links and then name_prefix in
snd_soc_dev_map/_dai_link is not the right place. One of my earlier version
of this prefixing stuff implemented a prefix_map to snd_soc_card
associating a prefix with codec name. Compile tested diff below.

I don't know would it fit to multi-DAI devices. Should those drivers
differentiate inside their controls & widgets for different DAIs?


-- 
Jarkko

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 17f985c..9012c4a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -424,6 +424,7 @@ struct snd_soc_ops {
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
+	const char *name_prefix;
 	int id;
 	struct device *dev;
 	struct snd_soc_codec_driver *driver;
@@ -549,6 +550,11 @@ struct snd_soc_dev_map {
 	struct snd_soc_ops *ops;
 };
 
+struct snd_soc_prefix_map {
+	const char *codec_name;
+	const char *name_prefix;
+};
+
 /* SoC card */
 struct snd_soc_card {
 	const char *name;
@@ -583,6 +589,10 @@ struct snd_soc_card {
 	struct snd_soc_pcm_runtime *rtd;
 	int num_rtd;
 
+	/* optional map of name prefixes that are associated per codec */
+	struct snd_soc_prefix_map *prefix_map;
+	int num_prefixes;
+
 	struct work_struct deferred_resume_work;
 
 	/* lists of probed devices belonging to this card */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b904a20..9b8d657 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1371,6 +1371,23 @@ static void soc_remove_dev_map(struct snd_soc_card *card, int num)
 	}
 }
 
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
+			codec->name_prefix = map->name_prefix;
+			break;
+		}
+	}
+}
+
 static void rtd_release(struct device *dev) {}
 
 static int soc_probe_dev_map(struct snd_soc_card *card, int num)
@@ -1380,6 +1397,7 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
+	const char *temp;
 	int ret;
 
 	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
@@ -1416,6 +1434,7 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 	/* probe the CODEC */
 	if (!codec->probed) {
 		codec->dapm->card = card;
+		soc_set_name_prefix(card, codec);
 		if (codec->driver->probe) {
 			ret = codec->driver->probe(codec);
 			if (ret < 0) {
@@ -1469,11 +1488,15 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 
 	/* now that all clients have probed, initialise the DAI link */
 	if (dev_map->init) {
+		/* machine controls, routes and widgets are not prefixed */
+		temp = rtd->codec->name_prefix;
+		rtd->codec->name_prefix = NULL;
 		ret = dev_map->init(rtd);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: failed to init %s\n", dev_map->stream_name);
 			return ret;
 		}
+		rtd->codec->name_prefix = temp;
 	}
 
 	/* Make sure all DAPM widgets are instantiated */
@@ -2030,14 +2053,22 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
 	struct snd_card *card = codec->card->snd_card;
+	char prefixed_name[44], *name;
 	int err, i;
 
 	for (i = 0; i < num_controls; i++) {
 		const struct snd_kcontrol_new *control = &controls[i];
-		err = snd_ctl_add(card, snd_soc_cnew(control, codec, NULL));
+		if (codec->name_prefix) {
+			snprintf(prefixed_name, sizeof(prefixed_name), "%s %s",
+				 codec->name_prefix, control->name);
+			name = prefixed_name;
+		} else {
+			name = control->name;
+		}
+		err = snd_ctl_add(card, snd_soc_cnew(control, codec, name));
 		if (err < 0) {
 			dev_err(codec->dev, "%s: Failed to add %s: %d\n",
-				codec->name, control->name, err);
+				codec->name, name, err);
 			return err;
 		}
 	}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2bccc9d..34bc7a8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1291,6 +1291,7 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 			kfree(p->long_name);
 			kfree(p);
 		}
+		kfree(w->name);
 		kfree(w);
 	}
 }
@@ -1339,11 +1340,25 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
 	struct snd_soc_dapm_widget *wtsource = NULL, *wtsink = NULL;
-	const char *sink = route->sink;
+	const char *sink;
 	const char *control = route->control;
-	const char *source = route->source;
+	const char *source;
+	char prefixed_sink[80];
+	char prefixed_source[80];
 	int ret = 0;
 
+	if (dapm->codec->name_prefix) {
+		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s %s",
+			 dapm->codec->name_prefix, route->sink);
+		sink = prefixed_sink;
+		snprintf(prefixed_source, sizeof(prefixed_source), "%s %s",
+			 dapm->codec->name_prefix, route->source);
+		source = prefixed_source;
+	} else {
+		sink = route->sink;
+		source = route->source;
+	}
+
 	/*
 	 * find src and dest widgets over all widgets but favor a widget from
 	 * current DAPM context
@@ -1983,10 +1998,25 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget)
 {
 	struct snd_soc_dapm_widget *w;
+	size_t name_len;
 
 	if ((w = dapm_cnew_widget(widget)) == NULL)
 		return -ENOMEM;
 
+	name_len = strlen(widget->name) + 1;
+	if (dapm->codec->name_prefix)
+		name_len += 1 + strlen(dapm->codec->name_prefix);
+	w->name = kmalloc(name_len, GFP_KERNEL);
+	if (w->name == NULL) {
+		kfree(w);
+		return -ENOMEM;
+	}
+	if (dapm->codec->name_prefix)
+		snprintf(w->name, name_len, "%s %s",
+			dapm->codec->name_prefix, widget->name);
+	else
+		snprintf(w->name, name_len, "%s", widget->name);
+
 	dapm->n_widgets++;
 	w->dapm = dapm;
 	w->codec = dapm->codec;
