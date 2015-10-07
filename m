From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] ASoC: da7219: Improve error checking of mclk
 enable/disable
Date: Wed, 7 Oct 2015 11:57:14 +0100
Message-ID: <413ccdb3a8f209045fad3063e10919a6e6ccb757.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Should only try to enable/disable the provided mclk, during bias
level changes, if it's not NULL. Also return value of
clk_prepare_enable() should be checked and dealt with accordingly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index adcc079..abba4b3 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1494,6 +1494,7 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1502,7 +1503,14 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			/* MCLK */
-			clk_prepare_enable(da7219->mclk);
+			if (da7219->mclk) {
+				ret = clk_prepare_enable(da7219->mclk);
+				if (ret) {
+					dev_err(codec->dev,
+						"Failed to enable mclk\n");
+					return ret;
+				}
+			}
 
 			/* Master bias */
 			snd_soc_update_bits(codec, DA7219_REFERENCES,
@@ -1528,7 +1536,8 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* MCLK */
-		clk_disable_unprepare(da7219->mclk);
+		if (da7219->mclk)
+			clk_disable_unprepare(da7219->mclk);
 		break;
 	}
 
-- 
1.9.3
