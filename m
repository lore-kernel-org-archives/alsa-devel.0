From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use asoc_simple_card_canonicalize_cpu()" to the asoc tree
Date: Wed, 10 Aug 2016 21:03:52 +0100
Message-ID: <E1bXZjE-0000QA-4l@debutante>
References: <87y445gymj.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87y445gymj.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use asoc_simple_card_canonicalize_cpu()

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

>From 27b010815bcfbb2cc79de7544547e33e4d169594 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Aug 2016 02:21:03 +0000
Subject: [PATCH] ASoC: rsrc-card: use asoc_simple_card_canonicalize_cpu()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 0bf17dae2b64..dd5eda1f9a29 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -134,7 +134,6 @@ static int rsrc_card_parse_links(struct device_node *np,
 	struct device *dev = rsrc_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
 	struct asoc_simple_dai *dai_props = rsrc_priv_to_props(priv, idx);
-	int is_single_links = 0;
 	int ret;
 
 	/* Parse TDM slot */
@@ -147,6 +146,8 @@ static int rsrc_card_parse_links(struct device_node *np,
 		return ret;
 
 	if (is_fe) {
+		int is_single_links = 0;
+
 		/* BE is dummy */
 		dai_link->codec_of_node		= NULL;
 		dai_link->codec_dai_name	= "snd-soc-dummy-dai";
@@ -171,17 +172,7 @@ static int rsrc_card_parse_links(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
-		/*
-		 * In soc_bind_dai_link() will check cpu name after
-		 * of_node matching if dai_link has cpu_dai_name.
-		 * but, it will never match if name was created by
-		 * fmt_single_name() remove cpu_dai_name if cpu_args
-		 * was 0. See:
-		 *	fmt_single_name()
-		 *	fmt_multiple_name()
-		 */
-		if (is_single_links)
-			dai_link->cpu_dai_name = NULL;
+		asoc_simple_card_canonicalize_cpu(dai_link, is_single_links);
 	} else {
 		const struct rsrc_card_of_data *of_data;
 
-- 
2.8.1
