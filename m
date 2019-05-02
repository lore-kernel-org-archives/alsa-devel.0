From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH] ASoC: da7219: Update the support rate list
Date: Thu,  2 May 2019 12:07:43 +0800
Message-ID: <20190502040743.184310-1-yuhsuan@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, alsa-devel@alsa-project.org, dgreid@chromium.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>
List-Id: alsa-devel@alsa-project.org

If we want to set rate to 64000 on da7219, it fails and returns
"snd_pcm_hw_params: Invalid argument".
We should remove 64000 from support rate list because it is not
available.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/da7219.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5f5fa3416af3..7497457cf3d4 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1658,20 +1658,26 @@ static const struct snd_soc_dai_ops da7219_dai_ops = {
 #define DA7219_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
+#define DA7219_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
+		      SNDRV_PCM_RATE_96000)
+
 static struct snd_soc_dai_driver da7219_dai = {
 	.name = "da7219-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = DA7219_DAI_CH_NUM_MAX,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = DA7219_RATES,
 		.formats = DA7219_FORMATS,
 	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = DA7219_DAI_CH_NUM_MAX,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = DA7219_RATES,
 		.formats = DA7219_FORMATS,
 	},
 	.ops = &da7219_dai_ops,
-- 
2.21.0.593.g511ec345e18-goog
