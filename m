From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/8] ASoC: Optimise clock management for WM8915
	Speyside
Date: Tue, 12 Apr 2011 23:06:06 -0700
Message-ID: <1302674771-17169-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE3E31038CF
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 08:07:42 +0200 (CEST)
In-Reply-To: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Dynamically enable and disable the FLL on the WM8915, configuring the
system clock to 256fs for 48kHz when the device is active but reverting
to using the input 32.768kHz clock directly at other times to support
features such as jack detection with minimal power consumption.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 6ec44a3..1e51750 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -14,6 +14,33 @@
 
 #include "../codecs/wm8915.h"
 
+static int speyside_set_bias_level(struct snd_soc_card *card,
+				   enum snd_soc_bias_level level)
+{
+	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		ret = snd_soc_dai_set_sysclk(codec_dai, WM8915_SYSCLK_MCLK1,
+					     32768, SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_dai_set_pll(codec_dai, WM8915_FLL_MCLK1,
+					  0, 0, 0);
+		if (ret < 0) {
+			pr_err("Failed to stop FLL\n");
+			return ret;
+		}
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int speyside_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
@@ -51,6 +78,13 @@ static struct snd_soc_ops speyside_ops = {
 	.hw_params = speyside_hw_params,
 };
 
+static int speyside_wm8915_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	return snd_soc_dai_set_sysclk(dai, WM8915_SYSCLK_MCLK1, 32768, 0);
+}
+
 static struct snd_soc_dai_link speyside_dai[] = {
 	{
 		.name = "CPU",
@@ -59,6 +93,7 @@ static struct snd_soc_dai_link speyside_dai[] = {
 		.codec_dai_name = "wm8915-aif1",
 		.platform_name = "samsung-audio",
 		.codec_name = "wm8915.1-001a",
+		.init = speyside_wm8915_init,
 		.ops = &speyside_ops,
 	},
 };
@@ -91,6 +126,8 @@ static struct snd_soc_card speyside = {
 	.dai_link = speyside_dai,
 	.num_links = ARRAY_SIZE(speyside_dai),
 
+	.set_bias_level = speyside_set_bias_level,
+
 	.dapm_widgets = widgets,
 	.num_dapm_widgets = ARRAY_SIZE(widgets),
 	.dapm_routes = audio_paths,
-- 
1.7.4.1
