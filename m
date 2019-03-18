From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: add
	simple_parse_mclk_fs()" to the asoc tree
Date: Mon, 18 Mar 2019 14:50:58 +0000 (GMT)
Message-ID: <20190318145058.AD968112887B@debutante.sirena.org.uk>
References: <8736nkztkd.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86079F80792
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:50:59 +0100 (CET)
In-Reply-To: <8736nkztkd.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: add simple_parse_mclk_fs()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d708d35ef084535ba1a06d0c0f858e18a5edef5a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Mar 2019 13:50:17 +0900
Subject: [PATCH] ASoC: simple-card: add simple_parse_mclk_fs()

It is parsing mclk_fs at many places, but it should be
same operation. This patch adds simple_parse_mclk_fs()
and parse it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 5238c912cecd..b792638a11c8 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -187,6 +187,26 @@ static void simple_parse_convert(struct device *dev,
 	of_node_put(node);
 }
 
+static void simple_parse_mclk_fs(struct device_node *top,
+				 struct device_node *cpu,
+				 struct device_node *codec,
+				 struct simple_dai_props *props,
+				 char *prefix)
+{
+	struct device_node *node = of_get_parent(cpu);
+	char prop[128];
+
+	snprintf(prop, sizeof(prop), "%smclk-fs", PREFIX);
+	of_property_read_u32(top,	prop, &props->mclk_fs);
+
+	snprintf(prop, sizeof(prop), "%smclk-fs", prefix);
+	of_property_read_u32(node,	prop, &props->mclk_fs);
+	of_property_read_u32(cpu,	prop, &props->mclk_fs);
+	of_property_read_u32(codec,	prop, &props->mclk_fs);
+
+	of_node_put(node);
+}
+
 static int simple_dai_link_of_dpcm(struct simple_priv *priv,
 				   struct device_node *np,
 				   struct device_node *codec,
@@ -200,7 +220,6 @@ static int simple_dai_link_of_dpcm(struct simple_priv *priv,
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	struct device_node *top = dev->of_node;
 	struct device_node *node = of_get_parent(np);
-	char prop[128];
 	char *prefix = "";
 	int ret;
 
@@ -296,6 +315,7 @@ static int simple_dai_link_of_dpcm(struct simple_priv *priv,
 	}
 
 	simple_parse_convert(dev, np, &dai_props->adata);
+	simple_parse_mclk_fs(top, np, codec, dai_props, prefix);
 
 	asoc_simple_card_canonicalize_platform(dai_link);
 
@@ -303,11 +323,6 @@ static int simple_dai_link_of_dpcm(struct simple_priv *priv,
 	if (ret)
 		return ret;
 
-	snprintf(prop, sizeof(prop), "%smclk-fs", prefix);
-	of_property_read_u32(top,  PREFIX "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(node, prop, &dai_props->mclk_fs);
-	of_property_read_u32(np,   prop, &dai_props->mclk_fs);
-
 	ret = asoc_simple_card_parse_daifmt(dev, node, codec,
 					    prefix, &dai_link->dai_fmt);
 	if (ret < 0)
@@ -372,11 +387,7 @@ static int simple_dai_link_of(struct simple_priv *priv,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	snprintf(prop, sizeof(prop), "%smclk-fs", prefix);
-	of_property_read_u32(top,  PREFIX "mclk-fs", &dai_props->mclk_fs);
-	of_property_read_u32(node,  prop, &dai_props->mclk_fs);
-	of_property_read_u32(cpu,   prop, &dai_props->mclk_fs);
-	of_property_read_u32(codec, prop, &dai_props->mclk_fs);
+	simple_parse_mclk_fs(top, cpu, codec, dai_props, prefix);
 
 	ret = asoc_simple_card_parse_cpu(cpu, dai_link,
 					 DAI, CELL, &single_cpu);
-- 
2.20.1
