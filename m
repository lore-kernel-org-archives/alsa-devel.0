From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: ad73311: Add DAPM support
Date: Wed,  7 Aug 2013 18:01:52 +0100
Message-ID: <1375894913-8608-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AE9D9261793
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 19:02:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This makes it possible to hook up other devices in boards and is required
by removal of support for non-DAPM CODECs in the core.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ad73311.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index b1f2baf..5fac8ad 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -23,6 +23,21 @@
 
 #include "ad73311.h"
 
+static const struct snd_soc_dapm_widget ad73311_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("VINP"),
+SND_SOC_DAPM_INPUT("VINN"),
+SND_SOC_DAPM_OUTPUT("VOUTN"),
+SND_SOC_DAPM_OUTPUT("VOUTP"),
+};
+
+static const struct snd_soc_dapm_route ad73311_dapm_routes[] = {
+	{ "Capture", NULL, "VINP" },
+	{ "Capture", NULL, "VINN" },
+
+	{ "VOUTN", NULL, "Playback" },
+	{ "VOUTP", NULL, "Playback" },
+};
+
 static struct snd_soc_dai_driver ad73311_dai = {
 	.name = "ad73311-hifi",
 	.playback = {
@@ -39,7 +54,12 @@ static struct snd_soc_dai_driver ad73311_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ad73311;
+static struct snd_soc_codec_driver soc_codec_dev_ad73311 = {
+	.dapm_widgets = ad73311_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ad73311_dapm_widgets),
+	.dapm_routes = ad73311_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(ad73311_dapm_routes),
+};
 
 static int ad73311_probe(struct platform_device *pdev)
 {
-- 
1.8.4.rc1
