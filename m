From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: platform also uses asoc_simple_card_sub_parse_of()" to the asoc tree
Date: Mon, 30 May 2016 18:39:25 +0100
Message-ID: <E1b7R9x-0000qH-ET@debutante>
References: <87futdrs2g.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87futdrs2g.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: platform also uses asoc_simple_card_sub_parse_of()

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

>From 5fb9cb165130cdb67fb3ac42b4510ed7677a077d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 May 2016 09:40:41 +0000
Subject: [PATCH] ASoC: simple-card: platform also uses
 asoc_simple_card_sub_parse_of()

In current simple-card, platform is handled as special case,
but, the code is not readable.
This patch makes platform to use asoc_simple_card_sub_parse_of()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 466492b7d4f5..4e39c0fa78c9 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -223,6 +223,9 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	u32 val;
 	int ret;
 
+	if (!np)
+		return 0;
+
 	/*
 	 * Get node via "sound-dai = <&phandle port>"
 	 * it will be used as xxx_of_node on soc_bind_dai_link()
@@ -238,9 +241,14 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 		*args_count = args.args_count;
 
 	/* Get dai->name */
-	ret = snd_soc_of_get_dai_name(np, name);
-	if (ret < 0)
-		return ret;
+	if (name) {
+		ret = snd_soc_of_get_dai_name(np, name);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!dai)
+		return 0;
 
 	/* Parse TDM slot */
 	ret = snd_soc_of_parse_tdm_slot(np, &dai->tx_slot_mask,
@@ -374,21 +382,20 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
+	ret = asoc_simple_card_sub_parse_of(plat, NULL,
+					    &dai_link->platform_of_node,
+					    NULL, NULL);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name) {
 		ret = -EINVAL;
 		goto dai_link_of_err;
 	}
 
-	if (plat) {
-		struct of_phandle_args args;
-
-		ret = of_parse_phandle_with_args(plat, "sound-dai",
-						 "#sound-dai-cells", 0, &args);
-		dai_link->platform_of_node = args.np;
-	} else {
-		/* Assumes platform == cpu */
+	/* Assumes platform == cpu */
+	if (!dai_link->platform_of_node)
 		dai_link->platform_of_node = dai_link->cpu_of_node;
-	}
 
 	/* DAI link name is created from CPU/CODEC dai name */
 	name = devm_kzalloc(dev,
-- 
2.8.1
