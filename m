From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: DAPM support for ADC on WM9713 PCM
	interface
Date: Tue, 16 Sep 2008 13:49:31 +0100
Message-ID: <1221569372-15516-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080916124851.GA15445@rakim.wolfsonmicro.main>
	<1221569372-15516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B8FE24416
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Sep 2008 14:49:34 +0200 (CEST)
In-Reply-To: <1221569372-15516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The stereo ADC in the WM9713 can be used to produce data for both the
standard AC97 interface and the additional voice PCM interface. Support
use on both by defining virtual ADCs tied to each accepting the output
from the actual ADCs.

Reported-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index c10f8a3..441d058 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -419,8 +419,12 @@ SND_SOC_DAPM_MIXER("Line Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("Capture Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_DAC("Voice DAC", "Voice Playback", AC97_EXTENDED_MID, 12, 1),
 SND_SOC_DAPM_DAC("Aux DAC", "Aux Playback", AC97_EXTENDED_MID, 11, 1),
-SND_SOC_DAPM_ADC("Left ADC", "Left HiFi Capture", AC97_EXTENDED_MID, 5, 1),
-SND_SOC_DAPM_ADC("Right ADC", "Right HiFi Capture", AC97_EXTENDED_MID, 4, 1),
+SND_SOC_DAPM_PGA("Left ADC", AC97_EXTENDED_MID, 5, 1, NULL, 0),
+SND_SOC_DAPM_PGA("Right ADC", AC97_EXTENDED_MID, 4, 1, NULL, 0),
+SND_SOC_DAPM_ADC("Left HiFi ADC", "Left HiFi Capture", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_ADC("Right HiFi ADC", "Right HiFi Capture", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_ADC("Left Voice ADC", "Left Voice Capture", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_ADC("Right Voice ADC", "Right Voice Capture", SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_PGA("Left Headphone", AC97_EXTENDED_MSTATUS, 10, 1, NULL, 0),
 SND_SOC_DAPM_PGA("Right Headphone", AC97_EXTENDED_MSTATUS, 9, 1, NULL, 0),
 SND_SOC_DAPM_PGA("Left Speaker", AC97_EXTENDED_MSTATUS, 8, 1, NULL, 0),
@@ -583,9 +587,13 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	/* left ADC */
 	{"Left ADC", NULL, "Left Capture Source"},
+	{"Left Voice ADC", NULL, "Left ADC"},
+	{"Left HiFi ADC", NULL, "Left ADC"},
 
 	/* right ADC */
 	{"Right ADC", NULL, "Right Capture Source"},
+	{"Right Voice ADC", NULL, "Right ADC"},
+	{"Right HiFi ADC", NULL, "Right ADC"},
 
 	/* mic */
 	{"Mic A Pre Amp", NULL, "Mic A Source"},
-- 
1.5.6.5
