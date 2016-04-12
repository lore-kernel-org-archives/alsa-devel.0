From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 09/11] ASoC: hdac_hdmi: Register chmap controls
	and ops
Date: Tue, 12 Apr 2016 10:31:31 +0530
Message-ID: <1460437293-8509-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 74665265AB2
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 07:02:49 +0200 (CEST)
In-Reply-To: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
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

With this patch, chmap controls are created and user space can
set the channel map.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 100 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index a2f949c..b7c1125 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -114,6 +114,19 @@ struct hdac_hdmi_priv {
 	struct hdac_chmap chmap;
 };
 
+static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
+						int pcm_idx)
+{
+	struct hdac_hdmi_pcm *pcm;
+
+	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
+		if (pcm->pcm_id == pcm_idx)
+			return pcm;
+	}
+
+	return NULL;
+}
+
 static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
 {
 	struct hdac_device *hdac = dev_to_hdac_dev(dev);
@@ -664,6 +677,8 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
 		mutex_lock(&dai_map->pin->lock);
+		dai_map->pin->chmap_set = false;
+		memset(dai_map->pin->chmap, 0, sizeof(dai_map->pin->chmap));
 		dai_map->pin->channels = 0;
 		mutex_unlock(&dai_map->pin->lock);
 
@@ -1388,6 +1403,19 @@ static struct i915_audio_component_audio_ops aops = {
 	.pin_eld_notify	= hdac_hdmi_eld_notify_cb,
 };
 
+static struct snd_pcm *hdac_hdmi_get_pcm_from_id(struct snd_soc_card *card,
+						int device)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (rtd->pcm && (rtd->pcm->device == device))
+			return rtd->pcm;
+	}
+
+	return NULL;
+}
+
 int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 {
 	char jack_name[NAME_SIZE];
@@ -1397,6 +1425,8 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 		snd_soc_component_get_dapm(&codec->component);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm;
+	struct snd_pcm *snd_pcm;
+	int err;
 
 	/*
 	 * this is a new PCM device, create new pcm and
@@ -1408,6 +1438,18 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 	pcm->pcm_id = device;
 	pcm->cvt = hdmi->dai_map[dai->id].cvt;
 
+	snd_pcm = hdac_hdmi_get_pcm_from_id(dai->component->card, device);
+	if (snd_pcm) {
+		err = snd_hdac_add_chmap_ctls(snd_pcm, device, &hdmi->chmap);
+		if (err < 0) {
+			dev_err(&edev->hdac.dev,
+				"chmap control add failed with err: %d for pcm: %d\n",
+				err, device);
+			kfree(pcm);
+			return err;
+		}
+	}
+
 	list_add_tail(&pcm->head, &hdmi->pcm_list);
 
 	sprintf(jack_name, "HDMI/DP, pcm=%d Jack", device);
@@ -1521,6 +1563,60 @@ static struct snd_soc_codec_driver hdmi_hda_codec = {
 	.idle_bias_off	= true,
 };
 
+static void hdac_hdmi_get_chmap(struct hdac_device *hdac, int pcm_idx,
+					unsigned char *chmap)
+{
+	struct hdac_ext_device *edev = to_ehdac_device(hdac);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
+	struct hdac_hdmi_pin *pin = pcm->pin;
+
+	/* chmap is already set to 0 in caller */
+	if (!pin)
+		return;
+
+	memcpy(chmap, pin->chmap, ARRAY_SIZE(pin->chmap));
+}
+
+static void hdac_hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
+				unsigned char *chmap, int prepared)
+{
+	struct hdac_ext_device *edev = to_ehdac_device(hdac);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
+	struct hdac_hdmi_pin *pin = pcm->pin;
+
+	mutex_lock(&pin->lock);
+	pin->chmap_set = true;
+	memcpy(pin->chmap, chmap, ARRAY_SIZE(pin->chmap));
+	if (prepared)
+		hdac_hdmi_setup_audio_infoframe(edev, pcm->cvt->nid, pin->nid);
+	mutex_unlock(&pin->lock);
+}
+
+static bool is_hdac_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
+{
+	struct hdac_ext_device *edev = to_ehdac_device(hdac);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
+	struct hdac_hdmi_pin *pin = pcm->pin;
+
+	return pin ? true:false;
+}
+
+static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
+{
+	struct hdac_ext_device *edev = to_ehdac_device(hdac);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
+	struct hdac_hdmi_pin *pin = pcm->pin;
+
+	if (!pin && !pin->eld.eld_valid)
+		return 0;
+
+	return pin->eld.info.spk_alloc;
+}
+
 static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 {
 	struct hdac_device *codec = &edev->hdac;
@@ -1535,6 +1631,10 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 
 	edev->private_data = hdmi_priv;
 	snd_hdac_register_chmap_ops(codec, &hdmi_priv->chmap);
+	hdmi_priv->chmap.ops.get_chmap = hdac_hdmi_get_chmap;
+	hdmi_priv->chmap.ops.set_chmap = hdac_hdmi_set_chmap;
+	hdmi_priv->chmap.ops.is_pcm_attached = is_hdac_hdmi_pcm_attached;
+	hdmi_priv->chmap.ops.get_spk_alloc = hdac_hdmi_get_spk_alloc;
 
 	dev_set_drvdata(&codec->dev, edev);
 
-- 
1.9.1
