From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: New enum type: value_enum
Date: Mon,  5 Jan 2009 09:54:57 +0200
Message-ID: <1231142098-16886-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1231142098-16886-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 19D4124158
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 08:55:07 +0100 (CET)
In-Reply-To: <1231142098-16886-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, broonie@sirena.org.uk, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch introduces a new enum type.
In this enum type each enumerated items referred with a value.

This new enum type can handle enums encoded in bitfield, or any other
weird ways. twl4030 codec has several mux selection register, where the
input/output mux is coded in a bitfield. With the normal enum type this type
of mux can not be handled in a clean way.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc-dapm.h |   15 ++++
 include/sound/soc.h      |   30 +++++++
 sound/soc/soc-core.c     |  107 +++++++++++++++++++++++++
 sound/soc/soc-dapm.c     |  197 +++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 346 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 7ee2f70..4af1083 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -85,6 +85,10 @@
 #define SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, .shift = wshift, \
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1}
+#define SND_SOC_DAPM_VALUE_MUX(wname, wreg, wshift, winvert, wcontrols) \
+{	.id = snd_soc_dapm_value_mux, .name = wname, .reg = wreg, \
+	.shift = wshift, .invert = winvert, .kcontrols = wcontrols, \
+	.num_kcontrols = 1}
 
 /* path domain with event - event handler must return 0 for success */
 #define SND_SOC_DAPM_PGA_E(wname, wreg, wshift, winvert, wcontrols, \
@@ -172,6 +176,12 @@
  	.get = snd_soc_dapm_get_enum_double, \
  	.put = snd_soc_dapm_put_enum_double, \
   	.private_value = (unsigned long)&xenum }
+#define SOC_DAPM_VALUE_ENUM(xname, xenum) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_value_enum_double, \
+	.get = snd_soc_dapm_get_value_enum_double, \
+	.put = snd_soc_dapm_put_value_enum_double, \
+	.private_value = (unsigned long)&xenum }
 
 /* dapm stream operations */
 #define SND_SOC_DAPM_STREAM_NOP			0x0
@@ -214,6 +224,10 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 	const struct snd_soc_dapm_widget *widget);
 int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
@@ -247,6 +261,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
 	snd_soc_dapm_output,		/* output pin */
 	snd_soc_dapm_mux,			/* selects 1 analog signal from many inputs */
+	snd_soc_dapm_value_mux,			/* selects 1 analog signal from many inputs */
 	snd_soc_dapm_mixer,			/* mixes several analog signals together */
 	snd_soc_dapm_pga,			/* programmable gain/attenuation (volume) */
 	snd_soc_dapm_adc,			/* analog to digital converter */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index f86e455..9b930d3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -94,11 +94,22 @@
 	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xmax, xtexts)
 #define SOC_ENUM_SINGLE_EXT(xmax, xtexts) \
 {	.max = xmax, .texts = xtexts }
+#define SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xmax, xtexts, xvalues) \
+{	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
+	.mask = xmask, .max = xmax, .texts = xtexts, .values = xvalues}
+#define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xmax, xtexts, xvalues) \
+	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xmax, xtexts, xvalues)
 #define SOC_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
 	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_get_enum_double, .put = snd_soc_put_enum_double, \
 	.private_value = (unsigned long)&xenum }
+#define SOC_VALUE_ENUM(xname, xenum) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
+	.info = snd_soc_info_value_enum_double, \
+	.get = snd_soc_get_value_enum_double, \
+	.put = snd_soc_put_value_enum_double, \
+	.private_value = (unsigned long)&xenum }
 #define SOC_SINGLE_EXT(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -200,6 +211,12 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_info_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_get_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_info_volsw_ext(struct snd_kcontrol *kcontrol,
@@ -406,6 +423,19 @@ struct soc_enum {
 	void *dapm;
 };
 
