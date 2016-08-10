From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_canonicalize_cpu()" to the asoc tree
Date: Wed, 10 Aug 2016 21:03:55 +0100
Message-ID: <E1bXZjH-0000RA-J3@debutante>
References: <87ziolgyn2.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87ziolgyn2.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_canonicalize_cpu()

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

>From 16f1de6f3656519120fd4a88d6b21fc3da8d373a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Aug 2016 02:20:43 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_canonicalize_cpu()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 8b1efdd2b115..64896e361bde 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -309,17 +309,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		dai_link->codec_dai_name,
 		dai_props->codec_dai.sysclk);
 
-	/*
-	 * In soc_bind_dai_link() will check cpu name after
-	 * of_node matching if dai_link has cpu_dai_name.
-	 * but, it will never match if name was created by
-	 * fmt_single_name() remove cpu_dai_name if cpu_args
-	 * was 0. See:
-	 *	fmt_single_name()
-	 *	fmt_multiple_name()
-	 */
-	if (single_cpu)
-		dai_link->cpu_dai_name = NULL;
+	asoc_simple_card_canonicalize_cpu(dai_link, single_cpu);
 
 dai_link_of_err:
 	of_node_put(cpu);
-- 
2.8.1
