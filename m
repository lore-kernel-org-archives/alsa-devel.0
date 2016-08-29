From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 07/12] ASoC: hdac: Build DAPM graph by querying
	through widget connection list
Date: Mon, 29 Aug 2016 11:53:21 +0530
Message-ID: <1472451806-10605-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BAB5F266E4B
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:23:43 +0200 (CEST)
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

This patch recursively traverses the HDA codec widgets and builds
the graph by querying connection list of each.

Only output pin widget and adc widget endpoints can support
connection list. So for a playback path query happens from output
pin widget end and for a capture path query happens from adc
widget end till an input endpoint is found.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_generic.c | 329 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 328 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_generic.c b/sound/soc/codecs/hdac_generic.c
index 7f3a2a0..6bd7b2b 100644
--- a/sound/soc/codecs/hdac_generic.c
+++ b/sound/soc/codecs/hdac_generic.c
@@ -53,6 +53,19 @@ static char *wid_names[] = {
 		NULL, NULL, NULL, "vendor",
 };
 
+struct route_map {
+	struct list_head head;
+	const char *sink;
+	char *control;
+	const char *src;
+};
+
+struct widget_node_entries {
+	struct hdac_codec_widget *wid;
+	struct snd_soc_dapm_widget *w;
+	int num_nodes;
+};
+
 static void hdac_generic_set_power_state(struct hdac_ext_device *edev,
 			hda_nid_t nid, unsigned int pwr_state)
 {
@@ -62,6 +75,316 @@ static void hdac_generic_set_power_state(struct hdac_ext_device *edev,
 				AC_VERB_SET_POWER_STATE, pwr_state);
 }
 
