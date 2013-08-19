From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: spdif: Add stub DAPM widgets for Rx
Date: Mon, 19 Aug 2013 12:04:54 +0100
Message-ID: <1376910294-6865-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2421C261A39
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 13:04:59 +0200 (CEST)
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

Ensure that the driver continues to work with mandatory DAPM.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/spdif_receiver.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/spdif_receiver.c b/sound/soc/codecs/spdif_receiver.c
index 26d3474..d5463c0 100644
--- a/sound/soc/codecs/spdif_receiver.c
+++ b/sound/soc/codecs/spdif_receiver.c
@@ -23,13 +23,26 @@
 #include <sound/initval.h>
 #include <linux/of.h>
 
+static const struct snd_soc_dapm_widget dir_widgets[] = {
+	SND_SOC_DAPM_INPUT("spdif-in"),
+};
+
+static const const struct snd_soc_dapm_route dir_routes[] = {
+	{ "Capture", NULL, "spdif-in" },
+};
+
 #define STUB_RATES	SNDRV_PCM_RATE_8000_192000
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 			SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | \
 			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
-static struct snd_soc_codec_driver soc_codec_spdif_dir;
+static struct snd_soc_codec_driver soc_codec_spdif_dir = {
+	.dapm_widgets = dir_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(dir_widgets),
+	.dapm_routes = dir_routes,
+	.num_dapm_routes = ARRAY_SIZE(dir_routes),
+};
 
 static struct snd_soc_dai_driver dir_stub_dai = {
 	.name		= "dir-hifi",
-- 
1.8.4.rc3
