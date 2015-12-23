From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/1] ASoC: da7219: Add regmap patch to support old silicon
Date: Wed, 23 Dec 2015 13:50:04 +0000
Message-ID: <20151223135004.A8AC93FB23@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Initial silicon did not have master bias enabled by default, unlike
later HW, so use regmap patch to align with newer defaults.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

This patch is based on the following commit:

'ASoC: da7219: Remove support for 32KHz PLL mode'
(Commit 501f72e9c5205b9d70d5d61e9b186ae7ba873f73, kernel/git/broonie/sound.git)


 sound/soc/codecs/da7219.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 82a7236..341a191 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1592,9 +1592,14 @@ static void da7219_handle_pdata(struct snd_soc_codec *codec)
 	}
 }

+static struct reg_sequence da7219_rev_aa_patch[] = {
+	{ DA7219_REFERENCES, 0x08 },
+};
+
 static int da7219_probe(struct snd_soc_codec *codec)
 {
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
+	unsigned int rev;
 	int ret;

 	mutex_init(&da7219->lock);
@@ -1604,6 +1609,26 @@ static int da7219_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;

+	ret = regmap_read(da7219->regmap, DA7219_CHIP_REVISION, &rev);
+	if (ret) {
+		dev_err(codec->dev, "Failed to read chip revision: %d\n", ret);
+		goto err_disable_reg;
+	}
+
+	switch (rev & DA7219_CHIP_MINOR_MASK) {
+	case 0:
+		ret = regmap_register_patch(da7219->regmap, da7219_rev_aa_patch,
+					    ARRAY_SIZE(da7219_rev_aa_patch));
+		if (ret) {
+			dev_err(codec->dev, "Failed to register AA patch: %d\n",
+				ret);
+			goto err_disable_reg;
+		}
+		break;
+	default:
+		break;
+	}
+
 	/* Handle DT/Platform data */
 	if (codec->dev->of_node)
 		da7219->pdata = da7219_of_to_pdata(codec);
@@ -1774,7 +1799,6 @@ static struct reg_default da7219_reg_defaults[] = {
 	{ DA7219_MIXOUT_R_CTRL, 0x10 },
 	{ DA7219_CHIP_ID1, 0x23 },
 	{ DA7219_CHIP_ID2, 0x93 },
-	{ DA7219_CHIP_REVISION, 0x00 },
 	{ DA7219_IO_CTRL, 0x00 },
 	{ DA7219_GAIN_RAMP_CTRL, 0x00 },
 	{ DA7219_PC_COUNT, 0x02 },
--
1.9.3
