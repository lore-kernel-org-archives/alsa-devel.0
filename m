From: Axel Lin <axel.lin@ingics.com>
Subject: [RFT][PATCH 1/2] ASoC: max98088: Get rid of
	max98088_access table
Date: Mon, 27 Jul 2015 17:04:57 +0800
Message-ID: <1437987897.1147.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id B81F22606C2
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 11:05:04 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so48354154pac.3
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 02:05:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Chih-Chung Chang <chihchung@chromium.org>
List-Id: alsa-devel@alsa-project.org

The max98088_access table is used for look up readable/writable/volatile
attributes of registers. The readable/writable/volatile registers are
mostly in continuous ranges, so we can replace the max98088_access table
entirely by using case range.

Below is a summary of the readable/writeable/volatile registers:

readable registers:
        0x00 ~ 0xC9, 0xFF
writeable registers:
        0x03 ~ 0xC9, 0xFF
volatile registers:
        0x00 ~ 0x03, 0xFF

Note, 0x00 should be read-only according to the datasheet.

This patch reworks the implement for .readable and .volatile and also add
implementation for .writable callback.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max98088.c | 305 ++++----------------------------------------
 1 file changed, 25 insertions(+), 280 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 99c2daa..2c2df17 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -258,292 +258,36 @@ static const struct reg_default max98088_reg[] = {
 	{ 0xc9, 0x00 }, /* C9 DAI2 biquad */
 };
 
