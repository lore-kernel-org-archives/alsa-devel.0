From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: Create card debugfs directory earlier
Date: Thu,  9 Apr 2015 10:52:36 +0200
Message-ID: <1428569558-15883-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 852652651D2
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:52:47 +0200 (CEST)
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <festevam@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Create the card debugfs directory at the begining of the initilization
rather then the end as various steps in the initilization sequence will try
to register files and sub-directories in the card directory.

Fixes: 4e2576bd36a1 ("ASoC: soc-core: initialize debugfs in snd_soc_instantiate_card()")
Reported-by: Fabio Estevam <festevam@gmail.com>
Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2801578..7bd1599 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1555,6 +1555,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		goto base_error;
 	}
 
+	soc_init_card_debugfs(card);
+
 	card->dapm.bias_level = SND_SOC_BIAS_OFF;
 	card->dapm.dev = card->dev;
 	card->dapm.card = card;
@@ -1684,8 +1686,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
-	soc_init_card_debugfs(card);
-
 	return 0;
 
 probe_aux_dev_err:
@@ -1699,6 +1699,7 @@ card_probe_error:
 	if (card->remove)
 		card->remove(card);
 
+	soc_cleanup_card_debugfs(card);
 	snd_card_free(card->snd_card);
 
 base_error:
-- 
1.8.0
