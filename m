From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2 2/2] ASoC: max98095: Get rid of
	max98095_access table
Date: Tue, 28 Jul 2015 13:30:14 +0800
Message-ID: <1438061414.22357.3.camel@ingics.com>
References: <1438061340.22357.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 879D426525B
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 07:30:20 +0200 (CEST)
Received: by pabkd10 with SMTP id kd10so63816088pab.2
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 22:30:19 -0700 (PDT)
In-Reply-To: <1438061340.22357.1.camel@ingics.com>
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
Cc: Chih-Chung Chang <chihchung@chromium.org>, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The max98095_access table is used for look up readable/writable
attributes of registers. The readable/writable/volatile registers are
mostly in continuous ranges, so we can replace the max98095_access table
entirely by using case range.

Below is a summary of the readable/writeable/volatile registers:

readable registers:
        0x01 ~ 0x97, 0xFF
writeable registers:
        0x0F ~ 0x97
volatile registers:
        0x00 ~ 0x0E, 0x98 ~ 0xFF

This patch reworks the implement for .readable and .volatile and also add
implementation for .writable callback.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: no code change, just update a copy-paste typo in commit message.
    s/max98088_access/max98095_access/

 sound/soc/codecs/max98095.c | 309 ++++----------------------------------------
 1 file changed, 23 insertions(+), 286 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 7e3814e..ad4909e 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -202,300 +202,36 @@ static const struct reg_default max98095_reg_def[] = {
 	{ 0xff, 0x00 }, /* FF */
 };
 
