From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH] ASoC: pcm3060: Add powersaving widgets for DAC and ADC
Date: Fri,  7 Dec 2018 20:02:34 +0100
Message-ID: <20181207190234.12040-1-kmarinushkin@birdec.tech>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

Enable DAC/ADC only when playing/capturing

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 14 ++++++++++----
 sound/soc/codecs/pcm3060.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 1dd851a7b43b..6714aa8d9026 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -198,19 +198,25 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", PCM3060_REG64,
+			 PCM3060_REG_SHIFT_DAPSV, 1),
+
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 
 	SND_SOC_DAPM_INPUT("INL"),
 	SND_SOC_DAPM_INPUT("INR"),
+
+	SND_SOC_DAPM_ADC("ADC", "Capture", PCM3060_REG64,
+			 PCM3060_REG_SHIFT_ADPSV, 1),
 };
 
 static const struct snd_soc_dapm_route pcm3060_dapm_map[] = {
-	{ "OUTL", NULL, "Playback" },
-	{ "OUTR", NULL, "Playback" },
+	{ "OUTL", NULL, "DAC" },
+	{ "OUTR", NULL, "DAC" },
 
-	{ "Capture", NULL, "INL" },
-	{ "Capture", NULL, "INR" },
+	{ "ADC", NULL, "INL" },
+	{ "ADC", NULL, "INR" },
 };
 
 /* soc component */
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index c895cf40ee10..6a027b4a845d 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -37,7 +37,9 @@ int pcm3060_remove(struct device *dev);
 #define PCM3060_REG_MRST		0x80
 #define PCM3060_REG_SRST		0x40
 #define PCM3060_REG_ADPSV		0x20
+#define PCM3060_REG_SHIFT_ADPSV	0x05
 #define PCM3060_REG_DAPSV		0x10
+#define PCM3060_REG_SHIFT_DAPSV	0x04
 #define PCM3060_REG_SE			0x01
 
 #define PCM3060_REG65			0x41
-- 
2.13.6
