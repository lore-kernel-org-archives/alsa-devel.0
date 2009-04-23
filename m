From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/21] ASoC: Support CLK_DSP in WM8903
Date: Thu, 23 Apr 2009 20:55:44 +0100
Message-ID: <1240516555-22249-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DB42310389B
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:06 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

CLK_DSP provides a master clock for the DAC and ADC related functionality
on the device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index a3a489d..27c8b94 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -846,6 +846,7 @@ SND_SOC_DAPM_PGA("Right Speaker PGA", WM8903_POWER_MANAGEMENT_5, 0, 0,
 
 SND_SOC_DAPM_SUPPLY("Charge Pump", WM8903_CHARGE_PUMP_0, 0, 0,
 		    wm8903_cp_event, SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_SUPPLY("CLK_DSP", WM8903_CLOCK_RATES_2, 1, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -891,7 +892,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "Right Input PGA", NULL, "Right Input Mode Mux" },
 
 	{ "ADCL", NULL, "Left Input PGA" },
+	{ "ADCL", NULL, "CLK_DSP" },
 	{ "ADCR", NULL, "Right Input PGA" },
+	{ "ADCR", NULL, "CLK_DSP" },
+
+	{ "DACL", NULL, "CLK_DSP" },
+	{ "DACR", NULL, "CLK_DSP" },
 
 	{ "Left Output Mixer", "Left Bypass Switch", "Left Input PGA" },
 	{ "Left Output Mixer", "Right Bypass Switch", "Right Input PGA" },
-- 
1.5.6.3
