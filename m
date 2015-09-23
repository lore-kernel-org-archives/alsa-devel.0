From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/4] ASoC: rt5645: Use the type
	SOC_DAPM_SINGLE_AUTODISABLE to prevent the weird sound in
	runtime of power up
Date: Wed, 23 Sep 2015 14:35:28 +0800
Message-ID: <1442990130-15801-2-git-send-email-oder_chiou@realtek.com>
References: <1442990130-15801-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4727B2604A3
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 08:35:41 +0200 (CEST)
In-Reply-To: <1442990130-15801-1-git-send-email-oder_chiou@realtek.com>
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
Cc: sy0704.lee@samsung.com, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index b0d96b6..0249abc 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -732,14 +732,14 @@ static const struct snd_kcontrol_new rt5645_mono_adc_r_mix[] = {
 static const struct snd_kcontrol_new rt5645_dac_l_mix[] = {
 	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5645_AD_DA_MIXER,
 			RT5645_M_ADCMIX_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 Switch", RT5645_AD_DA_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 Switch", RT5645_AD_DA_MIXER,
 			RT5645_M_DAC1_L_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5645_dac_r_mix[] = {
 	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5645_AD_DA_MIXER,
 			RT5645_M_ADCMIX_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 Switch", RT5645_AD_DA_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 Switch", RT5645_AD_DA_MIXER,
 			RT5645_M_DAC1_R_SFT, 1, 1),
 };
 
-- 
1.8.1.1.439.g50a6b54
