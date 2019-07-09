From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2][RESEND] ASoC: adau1761: Add PGA Slew time
	control
Date: Tue, 9 Jul 2019 11:21:10 +0300
Message-ID: <20190709082111.27221-1-alexandru.ardelean@analog.com>
References: <20190614105513.6894-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F31B3F800E0
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 10:21:28 +0200 (CEST)
In-Reply-To: <20190614105513.6894-1-alexandru.ardelean@analog.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Lars-Peter Clausen <lars@metafoo.de>

The PGA Slew Time control allows to configure the rate with which the PGA
gain control ramps up/down to the target setting.

The PGA slew control is done via the ALC Control 0 register. There are 2
bits on that reg, that control PGA slew time, while the other bits control
parts of the ALC (automatic level control) block.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 sound/soc/codecs/adau1761.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 977f5a63be3f..a9ef735f8b4e 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -28,6 +28,7 @@
 #define ADAU1761_REC_MIXER_RIGHT1	0x400d
 #define ADAU1761_LEFT_DIFF_INPUT_VOL	0x400e
 #define ADAU1761_RIGHT_DIFF_INPUT_VOL	0x400f
+#define ADAU1761_ALC_CTRL0		0x4011
 #define ADAU1761_PLAY_LR_MIXER_LEFT	0x4020
 #define ADAU1761_PLAY_MIXER_LEFT0	0x401c
 #define ADAU1761_PLAY_MIXER_LEFT1	0x401d
@@ -71,6 +72,7 @@ static const struct reg_default adau1761_reg_defaults[] = {
 	{ ADAU1761_REC_MIXER_RIGHT0,		0x00 },
 	{ ADAU1761_REC_MIXER_RIGHT1,		0x00 },
 	{ ADAU1761_LEFT_DIFF_INPUT_VOL,		0x00 },
+	{ ADAU1761_ALC_CTRL0,			0x00 },
 	{ ADAU1761_RIGHT_DIFF_INPUT_VOL,	0x00 },
 	{ ADAU1761_PLAY_LR_MIXER_LEFT,		0x00 },
 	{ ADAU1761_PLAY_MIXER_LEFT0,		0x00 },
@@ -147,6 +149,21 @@ static SOC_VALUE_ENUM_SINGLE_DECL(adau1761_capture_bias_enum,
 		ADAU17X1_REC_POWER_MGMT, 1, 0x3, adau1761_bias_select_text,
 		adau1761_bias_select_values);
 
+static const unsigned int adau1761_pga_slew_time_values[] = {
+	3, 0, 1, 2,
+};
+
+static const char * const adau1761_pga_slew_time_text[] = {
+	"Off",
+	"24 ms",
+	"48 ms",
+	"96 ms",
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(adau1761_pga_slew_time_enum,
+		ADAU1761_ALC_CTRL0, 6, 0x3, adau1761_pga_slew_time_text,
+		adau1761_pga_slew_time_values);
+
 static const struct snd_kcontrol_new adau1761_jack_detect_controls[] = {
 	SOC_SINGLE("Speaker Auto-mute Switch", ADAU1761_DIGMIC_JACKDETECT,
 		4, 1, 0),
@@ -161,6 +178,8 @@ static const struct snd_kcontrol_new adau1761_differential_mode_controls[] = {
 
 	SOC_DOUBLE_R_TLV("PGA Boost Capture Volume", ADAU1761_REC_MIXER_LEFT1,
 		ADAU1761_REC_MIXER_RIGHT1, 3, 2, 0, adau1761_pga_boost_tlv),
+
+	SOC_ENUM("PGA Capture Slew Time", adau1761_pga_slew_time_enum),
 };
 
 static const struct snd_kcontrol_new adau1761_single_mode_controls[] = {
@@ -632,6 +651,7 @@ static bool adau1761_readable_register(struct device *dev, unsigned int reg)
 	case ADAU1761_DEJITTER:
 	case ADAU1761_CLK_ENABLE0:
 	case ADAU1761_CLK_ENABLE1:
+	case ADAU1761_ALC_CTRL0:
 		return true;
 	default:
 		break;
-- 
2.20.1
