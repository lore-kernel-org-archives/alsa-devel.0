From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_spdif: Staticse non-exported symbols
Date: Sat, 31 Aug 2013 16:41:45 +0100
Message-ID: <1377963705-25670-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A3F18261AD6
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 17:41:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index e93dc0d..c5c228a 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -411,8 +411,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-int fsl_spdif_startup(struct snd_pcm_substream *substream,
-			struct snd_soc_dai *cpu_dai)
+static int fsl_spdif_startup(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *cpu_dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
@@ -546,7 +546,7 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-struct snd_soc_dai_ops fsl_spdif_dai_ops = {
+static struct snd_soc_dai_ops fsl_spdif_dai_ops = {
 	.startup = fsl_spdif_startup,
 	.hw_params = fsl_spdif_hw_params,
 	.trigger = fsl_spdif_trigger,
@@ -919,7 +919,7 @@ static int fsl_spdif_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-struct snd_soc_dai_driver fsl_spdif_dai = {
+static struct snd_soc_dai_driver fsl_spdif_dai = {
 	.probe = &fsl_spdif_dai_probe,
 	.playback = {
 		.channels_min = 2,
-- 
1.8.4.rc3
