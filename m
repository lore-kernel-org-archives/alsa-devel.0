From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/3] ASoC: Change 2nd argument of
	soc_bind_dai_link() to DAI link pointer
Date: Mon, 23 Nov 2015 11:03:52 -0500
Message-ID: <b0f365bbf5686b90723c25060076b42380824cb8.1448294077.git.mengdong.lin@linux.intel.com>
References: <cover.1448294077.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CBEAF265357
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 16:48:00 +0100 (CET)
In-Reply-To: <cover.1448294077.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Just code refactoring, to reuse it if new DAI Links are added later
based on topology in component probing phase.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2ecd094..878a9fe 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -960,9 +960,9 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	return NULL;
 }
 
-static int soc_bind_dai_link(struct snd_soc_card *card, int num)
+static int soc_bind_dai_link(struct snd_soc_card *card,
+	struct snd_soc_dai_link *dai_link)
 {
-	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	struct snd_soc_dai_link_component cpu_dai_component;
@@ -971,7 +971,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	const char *platform_name;
 	int i;
 
-	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
+	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
 
 	rtd = soc_new_pcm_runtime(card, dai_link);
 	if (!rtd)
@@ -1710,7 +1710,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	/* bind DAIs */
 	for (i = 0; i < card->num_links; i++) {
-		ret = soc_bind_dai_link(card, i);
+		ret = soc_bind_dai_link(card, &card->dai_link[i]);
 		if (ret != 0)
 			goto base_error;
 	}
-- 
2.5.0
