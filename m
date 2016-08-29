From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 04/12] ASoC: hdac: Create DAPM model for HDA
	widgets
Date: Mon, 29 Aug 2016 11:53:18 +0530
Message-ID: <1472451806-10605-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7722B266E14
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:23:42 +0200 (CEST)
In-Reply-To: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

HDA device widgets are mapped to dapm widgets to take advantage
of DAPM. Each HDA widget can be mapped to one or multiple dapm
widgets based on interface and how it is connected with other
widgets.

For example, a PIN widget 2 or 3 dapm widgets are created
depending on the capability. A dapm input/out widget is created
to represent the input/output capability, a pga widget is created
so that pin with retasking capability can be properly represented
in a dapm graph and a mux widget for output pin is created, if
the connection list has more than one input.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_generic.c | 478 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 477 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_generic.c b/sound/soc/codecs/hdac_generic.c
index 99e624e..7f3a2a0 100644
--- a/sound/soc/codecs/hdac_generic.c
+++ b/sound/soc/codecs/hdac_generic.c
@@ -43,6 +43,16 @@ struct hdac_generic_priv {
 	unsigned int num_dapm_widgets;
 };
 
+/*
+ * Widgets types can be accessed using an array with an index except vendor
+ * types. So fill NULL for the invalid indexes.
+ */
+static char *wid_names[] = {
+		"dac", "adc", "mixer", "mux", "pin", "power",
+		"volme knob", "beep", NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, "vendor",
+};
+
 static void hdac_generic_set_power_state(struct hdac_ext_device *edev,
 			hda_nid_t nid, unsigned int pwr_state)
 {
@@ -52,6 +62,467 @@ static void hdac_generic_set_power_state(struct hdac_ext_device *edev,
 				AC_VERB_SET_POWER_STATE, pwr_state);
 }
 
