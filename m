From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5640: move DAC2 Power to
	rt5640_dapm_widgets
Date: Wed, 4 Jan 2017 13:14:12 +0800
Message-ID: <1483506852-599-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B0EE3266E4A
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 06:14:27 +0100 (CET)
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

"DAC L2 Power" and "DAC R2 Power" are used by both rt5639 and rt5640.
But it was defined in rt5640_specific_dapm_widgets[]. Move them to
rt5640_dapm_widgets will let both rt5639 and rt5640 can use it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5640.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index e29a6de..0f1b216 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1227,6 +1227,10 @@ static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 		RT5640_PWR_DAC_L1_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("DAC R1 Power", RT5640_PWR_DIG1,
 		RT5640_PWR_DAC_R1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC L2 Power", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_L2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC R2 Power", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_R2_BIT, 0, NULL, 0),
 	/* SPK/OUT Mixer */
 	SND_SOC_DAPM_MIXER("SPK MIXL", RT5640_PWR_MIXER, RT5640_PWR_SM_L_BIT,
 		0, rt5640_spk_l_mix, ARRAY_SIZE(rt5640_spk_l_mix)),
@@ -1322,10 +1326,6 @@ static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 		rt5640_mono_mix, ARRAY_SIZE(rt5640_mono_mix)),
 	SND_SOC_DAPM_SUPPLY("Improve MONO Amp Drv", RT5640_PWR_ANLG1,
 		RT5640_PWR_MA_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("DAC L2 Power", RT5640_PWR_DIG1,
-		RT5640_PWR_DAC_L2_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("DAC R2 Power", RT5640_PWR_DIG1,
-		RT5640_PWR_DAC_R2_BIT, 0, NULL, 0),
 
 	SND_SOC_DAPM_OUTPUT("MONOP"),
 	SND_SOC_DAPM_OUTPUT("MONON"),
-- 
1.8.1.1.439.g50a6b54
