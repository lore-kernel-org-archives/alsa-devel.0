From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: core: Fix obscure leak of runtime
	array
Date: Wed, 14 Mar 2012 21:20:43 +0000
Message-ID: <1331760044-16857-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE376103D57
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 22:20:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Grant Likely <grant@secretlab.ca>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We're currently not freeing card->rtd in cases where the card is
unregistered before being registered - convert it to devm_kzalloc() to
make sure that happens.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9a7ca0e..b0f8666 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1694,7 +1694,6 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 
 	snd_soc_dapm_free(&card->dapm);
 
-	kfree(card->rtd);
 	snd_card_free(card->snd_card);
 	return 0;
 
@@ -3120,9 +3119,10 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	soc_init_card_debugfs(card);
 
-	card->rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime) *
-			    (card->num_links + card->num_aux_devs),
-			    GFP_KERNEL);
+	card->rtd = devm_kzalloc(card->dev,
+				 sizeof(struct snd_soc_pcm_runtime) *
+				 (card->num_links + card->num_aux_devs),
+				 GFP_KERNEL);
 	if (card->rtd == NULL)
 		return -ENOMEM;
 	card->rtd_aux = &card->rtd[card->num_links];
-- 
1.7.9.1
