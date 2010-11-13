From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2.1] ASoC: Add optional name_prefix for codec
	kcontrol, widget and route names
Date: Sat, 13 Nov 2010 20:40:44 +0200
Message-ID: <1289673644-2493-1-git-send-email-jhnikula@gmail.com>
References: <1289565525-30231-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A4C9124463
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 19:41:01 +0100 (CET)
Received: by eyg24 with SMTP id 24so2370458eyg.38
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 10:40:58 -0800 (PST)
In-Reply-To: <1289565525-30231-1-git-send-email-jhnikula@gmail.com>
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

There is a need to prefix codec kcontrol, widget and internal route names in
an ASoC machine that has multiple codecs with conflicting names. The name
collision would occur when codec drivers try to registering kcontrols with
the same name or when building audio paths.

This patch introduces optional prefix_map into struct snd_soc_card. With it
machine drivers can specify a unique name prefix to each codec that have
conflicting names with anothers. Prefix to codec is matched with codec
name.

Following example illustrates a machine that has two same codec instances.
Name collision from kcontrol registration is avoided by specifying a name
prefix "foo" for the second codec. As the codec widget names are prefixed
then second audio map for that codec shows a prefixed widget name.

static const struct snd_soc_dapm_route map0[] = {
	{"Spk", NULL, "MONO"},
};

static const struct snd_soc_dapm_route map1[] = {
	{"Vibra", NULL, "foo MONO"},
};

static struct snd_soc_prefix_map codec_prefix[] = {
	{
		.dev_name = "codec.2",
		.name_prefix = "foo",
	},
};

static struct snd_soc_card card = {
	...
	.prefix_map = codec_prefix,
	.num_prefixes = ARRAY_SIZE(codec_prefix),
};

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Just hand-rebased on top of for-2.6.38 as it turns out that we need to cook
with cross-device DAPM patches a little bit more.
---
 include/sound/soc.h  |   13 +++++++++++++
 sound/soc/soc-core.c |   35 +++++++++++++++++++++++++++++++++--
 sound/soc/soc-dapm.c |   34 ++++++++++++++++++++++++++++++++--
 3 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index af23f42..3eb92ef 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -450,6 +450,7 @@ struct snd_soc_cache_ops {
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
+	const char *name_prefix;
 	int id;
 	struct device *dev;
 	struct snd_soc_codec_driver *driver;
@@ -577,6 +578,11 @@ struct snd_soc_dai_link {
 	struct snd_soc_ops *ops;
 };
 
+struct snd_soc_prefix_map {
+	const char *dev_name;
+	const char *name_prefix;
+};
+
 /* SoC card */
 struct snd_soc_card {
 	const char *name;
@@ -611,6 +617,13 @@ struct snd_soc_card {
 	struct snd_soc_pcm_runtime *rtd;
 	int num_rtd;
 
+	/*
+	 * optional map of kcontrol, widget and path name prefixes that are
+	 * associated per device
+	 */
+	struct snd_soc_prefix_map *prefix_map;
+	int num_prefixes;
+
 	struct work_struct deferred_resume_work;
 
 	/* lists of probed devices belonging to this card */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3d70ce5..2540efd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1397,6 +1397,23 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
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
+		if (map->dev_name && !strcmp(codec->name, map->dev_name)) {
+			codec->name_prefix = map->name_prefix;
+			break;
+		}
+	}
+}
+
 static void rtd_release(struct device *dev) {}
 
 static int soc_probe_dai_link(struct snd_soc_card *card, int num)
@@ -1406,6 +1423,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
+	const char *temp;
 	int ret;
 
 	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
@@ -1440,6 +1458,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	/* probe the CODEC */
 	if (!codec->probed) {
 		codec->dapm.card = card;
+		soc_set_name_prefix(card, codec);
 		if (codec->driver->probe) {
 			ret = codec->driver->probe(codec);
 			if (ret < 0) {
@@ -1492,11 +1511,15 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 
 	/* now that all clients have probed, initialise the DAI link */
 	if (dai_link->init) {
+		/* machine controls, routes and widgets are not prefixed */
+		temp = rtd->codec->name_prefix;
+		rtd->codec->name_prefix = NULL;
 		ret = dai_link->init(rtd);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: failed to init %s\n", dai_link->stream_name);
 			return ret;
 		}
+		rtd->codec->name_prefix = temp;
 	}
 
 	/* Make sure all DAPM widgets are instantiated */
@@ -2072,14 +2095,22 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
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
index 8352430..a363db0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1295,6 +1295,7 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 
 	list_for_each_entry_safe(w, next_w, &dapm->widgets, list) {
 		list_del(&w->list);
+		kfree(w->name);
 		kfree(w);
 	}
 
@@ -1346,11 +1347,25 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
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
 	/* find src and dest widgets */
 	list_for_each_entry(w, &dapm->widgets, list) {
 
@@ -1978,10 +1993,25 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
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
 	w->dapm = dapm;
 	w->codec = dapm->codec;
 	INIT_LIST_HEAD(&w->sources);
-- 
1.7.0.4