-static struct {
-       int readable;
-       int writable;
-       int vol;
-} max98088_access[M98088_REG_CNT] = {
-       { 0xFF, 0xFF, 1 }, /* 00 IRQ status */
-       { 0xFF, 0x00, 1 }, /* 01 MIC status */
-       { 0xFF, 0x00, 1 }, /* 02 jack status */
-       { 0x1F, 0x1F, 1 }, /* 03 battery voltage */
-       { 0xFF, 0xFF, 0 }, /* 04 */
-       { 0xFF, 0xFF, 0 }, /* 05 */
-       { 0xFF, 0xFF, 0 }, /* 06 */
-       { 0xFF, 0xFF, 0 }, /* 07 */
-       { 0xFF, 0xFF, 0 }, /* 08 */
-       { 0xFF, 0xFF, 0 }, /* 09 */
-       { 0xFF, 0xFF, 0 }, /* 0A */
-       { 0xFF, 0xFF, 0 }, /* 0B */
-       { 0xFF, 0xFF, 0 }, /* 0C */
-       { 0xFF, 0xFF, 0 }, /* 0D */
-       { 0xFF, 0xFF, 0 }, /* 0E */
-       { 0xFF, 0xFF, 0 }, /* 0F interrupt enable */
-
-       { 0xFF, 0xFF, 0 }, /* 10 master clock */
-       { 0xFF, 0xFF, 0 }, /* 11 DAI1 clock mode */
-       { 0xFF, 0xFF, 0 }, /* 12 DAI1 clock control */
-       { 0xFF, 0xFF, 0 }, /* 13 DAI1 clock control */
-       { 0xFF, 0xFF, 0 }, /* 14 DAI1 format */
-       { 0xFF, 0xFF, 0 }, /* 15 DAI1 clock */
-       { 0xFF, 0xFF, 0 }, /* 16 DAI1 config */
-       { 0xFF, 0xFF, 0 }, /* 17 DAI1 TDM */
-       { 0xFF, 0xFF, 0 }, /* 18 DAI1 filters */
-       { 0xFF, 0xFF, 0 }, /* 19 DAI2 clock mode */
-       { 0xFF, 0xFF, 0 }, /* 1A DAI2 clock control */
-       { 0xFF, 0xFF, 0 }, /* 1B DAI2 clock control */
-       { 0xFF, 0xFF, 0 }, /* 1C DAI2 format */
-       { 0xFF, 0xFF, 0 }, /* 1D DAI2 clock */
-       { 0xFF, 0xFF, 0 }, /* 1E DAI2 config */
-       { 0xFF, 0xFF, 0 }, /* 1F DAI2 TDM */
-
-       { 0xFF, 0xFF, 0 }, /* 20 DAI2 filters */
-       { 0xFF, 0xFF, 0 }, /* 21 data config */
-       { 0xFF, 0xFF, 0 }, /* 22 DAC mixer */
-       { 0xFF, 0xFF, 0 }, /* 23 left ADC mixer */
-       { 0xFF, 0xFF, 0 }, /* 24 right ADC mixer */
-       { 0xFF, 0xFF, 0 }, /* 25 left HP mixer */
-       { 0xFF, 0xFF, 0 }, /* 26 right HP mixer */
-       { 0xFF, 0xFF, 0 }, /* 27 HP control */
-       { 0xFF, 0xFF, 0 }, /* 28 left REC mixer */
-       { 0xFF, 0xFF, 0 }, /* 29 right REC mixer */
-       { 0xFF, 0xFF, 0 }, /* 2A REC control */
-       { 0xFF, 0xFF, 0 }, /* 2B left SPK mixer */
-       { 0xFF, 0xFF, 0 }, /* 2C right SPK mixer */
-       { 0xFF, 0xFF, 0 }, /* 2D SPK control */
-       { 0xFF, 0xFF, 0 }, /* 2E sidetone */
-       { 0xFF, 0xFF, 0 }, /* 2F DAI1 playback level */
-
-       { 0xFF, 0xFF, 0 }, /* 30 DAI1 playback level */
-       { 0xFF, 0xFF, 0 }, /* 31 DAI2 playback level */
-       { 0xFF, 0xFF, 0 }, /* 32 DAI2 playbakc level */
-       { 0xFF, 0xFF, 0 }, /* 33 left ADC level */
-       { 0xFF, 0xFF, 0 }, /* 34 right ADC level */
-       { 0xFF, 0xFF, 0 }, /* 35 MIC1 level */
-       { 0xFF, 0xFF, 0 }, /* 36 MIC2 level */
-       { 0xFF, 0xFF, 0 }, /* 37 INA level */
-       { 0xFF, 0xFF, 0 }, /* 38 INB level */
-       { 0xFF, 0xFF, 0 }, /* 39 left HP volume */
-       { 0xFF, 0xFF, 0 }, /* 3A right HP volume */
-       { 0xFF, 0xFF, 0 }, /* 3B left REC volume */
-       { 0xFF, 0xFF, 0 }, /* 3C right REC volume */
-       { 0xFF, 0xFF, 0 }, /* 3D left SPK volume */
-       { 0xFF, 0xFF, 0 }, /* 3E right SPK volume */
-       { 0xFF, 0xFF, 0 }, /* 3F MIC config */
-
-       { 0xFF, 0xFF, 0 }, /* 40 MIC threshold */
-       { 0xFF, 0xFF, 0 }, /* 41 excursion limiter filter */
-       { 0xFF, 0xFF, 0 }, /* 42 excursion limiter threshold */
-       { 0xFF, 0xFF, 0 }, /* 43 ALC */
-       { 0xFF, 0xFF, 0 }, /* 44 power limiter threshold */
-       { 0xFF, 0xFF, 0 }, /* 45 power limiter config */
-       { 0xFF, 0xFF, 0 }, /* 46 distortion limiter config */
-       { 0xFF, 0xFF, 0 }, /* 47 audio input */
-       { 0xFF, 0xFF, 0 }, /* 48 microphone */
-       { 0xFF, 0xFF, 0 }, /* 49 level control */
-       { 0xFF, 0xFF, 0 }, /* 4A bypass switches */
-       { 0xFF, 0xFF, 0 }, /* 4B jack detect */
-       { 0xFF, 0xFF, 0 }, /* 4C input enable */
-       { 0xFF, 0xFF, 0 }, /* 4D output enable */
-       { 0xFF, 0xFF, 0 }, /* 4E bias control */
-       { 0xFF, 0xFF, 0 }, /* 4F DAC power */
-
-       { 0xFF, 0xFF, 0 }, /* 50 DAC power */
-       { 0xFF, 0xFF, 0 }, /* 51 system */
-       { 0xFF, 0xFF, 0 }, /* 52 DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 53 DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 54 DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 55 DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 56 DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 57 DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 58 DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 59 DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 5A DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 5B DAI1 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 5C DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 5D DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 5E DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 5F DAI1 EQ2 */
-
-       { 0xFF, 0xFF, 0 }, /* 60 DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 61 DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 62 DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 63 DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 64 DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 65 DAI1 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 66 DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 67 DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 68 DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 69 DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 6A DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 6B DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 6C DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 6D DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 6E DAI1 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 6F DAI1 EQ3 */
-
-       { 0xFF, 0xFF, 0 }, /* 70 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 71 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 72 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 73 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 74 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 75 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 76 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 77 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 78 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 79 DAI1 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* 7A DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 7B DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 7C DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 7D DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 7E DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 7F DAI1 EQ5 */
-
-       { 0xFF, 0xFF, 0 }, /* 80 DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 81 DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 82 DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 83 DAI1 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* 84 DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 85 DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 86 DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 87 DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 88 DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 89 DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 8A DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 8B DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 8C DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 8D DAI2 EQ1 */
-       { 0xFF, 0xFF, 0 }, /* 8E DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 8F DAI2 EQ2 */
-
-       { 0xFF, 0xFF, 0 }, /* 90 DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 91 DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 92 DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 93 DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 94 DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 95 DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 96 DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 97 DAI2 EQ2 */
-       { 0xFF, 0xFF, 0 }, /* 98 DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 99 DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 9A DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 9B DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 9C DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 9D DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 9E DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* 9F DAI2 EQ3 */
-
-       { 0xFF, 0xFF, 0 }, /* A0 DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* A1 DAI2 EQ3 */
-       { 0xFF, 0xFF, 0 }, /* A2 DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* A3 DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* A4 DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* A5 DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* A6 DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* A7 DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* A8 DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* A9 DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* AA DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* AB DAI2 EQ4 */
-       { 0xFF, 0xFF, 0 }, /* AC DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* AD DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* AE DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* AF DAI2 EQ5 */
-
-       { 0xFF, 0xFF, 0 }, /* B0 DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* B1 DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* B2 DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* B3 DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* B4 DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* B5 DAI2 EQ5 */
-       { 0xFF, 0xFF, 0 }, /* B6 DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* B7 DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* B8 DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* B9 DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* BA DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* BB DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* BC DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* BD DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* BE DAI1 biquad */
-       { 0xFF, 0xFF, 0 }, /* BF DAI1 biquad */
-
-       { 0xFF, 0xFF, 0 }, /* C0 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C1 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C2 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C3 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C4 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C5 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C6 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C7 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C8 DAI2 biquad */
-       { 0xFF, 0xFF, 0 }, /* C9 DAI2 biquad */
-       { 0x00, 0x00, 0 }, /* CA */
-       { 0x00, 0x00, 0 }, /* CB */
-       { 0x00, 0x00, 0 }, /* CC */
-       { 0x00, 0x00, 0 }, /* CD */
-       { 0x00, 0x00, 0 }, /* CE */
-       { 0x00, 0x00, 0 }, /* CF */
-
-       { 0x00, 0x00, 0 }, /* D0 */
-       { 0x00, 0x00, 0 }, /* D1 */
-       { 0x00, 0x00, 0 }, /* D2 */
-       { 0x00, 0x00, 0 }, /* D3 */
-       { 0x00, 0x00, 0 }, /* D4 */
-       { 0x00, 0x00, 0 }, /* D5 */
-       { 0x00, 0x00, 0 }, /* D6 */
-       { 0x00, 0x00, 0 }, /* D7 */
-       { 0x00, 0x00, 0 }, /* D8 */
-       { 0x00, 0x00, 0 }, /* D9 */
-       { 0x00, 0x00, 0 }, /* DA */
-       { 0x00, 0x00, 0 }, /* DB */
-       { 0x00, 0x00, 0 }, /* DC */
-       { 0x00, 0x00, 0 }, /* DD */
-       { 0x00, 0x00, 0 }, /* DE */
-       { 0x00, 0x00, 0 }, /* DF */
-
-       { 0x00, 0x00, 0 }, /* E0 */
-       { 0x00, 0x00, 0 }, /* E1 */
-       { 0x00, 0x00, 0 }, /* E2 */
-       { 0x00, 0x00, 0 }, /* E3 */
-       { 0x00, 0x00, 0 }, /* E4 */
-       { 0x00, 0x00, 0 }, /* E5 */
-       { 0x00, 0x00, 0 }, /* E6 */
-       { 0x00, 0x00, 0 }, /* E7 */
-       { 0x00, 0x00, 0 }, /* E8 */
-       { 0x00, 0x00, 0 }, /* E9 */
-       { 0x00, 0x00, 0 }, /* EA */
-       { 0x00, 0x00, 0 }, /* EB */
-       { 0x00, 0x00, 0 }, /* EC */
-       { 0x00, 0x00, 0 }, /* ED */
-       { 0x00, 0x00, 0 }, /* EE */
-       { 0x00, 0x00, 0 }, /* EF */
-
-       { 0x00, 0x00, 0 }, /* F0 */
-       { 0x00, 0x00, 0 }, /* F1 */
-       { 0x00, 0x00, 0 }, /* F2 */
-       { 0x00, 0x00, 0 }, /* F3 */
-       { 0x00, 0x00, 0 }, /* F4 */
-       { 0x00, 0x00, 0 }, /* F5 */
-       { 0x00, 0x00, 0 }, /* F6 */
-       { 0x00, 0x00, 0 }, /* F7 */
-       { 0x00, 0x00, 0 }, /* F8 */
-       { 0x00, 0x00, 0 }, /* F9 */
-       { 0x00, 0x00, 0 }, /* FA */
-       { 0x00, 0x00, 0 }, /* FB */
-       { 0x00, 0x00, 0 }, /* FC */
-       { 0x00, 0x00, 0 }, /* FD */
-       { 0x00, 0x00, 0 }, /* FE */
-       { 0xFF, 0x00, 1 }, /* FF */
-};
-
 static bool max98088_readable_register(struct device *dev, unsigned int reg)
 {
-       return max98088_access[reg].readable;
+	switch (reg) {
+	case M98088_REG_00_IRQ_STATUS ... 0xC9:
+	case M98088_REG_FF_REV_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool max98088_writeable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case M98088_REG_03_BATTERY_VOLTAGE ... 0xC9:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static bool max98088_volatile_register(struct device *dev, unsigned int reg)
 {
-       return max98088_access[reg].vol;
+	switch (reg) {
+	case M98088_REG_00_IRQ_STATUS ... M98088_REG_03_BATTERY_VOLTAGE:
+	case M98088_REG_FF_REV_ID:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static const struct regmap_config max98088_regmap = {
@@ -551,6 +295,7 @@ static const struct regmap_config max98088_regmap = {
 	.val_bits = 8,
 
 	.readable_reg = max98088_readable_register,
+	.writeable_reg = max98088_writeable_register,
 	.volatile_reg = max98088_volatile_register,
 	.max_register = 0xff,
 
-- 
2.1.0
