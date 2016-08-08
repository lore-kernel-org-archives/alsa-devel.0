From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use asoc_simple_card_parse_dai()" to the asoc tree
Date: Mon, 08 Aug 2016 11:46:53 +0100
Message-ID: <E1bWi57-0000Ko-JI@debutante>
References: <87fur6mjic.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fur6mjic.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_parse_dai()

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

>From 44c16af1fa8a5b1464fd76834ee6943f721748fa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 8 Aug 2016 06:02:07 +0000
Subject: [PATCH] ASoC: simple-card: use asoc_simple_card_parse_dai()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 43 +++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index b37c81b09203..05d6e02c42f3 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -44,6 +44,8 @@ struct simple_card_data {
 #define simple_priv_to_link(priv, i) ((priv)->snd_card.dai_link + i)
 #define simple_priv_to_props(priv, i) ((priv)->dai_props + i)
 
+#define DAI	"sound-dai"
+#define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
 
 #define asoc_simple_card_init_hp(card, sjack, prefix)\
@@ -243,33 +245,11 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			      const char **name,
 			      int *args_count)
 {
-	struct of_phandle_args args;
 	int ret;
 
 	if (!np)
 		return 0;
 
-	/*
-	 * Get node via "sound-dai = <&phandle port>"
-	 * it will be used as xxx_of_node on soc_bind_dai_link()
-	 */
-	ret = of_parse_phandle_with_args(np, "sound-dai",
-					 "#sound-dai-cells", 0, &args);
-	if (ret)
-		return ret;
-
-	*p_node = args.np;
-
-	if (args_count)
-		*args_count = args.args_count;
-
-	/* Get dai->name */
-	if (name) {
-		ret = snd_soc_of_get_dai_name(np, name);
-		if (ret < 0)
-			return ret;
-	}
-
 	if (!dai)
 		return 0;
 
@@ -298,7 +278,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	struct device_node *codec = NULL;
 	char prop[128];
 	char *prefix = "";
-	int ret, cpu_args;
+	int ret, single_cpu;
 	u32 val;
 
 	/* For single DAI link & old style of DT node */
@@ -328,10 +308,23 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (!of_property_read_u32(node, "mclk-fs", &val))
 		dai_props->mclk_fs = val;
 
+	ret = asoc_simple_card_parse_cpu(cpu, dai_link,
+					 DAI, CELL, &single_cpu);
+	if (ret < 0)
+		goto dai_link_of_err;
+
+	ret = asoc_simple_card_parse_codec(codec, dai_link, DAI, CELL);
+	if (ret < 0)
+		goto dai_link_of_err;
+
+	ret = asoc_simple_card_parse_platform(plat, dai_link, DAI, CELL);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	ret = asoc_simple_card_sub_parse_of(cpu, &dai_props->cpu_dai,
 					    &dai_link->cpu_of_node,
 					    &dai_link->cpu_dai_name,
-					    &cpu_args);
+					    &single_cpu);
 	if (ret < 0)
 		goto dai_link_of_err;
 
@@ -392,7 +385,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	 *	fmt_single_name()
 	 *	fmt_multiple_name()
 	 */
-	if (!cpu_args)
+	if (single_cpu)
 		dai_link->cpu_dai_name = NULL;
 
 dai_link_of_err:
-- 
2.8.1
