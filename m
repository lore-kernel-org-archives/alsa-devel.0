From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/4] ASoC: da7213: Improve driver efficiency with regards to
 MCLK usage
Date: Thu, 4 Aug 2016 15:35:39 +0100
Message-ID: <0a4cee872d31223fa076c58e4328aad3a11104a8.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
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
 sound/soc/codecs/da7213.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index bcf1834..7701f4e 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1454,11 +1454,10 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
 
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
 			if (da7213->mclk) {
 				ret = clk_prepare_enable(da7213->mclk);
 				if (ret) {
@@ -1467,21 +1466,24 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
 					return ret;
 				}
 			}
-
+		}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			/* Enable VMID reference & master bias */
 			snd_soc_update_bits(codec, DA7213_REFERENCES,
 					    DA7213_VMID_EN | DA7213_BIAS_EN,
 					    DA7213_VMID_EN | DA7213_BIAS_EN);
+		} else {
+			/* Remove MCLK */
+			if (da7213->mclk)
+				clk_disable_unprepare(da7213->mclk);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* Disable VMID reference & master bias */
 		snd_soc_update_bits(codec, DA7213_REFERENCES,
 				    DA7213_VMID_EN | DA7213_BIAS_EN, 0);
-
-		/* MCLK */
-		if (da7213->mclk)
-			clk_disable_unprepare(da7213->mclk);
 		break;
 	}
 	return 0;
-- 
1.9.3
