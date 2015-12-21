From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5616: rename some alsa control names
Date: Mon, 21 Dec 2015 10:09:53 +0800
Message-ID: <1450663793-3351-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D43292610A6
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 03:10:10 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, zhengsq@rock-chips.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Rename some alsa control name as what they should be.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5616.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index f4005cb..4de8c86 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -323,9 +323,9 @@ static const struct snd_kcontrol_new rt5616_snd_controls[] = {
 			RT5616_L_VOL_SFT, RT5616_R_VOL_SFT,
 			175, 0, dac_vol_tlv),
 	/* IN1/IN2 Control */
-	SOC_SINGLE_TLV("IN1 Boost", RT5616_IN1_IN2,
+	SOC_SINGLE_TLV("IN1 Boost Volume", RT5616_IN1_IN2,
 		RT5616_BST_SFT1, 8, 0, bst_tlv),
-	SOC_SINGLE_TLV("IN2 Boost", RT5616_IN1_IN2,
+	SOC_SINGLE_TLV("IN2 Boost Volume", RT5616_IN1_IN2,
 		RT5616_BST_SFT2, 8, 0, bst_tlv),
 	/* INL/INR Volume Control */
 	SOC_DOUBLE_TLV("IN Capture Volume", RT5616_INL1_INR1_VOL,
@@ -339,7 +339,7 @@ static const struct snd_kcontrol_new rt5616_snd_controls[] = {
 			127, 0, adc_vol_tlv),
 
 	/* ADC Boost Volume Control */
-	SOC_DOUBLE_TLV("ADC Boost Gain", RT5616_ADC_BST_VOL,
+	SOC_DOUBLE_TLV("ADC Boost Volume", RT5616_ADC_BST_VOL,
 			RT5616_ADC_L_BST_SFT, RT5616_ADC_R_BST_SFT,
 			3, 0, adc_bst_tlv),
 };
-- 
1.8.1.1.439.g50a6b54
