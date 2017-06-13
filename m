From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple_card_utils: add asoc_simple_card_clk_xxx()" to the asoc tree
Date: Tue, 13 Jun 2017 22:07:46 +0100
Message-ID: <E1dKt2Q-0000Gw-7k@debutante>
References: <87a85iov10.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87a85iov10.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple_card_utils: add asoc_simple_card_clk_xxx()

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

>From 891caea417469b4efdf506b6be1ef461b759c999 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 9 Jun 2017 00:43:18 +0000
Subject: [PATCH] ASoC: simple_card_utils: add asoc_simple_card_clk_xxx()

Current simple-card-utils sets asoc_simple_dai::clk via
asoc_simple_card_parse_clk().
Current simple card drivers are using it directly for
clk_enable/disable.
Encapsulation is one of simple card util's purpose.
Let's encapsulate it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 ++
 sound/soc/generic/simple-card-utils.c | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 108cae459ed0..840d624148df 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -45,6 +45,8 @@ int asoc_simple_card_parse_clk(struct device *dev,
 			       struct device_node *dai_of_node,
 			       struct asoc_simple_dai *simple_dai,
 			       const char *name);
+int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai);
+void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
 
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index d9d8b8a58348..beb4e3817d22 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -110,6 +110,22 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
 
+static void asoc_simple_card_clk_register(struct asoc_simple_dai *dai,
+					  struct clk *clk)
+{
+	dai->clk = clk;
+}
+
+int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
+{
+	return clk_prepare_enable(dai->clk);
+}
+
+void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai)
+{
+	clk_disable_unprepare(dai->clk);
+}
+
 int asoc_simple_card_parse_clk(struct device *dev,
 			       struct device_node *node,
 			       struct device_node *dai_of_node,
@@ -128,7 +144,8 @@ int asoc_simple_card_parse_clk(struct device *dev,
 	clk = devm_get_clk_from_child(dev, node, NULL);
 	if (!IS_ERR(clk)) {
 		simple_dai->sysclk = clk_get_rate(clk);
-		simple_dai->clk = clk;
+
+		asoc_simple_card_clk_register(simple_dai, clk);
 	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
 		simple_dai->sysclk = val;
 	} else {
-- 
2.11.0
