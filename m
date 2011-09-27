From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Use dai_fmt in Speyside
Date: Tue, 27 Sep 2011 16:49:52 +0100
Message-ID: <1317138593-12617-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317138593-12617-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5AF4F24442
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 17:50:02 +0200 (CEST)
In-Reply-To: <1317138593-12617-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/samsung/speyside.c |   33 ++++-----------------------------
 1 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index dfa62c9..faf47bd 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -90,33 +90,6 @@ static int speyside_set_bias_level_post(struct snd_soc_card *card,
 	return 0;
 }
 
-static int speyside_hw_params(struct snd_pcm_substream *substream,
-			      struct snd_pcm_hw_params *params)
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
-static struct snd_soc_ops speyside_ops = {
-	.hw_params = speyside_hw_params,
-};
-
 static struct snd_soc_jack speyside_headset;
 
 /* Headset jack detection DAPM pins */
@@ -206,7 +179,8 @@ static struct snd_soc_dai_link speyside_dai[] = {
 		.platform_name = "samsung-audio",
 		.codec_name = "wm8996.1-001a",
 		.init = speyside_wm8996_init,
-		.ops = &speyside_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
 	},
 	{
 		.name = "Baseband",
@@ -214,7 +188,8 @@ static struct snd_soc_dai_link speyside_dai[] = {
 		.cpu_dai_name = "wm8996-aif2",
 		.codec_dai_name = "wm1250-ev1",
 		.codec_name = "wm1250-ev1.1-0027",
-		.ops = &speyside_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
 	},
 };
-- 
1.7.6.3
