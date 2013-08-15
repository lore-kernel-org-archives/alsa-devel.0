From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: pcm3008: Add DAPM support
Date: Thu, 15 Aug 2013 12:04:55 +0100
Message-ID: <1376564696-5614-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A7537261A9C
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 13:05:02 +0200 (CEST)
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

Make it possible to connect external devices to the CODEC and ensure
continued operation with non-DAPM support removed from the core.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm3008.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 8b9b378..19f5028 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -28,6 +28,22 @@
 
 #include "pcm3008.h"
 
+static const struct snd_soc_dapm_widget pcm3008_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("VINL"),
+SND_SOC_DAPM_INPUT("VINR"),
+
+SND_SOC_DAPM_OUTPUT("VOUTL"),
+SND_SOC_DAPM_OUTPUT("VOUTR"),
+};
+
+static const struct snd_soc_dapm_route pcm3008_dapm_routes[] = {
+	{ "PCM3008 Capture", NULL, "VINL" },
+	{ "PCM3008 Capture", NULL, "VINR" },
+
+	{ "VOUTL", NULL, "PCM3008 Playback" },
+	{ "VOUTR", NULL, "PCM3008 Playback" },
+};
+
 #define PCM3008_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
 		       SNDRV_PCM_RATE_48000)
 
@@ -77,6 +93,10 @@ static int pcm3008_soc_resume(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
 	.suspend =	pcm3008_soc_suspend,
 	.resume =	pcm3008_soc_resume,
+	.dapm_widgets = pcm3008_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(pcm3008_dapm_widgets),
+	.dapm_routes = pcm3008_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(pcm3008_dapm_routes),
 };
 
 static int pcm3008_codec_probe(struct platform_device *pdev)
-- 
1.8.4.rc2
