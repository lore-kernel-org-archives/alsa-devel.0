From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ads711x: Add DAPM support
Date: Wed,  7 Aug 2013 18:26:20 +0100
Message-ID: <1375896380-10497-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C286261793
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 19:26:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Graeme Gregory <gg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This makes it easier to hook into boards and ensures the driver continues
to work with support for non-DAPM CODECs removed.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ads117x.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index 506d474..8f388ed 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -23,6 +23,28 @@
 #define ADS117X_RATES (SNDRV_PCM_RATE_8000_48000)
 #define ADS117X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
 
+static const struct snd_soc_dapm_widget ads117x_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("Input1"),
+SND_SOC_DAPM_INPUT("Input2"),
+SND_SOC_DAPM_INPUT("Input3"),
+SND_SOC_DAPM_INPUT("Input4"),
+SND_SOC_DAPM_INPUT("Input5"),
+SND_SOC_DAPM_INPUT("Input6"),
+SND_SOC_DAPM_INPUT("Input7"),
+SND_SOC_DAPM_INPUT("Input8"),
+};
+
+static const struct snd_soc_dapm_route ads117x_dapm_routes[] = {
+	{ "Capture", NULL, "Input1" },
+	{ "Capture", NULL, "Input2" },
+	{ "Capture", NULL, "Input3" },
+	{ "Capture", NULL, "Input4" },
+	{ "Capture", NULL, "Input5" },
+	{ "Capture", NULL, "Input6" },
+	{ "Capture", NULL, "Input7" },
+	{ "Capture", NULL, "Input8" },
+};
+
 static struct snd_soc_dai_driver ads117x_dai = {
 /* ADC */
 	.name = "ads117x-hifi",
@@ -34,7 +56,12 @@ static struct snd_soc_dai_driver ads117x_dai = {
 		.formats = ADS117X_FORMATS,},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ads117x;
+static struct snd_soc_codec_driver soc_codec_dev_ads117x = {
+	.dapm_widgets = ads117x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ads117x_dapm_widgets),
+	.dapm_routes = ads117x_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(ads117x_dapm_routes),
+};
 
 static int ads117x_probe(struct platform_device *pdev)
 {
-- 
1.8.4.rc1