+static int hdac_generic_fill_widget_info(struct device *dev,
+		struct snd_soc_dapm_widget *w, enum snd_soc_dapm_type id,
+		void *priv, const char *wname, const char *stream,
+		struct snd_kcontrol_new *wc, int numkc,
+		int (*event)(struct snd_soc_dapm_widget *,
+		struct snd_kcontrol *, int), unsigned short event_flags)
+{
+	w->id = id;
+	w->name = devm_kstrdup(dev, wname, GFP_KERNEL);
+	if (!w->name)
+		return -ENOMEM;
+
+	w->sname = stream;
+	w->reg = SND_SOC_NOPM;
+	w->shift = 0;
+	w->kcontrol_news = wc;
+	w->num_kcontrols = numkc;
+	w->priv = priv;
+	w->event = event;
+	w->event_flags = event_flags;
+
+	return 0;
+}
+
+static int hdac_generic_alloc_mux_widget(struct snd_soc_dapm_context *dapm,
+			struct snd_soc_dapm_widget *widgets, int index,
+			struct hdac_codec_widget *wid)
+
+{
+	struct snd_kcontrol_new *kc;
+	struct soc_enum *se;
+	char kc_name[HDAC_GENERIC_NAME_SIZE];
+	char mux_items[HDAC_GENERIC_NAME_SIZE];
+	char widget_name[HDAC_GENERIC_NAME_SIZE];
+	const char *name;
+	/* To hold inputs to the Pin mux */
+	char *items[HDA_MAX_CONNECTIONS];
+	int i = 0, ret;
+	int num_items = wid->num_inputs + 1;
+
+	if (wid->type == AC_WID_AUD_SEL)
+		sprintf(widget_name, "Mux %x", wid->nid);
+	else if (wid->type == AC_WID_PIN)
+		sprintf(widget_name, "Pin %x Mux", wid->nid);
+	else
+		return -EINVAL;
+
+	kc = devm_kzalloc(dapm->dev, sizeof(*kc), GFP_KERNEL);
+	if (!kc)
+		return -ENOMEM;
+
+	se = devm_kzalloc(dapm->dev, sizeof(*se), GFP_KERNEL);
+	if (!se)
+		return -ENOMEM;
+
+	sprintf(kc_name, "Mux %d Input", wid->nid);
+	kc->name = devm_kstrdup(dapm->dev, kc_name, GFP_KERNEL);
+	if (!kc->name)
+		return -ENOMEM;
+
+	kc->private_value = (long)se;
+	kc->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	kc->access = 0;
+	kc->info = snd_soc_info_enum_double;
+	kc->put = snd_soc_dapm_put_enum_double;
+	kc->get = snd_soc_dapm_get_enum_double;
+
+	se->reg = SND_SOC_NOPM;
+
+	se->items = num_items;
+	se->mask = roundup_pow_of_two(se->items) - 1;
+
+	sprintf(mux_items, "NONE");
+	items[i] = devm_kstrdup(dapm->dev, mux_items, GFP_KERNEL);
+	if (!items[i])
+		return -ENOMEM;
+
+	for (i = 0; i < wid->num_inputs; i++)	{
+		name = wid_names[wid->conn_list[i].type];
+		if (!name)
+			return -EINVAL;
+
+		sprintf(mux_items, "%s %x", name, wid->conn_list[i].nid);
+		items[i + 1] = devm_kstrdup(dapm->dev, mux_items, GFP_KERNEL);
+		if (!items[i])
+			return -ENOMEM;
+	}
+
+	se->texts = devm_kmemdup(dapm->dev, items,
+			(num_items  * sizeof(char *)), GFP_KERNEL);
+	if (!se->texts)
+		return -ENOMEM;
+
+	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
+			snd_soc_dapm_mux, wid, widget_name, NULL, kc, 1,
+			NULL, 0);
+
+	if (ret < 0)
+		return ret;
+
+	wid->priv = &widgets[index];
+
+	return 0;
+}
+
+static const char *get_dai_stream(struct snd_soc_dai_driver *dai_drv,
+			int num_dais, struct hdac_codec_widget *wid)
+{
+	int i;
+	struct hdac_codec_widget *tmp;
+
+	for (i = 0; i < num_dais; i++) {
+		tmp = dai_drv[i].dobj.private;
+		if (tmp->nid == wid->nid) {
+			if (wid->type == AC_WID_AUD_IN)
+				return dai_drv[i].capture.stream_name;
+			else
+				return dai_drv[i].playback.stream_name;
+		}
+	}
+
+	return NULL;
+}
+
+static int hdac_codec_alloc_cvt_widget(struct snd_soc_dapm_context *dapm,
+			struct snd_soc_dapm_widget *widgets, int index,
+			struct hdac_codec_widget *wid)
+{
+	struct snd_soc_dai_driver *dai_drv = dapm->component->dai_drv;
+	char widget_name[HDAC_GENERIC_NAME_SIZE];
+	const char *dai_strm_name;
+	int ret = 0;
+
+	dai_strm_name = get_dai_stream(dai_drv,
+				dapm->component->num_dai, wid);
+	if (!dai_strm_name)
+		return -EINVAL;
+
+	if (wid->type == AC_WID_AUD_IN) {
+		sprintf(widget_name, "ADC %x", wid->nid);
+	} else {
+		sprintf(widget_name, "%s DAC %x",
+			(wid->caps & AC_WCAP_DIGITAL) ? "Digital" : "Analog",
+			wid->nid);
+	}
+
+	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
+			wid->type == AC_WID_AUD_IN ?
+			snd_soc_dapm_aif_in : snd_soc_dapm_aif_out,
+			wid, widget_name, dai_strm_name, NULL, 0, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	wid->priv = &widgets[index];
+
+	return 0;
+}
+
+static int hdac_codec_alloc_mixer_widget(struct snd_soc_dapm_context *dapm,
+				struct snd_soc_dapm_widget *w, int index,
+				struct hdac_codec_widget *wid)
+{
+	struct snd_kcontrol_new *kc;
+	struct soc_mixer_control *mc;
+	char kc_name[HDAC_GENERIC_NAME_SIZE];
+	char widget_name[HDAC_GENERIC_NAME_SIZE];
+	const char *name;
+	int i, ret;
+
+	kc = devm_kcalloc(dapm->dev, wid->num_inputs, sizeof(*kc), GFP_KERNEL);
+	if (!kc)
+		return -ENOMEM;
+
+	for (i = 0; i < wid->num_inputs; i++) {
+		name = wid_names[wid->conn_list[i].type];
+		if (!name)
+			return -EINVAL;
+
+		sprintf(kc_name, "%s %x in Switch",
+				name, wid->conn_list[i].nid);
+		kc[i].name = devm_kstrdup(dapm->dev, kc_name, GFP_KERNEL);
+		if (!kc[i].name)
+			return -ENOMEM;
+
+		mc = devm_kzalloc(dapm->dev, (sizeof(*mc)), GFP_KERNEL);
+		if (!mc)
+			return -ENOMEM;
+
+		mc->reg = SND_SOC_NOPM;
+		mc->rreg = SND_SOC_NOPM;
+		mc->max = 1;
+
+		kc[i].private_value = (long)mc;
+		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		kc[i].info = snd_soc_info_volsw;
+		kc[i].put = snd_soc_dapm_put_volsw;
+		kc[i].get = snd_soc_dapm_get_volsw;
+	}
+
+	sprintf(widget_name, "Mixer %x", wid->nid);
+	ret = hdac_generic_fill_widget_info(dapm->dev, &w[index],
+			snd_soc_dapm_mixer, wid, widget_name, NULL,
+			kc, wid->num_inputs, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	wid->priv = &w[index];
+
+	return 0;
+}
+
+/*
+ * Each Pin widget will be represented with:
+ *	DAPM input/output - Based on out/in capability queried
+ *	DAPM PGA - To program the PIN configuration
+ *	DAPM Mux - Create a virtual Mux widget, if output capable pin can
+ *		   select from multiple inputs.
+ *
+ * Returns number of dapm widgets created on success else returns -ve error
+ * code.
+ */
+static int hdac_codec_alloc_pin_widget(struct snd_soc_dapm_context *dapm,
+			struct snd_soc_dapm_widget *widgets, int index,
+			struct hdac_codec_widget *wid)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
+	char widget_name[HDAC_GENERIC_NAME_SIZE];
+	int i = index;
+	int ret;
+	bool input;
+	/*
+	 * Pin complex are represented with multiple dapm widgets. Cache them
+	 * for easy reference. wid_ref[0]->input/output, wid_ref[1]->pga,
+	 * wid_ref[2]->mux.
+	 */
+	struct snd_soc_dapm_widget **wid_ref;
+
+	input = is_input_pin(&edev->hdac, wid->nid);
+
+	wid_ref = devm_kmalloc_array(dapm->dev, 3, sizeof(wid_ref), GFP_KERNEL);
+	if (!wid_ref)
+		return -ENOMEM;
+
+	/* Create output/input widget */
+	sprintf(widget_name, "Pin %x %s", wid->nid,
+				input ? "Input" : "Output");
+
+	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[i],
+			input ? snd_soc_dapm_input : snd_soc_dapm_output,
+			wid, widget_name, NULL, NULL, 0, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	wid_ref[0] = &widgets[i++];
+
+	/* Create PGA widget */
+	sprintf(widget_name, "Pin %x PGA", wid->nid);
+	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[i],
+			snd_soc_dapm_pga, wid, widget_name, NULL,
+			NULL, 0, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	wid_ref[1] = &widgets[i++];
+
+	/* Create Mux if Pin widget can select from multiple inputs */
+	if (!input && wid->num_inputs > 1) {
+		sprintf(widget_name, "Pin %x Mux", wid->nid);
+		ret = hdac_generic_alloc_mux_widget(dapm, widgets, i, wid);
+		if (ret < 0)
+			return ret;
+
+		wid_ref[2] = &widgets[i++];
+	}
+
+	/* override hda widget private with dapm widget group */
+	wid->priv = wid_ref;
+
+	/* Return number of dapm widgets created */
+	return i - index;
+}
+
+static int hdac_codec_alloc_power_widget(struct snd_soc_dapm_context *dapm,
+			struct snd_soc_dapm_widget *widgets, int index,
+			struct hdac_codec_widget *wid)
+{
+	char widget_name[HDAC_GENERIC_NAME_SIZE];
+	int ret = 0;
+
+	sprintf(widget_name, "Power %x", wid->nid);
+	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
+			snd_soc_dapm_supply, wid, widget_name,
+			NULL, NULL, 0, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	wid->priv = &widgets[index];
+
+	return 0;
+}
+
+/*
+ * Each Beep hda widget will be represented with two dapm widget a siggen
+ * and a PGA. A virtual switch control will be added to turn on/off DAPM.
+ */
+static int hdac_codec_alloc_beep_widget(struct snd_soc_dapm_context *dapm,
+			struct snd_soc_dapm_widget *widgets, int index,
+			struct hdac_codec_widget *wid)
+{
+	char widget_name[HDAC_GENERIC_NAME_SIZE];
+	int i = index, ret = 0;
+	struct soc_mixer_control *mc;
+	struct snd_kcontrol_new *kc;
+	char kc_name[HDAC_GENERIC_NAME_SIZE];
+	/*
+	 * Beep widgets are represented with multiple dapm widgets. Cache them
+	 * for each reference. wid_ref[0]->siggen, wid_ref[1]->pga.
+	 */
+	struct snd_soc_dapm_widget **wid_ref;
+
+	wid_ref = devm_kmalloc_array(dapm->dev, 2, sizeof(wid_ref), GFP_KERNEL);
+	if (!wid_ref)
+		return -ENOMEM;
+
+	sprintf(widget_name, "Beep Gen %x", wid->nid);
+	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[i++],
+			snd_soc_dapm_siggen, wid, widget_name,
+			NULL, NULL, 0, NULL, 0);
+		if (ret < 0)
+			return ret;
+
+	kc = devm_kzalloc(dapm->dev,
+			(sizeof(*kc) * wid->num_inputs),
+			GFP_KERNEL);
+	if (!kc)
+		return -ENOMEM;
+
+	sprintf(kc_name, "%s %x in Switch", wid_names[wid->type], wid->nid);
+	kc[i].name = devm_kstrdup(dapm->dev, kc_name, GFP_KERNEL);
+	if (!kc[i].name)
+		return -ENOMEM;
+	mc = devm_kzalloc(dapm->dev, (sizeof(*mc)), GFP_KERNEL);
+	if (!mc)
+		return -ENOMEM;
+
+	mc->reg = SND_SOC_NOPM;
+	mc->rreg = SND_SOC_NOPM;
+	mc->max = 1;
+
+	kc[i].private_value = (long)mc;
+	kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	kc[i].info = snd_soc_info_volsw;
+	kc[i].put = snd_soc_dapm_get_volsw;
+	kc[i].get = snd_soc_dapm_put_volsw;
+
+	sprintf(widget_name, "Beep Gen %x PGA", wid->nid);
+	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[i],
+			snd_soc_dapm_pga, wid, widget_name,
+			NULL, kc, 1, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	wid->priv = wid_ref;
+
+	return 0;
+}
+
+/* Create DAPM widgets to represent each codec widget */
+static int hdac_codec_alloc_widgets(struct snd_soc_dapm_context *dapm,
+		struct snd_soc_dapm_widget *widgets)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
+	struct hdac_codec_widget *wid;
+	int index = 0;
+	int ret = 0;
+
+	list_for_each_entry(wid, &edev->hdac.widget_list, head) {
+		switch (wid->type) {
+		case AC_WID_AUD_IN:
+		case AC_WID_AUD_OUT:
+			ret = hdac_codec_alloc_cvt_widget(dapm, widgets,
+							index, wid);
+			if (ret < 0)
+				return ret;
+			index++;
+			break;
+
+		case AC_WID_PIN:
+			ret = hdac_codec_alloc_pin_widget(dapm, widgets,
+							index, wid);
+			if (ret < 0)
+				return ret;
+			index += ret;
+			break;
+
+		case AC_WID_AUD_MIX:
+			ret = hdac_codec_alloc_mixer_widget(dapm, widgets,
+							index, wid);
+			if (ret < 0)
+				return ret;
+			index++;
+			break;
+
+		case AC_WID_AUD_SEL:
+			ret = hdac_generic_alloc_mux_widget(dapm, widgets,
+							index, wid);
+			if (ret < 0)
+				return ret;
+			index++;
+			break;
+
+		case AC_WID_POWER:
+			ret = hdac_codec_alloc_power_widget(dapm, widgets,
+							index, wid);
+			if (ret < 0)
+				return ret;
+			index++;
+			break;
+
+		case AC_WID_BEEP:
+			ret = hdac_codec_alloc_beep_widget(dapm, widgets,
+							index, wid);
+			if (ret < 0)
+				return ret;
+			index += 2;
+			break;
+
+		default:
+			dev_warn(&edev->hdac.dev,
+					"dapm widget not allocated for type: %d\n",
+					wid->type);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int hdac_generic_create_fill_widget_route_map(
+		struct snd_soc_dapm_context *dapm)
+{
+	struct snd_soc_dapm_widget *widgets;
+	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
+	struct hdac_generic_priv *hdac_priv = edev->private_data;
+
+	widgets = devm_kzalloc(dapm->dev,
+			(sizeof(*widgets) * hdac_priv->num_dapm_widgets),
+			GFP_KERNEL);
+	if (!widgets)
+		return -ENOMEM;
+
+	/* Create DAPM widgets */
+	hdac_codec_alloc_widgets(dapm, widgets);
+
+	snd_soc_dapm_new_controls(dapm, widgets, hdac_priv->num_dapm_widgets);
+
+	/* TODO:  Add each path to dapm graph when enumerated */
+
+	return 0;
+}
+
 static void hdac_generic_calc_dapm_widgets(struct hdac_ext_device *edev)
 {
 	struct hdac_generic_priv *hdac_priv = edev->private_data;
@@ -192,10 +663,15 @@ static int hdac_codec_probe(struct snd_soc_codec *codec)
 	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(&codec->component);
+	int ret;
 
 	edev->scodec = codec;
 
-	/* TODO: create widget, route and controls */
+	/* create widget, route and controls */
+	ret = hdac_generic_create_fill_widget_route_map(dapm);
+	if (ret < 0)
+		return ret;
+
 	/* TODO: jack sense */
 
 	/* Imp: Store the card pointer in hda_codec */
-- 
1.9.1
