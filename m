From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Fix typo in name of EQ coefficient controls
Date: Wed, 13 Nov 2013 13:01:49 +0000
Message-ID: <20131113130149.GA7665@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    8 ++++----
 sound/soc/codecs/wm5110.c |    8 ++++----
 sound/soc/codecs/wm8997.c |    8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 8bbddc1..a08e8bf 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -685,13 +685,13 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES_MASK("EQ1 Coefficeints", ARIZONA_EQ1_1, 21,
+SND_SOC_BYTES_MASK("EQ1 Coefficients", ARIZONA_EQ1_1, 21,
 		   ARIZONA_EQ1_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ2 Coefficeints", ARIZONA_EQ2_1, 21,
+SND_SOC_BYTES_MASK("EQ2 Coefficients", ARIZONA_EQ2_1, 21,
 		   ARIZONA_EQ2_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ3 Coefficeints", ARIZONA_EQ3_1, 21,
+SND_SOC_BYTES_MASK("EQ3 Coefficients", ARIZONA_EQ3_1, 21,
 		   ARIZONA_EQ3_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ4 Coefficeints", ARIZONA_EQ4_1, 21,
+SND_SOC_BYTES_MASK("EQ4 Coefficients", ARIZONA_EQ4_1, 21,
 		   ARIZONA_EQ4_ENA_MASK),
 
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index bbd6438..b67ba33 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -101,13 +101,13 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES_MASK("EQ1 Coefficeints", ARIZONA_EQ1_1, 21,
+SND_SOC_BYTES_MASK("EQ1 Coefficients", ARIZONA_EQ1_1, 21,
 		   ARIZONA_EQ1_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ2 Coefficeints", ARIZONA_EQ2_1, 21,
+SND_SOC_BYTES_MASK("EQ2 Coefficients", ARIZONA_EQ2_1, 21,
 		   ARIZONA_EQ2_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ3 Coefficeints", ARIZONA_EQ3_1, 21,
+SND_SOC_BYTES_MASK("EQ3 Coefficients", ARIZONA_EQ3_1, 21,
 		   ARIZONA_EQ3_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ4 Coefficeints", ARIZONA_EQ4_1, 21,
+SND_SOC_BYTES_MASK("EQ4 Coefficients", ARIZONA_EQ4_1, 21,
 		   ARIZONA_EQ4_ENA_MASK),
 
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 2e886ca..1392bb3 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -170,13 +170,13 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES_MASK("EQ1 Coefficeints", ARIZONA_EQ1_1, 21,
+SND_SOC_BYTES_MASK("EQ1 Coefficients", ARIZONA_EQ1_1, 21,
 		   ARIZONA_EQ1_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ2 Coefficeints", ARIZONA_EQ2_1, 21,
+SND_SOC_BYTES_MASK("EQ2 Coefficients", ARIZONA_EQ2_1, 21,
 		   ARIZONA_EQ2_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ3 Coefficeints", ARIZONA_EQ3_1, 21,
+SND_SOC_BYTES_MASK("EQ3 Coefficients", ARIZONA_EQ3_1, 21,
 		   ARIZONA_EQ3_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ4 Coefficeints", ARIZONA_EQ4_1, 21,
+SND_SOC_BYTES_MASK("EQ4 Coefficients", ARIZONA_EQ4_1, 21,
 		   ARIZONA_EQ4_ENA_MASK),
 
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
-- 
1.7.2.5
