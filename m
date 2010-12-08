From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: tlv320dac33: Move DACL/R power on to
	PGA widget
Date: Wed,  8 Dec 2010 15:12:57 +0200
Message-ID: <1291813977-17944-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1291813977-17944-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id E5028244A9
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 14:13:03 +0100 (CET)
In-Reply-To: <1291813977-17944-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The power for the DACs need to be enabled, even when only
the analog bypass is in use with the codec, otherwise
the audio is going to be distorted.
Make sure that the DACs are powered all the time, when
there is audio aictivity.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index d13fda0..119686a 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -590,8 +590,8 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LINEL"),
 	SND_SOC_DAPM_INPUT("LINER"),
 
-	SND_SOC_DAPM_DAC("DACL", "Left Playback", DAC33_LDAC_PWR_CTRL, 2, 0),
-	SND_SOC_DAPM_DAC("DACR", "Right Playback", DAC33_RDAC_PWR_CTRL, 2, 0),
+	SND_SOC_DAPM_DAC("DACL", "Left Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DACR", "Right Playback", SND_SOC_NOPM, 0, 0),
 
 	/* Analog bypass */
 	SND_SOC_DAPM_SWITCH("Analog Left Bypass", SND_SOC_NOPM, 0, 0,
@@ -599,6 +599,9 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Analog Right Bypass", SND_SOC_NOPM, 0, 0,
 				&dac33_dapm_abypassr_control),
 
+	SND_SOC_DAPM_PGA("Left DAC Power", DAC33_LDAC_PWR_CTRL, 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right DAC Power", DAC33_RDAC_PWR_CTRL, 2, 0, NULL, 0),
+
 	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Left Amp Power",
 			 DAC33_OUT_AMP_PWR_CTRL, 6, 3, 3, 0),
 	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Right Amp Power",
@@ -612,11 +615,14 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Analog Left Bypass", "Switch", "LINEL"},
 	{"Analog Right Bypass", "Switch", "LINER"},
 
-	{"Output Left Amp Power", NULL, "DACL"},
-	{"Output Right Amp Power", NULL, "DACR"},
+	{"Left DAC Power", NULL, "DACL"},
+	{"Right DAC Power", NULL, "DACR"},
+
+	{"Left DAC Power", NULL, "Analog Left Bypass"},
+	{"Right DAC Power", NULL, "Analog Right Bypass"},
 
-	{"Output Left Amp Power", NULL, "Analog Left Bypass"},
-	{"Output Right Amp Power", NULL, "Analog Right Bypass"},
+	{"Output Left Amp Power", NULL, "Left DAC Power"},
+	{"Output Right Amp Power", NULL, "Right DAC Power"},
 
 	/* output */
 	{"LEFT_LO", NULL, "Output Left Amp Power"},
-- 
1.7.3.2
