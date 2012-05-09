From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH RESEND 3/3] ASoC: cs42l73: Use DAPM routes to
	hook AIF widgets to DAI's
Date: Wed, 9 May 2012 12:33:22 -0500
Message-ID: <1336584802-12823-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe010.messaging.microsoft.com [216.32.180.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BCAC104540
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:36:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |   41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index a94e1e9..0aa56aa 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -599,17 +599,17 @@ static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("MIC2"),
 	SND_SOC_DAPM_SUPPLY("MIC2 Bias", CS42L73_PWRCTL2, 7, 1, NULL, 0),
 
-	SND_SOC_DAPM_AIF_OUT("XSPOUTL", "XSP Capture",  0,
+	SND_SOC_DAPM_AIF_OUT("XSPOUTL", NULL,  0,
 			CS42L73_PWRCTL2, 1, 1),
-	SND_SOC_DAPM_AIF_OUT("XSPOUTR", "XSP Capture",  0,
+	SND_SOC_DAPM_AIF_OUT("XSPOUTR", NULL,  0,
 			CS42L73_PWRCTL2, 1, 1),
-	SND_SOC_DAPM_AIF_OUT("ASPOUTL", "ASP Capture",  0,
+	SND_SOC_DAPM_AIF_OUT("ASPOUTL", NULL,  0,
 			CS42L73_PWRCTL2, 3, 1),
-	SND_SOC_DAPM_AIF_OUT("ASPOUTR", "ASP Capture",  0,
+	SND_SOC_DAPM_AIF_OUT("ASPOUTR", NULL,  0,
 			CS42L73_PWRCTL2, 3, 1),
-	SND_SOC_DAPM_AIF_OUT("VSPOUTL", "VSP Capture",  0,
+	SND_SOC_DAPM_AIF_OUT("VSPOUTL", NULL,  0,
 			CS42L73_PWRCTL2, 4, 1),
-	SND_SOC_DAPM_AIF_OUT("VSPOUTR", "VSP Capture",  0,
+	SND_SOC_DAPM_AIF_OUT("VSPOUTR", NULL,  0,
 			CS42L73_PWRCTL2, 4, 1),
 
 	SND_SOC_DAPM_PGA("PGA Left", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -638,21 +638,21 @@ static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("VSPL Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("VSPR Output Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 
-	SND_SOC_DAPM_AIF_IN("XSPINL", "XSP Playback", 0,
+	SND_SOC_DAPM_AIF_IN("XSPINL", NULL, 0,
 				CS42L73_PWRCTL2, 0, 1),
-	SND_SOC_DAPM_AIF_IN("XSPINR", "XSP Playback", 0,
+	SND_SOC_DAPM_AIF_IN("XSPINR", NULL, 0,
 				CS42L73_PWRCTL2, 0, 1),
-	SND_SOC_DAPM_AIF_IN("XSPINM", "XSP Playback", 0,
+	SND_SOC_DAPM_AIF_IN("XSPINM", NULL, 0,
 				CS42L73_PWRCTL2, 0, 1),
 
-	SND_SOC_DAPM_AIF_IN("ASPINL", "ASP Playback", 0,
+	SND_SOC_DAPM_AIF_IN("ASPINL", NULL, 0,
 				CS42L73_PWRCTL2, 2, 1),
-	SND_SOC_DAPM_AIF_IN("ASPINR", "ASP Playback", 0,
+	SND_SOC_DAPM_AIF_IN("ASPINR", NULL, 0,
 				CS42L73_PWRCTL2, 2, 1),
-	SND_SOC_DAPM_AIF_IN("ASPINM", "ASP Playback", 0,
+	SND_SOC_DAPM_AIF_IN("ASPINM", NULL, 0,
 				CS42L73_PWRCTL2, 2, 1),
 
-	SND_SOC_DAPM_AIF_IN("VSPIN", "VSP Playback", 0,
+	SND_SOC_DAPM_AIF_IN("VSPIN", NULL, 0,
 				CS42L73_PWRCTL2, 4, 1),
 
 	SND_SOC_DAPM_MIXER("HL Left Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -776,6 +776,14 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 	{"HL Left Mixer", NULL, "VSPIN"},
 	{"HL Right Mixer", NULL, "VSPIN"},
 
+	{"ASPINL", NULL, "ASP Playback"},
+	{"ASPINM", NULL, "ASP Playback"},
+	{"ASPINR", NULL, "ASP Playback"},
+	{"XSPINL", NULL, "XSP Playback"},
+	{"XSPINM", NULL, "XSP Playback"},
+	{"XSPINR", NULL, "XSP Playback"},
+	{"VSPIN", NULL, "VSP Playback"},
+
 	/* Capture Paths */
 	{"MIC1", NULL, "MIC1 Bias"},
 	{"PGA Left Mux", "Mic 1", "MIC1"},
@@ -822,6 +830,13 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 
 	{"VSPOUTL", NULL, "VSPL Output Mixer"},
 	{"VSPOUTR", NULL, "VSPR Output Mixer"},
+
+	{"ASP Capture", NULL, "ASPOUTL"},
+	{"ASP Capture", NULL, "ASPOUTR"},
+	{"XSP Capture", NULL, "XSPOUTL"},
+	{"XSP Capture", NULL, "XSPOUTR"},
+	{"VSP Capture", NULL, "VSPOUTL"},
+	{"VSP Capture", NULL, "VSPOUTR"},
 };
 
 struct cs42l73_mclk_div {
-- 
1.7.10
