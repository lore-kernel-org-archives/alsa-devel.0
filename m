From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove unneeded list_empty()
	check for snd_soc_try_rebind_card()" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:40 +0100 (BST)
Message-ID: <20190808203340.BBB272742BE9@ypsilon.sirena.org.uk>
References: <878ss5aho6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC55DF80534
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:42 +0200 (CEST)
In-Reply-To: <878ss5aho6.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove unneeded list_empty() check for snd_soc_try_rebind_card()

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

>From b245d273cbcd64eeaa93305f99c4ea8a6baf9c89 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:31:19 +0900
Subject: [PATCH] ASoC: soc-core: remove unneeded list_empty() check for
 snd_soc_try_rebind_card()

list_for_each_entry_safe() will do nothing if it was empty list.
This patch removes unneeded list_empty() check for
list_for_each_entry_safe().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/878ss5aho6.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cf3d967d731e..6b0042835233 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2808,12 +2808,9 @@ static void snd_soc_try_rebind_card(void)
 {
 	struct snd_soc_card *card, *c;
 
-	if (!list_empty(&unbind_card_list)) {
-		list_for_each_entry_safe(card, c, &unbind_card_list, list) {
-			if (!snd_soc_bind_card(card))
-				list_del(&card->list);
-		}
-	}
+	list_for_each_entry_safe(card, c, &unbind_card_list, list)
+		if (!snd_soc_bind_card(card))
+			list_del(&card->list);
 }
 
 int snd_soc_add_component(struct device *dev,
-- 
2.20.1
