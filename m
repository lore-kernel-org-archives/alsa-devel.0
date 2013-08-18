From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8782: Add DAPM support
Date: Sun, 18 Aug 2013 18:39:02 +0100
Message-ID: <1376847542-21551-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C11672615C5
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 19:39:05 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

In order to make the device easier to hook up to external components in
system designs and ensure operation when DAPM support becomes mandatory
add DAPM support.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8782.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index f1fdbf6..8092495 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -26,6 +26,16 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+static const struct snd_soc_dapm_widget wm8782_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("AINL"),
+SND_SOC_DAPM_INPUT("AINR"),
+};
+
+static const struct snd_soc_dapm_route wm8782_dapm_routes[] = {
+	{ "Capture", NULL, "AINL" },
+	{ "Capture", NULL, "AINR" },
+};
+
 static struct snd_soc_dai_driver wm8782_dai = {
 	.name = "wm8782",
 	.capture = {
@@ -40,7 +50,12 @@ static struct snd_soc_dai_driver wm8782_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8782;
+static struct snd_soc_codec_driver soc_codec_dev_wm8782 = {
+	.dapm_widgets = wm8782_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8782_dapm_widgets),
+	.dapm_routes = wm8782_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8782_dapm_routes),
+};
 
 static int wm8782_probe(struct platform_device *pdev)
 {
-- 
1.8.4.rc3
