From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 5/7] ASoC: Tegra: Harmony: Use dev_err not
	pr_err
Date: Fri, 28 Jan 2011 14:26:39 -0700
Message-ID: <1296250001-6348-5-git-send-email-swarren@nvidia.com>
References: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 583DA24435
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 22:27:02 +0100 (CET)
In-Reply-To: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
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
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index b5311a3..76793a9 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -48,7 +48,6 @@
 #include "tegra_asoc_utils.h"
 
 #define DRV_NAME "tegra-snd-harmony"
-#define PREFIX DRV_NAME ": "
 
 struct tegra_harmony {
 	struct harmony_audio_platform_data *pdata;
@@ -61,6 +60,8 @@ static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
 	int srate, mclk, mclk_change;
 	int err;
 
@@ -81,7 +82,7 @@ static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 
 	err = tegra_asoc_utils_set_rate(srate, mclk, &mclk_change);
 	if (err < 0) {
-		pr_err(PREFIX "Can't configure clocks\n");
+		dev_err(card->dev, "Can't configure clocks\n");
 		return err;
 	}
 
@@ -90,7 +91,7 @@ static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 					SND_SOC_DAIFMT_NB_NF |
 					SND_SOC_DAIFMT_CBS_CFS);
 	if (err < 0) {
-		pr_err(PREFIX "codec_dai fmt not set\n");
+		dev_err(card->dev, "codec_dai fmt not set\n");
 		return err;
 	}
 
@@ -99,7 +100,7 @@ static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 					SND_SOC_DAIFMT_NB_NF |
 					SND_SOC_DAIFMT_CBS_CFS);
 	if (err < 0) {
-		pr_err(PREFIX "cpu_dai fmt not set\n");
+		dev_err(card->dev, "cpu_dai fmt not set\n");
 		return err;
 	}
 
@@ -107,7 +108,7 @@ static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 		err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 					     SND_SOC_CLOCK_IN);
 		if (err < 0) {
-			pr_err(PREFIX "codec_dai clock not set\n");
+			dev_err(card->dev, "codec_dai clock not set\n");
 			return err;
 		}
 	}
-- 
1.7.1
