From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: WM8903: HP and Line out PGA/mixer DAPM
	fixes
Date: Thu,  7 Apr 2011 11:08:38 -0600
Message-ID: <1302196118-17941-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BD91C103800
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 19:08:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Dilan Lee <dilee@nvidia.com>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Dilan Lee <dilee@nvidia.com>

Update the headphone and line out mixers and PGAs use the same logical
set of register bits and sequencing as the speaker mixer/PGA.

This allows ALSA controls for mute and volume on headphone and line out
to operate correctly.

Per conversation on alsa-devel, earlier datasheets indicated that the
POWER_MANAGEMENT_* register bits 0 and 1 were aliases to ANALOG_* register
bits 0 and 4, and hence only one copy of those bits was programmed.
However, later datasheets corrected this.

From: Dilan Lee <dilee@nvidia.com>
[swarren: Applied same change to headphone widgets]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Runtime tested in chromeos-2.6.37 which uses ASoC for-2.6.39 backport.
Compile tesed in ASoC for-2.6.40; needed to disable USB due to apparent
  existing build break there.

 sound/soc/codecs/wm8903.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index a739e09..d53f206 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -247,8 +247,6 @@ static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int re
 	case WM8903_REVISION_NUMBER:
 	case WM8903_INTERRUPT_STATUS_1:
 	case WM8903_WRITE_SEQUENCER_4:
-	case WM8903_POWER_MANAGEMENT_3:
-	case WM8903_POWER_MANAGEMENT_2:
 	case WM8903_DC_SERVO_READBACK_1:
 	case WM8903_DC_SERVO_READBACK_2:
 	case WM8903_DC_SERVO_READBACK_3:
@@ -875,34 +873,40 @@ SND_SOC_DAPM_MIXER("Left Speaker Mixer", WM8903_POWER_MANAGEMENT_4, 1, 0,
 SND_SOC_DAPM_MIXER("Right Speaker Mixer", WM8903_POWER_MANAGEMENT_4, 0, 0,
 		   right_speaker_mixer, ARRAY_SIZE(right_speaker_mixer)),
 
-SND_SOC_DAPM_PGA_S("Left Headphone Output PGA", 0, WM8903_ANALOGUE_HP_0,
-		   4, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("Right Headphone Output PGA", 0, WM8903_ANALOGUE_HP_0,
+SND_SOC_DAPM_PGA_S("Left Headphone Output PGA", 0, WM8903_POWER_MANAGEMENT_2,
+		   1, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("Right Headphone Output PGA", 0, WM8903_POWER_MANAGEMENT_2,
 		   0, 0, NULL, 0),
 
-SND_SOC_DAPM_PGA_S("Left Line Output PGA", 0, WM8903_ANALOGUE_LINEOUT_0, 4, 0,
+SND_SOC_DAPM_PGA_S("Left Line Output PGA", 0, WM8903_POWER_MANAGEMENT_3, 1, 0,
 		   NULL, 0),
-SND_SOC_DAPM_PGA_S("Right Line Output PGA", 0, WM8903_ANALOGUE_LINEOUT_0, 0, 0,
+SND_SOC_DAPM_PGA_S("Right Line Output PGA", 0, WM8903_POWER_MANAGEMENT_3, 0, 0,
 		   NULL, 0),
 
 SND_SOC_DAPM_PGA_S("HPL_RMV_SHORT", 4, WM8903_ANALOGUE_HP_0, 7, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPL_ENA_OUTP", 3, WM8903_ANALOGUE_HP_0, 6, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("HPL_ENA_DLY", 1, WM8903_ANALOGUE_HP_0, 5, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPL_ENA_DLY", 2, WM8903_ANALOGUE_HP_0, 5, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPL_ENA", 1, WM8903_ANALOGUE_HP_0, 4, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPR_RMV_SHORT", 4, WM8903_ANALOGUE_HP_0, 3, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPR_ENA_OUTP", 3, WM8903_ANALOGUE_HP_0, 2, 0, NULL, 0),
-SND_SOC_DAPM_PGA_S("HPR_ENA_DLY", 1, WM8903_ANALOGUE_HP_0, 1, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPR_ENA_DLY", 2, WM8903_ANALOGUE_HP_0, 1, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPR_ENA", 1, WM8903_ANALOGUE_HP_0, 0, 0, NULL, 0),
 
 SND_SOC_DAPM_PGA_S("LINEOUTL_RMV_SHORT", 4, WM8903_ANALOGUE_LINEOUT_0, 7, 0,
 		   NULL, 0),
 SND_SOC_DAPM_PGA_S("LINEOUTL_ENA_OUTP", 3, WM8903_ANALOGUE_LINEOUT_0, 6, 0,
 		   NULL, 0),
-SND_SOC_DAPM_PGA_S("LINEOUTL_ENA_DLY", 1, WM8903_ANALOGUE_LINEOUT_0, 5, 0,
+SND_SOC_DAPM_PGA_S("LINEOUTL_ENA_DLY", 2, WM8903_ANALOGUE_LINEOUT_0, 5, 0,
+		   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTL_ENA", 1, WM8903_ANALOGUE_LINEOUT_0, 4, 0,
 		   NULL, 0),
 SND_SOC_DAPM_PGA_S("LINEOUTR_RMV_SHORT", 4, WM8903_ANALOGUE_LINEOUT_0, 3, 0,
 		   NULL, 0),
 SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_OUTP", 3, WM8903_ANALOGUE_LINEOUT_0, 2, 0,
 		   NULL, 0),
-SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_DLY", 1, WM8903_ANALOGUE_LINEOUT_0, 1, 0,
+SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_DLY", 2, WM8903_ANALOGUE_LINEOUT_0, 1, 0,
+		   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTR_ENA", 1, WM8903_ANALOGUE_LINEOUT_0, 0, 0,
 		   NULL, 0),
 
 SND_SOC_DAPM_SUPPLY("DCS Master", WM8903_DC_SERVO_0, 4, 0, NULL, 0),
@@ -1037,10 +1041,14 @@ static const struct snd_soc_dapm_route wm8903_intercon[] = {
 	{ "Left Speaker PGA", NULL, "Left Speaker Mixer" },
 	{ "Right Speaker PGA", NULL, "Right Speaker Mixer" },
 
-	{ "HPL_ENA_DLY", NULL, "Left Headphone Output PGA" },
-	{ "HPR_ENA_DLY", NULL, "Right Headphone Output PGA" },
-	{ "LINEOUTL_ENA_DLY", NULL, "Left Line Output PGA" },
-	{ "LINEOUTR_ENA_DLY", NULL, "Right Line Output PGA" },
+	{ "HPL_ENA", NULL, "Left Headphone Output PGA" },
+	{ "HPR_ENA", NULL, "Right Headphone Output PGA" },
+	{ "HPL_ENA_DLY", NULL, "HPL_ENA" },
+	{ "HPR_ENA_DLY", NULL, "HPR_ENA" },
+	{ "LINEOUTL_ENA", NULL, "Left Line Output PGA" },
+	{ "LINEOUTR_ENA", NULL, "Right Line Output PGA" },
+	{ "LINEOUTL_ENA_DLY", NULL, "LINEOUTL_ENA" },
+	{ "LINEOUTR_ENA_DLY", NULL, "LINEOUTR_ENA" },
 
 	{ "HPL_DCS", NULL, "DCS Master" },
 	{ "HPR_DCS", NULL, "DCS Master" },
-- 
1.7.1
