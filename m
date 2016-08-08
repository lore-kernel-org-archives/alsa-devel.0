From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] ASoC: da7218: Improve driver efficiency with regards to
 MCLK usage
Date: Mon, 8 Aug 2016 15:35:24 +0100
Message-ID: <aa06fd28f210387a6d7eb19fca9790022c01f72a.1470665013.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1470665013.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470665013.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently MCLK remains enabled during bias STANDBY state, and this
is not necessary. This patch updates the code to handle enabling
and disabling of MCLK, if provided, when moving between STANDBY
and PREPARE states, therefore saving power when no active streams
present.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7218.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index f443519..e7f3e4c 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2583,20 +2583,22 @@ static int da7218_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-	case SND_SOC_BIAS_PREPARE:
 		break;
-	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			/* MCLK */
+	case SND_SOC_BIAS_PREPARE:
+		/* Enable MCLK for transition to ON state */
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
 			if (da7218->mclk) {
 				ret = clk_prepare_enable(da7218->mclk);
 				if (ret) {
-					dev_err(codec->dev,
-						"Failed to enable mclk\n");
+					dev_err(codec->dev, "Failed to enable mclk\n");
 					return ret;
 				}
 			}
+		}
 
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			/* Master bias */
 			snd_soc_update_bits(codec, DA7218_REFERENCES,
 					    DA7218_BIAS_EN_MASK,
@@ -2606,6 +2608,10 @@ static int da7218_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_update_bits(codec, DA7218_LDO_CTRL,
 					    DA7218_LDO_EN_MASK,
 					    DA7218_LDO_EN_MASK);
+		} else {
+			/* Remove MCLK */
+			if (da7218->mclk)
+				clk_disable_unprepare(da7218->mclk);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -2619,10 +2625,6 @@ static int da7218_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_update_bits(codec, DA7218_REFERENCES,
 					    DA7218_BIAS_EN_MASK, 0);
 		}
-
-		/* MCLK */
-		if (da7218->mclk)
-			clk_disable_unprepare(da7218->mclk);
 		break;
 	}
 
-- 
1.9.3
