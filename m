From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: remove unused rt5645_clk_sel_put
Date: Tue, 11 Nov 2014 11:31:28 +0800
Message-ID: <1415676688-22528-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 72543261A2F
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 04:31:58 +0100 (CET)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Remove rt5645_clk_sel_put function since it is never used.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 59 -----------------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1adab38..d6298b3 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -443,65 +443,6 @@ static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_sel_enum,
 				RT5645_TDM_CTRL_1, 8,
 				rt5645_tdm_adc_data_select);
 
-static int rt5645_clk_sel_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	unsigned int u_bit = 0, p_bit = 0;
-	struct soc_enum *em =
-		(struct soc_enum *)kcontrol->private_value;
-
-	switch (em->reg) {
-	case RT5645_ASRC_2:
-		switch (em->shift_l) {
-		case 0:
-			u_bit = 0x8;
-			p_bit = RT5645_PWR_ADC_S1F;
-			break;
-		case 4:
-			u_bit = 0x100;
-			p_bit = RT5645_PWR_DAC_MF_R;
-			break;
-		case 8:
-			u_bit = 0x200;
-			p_bit = RT5645_PWR_DAC_MF_L;
-			break;
-		case 12:
-			u_bit = 0x400;
-			p_bit = RT5645_PWR_DAC_S1F;
-			break;
-		}
-		break;
-	case RT5645_ASRC_3:
-		switch (em->shift_l) {
-		case 0:
-			u_bit = 0x1;
-			p_bit = RT5645_PWR_ADC_MF_R;
-			break;
-		case 4:
-			u_bit = 0x2;
-			p_bit = RT5645_PWR_ADC_MF_L;
-			break;
-		}
-		break;
-	}
-
-	if (u_bit || p_bit) {
-		switch (ucontrol->value.integer.value[0]) {
-		case 1 ... 4: /*enable*/
-			if (snd_soc_read(codec, RT5645_PWR_DIG2) & p_bit)
-				snd_soc_update_bits(codec,
-					RT5645_ASRC_1, u_bit, u_bit);
-			break;
-		default: /*disable*/
-			snd_soc_update_bits(codec, RT5645_ASRC_1, u_bit, 0);
-			break;
-		}
-	}
-
-	return snd_soc_put_enum_double(kcontrol, ucontrol);
-}
-
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
-- 
1.8.1.1.439.g50a6b54
