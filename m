From: <shumingf@realtek.com>
Subject: [PATCH 4/5] ASoC: rt5682: Fix the boost volume at the
	begining of playback
Date: Tue, 18 Sep 2018 19:51:38 +0800
Message-ID: <1537271498-5688-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id C85442678A9
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 13:51:44 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, albertchen@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

This patch fixed the boost volume at the begining of playback
while DAC volume set to lower level.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 2725eb7..1809966 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -68,6 +68,7 @@ struct rt5682_priv {
 
 static const struct reg_sequence patch_list[] = {
 	{0x01c1, 0x1000},
+	{RT5682_DAC_ADC_DIG_VOL1, 0xa020},
 };
 
 static const struct reg_default rt5682_reg[] = {
@@ -1468,6 +1469,8 @@ static int rt5682_hp_event(struct snd_soc_dapm_widget *w,
 			RT5682_HP_CTRL_2, 0x6000);
 		snd_soc_component_update_bits(component,
 			RT5682_DEPOP_1, 0x60, 0x60);
+		snd_soc_component_update_bits(component,
+			RT5682_DAC_ADC_DIG_VOL1, 0x00c0, 0x0080);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
@@ -1475,6 +1478,8 @@ static int rt5682_hp_event(struct snd_soc_dapm_widget *w,
 			RT5682_DEPOP_1, 0x60, 0x0);
 		snd_soc_component_write(component,
 			RT5682_HP_CTRL_2, 0x0000);
+		snd_soc_component_update_bits(component,
+			RT5682_DAC_ADC_DIG_VOL1, 0x00c0, 0x0000);
 		break;
 
 	default:
-- 
2.7.4
