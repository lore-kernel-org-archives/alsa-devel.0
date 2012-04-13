From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm1250-ev1: Support sample rate
	configuration
Date: Fri, 13 Apr 2012 20:24:25 +0100
Message-ID: <1334345065-4148-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1334345065-4148-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7219B104581
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 21:24:31 +0200 (CEST)
In-Reply-To: <1334345065-4148-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The Springbank module can support a range of sample rates, selected at
runtime via GPIO configuration. Allow these to be configured at runtime.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm1250-ev1.c |   43 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 0766b5f..e0b51e9 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -79,6 +79,48 @@ static const struct snd_soc_dapm_route wm1250_ev1_dapm_routes[] = {
 	{ "WM1250 Output", NULL, "DAC" },
 };
 
+static int wm1250_ev1_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct wm1250_priv *wm1250 = snd_soc_codec_get_drvdata(dai->codec);
+
+	switch (params_rate(params)) {
+	case 8000:
+		gpio_set_value(wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL0].gpio,
+			       1);
+		gpio_set_value(wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL1].gpio,
+			       1);
+		break;
+	case 16000:
+		gpio_set_value(wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL0].gpio,
+			       0);
+		gpio_set_value(wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL1].gpio,
+			       1);
+		break;
+	case 32000:
+		gpio_set_value(wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL0].gpio,
+			       1);
+		gpio_set_value(wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL1].gpio,
+			       0);
+		break;
+	case 64000:
+		gpio_set_value(wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL0].gpio,
+			       0);
+		gpio_set_value(wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL1].gpio,
+			       0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops wm1250_ev1_ops = {
+	.hw_params = wm1250_ev1_hw_params,
+};
+
 static struct snd_soc_dai_driver wm1250_ev1_dai = {
 	.name = "wm1250-ev1",
 	.playback = {
@@ -95,6 +137,7 @@ static struct snd_soc_dai_driver wm1250_ev1_dai = {
 		.rates = SNDRV_PCM_RATE_8000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
+	.ops = &wm1250_ev1_ops,
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
-- 
1.7.9.1
