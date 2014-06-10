From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/4] ASoC: rt5677: Replace the string "Gain" to
	"Volume"
Date: Tue, 10 Jun 2014 14:35:25 +0800
Message-ID: <1402382126-704-3-git-send-email-oder_chiou@realtek.com>
References: <1402382126-704-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D0FC2652B9
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 08:35:39 +0200 (CEST)
In-Reply-To: <1402382126-704-1-git-send-email-oder_chiou@realtek.com>
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch replaces the string "Gain" to "Volume".

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index c0b4384..438f384 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -604,19 +604,19 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 		adc_vol_tlv),
 
 	/* ADC Boost Volume Control */
-	SOC_DOUBLE_TLV("STO1 ADC Boost Gain", RT5677_STO1_2_ADC_BST,
+	SOC_DOUBLE_TLV("STO1 ADC Boost Volume", RT5677_STO1_2_ADC_BST,
 		RT5677_STO1_ADC_L_BST_SFT, RT5677_STO1_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
-	SOC_DOUBLE_TLV("STO2 ADC Boost Gain", RT5677_STO1_2_ADC_BST,
+	SOC_DOUBLE_TLV("STO2 ADC Boost Volume", RT5677_STO1_2_ADC_BST,
 		RT5677_STO2_ADC_L_BST_SFT, RT5677_STO2_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
-	SOC_DOUBLE_TLV("STO3 ADC Boost Gain", RT5677_STO3_4_ADC_BST,
+	SOC_DOUBLE_TLV("STO3 ADC Boost Volume", RT5677_STO3_4_ADC_BST,
 		RT5677_STO3_ADC_L_BST_SFT, RT5677_STO3_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
-	SOC_DOUBLE_TLV("STO4 ADC Boost Gain", RT5677_STO3_4_ADC_BST,
+	SOC_DOUBLE_TLV("STO4 ADC Boost Volume", RT5677_STO3_4_ADC_BST,
 		RT5677_STO4_ADC_L_BST_SFT, RT5677_STO4_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
-	SOC_DOUBLE_TLV("Mono ADC Boost Gain", RT5677_ADC_BST_CTRL2,
+	SOC_DOUBLE_TLV("Mono ADC Boost Volume", RT5677_ADC_BST_CTRL2,
 		RT5677_MONO_ADC_L_BST_SFT, RT5677_MONO_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
 };
-- 
1.8.1.1.439.g50a6b54
