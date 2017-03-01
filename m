From: Liviu Dudau <liviu@dudau.co.uk>
Subject: [PATCH] ALSA: ASoC: TLV320AIC23: Unquote NULL from control name
Date: Wed,  1 Mar 2017 12:26:28 +0000
Message-ID: <20170301122628.10392-1-liviu@dudau.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Liviu Dudau <liviu@dudau.co.uk>
List-Id: alsa-devel@alsa-project.org

Without this I am getting the following messages at boot on my Trimslice:
   tlv320aic23-codec 2-001a: Control not supported for path LLINEIN -> [NULL] -> Line Input
   tlv320aic23-codec 2-001a: ASoC: no dapm match for LLINEIN --> NULL --> Line Input
   tlv320aic23-codec 2-001a: ASoC: Failed to add route LLINEIN -> NULL -> Line Input
   tlv320aic23-codec 2-001a: Control not supported for path RLINEIN -> [NULL] -> Line Input
   tlv320aic23-codec 2-001a: ASoC: no dapm match for RLINEIN --> NULL --> Line Input
   tlv320aic23-codec 2-001a: ASoC: Failed to add route RLINEIN -> NULL -> Line Input
   tlv320aic23-codec 2-001a: Control not supported for path MICIN -> [NULL] -> Mic Input
   tlv320aic23-codec 2-001a: ASoC: no dapm match for MICIN --> NULL --> Mic Input
   tlv320aic23-codec 2-001a: ASoC: Failed to add route MICIN -> NULL -> Mic Input
   tegra-snd-trimslice sound: tlv320aic23-hifi <-> 70002800.i2s mapping ok

Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
---
 sound/soc/codecs/tlv320aic23.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 410cae0f2060..628a8eeaab68 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -174,10 +174,9 @@ static const struct snd_soc_dapm_route tlv320aic23_intercon[] = {
 	{"ROUT", NULL, "Output Mixer"},
 
 	/* Inputs */
-	{"Line Input", "NULL", "LLINEIN"},
-	{"Line Input", "NULL", "RLINEIN"},
-
-	{"Mic Input", "NULL", "MICIN"},
+	{"Line Input", NULL, "LLINEIN"},
+	{"Line Input", NULL, "RLINEIN"},
+	{"Mic Input", NULL, "MICIN"},
 
 	/* input mux */
 	{"Capture Source", "Line", "Line Input"},
-- 
2.11.1
