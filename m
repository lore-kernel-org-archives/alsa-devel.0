From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_parse_clk()" to the asoc tree
Date: Fri, 05 Aug 2016 13:09:01 +0100
Message-ID: <E1bVdvx-0002cx-Kx@debutante>
References: <87r3cxqd03.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87r3cxqd03.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_parse_clk()

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

>From 28abd99b6e40741cd0e75be20817f23a3044d338 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Jul 2016 02:53:13 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_parse_clk()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 43295f024982..b37c81b09203 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -244,8 +244,6 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			      int *args_count)
 {
 	struct of_phandle_args args;
-	struct clk *clk;
-	u32 val;
 	int ret;
 
 	if (!np)
@@ -282,29 +280,6 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	if (ret)
 		return ret;
 
-	/*
-	 * Parse dai->sysclk come from "clocks = <&xxx>"
-	 * (if system has common clock)
-	 *  or "system-clock-frequency = <xxx>"
-	 *  or device's module clock.
-	 */
-	if (of_property_read_bool(np, "clocks")) {
-		clk = of_clk_get(np, 0);
-		if (IS_ERR(clk)) {
-			ret = PTR_ERR(clk);
-			return ret;
-		}
-
-		dai->sysclk = clk_get_rate(clk);
-		dai->clk = clk;
-	} else if (!of_property_read_u32(np, "system-clock-frequency", &val)) {
-		dai->sysclk = val;
-	} else {
-		clk = of_clk_get(args.np, 0);
-		if (!IS_ERR(clk))
-			dai->sysclk = clk_get_rate(clk);
-	}
-
 	return 0;
 }
 
@@ -316,6 +291,8 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
+	struct asoc_simple_dai *cpu_dai = &dai_props->cpu_dai;
+	struct asoc_simple_dai *codec_dai = &dai_props->codec_dai;
 	struct device_node *cpu = NULL;
 	struct device_node *plat = NULL;
 	struct device_node *codec = NULL;
@@ -370,6 +347,14 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
+	ret = asoc_simple_card_parse_clk_cpu(cpu, dai_link, cpu_dai);
+	if (ret < 0)
+		goto dai_link_of_err;
+
+	ret = asoc_simple_card_parse_clk_codec(codec, dai_link, codec_dai);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name) {
 		ret = -EINVAL;
 		goto dai_link_of_err;
-- 
2.8.1
