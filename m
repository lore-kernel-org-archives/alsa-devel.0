From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2][RESEND] ASoC: adau1761: Add ALC controls
Date: Tue, 9 Jul 2019 11:21:11 +0300
Message-ID: <20190709082111.27221-2-alexandru.ardelean@analog.com>
References: <20190614105513.6894-1-alexandru.ardelean@analog.com>
 <20190709082111.27221-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BEA6F801A4
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 10:21:27 +0200 (CEST)
In-Reply-To: <20190709082111.27221-1-alexandru.ardelean@analog.com>
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

The adau1761 has a automatic level control block that can adjust the gain
for the differential input PGA. This patch adds ALSA controls for enabling
and changing the parameter settings for the ALC.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 sound/soc/codecs/adau1761.c | 109 ++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index a9ef735f8b4e..5ca9b744b7d8 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -29,6 +29,9 @@
 #define ADAU1761_LEFT_DIFF_INPUT_VOL	0x400e
 #define ADAU1761_RIGHT_DIFF_INPUT_VOL	0x400f
 #define ADAU1761_ALC_CTRL0		0x4011
+#define ADAU1761_ALC_CTRL1		0x4012
+#define ADAU1761_ALC_CTRL2		0x4013
+#define ADAU1761_ALC_CTRL3		0x4014
 #define ADAU1761_PLAY_LR_MIXER_LEFT	0x4020
 #define ADAU1761_PLAY_MIXER_LEFT0	0x401c
 #define ADAU1761_PLAY_MIXER_LEFT1	0x401d
