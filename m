From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl-asoc-card: Add snd_soc_of_parse_audio_routing()
Date: Thu, 12 Feb 2015 13:30:02 -0800
Message-ID: <1423776602-28585-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds snd_soc_of_parse_audio_routing() to get dapm routes
via Device Tree. Because snd_soc_of_parse_audio_routing() overrides
dpam_routes, we use snd_soc_dapm_add_routes() to append the original
build-in DPCM routes instead of linking them to dpam_routes directly.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 3f6959c..bdc9671 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -388,6 +388,8 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 	struct device *dev = card->dev;
 	int ret;
 
+	snd_soc_dapm_add_routes(&card->dapm, audio_map, ARRAY_SIZE(audio_map));
+
 	ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
 				     codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
 	if (ret) {
@@ -503,15 +505,19 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->card.dev = &pdev->dev;
 	priv->card.name = priv->name;
 	priv->card.dai_link = priv->dai_link;
-	priv->card.dapm_routes = audio_map;
 	priv->card.late_probe = fsl_asoc_card_late_probe;
-	priv->card.num_dapm_routes = ARRAY_SIZE(audio_map);
 	priv->card.dapm_widgets = fsl_asoc_card_dapm_widgets;
 	priv->card.num_dapm_widgets = ARRAY_SIZE(fsl_asoc_card_dapm_widgets);
 
 	memcpy(priv->dai_link, fsl_asoc_card_dai,
 	       sizeof(struct snd_soc_dai_link) * ARRAY_SIZE(priv->dai_link));
 
+	ret = snd_soc_of_parse_audio_routing(&priv->card, "audio-routing");
+	if (ret) {
+		dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
+		goto asrc_fail;
+	}
+
 	/* Normal DAI Link */
 	priv->dai_link[0].cpu_of_node = cpu_np;
 	priv->dai_link[0].codec_of_node = codec_np;
-- 
1.9.1
