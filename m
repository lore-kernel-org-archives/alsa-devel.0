From: John Keeping <john@metanate.com>
Subject: [PATCH 5/9] ASoC: es8328: Use more suitable definition for mic bias
Date: Mon,  9 May 2016 12:24:33 +0100
Message-ID: <20160509112437.8924-6-john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-1-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/es8328.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index d580300d9220..8661d1837422 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -287,8 +287,8 @@ static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", ES8328_ADCPOWER,
 			ES8328_ADCPOWER_ADCL_OFF, 1),
 
-	SND_SOC_DAPM_SUPPLY("Mic Bias", ES8328_ADCPOWER,
-			ES8328_ADCPOWER_MIC_BIAS_OFF, 1, NULL, 0),
+	SND_SOC_DAPM_MICBIAS("Mic Bias", ES8328_ADCPOWER,
+			ES8328_ADCPOWER_MIC_BIAS_OFF, 1),
 	SND_SOC_DAPM_SUPPLY("Mic Bias Gen", ES8328_ADCPOWER,
 			ES8328_ADCPOWER_ADC_BIAS_GEN_OFF, 1, NULL, 0),
 
-- 
2.8.0.rc4.238.g874082a
