From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: update Audio DMA path search
	method" to the asoc tree
Date: Fri, 17 Jul 2015 19:26:28 +0100
Message-ID: <E1ZGAL6-00062B-7O@debutante>
References: <877fq1vqo7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33ED72668F8
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 20:26:35 +0200 (CEST)
In-Reply-To: <877fq1vqo7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: update Audio DMA path search method

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

>From 7dfb49194557ccf27ab99c8c04c021320e7ae458 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:16:56 +0000
Subject: [PATCH] ASoC: rsnd: update Audio DMA path search method

Current rsnd driver is assuming Audio DMAC / Audio DMAC peri peri
are used from SSI/SSIU/SRC/DVC. But we will add CTU/MIX to this driver.
Then, current DMA path searching method is not understandable, and good
enough for this purpose. This patch update DMA path search method, more
simply.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 88 +++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index a175863d239c..23282f48f71f 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -494,7 +494,7 @@ static dma_addr_t rsnd_dma_addr(struct rsnd_dai_stream *io,
 	return rsnd_gen2_dma_addr(io, mod, is_play, is_from);
 }
 
-#define MOD_MAX 4 /* MEM/SSI/SRC/DVC */
+#define MOD_MAX (RSND_MOD_MAX + 1) /* +Memory */
 static void rsnd_dma_of_path(struct rsnd_dma *dma,
 			     struct rsnd_dai_stream *io,
 			     int is_play,
@@ -506,53 +506,71 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 	struct rsnd_mod *src = rsnd_io_to_mod_src(io);
 	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
 	struct rsnd_mod *mod[MOD_MAX];
-	int i, index;
+	struct rsnd_mod *mod_start, *mod_end;
+	struct rsnd_priv *priv = rsnd_mod_to_priv(this);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	int nr, i;
 
+	if (!ssi)
+		return;
 
-	for (i = 0; i < MOD_MAX; i++)
+	nr = 0;
+	for (i = 0; i < MOD_MAX; i++) {
 		mod[i] = NULL;
+		nr += !!rsnd_io_to_mod(io, i);
+	}
 
 	/*
-	 * in play case...
+	 * [S] -*-> [E]
+	 * [S] -*-> SRC -o-> [E]
+	 * [S] -*-> SRC -> DVC -o-> [E]
+	 * [S] -*-> SRC -> CTU -> MIX -> DVC -o-> [E]
+	 *
+	 * playback	[S] = mem
+	 *		[E] = SSI
 	 *
-	 * src -> dst
+	 * capture	[S] = SSI
+	 *		[E] = mem
 	 *
-	 * mem -> SSI
-	 * mem -> SRC -> SSI
-	 * mem -> SRC -> DVC -> SSI
+	 * -*->		Audio DMAC
+	 * -o->		Audio DMAC peri peri
 	 */
-	mod[0] = NULL; /* for "mem" */
-	index = 1;
-	for (i = 1; i < MOD_MAX; i++) {
-		if (!src) {
-			mod[i] = ssi;
-		} else if (!dvc) {
-			mod[i] = src;
-			src = NULL;
-		} else {
-			if ((!is_play) && (this == src))
-				this = dvc;
+	mod_start	= (is_play) ? NULL : ssi;
+	mod_end		= (is_play) ? ssi  : NULL;
 
-			mod[i] = (is_play) ? src : dvc;
-			i++;
-			mod[i] = (is_play) ? dvc : src;
+	mod[0] = mod_start;
+	for (i = 1; i < nr; i++) {
+		if (src) {
+			mod[i] = src;
 			src = NULL;
+		} else if (dvc) {
+			mod[i] = dvc;
 			dvc = NULL;
 		}
-
-		if (mod[i] == this)
-			index = i;
-
-		if (mod[i] == ssi)
-			break;
 	}
+	mod[i] = mod_end;
 
-	if (is_play) {
-		*mod_from = mod[index - 1];
-		*mod_to   = mod[index];
+	/*
+	 *		| SSI | SRC |
+	 * -------------+-----+-----+
+	 *  is_play	|  o  |  *  |
+	 * !is_play	|  *  |  o  |
+	 */
+	if ((this == ssi) == (is_play)) {
+		*mod_from	= mod[nr - 1];
+		*mod_to		= mod[nr];
 	} else {
-		*mod_from = mod[index];
-		*mod_to   = mod[index - 1];
+		*mod_from	= mod[0];
+		*mod_to		= mod[1];
+	}
+
+	dev_dbg(dev, "module connection (this is %s[%d])\n",
+		rsnd_mod_name(this), rsnd_mod_id(this));
+	for (i = 0; i <= nr; i++) {
+		dev_dbg(dev, "  %s[%d]%s\n",
+		       rsnd_mod_name(mod[i]), rsnd_mod_id(mod[i]),
+		       (mod[i] == *mod_from) ? " from" :
+		       (mod[i] == *mod_to)   ? " to" : "");
 	}
 }
 
@@ -580,8 +598,8 @@ void rsnd_dma_quit(struct rsnd_dai_stream *io, struct rsnd_dma *dma)
 
 int rsnd_dma_init(struct rsnd_dai_stream *io, struct rsnd_dma *dma, int id)
 {
-	struct rsnd_mod *mod_from;
-	struct rsnd_mod *mod_to;
+	struct rsnd_mod *mod_from = NULL;
+	struct rsnd_mod *mod_to = NULL;
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
-- 
2.1.4
