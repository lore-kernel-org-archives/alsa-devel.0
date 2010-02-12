From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Make pmdown_time a per-card setting
Date: Fri, 12 Feb 2010 11:40:18 +0000
Message-ID: <1265974819-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D15222444F
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 12:40:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Make the pmdown_time a per-card setting rather than a global one,
initialised before the card initialisation runs. This allows cards
to override the default setting if it makes sense to do so (for
example, due to an unavoidable pop).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |    4 +++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e6a6d10..d9d88dd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -521,6 +521,8 @@ struct snd_soc_card {
 	int (*set_bias_level)(struct snd_soc_card *,
 			      enum snd_soc_bias_level level);
 
+	int pmdown_time;
+
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;
 	int num_links;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ca89c78..94b9cde 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -542,7 +542,7 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 		/* start delayed pop wq here for playback streams */
 		codec_dai->pop_wait = 1;
 		schedule_delayed_work(&card->delayed_work,
-			msecs_to_jiffies(pmdown_time));
+			msecs_to_jiffies(card->pmdown_time));
 	} else {
 		/* capture streams can be powered down now */
 		snd_soc_dapm_stream_event(codec,
@@ -1039,6 +1039,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	dev_dbg(card->dev, "All components present, instantiating\n");
 
 	/* Found everything, bring it up */
+	card->pmdown_time = pmdown_time;
+
 	if (card->probe) {
 		ret = card->probe(pdev);
 		if (ret < 0)
-- 
1.6.6.1
