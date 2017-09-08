From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl-asoc-card: Don't error out if ENOTSUPP
Date: Thu,  7 Sep 2017 22:27:33 -0700
Message-ID: <1504848453-9524-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com, fabio.estevam@nxp.com
List-Id: alsa-devel@alsa-project.org

The snd_soc_component_set_sysclk() and snd_soc_dai_set_tdm_slot()
in the soc-core.c will return -ENOTSUPP if there is no function
implementation for them in the dai and component drivers.

So this patch tries to ignore this errno.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 2db4d0c..3772abb 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -166,7 +166,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_sysclk(rtd->cpu_dai, cpu_priv->sysclk_id[tx],
 				     cpu_priv->sysclk_freq[tx],
 				     cpu_priv->sysclk_dir[tx]);
-	if (ret) {
+	if (ret && ret != -ENOTSUPP) {
 		dev_err(dev, "failed to set sysclk for cpu dai\n");
 		return ret;
 	}
@@ -174,7 +174,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 	if (cpu_priv->slot_width) {
 		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2,
 					       cpu_priv->slot_width);
-		if (ret) {
+		if (ret && ret != -ENOTSUPP) {
 			dev_err(dev, "failed to set TDM slot for cpu dai\n");
 			return ret;
 		}
@@ -270,7 +270,7 @@ static int fsl_asoc_card_set_bias_level(struct snd_soc_card *card,
 
 		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->fll_id,
 					     pll_out, SND_SOC_CLOCK_IN);
-		if (ret) {
+		if (ret && ret != -ENOTSUPP) {
 			dev_err(dev, "failed to set SYSCLK: %d\n", ret);
 			return ret;
 		}
@@ -283,7 +283,7 @@ static int fsl_asoc_card_set_bias_level(struct snd_soc_card *card,
 		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
 					     codec_priv->mclk_freq,
 					     SND_SOC_CLOCK_IN);
-		if (ret) {
+		if (ret && ret != -ENOTSUPP) {
 			dev_err(dev, "failed to switch away from FLL: %d\n", ret);
 			return ret;
 		}
@@ -459,7 +459,7 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
 				     codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
-	if (ret) {
+	if (ret && ret != -ENOTSUPP) {
 		dev_err(dev, "failed to set sysclk in %s\n", __func__);
 		return ret;
 	}
-- 
2.7.4
