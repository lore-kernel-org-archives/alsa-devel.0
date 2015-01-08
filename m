From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5677: Modify the behavior that
	updates the PLL parameter.
Date: Thu, 8 Jan 2015 10:31:05 +0800
Message-ID: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CDEE0260707
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 03:31:24 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, yang.a.fang@intel.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch modified the behavior that updates the PLL parameter. It set the
update bit before the PLL power up.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8900221..d27630a 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -2174,10 +2174,14 @@ static int rt5677_set_pll1_event(struct snd_soc_dapm_widget *w,
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
+	case SND_SOC_DAPM_PRE_PMU:
 		regmap_update_bits(rt5677->regmap, RT5677_PLL1_CTRL2, 0x2, 0x2);
+		break;
+
+	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(rt5677->regmap, RT5677_PLL1_CTRL2, 0x2, 0x0);
 		break;
+
 	default:
 		return 0;
 	}
@@ -2192,10 +2196,14 @@ static int rt5677_set_pll2_event(struct snd_soc_dapm_widget *w,
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
+	case SND_SOC_DAPM_PRE_PMU:
 		regmap_update_bits(rt5677->regmap, RT5677_PLL2_CTRL2, 0x2, 0x2);
+		break;
+
+	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(rt5677->regmap, RT5677_PLL2_CTRL2, 0x2, 0x0);
 		break;
+
 	default:
 		return 0;
 	}
@@ -2303,9 +2311,11 @@ static int rt5677_vref_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PLL1", RT5677_PWR_ANLG2, RT5677_PWR_PLL1_BIT,
-		0, rt5677_set_pll1_event, SND_SOC_DAPM_POST_PMU),
+		0, rt5677_set_pll1_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("PLL2", RT5677_PWR_ANLG2, RT5677_PWR_PLL2_BIT,
-		0, rt5677_set_pll2_event, SND_SOC_DAPM_POST_PMU),
+		0, rt5677_set_pll2_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU),
 
 	/* ASRC */
 	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5677_ASRC_1, 0, 0, NULL, 0),
-- 
1.8.1.1.439.g50a6b54
