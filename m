From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH 3/3] ASoC: cs42l73: Change VSPIN/VSPOUT to
	VSPINOUT
Date: Fri, 7 Dec 2012 14:53:44 -0600
Message-ID: <1354913625-11350-3-git-send-email-Paul.Handrigan@cirrus.com>
References: <1354913625-11350-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BAC2265140
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 22:13:44 +0100 (CET)
In-Reply-To: <1354913625-11350-1-git-send-email-Paul.Handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: brian.austin@cirrus.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Since VSP only has one power bit, only provide one DAPM widget.

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 1a03c2b..fbeaef1 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -658,9 +658,7 @@ static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
 			CS42L73_PWRCTL2, 3, 1),
 	SND_SOC_DAPM_AIF_OUT("ASPOUTR", NULL,  0,
 			CS42L73_PWRCTL2, 3, 1),
-	SND_SOC_DAPM_AIF_OUT("VSPOUTL", NULL,  0,
-			CS42L73_PWRCTL2, 4, 1),
-	SND_SOC_DAPM_AIF_OUT("VSPOUTR", NULL,  0,
+	SND_SOC_DAPM_AIF_OUT("VSPINOUT", NULL,  0,
 			CS42L73_PWRCTL2, 4, 1),
 
 	SND_SOC_DAPM_PGA("PGA Left", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -686,8 +684,7 @@ static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("ASPR Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("XSPL Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("XSPR Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_MIXER("VSPL Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_MIXER("VSPR Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("VSP Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	SND_SOC_DAPM_AIF_IN("XSPINL", NULL, 0,
 				CS42L73_PWRCTL2, 0, 1),
@@ -703,7 +700,7 @@ static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("ASPINM", NULL, 0,
 				CS42L73_PWRCTL2, 2, 1),
 
-	SND_SOC_DAPM_AIF_IN("VSPIN", NULL, 0,
+	SND_SOC_DAPM_AIF_IN("VSPINOUT", NULL, 0,
 				CS42L73_PWRCTL2, 4, 1),
 
 	SND_SOC_DAPM_MIXER("HL Left Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -763,7 +760,7 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 
 	{"ESL DAC", "ESL-ASP Mono Volume", "ESL Mixer"},
 	{"ESL DAC", "ESL-XSP Mono Volume", "ESL Mixer"},
-	{"ESL DAC", "ESL-VSP Mono Volume", "VSPIN"},
+	{"ESL DAC", "ESL-VSP Mono Volume", "VSPINOUT"},
 	/* Loopback */
 	{"ESL DAC", "ESL-IP Mono Volume", "Input Left Capture"},
 	{"ESL DAC", "ESL-IP Mono Volume", "Input Right Capture"},
@@ -785,7 +782,7 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 
 	{"SPK DAC", "SPK-ASP Mono Volume", "SPK Mixer"},
 	{"SPK DAC", "SPK-XSP Mono Volume", "SPK Mixer"},
-	{"SPK DAC", "SPK-VSP Mono Volume", "VSPIN"},
+	{"SPK DAC", "SPK-VSP Mono Volume", "VSPINOUT"},
 	/* Loopback */
 	{"SPK DAC", "SPK-IP Mono Volume", "Input Left Capture"},
 	{"SPK DAC", "SPK-IP Mono Volume", "Input Right Capture"},
@@ -828,8 +825,8 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 	{"HL Right Mixer", NULL, "ASPINR"},
 	{"HL Left Mixer", NULL, "XSPINL"},
 	{"HL Right Mixer", NULL, "XSPINR"},
-	{"HL Left Mixer", NULL, "VSPIN"},
-	{"HL Right Mixer", NULL, "VSPIN"},
+	{"HL Left Mixer", NULL, "VSPINOUT"},
+	{"HL Right Mixer", NULL, "VSPINOUT"},
 
 	{"ASPINL", NULL, "ASP Playback"},
 	{"ASPINM", NULL, "ASP Playback"},
@@ -837,7 +834,7 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 	{"XSPINL", NULL, "XSP Playback"},
 	{"XSPINM", NULL, "XSP Playback"},
 	{"XSPINR", NULL, "XSP Playback"},
-	{"VSPIN", NULL, "VSP Playback"},
+	{"VSPINOUT", NULL, "VSP Playback"},
 
 	/* Capture Paths */
 	{"MIC1", NULL, "MIC1 Bias"},
@@ -879,21 +876,18 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 	{"XSPOUTR", NULL, "XSPR Output Mixer"},
 
 	/* Voice Capture */
-	{"VSPL Output Mixer", NULL, "Input Left Capture"},
-	{"VSPR Output Mixer", NULL, "Input Left Capture"},
+	{"VSP Output Mixer", NULL, "Input Left Capture"},
+	{"VSP Output Mixer", NULL, "Input Right Capture"},
 
-	{"VSPOUTL", "VSP-IP Volume", "VSPL Output Mixer"},
-	{"VSPOUTR", "VSP-IP Volume", "VSPR Output Mixer"},
+	{"VSPINOUT", "VSP-IP Volume", "VSP Output Mixer"},
 
-	{"VSPOUTL", NULL, "VSPL Output Mixer"},
-	{"VSPOUTR", NULL, "VSPR Output Mixer"},
+	{"VSPINOUT", NULL, "VSP Output Mixer"},
 
 	{"ASP Capture", NULL, "ASPOUTL"},
 	{"ASP Capture", NULL, "ASPOUTR"},
 	{"XSP Capture", NULL, "XSPOUTL"},
 	{"XSP Capture", NULL, "XSPOUTR"},
-	{"VSP Capture", NULL, "VSPOUTL"},
-	{"VSP Capture", NULL, "VSPOUTR"},
+	{"VSP Capture", NULL, "VSPINOUT"},
 };
 
 struct cs42l73_mclk_div {
-- 
1.7.0.4
