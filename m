From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: remove asoc_simple_card_sub_parse_of()" to the asoc tree
Date: Mon, 08 Aug 2016 11:46:47 +0100
Message-ID: <E1bWi51-0000Is-O1@debutante>
References: <87d1mamjh9.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1mamjh9.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: remove asoc_simple_card_sub_parse_of()

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

>From c3b19c8dd069894961d0616aa3706df2920e7be4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 06:03:35 +0000
Subject: [PATCH] ASoC: simple-card: remove asoc_simple_card_sub_parse_of()

asoc_simple_card_sub_parse_of() is no longer needed. Let's cleanup

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 46 +++++++----------------------------------
 1 file changed, 8 insertions(+), 38 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 05d6e02c42f3..99028c190ea3 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -238,31 +238,6 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int
-asoc_simple_card_sub_parse_of(struct device_node *np,
-			      struct asoc_simple_dai *dai,
-			      struct device_node **p_node,
-			      const char **name,
-			      int *args_count)
-{
-	int ret;
-
-	if (!np)
-		return 0;
-
-	if (!dai)
-		return 0;
-
-	/* Parse TDM slot */
-	ret = snd_soc_of_parse_tdm_slot(np, &dai->tx_slot_mask,
-					&dai->rx_slot_mask,
-					&dai->slots, &dai->slot_width);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int asoc_simple_card_dai_link_of(struct device_node *node,
 					struct simple_card_data *priv,
 					int idx,
@@ -321,22 +296,17 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_sub_parse_of(cpu, &dai_props->cpu_dai,
-					    &dai_link->cpu_of_node,
-					    &dai_link->cpu_dai_name,
-					    &single_cpu);
-	if (ret < 0)
-		goto dai_link_of_err;
-
-	ret = asoc_simple_card_sub_parse_of(codec, &dai_props->codec_dai,
-					    &dai_link->codec_of_node,
-					    &dai_link->codec_dai_name, NULL);
+	ret = snd_soc_of_parse_tdm_slot(cpu,	&cpu_dai->tx_slot_mask,
+						&cpu_dai->rx_slot_mask,
+						&cpu_dai->slots,
+						&cpu_dai->slot_width);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_sub_parse_of(plat, NULL,
-					    &dai_link->platform_of_node,
-					    NULL, NULL);
+	ret = snd_soc_of_parse_tdm_slot(codec,	&codec_dai->tx_slot_mask,
+						&codec_dai->rx_slot_mask,
+						&codec_dai->slots,
+						&codec_dai->slot_width);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-- 
2.8.1
