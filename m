From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: bt-sco: Provide stub DAPM integration
Date: Mon, 19 Aug 2013 12:16:50 +0100
Message-ID: <1376911010-16215-2-git-send-email-broonie@kernel.org>
References: <1376911010-16215-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 28D1E261A23
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 13:16:57 +0200 (CEST)
In-Reply-To: <1376911010-16215-1-git-send-email-broonie@kernel.org>
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
 sound/soc/codecs/bt-sco.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index 5c040ce..c4cf069 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -15,15 +15,27 @@
 
 #include <sound/soc.h>
 
+static const struct snd_soc_dapm_widget bt_sco_widgets[] = {
+	SND_SOC_DAPM_INPUT("RX"),
+	SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route bt_sco_routes[] = {
+	{ "Capture", NULL, "RX" },
+	{ "TX", NULL, "Playback" },
+};
+
 static struct snd_soc_dai_driver bt_sco_dai = {
 	.name = "bt-sco-pcm",
 	.playback = {
+		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 1,
 		.rates = SNDRV_PCM_RATE_8000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
+		 .stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 1,
 		.rates = SNDRV_PCM_RATE_8000,
@@ -31,7 +43,12 @@ static struct snd_soc_dai_driver bt_sco_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_bt_sco;
+static struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
+	.dapm_widgets = bt_sco_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(bt_sco_widgets),
+	.dapm_routes = bt_sco_routes,
+	.num_dapm_routes = ARRAY_SIZE(bt_sco_routes),
+};
 
 static int bt_sco_probe(struct platform_device *pdev)
 {
-- 
1.8.4.rc3
