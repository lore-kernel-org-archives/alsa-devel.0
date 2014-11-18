From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: ad1980: Remove ac97_read/ac97_write wrappers
Date: Tue, 18 Nov 2014 19:45:54 +0100
Message-ID: <1416336354-32148-5-git-send-email-lars@metafoo.de>
References: <1416336354-32148-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416336354-32148-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since the regmap conversion ac97_read/ac97_write are just simple wrappers
around snd_soc_read/snd_soc_write. Use those instead directly and remove the
wrappers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad1980.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 5fd4a29..2860eef 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -186,18 +186,6 @@ static const struct snd_soc_dapm_route ad1980_dapm_routes[] = {
 	{ "HP_OUT_R", NULL, "Playback" },
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	return snd_soc_read(codec, reg);
-}
-
-static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int val)
-{
-	return snd_soc_write(codec, reg, val);
-}
-
 static struct snd_soc_dai_driver ad1980_dai = {
 	.name = "ad1980-hifi",
 	.playback = {
@@ -222,7 +210,7 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 	do {
 		if (try_warm && soc_ac97_ops->warm_reset) {
 			soc_ac97_ops->warm_reset(ac97);
-			if (ac97_read(codec, AC97_RESET) == 0x0090)
+			if (snd_soc_read(codec, AC97_RESET) == 0x0090)
 				return 1;
 		}
 
@@ -233,9 +221,9 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 		 * case the first nibble of data is eaten by the addr. (Tag is
 		 * always 16 bit)
 		 */
-		ac97_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
+		snd_soc_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
 
-		if (ac97_read(codec, AC97_RESET)  == 0x0090)
+		if (snd_soc_read(codec, AC97_RESET)  == 0x0090)
 			return 0;
 	} while (retry_cnt++ < 10);
 
@@ -273,12 +261,12 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 		goto reset_err;
 
 	/* Read out vendor ID to make sure it is ad1980 */
-	if (ac97_read(codec, AC97_VENDOR_ID1) != 0x4144) {
+	if (snd_soc_read(codec, AC97_VENDOR_ID1) != 0x4144) {
 		ret = -ENODEV;
 		goto reset_err;
 	}
 
-	vendor_id2 = ac97_read(codec, AC97_VENDOR_ID2);
+	vendor_id2 = snd_soc_read(codec, AC97_VENDOR_ID2);
 
 	if (vendor_id2 != 0x5370) {
 		if (vendor_id2 != 0x5374) {
@@ -291,15 +279,15 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	}
 
 	/* unmute captures and playbacks volume */
-	ac97_write(codec, AC97_MASTER, 0x0000);
-	ac97_write(codec, AC97_PCM, 0x0000);
-	ac97_write(codec, AC97_REC_GAIN, 0x0000);
-	ac97_write(codec, AC97_CENTER_LFE_MASTER, 0x0000);
-	ac97_write(codec, AC97_SURROUND_MASTER, 0x0000);
+	snd_soc_write(codec, AC97_MASTER, 0x0000);
+	snd_soc_write(codec, AC97_PCM, 0x0000);
+	snd_soc_write(codec, AC97_REC_GAIN, 0x0000);
+	snd_soc_write(codec, AC97_CENTER_LFE_MASTER, 0x0000);
+	snd_soc_write(codec, AC97_SURROUND_MASTER, 0x0000);
 
 	/*power on LFE/CENTER/Surround DACs*/
-	ext_status = ac97_read(codec, AC97_EXTENDED_STATUS);
-	ac97_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);
+	ext_status = snd_soc_read(codec, AC97_EXTENDED_STATUS);
+	snd_soc_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);
 
 	return 0;
 
-- 
1.8.0