+static bool is_duplicate_route(struct list_head *route_list,
+		const char *sink, const char *control, const char *src)
+{
+	struct route_map *map;
+
+	list_for_each_entry(map, route_list, head) {
+
+		if (strcmp(src, map->src))
+			continue;
+		if (strcmp(sink, map->sink))
+			continue;
+		if (!control && !map->control)
+			return true;
+		if ((control && map->control) &&
+				!strcmp(control, map->control))
+			return true;
+	}
+
+	return false;
+}
+
+static int hdac_generic_add_route(struct snd_soc_dapm_context *dapm,
+		const char *sink, const char *control, const char *src,
+		struct list_head *route_list)
+{
+	struct snd_soc_dapm_route route;
+	struct route_map *map;
+
+	/*
+	 * During parsing a loop can be created from input pin to output pin.
+	 * An input pin is represented with pga and input dapm widgets.
+	 * There is possibility of duplicate route between these two pga and
+	 * input widgets as the input can appear for multiple output pins or
+	 * adcs during connection list query. So check the duplication.
+	 */
+	if (is_duplicate_route(route_list, sink, control, src))
+		return 0;
+
+	route.sink = sink;
+	route.source = src;
+	route.control = control;
+	route.connected = NULL;
+
+	snd_soc_dapm_add_routes(dapm, &route, 1);
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	map->sink = sink;
+	map->src = src;
+	if (control) {
+		map->control = kcalloc(SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+					sizeof(char), GFP_KERNEL);
+		if (!map->control) {
+			kfree(map);
+			return -ENOMEM;
+		}
+
+		strcpy(map->control, control);
+	}
+
+	list_add_tail(&map->head, route_list);
+
+	return 0;
+}
+
+/* Returns the only dapm widget which can be connected to other hda widgets */
+static struct snd_soc_dapm_widget *hda_widget_to_dapm_widget(
+			struct hdac_ext_device *edev,
+			struct hdac_codec_widget *wid)
+{
+	struct snd_soc_dapm_widget **wid_ref;
+
+	switch (wid->type) {
+	case AC_WID_PIN:
+		wid_ref = wid->priv;
+
+		if (is_input_pin(&edev->hdac, wid->nid))
+			return wid_ref[1];
+
+		if (wid->num_inputs == 1)
+			return wid_ref[1];
+
+		return wid_ref[2];
+
+	case AC_WID_BEEP:
+		wid_ref = wid->priv;
+
+		return wid_ref[1];
+
+	case AC_WID_AUD_OUT:
+	case AC_WID_AUD_IN:
+	case AC_WID_AUD_MIX:
+	case AC_WID_AUD_SEL:
+	case AC_WID_POWER:
+		return wid->priv;
+
+	default:
+		dev_info(&edev->hdac.dev, "Widget type %d not handled\n",
+				wid->type);
+		return NULL;
+	}
+
+	return NULL;
+}
+
+static void fill_pinout_next_wid_entry(struct hdac_ext_device *edev,
+			struct widget_node_entries *next,
+			struct widget_node_entries *wid_entry,
+			const char **control, int index)
+{
+	struct snd_soc_dapm_widget **wid_ref = wid_entry->wid->priv;
+	const struct snd_kcontrol_new *kc;
+	struct soc_enum *se;
+
+	switch (wid_entry->w->id) {
+	case snd_soc_dapm_output:
+		next->w = wid_ref[1];
+		next->num_nodes = 1;
+		next->wid = wid_entry->wid;
+
+		break;
+
+	case snd_soc_dapm_pga:
+		if (wid_entry->wid->num_inputs == 1) {
+			next->wid = wid_entry->wid->conn_list[index].input_w;
+			next->w = hda_widget_to_dapm_widget(
+					edev, next->wid);
+			next->num_nodes = next->wid->num_inputs;
+		} else {
+			next->wid = wid_entry->wid;
+			next->w = wid_ref[2];
+			next->num_nodes = wid_entry->wid->num_inputs;
+		}
+
+		break;
+
+	case snd_soc_dapm_mux:
+		kc = wid_entry->w->kcontrol_news;
+		se = (struct soc_enum *)kc->private_value;
+
+		next->wid = wid_entry->wid->conn_list[index].input_w;
+		next->num_nodes = next->wid->num_inputs;
+		next->w = hda_widget_to_dapm_widget(edev, next->wid);
+
+		*control = se->texts[index + 1];
+
+		break;
+
+	default:
+		dev_warn(&edev->hdac.dev,
+				"widget nid: %d id: %d not handled\n",
+				wid_entry->wid->nid, wid_entry->w->id);
+		break;
+	}
+}
+
+static int parse_node_and_add_route(struct snd_soc_dapm_context *dapm,
+				struct widget_node_entries *wid_entry,
+				struct list_head *route_list)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
+	int i, ret;
+	struct widget_node_entries next;
+	const char *control = NULL;
+
+	if (!wid_entry->num_nodes)
+		return 0;
+
+	if ((wid_entry->w->id == snd_soc_dapm_dac) ||
+			 (wid_entry->w->id == snd_soc_dapm_input) ||
+			 (wid_entry->w->id == snd_soc_dapm_siggen)) {
+
+		return 0;
+	}
+
+	for (i = 0; i < wid_entry->num_nodes; i++) {
+
+		if (wid_entry->wid->type == AC_WID_PIN) {
+			control = NULL;
+
+			if (is_input_pin(&edev->hdac, wid_entry->wid->nid)) {
+
+				struct snd_soc_dapm_widget **wid_ref =
+							wid_entry->wid->priv;
+
+				if (wid_entry->w->id == snd_soc_dapm_pga) {
+					next.w = wid_ref[0];
+					next.num_nodes = 1;
+					next.wid = wid_entry->wid;
+				}
+			} else { /* if output pin */
+				fill_pinout_next_wid_entry(edev, &next,
+						wid_entry, &control, i);
+			}
+		} else {
+			struct snd_soc_dapm_widget *w = wid_entry->wid->priv;
+			const struct snd_kcontrol_new *kc;
+			struct soc_enum *se;
+
+			next.wid = wid_entry->wid->conn_list[i].input_w;
+			next.w = hda_widget_to_dapm_widget(edev, next.wid);
+			if (next.wid->type == AC_WID_PIN &&
+					is_input_pin(&edev->hdac,
+						next.wid->nid))
+				next.num_nodes = 1;
+			else
+				next.num_nodes = next.wid->num_inputs;
+
+			switch (w->id) {
+			case snd_soc_dapm_mux:
+				kc = &w->kcontrol_news[0];
+				se = (struct soc_enum *)kc->private_value;
+				control = se->texts[i + 1];
+
+				break;
+
+			case snd_soc_dapm_mixer:
+				kc = &w->kcontrol_news[i];
+				control = kc->name;
+
+				break;
+			default:
+				break;
+			}
+		}
+
+		ret = hdac_generic_add_route(dapm, wid_entry->w->name,
+					control, next.w->name, route_list);
+		if (ret < 0)
+			return ret;
+
+		ret = parse_node_and_add_route(dapm, &next, route_list);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Example graph connection from a output PIN to a DAC:
+ * DAC1->
+ *         Mixer 1 ------->
+ * DAC2->                   Virtual Mux -> PIN PGA -> OUTPUT PIN
+ *                       ->
+ * LOUT1 ----------------|
+ *
+ * Widget connection map can be created by querying the connection list for
+ * each widget. The parsing can happen from two endpoints:
+ * 1) PIN widget 2) ADC widget.
+ *
+ * This goes through both pin list and adc list and builds the graph.
+ */
+
+static int hdac_generic_add_route_to_list(struct snd_soc_dapm_context *dapm,
+				struct snd_soc_dapm_widget *widgets)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
+	struct hdac_codec_widget *wid;
+	struct snd_soc_dapm_widget **wid_ref;
+	struct widget_node_entries wid_entry;
+	struct list_head route_list;
+	struct route_map *map, *tmp;
+	int ret =  0;
+
+	/*
+	 * manage the routes through a temp list to identify duplicate
+	 * routes from being added.
+	 */
+	INIT_LIST_HEAD(&route_list);
+	list_for_each_entry(wid, &edev->hdac.widget_list, head) {
+		if ((wid->type != AC_WID_PIN) && (wid->type != AC_WID_AUD_IN))
+			continue;
+		/*
+		 * input capable pins don't have a connection list, so skip
+		 * them.
+		 */
+		if ((wid->type == AC_WID_PIN) &&
+				(is_input_pin(&edev->hdac, wid->nid)))
+			continue;
+
+		if (wid->type == AC_WID_PIN) {
+			wid_ref = wid->priv;
+
+			wid_entry.wid = wid;
+			wid_entry.num_nodes = 1;
+			wid_entry.w = wid_ref[0];
+		} else {
+			wid_entry.wid = wid;
+			wid_entry.num_nodes = wid->num_inputs;
+			wid_entry.w = wid->priv;
+		}
+
+		ret = parse_node_and_add_route(dapm, &wid_entry, &route_list);
+		if (ret < 0)
+			goto fail;
+	}
+
+fail:
+	list_for_each_entry_safe(map, tmp, &route_list, head) {
+		kfree(map->control);
+		list_del(&map->head);
+		kfree(map);
+	}
+
+	return ret;
+}
+
 static int hdac_generic_fill_widget_info(struct device *dev,
 		struct snd_soc_dapm_widget *w, enum snd_soc_dapm_type id,
 		void *priv, const char *wname, const char *stream,
@@ -518,7 +841,11 @@ static int hdac_generic_create_fill_widget_route_map(
 
 	snd_soc_dapm_new_controls(dapm, widgets, hdac_priv->num_dapm_widgets);
 
-	/* TODO:  Add each path to dapm graph when enumerated */
+	/* Add each path to dapm graph when enumerated */
+	hdac_generic_add_route_to_list(dapm, widgets);
+
+	snd_soc_dapm_new_widgets(dapm->card);
+
 
 	return 0;
 }
-- 
1.9.1
