From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] ASoC: Manage Speyside system clocking only
	in bias management
Date: Mon,  6 Jun 2011 19:18:33 +0100
Message-ID: <1307384313-23559-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E63CD24439
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 20:18:37 +0200 (CEST)
In-Reply-To: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Now that the CODEC driver supports it defer configuration of the system
clock until bias management which is a much more idiomatic place to do
system power control and makes things a lot more happy when we're using
both interfaces.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |   50 +++++++++++++++++++++++++++++++++--------
 1 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 99fb033..2515dba 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -42,11 +42,51 @@ static int speyside_set_bias_level(struct snd_soc_card *card,
 			pr_err("Failed to stop FLL\n");
 			return ret;
 		}
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int speyside_set_bias_level_post(struct snd_soc_card *card,
+					struct snd_soc_dapm_context *dapm,
+					enum snd_soc_bias_level level)
+{
+	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	int ret;
+
+	if (dapm->dev != codec_dai->dev)
+		return 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (card->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+			ret = snd_soc_dai_set_pll(codec_dai, 0,
+						  WM8915_FLL_MCLK2,
+						  32768, 48000 * 256);
+			if (ret < 0) {
+				pr_err("Failed to start FLL\n");
+				return ret;
+			}
+
+			ret = snd_soc_dai_set_sysclk(codec_dai,
+						     WM8915_SYSCLK_FLL,
+						     48000 * 256,
+						     SND_SOC_CLOCK_IN);
+			if (ret < 0)
+				return ret;
+		}
+		break;
 
 	default:
 		break;
 	}
 
+	card->dapm.bias_level = level;
+
 	return 0;
 }
 
@@ -70,16 +110,6 @@ static int speyside_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_pll(codec_dai, 0, WM8915_FLL_MCLK2,
-				  32768, 256 * 48000);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8915_SYSCLK_FLL,
-				     256 * 48000, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-- 
1.7.5.3
