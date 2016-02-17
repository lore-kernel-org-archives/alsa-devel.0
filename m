From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v7 2/9] ASoC: hdac_hdmi: Don't fail in dai
	startup to make userland happy
Date: Wed, 17 Feb 2016 21:34:00 +0530
Message-ID: <1455725047-7303-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D1F9726070F
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 17:03:40 +0100 (CET)
In-Reply-To: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
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

In dai startup, driver was checking for ELD and would fail if no
monitor is connected. This causes userland like PA, CRAS to be
unhappy as they scan the device list at bootup.

So move the ELD check to hw_params and fail if valid ELD is not
found.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 48 ++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index d2a2e18..f12af62 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -398,10 +398,20 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)
 {
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
+	struct hdac_hdmi_priv *hdmi = hdac->private_data;
+	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_hdmi_pin *pin;
 	struct hdac_ext_dma_params *dd;
 
-	if (dai->id > 0) {
-		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
+	dai_map = &hdmi->dai_map[dai->id];
+	pin = dai_map->pin;
+
+	if (!pin)
+		return -ENODEV;
+
+	if ((!pin->eld.monitor_present) || (!pin->eld.eld_valid)) {
+		dev_err(&hdac->hdac.dev, "device is not configured for this pin: %d\n",
+								pin->nid);
 		return -ENODEV;
 	}
 
@@ -431,11 +441,6 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
-				AC_VERB_SET_CHANNEL_STREAMID, 0);
-	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
-				AC_VERB_SET_STREAM_FORMAT, 0);
-
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
 
 	if (dd) {
@@ -536,6 +541,11 @@ static struct hdac_hdmi_pin *hdac_hdmi_get_pin_from_cvt(
 	return NULL;
 }
 
+/*
+ * This tries to get a valid pin and set the HW constraints based on the
+ * ELD. Even if a valid pin is not found return success so that device open
+ * doesn't fail.
+ */
 static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
@@ -550,17 +560,22 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	cvt = dai_map->cvt;
 	pin = hdac_hdmi_get_pin_from_cvt(hdac, hdmi, cvt);
+
+	/*
+	 * To make PA and other userland happy.
+	 * userland scans devices so returning error does not help.
+	 */
 	if (!pin)
-		return -EIO;
+		return 0;
 
 	if ((!pin->eld.monitor_present) ||
 			(!pin->eld.eld_valid)) {
 
-		dev_err(&hdac->hdac.dev,
+		dev_warn(&hdac->hdac.dev,
 			"Failed: montior present? %d ELD valid?: %d for pin: %d\n",
 			pin->eld.monitor_present, pin->eld.eld_valid, pin->nid);
 
-		return -ENODEV;
+		return 0;
 	}
 
 	dai_map->pin = pin;
@@ -587,12 +602,19 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
+	if (dai_map->pin) {
+		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
+				AC_VERB_SET_CHANNEL_STREAMID, 0);
+		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
+				AC_VERB_SET_STREAM_FORMAT, 0);
+
+		hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
 
-	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
+		snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-	dai_map->pin = NULL;
+		dai_map->pin = NULL;
+	}
 }
 
 static int
-- 
1.9.1
