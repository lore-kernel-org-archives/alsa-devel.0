From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 08/11] ASoC: hdac: Register widget event handlers
Date: Mon, 27 Jun 2016 09:18:01 +0530
Message-ID: <1466999284-14782-9-git-send-email-subhransu.s.prusty@intel.com>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B7BA62651D3
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:50 +0200 (CEST)
In-Reply-To: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
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

Register the event handlers and program the codec by sending
required verbs in the event handlers.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_generic.c | 212 ++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/hdac_generic.h |   3 +
 2 files changed, 209 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdac_generic.c b/sound/soc/codecs/hdac_generic.c
index a2084aa..32f8736 100644
--- a/sound/soc/codecs/hdac_generic.c
+++ b/sound/soc/codecs/hdac_generic.c
@@ -69,6 +69,188 @@ static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
 	return to_ehdac_device(hdac);
 }
 
+static void hdac_generic_set_power_state(struct hdac_ext_device *edev,
+			hda_nid_t nid, unsigned int pwr_state)
+{
+	/* TODO: check D0sup bit before setting this */
+	if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state))
+		snd_hdac_regmap_write(&edev->hdac, nid,
+				AC_VERB_SET_POWER_STATE, pwr_state);
+}
+
+static int hdac_generic_pin_io_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_codec_widget *wid = w->priv;
+
+	snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL,
+			w->id == snd_soc_dapm_input ?
+			AC_PINCTL_IN_EN : AC_PINCTL_OUT_EN);
+
+	return 0;
+}
+
+static int hdac_generic_pin_mux_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_codec_widget *wid = w->priv;
+	int mux_idx;
+
+	if (!kc)
+		kc  = w->kcontrols[0];
+
+	mux_idx = dapm_kcontrol_get_value(kc);
+
+	snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+			AC_VERB_SET_CONNECT_SEL, mux_idx);
+
+	return 0;
+}
+
+static int hdac_generic_pin_pga_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_codec_widget *wid = w->priv;
+
+	hdac_generic_set_power_state(edev, wid->nid,
+		(event == SND_SOC_DAPM_PRE_PMU ? AC_PWRST_D0:AC_PWRST_D3));
+
+	snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+	return 0;
+}
+
+static int hdac_generic_widget_power_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_codec_widget *wid = w->priv;
+
+	hdac_generic_set_power_state(edev, wid->nid,
+		(event == SND_SOC_DAPM_PRE_PMU ? AC_PWRST_D0:AC_PWRST_D3));
+
+	return 0;
+}
+
+static int get_mixer_control_index(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kc)
+{
+	int i;
+
+	for (i = 0; i < w->num_kcontrols; i++) {
+		if (w->kcontrols[i] == kc)
+			return i;
+	}
+
+	return -1;
+}
+
+static int hdac_generic_mixer_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_codec_widget *wid = w->priv;
+	bool no_input = true;
+	int i;
+
+	if (event == SND_SOC_DAPM_POST_REG) {
+		i = get_mixer_control_index(w, kc);
+		if (i == -1) {
+			dev_err(&edev->hdac.dev, "%s: Wrong kcontrol event: %s\n",
+							__func__, kc->id.name);
+			return -EINVAL;
+		}
+		if (dapm_kcontrol_get_value(kc)) {
+			snd_hdac_regmap_write(&edev->hdac, wid->nid,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(i));
+			no_input = false;
+		} else {
+			snd_hdac_regmap_write(&edev->hdac, wid->nid,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(i));
+		}
+
+		if (no_input)
+			snd_hdac_regmap_write(&edev->hdac, wid->nid,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+		return 0;
+	}
+
+	hdac_generic_set_power_state(edev, wid->nid,
+		(event == SND_SOC_DAPM_PRE_PMU ? AC_PWRST_D0:AC_PWRST_D3));
+
+	/* TODO: Check capability and program amp */
+	snd_hdac_regmap_write(&edev->hdac, wid->nid, AC_VERB_SET_AMP_GAIN_MUTE,
+							AMP_OUT_UNMUTE);
+
+	for (i = 0; i < w->num_kcontrols; i++) {
+		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
+			snd_hdac_regmap_write(&edev->hdac, wid->nid,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(i));
+		}
+	}
+
+	return 0;
+}
+
+static void update_mux_input_amp_mute(struct hdac_ext_device *edev,
+		hda_nid_t nid, struct snd_kcontrol *kc)
+{
+	bool no_input = true;
+	struct soc_enum *e = (struct soc_enum *)kc->private_value;
+	int mux_idx, i;
+
+	mux_idx = dapm_kcontrol_get_value(kc);
+
+	for (i = 0; i < (e->items - 1); i++) {
+		if (i == mux_idx) {
+			snd_hdac_regmap_write(&edev->hdac, nid,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(i));
+
+			no_input = false;
+		} else {
+			snd_hdac_regmap_write(&edev->hdac, nid,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(i));
+		}
+	}
+
+	if (no_input)
+		snd_hdac_regmap_write(&edev->hdac, nid,
+			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+}
+
+static int hdac_generic_selector_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_codec_widget *wid = w->priv;
+
+	if (event == SND_SOC_DAPM_POST_REG) {
+		/* TODO: Check capability and program amp */
+		update_mux_input_amp_mute(edev, wid->nid, kc);
+
+		return 0;
+	}
+
+	hdac_generic_set_power_state(edev, wid->nid,
+		(event == SND_SOC_DAPM_PRE_PMU ? AC_PWRST_D0:AC_PWRST_D3));
+
+	snd_hdac_regmap_write(&edev->hdac, wid->nid, AC_VERB_SET_CONNECT_SEL,
+				dapm_kcontrol_get_value(w->kcontrols[0]));
+
+	snd_hdac_regmap_write(&edev->hdac, wid->nid, AC_VERB_SET_AMP_GAIN_MUTE,
+							AMP_OUT_UNMUTE);
+	/* TODO: Check capability and program amp */
+	update_mux_input_amp_mute(edev, wid->nid, w->kcontrols[0]);
+
+	return 0;
+}
+
 static bool is_duplicate_route(struct list_head *route_list,
 		const char *sink, const char *control, const char *src)
 {
@@ -469,7 +651,8 @@ static int hdac_generic_alloc_mux_widget(struct snd_soc_dapm_context *dapm,
 
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
 			snd_soc_dapm_mux, wid, widget_name, NULL, kc, 1,
-			NULL, 0);
+			hdac_generic_selector_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_POST_REG);
 
 	if (ret < 0)
 		return ret;
