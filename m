From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: hdmi: Provide stub DAPM integration
Date: Mon, 19 Aug 2013 12:17:50 +0100
Message-ID: <1376911070-16351-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 173A4261ACA
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 13:17:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Ensure continued operation with DAPM being mandatory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/hdmi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
index f0986b9..68342b1 100644
--- a/sound/soc/codecs/hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -23,11 +23,20 @@
 
 #define DRV_NAME "hdmi-audio-codec"
 
-static struct snd_soc_codec_driver hdmi_codec;
+static const struct snd_soc_dapm_widget hdmi_widgets[] = {
+	SND_SOC_DAPM_INPUT("RX"),
+	SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route hdmi_routes[] = {
+	{ "Capture", NULL, "RX" },
+	{ "TX", NULL, "Playback" },
+};
 
 static struct snd_soc_dai_driver hdmi_codec_dai = {
 	.name = "hdmi-hifi",
 	.playback = {
+		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_32000 |
@@ -38,6 +47,7 @@ static struct snd_soc_dai_driver hdmi_codec_dai = {
 			SNDRV_PCM_FMTBIT_S24_LE,
 	},
 	.capture = {
+		.stream_name = "Capture",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_32000 |
@@ -50,6 +60,13 @@ static struct snd_soc_dai_driver hdmi_codec_dai = {
 
 };
 
+static struct snd_soc_codec_driver hdmi_codec = {
+	.dapm_widgets = hdmi_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
+	.dapm_routes = hdmi_routes,
+	.num_dapm_routes = ARRAY_SIZE(hdmi_routes),
+};
+
 static int hdmi_codec_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &hdmi_codec,
-- 
1.8.4.rc3
