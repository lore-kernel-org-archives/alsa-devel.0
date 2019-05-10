From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH] ASoC: max98090: remove 24-bit format support
Date: Fri, 10 May 2019 18:25:59 +0800
Message-ID: <20190510102559.76137-1-yuhsuan@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Yu-Hsuan Hsu <yuhsuan@chromium.org>, Jon Hunter <jonathanh@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, dgreid@chromium.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

Remove 24-bit format support because it doesn't work now. We can revert
this change after it really supports.
(https://patchwork.kernel.org/patch/10783561/)

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 7619ea31ab50..b25b7efa9118 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2313,7 +2313,7 @@ int max98090_mic_detect(struct snd_soc_component *component,
 EXPORT_SYMBOL_GPL(max98090_mic_detect);
 
 #define MAX98090_RATES SNDRV_PCM_RATE_8000_96000
-#define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define MAX98090_FORMATS SNDRV_PCM_FMTBIT_S16_LE
 
 static const struct snd_soc_dai_ops max98090_dai_ops = {
 	.set_sysclk = max98090_dai_set_sysclk,
-- 
2.21.0.1020.gf2820cf01a-goog
