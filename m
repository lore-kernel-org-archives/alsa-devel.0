From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: Rename controls with a / in wm_hubs
Date: Fri, 04 Dec 2009 15:12:10 +0900
Message-ID: <4B18A83A.6010300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AF0424502
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 07:12:12 +0100 (CET)
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KU400HW76K99L@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 04 Dec 2009 15:12:09 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KU400ETT6K9K5@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 04 Dec 2009 15:12:09 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This renames from a character / to : of controls. A / occurs below error
messages.

ASoC: Failed to create IN2RP/VXRP debugfs file
ASoC: Failed to create IN2LP/VXRN debugfs file

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
If there is the better a delimiter or other idea, please inform me it.

 sound/soc/codecs/wm_hubs.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 810a563..d73c305 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -438,11 +438,11 @@ static const struct snd_soc_dapm_widget analogue_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("IN1LN"),
 SND_SOC_DAPM_INPUT("IN1LP"),
 SND_SOC_DAPM_INPUT("IN2LN"),
-SND_SOC_DAPM_INPUT("IN2LP/VXRN"),
+SND_SOC_DAPM_INPUT("IN2LP:VXRN"),
 SND_SOC_DAPM_INPUT("IN1RN"),
 SND_SOC_DAPM_INPUT("IN1RP"),
 SND_SOC_DAPM_INPUT("IN2RN"),
-SND_SOC_DAPM_INPUT("IN2RP/VXRP"),
+SND_SOC_DAPM_INPUT("IN2RP:VXRP"),
 
 SND_SOC_DAPM_MICBIAS("MICBIAS2", WM8993_POWER_MANAGEMENT_1, 5, 0),
 SND_SOC_DAPM_MICBIAS("MICBIAS1", WM8993_POWER_MANAGEMENT_1, 4, 0),
@@ -537,14 +537,14 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "IN1R PGA", "IN1RP Switch", "IN1RP" },
 	{ "IN1R PGA", "IN1RN Switch", "IN1RN" },
 
-	{ "IN2L PGA", "IN2LP Switch", "IN2LP/VXRN" },
+	{ "IN2L PGA", "IN2LP Switch", "IN2LP:VXRN" },
 	{ "IN2L PGA", "IN2LN Switch", "IN2LN" },
 
-	{ "IN2R PGA", "IN2RP Switch", "IN2RP/VXRP" },
+	{ "IN2R PGA", "IN2RP Switch", "IN2RP:VXRP" },
 	{ "IN2R PGA", "IN2RN Switch", "IN2RN" },
 
-	{ "Direct Voice", NULL, "IN2LP/VXRN" },
-	{ "Direct Voice", NULL, "IN2RP/VXRP" },
+	{ "Direct Voice", NULL, "IN2LP:VXRN" },
+	{ "Direct Voice", NULL, "IN2RP:VXRP" },
 
 	{ "MIXINL", "IN1L Switch", "IN1L PGA" },
 	{ "MIXINL", "IN2L Switch", "IN2L PGA" },
@@ -565,7 +565,7 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "Left Output Mixer", "Right Input Switch", "MIXINR" },
 	{ "Left Output Mixer", "IN2RN Switch", "IN2RN" },
 	{ "Left Output Mixer", "IN2LN Switch", "IN2LN" },
-	{ "Left Output Mixer", "IN2LP Switch", "IN2LP/VXRN" },
+	{ "Left Output Mixer", "IN2LP Switch", "IN2LP:VXRN" },
 	{ "Left Output Mixer", "IN1L Switch", "IN1L PGA" },
 	{ "Left Output Mixer", "IN1R Switch", "IN1R PGA" },
 
@@ -573,7 +573,7 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "Right Output Mixer", "Right Input Switch", "MIXINR" },
 	{ "Right Output Mixer", "IN2LN Switch", "IN2LN" },
 	{ "Right Output Mixer", "IN2RN Switch", "IN2RN" },
-	{ "Right Output Mixer", "IN2RP Switch", "IN2RP/VXRP" },
+	{ "Right Output Mixer", "IN2RP Switch", "IN2RP:VXRP" },
 	{ "Right Output Mixer", "IN1L Switch", "IN1L PGA" },
 	{ "Right Output Mixer", "IN1R Switch", "IN1R PGA" },
 
-- 
1.6.3.3
