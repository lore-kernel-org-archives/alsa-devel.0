From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Create widget/route based on
	nodes enumerated" to the asoc tree
Date: Mon, 15 Feb 2016 20:58:50 +0000
Message-ID: <E1aVQEM-0007uM-1I@finisterre>
References: <1454161428-7896-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55F5A2654C7
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:58:57 +0100 (CET)
In-Reply-To: <1454161428-7896-6-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Create widget/route based on nodes enumerated

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 79f4e922b54771a4d41b1da67caf109ba92ed95a Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 12 Feb 2016 07:46:05 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Create widget/route based on nodes
 enumerated

In skylake, HDMI codec enumerates 3 pins and 3 cvts. Stream can
be routed from any cvt to any pin based on the connection list
queried from the pin.

This patch removes the static modelling of widget/route and
creates it dynamically based on the codec widgets enumerated.

Mux widgets are added to represent the map between a cvt and pin.
Ideally the mux widgets should be created based on the connection
list queried from the pin widget. But due to HW behavior, if an
external display is not connected on a port, querying the
connection list returns zero. So create mux widgets to map all
the cvt to all pins. At runtime, playback support on a pin can be
verified based on the connection list query.

Few function in driver have additional arguments now to support
this.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 241 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 219 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c85deae..6fb44c4 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -446,46 +446,241 @@ hdac_hdmi_query_cvt_params(struct hdac_device *hdac, struct hdac_hdmi_cvt *cvt)
 	return err;
 }
 
-static void hdac_hdmi_fill_widget_info(struct snd_soc_dapm_widget *w,
-				enum snd_soc_dapm_type id,
-				const char *wname, const char *stream)
+static int hdac_hdmi_fill_widget_info(struct device *dev,
+				struct snd_soc_dapm_widget *w,
+				enum snd_soc_dapm_type id, void *priv,
+				const char *wname, const char *stream,
+				struct snd_kcontrol_new *wc, int numkc)
 {
 	w->id = id;
-	w->name = wname;
+	w->name = devm_kstrdup(dev, wname, GFP_KERNEL);
+	if (!w->name)
+		return -ENOMEM;
+
 	w->sname = stream;
 	w->reg = SND_SOC_NOPM;
 	w->shift = 0;
-	w->kcontrol_news = NULL;
-	w->num_kcontrols = 0;
-	w->priv = NULL;
+	w->kcontrol_news = wc;
+	w->num_kcontrols = numkc;
+	w->priv = priv;
+
+	return 0;
 }
 
 static void hdac_hdmi_fill_route(struct snd_soc_dapm_route *route,
-		const char *sink, const char *control, const char *src)
+		const char *sink, const char *control, const char *src,
+		int (*handler)(struct snd_soc_dapm_widget *src,
+			struct snd_soc_dapm_widget *sink))
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
+{
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
+	/* enum texts: ["NONE", "cvt #", "cvt #", ...] */
+	se->items = num_items;
+	se->mask = roundup_pow_of_two(se->items) - 1;
+
+	sprintf(mux_items, "NONE");
+	items[i] = devm_kstrdup(&edev->hdac.dev, mux_items, GFP_KERNEL);
+	if (!items[i])
+		return -ENOMEM;
+
+	list_for_each_entry(cvt, &hdmi->cvt_list, head) {
+		i++;
+		sprintf(mux_items, "cvt %d", cvt->nid);
+		items[i] = devm_kstrdup(&edev->hdac.dev, mux_items, GFP_KERNEL);
+		if (!items[i])
+			return -ENOMEM;
+	}
+
+	se->texts = devm_kmemdup(&edev->hdac.dev, items,
+			(num_items  * sizeof(char *)), GFP_KERNEL);
+	if (!se->texts)
+		return -ENOMEM;
+
+	return hdac_hdmi_fill_widget_info(&edev->hdac.dev, widget,
+			snd_soc_dapm_mux, &pin->nid, widget_name,
+			NULL, kc, 1);
+}
+
+/* Add cvt <- input <- mux route map */
+static void hdac_hdmi_add_pinmux_cvt_route(struct hdac_ext_device *edev,
+			struct snd_soc_dapm_widget *widgets,
+			struct snd_soc_dapm_route *route, int rindex)
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
 {
-	struct snd_soc_dapm_route route[1];
-	struct snd_soc_dapm_widget widgets[2] = { {0} };
+	struct snd_soc_dapm_widget *widgets;
+	struct snd_soc_dapm_route *route;
+	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct snd_soc_dai_driver *dai_drv = dapm->component->dai_drv;
+	char widget_name[NAME_SIZE];
+	struct hdac_hdmi_cvt *cvt;
+	struct hdac_hdmi_pin *pin;
+	int ret, i = 0, num_routes = 0;
 
-	memset(&route, 0, sizeof(route));
+	if (list_empty(&hdmi->cvt_list) || list_empty(&hdmi->pin_list))
+		return -EINVAL;
 
-	hdac_hdmi_fill_widget_info(&widgets[0], snd_soc_dapm_output,
-			"hif1 Output", NULL);
-	hdac_hdmi_fill_widget_info(&widgets[1], snd_soc_dapm_aif_in,
-			"Coverter 1", "hif1");
+	widgets = devm_kzalloc(dapm->dev,
+		(sizeof(*widgets) * ((2 * hdmi->num_pin) + hdmi->num_cvt)),
+		GFP_KERNEL);
 
-	hdac_hdmi_fill_route(&route[0], "hif1 Output", NULL, "Coverter 1");
+	if (!widgets)
+		return -ENOMEM;
+
+	/* DAPM widgets to represent each converter widget */
+	list_for_each_entry(cvt, &hdmi->cvt_list, head) {
+		sprintf(widget_name, "Converter %d", cvt->nid);
+		ret = hdac_hdmi_fill_widget_info(dapm->dev, &widgets[i],
+			snd_soc_dapm_aif_in, &cvt->nid,
+			widget_name, dai_drv[i].playback.stream_name, NULL, 0);
+		if (ret < 0)
+			return ret;
+		i++;
+	}
+
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		sprintf(widget_name, "hif%d Output", pin->nid);
+		ret = hdac_hdmi_fill_widget_info(dapm->dev, &widgets[i],
+				snd_soc_dapm_output, &pin->nid,
+				widget_name, NULL, NULL, 0);
+		if (ret < 0)
+			return ret;
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
+		hdac_hdmi_fill_route(&route[i],
+				widgets[sink_index].name, NULL,
+				widgets[src_index].name, NULL);
+		i++;
+
+	}
+
+	hdac_hdmi_add_pinmux_cvt_route(edev, widgets, route, i);
+
+	snd_soc_dapm_new_controls(dapm, widgets,
+		((2 * hdmi->num_pin) + hdmi->num_cvt));
+
+	snd_soc_dapm_add_routes(dapm, route, num_routes);
+	snd_soc_dapm_new_widgets(dapm->card);
+
+	return 0;
 
-	snd_soc_dapm_new_controls(dapm, widgets, ARRAY_SIZE(widgets));
-	snd_soc_dapm_add_routes(dapm, route, ARRAY_SIZE(route));
 }
 
 static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
@@ -855,7 +1050,9 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 
 	edev->scodec = codec;
 
-	create_fill_widget_route_map(dapm, &hdmi->dai_map[0]);
+	ret = create_fill_widget_route_map(dapm);
+	if (ret < 0)
+		return ret;
 
 	aops.audio_ptr = edev;
 	ret = snd_hdac_i915_register_notifier(&aops);
-- 
2.7.0
