From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: soc_cleanup_card_resources()
	become void" to the asoc tree
Date: Thu, 22 Aug 2019 19:32:56 +0100 (BST)
Message-ID: <20190822183256.E471BD02CD1@fitzroy.sirena.org.uk>
References: <871rxg1lda.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D4CDF804CB
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 20:33:06 +0200 (CEST)
In-Reply-To: <871rxg1lda.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Sridharan@sirena.org.uk, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Ranjani <ranjani.sridharan@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: soc_cleanup_card_resources() become void

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From a4de83a385670c22c31e9bbb726595a447b32ba4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Aug 2019 14:05:10 +0900
Subject: [PATCH] ASoC: soc-core: soc_cleanup_card_resources() become void

There is no need to check return value for
soc_cleanup_card_resources(). Let't makes it as void.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/871rxg1lda.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0ed6576bfef4..1be069c2ac8d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1885,7 +1885,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 	}
 }
 
-static int soc_cleanup_card_resources(struct snd_soc_card *card)
+static void soc_cleanup_card_resources(struct snd_soc_card *card)
 {
 	/* free the ALSA card at first; this syncs with pending operations */
 	if (card->snd_card) {
@@ -1906,8 +1906,6 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	/* remove the card */
 	if (card->remove)
 		card->remove(card);
-
-	return 0;
 }
 
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
-- 
2.20.1
