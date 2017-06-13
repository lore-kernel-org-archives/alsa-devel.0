From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: use asoc_simple_card_clk_xxx()" to the asoc tree
Date: Tue, 13 Jun 2017 22:07:34 +0100
Message-ID: <E1dKt2E-0000Ck-1l@debutante>
References: <87y3t43aqr.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87y3t43aqr.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-card: use asoc_simple_card_clk_xxx()

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

>From d471d55934ca8b4f38535207589df4e3cc8b1484 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 9 Jun 2017 00:45:23 +0000
Subject: [PATCH] ASoC: audio-graph-card: use asoc_simple_card_clk_xxx()

Current simple-card-utils sets asoc_simple_dai::clk via
asoc_simple_card_parse_clk().
Current simple card drivers are using it directly for
clk_enable/disable.
Encapsulation is one of simple card util's purpose.
Let's use asoc_simple_card_clk_enable/disable.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 0180b286bee3..b5bb791a6e61 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -44,13 +44,13 @@ static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 	int ret;
 
-	ret = clk_prepare_enable(dai_props->cpu_dai.clk);
+	ret = asoc_simple_card_clk_enable(&dai_props->cpu_dai);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(dai_props->codec_dai.clk);
+	ret = asoc_simple_card_clk_enable(&dai_props->codec_dai);
 	if (ret)
-		clk_disable_unprepare(dai_props->cpu_dai.clk);
+		asoc_simple_card_clk_disable(&dai_props->cpu_dai);
 
 	return ret;
 }
@@ -61,9 +61,9 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
 
-	clk_disable_unprepare(dai_props->cpu_dai.clk);
+	asoc_simple_card_clk_disable(&dai_props->cpu_dai);
 
-	clk_disable_unprepare(dai_props->codec_dai.clk);
+	asoc_simple_card_clk_disable(&dai_props->codec_dai);
 }
 
 static struct snd_soc_ops asoc_graph_card_ops = {
-- 
2.11.0
