From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: Merge the soc_value_enum to soc_enum
	struct
Date: Thu,  8 Jan 2009 19:37:56 +0000
Message-ID: <1231443481-29352-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090108193718.GA29183@sirena.org.uk>
	<1231443481-29352-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B233224368
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 20:38:06 +0100 (CET)
In-Reply-To: <1231443481-29352-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Merge the recently introduced soc_value_enum structure to the soc_enum.
The value based enums are still handled separately from the normal enum types,
but with the merge some of the newly introduced functions can be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 +-
 include/sound/soc.h      |   15 +--------
 sound/soc/soc-core.c     |   37 +--------------------
 sound/soc/soc-dapm.c     |   80 +++-------------------------------------------
 4 files changed, 9 insertions(+), 125 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 4af1083..93a4edb 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -178,7 +178,7 @@
   	.private_value = (unsigned long)&xenum }
 #define SOC_DAPM_VALUE_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_value_enum_double, \
+	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_dapm_get_value_enum_double, \
 	.put = snd_soc_dapm_put_value_enum_double, \
 	.private_value = (unsigned long)&xenum }
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9b930d3..24593ac 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -106,7 +106,7 @@
 	.private_value = (unsigned long)&xenum }
 #define SOC_VALUE_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
-	.info = snd_soc_info_value_enum_double, \
+	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_get_value_enum_double, \
 	.put = snd_soc_put_value_enum_double, \
 	.private_value = (unsigned long)&xenum }
