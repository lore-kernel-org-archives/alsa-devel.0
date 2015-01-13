From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v3] ASoC: wm8904: fix runtime warning
Date: Tue, 13 Jan 2015 18:05:31 +0800
Message-ID: <1421143531-6662-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Correct the path name for mux to get rid of the following warning:

--->8---
wm8904 1-001a: Control not supported for path ADCL -> [Left] -> AIFOUTL
wm8904 1-001a: ASoC: no dapm match for ADCL --> Left --> AIFOUTL
wm8904 1-001a: ASoC: Failed to add route ADCL -> Left -> AIFOUTL
wm8904 1-001a: Control not supported for path ADCR -> [Right] -> AIFOUTL
wm8904 1-001a: ASoC: no dapm match for ADCR --> Right --> AIFOUTL
wm8904 1-001a: ASoC: Failed to add route ADCR -> Right -> AIFOUTL
wm8904 1-001a: Control not supported for path ADCL -> [Left] -> AIFOUTR
wm8904 1-001a: ASoC: no dapm match for ADCL --> Left --> AIFOUTR
wm8904 1-001a: ASoC: Failed to add route ADCL -> Left -> AIFOUTR
wm8904 1-001a: Control not supported for path ADCR -> [Right] -> AIFOUTR
wm8904 1-001a: ASoC: no dapm match for ADCR --> Right --> AIFOUTR
wm8904 1-001a: ASoC: Failed to add route ADCR -> Right -> AIFOUTR
wm8904 1-001a: Control not supported for path AIFINR -> [Right] -> DACL
wm8904 1-001a: ASoC: no dapm match for AIFINR --> Right --> DACL
wm8904 1-001a: ASoC: Failed to add route AIFINR -> Right -> DACL
wm8904 1-001a: Control not supported for path AIFINL -> [Left] -> DACL
wm8904 1-001a: ASoC: no dapm match for AIFINL --> Left --> DACL
wm8904 1-001a: ASoC: Failed to add route AIFINL -> Left -> DACL
wm8904 1-001a: Control not supported for path AIFINR -> [Right] -> DACR
wm8904 1-001a: ASoC: no dapm match for AIFINR --> Right --> DACR
wm8904 1-001a: ASoC: Failed to add route AIFINR -> Right -> DACR
wm8904 1-001a: Control not supported for path AIFINL -> [Left] -> DACR
wm8904 1-001a: ASoC: no dapm match for AIFINL --> Left --> DACR
wm8904 1-001a: ASoC: Failed to add route AIFINL -> Left -> DACR
---8<---

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

Changes in v3:
  - Correct the DAC related route path

Changes in v2:
  - Correct the mux path name.
  - Route the mux to the pins.

 sound/soc/codecs/wm8904.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 4d2d2b1..75b87c5 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1076,10 +1076,13 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
 	{ "Right Capture PGA", NULL, "Right Capture Mux" },
 	{ "Right Capture PGA", NULL, "Right Capture Inverting Mux" },
 
-	{ "AIFOUTL", "Left",  "ADCL" },
-	{ "AIFOUTL", "Right", "ADCR" },
-	{ "AIFOUTR", "Left",  "ADCL" },
-	{ "AIFOUTR", "Right", "ADCR" },
+	{ "AIFOUTL Mux", "Left", "ADCL" },
+	{ "AIFOUTL Mux", "Right", "ADCR" },
+	{ "AIFOUTR Mux", "Left", "ADCL" },
+	{ "AIFOUTR Mux", "Right", "ADCR" },
+
+	{ "AIFOUTL", NULL, "AIFOUTL Mux" },
+	{ "AIFOUTR", NULL, "AIFOUTR Mux" },
 
 	{ "ADCL", NULL, "CLK_DSP" },
 	{ "ADCL", NULL, "Left Capture PGA" },
@@ -1089,12 +1092,16 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
 };
 
 static const struct snd_soc_dapm_route dac_intercon[] = {
-	{ "DACL", "Right", "AIFINR" },
-	{ "DACL", "Left",  "AIFINL" },
+	{ "DACL Mux", "Left", "AIFINL" },
+	{ "DACL Mux", "Right", "AIFINR" },
+
+	{ "DACR Mux", "Left", "AIFINL" },
+	{ "DACR Mux", "Right", "AIFINR" },
+
+	{ "DACL", NULL, "DACL Mux" },
 	{ "DACL", NULL, "CLK_DSP" },
 
-	{ "DACR", "Right", "AIFINR" },
-	{ "DACR", "Left",  "AIFINL" },
+	{ "DACR", NULL, "DACR Mux" },
 	{ "DACR", NULL, "CLK_DSP" },
 
 	{ "Charge pump", NULL, "SYSCLK" },
-- 
2.1.0.24.g4109c28
