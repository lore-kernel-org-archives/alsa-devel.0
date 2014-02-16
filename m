From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: uda134x: Use core for applying symmetry
	constraitns
Date: Sun, 16 Feb 2014 22:35:37 +0100
Message-ID: <1392586537-8198-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-011.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FDD72610B7
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 22:35:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Let the core take care of applying sample rate and sample bits constraints
instead of open-coding this in the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Only compile tested
---
 sound/soc/codecs/uda134x.c | 52 +++-------------------------------------------
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index c94d4c1..43b88ee 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -34,9 +34,6 @@
 struct uda134x_priv {
 	int sysclk;
 	int dai_fmt;
-
-	struct snd_pcm_substream *master_substream;
-	struct snd_pcm_substream *slave_substream;
 };
 
 /* In-data addresses are hard-coded into the reg-cache values */
@@ -156,49 +153,6 @@ static int uda134x_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
-static int uda134x_startup(struct snd_pcm_substream *substream,
-	struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
-	struct snd_pcm_runtime *master_runtime;
-
-	if (uda134x->master_substream) {
-		master_runtime = uda134x->master_substream->runtime;
-
-		pr_debug("%s constraining to %d bits at %d\n", __func__,
-			 master_runtime->sample_bits,
-			 master_runtime->rate);
-
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_RATE,
-					     master_runtime->rate,
-					     master_runtime->rate);
-
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-					     master_runtime->sample_bits,
-					     master_runtime->sample_bits);
-
-		uda134x->slave_substream = substream;
-	} else
-		uda134x->master_substream = substream;
-
-	return 0;
-}
-
-static void uda134x_shutdown(struct snd_pcm_substream *substream,
-	struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
-
-	if (uda134x->master_substream == substream)
-		uda134x->master_substream = uda134x->slave_substream;
-
-	uda134x->slave_substream = NULL;
-}
-
 static int uda134x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
@@ -208,7 +162,7 @@ static int uda134x_hw_params(struct snd_pcm_substream *substream,
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 	u8 hw_params;
 
-	if (substream == uda134x->slave_substream) {
+	if (dai->active) {
 		pr_debug("%s ignoring hw_params for slave substream\n",
 			 __func__);
 		return 0;
@@ -447,8 +401,6 @@ static const struct snd_soc_dapm_route uda134x_dapm_routes[] = {
 };
 
 static const struct snd_soc_dai_ops uda134x_dai_ops = {
-	.startup	= uda134x_startup,
-	.shutdown	= uda134x_shutdown,
 	.hw_params	= uda134x_hw_params,
 	.digital_mute	= uda134x_mute,
 	.set_sysclk	= uda134x_set_dai_sysclk,
@@ -475,6 +427,8 @@ static struct snd_soc_dai_driver uda134x_dai = {
 	},
 	/* pcm operations */
 	.ops = &uda134x_dai_ops,
+	.symmetric_rates = 1,
+	.symmetric_samplebits = 1,
 };
 
 static int uda134x_soc_probe(struct snd_soc_codec *codec)
-- 
1.8.0
