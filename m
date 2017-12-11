From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove unneeded "is_graph" from
	__rsnd_dai_probe()" to the asoc tree
Date: Mon, 11 Dec 2017 12:13:18 +0000
Message-ID: <E1eOMxS-0004ZR-HU@debutante>
References: <87k1xuuh5b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 61B242673D4
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 13:13:23 +0100 (CET)
In-Reply-To: <87k1xuuh5b.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove unneeded "is_graph" from __rsnd_dai_probe()

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

>From 9f761183947b91aacc4ed5c2a1a39ac08b938b6c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Dec 2017 02:43:41 +0000
Subject: [PATCH] ASoC: rsnd: remove unneeded "is_graph" from
 __rsnd_dai_probe()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index a96ebebd96de..64d5ecb86528 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1017,7 +1017,7 @@ static struct device_node *rsnd_dai_of_node(struct rsnd_priv *priv,
 
 static void __rsnd_dai_probe(struct rsnd_priv *priv,
 			     struct device_node *dai_np,
-			     int dai_i, int is_graph)
+			     int dai_i)
 {
 	struct device_node *playback, *capture;
 	struct rsnd_dai_stream *io_playback;
@@ -1116,13 +1116,13 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	dai_i = 0;
 	if (is_graph) {
 		for_each_endpoint_of_node(dai_node, dai_np) {
-			__rsnd_dai_probe(priv, dai_np, dai_i, is_graph);
+			__rsnd_dai_probe(priv, dai_np, dai_i);
 			rsnd_ssi_parse_hdmi_connection(priv, dai_np, dai_i);
 			dai_i++;
 		}
 	} else {
 		for_each_child_of_node(dai_node, dai_np)
-			__rsnd_dai_probe(priv, dai_np, dai_i++, is_graph);
+			__rsnd_dai_probe(priv, dai_np, dai_i++);
 	}
 
 	return 0;
-- 
2.15.1
