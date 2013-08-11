From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ak4554: Add DAPM support
Date: Sun, 11 Aug 2013 12:29:51 +0100
Message-ID: <1376220591-13161-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 677FE260309
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 13:29:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This makes it possible to hook the device into a more complex board and
ensures it will continue to work with non-DAPM support removed from the
core.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4554.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/ak4554.c b/sound/soc/codecs/ak4554.c
index 6aed9c4..79e9555 100644
--- a/sound/soc/codecs/ak4554.c
+++ b/sound/soc/codecs/ak4554.c
@@ -29,6 +29,22 @@
  * CPU-DAI2 (capture only fmt = LEFT_J) ---+
  */
 
+static const struct snd_soc_dapm_widget ak4554_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("AINL"),
+SND_SOC_DAPM_INPUT("AINR"),
+
+SND_SOC_DAPM_OUTPUT("AOUTL"),
+SND_SOC_DAPM_OUTPUT("AOUTR"),
+};
+
+static const struct snd_soc_dapm_route ak4554_dapm_routes[] = {
+	{ "Capture", NULL, "AINL" },
+	{ "Capture", NULL, "AINR" },
+
+	{ "AOUTL", NULL, "Playback" },
+	{ "AOUTR", NULL, "Playback" },
+};
+
 static struct snd_soc_dai_driver ak4554_dai = {
 	.name = "ak4554-hifi",
 	.playback = {
@@ -49,6 +65,10 @@ static struct snd_soc_dai_driver ak4554_dai = {
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_ak4554 = {
+	.dapm_widgets = ak4554_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ak4554_dapm_widgets),
+	.dapm_routes = ak4554_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(ak4554_dapm_routes),
 };
 
 static int ak4554_soc_probe(struct platform_device *pdev)
-- 
1.8.4.rc1
