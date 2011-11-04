From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Disable thermal shutdown when not using
	speakers in wm_hubs
Date: Fri,  4 Nov 2011 23:07:33 +0000
Message-ID: <1320448053-22497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ABD411038E7
	for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2011 00:07:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The thermal shutdown support in wm_hubs devices is tied to the speaker
drivers (which are the only high power subsystems within the device).
Ensure minimal current usage when the thermal shutdown support is not
required by disabling the circuit when the speaker drivers are powered
down.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 84f33d4..f98170e 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -654,6 +654,7 @@ SND_SOC_DAPM_MIXER("SPKL Boost", SND_SOC_NOPM, 0, 0,
 SND_SOC_DAPM_MIXER("SPKR Boost", SND_SOC_NOPM, 0, 0,
 		   right_speaker_boost, ARRAY_SIZE(right_speaker_boost)),
 
+SND_SOC_DAPM_SUPPLY("TSHUT", WM8993_POWER_MANAGEMENT_2, 14, 0, NULL, 0),
 SND_SOC_DAPM_PGA("SPKL Driver", WM8993_POWER_MANAGEMENT_1, 12, 0,
 		 NULL, 0),
 SND_SOC_DAPM_PGA("SPKR Driver", WM8993_POWER_MANAGEMENT_1, 13, 0,
@@ -789,10 +790,12 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "SPKL Driver", NULL, "VMID" },
 	{ "SPKL Driver", NULL, "SPKL Boost" },
 	{ "SPKL Driver", NULL, "CLK_SYS" },
+	{ "SPKL Driver", NULL, "TSHUT" },
 
 	{ "SPKR Driver", NULL, "VMID" },
 	{ "SPKR Driver", NULL, "SPKR Boost" },
 	{ "SPKR Driver", NULL, "CLK_SYS" },
+	{ "SPKR Driver", NULL, "TSHUT" },
 
 	{ "SPKOUTLP", NULL, "SPKL Driver" },
 	{ "SPKOUTLN", NULL, "SPKL Driver" },
-- 
1.7.7.1
