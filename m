From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Fix deemphasis values" to the asoc tree
Date: Wed, 09 Dec 2015 20:43:59 +0000
Message-ID: <E1a6lah-000458-Uq@debutante>
References: <1449661093-17580-1-git-send-email-john@metanate.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1449661093-17580-1-git-send-email-john@metanate.com>
Sender: stable-owner@vger.kernel.org
To: John Keeping <john@metanate.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Fix deemphasis values

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 84ebac4d04d25ac5c1b1dc3ae621fd465eb38f4e Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Wed, 9 Dec 2015 11:38:13 +0000
Subject: [PATCH] ASoC: es8328: Fix deemphasis values

This is using completely the wrong mask and value when updating the
register.  Since the correct values are already defined in the header,
switch to using a table with explicit constants rather than shifting the
array index.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/es8328.c | 25 +++++++++++++++++--------
 sound/soc/codecs/es8328.h |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 969e337dc17c..c4c64e21963e 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -85,7 +85,15 @@ static const DECLARE_TLV_DB_SCALE(pga_tlv, 0, 300, 0);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 300, 0);
 
-static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
+static const struct {
+	int rate;
+	unsigned int val;
+} deemph_settings[] = {
+	{ 0,     ES8328_DACCONTROL6_DEEMPH_OFF },
+	{ 32000, ES8328_DACCONTROL6_DEEMPH_32k },
+	{ 44100, ES8328_DACCONTROL6_DEEMPH_44_1k },
+	{ 48000, ES8328_DACCONTROL6_DEEMPH_48k },
+};
 
 static int es8328_set_deemph(struct snd_soc_codec *codec)
 {
@@ -97,21 +105,22 @@ static int es8328_set_deemph(struct snd_soc_codec *codec)
 	 * rate.
 	 */
 	if (es8328->deemph) {
-		best = 1;
-		for (i = 2; i < ARRAY_SIZE(deemph_settings); i++) {
-			if (abs(deemph_settings[i] - es8328->playback_fs) <
-			    abs(deemph_settings[best] - es8328->playback_fs))
+		best = 0;
+		for (i = 1; i < ARRAY_SIZE(deemph_settings); i++) {
+			if (abs(deemph_settings[i].rate - es8328->playback_fs) <
+			    abs(deemph_settings[best].rate - es8328->playback_fs))
 				best = i;
 		}
 
-		val = best << 1;
+		val = deemph_settings[best].val;
 	} else {
-		val = 0;
+		val = ES8328_DACCONTROL6_DEEMPH_OFF;
 	}
 
 	dev_dbg(codec->dev, "Set deemphasis %d\n", val);
 
-	return snd_soc_update_bits(codec, ES8328_DACCONTROL6, 0x6, val);
+	return snd_soc_update_bits(codec, ES8328_DACCONTROL6,
+			ES8328_DACCONTROL6_DEEMPH_MASK, val);
 }
 
 static int es8328_get_deemph(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
index cb36afe10c0e..156c748c89c7 100644
--- a/sound/soc/codecs/es8328.h
+++ b/sound/soc/codecs/es8328.h
@@ -153,6 +153,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_DACCONTROL6_CLICKFREE (1 << 3)
 #define ES8328_DACCONTROL6_DAC_INVR (1 << 4)
 #define ES8328_DACCONTROL6_DAC_INVL (1 << 5)
+#define ES8328_DACCONTROL6_DEEMPH_MASK (3 << 6)
 #define ES8328_DACCONTROL6_DEEMPH_OFF (0 << 6)
 #define ES8328_DACCONTROL6_DEEMPH_32k (1 << 6)
 #define ES8328_DACCONTROL6_DEEMPH_44_1k (2 << 6)
-- 
2.6.2
