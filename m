From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: SRC function parameter uses "mod"
	instead of "src"" to the asoc tree
Date: Mon, 07 Mar 2016 14:42:52 +0700
Message-ID: <E1acpoa-00073I-Tu@finisterre>
References: <87h9giyj5v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C02261555
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:42:55 +0100 (CET)
In-Reply-To: <87h9giyj5v.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: SRC function parameter uses "mod" instead of "src"

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

>From 1a9be9ee194131465d945981969b85045f20e6af Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Mar 2016 05:07:29 +0000
Subject: [PATCH] ASoC: rsnd: SRC function parameter uses "mod" instead of
 "src"

To reduce confusion, SRC uses "mod" instead of "src"
as function parameter

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index ab974afe79eb..d520690409a2 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -93,9 +93,10 @@ static struct dma_chan *rsnd_src_dma_req(struct rsnd_dai_stream *io,
 }
 
 static u32 rsnd_src_convert_rate(struct rsnd_dai_stream *io,
-				 struct rsnd_src *src)
+				 struct rsnd_mod *mod)
 {
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	u32 convert_rate;
 
 	if (!runtime)
@@ -120,18 +121,14 @@ unsigned int rsnd_src_get_ssi_rate(struct rsnd_priv *priv,
 				   struct snd_pcm_runtime *runtime)
 {
 	struct rsnd_mod *src_mod = rsnd_io_to_mod_src(io);
-	struct rsnd_src *src;
 	unsigned int rate = 0;
 
-	if (src_mod) {
-		src = rsnd_mod_to_src(src_mod);
-
-		/*
-		 * return convert rate if SRC is used,
-		 * otherwise, return runtime->rate as usual
-		 */
-		rate = rsnd_src_convert_rate(io, src);
-	}
+	/*
+	 * return convert rate if SRC is used,
+	 * otherwise, return runtime->rate as usual
+	 */
+	if (src_mod)
+		rate = rsnd_src_convert_rate(io, src_mod);
 
 	if (!rate)
 		rate = runtime->rate;
@@ -179,7 +176,7 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
-	u32 convert_rate = rsnd_src_convert_rate(io, src);
+	u32 convert_rate = rsnd_src_convert_rate(io, mod);
 	u32 ifscr, fsrate, adinr;
 	u32 cr, route;
 	u32 bsdsr, bsisr;
-- 
2.7.0