-static struct {
-	int readable;
-	int writable;
-} max98095_access[M98095_REG_CNT] = {
-	{ 0x00, 0x00 }, /* 00 */
-	{ 0xFF, 0x00 }, /* 01 */
-	{ 0xFF, 0x00 }, /* 02 */
-	{ 0xFF, 0x00 }, /* 03 */
-	{ 0xFF, 0x00 }, /* 04 */
-	{ 0xFF, 0x00 }, /* 05 */
-	{ 0xFF, 0x00 }, /* 06 */
-	{ 0xFF, 0x00 }, /* 07 */
-	{ 0xFF, 0x00 }, /* 08 */
-	{ 0xFF, 0x00 }, /* 09 */
-	{ 0xFF, 0x00 }, /* 0A */
-	{ 0xFF, 0x00 }, /* 0B */
-	{ 0xFF, 0x00 }, /* 0C */
-	{ 0xFF, 0x00 }, /* 0D */
-	{ 0xFF, 0x00 }, /* 0E */
-	{ 0xFF, 0x9F }, /* 0F */
-	{ 0xFF, 0xFF }, /* 10 */
-	{ 0xFF, 0xFF }, /* 11 */
-	{ 0xFF, 0xFF }, /* 12 */
-	{ 0xFF, 0xFF }, /* 13 */
-	{ 0xFF, 0xFF }, /* 14 */
-	{ 0xFF, 0xFF }, /* 15 */
-	{ 0xFF, 0xFF }, /* 16 */
-	{ 0xFF, 0xFF }, /* 17 */
-	{ 0xFF, 0xFF }, /* 18 */
-	{ 0xFF, 0xFF }, /* 19 */
-	{ 0xFF, 0xFF }, /* 1A */
-	{ 0xFF, 0xFF }, /* 1B */
-	{ 0xFF, 0xFF }, /* 1C */
-	{ 0xFF, 0xFF }, /* 1D */
-	{ 0xFF, 0x77 }, /* 1E */
-	{ 0xFF, 0x77 }, /* 1F */
-	{ 0xFF, 0x77 }, /* 20 */
-	{ 0xFF, 0x77 }, /* 21 */
-	{ 0xFF, 0x77 }, /* 22 */
-	{ 0xFF, 0x77 }, /* 23 */
-	{ 0xFF, 0xFF }, /* 24 */
-	{ 0xFF, 0x7F }, /* 25 */
-	{ 0xFF, 0x31 }, /* 26 */
-	{ 0xFF, 0xFF }, /* 27 */
-	{ 0xFF, 0xFF }, /* 28 */
-	{ 0xFF, 0xFF }, /* 29 */
-	{ 0xFF, 0xF7 }, /* 2A */
-	{ 0xFF, 0x2F }, /* 2B */
-	{ 0xFF, 0xEF }, /* 2C */
-	{ 0xFF, 0xFF }, /* 2D */
-	{ 0xFF, 0xFF }, /* 2E */
-	{ 0xFF, 0xFF }, /* 2F */
-	{ 0xFF, 0xFF }, /* 30 */
-	{ 0xFF, 0xFF }, /* 31 */
-	{ 0xFF, 0xFF }, /* 32 */
-	{ 0xFF, 0xFF }, /* 33 */
-	{ 0xFF, 0xF7 }, /* 34 */
-	{ 0xFF, 0x2F }, /* 35 */
-	{ 0xFF, 0xCF }, /* 36 */
-	{ 0xFF, 0xFF }, /* 37 */
-	{ 0xFF, 0xFF }, /* 38 */
-	{ 0xFF, 0xFF }, /* 39 */
-	{ 0xFF, 0xFF }, /* 3A */
-	{ 0xFF, 0xFF }, /* 3B */
-	{ 0xFF, 0xFF }, /* 3C */
-	{ 0xFF, 0xFF }, /* 3D */
-	{ 0xFF, 0xF7 }, /* 3E */
-	{ 0xFF, 0x2F }, /* 3F */
-	{ 0xFF, 0xCF }, /* 40 */
-	{ 0xFF, 0xFF }, /* 41 */
-	{ 0xFF, 0x77 }, /* 42 */
-	{ 0xFF, 0xFF }, /* 43 */
-	{ 0xFF, 0xFF }, /* 44 */
-	{ 0xFF, 0xFF }, /* 45 */
-	{ 0xFF, 0xFF }, /* 46 */
-	{ 0xFF, 0xFF }, /* 47 */
-	{ 0xFF, 0xFF }, /* 48 */
-	{ 0xFF, 0x0F }, /* 49 */
-	{ 0xFF, 0xFF }, /* 4A */
-	{ 0xFF, 0xFF }, /* 4B */
-	{ 0xFF, 0x3F }, /* 4C */
-	{ 0xFF, 0x3F }, /* 4D */
-	{ 0xFF, 0x3F }, /* 4E */
-	{ 0xFF, 0xFF }, /* 4F */
-	{ 0xFF, 0x7F }, /* 50 */
-	{ 0xFF, 0x7F }, /* 51 */
-	{ 0xFF, 0x0F }, /* 52 */
-	{ 0xFF, 0x3F }, /* 53 */
-	{ 0xFF, 0x3F }, /* 54 */
-	{ 0xFF, 0x3F }, /* 55 */
-	{ 0xFF, 0xFF }, /* 56 */
-	{ 0xFF, 0xFF }, /* 57 */
-	{ 0xFF, 0xBF }, /* 58 */
-	{ 0xFF, 0x1F }, /* 59 */
-	{ 0xFF, 0xBF }, /* 5A */
-	{ 0xFF, 0x1F }, /* 5B */
-	{ 0xFF, 0xBF }, /* 5C */
-	{ 0xFF, 0x3F }, /* 5D */
-	{ 0xFF, 0x3F }, /* 5E */
-	{ 0xFF, 0x7F }, /* 5F */
-	{ 0xFF, 0x7F }, /* 60 */
-	{ 0xFF, 0x47 }, /* 61 */
-	{ 0xFF, 0x9F }, /* 62 */
-	{ 0xFF, 0x9F }, /* 63 */
-	{ 0xFF, 0x9F }, /* 64 */
-	{ 0xFF, 0x9F }, /* 65 */
-	{ 0xFF, 0x9F }, /* 66 */
-	{ 0xFF, 0xBF }, /* 67 */
-	{ 0xFF, 0xBF }, /* 68 */
-	{ 0xFF, 0xFF }, /* 69 */
-	{ 0xFF, 0xFF }, /* 6A */
-	{ 0xFF, 0x7F }, /* 6B */
-	{ 0xFF, 0xF7 }, /* 6C */
-	{ 0xFF, 0xFF }, /* 6D */
-	{ 0xFF, 0xFF }, /* 6E */
-	{ 0xFF, 0x1F }, /* 6F */
-	{ 0xFF, 0xF7 }, /* 70 */
-	{ 0xFF, 0xFF }, /* 71 */
-	{ 0xFF, 0xFF }, /* 72 */
-	{ 0xFF, 0x1F }, /* 73 */
-	{ 0xFF, 0xF7 }, /* 74 */
-	{ 0xFF, 0xFF }, /* 75 */
-	{ 0xFF, 0xFF }, /* 76 */
-	{ 0xFF, 0x1F }, /* 77 */
-	{ 0xFF, 0xF7 }, /* 78 */
-	{ 0xFF, 0xFF }, /* 79 */
-	{ 0xFF, 0xFF }, /* 7A */
-	{ 0xFF, 0x1F }, /* 7B */
-	{ 0xFF, 0xF7 }, /* 7C */
-	{ 0xFF, 0xFF }, /* 7D */
-	{ 0xFF, 0xFF }, /* 7E */
-	{ 0xFF, 0x1F }, /* 7F */
-	{ 0xFF, 0xF7 }, /* 80 */
-	{ 0xFF, 0xFF }, /* 81 */
-	{ 0xFF, 0xFF }, /* 82 */
-	{ 0xFF, 0x1F }, /* 83 */
-	{ 0xFF, 0x7F }, /* 84 */
-	{ 0xFF, 0x0F }, /* 85 */
-	{ 0xFF, 0xD8 }, /* 86 */
-	{ 0xFF, 0xFF }, /* 87 */
-	{ 0xFF, 0xEF }, /* 88 */
-	{ 0xFF, 0xFE }, /* 89 */
-	{ 0xFF, 0xFE }, /* 8A */
-	{ 0xFF, 0xFF }, /* 8B */
-	{ 0xFF, 0xFF }, /* 8C */
-	{ 0xFF, 0x3F }, /* 8D */
-	{ 0xFF, 0xFF }, /* 8E */
-	{ 0xFF, 0x3F }, /* 8F */
-	{ 0xFF, 0x8F }, /* 90 */
-	{ 0xFF, 0xFF }, /* 91 */
-	{ 0xFF, 0x3F }, /* 92 */
-	{ 0xFF, 0xFF }, /* 93 */
-	{ 0xFF, 0xFF }, /* 94 */
-	{ 0xFF, 0x0F }, /* 95 */
-	{ 0xFF, 0x3F }, /* 96 */
-	{ 0xFF, 0x8C }, /* 97 */
-	{ 0x00, 0x00 }, /* 98 */
-	{ 0x00, 0x00 }, /* 99 */
-	{ 0x00, 0x00 }, /* 9A */
-	{ 0x00, 0x00 }, /* 9B */
-	{ 0x00, 0x00 }, /* 9C */
-	{ 0x00, 0x00 }, /* 9D */
-	{ 0x00, 0x00 }, /* 9E */
-	{ 0x00, 0x00 }, /* 9F */
-	{ 0x00, 0x00 }, /* A0 */
-	{ 0x00, 0x00 }, /* A1 */
-	{ 0x00, 0x00 }, /* A2 */
-	{ 0x00, 0x00 }, /* A3 */
-	{ 0x00, 0x00 }, /* A4 */
-	{ 0x00, 0x00 }, /* A5 */
-	{ 0x00, 0x00 }, /* A6 */
-	{ 0x00, 0x00 }, /* A7 */
-	{ 0x00, 0x00 }, /* A8 */
-	{ 0x00, 0x00 }, /* A9 */
-	{ 0x00, 0x00 }, /* AA */
-	{ 0x00, 0x00 }, /* AB */
-	{ 0x00, 0x00 }, /* AC */
-	{ 0x00, 0x00 }, /* AD */
-	{ 0x00, 0x00 }, /* AE */
-	{ 0x00, 0x00 }, /* AF */
-	{ 0x00, 0x00 }, /* B0 */
-	{ 0x00, 0x00 }, /* B1 */
-	{ 0x00, 0x00 }, /* B2 */
-	{ 0x00, 0x00 }, /* B3 */
-	{ 0x00, 0x00 }, /* B4 */
-	{ 0x00, 0x00 }, /* B5 */
-	{ 0x00, 0x00 }, /* B6 */
-	{ 0x00, 0x00 }, /* B7 */
-	{ 0x00, 0x00 }, /* B8 */
-	{ 0x00, 0x00 }, /* B9 */
-	{ 0x00, 0x00 }, /* BA */
-	{ 0x00, 0x00 }, /* BB */
-	{ 0x00, 0x00 }, /* BC */
-	{ 0x00, 0x00 }, /* BD */
-	{ 0x00, 0x00 }, /* BE */
-	{ 0x00, 0x00 }, /* BF */
-	{ 0x00, 0x00 }, /* C0 */
-	{ 0x00, 0x00 }, /* C1 */
-	{ 0x00, 0x00 }, /* C2 */
-	{ 0x00, 0x00 }, /* C3 */
-	{ 0x00, 0x00 }, /* C4 */
-	{ 0x00, 0x00 }, /* C5 */
-	{ 0x00, 0x00 }, /* C6 */
-	{ 0x00, 0x00 }, /* C7 */
-	{ 0x00, 0x00 }, /* C8 */
-	{ 0x00, 0x00 }, /* C9 */
-	{ 0x00, 0x00 }, /* CA */
-	{ 0x00, 0x00 }, /* CB */
-	{ 0x00, 0x00 }, /* CC */
-	{ 0x00, 0x00 }, /* CD */
-	{ 0x00, 0x00 }, /* CE */
-	{ 0x00, 0x00 }, /* CF */
-	{ 0x00, 0x00 }, /* D0 */
-	{ 0x00, 0x00 }, /* D1 */
-	{ 0x00, 0x00 }, /* D2 */
-	{ 0x00, 0x00 }, /* D3 */
-	{ 0x00, 0x00 }, /* D4 */
-	{ 0x00, 0x00 }, /* D5 */
-	{ 0x00, 0x00 }, /* D6 */
-	{ 0x00, 0x00 }, /* D7 */
-	{ 0x00, 0x00 }, /* D8 */
-	{ 0x00, 0x00 }, /* D9 */
-	{ 0x00, 0x00 }, /* DA */
-	{ 0x00, 0x00 }, /* DB */
-	{ 0x00, 0x00 }, /* DC */
-	{ 0x00, 0x00 }, /* DD */
-	{ 0x00, 0x00 }, /* DE */
-	{ 0x00, 0x00 }, /* DF */
-	{ 0x00, 0x00 }, /* E0 */
-	{ 0x00, 0x00 }, /* E1 */
-	{ 0x00, 0x00 }, /* E2 */
-	{ 0x00, 0x00 }, /* E3 */
-	{ 0x00, 0x00 }, /* E4 */
-	{ 0x00, 0x00 }, /* E5 */
-	{ 0x00, 0x00 }, /* E6 */
-	{ 0x00, 0x00 }, /* E7 */
-	{ 0x00, 0x00 }, /* E8 */
-	{ 0x00, 0x00 }, /* E9 */
-	{ 0x00, 0x00 }, /* EA */
-	{ 0x00, 0x00 }, /* EB */
-	{ 0x00, 0x00 }, /* EC */
-	{ 0x00, 0x00 }, /* ED */
-	{ 0x00, 0x00 }, /* EE */
-	{ 0x00, 0x00 }, /* EF */
-	{ 0x00, 0x00 }, /* F0 */
-	{ 0x00, 0x00 }, /* F1 */
-	{ 0x00, 0x00 }, /* F2 */
-	{ 0x00, 0x00 }, /* F3 */
-	{ 0x00, 0x00 }, /* F4 */
-	{ 0x00, 0x00 }, /* F5 */
-	{ 0x00, 0x00 }, /* F6 */
-	{ 0x00, 0x00 }, /* F7 */
-	{ 0x00, 0x00 }, /* F8 */
-	{ 0x00, 0x00 }, /* F9 */
-	{ 0x00, 0x00 }, /* FA */
-	{ 0x00, 0x00 }, /* FB */
-	{ 0x00, 0x00 }, /* FC */
-	{ 0x00, 0x00 }, /* FD */
-	{ 0x00, 0x00 }, /* FE */
-	{ 0xFF, 0x00 }, /* FF */
-};
-
 static bool max98095_readable(struct device *dev, unsigned int reg)
 {
-	if (reg >= M98095_REG_CNT)
-		return 0;
-	return max98095_access[reg].readable != 0;
+	switch (reg) {
+	case M98095_001_HOST_INT_STS ... M98095_097_PWR_SYS:
+	case M98095_0FF_REV_ID:
+		return true;
+	default:
+		return false;
+	}
 }
 
