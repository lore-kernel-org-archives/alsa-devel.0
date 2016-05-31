From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 1/2] ASoC: cs53l30: Rename the volume controls for preamplifier
Date: Tue, 31 May 2016 16:06:38 -0700
Message-ID: <1464735999-10384-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Volume controls should end with 'Volume', so this patch renames them for
ADC preamplifier.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/codecs/cs53l30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 714e579..9aff449 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -331,10 +331,10 @@ static const struct snd_kcontrol_new cs53l30_snd_controls[] = {
 	SOC_SINGLE_TLV("ADC2 NG Boost Volume", CS53L30_ADC2_NG_CTL,
 		       CS53L30_ADCx_NG_BOOST_SHIFT, 1, 0, adc_ng_boost_tlv),
 
-	SOC_DOUBLE_R_TLV("ADC1 Pre Amp Gain", CS53L30_ADC1A_AFE_CTL,
+	SOC_DOUBLE_R_TLV("ADC1 Preamplifier Volume", CS53L30_ADC1A_AFE_CTL,
 			 CS53L30_ADC1B_AFE_CTL, CS53L30_ADCxy_PREAMP_SHIFT,
 			 2, 0, pga_preamp_tlv),
-	SOC_DOUBLE_R_TLV("ADC2 Pre Amp Gain", CS53L30_ADC2A_AFE_CTL,
+	SOC_DOUBLE_R_TLV("ADC2 Preamplifier Volume", CS53L30_ADC2A_AFE_CTL,
 			 CS53L30_ADC2B_AFE_CTL, CS53L30_ADCxy_PREAMP_SHIFT,
 			 2, 0, pga_preamp_tlv),
 
-- 
2.1.4
