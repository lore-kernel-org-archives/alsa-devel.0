From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup TDM Split mode check for
	CTU" to the asoc tree
Date: Sat,  2 Feb 2019 16:18:16 +0000 (GMT)
Message-ID: <20190202161816.BB3A7440082@finisterre.ee.mobilebroadband>
References: <874l9oneoo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E6002674F7
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:18:17 +0100 (CET)
In-Reply-To: <874l9oneoo.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup TDM Split mode check for CTU

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

>From 2264cf2e5db99cdff995592bf80ab6dea567ea91 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 1 Feb 2019 16:47:25 +0900
Subject: [PATCH] ASoC: rsnd: fixup TDM Split mode check for CTU

Renesas sound card need to judge that whether it is using
"TDM Split mode". To judge it and for other purpose, it has
rsnd_parse_connect_simple() and rsnd_parse_connect_graph(),
but these are using different judgement policy for
TDM Split mode.
It is pointless and confusable.
This patch add new rsnd_parse_tdm_split_mode() and use common
judgement policy for simple-card/audio-graph.

Without this patch, CTU will be judged as TDM Split mode
on audio-graph card.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 2a48d8a6cc76..2c2c60a3f276 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1031,7 +1031,7 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	.prepare	= rsnd_soc_dai_prepare,
 };
 
-static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
+static void rsnd_parse_tdm_split_mode(struct rsnd_priv *priv,
 				      struct rsnd_dai_stream *io,
 				      struct device_node *dai_np)
 {
@@ -1044,9 +1044,6 @@ static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
 	if (!ssiu_np)
 		return;
 
-	if (!rsnd_io_to_mod_ssi(io))
-		return;
-
 	/*
 	 * This driver assumes that it is TDM Split mode
 	 * if it includes ssiu node
@@ -1071,12 +1068,21 @@ static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
 	}
 }
 
+static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
+				      struct rsnd_dai_stream *io,
+				      struct device_node *dai_np)
+{
+	if (!rsnd_io_to_mod_ssi(io))
+		return;
+
+	rsnd_parse_tdm_split_mode(priv, io, dai_np);
+}
+
 static void rsnd_parse_connect_graph(struct rsnd_priv *priv,
 				     struct rsnd_dai_stream *io,
 				     struct device_node *endpoint)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct device_node *remote_port = of_graph_get_remote_port(endpoint);
 	struct device_node *remote_node = of_graph_get_remote_port_parent(endpoint);
 
 	if (!rsnd_io_to_mod_ssi(io))
@@ -1094,14 +1100,7 @@ static void rsnd_parse_connect_graph(struct rsnd_priv *priv,
 		dev_dbg(dev, "%s connected to HDMI1\n", io->name);
 	}
 
-	/*
-	 * This driver assumes that it is TDM Split mode
-	 * if remote node has multi endpoint
-	 */
-	if (of_get_child_count(remote_port) > 1) {
-		rsnd_flags_set(io, RSND_STREAM_TDM_SPLIT);
-		dev_dbg(dev, "%s is part of TDM Split\n", io->name);
-	}
+	rsnd_parse_tdm_split_mode(priv, io, endpoint);
 }
 
 void rsnd_parse_connect_common(struct rsnd_dai *rdai,
-- 
2.20.1
