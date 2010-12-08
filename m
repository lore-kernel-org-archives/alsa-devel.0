From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 1/2] ASoC: tlv320dac33: Rename outpup
	amplifier widget
Date: Wed,  8 Dec 2010 16:04:32 +0200
Message-ID: <1291817073-27599-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 67CFA103B50
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 15:04:40 +0100 (CET)
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

Use better name for the widget, and remove the 'Power'
from it's name.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index d13fda0..8e340a5 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -599,9 +599,9 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Analog Right Bypass", SND_SOC_NOPM, 0, 0,
 				&dac33_dapm_abypassr_control),
 
-	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Left Amp Power",
+	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Left Amplifier",
 			 DAC33_OUT_AMP_PWR_CTRL, 6, 3, 3, 0),
-	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Right Amp Power",
+	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Right Amplifier",
 			 DAC33_OUT_AMP_PWR_CTRL, 4, 3, 3, 0),
 
 	SND_SOC_DAPM_PRE("Prepare Playback", playback_event),
@@ -612,15 +612,15 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Analog Left Bypass", "Switch", "LINEL"},
 	{"Analog Right Bypass", "Switch", "LINER"},
 
-	{"Output Left Amp Power", NULL, "DACL"},
-	{"Output Right Amp Power", NULL, "DACR"},
+	{"Output Left Amplifier", NULL, "DACL"},
+	{"Output Right Amplifier", NULL, "DACR"},
 
-	{"Output Left Amp Power", NULL, "Analog Left Bypass"},
-	{"Output Right Amp Power", NULL, "Analog Right Bypass"},
+	{"Output Left Amplifier", NULL, "Analog Left Bypass"},
+	{"Output Right Amplifier", NULL, "Analog Right Bypass"},
 
 	/* output */
-	{"LEFT_LO", NULL, "Output Left Amp Power"},
-	{"RIGHT_LO", NULL, "Output Right Amp Power"},
+	{"LEFT_LO", NULL, "Output Left Amplifier"},
+	{"RIGHT_LO", NULL, "Output Right Amplifier"},
 };
 
 static int dac33_add_widgets(struct snd_soc_codec *codec)
-- 
1.7.3.2
