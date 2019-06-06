From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: snow: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:05 +0100 (BST)
Message-ID: <20190606212705.DBC5F440046@finisterre.sirena.org.uk>
References: <87k1dzl65z.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8DD8F896EF
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:06 +0200 (CEST)
In-Reply-To: <87k1dzl65z.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: snow: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From db1623faa43264fe4ef2234cdc555c0623b77482 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:09:56 +0900
Subject: [PATCH] ASoC: samsung: snow: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/snow.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 57ce90fe5004..8ea7799df028 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -14,6 +14,11 @@
 
 #define FIN_PLL_RATE		24000000
 
+SND_SOC_DAILINK_DEFS(links,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 struct snow_priv {
 	struct snd_soc_dai_link dai_link;
 	struct clk *clk_i2s_bus;
@@ -141,6 +146,13 @@ static int snow_probe(struct platform_device *pdev)
 	link->name = "Primary";
 	link->stream_name = link->name;
 
+	link->cpus = links_cpus;
+	link->num_cpus = ARRAY_SIZE(links_cpus);
+	link->codecs = links_codecs;
+	link->num_codecs = ARRAY_SIZE(links_codecs);
+	link->platforms = links_platforms;
+	link->num_platforms = ARRAY_SIZE(links_platforms);
+
 	card->dai_link = link;
 	card->num_links = 1;
 	card->dev = dev;
@@ -151,10 +163,10 @@ static int snow_probe(struct platform_device *pdev)
 	if (cpu) {
 		link->ops = &snow_card_ops;
 
-		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		link->cpus->of_node = of_parse_phandle(cpu, "sound-dai", 0);
 		of_node_put(cpu);
 
-		if (!link->cpu_of_node) {
+		if (!link->cpus->of_node) {
 			dev_err(dev, "Failed parsing cpu/sound-dai property\n");
 			return -EINVAL;
 		}
@@ -164,38 +176,38 @@ static int snow_probe(struct platform_device *pdev)
 		of_node_put(codec);
 
 		if (ret < 0) {
-			of_node_put(link->cpu_of_node);
+			of_node_put(link->cpus->of_node);
 			dev_err(dev, "Failed parsing codec node\n");
 			return ret;
 		}
 
-		priv->clk_i2s_bus = of_clk_get_by_name(link->cpu_of_node,
+		priv->clk_i2s_bus = of_clk_get_by_name(link->cpus->of_node,
 						       "i2s_opclk0");
 		if (IS_ERR(priv->clk_i2s_bus)) {
 			snd_soc_of_put_dai_link_codecs(link);
-			of_node_put(link->cpu_of_node);
+			of_node_put(link->cpus->of_node);
 			return PTR_ERR(priv->clk_i2s_bus);
 		}
 	} else {
-		link->codec_dai_name = "HiFi",
+		link->codecs->dai_name = "HiFi",
 
-		link->cpu_of_node = of_parse_phandle(dev->of_node,
+		link->cpus->of_node = of_parse_phandle(dev->of_node,
 						"samsung,i2s-controller", 0);
-		if (!link->cpu_of_node) {
+		if (!link->cpus->of_node) {
 			dev_err(dev, "i2s-controller property parse error\n");
 			return -EINVAL;
 		}
 
-		link->codec_of_node = of_parse_phandle(dev->of_node,
+		link->codecs->of_node = of_parse_phandle(dev->of_node,
 						"samsung,audio-codec", 0);
-		if (!link->codec_of_node) {
-			of_node_put(link->cpu_of_node);
+		if (!link->codecs->of_node) {
+			of_node_put(link->cpus->of_node);
 			dev_err(dev, "audio-codec property parse error\n");
 			return -EINVAL;
 		}
 	}
 
-	link->platform_of_node = link->cpu_of_node;
+	link->platforms->of_node = link->cpus->of_node;
 
 	/* Update card-name if provided through DT, else use default name */
 	snd_soc_of_parse_card_name(card, "samsung,model");
@@ -216,8 +228,8 @@ static int snow_remove(struct platform_device *pdev)
 	struct snow_priv *priv = platform_get_drvdata(pdev);
 	struct snd_soc_dai_link *link = &priv->dai_link;
 
-	of_node_put(link->cpu_of_node);
-	of_node_put(link->codec_of_node);
+	of_node_put(link->cpus->of_node);
+	of_node_put(link->codecs->of_node);
 	snd_soc_of_put_dai_link_codecs(link);
 
 	clk_put(priv->clk_i2s_bus);
-- 
2.20.1