@@ -523,7 +706,9 @@ static int hdac_codec_alloc_cvt_widget(struct snd_soc_dapm_context *dapm,
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
 			wid->type == AC_WID_AUD_IN ?
 			snd_soc_dapm_aif_in : snd_soc_dapm_aif_out,
-			wid, widget_name, dai_strm_name, NULL, 0, NULL, 0);
+			wid, widget_name, dai_strm_name, NULL, 0,
+			hdac_generic_widget_power_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
 	if (ret < 0)
 		return ret;
 
@@ -578,7 +763,9 @@ static int hdac_codec_alloc_mixer_widget(struct snd_soc_dapm_context *dapm,
 	sprintf(widget_name, "Mixer %x", wid->nid);
 	ret = hdac_generic_fill_widget_info(dapm->dev, &w[index],
 			snd_soc_dapm_mixer, wid, widget_name, NULL,
-			kc, wid->num_inputs, NULL, 0);
+			kc, wid->num_inputs, hdac_generic_mixer_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD |
+			SND_SOC_DAPM_POST_REG);
 	if (ret < 0)
 		return ret;
 
@@ -627,7 +814,9 @@ static int hdac_codec_alloc_pin_widget(struct snd_soc_dapm_context *dapm,
 
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[i],
 			input ? snd_soc_dapm_input : snd_soc_dapm_output,
-			wid, widget_name, NULL, NULL, 0, NULL, 0);
+			wid, widget_name, NULL, NULL, 0,
+			hdac_generic_pin_io_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
 	if (ret < 0)
 		return ret;
 
@@ -637,7 +826,8 @@ static int hdac_codec_alloc_pin_widget(struct snd_soc_dapm_context *dapm,
 	sprintf(widget_name, "Pin %x PGA", wid->nid);
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[i],
 			snd_soc_dapm_pga, wid, widget_name, NULL,
-			NULL, 0, NULL, 0);
+			NULL, 0, hdac_generic_pin_pga_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
 	if (ret < 0)
 		return ret;
 
@@ -649,6 +839,15 @@ static int hdac_codec_alloc_pin_widget(struct snd_soc_dapm_context *dapm,
 		ret = hdac_generic_alloc_mux_widget(dapm, widgets, i, wid);
 		if (ret < 0)
 			return ret;
+		/*
+		 * Pin mux will not use generic selector handler, so
+		 * override. Also mux widget create will increment the
+		 * index, so assign the previous widget.
+		 */
+		widgets[i].event_flags = SND_SOC_DAPM_PRE_PMU |
+						SND_SOC_DAPM_POST_PMD |
+						SND_SOC_DAPM_POST_REG;
+		widgets[i].event = hdac_generic_pin_mux_event;
 
 		wid_ref[2] = &widgets[i++];
 	}
@@ -670,7 +869,8 @@ static int hdac_codec_alloc_power_widget(struct snd_soc_dapm_context *dapm,
 	sprintf(widget_name, "Power %x", wid->nid);
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
 			snd_soc_dapm_supply, wid, widget_name,
-			NULL, NULL, 0, NULL, 0);
+			NULL, NULL, 0, hdac_generic_widget_power_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/codecs/hdac_generic.h b/sound/soc/codecs/hdac_generic.h
index 5a4cd36..c52dc7c 100644
--- a/sound/soc/codecs/hdac_generic.h
+++ b/sound/soc/codecs/hdac_generic.h
@@ -21,5 +21,8 @@
 #define __HDAC_GENERIC_H__
 
 #define HDAC_GENERIC_NAME_SIZE	32
+#define AMP_OUT_MUTE		0xb080
+#define AMP_OUT_UNMUTE		0xb000
+#define PIN_OUT			(AC_PINCTL_OUT_EN)
 
 #endif /* __HDAC_GENERIC_H__ */
-- 
1.9.1
