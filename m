From: John Keeping <john@metanate.com>
Subject: [PATCH] ASoC: es8328: Fix shifts for mixer switches
Date: Fri, 20 Nov 2015 11:42:22 +0000
Message-ID: <1448019742-12263-1-git-send-email-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: John Keeping <john@metanate.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These are all off by one; the playback and bypass switches are the top
two bits of the registers, which are at shifts 7 and 6 not 8 and 7.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/es8328.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 969e337..84f5eb0 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -205,18 +205,18 @@ static const struct snd_kcontrol_new es8328_right_line_controls =
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 8, 1, 0),
-	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 7, 1, 0),
-	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 8, 1, 0),
-	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 7, 1, 0),
+	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 7, 1, 0),
+	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 6, 1, 0),
+	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 7, 1, 0),
+	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 6, 1, 0),
 };
 
 /* Right Mixer */
 static const struct snd_kcontrol_new es8328_right_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 8, 1, 0),
-	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 7, 1, 0),
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 8, 1, 0),
-	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 7, 1, 0),
+	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 7, 1, 0),
+	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 6, 1, 0),
+	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 7, 1, 0),
+	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 6, 1, 0),
 };
 
 static const char * const es8328_pga_sel[] = {
-- 
2.6.3.462.gbe2c914
