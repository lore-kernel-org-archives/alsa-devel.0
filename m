From: Gabriel Dobato <dobatog@gmail.com>
Subject: [PATCH 1/1] ARM: TLV320AIC23 SoC Audio Codec: Fix errors reported related to input routing signals.
Date: Thu, 26 Feb 2015 12:32:27 +0100
Message-ID: <1424950347-26241-1-git-send-email-dobatog@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: moinejf@free.fr, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Max Filippov <jcmvbkbc@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dobatog <dobatog@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: dobatog <dobatog@gmail.com>

The following patch, based on stable v3.19,  corrects the errors that are reported in the boot trace in reference to the Input Signals of the audio codec TLV320AIC23:

tlv320aic23-codec 1-001a: Control not supported for path LLINEIN -> [NULL] -> Line Input
tlv320aic23-codec 1-001a: ASoC: no dapm match for LLINEIN --> NULL --> Line Input
tlv320aic23-codec 1-001a: ASoC: Failed to add route LLINEIN -> NULL -> Line Input
tlv320aic23-codec 1-001a: Control not supported for path RLINEIN -> [NULL] -> Line Input
tlv320aic23-codec 1-001a: ASoC: no dapm match for RLINEIN --> NULL --> Line Input
tlv320aic23-codec 1-001a: ASoC: Failed to add route RLINEIN -> NULL -> Line Input
tlv320aic23-codec 1-001a: Control not supported for path MICIN -> [NULL] -> Mic Input
tlv320aic23-codec 1-001a: ASoC: no dapm match for MICIN --> NULL --> Mic Input
tlv320aic23-codec 1-001a: ASoC: Failed to add route MICIN -> NULL -> Mic Input

I am trying to set the sound system in a CM-510 (Compulab - SoM) based board with DT, using Simple-Card-Audio and  the TLV320AIC23 audio codec included in the SoM . I faced this problem and thanks to the help of Sebastian Hesselbarth who noticed the possible error located in the structure snd_soc_dapm_route tlv320aic23_intercon[] , now errors are not reported.

Tested on CM-510 (Compulab SoM Board).

Signed-off-by: dobatog <dobatog@gmail.com>
---
 sound/soc/codecs/tlv320aic23.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index cc17e7e..891f3aa 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -174,10 +174,10 @@ static const struct snd_soc_dapm_route tlv320aic23_intercon[] = {
 	{"ROUT", NULL, "Output Mixer"},
 
 	/* Inputs */
-	{"Line Input", "NULL", "LLINEIN"},
-	{"Line Input", "NULL", "RLINEIN"},
+	{"Line Input", NULL, "LLINEIN"},
+	{"Line Input", NULL, "RLINEIN"},
 
-	{"Mic Input", "NULL", "MICIN"},
+	{"Mic Input", NULL, "MICIN"},
 
 	/* input mux */
 	{"Capture Source", "Line", "Line Input"},
-- 
1.9.1
