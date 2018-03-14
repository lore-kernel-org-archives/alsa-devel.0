From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: pcm: improve debug output for DPCM BE
	searching.
Date: Wed, 14 Mar 2018 20:43:51 +0000
Message-ID: <20180314204351.13973-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 49FE726718B
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 21:43:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Improve the DPCM BE search debug output to make it easier to debug
issues in topologies.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-pcm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ea36de977c93..4ce489165a6d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1404,12 +1404,18 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 	struct snd_soc_pcm_runtime *be;
 	int i;
 
+	dev_dbg(card->dev, "ASoC: find BE for widget %s\n", widget->name);
+
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		list_for_each_entry(be, &card->rtd_list, list) {
 
 			if (!be->dai_link->no_pcm)
 				continue;
 
+			dev_dbg(card->dev, "ASoC: try BE : %s\n",
+				be->cpu_dai->playback_widget ?
+				be->cpu_dai->playback_widget->name : "(not set)");
+
 			if (be->cpu_dai->playback_widget == widget)
 				return be;
 
@@ -1426,6 +1432,10 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (!be->dai_link->no_pcm)
 				continue;
 
+			dev_dbg(card->dev, "ASoC: try BE %s\n",
+				be->cpu_dai->capture_widget ?
+				be->cpu_dai->capture_widget->name : "(not set)");
+
 			if (be->cpu_dai->capture_widget == widget)
 				return be;
 
@@ -1437,6 +1447,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		}
 	}
 
+	/* dai link name and stream name set correctly ? */
 	dev_err(card->dev, "ASoC: can't get %s BE for %s\n",
 		stream ? "capture" : "playback", widget->name);
 	return NULL;
-- 
2.14.1
