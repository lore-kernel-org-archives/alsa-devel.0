From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: Fix capture volume setting issue
Date: Fri, 23 Jan 2015 14:51:09 +0800
Message-ID: <1421995869-30435-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A4191265452
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 07:51:27 +0100 (CET)
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

The purpose of rt286_adc_event is to mute/numnte the ADC mixer.
However, it will also set the capture volume to default value.
As a result, "ADC0 Capture Volume" is not working if it is set
before capture start. This patch remove rt286_adc_event and add
"ADC0 Capture Switch" to mute/unmute ADC mixer.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 1d1c7f8..847cc4b 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -417,6 +417,8 @@ static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
 static const struct snd_kcontrol_new rt286_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("DAC0 Playback Volume", RT286_DACL_GAIN,
 			    RT286_DACR_GAIN, 0, 0x7f, 0, out_vol_tlv),
+	SOC_DOUBLE_R("ADC0 Capture Switch", RT286_ADCL_GAIN,
+			    RT286_ADCR_GAIN, 7, 1, 1),
 	SOC_DOUBLE_R_TLV("ADC0 Capture Volume", RT286_ADCL_GAIN,
 			    RT286_ADCR_GAIN, 0, 0x7f, 0, out_vol_tlv),
 	SOC_SINGLE_TLV("AMIC Volume", RT286_MIC_GAIN,
@@ -538,32 +540,6 @@ static int rt286_set_dmic1_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rt286_adc_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	unsigned int nid;
-
-	nid = (w->reg >> 20) & 0xff;
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(codec,
-			VERB_CMD(AC_VERB_SET_AMP_GAIN_MUTE, nid, 0),
-			0x7080, 0x7000);
-		break;
-	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(codec,
-			VERB_CMD(AC_VERB_SET_AMP_GAIN_MUTE, nid, 0),
-			0x7080, 0x7080);
-		break;
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
 static int rt286_vref_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
@@ -667,12 +643,10 @@ static const struct snd_soc_dapm_widget rt286_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("ADC 1", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* ADC Mux */
-	SND_SOC_DAPM_MUX_E("ADC 0 Mux", RT286_SET_POWER(RT286_ADC_IN1), 0, 1,
-		&rt286_adc0_mux, rt286_adc_event, SND_SOC_DAPM_PRE_PMD |
-		SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("ADC 1 Mux", RT286_SET_POWER(RT286_ADC_IN2), 0, 1,
-		&rt286_adc1_mux, rt286_adc_event, SND_SOC_DAPM_PRE_PMD |
-		SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_MUX("ADC 0 Mux", RT286_SET_POWER(RT286_ADC_IN1), 0, 1,
+		&rt286_adc0_mux),
+	SND_SOC_DAPM_MUX("ADC 1 Mux", RT286_SET_POWER(RT286_ADC_IN2), 0, 1,
+		&rt286_adc1_mux),
 
 	/* Audio Interface */
 	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
-- 
1.8.1.1.439.g50a6b54
