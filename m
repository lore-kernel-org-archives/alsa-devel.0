From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Correct WM8994 MICBIAS supply widget
	hookup
Date: Thu, 14 Jul 2011 21:34:38 +0900
Message-ID: <1310646878-31152-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 648951039E9
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jul 2011 14:35:08 +0200 (CEST)
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

The WM8994 and WM8958 series of devices have two MICBIAS supplies rather
than one, the current widget actually manages the microphone detection
control register bit (which is managed separately by the relevant API).

Fix this, hooking the relevant supplies up to the MICBIAS1 and MICBIAS2
widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 79dee89..414f817 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1206,7 +1206,6 @@ SND_SOC_DAPM_INPUT("DMIC1DAT"),
 SND_SOC_DAPM_INPUT("DMIC2DAT"),
 SND_SOC_DAPM_INPUT("Clock"),
 
-SND_SOC_DAPM_MICBIAS("MICBIAS", WM8994_MICBIAS, 2, 0),
 SND_SOC_DAPM_SUPPLY_S("MICBIAS Supply", 1, SND_SOC_NOPM, 0, 0, micbias_ev,
 		      SND_SOC_DAPM_PRE_PMU),
 
@@ -1517,8 +1516,10 @@ static const struct snd_soc_dapm_route wm8994_revd_intercon[] = {
 	{ "AIF2DACDAT", NULL, "AIF1DACDAT" },
 	{ "AIF1ADCDAT", NULL, "AIF2ADCDAT" },
 	{ "AIF2ADCDAT", NULL, "AIF1ADCDAT" },
-	{ "MICBIAS", NULL, "CLK_SYS" },
-	{ "MICBIAS", NULL, "MICBIAS Supply" },
+	{ "MICBIAS1", NULL, "CLK_SYS" },
+	{ "MICBIAS1", NULL, "MICBIAS Supply" },
+	{ "MICBIAS2", NULL, "CLK_SYS" },
+	{ "MICBIAS2", NULL, "MICBIAS Supply" },
 };
 
 static const struct snd_soc_dapm_route wm8994_intercon[] = {
-- 
1.7.5.4
