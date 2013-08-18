From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wl1273: Add stub DAPM support
Date: Sun, 18 Aug 2013 18:26:39 +0100
Message-ID: <1376846799-6298-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0226E2608EE
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 19:26:44 +0200 (CEST)
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

In order to ensure that the device continues to work with DAPM support
being mandatory provide stub DAPM widgets and routes.

Note that the public information on the device appears to make no
mention of the FM support the driver appears to have.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wl1273.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 54cd3da..b7ab2ef 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -290,6 +290,18 @@ static const struct snd_kcontrol_new wl1273_controls[] = {
 		       snd_wl1273_fm_volume_get, snd_wl1273_fm_volume_put),
 };
 
+static const struct snd_soc_dapm_widget wl1273_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("RX"),
+
+	SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route wl1273_dapm_routes[] = {
+	{ "Capture", NULL, "RX" },
+
+	{ "TX", NULL, "Playback" },
+};
+
 static int wl1273_startup(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
@@ -483,6 +495,11 @@ static int wl1273_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_wl1273 = {
 	.probe = wl1273_probe,
 	.remove = wl1273_remove,
+
+	.dapm_widgets = wl1273_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wl1273_dapm_widgets),
+	.dapm_routes = wl1273_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wl1273_dapm_routes),
 };
 
 static int wl1273_platform_probe(struct platform_device *pdev)
-- 
1.8.4.rc3
