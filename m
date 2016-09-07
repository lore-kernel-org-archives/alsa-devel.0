From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: make the volume TLV to match the
	units 0.01dB
Date: Wed, 7 Sep 2016 11:07:49 +0800
Message-ID: <1473217669-29972-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 80ECE266499
 for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2016 05:08:00 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, woojoo.lee@samsung.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The volume have a step of 0.375dB, but TLV uses the units 0.01dB. It should
be changed to a step of 0.75dB to match the units of TLV.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 6 +++---
 sound/soc/codecs/rt5514.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index e0606a5..f24b7cf 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -278,7 +278,7 @@ static const DECLARE_TLV_DB_RANGE(bst_tlv,
 	8, 8, TLV_DB_SCALE_ITEM(1700, 0, 0)
 );
 
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 
 static int rt5514_dsp_voice_wake_up_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
@@ -352,10 +352,10 @@ static const struct snd_kcontrol_new rt5514_snd_controls[] = {
 	SOC_DOUBLE_TLV("MIC Boost Volume", RT5514_ANA_CTRL_MICBST,
 		RT5514_SEL_BSTL_SFT, RT5514_SEL_BSTR_SFT, 8, 0, bst_tlv),
 	SOC_DOUBLE_R_TLV("ADC1 Capture Volume", RT5514_DOWNFILTER0_CTRL1,
-		RT5514_DOWNFILTER0_CTRL2, RT5514_AD_GAIN_SFT, 127, 0,
+		RT5514_DOWNFILTER0_CTRL2, RT5514_AD_GAIN_SFT, 63, 0,
 		adc_vol_tlv),
 	SOC_DOUBLE_R_TLV("ADC2 Capture Volume", RT5514_DOWNFILTER1_CTRL1,
-		RT5514_DOWNFILTER1_CTRL2, RT5514_AD_GAIN_SFT, 127, 0,
+		RT5514_DOWNFILTER1_CTRL2, RT5514_AD_GAIN_SFT, 63, 0,
 		adc_vol_tlv),
 	SOC_SINGLE_EXT("DSP Voice Wake Up", SND_SOC_NOPM, 0, 1, 0,
 		rt5514_dsp_voice_wake_up_get, rt5514_dsp_voice_wake_up_put),
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 68883c6..229de0e 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -196,8 +196,8 @@
 #define RT5514_AD_AD_MIX_BIT			10
 #define RT5514_AD_AD_MUTE			(0x1 << 7)
 #define RT5514_AD_AD_MUTE_BIT			7
-#define RT5514_AD_GAIN_MASK			(0x7f << 0)
-#define RT5514_AD_GAIN_SFT			0
+#define RT5514_AD_GAIN_MASK			(0x3f << 1)
+#define RT5514_AD_GAIN_SFT			1
 
 /*  RT5514_ANA_CTRL_MICBST (0x2220) */
 #define RT5514_SEL_BSTL_MASK			(0xf << 4)
-- 
1.8.1.1.439.g50a6b54
