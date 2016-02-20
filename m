From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup SSI init/start sequence"
	to the asoc tree
Date: Sun, 21 Feb 2016 02:16:02 +0900
Message-ID: <E1aXB8U-0008Px-8p@finisterre>
References: <87io1mtp0w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66D3B26510A
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:14 +0100 (CET)
In-Reply-To: <87io1mtp0w.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup SSI init/start sequence

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

>From 0dc6bf75023a42895962800020583c19e0b87159 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:17:18 +0000
Subject: [PATCH] ASoC: rsnd: tidyup SSI init/start sequence

SSI want to have SSIWSR settings and SSICR settings without EN bit
when init, and SSICR EN bit only when start timing.
Otherwise, SSI output signal might be unstable.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index b1a29e2..1205872 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -276,7 +276,7 @@ static void rsnd_ssi_master_clk_stop(struct rsnd_mod *mod,
 	rsnd_adg_ssi_clk_stop(mod);
 }
 
-static int rsnd_ssi_config_init(struct rsnd_mod *mod,
+static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 				struct rsnd_dai_stream *io)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
@@ -313,8 +313,6 @@ static int rsnd_ssi_config_init(struct rsnd_mod *mod,
 	case 32:
 		cr_own |= DWL_24;
 		break;
-	default:
-		return -EINVAL;
 	}
 
 	if (rsnd_ssi_is_dma_mode(mod)) {
@@ -338,8 +336,16 @@ static int rsnd_ssi_config_init(struct rsnd_mod *mod,
 	ssi->cr_own	= cr_own;
 	ssi->cr_mode	= cr_mode;
 	ssi->wsr	= wsr;
+}
 
-	return 0;
+static void rsnd_ssi_register_setup(struct rsnd_mod *mod)
+{
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+
+	rsnd_mod_write(mod, SSIWSR,	ssi->wsr);
+	rsnd_mod_write(mod, SSICR,	ssi->cr_own	|
+					ssi->cr_clk	|
+					ssi->cr_mode); /* without EN */
 }
 
 /*
@@ -360,12 +366,10 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	if (rsnd_ssi_is_parent(mod, io))
-		return 0;
+	if (!rsnd_ssi_is_parent(mod, io))
+		rsnd_ssi_config_init(mod, io);
 
-	ret = rsnd_ssi_config_init(mod, io);
-	if (ret < 0)
-		return ret;
+	rsnd_ssi_register_setup(mod);
 
 	/* clear error status */
 	rsnd_ssi_status_clear(mod);
@@ -428,22 +432,14 @@ static int rsnd_ssi_start(struct rsnd_mod *mod,
 			  struct rsnd_dai_stream *io,
 			  struct rsnd_priv *priv)
 {
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	u32 cr;
-
-	cr  =	ssi->cr_own	|
-		ssi->cr_clk	|
-		ssi->cr_mode;
-
 	/*
 	 * EN will be set via SSIU :: SSI_CONTROL
 	 * if Multi channel mode
 	 */
-	if (!rsnd_ssi_multi_slaves(io))
-		cr |= EN;
+	if (rsnd_ssi_multi_slaves(io))
+		return 0;
 
-	rsnd_mod_write(mod, SSICR, cr);
-	rsnd_mod_write(mod, SSIWSR, ssi->wsr);
+	rsnd_mod_bset(mod, SSICR, EN, EN);
 
 	return 0;
 }
-- 
2.7.0
