From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Free card DAPM context on
	snd_soc_instantiate_card() error path
Date: Wed,  8 Jul 2015 22:14:48 +0200
Message-ID: <1436386488-5680-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-104.synserver.de (smtp-out-104.synserver.de
 [212.40.185.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 933F5265A81
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 22:14:55 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Make sure the to free the card DAPM context if snd_soc_instantiate_card()
fails, otherwise the memory allocated for the DAPM widgets is leaked.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2fc461c..8c8ce65 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1728,6 +1728,7 @@ card_probe_error:
 	if (card->remove)
 		card->remove(card);
 
+	snd_soc_dapm_free(&card->dapm);
 	soc_cleanup_card_debugfs(card);
 	snd_card_free(card->snd_card);
 
-- 
2.1.4
