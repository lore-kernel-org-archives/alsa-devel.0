From: mengdong.lin@intel.com
Subject: [RFC PATCH 03/10] ASoC: soc_bind_dai_link() change 2nd
	argument to DAI link pointer
Date: Mon, 10 Aug 2015 14:13:00 +0800
Message-ID: <1439187180-1059-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DFB7126532C
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 07:59:42 +0200 (CEST)
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Just code refactoring, to reuse it if new DAI Links are added later
based on topology in component probing phase.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e9e8956..ddfdd1d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -961,9 +961,9 @@ static struct snd_soc_dai *snd_soc_find_dai(
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
@@ -972,7 +972,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	const char *platform_name;
 	int i;
 
-	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
+	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
 
 	if (snd_soc_get_pcm_runtime(card, dai_link->name)) {
 		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
@@ -1717,7 +1717,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	/* bind DAIs */
 	for (i = 0; i < card->num_links; i++) {
-		ret = soc_bind_dai_link(card, i);
+		ret = soc_bind_dai_link(card, &card->dai_link[i]);
 		if (ret != 0)
 			goto base_error;
 	}
-- 
1.9.1
