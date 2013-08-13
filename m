From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: max9877: Add basic DAPM support
Date: Tue, 13 Aug 2013 13:33:47 +0100
Message-ID: <1376397227-13863-3-git-send-email-broonie@kernel.org>
References: <1376397227-13863-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DD3392617BB
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 14:33:56 +0200 (CEST)
In-Reply-To: <1376397227-13863-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This does not fully map the power control available within the device
but it provides the hooks for routing signals through the device and
allows automatic management of the device low power mode.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max9877.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 8505b40..29549cd 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -87,15 +87,50 @@ static const struct snd_kcontrol_new max9877_controls[] = {
 		   MAX9877_INPUT_MODE, 6, 1, 0),
 	SOC_SINGLE("MAX9877 Bypass Mode Switch",
 		   MAX9877_OUTPUT_MODE, 6, 1, 0),
-	SOC_SINGLE("MAX9877 Shutdown Mode Switch",
-		   MAX9877_OUTPUT_MODE, 7, 1, 1),
 	SOC_ENUM("MAX9877 Output Mode", max9877_enum[0]),
 	SOC_ENUM("MAX9877 Oscillator Mode", max9877_enum[1]),
 };
 
+static const struct snd_soc_dapm_widget max9877_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("INA1"),
+SND_SOC_DAPM_INPUT("INA2"),
+SND_SOC_DAPM_INPUT("INB1"),
+SND_SOC_DAPM_INPUT("INB2"),
+SND_SOC_DAPM_INPUT("RXIN+"),
+SND_SOC_DAPM_INPUT("RXIN-"),
+
+SND_SOC_DAPM_PGA("SHDN", MAX9877_OUTPUT_MODE, 7, 1, NULL, 0),
+
+SND_SOC_DAPM_OUTPUT("OUT+"),
+SND_SOC_DAPM_OUTPUT("OUT-"),
+SND_SOC_DAPM_OUTPUT("HPL"),
+SND_SOC_DAPM_OUTPUT("HPR"),
+};
+
+static const struct snd_soc_dapm_route max9877_dapm_routes[] = {
+	{ "SHDN", NULL, "INA1" },
+	{ "SHDN", NULL, "INA2" },
+	{ "SHDN", NULL, "INB1" },
+	{ "SHDN", NULL, "INB2" },
+
+	{ "OUT+", NULL, "RXIN+" },
+	{ "OUT+", NULL, "SHDN" },
+
+	{ "OUT-", NULL, "SHDN" },
+	{ "OUT-", NULL, "RXIN-" },
+
+	{ "HPL", NULL, "SHDN" },
+	{ "HPR", NULL, "SHDN" },
+};
+
 static const struct snd_soc_codec_driver max9877_codec = {
 	.controls = max9877_controls,
 	.num_controls = ARRAY_SIZE(max9877_controls),
+
+	.dapm_widgets = max9877_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max9877_dapm_widgets),
+	.dapm_routes = max9877_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(max9877_dapm_routes),
 };
 
 static const struct regmap_config max9877_regmap = {
-- 
1.8.4.rc2
