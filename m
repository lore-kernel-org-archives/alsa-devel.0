From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Fix broken bitfield definitions in
	WM8978
Date: Wed,  2 Mar 2011 11:04:44 +0000
Message-ID: <1299063885-27125-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A83231037EC
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 12:04:25 +0100 (CET)
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
 sound/soc/codecs/wm8978.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 30fb48e..7ce4f49 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -145,18 +145,18 @@ static const struct snd_kcontrol_new wm8978_snd_controls[] = {
 	SOC_SINGLE("DAC Playback Limiter Threshold",
 		WM8978_DAC_LIMITER_2, 4, 7, 0),
 	SOC_SINGLE("DAC Playback Limiter Boost",
-		WM8978_DAC_LIMITER_2, 0, 15, 0),
+		WM8978_DAC_LIMITER_2, 0, 12, 0),
 
 	SOC_ENUM("ALC Enable Switch", alc1),
 	SOC_SINGLE("ALC Capture Min Gain", WM8978_ALC_CONTROL_1, 0, 7, 0),
 	SOC_SINGLE("ALC Capture Max Gain", WM8978_ALC_CONTROL_1, 3, 7, 0),
 
-	SOC_SINGLE("ALC Capture Hold", WM8978_ALC_CONTROL_2, 4, 7, 0),
+	SOC_SINGLE("ALC Capture Hold", WM8978_ALC_CONTROL_2, 4, 10, 0),
 	SOC_SINGLE("ALC Capture Target", WM8978_ALC_CONTROL_2, 0, 15, 0),
 
 	SOC_ENUM("ALC Capture Mode", alc3),
-	SOC_SINGLE("ALC Capture Decay", WM8978_ALC_CONTROL_3, 4, 15, 0),
-	SOC_SINGLE("ALC Capture Attack", WM8978_ALC_CONTROL_3, 0, 15, 0),
+	SOC_SINGLE("ALC Capture Decay", WM8978_ALC_CONTROL_3, 4, 10, 0),
+	SOC_SINGLE("ALC Capture Attack", WM8978_ALC_CONTROL_3, 0, 10, 0),
 
 	SOC_SINGLE("ALC Capture Noise Gate Switch", WM8978_NOISE_GATE, 3, 1, 0),
 	SOC_SINGLE("ALC Capture Noise Gate Threshold",
@@ -211,8 +211,10 @@ static const struct snd_kcontrol_new wm8978_snd_controls[] = {
 		WM8978_LOUT2_SPK_CONTROL, WM8978_ROUT2_SPK_CONTROL, 6, 1, 1),
 
 	/* DAC / ADC oversampling */
-	SOC_SINGLE("DAC 128x Oversampling Switch", WM8978_DAC_CONTROL, 8, 1, 0),
-	SOC_SINGLE("ADC 128x Oversampling Switch", WM8978_ADC_CONTROL, 8, 1, 0),
+	SOC_SINGLE("DAC 128x Oversampling Switch", WM8978_DAC_CONTROL,
+		   5, 1, 0),
+	SOC_SINGLE("ADC 128x Oversampling Switch", WM8978_ADC_CONTROL,
+		   5, 1, 0),
 };
 
 /* Mixer #1: Output (OUT1, OUT2) Mixer: mix AUX, Input mixer output and DAC */
-- 
1.7.2.3
