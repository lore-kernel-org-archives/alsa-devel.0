From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Add sidetone function
Date: Thu, 18 Sep 2014 14:45:59 +0800
Message-ID: <1411022759-25026-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C245E265141
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 08:46:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add sidetone function

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 9 +++++++++
 sound/soc/codecs/rt5677.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 1d4719f..4a0f3df 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -541,6 +541,7 @@ static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
+static const DECLARE_TLV_DB_SCALE(st_vol_tlv, -4650, 150, 0);
 
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
 static unsigned int bst_tlv[] = {
@@ -605,6 +606,10 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 		RT5677_MONO_ADC_L_VOL_SFT, RT5677_MONO_ADC_R_VOL_SFT, 127, 0,
 		adc_vol_tlv),
 
+	/* Sidetone Control */
+	SOC_SINGLE_TLV("Sidetone Volume", RT5677_SIDETONE_CTRL,
+		RT5677_ST_VOL_SFT, 31, 0, st_vol_tlv),
+
 	/* ADC Boost Volume Control */
 	SOC_DOUBLE_TLV("STO1 ADC Boost Volume", RT5677_STO1_2_ADC_BST,
 		RT5677_STO1_ADC_L_BST_SFT, RT5677_STO1_ADC_R_BST_SFT, 3, 0,
@@ -1993,6 +1998,9 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	/* Sidetone Mux */
 	SND_SOC_DAPM_MUX("Sidetone Mux", SND_SOC_NOPM, 0, 0,
 			&rt5677_sidetone_mux),
+	SND_SOC_DAPM_SUPPLY("Sidetone Power", RT5677_SIDETONE_CTRL,
+		RT5677_ST_EN_SFT, 0, NULL, 0),
+
 	/* VAD Mux*/
 	SND_SOC_DAPM_MUX("VAD ADC Mux", SND_SOC_NOPM, 0, 0,
 			&rt5677_vad_src_mux),
@@ -2704,6 +2712,7 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "Sidetone Mux", "DMIC4 L", "DMIC L4" },
 	{ "Sidetone Mux", "ADC1", "ADC 1" },
 	{ "Sidetone Mux", "ADC2", "ADC 2" },
+	{ "Sidetone Mux", NULL, "Sidetone Power" },
 
 	{ "Stereo DAC MIXL", "ST L Switch", "Sidetone Mux" },
 	{ "Stereo DAC MIXL", "DAC1 L Switch", "DAC1 MIXL" },
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index b61b72c..1fe8872 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -382,6 +382,10 @@
 #define RT5677_ST_SEL_SFT			9
 #define RT5677_ST_EN				(0x1 << 6)
 #define RT5677_ST_EN_SFT			6
+#define RT5677_ST_GAIN				(0x1 << 5)
+#define RT5677_ST_GAIN_SFT			5
+#define RT5677_ST_VOL_MASK			(0x1f << 0)
+#define RT5677_ST_VOL_SFT			0
 
 /* Analog DAC1/2/3 Source Control (0x15) */
 #define RT5677_ANA_DAC3_SRC_SEL_MASK		(0x3 << 4)
-- 
1.8.1.1.439.g50a6b54