+/* semi enumerated kcontrol */
+struct soc_value_enum {
+	unsigned short reg;
+	unsigned short reg2;
+	unsigned char shift_l;
+	unsigned char shift_r;
+	unsigned int max;
+	unsigned int mask;
+	const char **texts;
+	const unsigned int *values;
+	void *dapm;
+};
+
 #include <sound/soc-dai.h>
 
 #endif
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f73c134..6cbe7e8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1585,6 +1585,113 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
 
 /**
+ * snd_soc_info_value_enum_double - semi enumerated double mixer info callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to provide information about a double semi enumerated
+ * mixer control.
+ *
+ * Semi enumerated mixer: the enumerated items are referred as values. Can be
+ * used for handling bitfield coded enumeration for example.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_info_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_value_enum *e = (struct soc_value_enum *)
+			kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = e->shift_l == e->shift_r ? 1 : 2;
+	uinfo->value.enumerated.items = e->max;
+
+	if (uinfo->value.enumerated.item > e->max - 1)
+		uinfo->value.enumerated.item = e->max - 1;
+	strcpy(uinfo->value.enumerated.name,
+		e->texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_info_value_enum_double);
+
+/**
+ * snd_soc_get_value_enum_double - semi enumerated double mixer get callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to get the value of a double semi enumerated mixer.
+ *
+ * Semi enumerated mixer: the enumerated items are referred as values. Can be
+ * used for handling bitfield coded enumeration for example.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_value_enum *e = (struct soc_value_enum *)
+			kcontrol->private_value;
+	unsigned short reg_val, val, mux;
+
+	reg_val = snd_soc_read(codec, e->reg);
+	val = (reg_val >> e->shift_l) & e->mask;
+	for (mux = 0; mux < e->max; mux++) {
+		if (val == e->values[mux])
+			break;
+	}
+	ucontrol->value.enumerated.item[0] = mux;
+	if (e->shift_l != e->shift_r) {
+		val = (reg_val >> e->shift_r) & e->mask;
+		for (mux = 0; mux < e->max; mux++) {
+			if (val == e->values[mux])
+				break;
+		}
+		ucontrol->value.enumerated.item[1] = mux;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_value_enum_double);
+
+/**
+ * snd_soc_put_value_enum_double - semi enumerated double mixer put callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to set the value of a double semi enumerated mixer.
+ *
+ * Semi enumerated mixer: the enumerated items are referred as values. Can be
+ * used for handling bitfield coded enumeration for example.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_value_enum *e = (struct soc_value_enum *)
+			kcontrol->private_value;
+	unsigned short val;
+	unsigned short mask;
+
+	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+		return -EINVAL;
+	val = e->values[ucontrol->value.enumerated.item[0]] << e->shift_l;
+	mask = e->mask << e->shift_l;
+	if (e->shift_l != e->shift_r) {
+		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+			return -EINVAL;
+		val |= e->values[ucontrol->value.enumerated.item[1]] << e->shift_r;
+		mask |= e->mask << e->shift_r;
+	}
+
+	return snd_soc_update_bits(codec, e->reg, mask, val);
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_value_enum_double);
+
+/**
  * snd_soc_info_enum_ext - external enumerated single mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6c79ca6..ad0d801 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -53,13 +53,15 @@
 /* dapm power sequences - make this per codec in the future */
 static int dapm_up_seq[] = {
 	snd_soc_dapm_pre, snd_soc_dapm_micbias, snd_soc_dapm_mic,
-	snd_soc_dapm_mux, snd_soc_dapm_dac, snd_soc_dapm_mixer, snd_soc_dapm_pga,
-	snd_soc_dapm_adc, snd_soc_dapm_hp, snd_soc_dapm_spk, snd_soc_dapm_post
+	snd_soc_dapm_mux, snd_soc_dapm_value_mux, snd_soc_dapm_dac,
+	snd_soc_dapm_mixer, snd_soc_dapm_pga, snd_soc_dapm_adc, snd_soc_dapm_hp,
+	snd_soc_dapm_spk, snd_soc_dapm_post
 };
 static int dapm_down_seq[] = {
 	snd_soc_dapm_pre, snd_soc_dapm_adc, snd_soc_dapm_hp, snd_soc_dapm_spk,
 	snd_soc_dapm_pga, snd_soc_dapm_mixer, snd_soc_dapm_dac, snd_soc_dapm_mic,
-	snd_soc_dapm_micbias, snd_soc_dapm_mux, snd_soc_dapm_post
+	snd_soc_dapm_micbias, snd_soc_dapm_mux, snd_soc_dapm_value_mux,
+	snd_soc_dapm_post
 };
 
 static int dapm_status = 1;
