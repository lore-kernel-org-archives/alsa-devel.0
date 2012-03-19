From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm_hubs: Don't actively manage
	LINEOUT_VMID_BUF
Date: Mon, 19 Mar 2012 18:59:39 +0000
Message-ID: <1332183581-14591-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 848E224354
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 19:59:44 +0100 (CET)
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

It can just be enabled all the time with no impact.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index c08d1c2..f13f288 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -643,8 +643,6 @@ SND_SOC_DAPM_INPUT("IN2RP:VXRP"),
 SND_SOC_DAPM_SUPPLY("MICBIAS2", WM8993_POWER_MANAGEMENT_1, 5, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("MICBIAS1", WM8993_POWER_MANAGEMENT_1, 4, 0, NULL, 0),
 
-SND_SOC_DAPM_SUPPLY("LINEOUT_VMID_BUF", WM8993_ANTIPOP1, 7, 0, NULL, 0),
-
 SND_SOC_DAPM_MIXER("IN1L PGA", WM8993_POWER_MANAGEMENT_2, 6, 0,
 		   in1l_pga, ARRAY_SIZE(in1l_pga)),
 SND_SOC_DAPM_MIXER("IN1R PGA", WM8993_POWER_MANAGEMENT_2, 4, 0,
@@ -869,11 +867,9 @@ static const struct snd_soc_dapm_route lineout1_diff_routes[] = {
 };
 
 static const struct snd_soc_dapm_route lineout1_se_routes[] = {
-	{ "LINEOUT1N Mixer", NULL, "LINEOUT_VMID_BUF" },
 	{ "LINEOUT1N Mixer", "Left Output Switch", "Left Output PGA" },
 	{ "LINEOUT1N Mixer", "Right Output Switch", "Right Output PGA" },
 
-	{ "LINEOUT1P Mixer", NULL, "LINEOUT_VMID_BUF" },
 	{ "LINEOUT1P Mixer", "Left Output Switch", "Left Output PGA" },
 
 	{ "LINEOUT1N Driver", NULL, "LINEOUT1N Mixer" },
@@ -890,11 +886,9 @@ static const struct snd_soc_dapm_route lineout2_diff_routes[] = {
 };
 
 static const struct snd_soc_dapm_route lineout2_se_routes[] = {
-	{ "LINEOUT2N Mixer", NULL, "LINEOUT_VMID_BUF" },
 	{ "LINEOUT2N Mixer", "Left Output Switch", "Left Output PGA" },
 	{ "LINEOUT2N Mixer", "Right Output Switch", "Right Output PGA" },
 
-	{ "LINEOUT2P Mixer", NULL, "LINEOUT_VMID_BUF" },
 	{ "LINEOUT2P Mixer", "Right Output Switch", "Right Output PGA" },
 
 	{ "LINEOUT2N Driver", NULL, "LINEOUT2N Mixer" },
@@ -996,6 +990,11 @@ int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
 				    WM8993_LINEOUT2_MODE,
 				    WM8993_LINEOUT2_MODE);
 
+	if (!lineout1_diff && !lineout2_diff)
+		snd_soc_update_bits(codec, WM8993_ANTIPOP1,
+				    WM8993_LINEOUT_VMID_BUF_ENA,
+				    WM8993_LINEOUT_VMID_BUF_ENA);
+
 	if (lineout1fb)
 		snd_soc_update_bits(codec, WM8993_ADDITIONAL_CONTROL,
 				    WM8993_LINEOUT1_FB, WM8993_LINEOUT1_FB);
@@ -1068,11 +1067,6 @@ void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
 				    WM8993_LINEOUT2P_ENA,
 				    val);
 
-		if (!hubs->lineout1n_ena && !hubs->lineout1p_ena &&
-		    !hubs->lineout2n_ena && !hubs->lineout2p_ena)
-			snd_soc_update_bits(codec, WM8993_ANTIPOP1,
-					    WM8993_LINEOUT_VMID_BUF_ENA, 0);
-
 		/* Remove the input clamps */
 		snd_soc_update_bits(codec, WM8993_INPUTS_CLAMP_REG,
 				    WM8993_INPUTS_CLAMP, 0);
-- 
1.7.9.1
