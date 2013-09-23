From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: max98088: Convert to direct regmap
	API usage
Date: Mon, 23 Sep 2013 17:58:26 +0100
Message-ID: <1379955506-11658-3-git-send-email-broonie@kernel.org>
References: <1379955506-11658-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D2F2610BF
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 18:58:41 +0200 (CEST)
In-Reply-To: <1379955506-11658-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, Chih-Chung Chang <chihchung@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This saves code and moves us towards removing the redundant register I/O
implementation in ASoC.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98088.c | 580 +++++++++++++++++++-------------------------
 1 file changed, 251 insertions(+), 329 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 8896d5e..31912d5 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -38,6 +39,7 @@ struct max98088_cdata {
 };
 
 struct max98088_priv {
+	struct regmap *regmap;
 	enum max98088_type devtype;
 	struct max98088_pdata *pdata;
 	unsigned int sysclk;
@@ -54,278 +56,206 @@ struct max98088_priv {
 	unsigned int extmic_mode;
 };
 
-static const u8 max98088_reg[M98088_REG_CNT] = {
-       0x00, /* 00 IRQ status */
-       0x00, /* 01 MIC status */
-       0x00, /* 02 jack status */
-       0x00, /* 03 battery voltage */
-       0x00, /* 04 */
-       0x00, /* 05 */
-       0x00, /* 06 */
-       0x00, /* 07 */
-       0x00, /* 08 */
-       0x00, /* 09 */
-       0x00, /* 0A */
-       0x00, /* 0B */
-       0x00, /* 0C */
-       0x00, /* 0D */
-       0x00, /* 0E */
-       0x00, /* 0F interrupt enable */
-
-       0x00, /* 10 master clock */
-       0x00, /* 11 DAI1 clock mode */
-       0x00, /* 12 DAI1 clock control */
-       0x00, /* 13 DAI1 clock control */
-       0x00, /* 14 DAI1 format */
-       0x00, /* 15 DAI1 clock */
-       0x00, /* 16 DAI1 config */
-       0x00, /* 17 DAI1 TDM */
-       0x00, /* 18 DAI1 filters */
-       0x00, /* 19 DAI2 clock mode */
-       0x00, /* 1A DAI2 clock control */
-       0x00, /* 1B DAI2 clock control */
-       0x00, /* 1C DAI2 format */
-       0x00, /* 1D DAI2 clock */
-       0x00, /* 1E DAI2 config */
-       0x00, /* 1F DAI2 TDM */
-
-       0x00, /* 20 DAI2 filters */
-       0x00, /* 21 data config */
-       0x00, /* 22 DAC mixer */
-       0x00, /* 23 left ADC mixer */
-       0x00, /* 24 right ADC mixer */
-       0x00, /* 25 left HP mixer */
-       0x00, /* 26 right HP mixer */
-       0x00, /* 27 HP control */
-       0x00, /* 28 left REC mixer */
-       0x00, /* 29 right REC mixer */
-       0x00, /* 2A REC control */
-       0x00, /* 2B left SPK mixer */
-       0x00, /* 2C right SPK mixer */
-       0x00, /* 2D SPK control */
-       0x00, /* 2E sidetone */
-       0x00, /* 2F DAI1 playback level */
-
-       0x00, /* 30 DAI1 playback level */
-       0x00, /* 31 DAI2 playback level */
-       0x00, /* 32 DAI2 playbakc level */
-       0x00, /* 33 left ADC level */
-       0x00, /* 34 right ADC level */
-       0x00, /* 35 MIC1 level */
-       0x00, /* 36 MIC2 level */
-       0x00, /* 37 INA level */
-       0x00, /* 38 INB level */
-       0x00, /* 39 left HP volume */
-       0x00, /* 3A right HP volume */
-       0x00, /* 3B left REC volume */
-       0x00, /* 3C right REC volume */
-       0x00, /* 3D left SPK volume */
-       0x00, /* 3E right SPK volume */
-       0x00, /* 3F MIC config */
-
-       0x00, /* 40 MIC threshold */
-       0x00, /* 41 excursion limiter filter */
-       0x00, /* 42 excursion limiter threshold */
-       0x00, /* 43 ALC */
-       0x00, /* 44 power limiter threshold */
-       0x00, /* 45 power limiter config */
-       0x00, /* 46 distortion limiter config */
-       0x00, /* 47 audio input */
-       0x00, /* 48 microphone */
-       0x00, /* 49 level control */
-       0x00, /* 4A bypass switches */
-       0x00, /* 4B jack detect */
-       0x00, /* 4C input enable */
-       0x00, /* 4D output enable */
-       0xF0, /* 4E bias control */
-       0x00, /* 4F DAC power */
-
-       0x0F, /* 50 DAC power */
-       0x00, /* 51 system */
-       0x00, /* 52 DAI1 EQ1 */
-       0x00, /* 53 DAI1 EQ1 */
-       0x00, /* 54 DAI1 EQ1 */
-       0x00, /* 55 DAI1 EQ1 */
-       0x00, /* 56 DAI1 EQ1 */
-       0x00, /* 57 DAI1 EQ1 */
-       0x00, /* 58 DAI1 EQ1 */
-       0x00, /* 59 DAI1 EQ1 */
-       0x00, /* 5A DAI1 EQ1 */
-       0x00, /* 5B DAI1 EQ1 */
-       0x00, /* 5C DAI1 EQ2 */
-       0x00, /* 5D DAI1 EQ2 */
-       0x00, /* 5E DAI1 EQ2 */
-       0x00, /* 5F DAI1 EQ2 */
-
-       0x00, /* 60 DAI1 EQ2 */
-       0x00, /* 61 DAI1 EQ2 */
-       0x00, /* 62 DAI1 EQ2 */
-       0x00, /* 63 DAI1 EQ2 */
-       0x00, /* 64 DAI1 EQ2 */
-       0x00, /* 65 DAI1 EQ2 */
-       0x00, /* 66 DAI1 EQ3 */
-       0x00, /* 67 DAI1 EQ3 */
-       0x00, /* 68 DAI1 EQ3 */
-       0x00, /* 69 DAI1 EQ3 */
-       0x00, /* 6A DAI1 EQ3 */
-       0x00, /* 6B DAI1 EQ3 */
-       0x00, /* 6C DAI1 EQ3 */
-       0x00, /* 6D DAI1 EQ3 */
-       0x00, /* 6E DAI1 EQ3 */
-       0x00, /* 6F DAI1 EQ3 */
-
-       0x00, /* 70 DAI1 EQ4 */
-       0x00, /* 71 DAI1 EQ4 */
-       0x00, /* 72 DAI1 EQ4 */
-       0x00, /* 73 DAI1 EQ4 */
-       0x00, /* 74 DAI1 EQ4 */
-       0x00, /* 75 DAI1 EQ4 */
-       0x00, /* 76 DAI1 EQ4 */
-       0x00, /* 77 DAI1 EQ4 */
-       0x00, /* 78 DAI1 EQ4 */
-       0x00, /* 79 DAI1 EQ4 */
-       0x00, /* 7A DAI1 EQ5 */
-       0x00, /* 7B DAI1 EQ5 */
-       0x00, /* 7C DAI1 EQ5 */
-       0x00, /* 7D DAI1 EQ5 */
-       0x00, /* 7E DAI1 EQ5 */
-       0x00, /* 7F DAI1 EQ5 */
-
-       0x00, /* 80 DAI1 EQ5 */
-       0x00, /* 81 DAI1 EQ5 */
-       0x00, /* 82 DAI1 EQ5 */
-       0x00, /* 83 DAI1 EQ5 */
-       0x00, /* 84 DAI2 EQ1 */
-       0x00, /* 85 DAI2 EQ1 */
-       0x00, /* 86 DAI2 EQ1 */
-       0x00, /* 87 DAI2 EQ1 */
-       0x00, /* 88 DAI2 EQ1 */
-       0x00, /* 89 DAI2 EQ1 */
-       0x00, /* 8A DAI2 EQ1 */
-       0x00, /* 8B DAI2 EQ1 */
-       0x00, /* 8C DAI2 EQ1 */
-       0x00, /* 8D DAI2 EQ1 */
-       0x00, /* 8E DAI2 EQ2 */
-       0x00, /* 8F DAI2 EQ2 */
-
-       0x00, /* 90 DAI2 EQ2 */
-       0x00, /* 91 DAI2 EQ2 */
-       0x00, /* 92 DAI2 EQ2 */
-       0x00, /* 93 DAI2 EQ2 */
-       0x00, /* 94 DAI2 EQ2 */
-       0x00, /* 95 DAI2 EQ2 */
-       0x00, /* 96 DAI2 EQ2 */
-       0x00, /* 97 DAI2 EQ2 */
-       0x00, /* 98 DAI2 EQ3 */
-       0x00, /* 99 DAI2 EQ3 */
-       0x00, /* 9A DAI2 EQ3 */
-       0x00, /* 9B DAI2 EQ3 */
-       0x00, /* 9C DAI2 EQ3 */
-       0x00, /* 9D DAI2 EQ3 */
-       0x00, /* 9E DAI2 EQ3 */
-       0x00, /* 9F DAI2 EQ3 */
-
-       0x00, /* A0 DAI2 EQ3 */
-       0x00, /* A1 DAI2 EQ3 */
-       0x00, /* A2 DAI2 EQ4 */
-       0x00, /* A3 DAI2 EQ4 */
-       0x00, /* A4 DAI2 EQ4 */
-       0x00, /* A5 DAI2 EQ4 */
-       0x00, /* A6 DAI2 EQ4 */
-       0x00, /* A7 DAI2 EQ4 */
-       0x00, /* A8 DAI2 EQ4 */
-       0x00, /* A9 DAI2 EQ4 */
-       0x00, /* AA DAI2 EQ4 */
-       0x00, /* AB DAI2 EQ4 */
-       0x00, /* AC DAI2 EQ5 */
-       0x00, /* AD DAI2 EQ5 */
-       0x00, /* AE DAI2 EQ5 */
-       0x00, /* AF DAI2 EQ5 */
-
-       0x00, /* B0 DAI2 EQ5 */
-       0x00, /* B1 DAI2 EQ5 */
-       0x00, /* B2 DAI2 EQ5 */
-       0x00, /* B3 DAI2 EQ5 */
-       0x00, /* B4 DAI2 EQ5 */
-       0x00, /* B5 DAI2 EQ5 */
-       0x00, /* B6 DAI1 biquad */
-       0x00, /* B7 DAI1 biquad */
-       0x00, /* B8 DAI1 biquad */
-       0x00, /* B9 DAI1 biquad */
-       0x00, /* BA DAI1 biquad */
-       0x00, /* BB DAI1 biquad */
-       0x00, /* BC DAI1 biquad */
-       0x00, /* BD DAI1 biquad */
-       0x00, /* BE DAI1 biquad */
-       0x00, /* BF DAI1 biquad */
-
-       0x00, /* C0 DAI2 biquad */
-       0x00, /* C1 DAI2 biquad */
-       0x00, /* C2 DAI2 biquad */
-       0x00, /* C3 DAI2 biquad */
-       0x00, /* C4 DAI2 biquad */
-       0x00, /* C5 DAI2 biquad */
-       0x00, /* C6 DAI2 biquad */
-       0x00, /* C7 DAI2 biquad */
-       0x00, /* C8 DAI2 biquad */
-       0x00, /* C9 DAI2 biquad */
-       0x00, /* CA */
-       0x00, /* CB */
-       0x00, /* CC */
-       0x00, /* CD */
-       0x00, /* CE */
-       0x00, /* CF */
-
-       0x00, /* D0 */
-       0x00, /* D1 */
-       0x00, /* D2 */
-       0x00, /* D3 */
-       0x00, /* D4 */
-       0x00, /* D5 */
-       0x00, /* D6 */
-       0x00, /* D7 */
-       0x00, /* D8 */
-       0x00, /* D9 */
-       0x00, /* DA */
-       0x70, /* DB */
-       0x00, /* DC */
-       0x00, /* DD */
-       0x00, /* DE */
-       0x00, /* DF */
-
-       0x00, /* E0 */
-       0x00, /* E1 */
-       0x00, /* E2 */
-       0x00, /* E3 */
-       0x00, /* E4 */
-       0x00, /* E5 */
-       0x00, /* E6 */
-       0x00, /* E7 */
-       0x00, /* E8 */
-       0x00, /* E9 */
-       0x00, /* EA */
-       0x00, /* EB */
-       0x00, /* EC */
-       0x00, /* ED */
-       0x00, /* EE */
-       0x00, /* EF */
-
-       0x00, /* F0 */
-       0x00, /* F1 */
-       0x00, /* F2 */
-       0x00, /* F3 */
-       0x00, /* F4 */
-       0x00, /* F5 */
-       0x00, /* F6 */
-       0x00, /* F7 */
-       0x00, /* F8 */
-       0x00, /* F9 */
-       0x00, /* FA */
-       0x00, /* FB */
-       0x00, /* FC */
-       0x00, /* FD */
-       0x00, /* FE */
-       0x00, /* FF */
+static const struct reg_default max98088_reg[] = {
+	{  0xf, 0x00 }, /* 0F interrupt enable */
+
+	{ 0x10, 0x00 }, /* 10 master clock */
+	{ 0x11, 0x00 }, /* 11 DAI1 clock mode */
+	{ 0x12, 0x00 }, /* 12 DAI1 clock control */
+	{ 0x13, 0x00 }, /* 13 DAI1 clock control */
+	{ 0x14, 0x00 }, /* 14 DAI1 format */
+	{ 0x15, 0x00 }, /* 15 DAI1 clock */
+	{ 0x16, 0x00 }, /* 16 DAI1 config */
+	{ 0x17, 0x00 }, /* 17 DAI1 TDM */
+	{ 0x18, 0x00 }, /* 18 DAI1 filters */
+	{ 0x19, 0x00 }, /* 19 DAI2 clock mode */
+	{ 0x1a, 0x00 }, /* 1A DAI2 clock control */
+	{ 0x1b, 0x00 }, /* 1B DAI2 clock control */
+	{ 0x1c, 0x00 }, /* 1C DAI2 format */
+	{ 0x1d, 0x00 }, /* 1D DAI2 clock */
+	{ 0x1e, 0x00 }, /* 1E DAI2 config */
+	{ 0x1f, 0x00 }, /* 1F DAI2 TDM */
+
+	{ 0x20, 0x00 }, /* 20 DAI2 filters */
+	{ 0x21, 0x00 }, /* 21 data config */
+	{ 0x22, 0x00 }, /* 22 DAC mixer */
+	{ 0x23, 0x00 }, /* 23 left ADC mixer */
+	{ 0x24, 0x00 }, /* 24 right ADC mixer */
+	{ 0x25, 0x00 }, /* 25 left HP mixer */
+	{ 0x26, 0x00 }, /* 26 right HP mixer */
+	{ 0x27, 0x00 }, /* 27 HP control */
+	{ 0x28, 0x00 }, /* 28 left REC mixer */
+	{ 0x29, 0x00 }, /* 29 right REC mixer */
+	{ 0x2a, 0x00 }, /* 2A REC control */
+	{ 0x2b, 0x00 }, /* 2B left SPK mixer */
+	{ 0x2c, 0x00 }, /* 2C right SPK mixer */
+	{ 0x2d, 0x00 }, /* 2D SPK control */
+	{ 0x2e, 0x00 }, /* 2E sidetone */
+	{ 0x2f, 0x00 }, /* 2F DAI1 playback level */
+
+	{ 0x30, 0x00 }, /* 30 DAI1 playback level */
+	{ 0x31, 0x00 }, /* 31 DAI2 playback level */
+	{ 0x32, 0x00 }, /* 32 DAI2 playbakc level */
+	{ 0x33, 0x00 }, /* 33 left ADC level */
+	{ 0x34, 0x00 }, /* 34 right ADC level */
+	{ 0x35, 0x00 }, /* 35 MIC1 level */
+	{ 0x36, 0x00 }, /* 36 MIC2 level */
+	{ 0x37, 0x00 }, /* 37 INA level */
+	{ 0x38, 0x00 }, /* 38 INB level */
+	{ 0x39, 0x00 }, /* 39 left HP volume */
+	{ 0x3a, 0x00 }, /* 3A right HP volume */
+	{ 0x3b, 0x00 }, /* 3B left REC volume */
+	{ 0x3c, 0x00 }, /* 3C right REC volume */
+	{ 0x3d, 0x00 }, /* 3D left SPK volume */
+	{ 0x3e, 0x00 }, /* 3E right SPK volume */
+	{ 0x3f, 0x00 }, /* 3F MIC config */
+
+	{ 0x40, 0x00 }, /* 40 MIC threshold */
+	{ 0x41, 0x00 }, /* 41 excursion limiter filter */
+	{ 0x42, 0x00 }, /* 42 excursion limiter threshold */
+	{ 0x43, 0x00 }, /* 43 ALC */
+	{ 0x44, 0x00 }, /* 44 power limiter threshold */
+	{ 0x45, 0x00 }, /* 45 power limiter config */
+	{ 0x46, 0x00 }, /* 46 distortion limiter config */
+	{ 0x47, 0x00 }, /* 47 audio input */
+        { 0x48, 0x00 }, /* 48 microphone */
+	{ 0x49, 0x00 }, /* 49 level control */
+	{ 0x4a, 0x00 }, /* 4A bypass switches */
+	{ 0x4b, 0x00 }, /* 4B jack detect */
+	{ 0x4c, 0x00 }, /* 4C input enable */
+	{ 0x4d, 0x00 }, /* 4D output enable */
+	{ 0x4e, 0xF0 }, /* 4E bias control */
+	{ 0x4f, 0x00 }, /* 4F DAC power */
+
+	{ 0x50, 0x0F }, /* 50 DAC power */
+	{ 0x51, 0x00 }, /* 51 system */
+	{ 0x52, 0x00 }, /* 52 DAI1 EQ1 */
+	{ 0x53, 0x00 }, /* 53 DAI1 EQ1 */
+	{ 0x54, 0x00 }, /* 54 DAI1 EQ1 */
+	{ 0x55, 0x00 }, /* 55 DAI1 EQ1 */
+	{ 0x56, 0x00 }, /* 56 DAI1 EQ1 */
+	{ 0x57, 0x00 }, /* 57 DAI1 EQ1 */
+	{ 0x58, 0x00 }, /* 58 DAI1 EQ1 */
+	{ 0x59, 0x00 }, /* 59 DAI1 EQ1 */
+	{ 0x5a, 0x00 }, /* 5A DAI1 EQ1 */
+	{ 0x5b, 0x00 }, /* 5B DAI1 EQ1 */
+	{ 0x5c, 0x00 }, /* 5C DAI1 EQ2 */
+	{ 0x5d, 0x00 }, /* 5D DAI1 EQ2 */
+	{ 0x5e, 0x00 }, /* 5E DAI1 EQ2 */
+	{ 0x5f, 0x00 }, /* 5F DAI1 EQ2 */
+
+	{ 0x60, 0x00 }, /* 60 DAI1 EQ2 */
+	{ 0x61, 0x00 }, /* 61 DAI1 EQ2 */
+	{ 0x62, 0x00 }, /* 62 DAI1 EQ2 */
+	{ 0x63, 0x00 }, /* 63 DAI1 EQ2 */
+	{ 0x64, 0x00 }, /* 64 DAI1 EQ2 */
+	{ 0x65, 0x00 }, /* 65 DAI1 EQ2 */
+	{ 0x66, 0x00 }, /* 66 DAI1 EQ3 */
+	{ 0x67, 0x00 }, /* 67 DAI1 EQ3 */
+	{ 0x68, 0x00 }, /* 68 DAI1 EQ3 */
+	{ 0x69, 0x00 }, /* 69 DAI1 EQ3 */
+	{ 0x6a, 0x00 }, /* 6A DAI1 EQ3 */
+	{ 0x6b, 0x00 }, /* 6B DAI1 EQ3 */
+	{ 0x6c, 0x00 }, /* 6C DAI1 EQ3 */
+	{ 0x6d, 0x00 }, /* 6D DAI1 EQ3 */
+	{ 0x6e, 0x00 }, /* 6E DAI1 EQ3 */
+	{ 0x6f, 0x00 }, /* 6F DAI1 EQ3 */
+
+	{ 0x70, 0x00 }, /* 70 DAI1 EQ4 */
+	{ 0x71, 0x00 }, /* 71 DAI1 EQ4 */
+	{ 0x72, 0x00 }, /* 72 DAI1 EQ4 */
+	{ 0x73, 0x00 }, /* 73 DAI1 EQ4 */
+	{ 0x74, 0x00 }, /* 74 DAI1 EQ4 */
+	{ 0x75, 0x00 }, /* 75 DAI1 EQ4 */
+	{ 0x76, 0x00 }, /* 76 DAI1 EQ4 */
+	{ 0x77, 0x00 }, /* 77 DAI1 EQ4 */
+	{ 0x78, 0x00 }, /* 78 DAI1 EQ4 */
+	{ 0x79, 0x00 }, /* 79 DAI1 EQ4 */
+	{ 0x7a, 0x00 }, /* 7A DAI1 EQ5 */
+	{ 0x7b, 0x00 }, /* 7B DAI1 EQ5 */
+	{ 0x7c, 0x00 }, /* 7C DAI1 EQ5 */
+	{ 0x7d, 0x00 }, /* 7D DAI1 EQ5 */
+	{ 0x7e, 0x00 }, /* 7E DAI1 EQ5 */
+	{ 0x7f, 0x00 }, /* 7F DAI1 EQ5 */
+
+	{ 0x80, 0x00 }, /* 80 DAI1 EQ5 */
+	{ 0x81, 0x00 }, /* 81 DAI1 EQ5 */
+	{ 0x82, 0x00 }, /* 82 DAI1 EQ5 */
+	{ 0x83, 0x00 }, /* 83 DAI1 EQ5 */
+	{ 0x84, 0x00 }, /* 84 DAI2 EQ1 */
+	{ 0x85, 0x00 }, /* 85 DAI2 EQ1 */
+	{ 0x86, 0x00 }, /* 86 DAI2 EQ1 */
+	{ 0x87, 0x00 }, /* 87 DAI2 EQ1 */
+	{ 0x88, 0x00 }, /* 88 DAI2 EQ1 */
+	{ 0x89, 0x00 }, /* 89 DAI2 EQ1 */
+	{ 0x8a, 0x00 }, /* 8A DAI2 EQ1 */
+	{ 0x8b, 0x00 }, /* 8B DAI2 EQ1 */
+	{ 0x8c, 0x00 }, /* 8C DAI2 EQ1 */
+	{ 0x8d, 0x00 }, /* 8D DAI2 EQ1 */
+	{ 0x8e, 0x00 }, /* 8E DAI2 EQ2 */
+	{ 0x8f, 0x00 }, /* 8F DAI2 EQ2 */
+
+	{ 0x90, 0x00 }, /* 90 DAI2 EQ2 */
+	{ 0x91, 0x00 }, /* 91 DAI2 EQ2 */
+	{ 0x92, 0x00 }, /* 92 DAI2 EQ2 */
+	{ 0x93, 0x00 }, /* 93 DAI2 EQ2 */
+	{ 0x94, 0x00 }, /* 94 DAI2 EQ2 */
+	{ 0x95, 0x00 }, /* 95 DAI2 EQ2 */
+	{ 0x96, 0x00 }, /* 96 DAI2 EQ2 */
+	{ 0x97, 0x00 }, /* 97 DAI2 EQ2 */
+	{ 0x98, 0x00 }, /* 98 DAI2 EQ3 */
+	{ 0x99, 0x00 }, /* 99 DAI2 EQ3 */
+	{ 0x9a, 0x00 }, /* 9A DAI2 EQ3 */
+        { 0x9b, 0x00 }, /* 9B DAI2 EQ3 */
+	{ 0x9c, 0x00 }, /* 9C DAI2 EQ3 */
+	{ 0x9d, 0x00 }, /* 9D DAI2 EQ3 */
+	{ 0x9e, 0x00 }, /* 9E DAI2 EQ3 */
+	{ 0x9f, 0x00 }, /* 9F DAI2 EQ3 */
+
+	{ 0xa0, 0x00 }, /* A0 DAI2 EQ3 */
+	{ 0xa1, 0x00 }, /* A1 DAI2 EQ3 */
+	{ 0xa2, 0x00 }, /* A2 DAI2 EQ4 */
+	{ 0xa3, 0x00 }, /* A3 DAI2 EQ4 */
+	{ 0xa4, 0x00 }, /* A4 DAI2 EQ4 */
+	{ 0xa5, 0x00 }, /* A5 DAI2 EQ4 */
+	{ 0xa6, 0x00 }, /* A6 DAI2 EQ4 */
+	{ 0xa7, 0x00 }, /* A7 DAI2 EQ4 */
+	{ 0xa8, 0x00 }, /* A8 DAI2 EQ4 */
+	{ 0xa9, 0x00 }, /* A9 DAI2 EQ4 */
+	{ 0xaa, 0x00 }, /* AA DAI2 EQ4 */
+	{ 0xab, 0x00 }, /* AB DAI2 EQ4 */
+	{ 0xac, 0x00 }, /* AC DAI2 EQ5 */
+	{ 0xad, 0x00 }, /* AD DAI2 EQ5 */
+	{ 0xae, 0x00 }, /* AE DAI2 EQ5 */
+	{ 0xaf, 0x00 }, /* AF DAI2 EQ5 */
+
+	{ 0xb0, 0x00 }, /* B0 DAI2 EQ5 */
+	{ 0xb1, 0x00 }, /* B1 DAI2 EQ5 */
+	{ 0xb2, 0x00 }, /* B2 DAI2 EQ5 */
+	{ 0xb3, 0x00 }, /* B3 DAI2 EQ5 */
+	{ 0xb4, 0x00 }, /* B4 DAI2 EQ5 */
+	{ 0xb5, 0x00 }, /* B5 DAI2 EQ5 */
+	{ 0xb6, 0x00 }, /* B6 DAI1 biquad */
+	{ 0xb7, 0x00 }, /* B7 DAI1 biquad */
+	{ 0xb8 ,0x00 }, /* B8 DAI1 biquad */
+	{ 0xb9, 0x00 }, /* B9 DAI1 biquad */
+	{ 0xba, 0x00 }, /* BA DAI1 biquad */
+	{ 0xbb, 0x00 }, /* BB DAI1 biquad */
+	{ 0xbc, 0x00 }, /* BC DAI1 biquad */
+	{ 0xbd, 0x00 }, /* BD DAI1 biquad */
+	{ 0xbe, 0x00 }, /* BE DAI1 biquad */
+        { 0xbf, 0x00 }, /* BF DAI1 biquad */
+
+	{ 0xc0, 0x00 }, /* C0 DAI2 biquad */
+	{ 0xc1, 0x00 }, /* C1 DAI2 biquad */
+	{ 0xc2, 0x00 }, /* C2 DAI2 biquad */
+	{ 0xc3, 0x00 }, /* C3 DAI2 biquad */
+	{ 0xc4, 0x00 }, /* C4 DAI2 biquad */
+	{ 0xc5, 0x00 }, /* C5 DAI2 biquad */
+	{ 0xc6, 0x00 }, /* C6 DAI2 biquad */
+	{ 0xc7, 0x00 }, /* C7 DAI2 biquad */
+	{ 0xc8, 0x00 }, /* C8 DAI2 biquad */
+	{ 0xc9, 0x00 }, /* C9 DAI2 biquad */
 };
 
 static struct {
@@ -606,11 +536,27 @@ static struct {
        { 0xFF, 0x00, 1 }, /* FF */
 };
 
-static int max98088_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
+static bool max98088_readable_register(struct device *dev, unsigned int reg)
+{
+       return max98088_access[reg].readable;
+}
+
+static bool max98088_volatile_register(struct device *dev, unsigned int reg)
 {
        return max98088_access[reg].vol;
 }
 
+static const struct regmap_config max98088_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.readable_reg = max98088_readable_register,
+	.volatile_reg = max98088_volatile_register,
+
+	.reg_defaults = max98088_reg,
+	.num_reg_defaults = ARRAY_SIZE(max98088_reg),
+	.cache_type = REGCACHE_RBTREE,
+};
 
 /*
  * Load equalizer DSP coefficient configurations registers
@@ -1610,58 +1556,34 @@ static int max98088_dai2_digital_mute(struct snd_soc_dai *codec_dai, int mute)
        return 0;
 }
 
-static void max98088_sync_cache(struct snd_soc_codec *codec)
-{
-       u8 *reg_cache = codec->reg_cache;
-       int i;
-
-       if (!codec->cache_sync)
-               return;
-
-       codec->cache_only = 0;
-
-       /* write back cached values if they're writeable and
-        * different from the hardware default.
-        */
-       for (i = 1; i < codec->driver->reg_cache_size; i++) {
-               if (!max98088_access[i].writable)
-                       continue;
-
-               if (reg_cache[i] == max98088_reg[i])
-                       continue;
-
-               snd_soc_write(codec, i, reg_cache[i]);
-       }
-
-       codec->cache_sync = 0;
-}
-
 static int max98088_set_bias_level(struct snd_soc_codec *codec,
                                   enum snd_soc_bias_level level)
 {
-       switch (level) {
-       case SND_SOC_BIAS_ON:
-               break;
-
-       case SND_SOC_BIAS_PREPARE:
-               break;
-
-       case SND_SOC_BIAS_STANDBY:
-               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
-                       max98088_sync_cache(codec);
-
-               snd_soc_update_bits(codec, M98088_REG_4C_PWR_EN_IN,
-                               M98088_MBEN, M98088_MBEN);
-               break;
-
-       case SND_SOC_BIAS_OFF:
-               snd_soc_update_bits(codec, M98088_REG_4C_PWR_EN_IN,
-                               M98088_MBEN, 0);
-               codec->cache_sync = 1;
-               break;
-       }
-       codec->dapm.bias_level = level;
-       return 0;
+	struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+			regcache_sync(max98088->regmap);
+
+		snd_soc_update_bits(codec, M98088_REG_4C_PWR_EN_IN,
+				   M98088_MBEN, M98088_MBEN);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		snd_soc_update_bits(codec, M98088_REG_4C_PWR_EN_IN,
+				    M98088_MBEN, 0);
+		regcache_mark_dirty(max98088->regmap);
+		break;
+	}
+	codec->dapm.bias_level = level;
+	return 0;
 }
 
 #define MAX98088_RATES SNDRV_PCM_RATE_8000_96000
