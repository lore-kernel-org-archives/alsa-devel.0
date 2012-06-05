From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8994: Ensure all AIFnCLK events
	are run from the _late variants
Date: Tue,  5 Jun 2012 13:52:19 +0100
Message-ID: <1338900740-24523-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73B6A2464B
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 14:52:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensure that all the actions get taken at appropriate times by calling the
_PRE and _POST events for the aifNclk_ev functions explicitly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 993639d..6d3a865 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1190,17 +1190,19 @@ static int late_enable_ev(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		if (wm8994->aif1clk_enable) {
-			aif1clk_ev(w, kcontrol, event);
+			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMU);
 			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
 					    WM8994_AIF1CLK_ENA_MASK,
 					    WM8994_AIF1CLK_ENA);
+			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_POST_PMU);
 			wm8994->aif1clk_enable = 0;
 		}
 		if (wm8994->aif2clk_enable) {
-			aif2clk_ev(w, kcontrol, event);
+			aif2clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMU);
 			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
 					    WM8994_AIF2CLK_ENA_MASK,
 					    WM8994_AIF2CLK_ENA);
+			aif2clk_ev(w, kcontrol, SND_SOC_DAPM_POST_PMU);
 			wm8994->aif2clk_enable = 0;
 		}
 		break;
@@ -1221,15 +1223,17 @@ static int late_disable_ev(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMD:
 		if (wm8994->aif1clk_disable) {
+			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMD);
 			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
 					    WM8994_AIF1CLK_ENA_MASK, 0);
-			aif1clk_ev(w, kcontrol, event);
+			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_POST_PMD);
 			wm8994->aif1clk_disable = 0;
 		}
 		if (wm8994->aif2clk_disable) {
+			aif2clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMD);
 			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
 					    WM8994_AIF2CLK_ENA_MASK, 0);
-			aif2clk_ev(w, kcontrol, event);
+			aif2clk_ev(w, kcontrol, SND_SOC_DAPM_POST_PMD);
 			wm8994->aif2clk_disable = 0;
 		}
 		break;
-- 
1.7.10
