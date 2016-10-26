From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5640: add Mono ADC Capture Switch
	control
Date: Wed, 26 Oct 2016 09:40:44 +0800
Message-ID: <1477446044-15127-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1396426702B
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 03:40:59 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, pierre-louis.bossart@linux.intel.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Mono ADC Capture Switch control is missing in the driver. So, add it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5640.c | 2 ++
 sound/soc/codecs/rt5640.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0a7378f..e29a6de 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -423,6 +423,8 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 	SOC_DOUBLE_TLV("ADC Capture Volume", RT5640_ADC_DIG_VOL,
 			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
 			127, 0, adc_vol_tlv),
+	SOC_DOUBLE("Mono ADC Capture Switch", RT5640_DUMMY1,
+		RT5640_M_MONO_ADC_L_SFT, RT5640_M_MONO_ADC_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("Mono ADC Capture Volume", RT5640_ADC_DATA,
 			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
 			127, 0, adc_vol_tlv),
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 22c017c..b8a81173 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -1971,6 +1971,10 @@
 #define RT5640_ZCD_HP_EN			(0x1 << 15)
 
 /* General Control 1 (0xfa) */
+#define RT5640_M_MONO_ADC_L			(0x1 << 13)
+#define RT5640_M_MONO_ADC_L_SFT			13
+#define RT5640_M_MONO_ADC_R			(0x1 << 12)
+#define RT5640_M_MONO_ADC_R_SFT			12
 #define RT5640_MCLK_DET				(0x1 << 11)
 
 /* Codec Private Register definition */
-- 
1.8.1.1.439.g50a6b54
