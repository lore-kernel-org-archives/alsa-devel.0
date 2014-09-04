From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/9] ASoC: Set card->instantiated to false when
	removing the card
Date: Thu,  4 Sep 2014 19:44:04 +0200
Message-ID: <1409852652-27939-2-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 261E0265691
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 19:44:43 +0200 (CEST)
In-Reply-To: <1409852652-27939-1-git-send-email-lars@metafoo.de>
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

Set card->instantiated to false when the card is removed to make sure that
operations that expect the card to be fully instantiated do not run anymore
during card removal.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b1327ef..031a19a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3810,8 +3810,10 @@ EXPORT_SYMBOL_GPL(snd_soc_register_card);
  */
 int snd_soc_unregister_card(struct snd_soc_card *card)
 {
-	if (card->instantiated)
+	if (card->instantiated) {
+		card->instantiated = false;
 		soc_cleanup_card_resources(card);
+	}
 	dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 
 	return 0;
-- 
1.8.0