@@ -1988,9 +1910,9 @@ static int max98088_probe(struct snd_soc_codec *codec)
        struct max98088_cdata *cdata;
        int ret = 0;
 
-       codec->cache_sync = 1;
+       regcache_mark_dirty(max98088->regmap);
 
-       ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+       ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
        if (ret != 0) {
                dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
                return ret;
@@ -2070,10 +1992,6 @@ static struct snd_soc_codec_driver soc_codec_dev_max98088 = {
 	.set_bias_level = max98088_set_bias_level,
 	.controls = max98088_snd_controls,
 	.num_controls = ARRAY_SIZE(max98088_snd_controls),
-	.reg_cache_size = ARRAY_SIZE(max98088_reg),
-	.reg_word_size = sizeof(u8),
-	.reg_cache_default = max98088_reg,
-	.volatile_register = max98088_volatile_register,
 	.dapm_widgets = max98088_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(max98088_dapm_widgets),
 	.dapm_routes = max98088_audio_map,
@@ -2081,7 +1999,7 @@ static struct snd_soc_codec_driver soc_codec_dev_max98088 = {
 };
 
 static int max98088_i2c_probe(struct i2c_client *i2c,
-                            const struct i2c_device_id *id)
+			      const struct i2c_device_id *id)
 {
        struct max98088_priv *max98088;
        int ret;
@@ -2091,6 +2009,10 @@ static int max98088_i2c_probe(struct i2c_client *i2c,
        if (max98088 == NULL)
                return -ENOMEM;
 
+       max98088->regmap = devm_regmap_init_i2c(i2c, &max98088_regmap);
+       if (IS_ERR(max98088->regmap))
+	       return PTR_ERR(max98088->regmap);
+
        max98088->devtype = id->driver_data;
 
        i2c_set_clientdata(i2c, max98088);
-- 
1.8.4.rc3
