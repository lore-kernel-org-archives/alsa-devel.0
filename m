From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v5 06/14] ASoC: hdac_hdmi: Add jack reporting
Date: Sat, 30 Jan 2016 19:13:40 +0530
Message-ID: <1454161428-7896-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1454161428-7896-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AF0D2605B6
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2016 14:42:29 +0100 (CET)
In-Reply-To: <1454161428-7896-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Jack is created based on pcm devices enumerated, so we will
create Jack as "HDMI/DP, pcm=x Jack". This style is expected by
current usermode like PulseAudio and CRAS.

This patch exports an API which can be used to register Jack
based on PCM. This API also establishes the map between PCM and
cvt. Further cvt to pin mapping is established with the help of
usermode selection based on the board topology.

During device probe as the PCMs may not be registered, initial
pin sense don't report jack events. So, first time jack reporting
is done during user selection of mux control.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 160 ++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/hdac_hdmi.h |   6 ++
 2 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hdmi.h

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 64aa457..f93aee0 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -24,11 +24,13 @@
 #include <linux/hdmi.h>
 #include <drm/drm_edid.h>
 #include <sound/pcm_params.h>
+#include <sound/jack.h>
 #include <sound/soc.h>
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_i915.h>
 #include <sound/pcm_drm_eld.h>
 #include "../../hda/local.h"
+#include "hdac_hdmi.h"
 
 #define NAME_SIZE	32
 
@@ -52,6 +54,7 @@ struct hdac_hdmi_cvt_params {
 struct hdac_hdmi_cvt {
 	struct list_head head;
 	hda_nid_t nid;
+	const char *name;
 	struct hdac_hdmi_cvt_params params;
 };
 
@@ -73,6 +76,14 @@ struct hdac_hdmi_pin {
 	struct delayed_work work;
 };
 
+struct hdac_hdmi_pcm {
+	struct list_head head;
+	int pcm_id;
+	struct hdac_hdmi_pin *pin;
+	struct hdac_hdmi_cvt *cvt;
+	struct snd_jack *jack;
+};
+
 struct hdac_hdmi_dai_pin_map {
 	int dai_id;
 	struct hdac_hdmi_pin *pin;
@@ -83,8 +94,10 @@ struct hdac_hdmi_priv {
 	struct hdac_hdmi_dai_pin_map dai_map[3];
 	struct list_head pin_list;
 	struct list_head cvt_list;
+	struct list_head pcm_list;
 	int num_pin;
 	int num_cvt;
+	struct mutex pin_mutex;
 };
 
 static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
@@ -477,6 +490,67 @@ static void hdac_hdmi_fill_route(struct snd_soc_dapm_route *route,
 	route->connected = handler;
 }
 
+static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
+					struct hdac_hdmi_pin *pin)
+{
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pcm *pcm = NULL;
+
+	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
+		if (pcm->pin == pin)
+			return pcm;
+	}
+
+	return NULL;
+}
+
+/*
+ * Based on user selection, map the PINs with the PCMs.
+ */
+static int hdac_hdmi_set_pin_mux(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	int ret;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct hdac_hdmi_pin *pin = w->priv;
+	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pcm *pcm = NULL;
+	const char *cvt_name =  e->texts[ucontrol->value.enumerated.item[0]];
+
+	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&hdmi->pin_mutex);
+	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
+		if (pcm->pin == pin)
+			pcm->pin = NULL;
+
+		/*
+		 * Jack status is not reported during device probe as the
+		 * PCMs are not registered by then. So report it here.
+		 */
+		if (!strcmp(cvt_name, pcm->cvt->name) && !pcm->pin) {
+			pcm->pin = pin;
+			if (pin->eld.monitor_present && pin->eld.eld_valid) {
+				dev_dbg(&edev->hdac.dev,
+					"jack report for pcm=%d\n",
+					pcm->pcm_id);
+
+				snd_jack_report(pcm->jack, SND_JACK_AVOUT);
+			}
+			mutex_unlock(&hdmi->pin_mutex);
+			return ret;
+		}
+	}
+	mutex_unlock(&hdmi->pin_mutex);
+
+	return ret;
+}
+
 /*
  * Ideally the Mux inputs should be based on the num_muxs enumerated, but
  * the display driver seem to be programming the connection list for the pin
@@ -519,7 +593,7 @@ static int hdac_hdmi_create_pin_muxs(struct hdac_ext_device *edev,
 	kc->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	kc->access = 0;
 	kc->info = snd_soc_info_enum_double;
-	kc->put = snd_soc_dapm_put_enum_double;
+	kc->put = hdac_hdmi_set_pin_mux;
 	kc->get = snd_soc_dapm_get_enum_double;
 
 	se->reg = SND_SOC_NOPM;
@@ -547,8 +621,7 @@ static int hdac_hdmi_create_pin_muxs(struct hdac_ext_device *edev,
 		return -ENOMEM;
 
 	return hdac_hdmi_fill_widget_info(&edev->hdac.dev, widget,
-			snd_soc_dapm_mux, &pin->nid, widget_name,
-			NULL, kc, 1);
+			snd_soc_dapm_mux, pin, widget_name, NULL, kc, 1);
 }
 
 /* Add cvt <- input <- mux route map */
