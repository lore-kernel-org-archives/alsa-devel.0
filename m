From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 6/9] ASoC: Intel: boards: Update
	skl_nau88l25_ssm4567 driver to support chmap
Date: Thu, 14 Apr 2016 10:07:33 +0530
Message-ID: <1460608656-8860-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 98534266671
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 06:38:46 +0200 (CEST)
In-Reply-To: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
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

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 73 +++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 5f1ca99..bde85bf 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -34,6 +34,15 @@
 static struct snd_soc_jack skylake_headset;
 static struct snd_soc_card skylake_audio_card;
 
+struct skl_hdmi_pcm {
+	struct list_head head;
+	struct snd_soc_dai *codec_dai;
+	int device;
+};
+
+struct skl_nau88125_private {
+	struct list_head hdmi_pcm_list;
+};
 enum {
 	SKL_DPCM_AUDIO_PB = 0,
 	SKL_DPCM_AUDIO_CP,
@@ -222,24 +231,57 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct skl_hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
+	pcm->device = SKL_DPCM_AUDIO_HDMI1_PB;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
 
-	return hdac_hdmi_jack_init(dai, SKL_DPCM_AUDIO_HDMI1_PB);
+	return 0;
 }
 
 static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct skl_hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
+	pcm->device = SKL_DPCM_AUDIO_HDMI2_PB;
+	pcm->codec_dai = dai;
 
-	return hdac_hdmi_jack_init(dai, SKL_DPCM_AUDIO_HDMI2_PB);
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
 }
 
 
 static int skylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct skl_hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
 
-	return hdac_hdmi_jack_init(dai, SKL_DPCM_AUDIO_HDMI3_PB);
+	pcm->device = SKL_DPCM_AUDIO_HDMI3_PB;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
 }
 
 static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
@@ -585,6 +627,21 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 };
 
+static int skylake_card_late_probe(struct snd_soc_card *card)
+{
+	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(card);
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
 /* skylake audio machine driver for SPT + NAU88L25 */
 static struct snd_soc_card skylake_audio_card = {
 	.name = "sklnau8825adi",
@@ -600,11 +657,21 @@ static struct snd_soc_card skylake_audio_card = {
 	.codec_conf = ssm4567_codec_conf,
 	.num_configs = ARRAY_SIZE(ssm4567_codec_conf),
 	.fully_routed = true,
+	.late_probe = skylake_card_late_probe,
 };
 
 static int skylake_audio_probe(struct platform_device *pdev)
 {
+	struct skl_nau88125_private *ctx;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+
 	skylake_audio_card.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&skylake_audio_card, ctx);
 
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
 }
-- 
1.9.1
