From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] ASoC: dapm: Implement mixer input
	auto-disable
Date: Mon,  5 Aug 2013 11:27:31 +0200
Message-ID: <1375694851-13303-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id C7BC32610B2
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 11:26:34 +0200 (CEST)
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

Some devices have the problem that if a internal audio signal source is disabled
the output of the source becomes undefined or goes to a undesired state (E.g.
DAC output goes to ground instead of VMID). In this case it is necessary, in
order to avoid unwanted clicks and pops, to disable any mixer input the signal
feeds into or to active a mute control along the path to the output. Often it is
still desirable to expose the same mixer input control to userspace, so cerain
paths can sill be disabled manually. This means we can not use conventional DAPM
to manage the mixer input control. This patch implements a method for letting
DAPM overwrite the state of a userspace visible control. I.e. DAPM will disable
the control if the path on which the control sits becomes inactive. Userspace
will then only see a cached copy of the controls state. Once DAPM powers the
path up again it will sync the userspace setting with the hardware and give
control back to userspace.

To implement this a new widget type is introduced. One widget of this type will
be created for each DAPM kcontrol which has the auto-disable feature enabled.
For each path that is controlled by the kcontrol the widget will be connected to
the source of that path. The new widget type behaves like a supply widget,
which means it will power up if one of its sinks are powered up and will only
power down if all of its sinks are powered down. In order to only have the mixer
input enabled when the source signal is valid the new widget type will be
disabled before all other widget types and only be enabled after all other
widget types.

E.g. consider the following simplified example. A DAC is connected to a mixer
and the mixer has a control to enable or disable the signal from the DAC.

                     +-------+
  +-----+            |       |
  | DAC |-----[Ctrl]-| Mixer |
  +-----+       :    |       |
     |          :    +-------+
     |          :
    +-------------+
    | Ctrl widget |
    +-------------+

If the control has the auto-disable feature enabled we'll create a widget for
the control. This widget is connected to the DAC as it is the source for the
mixer input. If the DAC powers up the control widget powers up and if the DAC
powers down the control widget is powered down. As long as the control widget
is powered down the hardware input control is kept disabled and if it is enabled
userspace can freely change the control's state.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Rebased onto the latest asoc/topic/dapm
---
 include/sound/soc-dapm.h |  17 +++++++-
 include/sound/soc.h      |  28 ++++++------
 sound/soc/soc-dapm.c     | 108 +++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 125 insertions(+), 28 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3575721..c728d28 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -280,14 +280,26 @@ struct device;
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+#define SOC_DAPM_SINGLE_AUTODISABLE(xname, reg, shift, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
 #define SOC_DAPM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+#define SOC_DAPM_SINGLE_TLV_AUTODISABLE(xname, reg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
 #define SOC_DAPM_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
@@ -484,6 +496,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_dai_in,		/* link to DAI structure */
 	snd_soc_dapm_dai_out,
 	snd_soc_dapm_dai_link,		/* link between two DAI structures */
+	snd_soc_dapm_kcontrol,		/* Auto-disabled kcontrol */
 };
 
 enum snd_soc_dapm_subclass {
diff --git a/include/sound/soc.h b/include/sound/soc.h
index b1e1f96..6201c6e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -30,13 +30,13 @@
 /*
  * Convenience kcontrol builders
  */
-#define SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, xmax, xinvert) \
+#define SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, xmax, xinvert, xautodisable) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
 	.rshift = shift_right, .max = xmax, .platform_max = xmax, \
-	.invert = xinvert})
-#define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) \
-	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert)
+	.invert = xinvert, .autodisable = xautodisable})
+#define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, xautodisable) \
+	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert, xautodisable)
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .max = xmax, .platform_max = xmax, .invert = xinvert})
@@ -52,7 +52,7 @@
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
 #define SOC_SINGLE_RANGE(xname, xreg, xshift, xmin, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw_range, .get = snd_soc_get_volsw_range, \
@@ -68,7 +68,7 @@
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
 #define SOC_SINGLE_SX_TLV(xname, xreg, xshift, xmin, xmax, tlv_array) \
 {       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
@@ -97,7 +97,7 @@
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right, \
-					  max, invert) }
+					  max, invert, 0) }
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw, \
@@ -119,7 +119,7 @@
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right, \
-					  max, invert) }
+					  max, invert, 0) }
 #define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -190,14 +190,14 @@
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, 0) }
 #define SOC_DOUBLE_EXT(xname, reg, shift_left, shift_right, max, invert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = \
