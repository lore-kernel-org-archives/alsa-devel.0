From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Clean up DAPM before the card
	debugfs" to the asoc tree
Date: Fri, 19 Aug 2016 16:10:19 +0100
Message-ID: <E1balR5-0001Sl-LY@debutante>
References: <1471545449-29516-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D422026753B
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 17:10:32 +0200 (CEST)
In-Reply-To: <1471545449-29516-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Clean up DAPM before the card debugfs

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d1e81428826221d7ff8e4d83db784d099cd232a7 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Aug 2016 19:32:59 +0100
Subject: [PATCH] ASoC: core: Clean up DAPM before the card debugfs

Both the card and DAPM cleanups recursively delete their debugfs
directories.  Since the DAPM debugfs subdirectory for the card is
located within the card debugfs this means we end up trying to double
free the DAPM subdirectory.  Reorder the cleanup to free the card
debugfs after we've cleaned up DAPM and it has deleted its own
subdirectory.

Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Tested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
