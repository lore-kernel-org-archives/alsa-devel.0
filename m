From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc.h: fixup for_each_card_links()
	macro" to the asoc tree
Date: Wed, 19 Jun 2019 13:12:04 +0100 (BST)
Message-ID: <20190619121204.E6E7B44004C@finisterre.sirena.org.uk>
References: <877e9itlgo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3C5FF89752
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 14:12:05 +0200 (CEST)
In-Reply-To: <877e9itlgo.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc.h: fixup for_each_card_links() macro

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 5f174cf75a8cb14d50c1cecfb3884ae82f754058 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Jun 2019 10:27:52 +0900
Subject: [PATCH] ASoC: soc.h: fixup for_each_card_links() macro

Macro is using "link", not "dai_link"

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 055e6d035e04..80c1ca3a62c7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1230,7 +1230,7 @@ struct snd_soc_card {
 	     (i)++)
 
 #define for_each_card_links(card, link)				\
-	list_for_each_entry(dai_link, &(card)->dai_link_list, list)
+	list_for_each_entry(link, &(card)->dai_link_list, list)
 #define for_each_card_links_safe(card, link, _link)			\
 	list_for_each_entry_safe(link, _link, &(card)->dai_link_list, list)
 
-- 
2.20.1