@@ -73,6 +76,9 @@ static const struct reg_default adau1761_reg_defaults[] = {
 	{ ADAU1761_REC_MIXER_RIGHT1,		0x00 },
 	{ ADAU1761_LEFT_DIFF_INPUT_VOL,		0x00 },
 	{ ADAU1761_ALC_CTRL0,			0x00 },
+	{ ADAU1761_ALC_CTRL1,			0x00 },
+	{ ADAU1761_ALC_CTRL2,			0x00 },
+	{ ADAU1761_ALC_CTRL3,			0x00 },
 	{ ADAU1761_RIGHT_DIFF_INPUT_VOL,	0x00 },
 	{ ADAU1761_PLAY_LR_MIXER_LEFT,		0x00 },
 	{ ADAU1761_PLAY_MIXER_LEFT0,		0x00 },
@@ -123,6 +129,10 @@ static const DECLARE_TLV_DB_SCALE(adau1761_sidetone_tlv, -1800, 300, 1);
 static const DECLARE_TLV_DB_SCALE(adau1761_boost_tlv, -600, 600, 1);
 static const DECLARE_TLV_DB_SCALE(adau1761_pga_boost_tlv, -2000, 2000, 1);
 
+static const DECLARE_TLV_DB_SCALE(adau1761_alc_max_gain_tlv, -1200, 600, 0);
+static const DECLARE_TLV_DB_SCALE(adau1761_alc_target_tlv, -2850, 150, 0);
+static const DECLARE_TLV_DB_SCALE(adau1761_alc_ng_threshold_tlv, -7650, 150, 0);
+
 static const unsigned int adau1761_bias_select_values[] = {
 	0, 2, 3,
 };
@@ -160,9 +170,91 @@ static const char * const adau1761_pga_slew_time_text[] = {
 	"96 ms",
 };
 
+static const char * const adau1761_alc_function_text[] = {
+	"Off",
+	"Right",
+	"Left",
+	"Stereo",
+	"DSP control",
+};
+
+static const char * const adau1761_alc_hold_time_text[] = {
+	"2.67 ms",
+	"5.34 ms",
+	"10.68 ms",
+	"21.36 ms",
+	"42.72 ms",
+	"85.44 ms",
+	"170.88 ms",
+	"341.76 ms",
+	"683.52 ms",
+	"1367 ms",
+	"2734.1 ms",
+	"5468.2 ms",
+	"10936 ms",
+	"21873 ms",
+	"43745 ms",
+	"87491 ms",
+};
+
+static const char * const adau1761_alc_attack_time_text[] = {
+	"6 ms",
+	"12 ms",
+	"24 ms",
+	"48 ms",
+	"96 ms",
+	"192 ms",
+	"384 ms",
+	"768 ms",
+	"1540 ms",
+	"3070 ms",
+	"6140 ms",
+	"12290 ms",
+	"24580 ms",
+	"49150 ms",
+	"98300 ms",
+	"196610 ms",
+};
+
+static const char * const adau1761_alc_decay_time_text[] = {
+	"24 ms",
+	"48 ms",
+	"96 ms",
+	"192 ms",
+	"384 ms",
+	"768 ms",
+	"15400 ms",
+	"30700 ms",
+	"61400 ms",
+	"12290 ms",
+	"24580 ms",
+	"49150 ms",
+	"98300 ms",
+	"196610 ms",
+	"393220 ms",
+	"786430 ms",
+};
+
+static const char * const adau1761_alc_ng_type_text[] = {
+	"Hold",
+	"Mute",
+	"Fade",
+	"Fade + Mute",
+};
+
 static SOC_VALUE_ENUM_SINGLE_DECL(adau1761_pga_slew_time_enum,
 		ADAU1761_ALC_CTRL0, 6, 0x3, adau1761_pga_slew_time_text,
 		adau1761_pga_slew_time_values);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_function_enum,
+		ADAU1761_ALC_CTRL0, 0, adau1761_alc_function_text);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_hold_time_enum,
+		ADAU1761_ALC_CTRL1, 4, adau1761_alc_hold_time_text);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_attack_time_enum,
+		ADAU1761_ALC_CTRL2, 4, adau1761_alc_attack_time_text);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_decay_time_enum,
+		ADAU1761_ALC_CTRL2, 0, adau1761_alc_decay_time_text);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_ng_type_enum,
+		ADAU1761_ALC_CTRL3, 6, adau1761_alc_ng_type_text);
 
 static const struct snd_kcontrol_new adau1761_jack_detect_controls[] = {
 	SOC_SINGLE("Speaker Auto-mute Switch", ADAU1761_DIGMIC_JACKDETECT,
@@ -180,6 +272,20 @@ static const struct snd_kcontrol_new adau1761_differential_mode_controls[] = {
 		ADAU1761_REC_MIXER_RIGHT1, 3, 2, 0, adau1761_pga_boost_tlv),
 
 	SOC_ENUM("PGA Capture Slew Time", adau1761_pga_slew_time_enum),
+
+	SOC_SINGLE_TLV("ALC Capture Max Gain Volume", ADAU1761_ALC_CTRL0,
+		3, 7, 0, adau1761_alc_max_gain_tlv),
+	SOC_ENUM("ALC Capture Function", adau1761_alc_function_enum),
+	SOC_ENUM("ALC Capture Hold Time", adau1761_alc_hold_time_enum),
+	SOC_SINGLE_TLV("ALC Capture Target Volume", ADAU1761_ALC_CTRL1,
+		0, 15, 0, adau1761_alc_target_tlv),
+	SOC_ENUM("ALC Capture Attack Time", adau1761_alc_decay_time_enum),
+	SOC_ENUM("ALC Capture Decay Time", adau1761_alc_attack_time_enum),
+	SOC_ENUM("ALC Capture Noise Gate Type", adau1761_alc_ng_type_enum),
+	SOC_SINGLE("ALC Capture Noise Gate Switch",
+		ADAU1761_ALC_CTRL3, 5, 1, 0),
+	SOC_SINGLE_TLV("ALC Capture Noise Gate Threshold Volume",
+		ADAU1761_ALC_CTRL3, 0, 31, 0, adau1761_alc_ng_threshold_tlv),
 };
 
 static const struct snd_kcontrol_new adau1761_single_mode_controls[] = {
@@ -652,6 +758,9 @@ static bool adau1761_readable_register(struct device *dev, unsigned int reg)
 	case ADAU1761_CLK_ENABLE0:
 	case ADAU1761_CLK_ENABLE1:
 	case ADAU1761_ALC_CTRL0:
+	case ADAU1761_ALC_CTRL1:
+	case ADAU1761_ALC_CTRL2:
+	case ADAU1761_ALC_CTRL3:
 		return true;
 	default:
 		break;
-- 
2.20.1
