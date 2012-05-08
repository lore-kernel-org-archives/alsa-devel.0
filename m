From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: lowland: Convert to dai_fmt
Date: Tue,  8 May 2012 09:54:58 +0100
Message-ID: <1336467298-10457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2F9010405B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 10:55:02 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/lowland.c |   33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 4adff93..6cac1e9 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -21,33 +21,6 @@
 #define MCLK1_RATE (44100 * 512)
 #define CLKOUT_RATE (44100 * 256)
 
-static int lowland_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
-					 | SND_SOC_DAIFMT_NB_NF
-					 | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
-					 | SND_SOC_DAIFMT_NB_NF
-					 | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static struct snd_soc_ops lowland_ops = {
-	.hw_params = lowland_hw_params,
-};
-
 static struct snd_soc_jack lowland_headset;
 
 /* Headset jack detection DAPM pins */
@@ -109,7 +82,8 @@ static struct snd_soc_dai_link lowland_dai[] = {
 		.codec_dai_name = "wm5100-aif1",
 		.platform_name = "samsung-audio",
 		.codec_name = "wm5100.1-001a",
-		.ops = &lowland_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBM_CFM,
 		.init = lowland_wm5100_init,
 	},
 	{
@@ -118,7 +92,8 @@ static struct snd_soc_dai_link lowland_dai[] = {
 		.cpu_dai_name = "wm5100-aif2",
 		.codec_dai_name = "wm1250-ev1",
 		.codec_name = "wm1250-ev1.1-0027",
-		.ops = &lowland_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
 	},
 };
-- 
1.7.10