-static bool max98095_volatile(struct device *dev, unsigned int reg)
+static bool max98095_writeable(struct device *dev, unsigned int reg)
 {
-	if (reg > M98095_REG_MAX_CACHED)
-		return 1;
-
 	switch (reg) {
-	case M98095_000_HOST_DATA:
-	case M98095_001_HOST_INT_STS:
-	case M98095_002_HOST_RSP_STS:
-	case M98095_003_HOST_CMD_STS:
-	case M98095_004_CODEC_STS:
-	case M98095_005_DAI1_ALC_STS:
-	case M98095_006_DAI2_ALC_STS:
-	case M98095_007_JACK_AUTO_STS:
-	case M98095_008_JACK_MANUAL_STS:
-	case M98095_009_JACK_VBAT_STS:
-	case M98095_00A_ACC_ADC_STS:
-	case M98095_00B_MIC_NG_AGC_STS:
-	case M98095_00C_SPK_L_VOLT_STS:
-	case M98095_00D_SPK_R_VOLT_STS:
-	case M98095_00E_TEMP_SENSOR_STS:
-		return 1;
+	case M98095_00F_HOST_CFG ... M98095_097_PWR_SYS:
+		return true;
+	default:
+		return false;
 	}
+}
 
-	return 0;
+static bool max98095_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case M98095_000_HOST_DATA ... M98095_00E_TEMP_SENSOR_STS:
+	case M98095_REG_MAX_CACHED + 1 ... M98095_0FF_REV_ID:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static const struct regmap_config max98095_regmap = {
@@ -508,6 +244,7 @@ static const struct regmap_config max98095_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 
 	.readable_reg = max98095_readable,
+	.writeable_reg = max98095_writeable,
 	.volatile_reg = max98095_volatile,
 };
 
-- 
2.1.0
