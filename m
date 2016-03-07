From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_src_get_in/out_rate()"
	to the asoc tree
Date: Mon, 07 Mar 2016 14:42:49 +0700
Message-ID: <E1acpoX-00072F-Ii@finisterre>
References: <87egbmyj43.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC4F126152C
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:42:52 +0100 (CET)
In-Reply-To: <87egbmyj43.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add rsnd_src_get_in/out_rate()

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

>From cbf1494fbcc80d363477af1efefb2380e7660a24 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Mar 2016 05:08:33 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_src_get_in/out_rate()

SRC will convert rate, and then, CMD and SSI want to know its
rate (= SRC.in / SRC.out) for each purpose.
Current driver is supporting only Playback, but SRC+Capture support
needs more flexibility.
This patch adds rsnd_src_get_in/out_rate() for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 10 +++++++---
 sound/soc/sh/rcar/src.c  | 20 +++++++++++++++++---
 sound/soc/sh/rcar/ssi.c  |  5 +++--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ff53f96e5006..4b77f33358fb 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -627,9 +627,13 @@ void rsnd_ssiu_remove(struct rsnd_priv *priv);
 int rsnd_src_probe(struct rsnd_priv *priv);
 void rsnd_src_remove(struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_src_mod_get(struct rsnd_priv *priv, int id);
-unsigned int rsnd_src_get_ssi_rate(struct rsnd_priv *priv,
-				   struct rsnd_dai_stream *io,
-				   struct snd_pcm_runtime *runtime);
+
+#define rsnd_src_get_in_rate(priv, io) rsnd_src_get_rate(priv, io, 1)
+#define rsnd_src_get_out_rate(priv, io) rsnd_src_get_rate(priv, io, 0)
+unsigned int rsnd_src_get_rate(struct rsnd_priv *priv,
+			       struct rsnd_dai_stream *io,
+			       int is_in);
+
 #define rsnd_src_of_node(priv)						\
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,src")
 #define rsnd_parse_connect_src(rdai, playback, capture)			\
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 1d5aedb50213..d1a8741cc446 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -116,12 +116,26 @@ static u32 rsnd_src_convert_rate(struct rsnd_dai_stream *io,
 	return convert_rate;
 }
 
-unsigned int rsnd_src_get_ssi_rate(struct rsnd_priv *priv,
-				   struct rsnd_dai_stream *io,
-				   struct snd_pcm_runtime *runtime)
+unsigned int rsnd_src_get_rate(struct rsnd_priv *priv,
+			       struct rsnd_dai_stream *io,
+			       int is_in)
 {
 	struct rsnd_mod *src_mod = rsnd_io_to_mod_src(io);
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	unsigned int rate = 0;
+	int is_play = rsnd_io_is_play(io);
+
+	/*
+	 *
+	 * Playback
+	 * runtime_rate -> [SRC] -> convert_rate
+	 *
+	 * Capture
+	 * convert_rate -> [SRC] -> runtime_rate
+	 */
+
+	if (is_play == is_in)
+		return runtime->rate;
 
 	/*
 	 * return convert rate if SRC is used,
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 540489755367..5f848f054745 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -190,7 +190,6 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 				     struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
@@ -201,7 +200,9 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 		1, 2, 4, 8, 16, 6, 12,
 	};
 	unsigned int main_rate;
-	unsigned int rate = rsnd_src_get_ssi_rate(priv, io, runtime);
+	unsigned int rate = rsnd_io_is_play(io) ?
+		rsnd_src_get_out_rate(priv, io) :
+		rsnd_src_get_in_rate(priv, io);
 
 	if (!rsnd_rdai_is_clk_master(rdai))
 		return 0;
-- 
2.7.0
