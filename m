From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Register chmap controls and
	ops" to the asoc tree
Date: Thu, 28 Apr 2016 18:55:14 +0100
Message-ID: <E1avq9i-0002y7-T1@debutante>
References: <1460437293-8509-10-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B9E2651A5
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 19:55:19 +0200 (CEST)
In-Reply-To: <1460437293-8509-10-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Register chmap controls and ops

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

>From 2889099eb8cd0811dc2986643d46c0b62b90eeb4 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 14 Apr 2016 10:07:34 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Register chmap controls and ops

With this patch, chmap controls are created and user space can
set the channel map.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 100 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 034593bf2cd6..0ed39753c871 100644
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
 
@@ -1386,6 +1401,19 @@ static struct i915_audio_component_audio_ops aops = {
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
@@ -1395,6 +1423,8 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 		snd_soc_component_get_dapm(&codec->component);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm;
+	struct snd_pcm *snd_pcm;
+	int err;
 
 	/*
 	 * this is a new PCM device, create new pcm and
@@ -1406,6 +1436,18 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
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
@@ -1524,6 +1566,60 @@ static struct snd_soc_codec_driver hdmi_hda_codec = {
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
@@ -1538,6 +1634,10 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 
 	edev->private_data = hdmi_priv;
 	snd_hdac_register_chmap_ops(codec, &hdmi_priv->chmap);
+	hdmi_priv->chmap.ops.get_chmap = hdac_hdmi_get_chmap;
+	hdmi_priv->chmap.ops.set_chmap = hdac_hdmi_set_chmap;
+	hdmi_priv->chmap.ops.is_pcm_attached = is_hdac_hdmi_pcm_attached;
+	hdmi_priv->chmap.ops.get_spk_alloc = hdac_hdmi_get_spk_alloc;
 
 	dev_set_drvdata(&codec->dev, edev);
 
-- 
2.8.0.rc3