-		SOC_DOUBLE_VALUE(reg, shift_left, shift_right, max, invert) }
+		SOC_DOUBLE_VALUE(reg, shift_left, shift_right, max, invert, 0) }
 #define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -206,7 +206,7 @@
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, 0) }
 #define SOC_DOUBLE_EXT_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -216,7 +216,7 @@
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, \
-					  xmax, xinvert) }
+					  xmax, xinvert, 0) }
 #define SOC_DOUBLE_R_EXT_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -1088,7 +1088,9 @@ struct snd_soc_pcm_runtime {
 /* mixer control */
 struct soc_mixer_control {
 	int min, max, platform_max;
-	unsigned int reg, rreg, shift, rshift, invert;
+	unsigned int reg, rreg, shift, rshift;
+	unsigned int invert:1;
+	unsigned int autodisable:1;
 };
 
 struct soc_bytes {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5f64c16..0944bc4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -47,6 +47,15 @@
 
 #define DAPM_UPDATE_STAT(widget, val) widget->dapm->card->dapm_stats.val++;
 
+static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
+	struct snd_soc_dapm_widget *wsource, struct snd_soc_dapm_widget *wsink,
+	const char *control,
+	int (*connected)(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink));
+static struct snd_soc_dapm_widget *
+snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
+			 const struct snd_soc_dapm_widget *widget);
+
 /* dapm power sequences - make this per codec in the future */
 static int dapm_up_seq[] = {
 	[snd_soc_dapm_pre] = 0,
@@ -73,16 +82,18 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_hp] = 10,
 	[snd_soc_dapm_spk] = 10,
 	[snd_soc_dapm_line] = 10,
