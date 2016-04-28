From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt5651: remove unexisting widget
Date: Thu, 28 Apr 2016 17:15:25 +0800
Message-ID: <1461834925-23746-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D1C462664BD
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 11:15:35 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

IN Muxes are not existing on rt5651.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5651.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 7a61970..979e3e9 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -586,44 +586,6 @@ static const struct snd_kcontrol_new hpo_r_mute_control =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5651_HP_VOL,
 				    RT5651_R_MUTE_SFT, 1, 1);
 
-/* INL/R source */
-static const char * const rt5651_inl_src[] = {"IN2P", "HPOVOLLP"};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5651_inl_enum, RT5651_INL1_INR1_VOL,
-	RT5651_INL_SEL_SFT, rt5651_inl_src);
-
-static const struct snd_kcontrol_new rt5651_inl1_mux =
-	SOC_DAPM_ENUM("INL1 source", rt5651_inl_enum);
-
-static const char * const rt5651_inr1_src[] = {"IN2N", "HPOVOLRP"};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5651_inr1_enum, RT5651_INL1_INR1_VOL,
-	RT5651_INR_SEL_SFT, rt5651_inr1_src);
-
-static const struct snd_kcontrol_new rt5651_inr1_mux =
-	SOC_DAPM_ENUM("INR1 source", rt5651_inr1_enum);
-
-static const char * const rt5651_inl2_src[] = {"IN3P", "OUTVOLLP"};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5651_inl2_enum, RT5651_INL2_INR2_VOL,
-	RT5651_INL_SEL_SFT, rt5651_inl2_src);
-
-static const struct snd_kcontrol_new rt5651_inl2_mux =
-	SOC_DAPM_ENUM("INL2 source", rt5651_inl2_enum);
-
-static const char * const rt5651_inr2_src[] = {"IN3N", "OUTVOLRP"};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5651_inr2_enum, RT5651_INL2_INR2_VOL,
-	RT5651_INR_SEL_SFT, rt5651_inr2_src);
-
-static const struct snd_kcontrol_new rt5651_inr2_mux =
-	SOC_DAPM_ENUM("INR2 source", rt5651_inr2_enum);
-
-
 /* Stereo ADC source */
 static const char * const rt5651_stereo1_adc1_src[] = {"DD MIX", "ADC"};
 
@@ -955,11 +917,6 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 			 RT5651_PWR_IN2_L_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("INR2 VOL", RT5651_PWR_VOL,
 			 RT5651_PWR_IN2_R_BIT, 0, NULL, 0),
-	/* IN Mux */
-	SND_SOC_DAPM_MUX("INL1 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inl1_mux),
-	SND_SOC_DAPM_MUX("INR1 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inr1_mux),
-	SND_SOC_DAPM_MUX("INL2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inl2_mux),
-	SND_SOC_DAPM_MUX("INR2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inr2_mux),
 	/* REC Mixer */
 	SND_SOC_DAPM_MIXER("RECMIXL", RT5651_PWR_MIXER, RT5651_PWR_RM_L_BIT, 0,
 			   rt5651_rec_l_mix, ARRAY_SIZE(rt5651_rec_l_mix)),
-- 
1.8.1.1.439.g50a6b54
