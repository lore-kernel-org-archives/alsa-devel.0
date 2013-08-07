From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: ak4104: Add stub DAPM support
Date: Wed,  7 Aug 2013 19:07:18 +0100
Message-ID: <1375898839-15992-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 70A4C261740
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 20:07:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This makes it easer to integrate the device with other on-board components
and ensures correct operation following removal of support for non-DAPM
CODECs.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4104.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index c7cfdf9..9a7c89b 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -51,6 +51,14 @@ struct ak4104_private {
 	struct regmap *regmap;
 };
 
+static const struct snd_soc_dapm_widget ak4104_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route ak4104_dapm_routes[] = {
+	{ "TX", NULL, "Playback" },
+};
+
 static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
 {
@@ -214,6 +222,11 @@ static int ak4104_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
 	.probe =	ak4104_probe,
 	.remove =	ak4104_remove,
+
+	.dapm_widgets = ak4104_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ak4104_dapm_widgets),
+	.dapm_routes = ak4104_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(ak4104_dapm_routes),
 };
 
 static const struct regmap_config ak4104_regmap = {
-- 
1.8.4.rc1
