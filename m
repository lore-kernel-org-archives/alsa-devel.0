From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Free card DAPM context on
	snd_soc_instantiate_card() error path" to the asoc tree
Date: Wed, 08 Jul 2015 22:17:10 +0100
Message-ID: <E1ZCwiM-00071Q-4p@debutante>
References: <1436386488-5680-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB678265A81
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 23:17:19 +0200 (CEST)
In-Reply-To: <1436386488-5680-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Free card DAPM context on snd_soc_instantiate_card() error path

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

>From 2210438b6aae9668cf89c272fef935b83aedf81d Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 8 Jul 2015 22:14:48 +0200
Subject: [PATCH] ASoC: Free card DAPM context on snd_soc_instantiate_card()
 error path

Make sure the to free the card DAPM context if snd_soc_instantiate_card()
fails, otherwise the memory allocated for the DAPM widgets is leaked.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a4a5c0e3f97..0e1e69c7abd5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1716,6 +1716,7 @@ card_probe_error:
 	if (card->remove)
 		card->remove(card);
 
+	snd_soc_dapm_free(&card->dapm);
 	soc_cleanup_card_debugfs(card);
 	snd_card_free(card->snd_card);
 
-- 
2.1.4