-	[snd_soc_dapm_post] = 11,
+	[snd_soc_dapm_kcontrol] = 11,
+	[snd_soc_dapm_post] = 12,
 };
 
 static int dapm_down_seq[] = {
 	[snd_soc_dapm_pre] = 0,
-	[snd_soc_dapm_adc] = 1,
-	[snd_soc_dapm_hp] = 2,
-	[snd_soc_dapm_spk] = 2,
-	[snd_soc_dapm_line] = 2,
-	[snd_soc_dapm_out_drv] = 2,
+	[snd_soc_dapm_kcontrol] = 1,
+	[snd_soc_dapm_adc] = 2,
+	[snd_soc_dapm_hp] = 3,
+	[snd_soc_dapm_spk] = 3,
+	[snd_soc_dapm_line] = 3,
+	[snd_soc_dapm_out_drv] = 3,
 	[snd_soc_dapm_pga] = 4,
 	[snd_soc_dapm_switch] = 5,
 	[snd_soc_dapm_mixer_named_ctl] = 5,
@@ -176,6 +187,7 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 
 struct dapm_kcontrol_data {
 	unsigned int value;
+	struct snd_soc_dapm_widget *widget;
 	struct list_head paths;
 	struct snd_soc_dapm_widget_list *wlist;
 };
@@ -184,6 +196,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 	struct snd_kcontrol *kcontrol)
 {
 	struct dapm_kcontrol_data *data;
+	struct soc_mixer_control *mc;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
@@ -195,6 +208,39 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 
 	INIT_LIST_HEAD(&data->paths);
 
+	switch (widget->id) {
+	case snd_soc_dapm_switch:
+	case snd_soc_dapm_mixer:
+	case snd_soc_dapm_mixer_named_ctl:
+		mc = (struct soc_mixer_control *)kcontrol->private_value;
+
+		if (mc->autodisable) {
+			struct snd_soc_dapm_widget template;
+
+			memset(&template, 0, sizeof(template));
+			template.reg = mc->reg;
+			template.mask = (1 << fls(mc->max)) - 1;
+			template.shift = mc->shift;
+			if (mc->invert)
+				template.off_val = mc->max;
+			else
+				template.off_val = 0;
+			template.on_val = template.off_val;
+			template.id = snd_soc_dapm_kcontrol;
+			template.name = kcontrol->id.name;
+
+			data->widget = snd_soc_dapm_new_control(widget->dapm,
+				&template);
+			if (!data->widget) {
+				kfree(data);
+				return -ENOMEM;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
 	kcontrol->private_data = data;
 
 	return 0;
@@ -203,6 +249,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
+	kfree(data->widget);
 	kfree(data->wlist);
 	kfree(data);
 }
@@ -246,6 +293,21 @@ static void dapm_kcontrol_add_path(const struct snd_kcontrol *kcontrol,
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
 
 	list_add_tail(&path->list_kcontrol, &data->paths);
+
+	if (data->widget) {
+		snd_soc_dapm_add_path(data->widget->dapm, data->widget,
+		    path->source, NULL, NULL);
+	}
+}
+
+static bool dapm_kcontrol_is_powered(const struct snd_kcontrol *kcontrol)
+{
+	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
+
+	if (!data->widget)
+		return true;
+
+	return data->widget->power;
 }
 
 static struct list_head *dapm_kcontrol_get_path_list(
@@ -275,6 +337,9 @@ static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 	if (data->value == value)
 		return false;
 
+	if (data->widget)
+		data->widget->on_val = value;
+
 	data->value = value;
 
 	return true;
@@ -515,6 +580,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_spk:
 	case snd_soc_dapm_line:
 	case snd_soc_dapm_dai_link:
+	case snd_soc_dapm_kcontrol:
 		p->connect = 1;
 	break;
 	/* does affect routing - dynamically connected */
@@ -880,6 +946,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_clock_supply:
+	case snd_soc_dapm_kcontrol:
 		return 0;
 	default:
 		break;
@@ -975,6 +1042,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_clock_supply:
+	case snd_soc_dapm_kcontrol:
 		return 0;
 	default:
 		break;
@@ -1523,7 +1591,7 @@ static void dapm_widget_update(struct snd_soc_card *card)
 	unsigned int wi;
 	int ret;
 
-	if (!update)
+	if (!update || !dapm_kcontrol_is_powered(update->kcontrol))
 		return;
 
 	wlist = dapm_kcontrol_get_wlist(update->kcontrol);
@@ -1668,6 +1736,7 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_clock_supply:
+	case snd_soc_dapm_kcontrol:
 		/* Supplies can't affect their outputs, only their inputs */
 		break;
 	default:
@@ -2335,6 +2404,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_dai_in:
 	case snd_soc_dapm_dai_out:
 	case snd_soc_dapm_dai_link:
+	case snd_soc_dapm_kcontrol:
 		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
@@ -2717,6 +2787,7 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_card *card = codec->card;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
@@ -2724,17 +2795,24 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
+	unsigned int val;
 
 	if (snd_soc_volsw_is_stereo(mc))
 		dev_warn(codec->dapm.dev,
 			 "ASoC: Control '%s' is stereo, which is not supported\n",
 			 kcontrol->id.name);
 
-	ucontrol->value.integer.value[0] =
-		(snd_soc_read(codec, reg) >> shift) & mask;
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	if (dapm_kcontrol_is_powered(kcontrol))
+		val = (snd_soc_read(codec, reg) >> shift) & mask;
+	else
+		val = dapm_kcontrol_get_value(kcontrol);
+	mutex_unlock(&card->dapm_mutex);
+
 	if (invert)
-		ucontrol->value.integer.value[0] =
-			max - ucontrol->value.integer.value[0];
+		ucontrol->value.integer.value[0] = max - val;
+	else
+		ucontrol->value.integer.value[0] = val;
 
 	return 0;
 }
@@ -2775,11 +2853,14 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 
 	if (invert)
 		val = max - val;
-	mask = mask << shift;
-	val = val << shift;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
+	dapm_kcontrol_set_value(kcontrol, val);
+
+	mask = mask << shift;
+	val = val << shift;
+
 	change = snd_soc_test_bits(codec, reg, mask, val);
 	if (change) {
 		update.kcontrol = kcontrol;
@@ -3179,6 +3260,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_clock_supply:
+	case snd_soc_dapm_kcontrol:
 		w->power_check = dapm_supply_check_power;
 		break;
 	default:
-- 
1.8.0
