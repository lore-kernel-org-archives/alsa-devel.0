From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 6/6] ASoC: rt5645: make volume TLV closer
	to	reality
Date: Thu, 30 Apr 2015 18:18:47 +0800
Message-ID: <1430389127-24609-6-git-send-email-bardliao@realtek.com>
References: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 60A5E265D3D
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 12:19:16 +0200 (CEST)
In-Reply-To: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The volume blocks have an step of 0.375dB, but TLV uses 0.01dB for
units.  Only use the resolution supported, ignoring the LSB of the
volume register.  This results in half the steps and 0.75dB per step,
but reports accurate levels through TLV.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
I didn't change the header file. It is because we can keep the header
file match to the datasheet. Also, user will know we skip the LSB of
the volume register by reading the source code.
---
 sound/soc/codecs/rt5645.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index f400cf9..71716c0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -417,9 +417,9 @@ static bool rt5645_readable_register(struct device *dev, unsigned int reg)
 }
 
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6525, 75, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
@@ -459,9 +459,9 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	SOC_DOUBLE("DAC2 Playback Switch", RT5645_DAC_CTRL,
 		RT5645_M_DAC_L2_VOL_SFT, RT5645_M_DAC_R2_VOL_SFT, 1, 1),
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5645_DAC1_DIG_VOL,
-		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 175, 0, dac_vol_tlv),
+		RT5645_L_VOL_SFT + 1, RT5645_R_VOL_SFT + 1, 87, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5645_DAC2_DIG_VOL,
-		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 175, 0, dac_vol_tlv),
+		RT5645_L_VOL_SFT + 1, RT5645_R_VOL_SFT + 1, 87, 0, dac_vol_tlv),
 
 	/* IN1/IN2 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5645_IN1_CTRL1,
@@ -477,11 +477,11 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	SOC_DOUBLE("ADC Capture Switch", RT5645_STO1_ADC_DIG_VOL,
 		RT5645_L_MUTE_SFT, RT5645_R_MUTE_SFT, 1, 1),
 	SOC_DOUBLE_TLV("ADC Capture Volume", RT5645_STO1_ADC_DIG_VOL,
-		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 127, 0, adc_vol_tlv),
+		RT5645_L_VOL_SFT + 1, RT5645_R_VOL_SFT + 1, 63, 0, adc_vol_tlv),
 	SOC_DOUBLE("Mono ADC Capture Switch", RT5645_MONO_ADC_DIG_VOL,
 		RT5645_L_MUTE_SFT, RT5645_R_MUTE_SFT, 1, 1),
 	SOC_DOUBLE_TLV("Mono ADC Capture Volume", RT5645_MONO_ADC_DIG_VOL,
-		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 127, 0, adc_vol_tlv),
+		RT5645_L_VOL_SFT + 1, RT5645_R_VOL_SFT + 1, 63, 0, adc_vol_tlv),
 
 	/* ADC Boost Volume Control */
 	SOC_DOUBLE_TLV("STO1 ADC Boost Gain", RT5645_ADC_BST_VOL1,
-- 
1.8.1.1.439.g50a6b54
