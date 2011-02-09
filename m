From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Dynamically manage CLK_SYS in WM8903
Date: Wed,  9 Feb 2011 17:42:56 +0000
Message-ID: <1297273377-7898-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1297273377-7898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC69F2443D
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 18:43:14 +0100 (CET)
In-Reply-To: <1297273377-7898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index a5b2d07..4aeb767 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -865,10 +865,18 @@ SND_SOC_DAPM_PGA("Right Speaker PGA", WM8903_POWER_MANAGEMENT_5, 0, 0,
 SND_SOC_DAPM_SUPPLY("Charge Pump", WM8903_CHARGE_PUMP_0, 0, 0,
 		    wm8903_cp_event, SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_SUPPLY("CLK_DSP", WM8903_CLOCK_RATES_2, 1, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("CLK_SYS", WM8903_CLOCK_RATES_2, 2, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
 
+	{ "CLK_DSP", NULL, "CLK_SYS" },
+	{ "Mic Bias", NULL, "CLK_SYS" },
+	{ "HPL_DCS", NULL, "CLK_SYS" },
+	{ "HPR_DCS", NULL, "CLK_SYS" },
+	{ "LINEOUTL_DCS", NULL, "CLK_SYS" },
+	{ "LINEOUTR_DCS", NULL, "CLK_SYS" },
+
 	{ "Left Input Mux", "IN1L", "IN1L" },
 	{ "Left Input Mux", "IN2L", "IN2L" },
 	{ "Left Input Mux", "IN3L", "IN3L" },
@@ -1064,10 +1072,11 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
+		snd_soc_update_bits(codec, WM8903_CLOCK_RATES_2,
+				    WM8903_CLK_SYS_ENA, WM8903_CLK_SYS_ENA);
 		wm8903_run_sequence(codec, 32);
-		reg = snd_soc_read(codec, WM8903_CLOCK_RATES_2);
-		reg &= ~WM8903_CLK_SYS_ENA;
-		snd_soc_write(codec, WM8903_CLOCK_RATES_2, reg);
+		snd_soc_update_bits(codec, WM8903_CLOCK_RATES_2,
+				    WM8903_CLK_SYS_ENA, 0);
 		break;
 	}
 
-- 
1.7.2.3
