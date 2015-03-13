From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: Remove adc stereo2 filter
Date: Fri, 13 Mar 2015 10:50:26 +0800
Message-ID: <1426215026-15550-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 75D07260309
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 03:50:37 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Remove adc stereo2 filter since it is not in rt5645/rt5650 codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
"ADC STO2 ASRC" is not defined in the driver already. So it is not seen
in this patch.
---
 sound/soc/codecs/rt5645.c | 3 ---
 sound/soc/codecs/rt5645.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index af468ae..e1433f9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1536,8 +1536,6 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 
 	SND_SOC_DAPM_SUPPLY_S("adc stereo1 filter", 1, RT5645_PWR_DIG2,
 		RT5645_PWR_ADC_S1F_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY_S("adc stereo2 filter", 1, RT5645_PWR_DIG2,
-		RT5645_PWR_ADC_S2F_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER_E("Sto1 ADC MIXL", SND_SOC_NOPM, 0, 0,
 		rt5645_sto1_adc_l_mix, ARRAY_SIZE(rt5645_sto1_adc_l_mix),
 		NULL, 0),
@@ -1727,7 +1725,6 @@ static const struct snd_soc_dapm_widget rt5650_specific_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 	{ "adc stereo1 filter", NULL, "ADC STO1 ASRC", is_using_asrc },
-	{ "adc stereo2 filter", NULL, "ADC STO2 ASRC", is_using_asrc },
 	{ "adc mono left filter", NULL, "ADC MONO L ASRC", is_using_asrc },
 	{ "adc mono right filter", NULL, "ADC MONO R ASRC", is_using_asrc },
 	{ "dac mono left filter", NULL, "DAC MONO L ASRC", is_using_asrc },
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index dbfd98c..db78e94 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -804,8 +804,6 @@
 #define RT5645_PWR_DAC_MF_L_BIT			10
 #define RT5645_PWR_DAC_MF_R			(0x1 << 9)
 #define RT5645_PWR_DAC_MF_R_BIT			9
-#define RT5645_PWR_ADC_S2F			(0x1 << 8)
-#define RT5645_PWR_ADC_S2F_BIT			8
 #define RT5645_PWR_PDM1				(0x1 << 7)
 #define RT5645_PWR_PDM1_BIT			7
 #define RT5645_PWR_PDM2				(0x1 << 6)
-- 
1.8.1.1.439.g50a6b54
