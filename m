From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: WM8994: Don't disable the
	AIF[1|2]CLK_ENA unconditionaly
Date: Mon, 28 Feb 2011 17:27:30 +0000
Message-ID: <1298914051-24754-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3775103848
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 18:27:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Since we began using the late clock disable functionality, ensure that
we don't disable the clock if any of the ADC or DAC paths are still
enabled.  This happens when we have simultaneous playback and recording.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 0dc1411..4dfbaee 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -109,6 +109,9 @@ struct wm8994_priv {
 
 	unsigned int aif1clk_enable:1;
 	unsigned int aif2clk_enable:1;
+
+	unsigned int aif1clk_disable:1;
+	unsigned int aif2clk_disable:1;
 };
 
 static int wm8994_readable(struct snd_soc_codec *codec, unsigned int reg)
@@ -1014,14 +1017,18 @@ static int late_enable_ev(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (wm8994->aif1clk_enable)
+		if (wm8994->aif1clk_enable) {
 			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
 					    WM8994_AIF1CLK_ENA_MASK,
 					    WM8994_AIF1CLK_ENA);
-		if (wm8994->aif2clk_enable)
+			wm8994->aif1clk_enable = 0;
+		}
+		if (wm8994->aif2clk_enable) {
 			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
 					    WM8994_AIF2CLK_ENA_MASK,
 					    WM8994_AIF2CLK_ENA);
+			wm8994->aif2clk_enable = 0;
+		}
 		break;
 	}
 
@@ -1036,15 +1043,15 @@ static int late_disable_ev(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMD:
-		if (wm8994->aif1clk_enable) {
+		if (wm8994->aif1clk_disable) {
 			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
 					    WM8994_AIF1CLK_ENA_MASK, 0);
-			wm8994->aif1clk_enable = 0;
+			wm8994->aif1clk_disable = 0;
 		}
-		if (wm8994->aif2clk_enable) {
+		if (wm8994->aif2clk_disable) {
 			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
 					    WM8994_AIF2CLK_ENA_MASK, 0);
-			wm8994->aif2clk_enable = 0;
+			wm8994->aif2clk_disable = 0;
 		}
 		break;
 	}
@@ -1062,6 +1069,9 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMU:
 		wm8994->aif1clk_enable = 1;
 		break;
+	case SND_SOC_DAPM_POST_PMD:
+		wm8994->aif1clk_disable = 1;
+		break;
 	}
 
 	return 0;
@@ -1077,6 +1087,9 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMU:
 		wm8994->aif2clk_enable = 1;
 		break;
+	case SND_SOC_DAPM_POST_PMD:
+		wm8994->aif2clk_disable = 1;
+		break;
 	}
 
 	return 0;
-- 
1.7.4.1
