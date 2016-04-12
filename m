From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 06/11] ASoC: skl_rt286: Fix to support hdmi
	channel map support
Date: Tue, 12 Apr 2016 10:31:28 +0530
Message-ID: <1460437293-8509-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 088EA2659FE
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 07:02:41 +0200 (CEST)
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

HDMI registers channel map controls per PCM. As PCMs are not
registered during dai_link init callback, store the pcm ids and
codec DAIs during this init callback.

Register for late probe and call the jack_init API which also
registers channel map in the late probe callback handler.

The patch following the machine driver changes adds the channel
map control in the hdac_hdmi codec driver.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 48 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 2016397..1e13542 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -30,6 +30,16 @@
 
 static struct snd_soc_jack skylake_headset;
 
+struct skl_hdmi_pcm {
+	struct list_head head;
+	struct snd_soc_dai *codec_dai;
+	int device;
+};
+
+struct skl_rt286_private {
+	struct list_head hdmi_pcm_list;
+};
+
 enum {
 	SKL_DPCM_AUDIO_PB = 0,
 	SKL_DPCM_AUDIO_CP,
@@ -142,9 +152,20 @@ static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 static int skylake_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct skl_rt286_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct skl_hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
 
-	return hdac_hdmi_jack_init(dai, SKL_DPCM_AUDIO_HDMI1_PB + dai->id);
+	pcm->device = SKL_DPCM_AUDIO_HDMI1_PB + dai->id;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
 }
 
 static unsigned int rates[] = {
@@ -438,6 +459,21 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	},
 };
 
+int skylake_card_late_probe(struct snd_soc_card *card)
+{
+	struct skl_rt286_private *ctx = snd_soc_card_get_drvdata(card);
+	struct skl_hdmi_pcm *pcm;
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
 /* skylake audio machine driver for SPT + RT286S */
 static struct snd_soc_card skylake_rt286 = {
 	.name = "skylake-rt286",
@@ -451,11 +487,21 @@ static struct snd_soc_card skylake_rt286 = {
 	.dapm_routes = skylake_rt286_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_rt286_map),
 	.fully_routed = true,
+	.late_probe = skylake_card_late_probe,
 };
 
 static int skylake_audio_probe(struct platform_device *pdev)
 {
+	struct skl_rt286_private *ctx;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+
 	skylake_rt286.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&skylake_rt286, ctx);
 
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_rt286);
 }
-- 
1.9.1
