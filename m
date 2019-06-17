From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH v5] ASoC: max98090: remove 24-bit format support if RJ is 0
Date: Mon, 17 Jun 2019 11:55:26 +0800
Message-ID: <20190617035526.85310-1-yuhsuan@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jon Hunter <jonathanh@nvidia.com>, Yu-Hsuan Hsu <yuhsuan@chromium.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dgreid@chromium.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The supported formats are S16_LE and S24_LE now. However, S24_LE is
not supported when TDM is 0 and it is not in the right justified mode.
We should remove 24-bit format in that situation to avoid triggering
error.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
The datasheet said that when TDM=0 and RJ=0, S24_LE is not supported.
So I added a constraint to check TDM. Please take a look. Thanks!

 sound/soc/codecs/max98090.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 7619ea31ab50..d118cf80b6b2 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1909,6 +1909,26 @@ static int max98090_configure_dmic(struct max98090_priv *max98090,
 	return 0;
 }
 
+static int max98090_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
+	unsigned int fmt = max98090->dai_fmt;
+
+	/*
+	 * When TDM = 0, remove 24-bit format support if it is not in right
+	 * justified mode.
+	 */
+	if (!max98090->tdm_slots &&
+		(fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
+		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
+	}
+
+	return 0;
+}
+
 static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -2316,6 +2336,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
 #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops max98090_dai_ops = {
+	.startup = max98090_dai_startup,
 	.set_sysclk = max98090_dai_set_sysclk,
 	.set_fmt = max98090_dai_set_fmt,
 	.set_tdm_slot = max98090_set_tdm_slot,
-- 
2.22.0.410.gd8fdbe21b5-goog
