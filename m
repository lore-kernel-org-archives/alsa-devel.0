From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Switch FSL SSI DAI over to
	symmetric_rates
Date: Sat, 23 May 2009 10:41:05 +0100
Message-ID: <1243071665-5968-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 53FCB24594
	for <alsa-devel@alsa-project.org>;
	Sat, 23 May 2009 11:41:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The effect of symmetric_constraints should provide a standard way to
enforce the use of the same sample rate for both directions.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/fsl/fsl_ssi.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 47afaa9..93f0f38 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -375,18 +375,14 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		struct snd_pcm_runtime *first_runtime =
 			ssi_private->first_stream->runtime;
 
-		if (!first_runtime->rate || !first_runtime->sample_bits) {
+		if (!first_runtime->sample_bits) {
 			dev_err(substream->pcm->card->dev,
-				"set sample rate and size in %s stream first\n",
+				"set sample size in %s stream first\n",
 				substream->stream == SNDRV_PCM_STREAM_PLAYBACK
 				? "capture" : "playback");
 			return -EAGAIN;
 		}
 
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-			SNDRV_PCM_HW_PARAM_RATE,
-			first_runtime->rate, first_runtime->rate);
-
 		/* If we're in synchronous mode, then we need to constrain
 		 * the sample size as well.  We don't support independent sample
 		 * rates in asynchronous mode.
@@ -693,6 +689,7 @@ struct snd_soc_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
 	fsl_ssi_dai->name = ssi_private->name;
 	fsl_ssi_dai->id = ssi_info->id;
 	fsl_ssi_dai->dev = ssi_info->dev;
+	fsl_ssi_dai->symmetric_rates = 1;
 
 	ret = snd_soc_register_dai(fsl_ssi_dai);
 	if (ret != 0) {
-- 
1.6.3.1
