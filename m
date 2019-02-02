From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: synchronize connection check for
	simple-card/audio-graph" to the asoc tree
Date: Sat,  2 Feb 2019 16:18:19 +0000 (GMT)
Message-ID: <20190202161819.4553F440082@finisterre.ee.mobilebroadband>
References: <875zu4neqa.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CC27D267A02
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:18:19 +0100 (CET)
In-Reply-To: <875zu4neqa.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: synchronize connection check for simple-card/audio-graph

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

>From f497c88b195eaee8733a304f2a1dc27fb319c9c3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 1 Feb 2019 16:46:27 +0900
Subject: [PATCH] ASoC: rsnd: synchronize connection check for
 simple-card/audio-graph

Current rsnd driver has below function to check connection
	rsnd_parse_connect_simple()
	rsnd_parse_connect_graph()
But these have different parameters. This patch synchronize these
for cleanup.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 59e250cc2e9d..2a48d8a6cc76 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1032,16 +1032,13 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 };
 
 static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
-				      struct device_node *dai_np,
-				      int dai_i, int is_play)
+				      struct rsnd_dai_stream *io,
+				      struct device_node *dai_np)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
-	struct rsnd_dai_stream *io = is_play ?
-		&rdai->playback :
-		&rdai->capture;
 	struct device_node *ssiu_np = rsnd_ssiu_of_node(priv);
 	struct device_node *np;
+	int is_play = rsnd_io_is_play(io);
 	int i, j;
 
 	if (!ssiu_np)
@@ -1292,8 +1289,10 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 		for_each_child_of_node(dai_node, dai_np) {
 			__rsnd_dai_probe(priv, dai_np, dai_i);
 			if (rsnd_is_gen3(priv)) {
-				rsnd_parse_connect_simple(priv, dai_np, dai_i, 1);
-				rsnd_parse_connect_simple(priv, dai_np, dai_i, 0);
+				struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
+
+				rsnd_parse_connect_simple(priv, &rdai->playback, dai_np);
+				rsnd_parse_connect_simple(priv, &rdai->capture,  dai_np);
 			}
 			dai_i++;
 		}
-- 
2.20.1
