From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: Update
	skl_nau88l25_ssm4567 driver to support chmap" to the asoc tree
Date: Thu, 28 Apr 2016 18:55:17 +0100
Message-ID: <E1avq9l-0002zN-Rv@debutante>
References: <1460454977-30057-7-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C0B92661B9
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 19:55:22 +0200 (CEST)
In-Reply-To: <1460454977-30057-7-git-send-email-subhransu.s.prusty@intel.com>
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

   ASoC: Intel: boards: Update skl_nau88l25_ssm4567 driver to support chmap

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

>From 46ed1a27fb44febb2c362fc30fcb51e8eed06e3a Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 14 Apr 2016 10:07:33 +0530
Subject: [PATCH] ASoC: Intel: boards: Update skl_nau88l25_ssm4567 driver to
 support chmap

HDMI registers channel map controls per PCM. As PCMs are not
registered during dai_link init callback, store the pcm ids and
codec DAIs during this init callback.

Register for late probe and call the jack_init API which also
registers channel map in the late probe callback handler.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 73 +++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 5f1ca99ae9b0..bde85bf989b8 100644
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
2.8.0.rc3
