From: abhijeet.kumar@intel.com
Subject: [PATCH] ASoC: nau8825: fix issue that pop noise when start capture
Date: Tue, 12 Dec 2017 00:40:25 +0530
Message-ID: <1513019426-9623-1-git-send-email-abhijeet.kumar@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Hsu <KCHSU0@nuvoton.com>, Abhijeet Kumar <abhijeet.kumar@intel.com>, Bhumika Goyal <bhumirks@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

In skylake platform, we hear a loud pop noise(0 dB) at start of
audio capture power up sequence. This patch removes the pop noise
from the recording by adding a delay before enabling ADC.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
---
 sound/soc/codecs/nau8825.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 714ce17da717..e853a6dfd33b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -905,6 +905,7 @@ static int nau8825_adc_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		msleep(125);
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
 			NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
 		break;
-- 
1.9.1
