From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 10/15] ASoC: hdac_hdmi: Create widget/route
	based on nodes enumerated
Date: Tue,  1 Dec 2015 23:17:06 +0530
Message-ID: <1448992031-8271-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DB0E265D37
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:50 +0100 (CET)
In-Reply-To: <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
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

Instead of direct mapping between converter and pin, Muxes are
added between them to support any converter connection to any pin.

As the possible mux inputs can only be identified during runtime,
all possible routes are created to connect all converters to all
pin muxes. The user should enable appropriate mux inputs to enable
correct port.

In the process to support the above changes widget/route fill APIs
are updated to take all required parameters.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 224 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 202 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 3c4254c..888d02e 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -345,46 +345,224 @@ static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
 	return pin->num_mux_nids;
 }
 
-static void hdac_hdmi_fill_widget_info(struct snd_soc_dapm_widget *w,
-				enum snd_soc_dapm_type id,
-				const char *wname, const char *stream)
+static void hdac_hdmi_fill_widget_info(struct device *dev,
+				struct snd_soc_dapm_widget *w,
+				enum snd_soc_dapm_type id, void *priv,
+				const char *wname, const char *stream,
+				struct snd_kcontrol_new *wc, int numkc)
 {
 	w->id = id;
-	w->name = wname;
+	w->name = devm_kstrdup(dev, wname, GFP_KERNEL);
 	w->sname = stream;
 	w->reg = SND_SOC_NOPM;
 	w->shift = 0;
-	w->kcontrol_news = NULL;
-	w->num_kcontrols = 0;
-	w->priv = NULL;
+	w->kcontrol_news = wc;
+	w->num_kcontrols = numkc;
+	w->priv = priv;
 }
 
 static void hdac_hdmi_fill_route(struct snd_soc_dapm_route *route,
-		const char *sink, const char *control, const char *src)
+		const char *sink, const char *control, const char *src,
+		int (*handler)(struct snd_soc_dapm_widget *sr,
+			struct snd_soc_dapm_widget *snk))
 {
 	route->sink = sink;
 	route->source = src;
 	route->control = control;
-	route->connected = NULL;
+	route->connected = handler;
 }
 
-static void create_fill_widget_route_map(struct snd_soc_dapm_context *dapm,
-					struct hdac_hdmi_dai_pin_map *dai_map)
+/*
+ * Ideally the Mux inputs should be based on the num_muxs enumerated, but
+ * the display driver seem to be programming the connection list for the pin
+ * widget runtime.
+ *
+ * So programming all the possible inputs for the mux, the user has to take
+ * care of selecting the right one and leaving all other inputs selected to
+ * "NONE"
+ */
+static int hdac_hdmi_create_pin_muxs(struct hdac_ext_device *edev,
+				struct hdac_hdmi_pin *pin,
+				struct snd_soc_dapm_widget *widget,
+				const char *widget_name)
 {
-	struct snd_soc_dapm_route route[1];
-	struct snd_soc_dapm_widget widgets[2] = { {0} };
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct snd_kcontrol_new *kc;
+	struct hdac_hdmi_cvt *cvt;
+	struct soc_enum *se;
+	char kc_name[NAME_SIZE];
+	char mux_items[NAME_SIZE];
+	/* To hold inputs to the Pin mux */
+	char *items[HDA_MAX_CONNECTIONS];
+	int i = 0;
+	int num_items = hdmi->num_cvt + 1;
+
+	kc = devm_kzalloc(&edev->hdac.dev, sizeof(*kc), GFP_KERNEL);
+	if (!kc)
+		return -ENOMEM;
+
+	se = devm_kzalloc(&edev->hdac.dev, sizeof(*se), GFP_KERNEL);
+	if (!se)
+		return -ENOMEM;
+
+	sprintf(kc_name, "Pin %d Input", pin->nid);
+	kc->name = devm_kstrdup(&edev->hdac.dev, kc_name, GFP_KERNEL);
+	kc->private_value = (long)se;
+	kc->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	kc->access = 0;
+	kc->info = snd_soc_info_enum_double;
+	kc->put = snd_soc_dapm_put_enum_double;
+	kc->get = snd_soc_dapm_get_enum_double;
 
-	memset(&route, 0, sizeof(route));
+	se->reg = SND_SOC_NOPM;
 
-	hdac_hdmi_fill_widget_info(&widgets[0], snd_soc_dapm_output,
-			"hif1 Output", NULL);
-	hdac_hdmi_fill_widget_info(&widgets[1], snd_soc_dapm_aif_in,
-			"Coverter 1", "hif1");
+	/* enum texts: ["NONE", "cvt #", "cvt #", ...] */
+	se->items = num_items;
+	se->mask = roundup_pow_of_two(se->items) - 1;
+
+	sprintf(mux_items, "NONE");
+	items[i] = devm_kstrdup(&edev->hdac.dev, mux_items, GFP_KERNEL);
+
+	list_for_each_entry(cvt, &hdmi->cvt_list, head) {
+		i++;
+		sprintf(mux_items, "cvt %d", cvt->nid);
+		items[i] = devm_kstrdup(&edev->hdac.dev, mux_items, GFP_KERNEL);
+	}
+
+	se->texts = devm_kmemdup(&edev->hdac.dev, items,
+			(num_items  * sizeof(char *)), GFP_KERNEL);
+
+	hdac_hdmi_fill_widget_info(&edev->hdac.dev, widget, snd_soc_dapm_mux,
+				&pin->nid, widget_name, NULL, kc, 1);
+
+	return 0;
+}
 
