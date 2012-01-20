From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Enable line out VMID buffer for single
	ended line outputs in wm_hubs
Date: Fri, 20 Jan 2012 18:37:07 +0000
Message-ID: <1327084628-18882-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BAC36243CF
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2012 19:37:12 +0100 (CET)
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

For optimal performance the single ended line outputs require that the
line output VMID buffer be enabled.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 2a61094..9ccc416 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -613,6 +613,8 @@ SND_SOC_DAPM_INPUT("IN2RP:VXRP"),
 SND_SOC_DAPM_SUPPLY("MICBIAS2", WM8993_POWER_MANAGEMENT_1, 5, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("MICBIAS1", WM8993_POWER_MANAGEMENT_1, 4, 0, NULL, 0),
 
+SND_SOC_DAPM_SUPPLY("LINEOUT_VMID_BUF", WM8993_ANTIPOP1, 7, 0, NULL, 0),
+
 SND_SOC_DAPM_MIXER("IN1L PGA", WM8993_POWER_MANAGEMENT_2, 6, 0,
 		   in1l_pga, ARRAY_SIZE(in1l_pga)),
 SND_SOC_DAPM_MIXER("IN1R PGA", WM8993_POWER_MANAGEMENT_2, 4, 0,
@@ -834,9 +836,11 @@ static const struct snd_soc_dapm_route lineout1_diff_routes[] = {
 };
 
 static const struct snd_soc_dapm_route lineout1_se_routes[] = {
+	{ "LINEOUT1N Mixer", NULL, "LINEOUT_VMID_BUF" },
 	{ "LINEOUT1N Mixer", "Left Output Switch", "Left Output PGA" },
 	{ "LINEOUT1N Mixer", "Right Output Switch", "Right Output PGA" },
 
+	{ "LINEOUT1P Mixer", NULL, "LINEOUT_VMID_BUF" },
 	{ "LINEOUT1P Mixer", "Left Output Switch", "Left Output PGA" },
 
 	{ "LINEOUT1N Driver", NULL, "LINEOUT1N Mixer" },
@@ -853,9 +857,11 @@ static const struct snd_soc_dapm_route lineout2_diff_routes[] = {
 };
 
 static const struct snd_soc_dapm_route lineout2_se_routes[] = {
+	{ "LINEOUT2N Mixer", NULL, "LINEOUT_VMID_BUF" },
 	{ "LINEOUT2N Mixer", "Left Output Switch", "Left Output PGA" },
 	{ "LINEOUT2N Mixer", "Right Output Switch", "Right Output PGA" },
 
+	{ "LINEOUT2P Mixer", NULL, "LINEOUT_VMID_BUF" },
 	{ "LINEOUT2P Mixer", "Right Output Switch", "Right Output PGA" },
 
 	{ "LINEOUT2N Driver", NULL, "LINEOUT2N Mixer" },
-- 
1.7.7.3
