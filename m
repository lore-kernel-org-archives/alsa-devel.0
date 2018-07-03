From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5682: add button detection mode control
Date: Tue, 3 Jul 2018 13:07:25 +0800
Message-ID: <1530594445-30007-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E553267731
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 07:07:39 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Bard Liao <bardliao@realtek.com>, shumingf@realtek.com, naveen.m@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We are currently using power saving mode for button detection.
However, it will impact the headset recording performance.
This patch will switch button detection to normal mode in capture
and switch to power saving mode in the end of capture.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5682.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index baad177..640d400 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -857,6 +857,8 @@ static int rt5682_button_detect(struct snd_soc_component *component)
 	btn_type = val & 0xfff0;
 	snd_soc_component_write(component, RT5682_4BTN_IL_CMD_1, val);
 	pr_debug("%s btn_type=%x\n", __func__, btn_type);
+	snd_soc_component_update_bits(component,
+		RT5682_SAR_IL_CMD_2, 0x10, 0x10);
 
 	return btn_type;
 }
@@ -1645,6 +1647,8 @@ static const struct snd_soc_dapm_widget rt5682_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Stereo1 ADC MIXR", RT5682_STO1_ADC_DIG_VOL,
 		RT5682_R_MUTE_SFT, 1, rt5682_sto1_adc_r_mix,
 		ARRAY_SIZE(rt5682_sto1_adc_r_mix)),
+	SND_SOC_DAPM_SUPPLY("BTN Detection Mode", RT5682_SAR_IL_CMD_1,
+		14, 1, NULL, 0),
 
 	/* ADC PGA */
 	SND_SOC_DAPM_PGA("Stereo1 ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -1807,6 +1811,8 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 	{"Stereo1 ADC MIXR", "ADC2 Switch", "Stereo1 ADC R2 Mux"},
 	{"Stereo1 ADC MIXR", NULL, "ADC Stereo1 Filter"},
 
+	{"ADC Stereo1 Filter", NULL, "BTN Detection Mode"},
+
 	{"Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXL"},
 	{"Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXR"},
 
-- 
2.7.4
