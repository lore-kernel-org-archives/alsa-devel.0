From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Remove name_prefix unset during DAI link
	init hack again
Date: Sat, 26 Apr 2014 13:02:29 +0200
Message-ID: <1398510149-24032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-171.synserver.de (smtp-out-139.synserver.de
 [212.40.185.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 516132608ED
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 13:02:31 +0200 (CEST)
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
Cc: Fabien Parent <fparent@baylibre.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

This was initially removed in commit 6479f15ad ("ASoC: Remove name_prefix unset
during DAI link init hack"), but was brought back in commit 503ae5e0 ("ASoC:
core: Add helpers for dai link and aux dev init") by accident. This patch
removes it again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f18112a..94c1668 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1272,14 +1272,10 @@ static int soc_aux_dev_init(struct snd_soc_card *card,
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
-	const char *temp;
 	int ret;
 
 	rtd->card = card;
 
-	temp = codec->name_prefix;
-	codec->name_prefix = NULL;
-
 	/* do machine specific initialization */
 	if (aux_dev->init) {
 		ret = aux_dev->init(&codec->dapm);
@@ -1287,8 +1283,6 @@ static int soc_aux_dev_init(struct snd_soc_card *card,
 			return ret;
 	}
 
-	codec->name_prefix = temp;
-
 	rtd->codec = codec;
 
 	return 0;
@@ -1300,15 +1294,10 @@ static int soc_dai_link_init(struct snd_soc_card *card,
 {
 	struct snd_soc_dai_link *dai_link =  &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	const char *temp;
 	int ret;
 
 	rtd->card = card;
 
-	/* machine controls, routes and widgets are not prefixed */
-	temp = codec->name_prefix;
-	codec->name_prefix = NULL;
-
 	/* do machine specific initialization */
 	if (dai_link->init) {
 		ret = dai_link->init(rtd);
@@ -1316,8 +1305,6 @@ static int soc_dai_link_init(struct snd_soc_card *card,
 			return ret;
 	}
 
-	codec->name_prefix = temp;
-
 	rtd->codec = codec;
 
 	return 0;
-- 
1.8.0
