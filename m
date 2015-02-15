From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl-asoc-card: Add snd_soc_of_parse_audio_routing()
Date: Sat, 14 Feb 2015 17:22:50 -0800
Message-ID: <5f668d5949ffb3237041cdd28304d5deb2331b15.1423963314.git.nicoleotsuka@gmail.com>
References: <15b0ecaefffcd48bb5f56fe76326d705c3467438.1423963314.git.nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15b0ecaefffcd48bb5f56fe76326d705c3467438.1423963314.git.nicoleotsuka@gmail.com>
In-Reply-To: <15b0ecaefffcd48bb5f56fe76326d705c3467438.1423963314.git.nicoleotsuka@gmail.com>
References: <15b0ecaefffcd48bb5f56fe76326d705c3467438.1423963314.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds snd_soc_of_parse_audio_routing() to get dapm routes
configurations via Device Tree.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 3f6959c..de43887 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -512,6 +512,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
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
