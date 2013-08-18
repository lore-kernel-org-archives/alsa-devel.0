From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8727: Add DAPM support
Date: Sun, 18 Aug 2013 18:38:52 +0100
Message-ID: <1376847532-21496-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A9A7C26109D
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 19:38:56 +0200 (CEST)
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
 sound/soc/codecs/wm8727.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index 462f5e4..7b1a6d5 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -23,6 +23,16 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+static const struct snd_soc_dapm_widget wm8727_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("VOUTL"),
+SND_SOC_DAPM_OUTPUT("VOUTR"),
+};
+
+static const struct snd_soc_dapm_route wm8727_dapm_routes[] = {
+	{ "VOUTL", NULL, "Playback" },
+	{ "VOUTR", NULL, "Playback" },
+};
+
 /*
  * Note this is a simple chip with no configuration interface, sample rate is
  * determined automatically by examining the Master clock and Bit clock ratios
@@ -43,7 +53,12 @@ static struct snd_soc_dai_driver wm8727_dai = {
 		},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8727;
+static struct snd_soc_codec_driver soc_codec_dev_wm8727 = {
+	.dapm_widgets = wm8727_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8727_dapm_widgets),
+	.dapm_routes = wm8727_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8727_dapm_routes),
+};
 
 static int wm8727_probe(struct platform_device *pdev)
 {
-- 
1.8.4.rc3