@@ -727,12 +800,15 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
 {
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_cvt *cvt;
+	char name[NAME_SIZE];
 
 	cvt = kzalloc(sizeof(*cvt), GFP_KERNEL);
 	if (!cvt)
 		return -ENOMEM;
 
 	cvt->nid = nid;
+	sprintf(name, "cvt %d", cvt->nid);
+	cvt->name = kstrdup(name, GFP_KERNEL);
 
 	list_add_tail(&cvt->head, &hdmi->cvt_list);
 	hdmi->num_cvt++;
@@ -743,6 +819,8 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
 static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 {
 	struct hdac_ext_device *edev = pin->edev;
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pcm *pcm;
 	int val;
 
 	if (!edev)
@@ -757,13 +835,31 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 	dev_dbg(&edev->hdac.dev, "Pin sense val %x for pin: %d\n",
 						val, pin->nid);
 
+
+	mutex_lock(&hdmi->pin_mutex);
 	pin->eld.monitor_present = !!(val & AC_PINSENSE_PRESENCE);
 	pin->eld.eld_valid = !!(val & AC_PINSENSE_ELDV);
 
+	pcm = hdac_hdmi_get_pcm(edev, pin);
+
 	if (!pin->eld.monitor_present || !pin->eld.eld_valid) {
 
 		dev_info(&edev->hdac.dev, "%s: disconnect for pin %d\n",
 						__func__, pin->nid);
+
+		/*
+		 * PCMs are not registered during device probe, so don't
+		 * report jack here. It will be done in usermode mux
+		 * control select.
+		 */
+		if (pcm) {
+			dev_dbg(&edev->hdac.dev,
+				"jack report for pcm=%d\n", pcm->pcm_id);
+
+			snd_jack_report(pcm->jack, 0);
+		}
+
+		mutex_unlock(&hdmi->pin_mutex);
 		goto put_hdac_device;
 	}
 
@@ -773,15 +869,33 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 				pin->eld.eld_buffer,
 				&pin->eld.eld_size) == 0) {
 
+			if (pcm) {
+				dev_dbg(&edev->hdac.dev,
+					"jack report for pcm=%d\n",
+					pcm->pcm_id);
+
+				snd_jack_report(pcm->jack, SND_JACK_AVOUT);
+			}
+
 			print_hex_dump_bytes("Eld: ", DUMP_PREFIX_OFFSET,
 					pin->eld.eld_buffer, pin->eld.eld_size);
 		} else {
 			dev_err(&edev->hdac.dev, "ELD invalid\n");
 			pin->eld.monitor_present = false;
 			pin->eld.eld_valid = false;
+
+			if (pcm) {
+				dev_dbg(&edev->hdac.dev,
+					"jack report for pcm=%d\n",
+					pcm->pcm_id);
+
+				snd_jack_report(pcm->jack, 0);
+			}
 		}
 	}
 
+	mutex_unlock(&hdmi->pin_mutex);
+
 	/*
 	 * Sometimes the pin_sense may present invalid monitor
 	 * present and eld_valid. If eld data is not valid loop, few
@@ -1039,6 +1153,35 @@ static struct i915_audio_component_audio_ops aops = {
 	.pin_eld_notify	= hdac_hdmi_eld_notify_cb,
 };
 
+int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
+{
+	char jack_name[NAME_SIZE];
+	struct snd_soc_codec *codec = dai->codec;
+	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(&codec->component);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pcm *pcm;
+
+	/*
+	 * this is a new PCM device, create new pcm and
+	 * add to the pcm list
+	 */
+	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+	pcm->pcm_id = device;
+	pcm->cvt = hdmi->dai_map[dai->id].cvt;
+
+	list_add_tail(&pcm->head, &hdmi->pcm_list);
+
+	sprintf(jack_name, "HDMI/DP, pcm=%d Jack", device);
+
+	return snd_jack_new(dapm->card->snd_card, jack_name,
+		SND_JACK_AVOUT,	&pcm->jack, true, false);
+}
+EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
+
 static int hdmi_codec_probe(struct snd_soc_codec *codec)
 {
 	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
@@ -1111,6 +1254,8 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 
 	INIT_LIST_HEAD(&hdmi_priv->pin_list);
 	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
+	INIT_LIST_HEAD(&hdmi_priv->pcm_list);
+	mutex_init(&hdmi_priv->pin_mutex);
 
 	ret = hdac_hdmi_parse_and_map_nid(edev, &hdmi_dais, &num_dais);
 	if (ret < 0) {
@@ -1129,11 +1274,20 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pin *pin, *pin_next;
 	struct hdac_hdmi_cvt *cvt, *cvt_next;
+	struct hdac_hdmi_pcm *pcm, *pcm_next;
 
 	snd_soc_unregister_codec(&edev->hdac.dev);
 
+	list_for_each_entry_safe(pcm, pcm_next, &hdmi->pcm_list, head) {
+		pcm->cvt = NULL;
+		pcm->pin = NULL;
+		list_del(&pcm->head);
+		kfree(pcm);
+	}
+
 	list_for_each_entry_safe(cvt, cvt_next, &hdmi->cvt_list, head) {
 		list_del(&cvt->head);
+		kfree(cvt->name);
 		kfree(cvt);
 	}
 
diff --git a/sound/soc/codecs/hdac_hdmi.h b/sound/soc/codecs/hdac_hdmi.h
new file mode 100644
index 0000000..8dfd1e0
--- /dev/null
+++ b/sound/soc/codecs/hdac_hdmi.h
@@ -0,0 +1,6 @@
+#ifndef __HDAC_HDMI_H__
+#define __HDAC_HDMI_H__
+
+int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm);
+
+#endif /* __HDAC_HDMI_H__ */
-- 
1.9.1
