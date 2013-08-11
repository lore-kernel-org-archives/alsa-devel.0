From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ak5386: Add DAPM support
Date: Sun, 11 Aug 2013 12:44:54 +0100
Message-ID: <1376221494-15780-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AF249261688
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 13:44:58 +0200 (CEST)
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

This makes it possible to hook the device into a more complex board and
ensures it will continue to work with non-DAPM support removed from the
core.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak5386.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak5386.c b/sound/soc/codecs/ak5386.c
index 1f30398..72e953b 100644
--- a/sound/soc/codecs/ak5386.c
+++ b/sound/soc/codecs/ak5386.c
@@ -22,7 +22,22 @@ struct ak5386_priv {
 	int reset_gpio;
 };
 
-static struct snd_soc_codec_driver soc_codec_ak5386;
+static const struct snd_soc_dapm_widget ak5386_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("AINL"),
+SND_SOC_DAPM_INPUT("AINR"),
+};
+
+static const struct snd_soc_dapm_route ak5386_dapm_routes[] = {
+	{ "Capture", NULL, "AINL" },
+	{ "Capture", NULL, "AINR" },
+};
+
+static struct snd_soc_codec_driver soc_codec_ak5386 = {
+	.dapm_widgets = ak5386_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ak5386_dapm_widgets),
+	.dapm_routes = ak5386_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(ak5386_dapm_routes),
+};
 
 static int ak5386_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
-- 
1.8.4.rc1
