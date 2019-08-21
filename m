From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove unneeded dai_link
	check from snd_soc_remove_dai_link()" to the asoc tree
Date: Wed, 21 Aug 2019 13:15:32 +0100 (BST)
Message-ID: <20190821121532.4491A27430D0@ypsilon.sirena.org.uk>
References: <875zms1ldm.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com
 [209.85.128.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2290EF80322
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 14:15:33 +0200 (CEST)
Received: by mail-wm1-f98.google.com with SMTP id c5so1699969wmb.5
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 05:15:33 -0700 (PDT)
In-Reply-To: <875zms1ldm.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Sridharan@sirena.co.uk, Ranjani <ranjani.sridharan@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove unneeded dai_link check from snd_soc_remove_dai_link()

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

>From c26a8841119826badc8d358a4266880f83359f26 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Aug 2019 14:04:58 +0900
Subject: [PATCH] ASoC: soc-core: remove unneeded dai_link check from
 snd_soc_remove_dai_link()

snd_soc_remove_dai_link() has card connected dai_link check. but
	1) we need to call list_del() anyway,
	   because it is "remove" function,
	2) It is doing many thing for this card / dai_link already
	   before checking dai_link.

This patch removes poinless dai_link check

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/875zms1ldm.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d428491d51a7..6df880be1622 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1182,8 +1182,6 @@ EXPORT_SYMBOL_GPL(snd_soc_add_dai_link);
 void snd_soc_remove_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *dai_link)
 {
-	struct snd_soc_dai_link *link, *_link;
-
 	if (dai_link->dobj.type
 	    && dai_link->dobj.type != SND_SOC_DOBJ_DAI_LINK) {
 		dev_err(card->dev, "Invalid dai link type %d\n",
@@ -1199,12 +1197,7 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 	if (dai_link->dobj.type && card->remove_dai_link)
 		card->remove_dai_link(card, dai_link);
 
-	for_each_card_links_safe(card, link, _link) {
-		if (link == dai_link) {
-			list_del(&link->list);
-			return;
-		}
-	}
+	list_del(&dai_link->list);
 }
 EXPORT_SYMBOL_GPL(snd_soc_remove_dai_link);
 
-- 
2.20.1
