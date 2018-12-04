From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add missing TDM Split mode
	support for simple-card" to the asoc tree
Date: Tue,  4 Dec 2018 17:27:10 +0000 (GMT)
Message-ID: <20181204172710.2BCDE11251E3@debutante.sirena.org.uk>
References: <87h8ft3ezh.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DBDDB267B69
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 18:27:10 +0100 (CET)
In-Reply-To: <87h8ft3ezh.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add missing TDM Split mode support for simple-card

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

>From 538a4ffea3f719ed8f853f78826e360aee5fe9d7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 4 Dec 2018 08:02:43 +0000
Subject: [PATCH] ASoC: rsnd: add missing TDM Split mode support for
 simple-card

commit f69f452243e4e1 ("ASoC: rsnd: add TDM Split mode support")
added TDM Split mode support for rsnd driver.
But, it cares audio-graph-card style only. We can't use TDM Split
mode on simple-card style now.
This patch fixup this issue.

Fixes: f69f452243e4e1 ("ASoC: rsnd: add TDM Split mode support")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 53 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 56469ac4bc8c..ad6298330fdb 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1031,6 +1031,49 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	.prepare	= rsnd_soc_dai_prepare,
 };
 
+static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
+				      struct device_node *dai_np,
+				      int dai_i, int is_play)
+{
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
+	struct rsnd_dai_stream *io = is_play ?
+		&rdai->playback :
+		&rdai->capture;
+	struct device_node *ssiu_np = rsnd_ssiu_of_node(priv);
+	struct device_node *np;
+	int i, j;
+
+	if (!ssiu_np)
+		return;
+
+	if (!rsnd_io_to_mod_ssi(io))
+		return;
+
+	/*
+	 * This driver assumes that it is TDM Split mode
+	 * if it includes ssiu node
+	 */
+	for (i = 0;; i++) {
+		struct device_node *node = is_play ?
+			of_parse_phandle(dai_np, "playback", i) :
+			of_parse_phandle(dai_np, "capture",  i);
+
+		if (!node)
+			break;
+
+		j = 0;
+		for_each_child_of_node(ssiu_np, np) {
+			if (np == node) {
+				rsnd_flags_set(io, RSND_STREAM_TDM_SPLIT);
+				dev_dbg(dev, "%s is part of TDM Split\n", io->name);
+			}
+			j++;
+		}
+
+	}
+}
+
 static void rsnd_parse_connect_graph(struct rsnd_priv *priv,
 				     struct rsnd_dai_stream *io,
 				     struct device_node *endpoint)
@@ -1246,8 +1289,14 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 			dai_i++;
 		}
 	} else {
-		for_each_child_of_node(dai_node, dai_np)
-			__rsnd_dai_probe(priv, dai_np, dai_i++);
+		for_each_child_of_node(dai_node, dai_np) {
+			__rsnd_dai_probe(priv, dai_np, dai_i);
+			if (rsnd_is_gen3(priv)) {
+				rsnd_parse_connect_simple(priv, dai_np, dai_i, 1);
+				rsnd_parse_connect_simple(priv, dai_np, dai_i, 0);
+			}
+			dai_i++;
+		}
 	}
 
 	return 0;
-- 
2.19.0.rc2
