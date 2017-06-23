From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: tidyup asoc_simple_card_canonicalize_cpu() parameter" to the asoc tree
Date: Fri, 23 Jun 2017 13:03:54 +0100
Message-ID: <E1dONJa-0006MX-AO@debutante>
References: <87injoczta.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87injoczta.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: tidyup asoc_simple_card_canonicalize_cpu() parameter

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

>From 47ca9593decee772a48d630af815aabedf99e694 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jun 2017 06:21:49 +0000
Subject: [PATCH] ASoC: audio-graph-card: tidyup
 asoc_simple_card_canonicalize_cpu() parameter

asoc_simple_card_canonicalize_cpu() 2nd param is asking CPU component's
DAI links, not Card links.
This patch fixup it. Otherwise, audio-graph-card can't handle CPU
component correctly if CPU has mult-DAIs and Card uses only one of them

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 885b405d7844..ee752f62d89d 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -100,7 +100,6 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, idx);
 	struct asoc_simple_dai *cpu_dai = &dai_props->cpu_dai;
 	struct asoc_simple_dai *codec_dai = &dai_props->codec_dai;
-	struct snd_soc_card *card = graph_priv_to_card(priv);
 	struct device_node *cpu_ep    = of_get_next_child(cpu_port, NULL);
 	struct device_node *codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 	struct device_node *rcpu_ep = of_graph_get_remote_endpoint(codec_ep);
@@ -162,7 +161,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	dai_link->init = asoc_graph_card_dai_init;
 
 	asoc_simple_card_canonicalize_cpu(dai_link,
-					  card->num_links == 1);
+		of_graph_get_endpoint_count(dai_link->cpu_of_node) == 1);
 
 dai_link_of_err:
 	of_node_put(cpu_ep);
-- 
2.13.1
