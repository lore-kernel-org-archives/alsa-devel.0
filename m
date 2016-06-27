From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 11/11] ASoC: hdac: Export API to create machine
	controls
Date: Mon, 27 Jun 2016 09:18:04 +0530
Message-ID: <1466999284-14782-12-git-send-email-subhransu.s.prusty@intel.com>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E4D4C266570
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:58 +0200 (CEST)
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

The default configuration of pin complex is queried and machine
controls are created.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_generic.c | 145 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_generic.h |   3 +
 2 files changed, 148 insertions(+)

diff --git a/sound/soc/codecs/hdac_generic.c b/sound/soc/codecs/hdac_generic.c
index 32f8736..2630a83 100644
--- a/sound/soc/codecs/hdac_generic.c
+++ b/sound/soc/codecs/hdac_generic.c
@@ -580,6 +580,151 @@ static int hdac_generic_fill_widget_info(struct device *dev,
 	return 0;
 }
 
+static int hdac_generic_add_machine_control(struct snd_soc_dapm_context *dapm,
+				enum snd_soc_dapm_type id, const char *name,
+				struct hdac_codec_widget *wid)
+{
+	struct snd_soc_dapm_widget **wid_ref;
+	struct snd_soc_dapm_widget *dapm_w;
+	struct snd_soc_dapm_route route;
+	int ret;
+
+	dapm_w = devm_kzalloc(dapm->dev, sizeof(*dapm_w), GFP_KERNEL);
+	ret = hdac_generic_fill_widget_info(dapm->dev, dapm_w,
+				id, NULL, name,
+				NULL, NULL, 0, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	wid_ref = wid->priv;
+
+	snd_soc_dapm_new_control(dapm, dapm_w);
+	route.sink = dapm_w->name;
+	route.control = NULL;
+	route.source = wid_ref[0]->name;
+	route.connected = NULL;
+	snd_soc_dapm_add_route_single(dapm, &route);
+	snd_soc_dapm_new_widgets(dapm->card);
+
+	return 0;
+}
+
+/**
+ * hdac_generic_machine_control_init - Add machine widgets and graph
+ * @dapm: machine dapm context
+ * @codec: codec object
+ * @device: pcm device
+ *
+ * Reads the default configuration parameters and builds the machine
+ * controls and graph.
+ */
+int hdac_generic_machine_control_init(struct snd_soc_dapm_context *dapm,
+		struct snd_soc_codec *codec, int device)
+{
+	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct hdac_codec_widget *wid;
+	struct snd_soc_dapm_widget **wid_ref;
+	unsigned int *cfg;
+	short dev;
+	int ret;
+
+	list_for_each_entry(wid, &edev->hdac.widget_list, head) {
+		if (wid->type == AC_WID_PIN)
+			continue;
+
+		cfg = wid->params;
+		dev = get_defcfg_device(*cfg);
+
+		if (is_input_pin(&edev->hdac, wid->nid) &&
+				((dev == AC_JACK_LINE_OUT) ||
+				(dev == AC_JACK_SPEAKER) ||
+				(dev == AC_JACK_DIG_OTHER_OUT) ||
+				(dev == AC_JACK_HP_OUT) ||
+				(dev == AC_JACK_SPDIF_OUT))) {
+
+			dev_warn(dapm->dev,
+				"Wrong pin and dev configuration, nid: %d\n",
+				wid->nid);
+
+			continue;
+		}
+
+		switch (dev) {
+		case AC_JACK_LINE_OUT:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_line, "Lineout", wid);
+			if (ret < 0)
+				return ret;
+			break;
+		case AC_JACK_SPEAKER:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_spk, "spk", wid);
+			if (ret < 0)
+				return ret;
+			break;
+		case AC_JACK_SPDIF_OUT:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_spk, "spdif_out", wid);
+			if (ret < 0)
+				return ret;
+			break;
+		case AC_JACK_DIG_OTHER_OUT:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_spk, "dig_other_out", wid);
+			if (ret < 0)
+				return ret;
+			break;
+
+		case AC_JACK_HP_OUT:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_hp, "hp", wid);
+			if (ret < 0)
+				return ret;
+			break;
+
+		case AC_JACK_AUX:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_line, "Aux", wid);
+			if (ret < 0)
+				return ret;
+			break;
+		case AC_JACK_LINE_IN:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_line, "Linein", wid);
+			if (ret < 0)
+				return ret;
+			break;
+
+		case AC_JACK_MIC_IN:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_mic, "MIC", wid);
+			if (ret < 0)
+				return ret;
+			break;
+		case AC_JACK_SPDIF_IN:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_mic, "spdif_in", wid);
+			if (ret < 0)
+				return ret;
+			break;
+		case AC_JACK_DIG_OTHER_IN:
+			ret = hdac_generic_add_machine_control(dapm,
+					snd_soc_dapm_mic, "dig_other_in", wid);
+			if (ret < 0)
+				return ret;
+			break;
+
+		default:
+			wid_ref = wid->priv;
+			snd_soc_dapm_nc_pin(dapm, wid_ref[0]->name);
+			break;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hdac_generic_machine_control_init);
+
 static int hdac_generic_alloc_mux_widget(struct snd_soc_dapm_context *dapm,
 		struct snd_soc_dapm_widget *widgets, int index,
 		struct hdac_codec_widget *wid)
diff --git a/sound/soc/codecs/hdac_generic.h b/sound/soc/codecs/hdac_generic.h
index c52dc7c..cf55d0a 100644
--- a/sound/soc/codecs/hdac_generic.h
+++ b/sound/soc/codecs/hdac_generic.h
@@ -25,4 +25,7 @@
 #define AMP_OUT_UNMUTE		0xb000
 #define PIN_OUT			(AC_PINCTL_OUT_EN)
 
+int hdac_generic_machine_control_init(struct snd_soc_dapm_context *dapm,
+			struct snd_soc_codec *codec, int device);
+
 #endif /* __HDAC_GENERIC_H__ */
-- 
1.9.1
