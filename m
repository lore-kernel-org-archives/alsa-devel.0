From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 07/11] ASoC: hdac: Register widget event
	handlers
Date: Fri,  2 Sep 2016 16:34:56 +0530
Message-ID: <1472814300-5629-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C57A2677A6
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 13:10:53 +0200 (CEST)
In-Reply-To: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
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
 sound/soc/codecs/hdac_generic.c | 329 +++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/hdac_generic.h |   3 +
 2 files changed, 326 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdac_generic.c b/sound/soc/codecs/hdac_generic.c
index 87fc752..f6f1658 100644
--- a/sound/soc/codecs/hdac_generic.c
+++ b/sound/soc/codecs/hdac_generic.c
@@ -75,6 +75,305 @@ static void hdac_generic_set_power_state(struct hdac_ext_device *edev,
 				AC_VERB_SET_POWER_STATE, pwr_state);
 }
 
+/* TODO: Add feature to program by querying capability */
+static void hdac_generic_set_eapd(struct hdac_ext_device *edev,
+			hda_nid_t nid, bool enable)
+{
+	u32 pin_caps = snd_hdac_read_parm_uncached(&edev->hdac,
+					nid, AC_PAR_PIN_CAP);
+
+	if (pin_caps & AC_PINCAP_EAPD)
+		snd_hdac_codec_write(&edev->hdac, nid, 0,
+				AC_VERB_SET_EAPD_BTLENABLE, enable ? 2 : 0);
+}
+
+static int hdac_generic_pin_io_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_ext_codec_widget *wid = w->priv;
+	int val;
+
+	dev_dbg(&edev->hdac.dev, "%s: widget: %s event: %x\n",
+			__func__, w->name, event);
+
+	val = snd_hdac_codec_read(&edev->hdac, wid->nid, 0,
+			AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (w->id == snd_soc_dapm_output) {
+			/* TODO: program using a eapd widget */
+			hdac_generic_set_eapd(edev, wid->nid, true);
+			val |= AC_PINCTL_OUT_EN;
+		} else {
+
+			/* TODO: program vref using a mixer control */
+			val |= AC_PINCTL_VREF_80;
+			val |= AC_PINCTL_IN_EN;
+		}
+
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		if (w->id == snd_soc_dapm_output) {
+			/* TODO: program using a eapd widget */
+			hdac_generic_set_eapd(edev, wid->nid, false);
+			val &= ~AC_PINCTL_OUT_EN;
+		} else {
+			val &= AC_PINCTL_VREF_HIZ;
+			val &= ~AC_PINCTL_IN_EN;
+		}
+
+		break;
+
+	default:
+		dev_warn(&edev->hdac.dev, "Event %d not handled\n", event);
+		return 0;
+	}
+
+	snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL, val);
+
+	return 0;
+}
+
+static int hdac_generic_pin_mux_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_ext_codec_widget *wid = w->priv;
+	int mux_idx;
+
+	dev_dbg(&edev->hdac.dev, "%s: widget: %s event: %x\n",
+			__func__, w->name, event);
+	if (!kc)
+		kc  = w->kcontrols[0];
+
+	mux_idx = dapm_kcontrol_get_value(kc);
+	if (mux_idx > 0) {
+		snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+			AC_VERB_SET_CONNECT_SEL, (mux_idx - 1));
+	}
+
+	return 0;
+}
+
+static int hdac_generic_pin_pga_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_ext_codec_widget *wid = w->priv;
+
+	dev_dbg(&edev->hdac.dev, "%s: widget: %s event: %x\n",
+			__func__, w->name, event);
+
+	if (event == SND_SOC_DAPM_POST_PMD) {
+		hdac_generic_set_power_state(edev, wid->nid, AC_PWRST_D3);
+		snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	} else {
+		hdac_generic_set_power_state(edev, wid->nid, AC_PWRST_D0);
+		snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+	}
+
+	return 0;
+}
+
+static int hdac_generic_widget_power_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_ext_codec_widget *wid = w->priv;
+
+	dev_dbg(&edev->hdac.dev, "%s: widget: %s event: %x\n",
+			__func__, w->name, event);
+	hdac_generic_set_power_state(edev, wid->nid,
+		(event == SND_SOC_DAPM_POST_PMD ? AC_PWRST_D3:AC_PWRST_D0));
+
+	return 0;
+}
+
+static int hdac_generic_cvt_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_ext_codec_widget *wid = w->priv;
+
+	hdac_generic_widget_power_event(w, kc, event);
+
+	if (event == SND_SOC_DAPM_POST_PMD)
+		snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE,
+				AMP_IN_MUTE(0));
+	else
+		snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE,
+				AMP_IN_UNMUTE(0) | 0x5b);
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
+	return -EINVAL;
+}
+
+static int hdac_generic_mixer_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_ext_codec_widget *wid = w->priv;
+	bool no_input = true;
+	int i;
+
+	dev_dbg(&edev->hdac.dev, "%s: widget: %s event: %x\n",
+			__func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		hdac_generic_set_power_state(edev, wid->nid, AC_PWRST_D0);
+
+
+		snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+		for (i = 0; i < w->num_kcontrols; i++) {
+			if (dapm_kcontrol_get_value(w->kcontrols[i])) {
+				snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+					AC_VERB_SET_AMP_GAIN_MUTE,
+					AMP_IN_UNMUTE(i));
+			}
+		}
+
+		return 0;
+
+	case SND_SOC_DAPM_POST_PMD:
+		snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+		for (i = 0; i < w->num_kcontrols; i++) {
+			if (dapm_kcontrol_get_value(w->kcontrols[i])) {
+				snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+					AC_VERB_SET_AMP_GAIN_MUTE,
+					AMP_IN_MUTE(i));
+			}
+		}
+
+		hdac_generic_set_power_state(edev, wid->nid, AC_PWRST_D3);
+
+		return 0;
+
+	case SND_SOC_DAPM_POST_REG:
+		i = get_mixer_control_index(w, kc);
+		if (i < 0) {
+			dev_err(&edev->hdac.dev,
+					"%s: Wrong kcontrol event: %s\n",
+					__func__, kc->id.name);
+			return i;
+		}
+		if (dapm_kcontrol_get_value(kc)) {
+			snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(i));
+			no_input = false;
+		} else {
+			snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(i));
+		}
+
+		if (no_input)
+			snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+		return 0;
+
+	default:
+		dev_warn(&edev->hdac.dev, "Event %d not handled\n", event);
+		return 0;
+	}
+
+	return 0;
+}
+
+static void update_mux_amp_switch(struct hdac_ext_device *edev,
+		hda_nid_t nid, struct snd_kcontrol *kc, bool enable)
+{
+	struct soc_enum *e = (struct soc_enum *)kc->private_value;
+	int mux_idx, i;
+
+	mux_idx = dapm_kcontrol_get_value(kc);
+
+	if (!enable || !mux_idx) {
+		for (i = 1; i < (e->items - 1); i++)
+			snd_hdac_codec_write(&edev->hdac, nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(i - 1));
+
+		snd_hdac_codec_write(&edev->hdac, nid, 0,
+			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	} else {
+		for (i = 1; i < (e->items - 1); i++) {
+			if (i == mux_idx)
+				snd_hdac_codec_write(&edev->hdac, nid, 0,
+					AC_VERB_SET_AMP_GAIN_MUTE,
+					AMP_IN_UNMUTE(i - 1));
+			else
+				snd_hdac_codec_write(&edev->hdac, nid, 0,
+					AC_VERB_SET_AMP_GAIN_MUTE,
+					AMP_IN_MUTE(i - 1));
+		}
+
+		snd_hdac_codec_write(&edev->hdac, nid, 0,
+			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+	}
+}
+
+static int hdac_generic_selector_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kc, int event)
+{
+	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_ext_codec_widget *wid = w->priv;
+
+	dev_dbg(&edev->hdac.dev, "%s: widget: %s event: %x\n",
+			__func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		hdac_generic_set_power_state(edev, wid->nid, AC_PWRST_D0);
+		snd_hdac_codec_write(&edev->hdac, wid->nid, 0,
+				AC_VERB_SET_CONNECT_SEL,
+				(dapm_kcontrol_get_value(w->kcontrols[0]) - 1));
+		update_mux_amp_switch(edev, wid->nid, w->kcontrols[0], true);
+
+		return 0;
+
+	case SND_SOC_DAPM_POST_REG:
+		update_mux_amp_switch(edev, wid->nid, kc, true);
+
+		return 0;
+
+	case SND_SOC_DAPM_POST_PMD:
+		update_mux_amp_switch(edev, wid->nid, w->kcontrols[0], false);
+		hdac_generic_set_power_state(edev, wid->nid, AC_PWRST_D3);
+
+		return 0;
+
+	default:
+		dev_warn(&edev->hdac.dev, "Event %d not handled\n", event);
+		return 0;
+	}
+
+	return 0;
+}
+
 static bool is_duplicate_route(struct list_head *route_list,
 		const char *sink, const char *control, const char *src)
 {
@@ -480,7 +779,8 @@ static int hdac_generic_alloc_mux_widget(struct snd_soc_dapm_context *dapm,
 
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
 			snd_soc_dapm_mux, wid, widget_name, NULL, kc, 1,
-			NULL, 0);
+			hdac_generic_selector_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_POST_REG);
 
 	if (ret < 0)
 		return ret;
@@ -534,7 +834,9 @@ static int hdac_codec_alloc_cvt_widget(struct snd_soc_dapm_context *dapm,
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
 			wid->type == AC_WID_AUD_IN ?
 			snd_soc_dapm_aif_in : snd_soc_dapm_aif_out,
-			wid, widget_name, dai_strm_name, NULL, 0, NULL, 0);
+			wid, widget_name, dai_strm_name, NULL, 0,
+			hdac_generic_cvt_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
 	if (ret < 0)
 		return ret;
 
@@ -587,7 +889,9 @@ static int hdac_codec_alloc_mixer_widget(struct snd_soc_dapm_context *dapm,
 	sprintf(widget_name, "Mixer %x", wid->nid);
 	ret = hdac_generic_fill_widget_info(dapm->dev, &w[index],
 			snd_soc_dapm_mixer, wid, widget_name, NULL,
-			kc, wid->num_inputs, NULL, 0);
+			kc, wid->num_inputs, hdac_generic_mixer_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD |
+			SND_SOC_DAPM_POST_REG);
 	if (ret < 0)
 		return ret;
 
@@ -635,7 +939,9 @@ static int hdac_codec_alloc_pin_widget(struct snd_soc_dapm_context *dapm,
 
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[i],
 			input ? snd_soc_dapm_input : snd_soc_dapm_output,
-			wid, widget_name, NULL, NULL, 0, NULL, 0);
+			wid, widget_name, NULL, NULL, 0,
+			hdac_generic_pin_io_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
 	if (ret < 0)
 		return ret;
 
@@ -645,7 +951,8 @@ static int hdac_codec_alloc_pin_widget(struct snd_soc_dapm_context *dapm,
 	sprintf(widget_name, "Pin %x PGA", wid->nid);
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[i],
 			snd_soc_dapm_pga, wid, widget_name, NULL,
-			NULL, 0, NULL, 0);
+			NULL, 0, hdac_generic_pin_pga_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
 	if (ret < 0)
 		return ret;
 
@@ -657,6 +964,15 @@ static int hdac_codec_alloc_pin_widget(struct snd_soc_dapm_context *dapm,
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
@@ -678,7 +994,8 @@ static int hdac_codec_alloc_power_widget(struct snd_soc_dapm_context *dapm,
 	sprintf(widget_name, "Power %x", wid->nid);
 	ret = hdac_generic_fill_widget_info(dapm->dev, &widgets[index],
 			snd_soc_dapm_supply, wid, widget_name,
-			NULL, NULL, 0, NULL, 0);
+			NULL, NULL, 0, hdac_generic_widget_power_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/codecs/hdac_generic.h b/sound/soc/codecs/hdac_generic.h
index 5ca713a..a938b50 100644
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
