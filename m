From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 4/6] ASoC: da7219: Remove internal LDO features of codec
Date: Tue, 22 Dec 2015 18:27:54 +0000
Message-ID: <c5fa840a76989331e59c4b97956a203d07d07464.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

In AB silicon, the internal LDO is not supported so remove
DT and driver references to this (digital voltage direct from
'VDD' supply)

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da7219.txt |  6 ++-
 include/sound/da7219.h                             | 11 -----
 sound/soc/codecs/da7219.c                          | 50 +---------------------
 sound/soc/codecs/da7219.h                          |  7 ---
 4 files changed, 6 insertions(+), 68 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index 1b70309..062a2a0 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -28,13 +28,15 @@ Optional properties:
 - clocks : phandle and clock specifier for codec MCLK.
 - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
 
-- dlg,ldo-lvl : Required internal LDO voltage (mV) level for digital engine
-	[<1050>, <1100>, <1200>, <1400>]
 - dlg,micbias-lvl : Voltage (mV) for Mic Bias
 	[<1800>, <2000>, <2200>, <2400>, <2600>]
 - dlg,mic-amp-in-sel : Mic input source type
 	["diff", "se_p", "se_n"]
 
+Deprecated properties:
+- dlg,ldo-lvl : Required internal LDO voltage (mV) level for digital engine
+  (LDO unavailable in production HW so property no longer required).
+
 ======
 
 Child node - 'da7219_aad':
diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 3f39e13..307198b 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -14,14 +14,6 @@
 #ifndef __DA7219_PDATA_H
 #define __DA7219_PDATA_H
 
-/* LDO */
-enum da7219_ldo_lvl_sel {
-	DA7219_LDO_LVL_SEL_1_05V = 0,
-	DA7219_LDO_LVL_SEL_1_10V,
-	DA7219_LDO_LVL_SEL_1_20V,
-	DA7219_LDO_LVL_SEL_1_40V,
-};
-
 /* Mic Bias */
 enum da7219_micbias_voltage {
 	DA7219_MICBIAS_1_8V = 1,
@@ -41,9 +33,6 @@ enum da7219_mic_amp_in_sel {
 struct da7219_aad_pdata;
 
 struct da7219_pdata {
-	/* Internal LDO */
-	enum da7219_ldo_lvl_sel ldo_lvl_sel;
-
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
 	enum da7219_mic_amp_in_sel mic_amp_in_sel;
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 3502c13..5daeec8 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1406,24 +1406,6 @@ static const struct of_device_id da7219_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, da7219_of_match);
 
-static enum da7219_ldo_lvl_sel da7219_of_ldo_lvl(struct snd_soc_codec *codec,
-						 u32 val)
-{
-	switch (val) {
-	case 1050:
-		return DA7219_LDO_LVL_SEL_1_05V;
-	case 1100:
-		return DA7219_LDO_LVL_SEL_1_10V;
-	case 1200:
-		return DA7219_LDO_LVL_SEL_1_20V;
-	case 1400:
-		return DA7219_LDO_LVL_SEL_1_40V;
-	default:
-		dev_warn(codec->dev, "Invalid LDO level");
-		return DA7219_LDO_LVL_SEL_1_05V;
-	}
-}
-
 static enum da7219_micbias_voltage
 	da7219_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
 {
@@ -1470,9 +1452,6 @@ static struct da7219_pdata *da7219_of_to_pdata(struct snd_soc_codec *codec)
 	if (!pdata)
 		return NULL;
 
-	if (of_property_read_u32(np, "dlg,ldo-lvl", &of_val32) >= 0)
-		pdata->ldo_lvl_sel = da7219_of_ldo_lvl(codec, of_val32);
-
 	if (of_property_read_u32(np, "dlg,micbias-lvl", &of_val32) >= 0)
 		pdata->micbias_lvl = da7219_of_micbias_lvl(codec, of_val32);
 	else
@@ -1517,24 +1496,13 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_update_bits(codec, DA7219_REFERENCES,
 					    DA7219_BIAS_EN_MASK,
 					    DA7219_BIAS_EN_MASK);
-
-			/* Enable Internal Digital LDO */
-			snd_soc_update_bits(codec, DA7219_LDO_CTRL,
-					    DA7219_LDO_EN_MASK,
-					    DA7219_LDO_EN_MASK);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
-		/* Only disable if jack detection not active */
-		if (!da7219->aad->jack) {
-			/* Bypass Internal Digital LDO */
-			snd_soc_update_bits(codec, DA7219_LDO_CTRL,
-					    DA7219_LDO_EN_MASK, 0);
-
-			/* Master bias */
+		/* Only disable master bias if jack detection not active */
+		if (!da7219->aad->jack)
 			snd_soc_update_bits(codec, DA7219_REFERENCES,
 					    DA7219_BIAS_EN_MASK, 0);
-		}
 
 		/* MCLK */
 		if (da7219->mclk)
@@ -1601,19 +1569,6 @@ static void da7219_handle_pdata(struct snd_soc_codec *codec)
 	if (pdata) {
 		u8 micbias_lvl = 0;
 
-		/* Internal LDO */
-		switch (pdata->ldo_lvl_sel) {
-		case DA7219_LDO_LVL_SEL_1_05V:
-		case DA7219_LDO_LVL_SEL_1_10V:
-		case DA7219_LDO_LVL_SEL_1_20V:
-		case DA7219_LDO_LVL_SEL_1_40V:
-			snd_soc_update_bits(codec, DA7219_LDO_CTRL,
-					    DA7219_LDO_LEVEL_SELECT_MASK,
-					    (pdata->ldo_lvl_sel <<
-					     DA7219_LDO_LEVEL_SELECT_SHIFT));
-			break;
-		}
-
 		/* Mic Bias voltages */
 		switch (pdata->micbias_lvl) {
 		case DA7219_MICBIAS_1_8V:
@@ -1823,7 +1778,6 @@ static struct reg_default da7219_reg_defaults[] = {
 	{ DA7219_CHIP_ID1, 0x23 },
 	{ DA7219_CHIP_ID2, 0x93 },
 	{ DA7219_CHIP_REVISION, 0x00 },
-	{ DA7219_LDO_CTRL, 0x00 },
 	{ DA7219_IO_CTRL, 0x00 },
 	{ DA7219_GAIN_RAMP_CTRL, 0x00 },
 	{ DA7219_PC_COUNT, 0x02 },
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index b514268..2b3f447 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -85,7 +85,6 @@
 #define DA7219_CHIP_ID1			0x81
 #define DA7219_CHIP_ID2			0x82
 #define DA7219_CHIP_REVISION		0x83
-#define DA7219_LDO_CTRL			0x90
 #define DA7219_IO_CTRL			0x91
 #define DA7219_GAIN_RAMP_CTRL		0x92
 #define DA7219_PC_COUNT			0x94
@@ -569,12 +568,6 @@
 #define DA7219_CHIP_MAJOR_SHIFT	4
 #define DA7219_CHIP_MAJOR_MASK	(0xF << 4)
 
-/* DA7219_LDO_CTRL = 0x90 */
-#define DA7219_LDO_LEVEL_SELECT_SHIFT	4
-#define DA7219_LDO_LEVEL_SELECT_MASK	(0x3 << 4)
-#define DA7219_LDO_EN_SHIFT		7
-#define DA7219_LDO_EN_MASK		(0x1 << 7)
-
 /* DA7219_IO_CTRL = 0x91 */
 #define DA7219_IO_VOLTAGE_LEVEL_SHIFT		0
 #define DA7219_IO_VOLTAGE_LEVEL_MASK		(0x1 << 0)
-- 
1.9.3
