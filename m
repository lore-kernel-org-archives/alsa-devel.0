From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: core: Clean up DAPM before the card
	debugfs
Date: Thu, 18 Aug 2016 19:37:29 +0100
Message-ID: <1471545449-29516-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E3C126619A
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 20:37:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Both the card and DAPM cleanups recursively delete their debugfs
directories.  Since the DAPM debugfs subdirectory for the card is
located within the card debugfs this means we end up trying to double
free the DAPM subdirectory.  Reorder the cleanup to free the card
debugfs after we've cleaned up DAPM and it has deleted its own
subdirectory.

Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---

Not tested at all yet, just about done for today.

 sound/soc/soc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16369cad4803..66a33f1e4881 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2083,14 +2083,13 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	/* remove auxiliary devices */
 	soc_remove_aux_devices(card);
 
+	snd_soc_dapm_free(&card->dapm);
 	soc_cleanup_card_debugfs(card);
 
 	/* remove the card */
 	if (card->remove)
 		card->remove(card);
 
-	snd_soc_dapm_free(&card->dapm);
-
 	snd_card_free(card->snd_card);
 	return 0;
 
-- 
2.8.1
