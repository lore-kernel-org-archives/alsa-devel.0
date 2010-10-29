From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC_iv/iv 1/1] ASoC: Add optional name_prefix to
	struct snd_soc_dev_map
Date: Fri, 29 Oct 2010 15:03:43 +0300
Message-ID: <1288353823-22075-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CB4410385D
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 14:02:31 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1625642ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 05:02:31 -0700 (PDT)
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
the same name or when building the audio paths between codecs.

This patch solves the issue by introducing optional name_prefix field to
struct snd_soc_dev_map that machine drivers can specify. ASoC core then uses
that prefix for prefixing names for codec kcontrols, widgets and codec
internal routes.

Following example illustrates how two same codec instances are registered in
a machine driver. The name collision is avoided by specifying a name prefix
for the second codec. That prefix is then used in audio map that connects
output of first codec to the input of second and output of second codec to
a machine widget.

static const struct snd_soc_dapm_route map0[] = {
	{"Spk", NULL, "MONO"},
};

static const struct snd_soc_dapm_route map1[] = {
	{"foo LINEIN", NULL, "MONO"},
	{"Vibra", NULL, "foo MONO"},
};

static struct snd_soc_dev_map bar_dev[] = {
	{
		...
		.codec_name = "simple-codec.0",
		.init = bar_codec0_init,
		...
	},
	{
		...
		.codec_name = "simple-codec.1",
		.init = bar_codec1_init,
		.name_prefix = "foo",
		...
	},
};

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc.h  |    4 ++++
 sound/soc/soc-core.c |   16 ++++++++++++++--
 sound/soc/soc-dapm.c |   34 ++++++++++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 17f985c..18de502 100644
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
@@ -547,6 +548,9 @@ struct snd_soc_dev_map {
 
 	/* machine stream operations */
 	struct snd_soc_ops *ops;
+
+	/* optional name prefix for kcontrols and widgets */
+	const char *name_prefix;
 };
 
 /* SoC card */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b904a20..2c9b6ef 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1416,6 +1416,7 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 	/* probe the CODEC */
 	if (!codec->probed) {
 		codec->dapm->card = card;
+		codec->name_prefix = dev_map->name_prefix;
 		if (codec->driver->probe) {
 			ret = codec->driver->probe(codec);
 			if (ret < 0) {
@@ -1469,11 +1470,14 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 
 	/* now that all clients have probed, initialise the DAI link */
 	if (dev_map->init) {
+		/* machine controls, routes and widgets are not prefixed */
+		rtd->codec->name_prefix = NULL;
 		ret = dev_map->init(rtd);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: failed to init %s\n", dev_map->stream_name);
 			return ret;
 		}
+		rtd->codec->name_prefix = dev_map->name_prefix;
 	}
 
 	/* Make sure all DAPM widgets are instantiated */
@@ -2030,14 +2034,22 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
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
-- 
1.7.2.3
