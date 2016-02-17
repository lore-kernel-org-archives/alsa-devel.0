From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v7 4/9] ASoC: hdac_hdmi: Fix to reconfigure
	registers in runtime resume
Date: Wed, 17 Feb 2016 21:34:02 +0530
Message-ID: <1455725047-7303-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 63E68265A10
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 17:03:44 +0100 (CET)
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

The register are reset during the D3 to D0 transition. So
reconfigure them.

Also as all DAIs are now supported, remove the dai id check in prepare.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 57ab212..2445b43 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -374,11 +374,6 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	struct hdac_ext_dma_params *dd;
 	int ret;
 
-	if (dai->id > 0) {
-		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
-		return -ENODEV;
-	}
-
 	dai_map = &hdmi->dai_map[dai->id];
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
@@ -451,6 +446,18 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
+		struct hdac_hdmi_dai_pin_map *dai_map)
+{
+	/* Enable transmission */
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+			AC_VERB_SET_DIGI_CONVERT_1, 1);
+
+	/* Category Code (CC) to zero */
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+			AC_VERB_SET_DIGI_CONVERT_2, 0);
+}
+
 static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
 		struct hdac_hdmi_dai_pin_map *dai_map)
 {
@@ -580,6 +587,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	dai_map->pin = pin;
 
+	hdac_hdmi_enable_cvt(hdac, dai_map);
 	ret = hdac_hdmi_enable_pin(hdac, dai_map);
 	if (ret < 0)
 		return ret;
@@ -949,14 +957,6 @@ static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
 		dai_map->dai_id = dai_id;
 		dai_map->cvt = cvt;
 
-		/* Enable transmission */
-		snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
-				AC_VERB_SET_DIGI_CONVERT_1, 1);
-
-		/* Category Code (CC) to zero */
-		snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
-				AC_VERB_SET_DIGI_CONVERT_2, 0);
-
 		dai_id++;
 
 		if (dai_id == HDA_MAX_CVTS) {
@@ -1527,6 +1527,9 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 		return err;
 	}
 
+	hdac_hdmi_skl_enable_all_pins(&edev->hdac);
+	hdac_hdmi_skl_enable_dp12(&edev->hdac);
+
 	/* Power up afg */
 	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0))
 		snd_hdac_codec_write(hdac, hdac->afg, 0,
-- 
1.9.1
