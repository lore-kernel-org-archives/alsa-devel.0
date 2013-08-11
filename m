From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: max9768: Add DAPM support
Date: Sun, 11 Aug 2013 13:28:25 +0100
Message-ID: <1376224105-28981-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B41122616E1
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 14:30:05 +0200 (CEST)
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

This makes it possible to hook the device into a more complex board and
ensures it will continue to work with non-DAPM support removed from the
core.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max9768.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index a6ac231..31f9156 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -118,6 +118,18 @@ static const struct snd_kcontrol_new max9768_mute[] = {
 	SOC_SINGLE_BOOL_EXT("Playback Switch", 0, max9768_get_gpio, max9768_set_gpio),
 };
 
+static const struct snd_soc_dapm_widget max9768_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("IN"),
+
+SND_SOC_DAPM_OUTPUT("OUT+"),
+SND_SOC_DAPM_OUTPUT("OUT-"),
+};
+
+static const struct snd_soc_dapm_route max9768_dapm_routes[] = {
+	{ "OUT+", NULL, "IN" },
+	{ "OUT-", NULL, "IN" },
+};
+
 static int max9768_probe(struct snd_soc_codec *codec)
 {
 	struct max9768 *max9768 = snd_soc_codec_get_drvdata(codec);
@@ -148,6 +160,10 @@ static struct snd_soc_codec_driver max9768_codec_driver = {
 	.probe = max9768_probe,
 	.controls = max9768_volume,
 	.num_controls = ARRAY_SIZE(max9768_volume),
+	.dapm_widgets = max9768_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max9768_dapm_widgets),
+	.dapm_routes = max9768_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(max9768_dapm_routes),
 };
 
 static const struct regmap_config max9768_i2c_regmap_config = {
-- 
1.8.4.rc1