@@ -134,6 +136,25 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		}
 	}
 	break;
+	case snd_soc_dapm_value_mux: {
+		struct soc_value_enum *e = (struct soc_value_enum *)
+			w->kcontrols[i].private_value;
+		int val, item;
+
+		val = snd_soc_read(w->codec, e->reg);
+		val = (val >> e->shift_l) & e->mask;
+		for (item = 0; item < e->max; item++) {
+			if (val == e->values[item])
+				break;
+		}
+
+		p->connect = 0;
+		for (i = 0; i < e->max; i++) {
+			if (!(strcmp(p->name, e->texts[i])) && item == i)
+				p->connect = 1;
+		}
+	}
+	break;
 	/* does not effect routing - always connected */
 	case snd_soc_dapm_pga:
 	case snd_soc_dapm_output:
@@ -179,6 +200,30 @@ static int dapm_connect_mux(struct snd_soc_codec *codec,
 	return -ENODEV;
 }
 
+/* connect value_mux widget to it's interconnecting audio paths */
+static int dapm_connect_value_mux(struct snd_soc_codec *codec,
+	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
+	struct snd_soc_dapm_path *path, const char *control_name,
+	const struct snd_kcontrol_new *kcontrol)
+{
+	struct soc_value_enum *e = (struct soc_value_enum *)
+			kcontrol->private_value;
+	int i;
+
+	for (i = 0; i < e->max; i++) {
+		if (!(strcmp(control_name, e->texts[i]))) {
+			list_add(&path->list, &codec->dapm_paths);
+			list_add(&path->list_sink, &dest->sources);
+			list_add(&path->list_source, &src->sinks);
+			path->name = (char *)e->texts[i];
+			dapm_set_path_status(dest, path, 0);
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 /* connect mixer widget to it's interconnecting audio paths */
 static int dapm_connect_mixer(struct snd_soc_codec *codec,
 	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
@@ -653,6 +698,7 @@ static void dbg_dump_dapm(struct snd_soc_codec* codec, const char *action)
 		case snd_soc_dapm_vmid:
 			continue;
 		case snd_soc_dapm_mux:
+		case snd_soc_dapm_value_mux:
 		case snd_soc_dapm_output:
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_switch:
@@ -728,6 +774,45 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	return 0;
 }
 
+/* test and update the power status of a value_mux widget */
+static int dapm_value_mux_update_power(struct snd_soc_dapm_widget *widget,
+				 struct snd_kcontrol *kcontrol, int mask,
+				 int mux, int val, struct soc_value_enum *e)
+{
+	struct snd_soc_dapm_path *path;
+	int found = 0;
+
+	if (widget->id != snd_soc_dapm_value_mux)
+		return -ENODEV;
+
+	if (!snd_soc_test_bits(widget->codec, e->reg, mask, val))
+		return 0;
+
+	/* find dapm widget path assoc with kcontrol */
+	list_for_each_entry(path, &widget->codec->dapm_paths, list) {
+		if (path->kcontrol != kcontrol)
+			continue;
+
+		if (!path->name || !e->texts[mux])
+			continue;
+
+		found = 1;
+		/* we now need to match the string in the enum to the path */
+		if (!(strcmp(path->name, e->texts[mux])))
+			path->connect = 1; /* new connection */
+		else
+			path->connect = 0; /* old connection must be
+					      powered down */
+	}
+
+	if (found) {
+		dapm_power_widgets(widget->codec, SND_SOC_DAPM_STREAM_NOP);
+		dump_dapm(widget->codec, "mux power update");
+	}
+
+	return 0;
+}
+
 /* test and update the power status of a mixer or switch widget */
 static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int reg,
@@ -965,6 +1050,12 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 		if (ret != 0)
 			goto err;
 		break;
+	case snd_soc_dapm_value_mux:
+		ret = dapm_connect_value_mux(codec, wsource, wsink, path,
+			control, &wsink->kcontrols[0]);
+		if (ret != 0)
+			goto err;
+		break;
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer:
 		ret = dapm_connect_mixer(codec, wsource, wsink, path, control);
@@ -1047,6 +1138,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 			dapm_new_mixer(codec, w);
 			break;
 		case snd_soc_dapm_mux:
+		case snd_soc_dapm_value_mux:
 			dapm_new_mux(codec, w);
 			break;
 		case snd_soc_dapm_adc:
@@ -1274,6 +1366,105 @@ out:
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
 
 /**
+ * snd_soc_dapm_get_value_enum_double - dapm semi enumerated double mixer get
+ *					callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to get the value of a dapm semi enumerated double mixer control.
+ *
+ * Semi enumerated mixer: the enumerated items are referred as values. Can be
+ * used for handling bitfield coded enumeration for example.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct soc_value_enum *e = (struct soc_value_enum *)
+			kcontrol->private_value;
+	unsigned short reg_val, val, mux;
+
+	reg_val = snd_soc_read(widget->codec, e->reg);
+	val = (reg_val >> e->shift_l) & e->mask;
+	for (mux = 0; mux < e->max; mux++) {
+		if (val == e->values[mux])
+			break;
+	}
+	ucontrol->value.enumerated.item[0] = mux;
+	if (e->shift_l != e->shift_r) {
+		val = (reg_val >> e->shift_r) & e->mask;
+		for (mux = 0; mux < e->max; mux++) {
+			if (val == e->values[mux])
+				break;
+		}
+		ucontrol->value.enumerated.item[1] = mux;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_get_value_enum_double);
+
+/**
+ * snd_soc_dapm_put_value_enum_double - dapm semi enumerated double mixer set
+ *					callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to set the value of a dapm semi enumerated double mixer control.
+ *
+ * Semi enumerated mixer: the enumerated items are referred as values. Can be
+ * used for handling bitfield coded enumeration for example.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct soc_value_enum *e = (struct soc_value_enum *)
+			kcontrol->private_value;
+	unsigned short val, mux;
+	unsigned short mask;
+	int ret = 0;
+
+	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+		return -EINVAL;
+	mux = ucontrol->value.enumerated.item[0];
+	val = e->values[ucontrol->value.enumerated.item[0]] << e->shift_l;
+	mask = e->mask << e->shift_l;
+	if (e->shift_l != e->shift_r) {
+		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+			return -EINVAL;
+		val |= e->values[ucontrol->value.enumerated.item[1]] << e->shift_r;
+		mask |= e->mask << e->shift_r;
+	}
+
+	mutex_lock(&widget->codec->mutex);
+	widget->value = val;
+	dapm_value_mux_update_power(widget, kcontrol, mask, mux, val, e);
+	if (widget->event) {
+		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
+			ret = widget->event(widget,
+				kcontrol, SND_SOC_DAPM_PRE_REG);
+			if (ret < 0)
+				goto out;
+		}
+		ret = snd_soc_update_bits(widget->codec, e->reg, mask, val);
+		if (widget->event_flags & SND_SOC_DAPM_POST_REG)
+			ret = widget->event(widget,
+				kcontrol, SND_SOC_DAPM_POST_REG);
+	} else
+		ret = snd_soc_update_bits(widget->codec, e->reg, mask, val);
+
+out:
+	mutex_unlock(&widget->codec->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
+
+/**
  * snd_soc_dapm_new_control - create new dapm control
  * @codec: audio codec
  * @widget: widget template
-- 
1.6.0.6
