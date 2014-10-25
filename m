From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/8] ASoC: dapm: Do not pretend to support
	controls for non mixer/mux widgets
Date: Sat, 25 Oct 2014 17:41:58 +0200
Message-ID: <1414251723-25050-4-git-send-email-lars@metafoo.de>
References: <1414251723-25050-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id A856B260632
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 17:42:12 +0200 (CEST)
In-Reply-To: <1414251723-25050-1-git-send-email-lars@metafoo.de>
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

Controls on a path only have an effect if the sink on the path is either a
mixer or mux widget. Currently we sort of silently ignore controls on other
paths, but since they don't do anything having them on other paths does not
make much sense and it is probably safe to assume that if we see such a path
it is a mistake in the driver that registered the path. This patch modifies
snd_soc_dapm_add_path() to report an error if a path with and control is
encountered where we didn't expect a control. This also allows to simplify
the code quite a bit.

The patch also moves the connecting of the path lists out of
dapm_connect_mux() and dapm_connect_mixer() into snd_soc_dapm_add_path().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Rebased on topic/dapm
---
 sound/soc/soc-dapm.c | 112 +++++++++++++++++----------------------------------
 1 file changed, 37 insertions(+), 75 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1fed220..c49df10 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -469,10 +469,9 @@ out:
 
 /* connect mux widget to its interconnecting audio paths */
 static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
-	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
-	struct snd_soc_dapm_path *path, const char *control_name,
-	const struct snd_kcontrol_new *kcontrol)
+	struct snd_soc_dapm_path *path, const char *control_name)
 {
+	const struct snd_kcontrol_new *kcontrol = &path->sink->kcontrol_news[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, item;
 	int i;
@@ -493,9 +492,6 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 
 	for (i = 0; i < e->items; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
-			list_add(&path->list, &dapm->card->paths);
-			list_add(&path->list_sink, &dest->sources);
-			list_add(&path->list_source, &src->sinks);
 			path->name = e->texts[i];
 			if (i == item)
 				path->connect = 1;
@@ -509,11 +505,10 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 }
 
 /* set up initial codec paths */
-static void dapm_set_mixer_path_status(struct snd_soc_dapm_widget *w,
-	struct snd_soc_dapm_path *p, int i)
+static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
 {
 	struct soc_mixer_control *mc = (struct soc_mixer_control *)
-		w->kcontrol_news[i].private_value;
+		p->sink->kcontrol_news[i].private_value;
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	unsigned int max = mc->max;
@@ -522,7 +517,7 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_widget *w,
 	unsigned int val;
 
 	if (reg != SND_SOC_NOPM) {
-		soc_dapm_read(w->dapm, reg, &val);
+		soc_dapm_read(p->sink->dapm, reg, &val);
 		val = (val >> shift) & mask;
 		if (invert)
 			val = max - val;
@@ -534,19 +529,15 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_widget *w,
 
 /* connect mixer widget to its interconnecting audio paths */
 static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
-	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
 	struct snd_soc_dapm_path *path, const char *control_name)
 {
 	int i;
 
 	/* search for mixer kcontrol */
-	for (i = 0; i < dest->num_kcontrols; i++) {
-		if (!strcmp(control_name, dest->kcontrol_news[i].name)) {
-			list_add(&path->list, &dapm->card->paths);
-			list_add(&path->list_sink, &dest->sources);
-			list_add(&path->list_source, &src->sinks);
-			path->name = dest->kcontrol_news[i].name;
-			dapm_set_mixer_path_status(dest, path, i);
+	for (i = 0; i < path->sink->num_kcontrols; i++) {
+		if (!strcmp(control_name, path->sink->kcontrol_news[i].name)) {
+			path->name = path->sink->kcontrol_news[i].name;
+			dapm_set_mixer_path_status(path, i);
 			return 0;
 		}
 	}
@@ -2272,69 +2263,40 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 			wsource->ext = 1;
 	}
 
-	dapm_mark_dirty(wsource, "Route added");
-	dapm_mark_dirty(wsink, "Route added");
-
 	/* connect static paths */
 	if (control == NULL) {
-		list_add(&path->list, &dapm->card->paths);
-		list_add(&path->list_sink, &wsink->sources);
-		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
-		return 0;
-	}
-
-	/* connect dynamic paths */
-	switch (wsink->id) {
-	case snd_soc_dapm_adc:
-	case snd_soc_dapm_dac:
-	case snd_soc_dapm_pga:
-	case snd_soc_dapm_out_drv:
-	case snd_soc_dapm_input:
-	case snd_soc_dapm_output:
-	case snd_soc_dapm_siggen:
-	case snd_soc_dapm_micbias:
-	case snd_soc_dapm_vmid:
-	case snd_soc_dapm_pre:
-	case snd_soc_dapm_post:
-	case snd_soc_dapm_supply:
-	case snd_soc_dapm_regulator_supply:
-	case snd_soc_dapm_clock_supply:
-	case snd_soc_dapm_aif_in:
-	case snd_soc_dapm_aif_out:
-	case snd_soc_dapm_dai_in:
-	case snd_soc_dapm_dai_out:
-	case snd_soc_dapm_dai_link:
-	case snd_soc_dapm_kcontrol:
-		list_add(&path->list, &dapm->card->paths);
-		list_add(&path->list_sink, &wsink->sources);
-		list_add(&path->list_source, &wsource->sinks);
-		path->connect = 1;
-		return 0;
-	case snd_soc_dapm_mux:
-		ret = dapm_connect_mux(dapm, wsource, wsink, path, control,
-			&wsink->kcontrol_news[0]);
-		if (ret != 0)
-			goto err;
-		break;
-	case snd_soc_dapm_switch:
-	case snd_soc_dapm_mixer:
-	case snd_soc_dapm_mixer_named_ctl:
-		ret = dapm_connect_mixer(dapm, wsource, wsink, path, control);
-		if (ret != 0)
+	} else {
+		/* connect dynamic paths */
+		switch (wsink->id) {
+		case snd_soc_dapm_mux:
+			ret = dapm_connect_mux(dapm, path, control);
+			if (ret != 0)
+				goto err;
+			break;
+		case snd_soc_dapm_switch:
+		case snd_soc_dapm_mixer:
+		case snd_soc_dapm_mixer_named_ctl:
+			ret = dapm_connect_mixer(dapm, path, control);
+			if (ret != 0)
+				goto err;
+			break;
+		default:
+			dev_err(dapm->dev,
+				"Control not supported for path %s -> [%s] -> %s\n",
+				wsource->name, control, wsink->name);
+			ret = -EINVAL;
 			goto err;
-		break;
-	case snd_soc_dapm_hp:
-	case snd_soc_dapm_mic:
-	case snd_soc_dapm_line:
-	case snd_soc_dapm_spk:
-		list_add(&path->list, &dapm->card->paths);
-		list_add(&path->list_sink, &wsink->sources);
-		list_add(&path->list_source, &wsource->sinks);
-		path->connect = 0;
-		return 0;
+		}
 	}
 
+	list_add(&path->list, &dapm->card->paths);
+	list_add(&path->list_sink, &wsink->sources);
+	list_add(&path->list_source, &wsource->sinks);
+
+	dapm_mark_dirty(wsource, "Route added");
+	dapm_mark_dirty(wsink, "Route added");
+
 	return 0;
 err:
 	kfree(path);
-- 
1.8.0
