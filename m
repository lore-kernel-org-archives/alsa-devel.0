From: Stephen Warren <swarren@nvidia.com>
Subject: WM8903 line output mute/volume, and POWER_MANAGEMENT_3
Date: Wed, 6 Apr 2011 13:28:15 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0493EB374D@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id BEE622438A
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 22:27:58 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
Cc: Jordan Nien <JNien@nvidia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dilan Lee <dilee@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Mark,

With wm8903.c as it stands, POWER_MANAGEMENT_3 bits LINEOUTL/R_PGA_ENA are
left at 0 by the driver. In turn, this prevents mute and volume adjustments
of the Line Output PGA from affecting the audio. An offline conversation
with a WM FAE indicates these bits must be 1 for the LINEOUT PGA to function
correctly.

Below is a patch from a colleague that fixes this. Is it correct? I see
precedent for this sequencing setup in the Speaker PGA setup. However, the
datasheet implies (by considering together in the same section) that the Line
and Headphone Output PGAs are typically programmed in the same fashion, and
they already were in the code. Perhaps the Headphone Output PGA also has an
issue and needs similar rework?

Related, looking at the default write sequencer startup sequence in the
datasheet, that sequence does enable LINEOUTL/R_PGA_ENA. Perhaps now the
driver skips that write sequencer initialization sequence, the open-coded
initialization code needs a few extra register writes? See
22f226dd1496a0fa470e64a66e2da474f34eebf8
ASoC: Don't use write sequencer to power up WM8903
(although I imagine this path shouldn't be enabled at probe time, but later
when the playback path is actually active, which the patch below achieves)
    
If the patch is OK, I'll repost as a regular [PATCH] email, or adjust as
necessary based on your feedback.

Thanks for any input.

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ae1cadf..511858a 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -247,7 +247,6 @@ static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int re
        case WM8903_REVISION_NUMBER:
        case WM8903_INTERRUPT_STATUS_1:
        case WM8903_WRITE_SEQUENCER_4:
-       case WM8903_POWER_MANAGEMENT_3:
        case WM8903_POWER_MANAGEMENT_2:
        case WM8903_DC_SERVO_READBACK_1:
        case WM8903_DC_SERVO_READBACK_2:
@@ -880,9 +879,9 @@ SND_SOC_DAPM_PGA_S("Left Headphone Output PGA", 0, WM8903_ANALOGUE_HP_0,
 SND_SOC_DAPM_PGA_S("Right Headphone Output PGA", 0, WM8903_ANALOGUE_HP_0,
                   0, 0, NULL, 0),
 
-SND_SOC_DAPM_PGA_S("Left Line Output PGA", 0, WM8903_ANALOGUE_LINEOUT_0, 4, 0,
+SND_SOC_DAPM_PGA_S("Left Line Output PGA", 0, WM8903_POWER_MANAGEMENT_3, 1, 0,
                   NULL, 0),
-SND_SOC_DAPM_PGA_S("Right Line Output PGA", 0, WM8903_ANALOGUE_LINEOUT_0, 0, 0,
+SND_SOC_DAPM_PGA_S("Right Line Output PGA", 0, WM8903_POWER_MANAGEMENT_3, 0, 0,
                   NULL, 0),
 
 SND_SOC_DAPM_PGA_S("HPL_RMV_SHORT", 4, WM8903_ANALOGUE_HP_0, 7, 0, NULL, 0),
@@ -896,14 +895,18 @@ SND_SOC_DAPM_PGA_S("LINEOUTL_RMV_SHORT", 4, WM8903_ANALOGUE_LINEOUT_0, 7, 0,
                   NULL, 0),
 SND_SOC_DAPM_PGA_S("LINEOUTL_ENA_OUTP", 3, WM8903_ANALOGUE_LINEOUT_0, 6, 0,
                   NULL, 0),
-SND_SOC_DAPM_PGA_S("LINEOUTL_ENA_DLY", 1, WM8903_ANALOGUE_LINEOUT_0, 5, 0,
+SND_SOC_DAPM_PGA_S("LINEOUTL_ENA_DLY", 2, WM8903_ANALOGUE_LINEOUT_0, 5, 0,
                   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTL_ENA", 1, WM8903_ANALOGUE_LINEOUT_0, 4, 0,
+                  NULL, 0),               
 SND_SOC_DAPM_PGA_S("LINEOUTR_RMV_SHORT", 4, WM8903_ANALOGUE_LINEOUT_0, 3, 0,
                   NULL, 0),
 SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_OUTP", 3, WM8903_ANALOGUE_LINEOUT_0, 2, 0,
                   NULL, 0),
-SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_DLY", 1, WM8903_ANALOGUE_LINEOUT_0, 1, 0,
+SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_DLY", 2, WM8903_ANALOGUE_LINEOUT_0, 1, 0,
                   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTR_ENA", 1, WM8903_ANALOGUE_LINEOUT_0, 0, 0,
+                  NULL, 0),               
 
 SND_SOC_DAPM_SUPPLY("DCS Master", WM8903_DC_SERVO_0, 4, 0, NULL, 0),
 SND_SOC_DAPM_PGA_S("HPL_DCS", 3, SND_SOC_NOPM, 3, 0, wm8903_dcs_event,
@@ -1039,8 +1042,10 @@ static const struct snd_soc_dapm_route intercon[] = {
 
        { "HPL_ENA_DLY", NULL, "Left Headphone Output PGA" },
        { "HPR_ENA_DLY", NULL, "Right Headphone Output PGA" },
-       { "LINEOUTL_ENA_DLY", NULL, "Left Line Output PGA" },
-       { "LINEOUTR_ENA_DLY", NULL, "Right Line Output PGA" },
+       { "LINEOUTL_ENA", NULL, "Left Line Output PGA" },
+       { "LINEOUTR_ENA", NULL, "Right Line Output PGA" },
+       { "LINEOUTL_ENA_DLY", NULL, "LINEOUTL_ENA" },
+       { "LINEOUTR_ENA_DLY", NULL, "LINEOUTR_ENA" },
 
        { "HPL_DCS", NULL, "DCS Master" },
        { "HPR_DCS", NULL, "DCS Master" },

-- 
nvpublic
