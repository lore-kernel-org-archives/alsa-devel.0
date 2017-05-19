From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 2/5] staging: max98927: Added controls for Envelope tracking
Date: Thu, 18 May 2017 20:01:11 -0700
Message-ID: <1495162871-21519-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 sound/soc/codecs/max98927.c | 20 ++++++++++++++++----
 sound/soc/codecs/max98927.h |  4 ++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 99d6e41..cdee3a3 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -614,6 +614,18 @@ static SOC_ENUM_SINGLE_DECL(max98927_current_limit,
 		MAX98927_R0042_BOOST_CTRL1, 1,
 		max98927_current_limit_text);
 
+static const char * const max98927_env_track_headroom_text[] = {
+	"0.000V", "0.125V", "0.250V", "0.375V", "0.500V", "0.625V",
+	"0.750V", "0.875V", "1.000V", "1.125V", "1.250V", "1.375V",
+	"1.500V", "1.625V", "1.750V", "1.875V", "2.000V", "2.125V",
+	"2.250V", "2.375V", "2.500V", "2.625V", "2.750V", "2.875V",
+	"3.000V", "3.125V", "3.250V", "3.375V", "3.500V"
+};
+
+static SOC_ENUM_SINGLE_DECL(max98927_env_track_headroom,
+		MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM, 0,
+		max98927_env_track_headroom_text);
+
 static const struct snd_kcontrol_new max98927_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Volume", MAX98927_R003C_SPK_GAIN,
 		0, 6, 0,
@@ -631,6 +643,9 @@ static const struct snd_kcontrol_new max98927_snd_controls[] = {
 		MAX98927_AMP_VOL_SEL_SHIFT, 1, 0),
 	SOC_ENUM("Boost Output Voltage", max98927_boost_voltage),
 	SOC_ENUM("Current Limit", max98927_current_limit),
+	SOC_SINGLE("EnvTrack Switch", MAX98927_R0086_ENV_TRACK_CTRL,
+		MAX98927_ENV_TRACKER_EN_SHIFT, 1, 0),
+	SOC_ENUM("EnvTrack Headroom", max98927_env_track_headroom),
 };
 
 static const struct snd_soc_dapm_route max98927_audio_map[] = {
@@ -726,13 +741,10 @@ static int max98927_probe(struct snd_soc_codec *codec)
 	/* Envelope Tracking configuration */
 	regmap_write(max98927->regmap,
 		MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,
-		0x08);
+		0x0A);
 	regmap_write(max98927->regmap,
 		MAX98927_R0086_ENV_TRACK_CTRL,
 		0x01);
-	regmap_write(max98927->regmap,
-		MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,
-		0x10);
 
 	/* voltage, current slot configuration */
 	regmap_write(max98927->regmap,
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index bf7a6f92..3069a09 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -250,6 +250,10 @@
 #define MAX98927_BROWNOUT_DSP_EN (0x1 << 2)
 #define MAX98927_BROWNOUT_DSP_SHIFT (2)
 
+/* MAX98927_R0086_ENV_TRACK_CTRL */
+#define MAX98927_ENV_TRACKER_EN (0x1 << 0)
+#define MAX98927_ENV_TRACKER_EN_SHIFT (0)
+
 /* MAX98927_R0100_SOFT_RESET */
 #define MAX98927_SOFT_RESET (0x1 << 0)
 
-- 
2.7.4
