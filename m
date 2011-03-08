From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Refactor symmetric_rates check to
	reduce indentation
Date: Tue,  8 Mar 2011 13:56:19 +0000
Message-ID: <1299592580-3759-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28BAF103820
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 14:56:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c2ec6cb..65ff612 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -500,20 +500,20 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	if (codec_dai->driver->symmetric_rates || cpu_dai->driver->symmetric_rates ||
-			rtd->dai_link->symmetric_rates) {
-		dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n",
-				rtd->rate);
-
-		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
-						   SNDRV_PCM_HW_PARAM_RATE,
-						   rtd->rate,
-						   rtd->rate);
-		if (ret < 0) {
-			dev_err(&rtd->dev,
-				"Unable to apply rate symmetry constraint: %d\n", ret);
-			return ret;
-		}
+	if (!codec_dai->driver->symmetric_rates &&
+	    !cpu_dai->driver->symmetric_rates &&
+	    !rtd->dai_link->symmetric_rates)
+		return 0;
+
+	dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n", rtd->rate);
+
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   rtd->rate, rtd->rate);
+	if (ret < 0) {
+		dev_err(&rtd->dev,
+			"Unable to apply rate symmetry constraint: %d\n", ret);
+		return ret;
 	}
 
 	return 0;
-- 
1.7.2.3
