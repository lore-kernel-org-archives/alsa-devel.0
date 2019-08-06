From: <shumingf@realtek.com>
Subject: [PATCH RESEND] ASoC: rt1011: Add R0 temperature and
	TDM1 ADC2DAT Swap control
Date: Tue, 6 Aug 2019 17:14:35 +0800
Message-ID: <20190806091435.14329-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7BB8F800F4
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 11:14:50 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Shuming Fan <shumingf@realtek.com>, derek.fang@realtek.com, sathya.prakash.m.r@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

- The user level application could set the R0 temperature after booting system.
  The degree Celsius of R0 temperature store in the non-volatile space
  when doing R0 calibration.
- TDM1 ADC2DAT Swap controls use to control TDM slot2/3 data

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1011.c | 9 ++++++++-
 sound/soc/codecs/rt1011.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 0a6ff13d76e1..b25b4c1127ca 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1029,6 +1029,8 @@ static const char * const rt1011_tdm_adc_swap_select[] = {
 
 static SOC_ENUM_SINGLE_DECL(rt1011_tdm_adc1_1_enum,	RT1011_TDM1_SET_3, 6,
 	rt1011_tdm_adc_swap_select);
+static SOC_ENUM_SINGLE_DECL(rt1011_tdm_adc2_1_enum,	RT1011_TDM1_SET_3, 4,
+	rt1011_tdm_adc_swap_select);
 
 static void rt1011_reset(struct regmap *regmap)
 {
@@ -1333,7 +1335,8 @@ static const struct snd_kcontrol_new rt1011_snd_controls[] = {
 	/* TDM1 Data Out Selection */
 	SOC_ENUM("TDM1 DOUT Source", rt1011_tdm1_adc1_dat_enum),
 	SOC_ENUM("TDM1 DOUT Location", rt1011_tdm1_adc1_loc_enum),
-	SOC_ENUM("TDM1 ADCDAT Swap Select", rt1011_tdm_adc1_1_enum),
+	SOC_ENUM("TDM1 ADC1DAT Swap Select", rt1011_tdm_adc1_1_enum),
+	SOC_ENUM("TDM1 ADC2DAT Swap Select", rt1011_tdm_adc2_1_enum),
 
 	/* Data Out Mode */
 	SOC_ENUM("I2S ADC DOUT Mode", rt1011_adc_dout_mode_enum),
@@ -1355,6 +1358,10 @@ static const struct snd_kcontrol_new rt1011_snd_controls[] = {
 	SOC_SINGLE_EXT("R0 Calibration", SND_SOC_NOPM, 0, 1, 0,
 		rt1011_r0_cali_get, rt1011_r0_cali_put),
 	RT1011_R0_LOAD("R0 Load Mode"),
+
+	/* R0 temperature */
+	SOC_SINGLE("R0 Temperature", RT1011_STP_INITIAL_RESISTANCE_TEMP,
+		2, 255, 0),
 };
 
 static int rt1011_is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
diff --git a/sound/soc/codecs/rt1011.h b/sound/soc/codecs/rt1011.h
index 98a38800c4df..5d431d7f1d16 100644
--- a/sound/soc/codecs/rt1011.h
+++ b/sound/soc/codecs/rt1011.h
@@ -227,6 +227,7 @@
 #define RT1011_STP_CALIB_RS_TEMP			0x152a
 #define RT1011_INIT_RECIPROCAL_REG_24_16				0x1538
 #define RT1011_INIT_RECIPROCAL_REG_15_0				0x1539
+#define RT1011_STP_INITIAL_RESISTANCE_TEMP				0x153c
 #define RT1011_STP_ALPHA_RECIPROCAL_MSB				0x153e
 #define RT1011_SPK_RESISTANCE_1				0x1544
 #define RT1011_SPK_RESISTANCE_2				0x1546
-- 
2.22.0
