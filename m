From: jeeja.kp@intel.com
Subject: [PATCH 05/30] ASoC: Intel: bxt: add channel map
	support in rt298 machine
Date: Mon, 16 Jan 2017 23:27:32 +0530
Message-ID: <1484589477-7630-6-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DFEF2670FA
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:47:12 +0100 (CET)
In-Reply-To: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

HDMI registers channel map controls per pcm. As PCMs are not
registered during dai_link init callback, store the pcm ids and
codec DAIs during this init callback.

Register for late probe and call the jack_init API which registers
channel map in the late probe callback handler.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 52 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 1309405..bc9ee09 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -26,8 +26,18 @@
 #include "../../codecs/hdac_hdmi.h"
 #include "../../codecs/rt298.h"
 
-static struct snd_soc_jack broxton_headset;
 /* Headset jack detection DAPM pins */
+static struct snd_soc_jack broxton_headset;
+
+struct bxt_hdmi_pcm {
+	struct list_head head;
+	struct snd_soc_dai *codec_dai;
+	int device;
+};
+
+struct bxt_rt286_private {
+	struct list_head hdmi_pcm_list;
+};
 
 enum {
 	BXT_DPCM_AUDIO_PB = 0,
@@ -139,9 +149,20 @@ static int broxton_rt298_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 static int broxton_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct bxt_rt286_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct bxt_hdmi_pcm *pcm;
 
-	return hdac_hdmi_jack_init(dai, BXT_DPCM_AUDIO_HDMI1_PB + dai->id);
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
+	pcm->device = BXT_DPCM_AUDIO_HDMI1_PB + dai->id;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
 }
 
 static int broxton_ssp5_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -432,6 +453,22 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 	},
 };
 
+static int bxt_card_late_probe(struct snd_soc_card *card)
+{
+	struct bxt_rt286_private *ctx = snd_soc_card_get_drvdata(card);
+	struct bxt_hdmi_pcm *pcm;
+	int err;
+
+	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+
 /* broxton audio machine driver for SPT + RT298S */
 static struct snd_soc_card broxton_rt298 = {
 	.name = "broxton-rt298",
@@ -445,11 +482,22 @@ static struct snd_soc_card broxton_rt298 = {
 	.dapm_routes = broxton_rt298_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
 	.fully_routed = true,
+	.late_probe = bxt_card_late_probe,
+
 };
 
 static int broxton_audio_probe(struct platform_device *pdev)
 {
+	struct bxt_rt286_private *ctx;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+
 	broxton_rt298.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&broxton_rt298, ctx);
 
 	return devm_snd_soc_register_card(&pdev->dev, &broxton_rt298);
 }
-- 
2.5.0