@@ -211,8 +211,6 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_info_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
@@ -419,17 +417,6 @@ struct soc_enum {
 	unsigned char shift_l;
 	unsigned char shift_r;
 	unsigned int max;
-	const char **texts;
-	void *dapm;
-};
-
-/* semi enumerated kcontrol */
-struct soc_value_enum {
-	unsigned short reg;
-	unsigned short reg2;
-	unsigned char shift_l;
-	unsigned char shift_r;
-	unsigned int max;
 	unsigned int mask;
 	const char **texts;
 	const unsigned int *values;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6cbe7e8..55fdb4a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1585,37 +1585,6 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
 
 /**
- * snd_soc_info_value_enum_double - semi enumerated double mixer info callback
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Callback to provide information about a double semi enumerated
- * mixer control.
- *
- * Semi enumerated mixer: the enumerated items are referred as values. Can be
- * used for handling bitfield coded enumeration for example.
- *
- * Returns 0 for success.
- */
-int snd_soc_info_value_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
-{
-	struct soc_value_enum *e = (struct soc_value_enum *)
-			kcontrol->private_value;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = e->shift_l == e->shift_r ? 1 : 2;
-	uinfo->value.enumerated.items = e->max;
-
-	if (uinfo->value.enumerated.item > e->max - 1)
-		uinfo->value.enumerated.item = e->max - 1;
-	strcpy(uinfo->value.enumerated.name,
-		e->texts[uinfo->value.enumerated.item]);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_info_value_enum_double);
-
-/**
  * snd_soc_get_value_enum_double - semi enumerated double mixer get callback
  * @kcontrol: mixer control
  * @ucontrol: control element information
@@ -1631,8 +1600,7 @@ int snd_soc_get_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct soc_value_enum *e = (struct soc_value_enum *)
-			kcontrol->private_value;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short reg_val, val, mux;
 
 	reg_val = snd_soc_read(codec, e->reg);
@@ -1671,8 +1639,7 @@ int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct soc_value_enum *e = (struct soc_value_enum *)
-			kcontrol->private_value;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short val;
 	unsigned short mask;
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ad0d801..493a4e8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -137,7 +137,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	}
 	break;
 	case snd_soc_dapm_value_mux: {
-		struct soc_value_enum *e = (struct soc_value_enum *)
+		struct soc_enum *e = (struct soc_enum *)
 			w->kcontrols[i].private_value;
 		int val, item;
 
@@ -200,30 +200,6 @@ static int dapm_connect_mux(struct snd_soc_codec *codec,
 	return -ENODEV;
 }
 
-/* connect value_mux widget to it's interconnecting audio paths */
-static int dapm_connect_value_mux(struct snd_soc_codec *codec,
-	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
-	struct snd_soc_dapm_path *path, const char *control_name,
-	const struct snd_kcontrol_new *kcontrol)
-{
-	struct soc_value_enum *e = (struct soc_value_enum *)
-			kcontrol->private_value;
-	int i;
-
-	for (i = 0; i < e->max; i++) {
-		if (!(strcmp(control_name, e->texts[i]))) {
-			list_add(&path->list, &codec->dapm_paths);
-			list_add(&path->list_sink, &dest->sources);
-			list_add(&path->list_source, &src->sinks);
-			path->name = (char *)e->texts[i];
-			dapm_set_path_status(dest, path, 0);
-			return 0;
-		}
-	}
-
-	return -ENODEV;
-}
-
 /* connect mixer widget to it's interconnecting audio paths */
 static int dapm_connect_mixer(struct snd_soc_codec *codec,
 	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
@@ -774,45 +750,6 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	return 0;
 }
 
-/* test and update the power status of a value_mux widget */
-static int dapm_value_mux_update_power(struct snd_soc_dapm_widget *widget,
-				 struct snd_kcontrol *kcontrol, int mask,
-				 int mux, int val, struct soc_value_enum *e)
-{
-	struct snd_soc_dapm_path *path;
-	int found = 0;
-
-	if (widget->id != snd_soc_dapm_value_mux)
-		return -ENODEV;
-
-	if (!snd_soc_test_bits(widget->codec, e->reg, mask, val))
-		return 0;
-
-	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->codec->dapm_paths, list) {
-		if (path->kcontrol != kcontrol)
-			continue;
-
-		if (!path->name || !e->texts[mux])
-			continue;
-
-		found = 1;
-		/* we now need to match the string in the enum to the path */
-		if (!(strcmp(path->name, e->texts[mux])))
-			path->connect = 1; /* new connection */
-		else
-			path->connect = 0; /* old connection must be
-					      powered down */
-	}
-
-	if (found) {
-		dapm_power_widgets(widget->codec, SND_SOC_DAPM_STREAM_NOP);
-		dump_dapm(widget->codec, "mux power update");
-	}
-
-	return 0;
-}
-
 /* test and update the power status of a mixer or switch widget */
 static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int reg,
@@ -1045,17 +982,12 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 		path->connect = 1;
 		return 0;
 	case snd_soc_dapm_mux:
+	case snd_soc_dapm_value_mux:
 		ret = dapm_connect_mux(codec, wsource, wsink, path, control,
 			&wsink->kcontrols[0]);
 		if (ret != 0)
 			goto err;
 		break;
-	case snd_soc_dapm_value_mux:
-		ret = dapm_connect_value_mux(codec, wsource, wsink, path,
-			control, &wsink->kcontrols[0]);
-		if (ret != 0)
-			goto err;
-		break;
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer:
 		ret = dapm_connect_mixer(codec, wsource, wsink, path, control);
@@ -1382,8 +1314,7 @@ int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
-	struct soc_value_enum *e = (struct soc_value_enum *)
-			kcontrol->private_value;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short reg_val, val, mux;
 
 	reg_val = snd_soc_read(widget->codec, e->reg);
@@ -1423,8 +1354,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
-	struct soc_value_enum *e = (struct soc_value_enum *)
-			kcontrol->private_value;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short val, mux;
 	unsigned short mask;
 	int ret = 0;
@@ -1443,7 +1373,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
-	dapm_value_mux_update_power(widget, kcontrol, mask, mux, val, e);
+	dapm_mux_update_power(widget, kcontrol, mask, mux, val, e);
 	if (widget->event) {
 		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
 			ret = widget->event(widget,
-- 
1.5.6.5
