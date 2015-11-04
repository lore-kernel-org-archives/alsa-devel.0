From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: nau8825: fix stream_name conflicting
Date: Tue,  3 Nov 2015 16:13:39 -0800
Message-ID: <1446596019-83464-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 846812617C1
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 01:15:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, joe.konno@intel.com, yang.a.fang@intel.com, sathyanarayana.nujella@intel.com, naveen.m@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org

From: M Naveen <naveen.m@intel.com>

There is naming conflict with dai stream_name defined in dmic.c
so assign different name

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: M Naveen <naveen.m@intel.com>
---
 sound/soc/codecs/nau8825.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 7fc7b4e..4d00ac0 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -298,8 +298,8 @@ static const struct snd_kcontrol_new nau8825_dacr_mux =
 
 
 static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
-	SND_SOC_DAPM_AIF_OUT("AIFTX", "Capture", 0, NAU8825_REG_I2S_PCM_CTRL2,
-		15, 1),
+	SND_SOC_DAPM_AIF_OUT("AIFTX", "AIF1 Capture", 0,
+		NAU8825_REG_I2S_PCM_CTRL2, 15, 1),
 
 	SND_SOC_DAPM_INPUT("MIC"),
 	SND_SOC_DAPM_MICBIAS("MICBIAS", NAU8825_REG_MIC_BIAS, 8, 0),
@@ -365,8 +365,8 @@ static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
 	{"ADC", NULL, "ADC Power"},
 	{"AIFTX", NULL, "ADC"},
 
-	{"DDACL", NULL, "Playback"},
-	{"DDACR", NULL, "Playback"},
+	{"DDACL", NULL, "AIF1 Playback"},
+	{"DDACR", NULL, "AIF1 Playback"},
 	{"DDACL", NULL, "DDAC Clock"},
 	{"DDACR", NULL, "DDAC Clock"},
 	{"DACL Mux", "DACL", "DDACL"},
@@ -495,14 +495,14 @@ static const struct snd_soc_dai_ops nau8825_dai_ops = {
 static struct snd_soc_dai_driver nau8825_dai = {
 	.name = "nau8825-hifi",
 	.playback = {
-		.stream_name	 = "Playback",
+		.stream_name	 = "AIF1 Playback",
 		.channels_min	 = 1,
 		.channels_max	 = 2,
 		.rates		 = NAU8825_RATES,
 		.formats	 = NAU8825_FORMATS,
 	},
 	.capture = {
-		.stream_name	 = "Capture",
+		.stream_name	 = "AIF1 Capture",
 		.channels_min	 = 1,
 		.channels_max	 = 1,
 		.rates		 = NAU8825_RATES,
-- 
1.7.9.5
