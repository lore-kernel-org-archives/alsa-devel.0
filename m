From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: SSI function parameter uses "mod"
	instead of "ssi"" to the asoc tree
Date: Sun, 21 Feb 2016 02:16:10 +0900
Message-ID: <E1aXB8c-0008RQ-VW@finisterre>
References: <87mvqytp5d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B7826513A
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:14 +0100 (CET)
In-Reply-To: <87mvqytp5d.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: SSI function parameter uses "mod" instead of "ssi"

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

>From 26d34b11af6a344da6191beca2e2883f65d2597a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:14:37 +0000
Subject: [PATCH] ASoC: rsnd: SSI function parameter uses "mod" instead of
 "ssi"

To reduce confusion, SSI uses "mod" instead of "ssi"
as function parameter

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index a72ce28..c5c4510 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -188,14 +188,14 @@ u32 rsnd_ssi_multi_slaves(struct rsnd_dai_stream *io)
 	return mask;
 }
 
-static int rsnd_ssi_master_clk_start(struct rsnd_ssi *ssi,
+static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 				     struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-	struct rsnd_mod *mod = rsnd_mod_get(ssi);
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
 	int slots = rsnd_get_slot_width(io);
 	int j, ret;
@@ -255,11 +255,11 @@ static int rsnd_ssi_master_clk_start(struct rsnd_ssi *ssi,
 	return -EIO;
 }
 
-static void rsnd_ssi_master_clk_stop(struct rsnd_ssi *ssi,
+static void rsnd_ssi_master_clk_stop(struct rsnd_mod *mod,
 				     struct rsnd_dai_stream *io)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-	struct rsnd_mod *mod = rsnd_mod_get(ssi);
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
 
 	if (!rsnd_rdai_is_clk_master(rdai))
@@ -277,11 +277,12 @@ static void rsnd_ssi_master_clk_stop(struct rsnd_ssi *ssi,
 	rsnd_adg_ssi_clk_stop(mod);
 }
 
-static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
+static int rsnd_ssi_config_init(struct rsnd_mod *mod,
 				struct rsnd_dai_stream *io)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	u32 cr_own;
 	u32 cr_mode;
 	u32 wsr;
@@ -317,7 +318,7 @@ static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
 		return -EINVAL;
 	}
 
-	if (rsnd_ssi_is_dma_mode(rsnd_mod_get(ssi))) {
+	if (rsnd_ssi_is_dma_mode(mod)) {
 		cr_mode = UIEN | OIEN |	/* over/under run */
 			  DMEN;		/* DMA : enable DMA */
 	} else {
@@ -356,14 +357,14 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 
 	rsnd_mod_power_on(mod);
 
-	ret = rsnd_ssi_master_clk_start(ssi, io);
+	ret = rsnd_ssi_master_clk_start(mod, io);
 	if (ret < 0)
 		return ret;
 
 	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
-	ret = rsnd_ssi_config_init(ssi, io);
+	ret = rsnd_ssi_config_init(mod, io);
 	if (ret < 0)
 		return ret;
 
@@ -389,7 +390,7 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 	if (!rsnd_ssi_is_parent(mod, io))
 		ssi->cr_own	= 0;
 
-	rsnd_ssi_master_clk_stop(ssi, io);
+	rsnd_ssi_master_clk_stop(mod, io);
 
 	rsnd_mod_power_off(mod);
 
-- 
2.7.0
