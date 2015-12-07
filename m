From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 15/15] ASoC: hdac_hdmi: Fix to enable device
	configuration in hw_params
Date: Tue,  8 Dec 2015 02:54:29 +0530
Message-ID: <1449523469-4395-15-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E446B265A21
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 16:54:34 +0100 (CET)
In-Reply-To: <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
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

User can keep the device open and with the device configuration
done in pcm_open, this may fail. Anyway hw_params is the right
place for this. So moving the configuration to hw_params and free
in hw_free. Remove the redundant startup/shutdown ops.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 100 ++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 58 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index cce2af0..cb34c6a 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -377,52 +377,6 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 			dai_map->pin->nid, dd->stream_tag, dd->format);
 }
 
-static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)
-{
-	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
-	struct hdac_ext_dma_params *dd;
-
-	if (dai->id > 0) {
-		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
-		return -ENODEV;
-	}
-
-	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
-	if (!dd)
-		return -ENOMEM;
-	dd->format = snd_hdac_calc_stream_format(params_rate(hparams),
-			params_channels(hparams), params_format(hparams),
-			24, 0);
-
-	snd_soc_dai_set_dma_data(dai, substream, (void *)dd);
-
-	return 0;
-}
-
-static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
-	struct hdac_ext_dma_params *dd;
-	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
-
-	dai_map = &hdmi->dai_map[dai->id];
-
-	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
-				AC_VERB_SET_CHANNEL_STREAMID, 0);
-	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
-				AC_VERB_SET_STREAM_FORMAT, 0);
-
-	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
-
-	kfree(dd);
-
-	return 0;
-}
-
 static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
 		struct hdac_hdmi_dai_pin_map *dai_map)
 {
@@ -534,8 +488,8 @@ static struct hdac_hdmi_pin *hdac_hdmi_get_pin_from_daistream(
 	return NULL;
 }
 
-static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
-			struct snd_soc_dai *dai)
+static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)
 {
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
@@ -543,6 +497,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	struct hdac_hdmi_cvt *cvt;
 	struct hdac_hdmi_pin *pin;
 	int ret;
+	struct hdac_ext_dma_params *dd;
 
 	if (dai->id > 0) {
 		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
@@ -575,25 +530,56 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	return snd_pcm_hw_constraint_eld(substream->runtime,
-				pin->eld.eld_buffer);
+	ret = snd_pcm_hw_constraint_eld(substream->runtime,
+			dai_map->pin->eld.eld_buffer);
+
+	if (ret < 0)
+		return ret;
+
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+	if (!dd)
+		return -ENOMEM;
+	dd->format = snd_hdac_calc_stream_format(params_rate(hparams),
+			params_channels(hparams), params_format(hparams),
+			24, 0);
+
+	snd_soc_dai_set_dma_data(dai, substream, (void *)dd);
+
+	return 0;
 }
 
-static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
+static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
-	struct hdac_hdmi_priv *hdmi = hdac->private_data;
+	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
+	struct hdac_ext_dma_params *dd;
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_dai_pin_map *dai_map;
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
+	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
 
-	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
+	if (dd) {
+		snd_soc_dai_set_dma_data(dai, substream, NULL);
+		kfree(dd);
+	}
+
+	if (dai_map->pin) {
+		snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+				AC_VERB_SET_CHANNEL_STREAMID, 0);
+		snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+				AC_VERB_SET_STREAM_FORMAT, 0);
+
+		hdac_hdmi_set_power_state(edev, dai_map, AC_PWRST_D3);
+
+		snd_hdac_codec_write(&edev->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-	dai_map->pin = NULL;
+		dai_map->pin = NULL;
+	}
+
+	return 0;
 }
 
 static int
@@ -1014,8 +1000,6 @@ static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdac)
 }
 
 static struct snd_soc_dai_ops hdmi_dai_ops = {
-	.startup = hdac_hdmi_pcm_open,
-	.shutdown = hdac_hdmi_pcm_close,
 	.hw_params = hdac_hdmi_set_hw_params,
 	.prepare = hdac_hdmi_playback_prepare,
 	.hw_free = hdac_hdmi_playback_cleanup,
-- 
1.9.1
