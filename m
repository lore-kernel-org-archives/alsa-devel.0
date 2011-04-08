From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix output PGA enabling in wm_hubs CODECs
Date: Fri,  8 Apr 2011 17:05:47 +0900
Message-ID: <1302249947-1414-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C32210382F
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 04:28:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The output PGA was not being powered up in headphone and speaker paths,
removing the ability to offer volume control and mute with the output
PGA.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 7b6b3c1..4005e9a 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -740,12 +740,12 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 
 	{ "SPKL", "Input Switch", "MIXINL" },
 	{ "SPKL", "IN1LP Switch", "IN1LP" },
-	{ "SPKL", "Output Switch", "Left Output Mixer" },
+	{ "SPKL", "Output Switch", "Left Output PGA" },
 	{ "SPKL", NULL, "TOCLK" },
 
 	{ "SPKR", "Input Switch", "MIXINR" },
 	{ "SPKR", "IN1RP Switch", "IN1RP" },
-	{ "SPKR", "Output Switch", "Right Output Mixer" },
+	{ "SPKR", "Output Switch", "Right Output PGA" },
 	{ "SPKR", NULL, "TOCLK" },
 
 	{ "SPKL Boost", "Direct Voice Switch", "Direct Voice" },
@@ -767,8 +767,8 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "SPKOUTRP", NULL, "SPKR Driver" },
 	{ "SPKOUTRN", NULL, "SPKR Driver" },
 
-	{ "Left Headphone Mux", "Mixer", "Left Output Mixer" },
-	{ "Right Headphone Mux", "Mixer", "Right Output Mixer" },
+	{ "Left Headphone Mux", "Mixer", "Left Output PGA" },
+	{ "Right Headphone Mux", "Mixer", "Right Output PGA" },
 
 	{ "Headphone PGA", NULL, "Left Headphone Mux" },
 	{ "Headphone PGA", NULL, "Right Headphone Mux" },
-- 
1.7.4.1
