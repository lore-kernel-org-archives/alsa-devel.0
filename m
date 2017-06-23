From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: tidyup asoc_simple_card_canonicalize_cpu() parameter" to the asoc tree
Date: Fri, 23 Jun 2017 13:03:48 +0100
Message-ID: <E1dONJU-0006Lg-JB@debutante>
References: <87h8z8czsk.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87h8z8czsk.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-scu-card: tidyup asoc_simple_card_canonicalize_cpu() parameter

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

>From 32f2bcce3ed10b93236d747701a9c04d51626cc2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jun 2017 06:22:14 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: tidyup
 asoc_simple_card_canonicalize_cpu() parameter

asoc_simple_card_canonicalize_cpu() 2nd param is asking CPU component's
DAI links, not Card links.
This patch fixup it. Otherwise, audio-graph-card can't handle CPU
component correctly if CPU has mult-DAIs and Card uses only one of them

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 05934b24627b..061c7a60d6b4 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -125,7 +125,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 
 		/* card->num_links includes Codec */
 		asoc_simple_card_canonicalize_cpu(dai_link,
-					(card->num_links - 1) == 1);
+			of_graph_get_endpoint_count(dai_link->cpu_of_node) == 1);
 	} else {
 		/* FE is dummy */
 		dai_link->cpu_of_node		= NULL;
-- 
2.13.1
