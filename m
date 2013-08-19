From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ac97: Provide stub DAPM integration
Date: Mon, 19 Aug 2013 12:18:20 +0100
Message-ID: <1376911100-16426-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AFF5261A9A
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 13:18:24 +0200 (CEST)
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
 sound/soc/codecs/ac97.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index ec73518..8d9ba4ba 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -23,6 +23,16 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+static const struct snd_soc_dapm_widget ac97_widgets[] = {
+	SND_SOC_DAPM_INPUT("RX"),
+	SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route ac97_routes[] = {
+	{ "AC97 Capture", NULL, "RX" },
+	{ "TX", NULL, "AC97 Playback" },
+};
+
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
@@ -117,6 +127,11 @@ static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
 	.probe = 	ac97_soc_probe,
 	.suspend =	ac97_soc_suspend,
 	.resume =	ac97_soc_resume,
+
+	.dapm_widgets = ac97_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ac97_widgets),
+	.dapm_routes = ac97_routes,
+	.num_dapm_routes = ARRAY_SIZE(ac97_routes),
 };
 
 static int ac97_probe(struct platform_device *pdev)
-- 
1.8.4.rc3
