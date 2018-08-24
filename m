From: <shumingf@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5682: Change DAC/ADC volume scale
Date: Fri, 24 Aug 2018 10:52:19 +0800
Message-ID: <1535079139-9982-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A73E26782E
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2018 04:52:26 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koonc@google.com, albertchen@realtek.com, alexlee@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

The step of DAC/ADC volume scale changes from 0.375dB to 0.75dB

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 0ea2759..731c6a8 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -750,8 +750,8 @@ static bool rt5682_readable_register(struct device *dev, unsigned int reg)
 }
 
 static const DECLARE_TLV_DB_SCALE(hp_vol_tlv, -2250, 150, 0);
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6525, 75, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
@@ -1114,7 +1114,7 @@ static const struct snd_kcontrol_new rt5682_snd_controls[] = {
 
 	/* DAC Digital Volume */
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5682_DAC1_DIG_VOL,
-		RT5682_L_VOL_SFT, RT5682_R_VOL_SFT, 175, 0, dac_vol_tlv),
+		RT5682_L_VOL_SFT + 1, RT5682_R_VOL_SFT + 1, 86, 0, dac_vol_tlv),
 
 	/* IN Boost Volume */
 	SOC_SINGLE_TLV("CBJ Boost Volume", RT5682_CBJ_BST_CTRL,
@@ -1124,7 +1124,7 @@ static const struct snd_kcontrol_new rt5682_snd_controls[] = {
 	SOC_DOUBLE("STO1 ADC Capture Switch", RT5682_STO1_ADC_DIG_VOL,
 		RT5682_L_MUTE_SFT, RT5682_R_MUTE_SFT, 1, 1),
 	SOC_DOUBLE_TLV("STO1 ADC Capture Volume", RT5682_STO1_ADC_DIG_VOL,
-		RT5682_L_VOL_SFT, RT5682_R_VOL_SFT, 127, 0, adc_vol_tlv),
+		RT5682_L_VOL_SFT + 1, RT5682_R_VOL_SFT + 1, 63, 0, adc_vol_tlv),
 
 	/* ADC Boost Volume Control */
 	SOC_DOUBLE_TLV("STO1 ADC Boost Gain Volume", RT5682_STO1_ADC_BOOST,
-- 
2.7.4
