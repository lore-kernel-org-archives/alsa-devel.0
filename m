From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: merge .nolock_start and .prepare"
	to the asoc tree
Date: Mon,  3 Sep 2018 14:44:56 +0100 (BST)
Message-ID: <20180903134456.78BD011227AE@debutante.sirena.org.uk>
References: <87tvn7dpx8.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BC462678B3
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:44:56 +0200 (CEST)
In-Reply-To: <87tvn7dpx8.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Jiada Wang <jiada_wang@mentor.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: merge .nolock_start and .prepare

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

>From 6ab6a2474e0dce02f71e92adb9778a168a8931f4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 3 Sep 2018 07:09:17 +0000
Subject: [PATCH] ASoC: rsnd: merge .nolock_start and .prepare

Main purpose of .nolock_start is we need to call
some function without spinlock.
OTOH we have .prepare which main purpose is
called under atomic context.
Then, it is called without spinlock.

In summary, our main callback init/quit, and start/stop
are called under "atomic context and with spinlock".
And some function need to be called under
"non-atomic context or without spinlock".
Let's merge .nolock_start and prepare to be more clear code.
Then, let's rename nolock_stop to cleanup

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 13 ++-----------
 sound/soc/sh/rcar/dma.c  | 20 ++++++++++----------
 sound/soc/sh/rcar/rsnd.h | 26 ++++++++++----------------
 3 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 299fb457573d..e46415c807a0 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -881,12 +881,10 @@ static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
 	struct snd_pcm_hw_constraint_list *constraint = &rdai->constraint;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int max_channels = rsnd_rdai_channels_get(rdai);
-	int ret;
 	int i;
 
 	rsnd_dai_stream_init(io, substream);
@@ -930,14 +928,7 @@ static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
 				    SNDRV_PCM_HW_PARAM_RATE, -1);
 	}
 