-	hdac_hdmi_fill_route(&route[0], "hif1 Output", NULL, "Coverter 1");
+/* Add cvt <- input <- mux route map */
+static void hdac_hdmi_add_pinmux_cvt_route(struct hdac_ext_device *edev,
+		struct snd_soc_dapm_widget *widgets,
+		struct snd_soc_dapm_route *route, int rindex)
+{
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	const struct snd_kcontrol_new *kc;
+	struct soc_enum *se;
+	int mux_index = hdmi->num_cvt + hdmi->num_pin;
+	int i, j;
+
+	for (i = 0; i < hdmi->num_pin; i++) {
+		kc = widgets[mux_index].kcontrol_news;
+		se = (struct soc_enum *)kc->private_value;
+		for (j = 0; j < hdmi->num_cvt; j++) {
+			hdac_hdmi_fill_route(&route[rindex],
+					widgets[mux_index].name,
+					se->texts[j + 1],
+					widgets[j].name, NULL);
+
+			rindex++;
+		}
+
+		mux_index++;
+	}
+}
+
+/*
+ * Widgets are added in the below sequence
+ *	Converter widgets for num converters enumerated
+ *	Pin widgets for num pins enumerated
+ *	Pin mux widgets to represent connenction list of pin widget
+ *
+ * Total widgets elements = num_cvt + num_pin + num_pin;
+ *
+ * Routes are added as below:
+ *	pin mux -> pin (based on num_pins)
+ *	cvt -> "Input sel control" -> pin_mux
+ *
+ * Total route elements:
+ *	num_pins + (pin_muxes * num_cvt)
+ */
+static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
+{
+	struct snd_soc_dapm_widget *widgets;
+	struct snd_soc_dapm_route *route;
+	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct snd_soc_dai_driver *dai_drv = dapm->component->dai_drv;
+	char widget_name[NAME_SIZE];
+	struct hdac_hdmi_cvt *cvt;
+	struct hdac_hdmi_pin *pin;
+	int i = 0;
+	int ret;
+	int num_routes = 0;
+
+	if (list_empty(&hdmi->cvt_list) || list_empty(&hdmi->pin_list))
+		return -EINVAL;
+
+	widgets = devm_kzalloc(dapm->dev,
+			(sizeof(*widgets) * ((2 * hdmi->num_pin) + hdmi->num_cvt)),
+			GFP_KERNEL);
+	if (!widgets)
+		return -ENOMEM;
+
+	/* DAPM widgets to represent each converter widget */
+	list_for_each_entry(cvt, &hdmi->cvt_list, head) {
+		sprintf(widget_name, "Converter %d", cvt->nid);
+		hdac_hdmi_fill_widget_info(dapm->dev, &widgets[i],
+			snd_soc_dapm_aif_in, &cvt->nid,
+			widget_name, dai_drv[i].playback.stream_name, NULL, 0);
+		i++;
+	}
+
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		sprintf(widget_name, "hif%d Output", pin->nid);
+		hdac_hdmi_fill_widget_info(dapm->dev, &widgets[i],
+				snd_soc_dapm_output, &pin->nid,
+				widget_name, NULL, NULL, 0);
+		i++;
+	}
+
+	/* DAPM widgets to represent the connection list to pin widget */
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		sprintf(widget_name, "Pin %d Mux", pin->nid);
+		ret = hdac_hdmi_create_pin_muxs(edev, pin, &widgets[i],
+							widget_name);
+		if (ret < 0)
+			return ret;
+		i++;
+
+		/* For cvt to pin_mux mapping */
+		num_routes += hdmi->num_cvt;
+
+		/* For pin_mux to pin mapping */
+		num_routes++;
+	}
+
+	route = devm_kzalloc(dapm->dev, (sizeof(*route) * num_routes),
+							GFP_KERNEL);
+	if (!route)
+		return -ENOMEM;
+
+	i = 0;
+	/* Add pin <- NULL <- mux route map */
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		int sink_index = i + hdmi->num_cvt;
+		int src_index = sink_index + hdmi->num_pin;
+
+		hdac_hdmi_fill_route(&route[i], widgets[sink_index].name,
+				NULL, widgets[src_index].name,
+				NULL);
+		i++;
+
+	}
+
+	hdac_hdmi_add_pinmux_cvt_route(edev, widgets, route, i);
+
+	snd_soc_dapm_new_controls(dapm, widgets,
+		((2 * hdmi->num_pin) + hdmi->num_cvt));
+	snd_soc_dapm_add_routes(dapm, route, num_routes);
+	snd_soc_dapm_new_widgets(dapm->card);
+
+	return 0;
 
-	snd_soc_dapm_new_controls(dapm, widgets, ARRAY_SIZE(widgets));
-	snd_soc_dapm_add_routes(dapm, route, ARRAY_SIZE(route));
 }
 
 static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
@@ -737,7 +915,9 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 
 	edev->scodec = codec;
 
-	create_fill_widget_route_map(dapm, &hdmi->dai_map[0]);
+	ret = create_fill_widget_route_map(dapm);
+	if (ret < 0)
+		return ret;
 
 	aops.audio_ptr = edev;
 	ret = snd_hdac_i915_register_notifier(&aops);
-- 
1.9.1
