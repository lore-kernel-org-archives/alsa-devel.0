From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Remove internal LDO features of
	codec" to the asoc tree
Date: Wed, 23 Dec 2015 00:12:17 +0000
Message-ID: <E1aBX2P-0008MT-Ca@debutante>
References: <c5fa840a76989331e59c4b97956a203d07d07464.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 294A32666A9
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:12:24 +0100 (CET)
In-Reply-To: <c5fa840a76989331e59c4b97956a203d07d07464.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Remove internal LDO features of codec

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

>From d8ef140dccc1645aa37a140ed7585458294210b8 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 Dec 2015 18:27:54 +0000
Subject: [PATCH] ASoC: da7219: Remove internal LDO features of codec

In AB silicon, the internal LDO is not supported so remove
DT and driver references to this (digital voltage direct from
'VDD' supply)

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7219.txt |  6 ++-
 include/sound/da7219.h                             | 11 -----
 sound/soc/codecs/da7219.c                          | 50 +---------------------
 sound/soc/codecs/da7219.h                          |  7 ---
 4 files changed, 6 insertions(+), 68 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index 1b7030911a3b..062a2a08250e 100644
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
index 3f39e135312d..307198b469bc 100644
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
index 0a177ae8e0c3..2630c503e3df 100644
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
index b514268c6c56..2b3f4471a17f 100644
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
2.6.2