-	/*
-	 * call rsnd_dai_call without spinlock
-	 */
-	ret = rsnd_dai_call(nolock_start, io, priv);
-	if (ret < 0)
-		rsnd_dai_call(nolock_stop, io, priv);
-
-	return ret;
+	return 0;
 }
 
 static void rsnd_soc_dai_shutdown(struct snd_pcm_substream *substream,
@@ -950,7 +941,7 @@ static void rsnd_soc_dai_shutdown(struct snd_pcm_substream *substream,
 	/*
 	 * call rsnd_dai_call without spinlock
 	 */
-	rsnd_dai_call(nolock_stop, io, priv);
+	rsnd_dai_call(cleanup, io, priv);
 
 	rsnd_dai_stream_quit(io);
 }
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index d3b1a4ae876a..f99c1ab3b0bd 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -106,9 +106,9 @@ static int rsnd_dmaen_stop(struct rsnd_mod *mod,
 	return 0;
 }
 
-static int rsnd_dmaen_nolock_stop(struct rsnd_mod *mod,
-				   struct rsnd_dai_stream *io,
-				   struct rsnd_priv *priv)
+static int rsnd_dmaen_cleanup(struct rsnd_mod *mod,
+			      struct rsnd_dai_stream *io,
+			      struct rsnd_priv *priv)
 {
 	struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
 	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
@@ -116,7 +116,7 @@ static int rsnd_dmaen_nolock_stop(struct rsnd_mod *mod,
 	/*
 	 * DMAEngine release uses mutex lock.
 	 * Thus, it shouldn't be called under spinlock.
-	 * Let's call it under nolock_start
+	 * Let's call it under prepare
 	 */
 	if (dmaen->chan)
 		dma_release_channel(dmaen->chan);
@@ -126,9 +126,9 @@ static int rsnd_dmaen_nolock_stop(struct rsnd_mod *mod,
 	return 0;
 }
 
-static int rsnd_dmaen_nolock_start(struct rsnd_mod *mod,
-			    struct rsnd_dai_stream *io,
-			    struct rsnd_priv *priv)
+static int rsnd_dmaen_prepare(struct rsnd_mod *mod,
+			      struct rsnd_dai_stream *io,
+			      struct rsnd_priv *priv)
 {
 	struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
 	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
@@ -142,7 +142,7 @@ static int rsnd_dmaen_nolock_start(struct rsnd_mod *mod,
 	/*
 	 * DMAEngine request uses mutex lock.
 	 * Thus, it shouldn't be called under spinlock.
-	 * Let's call it under nolock_start
+	 * Let's call it under prepare
 	 */
 	dmaen->chan = rsnd_dmaen_request_channel(io,
 						 dma->mod_from,
@@ -287,8 +287,8 @@ static int rsnd_dmaen_pointer(struct rsnd_mod *mod,
 
 static struct rsnd_mod_ops rsnd_dmaen_ops = {
 	.name	= "audmac",
-	.nolock_start = rsnd_dmaen_nolock_start,
-	.nolock_stop  = rsnd_dmaen_nolock_stop,
+	.prepare = rsnd_dmaen_prepare,
+	.cleanup = rsnd_dmaen_cleanup,
 	.start	= rsnd_dmaen_start,
 	.stop	= rsnd_dmaen_stop,
 	.pointer= rsnd_dmaen_pointer,
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 7a04b19e405c..e857311ee5c1 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -295,15 +295,12 @@ struct rsnd_mod_ops {
 	int (*fallback)(struct rsnd_mod *mod,
 			struct rsnd_dai_stream *io,
 			struct rsnd_priv *priv);
-	int (*nolock_start)(struct rsnd_mod *mod,
-		    struct rsnd_dai_stream *io,
-		    struct rsnd_priv *priv);
-	int (*nolock_stop)(struct rsnd_mod *mod,
-		    struct rsnd_dai_stream *io,
-		    struct rsnd_priv *priv);
 	int (*prepare)(struct rsnd_mod *mod,
 		       struct rsnd_dai_stream *io,
 		       struct rsnd_priv *priv);
+	int (*cleanup)(struct rsnd_mod *mod,
+		       struct rsnd_dai_stream *io,
+		       struct rsnd_priv *priv);
 };
 
 struct rsnd_dai_stream;
@@ -323,7 +320,7 @@ struct rsnd_mod {
  *
  * 0xH0000CBA
  *
- * A	0: nolock_start	1: nolock_stop
+ * A	0: prepare	1: cleanup
  * B	0: init		1: quit
  * C	0: start	1: stop
  *
@@ -335,8 +332,8 @@ struct rsnd_mod {
  * H	0: pointer
  * H	0: prepare
  */
-#define __rsnd_mod_shift_nolock_start	0
-#define __rsnd_mod_shift_nolock_stop	0
+#define __rsnd_mod_shift_prepare	0
+#define __rsnd_mod_shift_cleanup	0
 #define __rsnd_mod_shift_init		4
 #define __rsnd_mod_shift_quit		4
 #define __rsnd_mod_shift_start		8
@@ -348,12 +345,11 @@ struct rsnd_mod {
 #define __rsnd_mod_shift_fallback	28 /* always called */
 #define __rsnd_mod_shift_hw_params	28 /* always called */
 #define __rsnd_mod_shift_pointer	28 /* always called */
-#define __rsnd_mod_shift_prepare	28 /* always called */
 
 #define __rsnd_mod_add_probe		0
 #define __rsnd_mod_add_remove		0
-#define __rsnd_mod_add_nolock_start	 1
-#define __rsnd_mod_add_nolock_stop	-1
+#define __rsnd_mod_add_prepare		 1
+#define __rsnd_mod_add_cleanup		-1
 #define __rsnd_mod_add_init		 1
 #define __rsnd_mod_add_quit		-1
 #define __rsnd_mod_add_start		 1
@@ -363,10 +359,11 @@ struct rsnd_mod {
 #define __rsnd_mod_add_fallback		0
 #define __rsnd_mod_add_hw_params	0
 #define __rsnd_mod_add_pointer		0
-#define __rsnd_mod_add_prepare		0
 
 #define __rsnd_mod_call_probe		0
 #define __rsnd_mod_call_remove		0
+#define __rsnd_mod_call_prepare		0
+#define __rsnd_mod_call_cleanup		1
 #define __rsnd_mod_call_init		0
 #define __rsnd_mod_call_quit		1
 #define __rsnd_mod_call_start		0
@@ -376,9 +373,6 @@ struct rsnd_mod {
 #define __rsnd_mod_call_fallback	0
 #define __rsnd_mod_call_hw_params	0
 #define __rsnd_mod_call_pointer		0
-#define __rsnd_mod_call_nolock_start	0
-#define __rsnd_mod_call_nolock_stop	1
-#define __rsnd_mod_call_prepare		0
 
 #define rsnd_mod_to_priv(mod)	((mod)->priv)
 #define rsnd_mod_name(mod)	((mod)->ops->name)
-- 
2.19.0.rc1
