From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Don't stop HW even if a large
	number of errors occur" to the asoc tree
Date: Tue, 27 Oct 2015 13:48:30 +0900
Message-ID: <E1ZqwBS-0004pa-9t@finisterre>
References: <87mvv63u29.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F6272651A5
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:48:39 +0100 (CET)
In-Reply-To: <87mvv63u29.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: Don't stop HW even if a large number of errors occur

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

>From d4a5d70fc97f6edda5945802a5a026571d2f40fa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:41:36 +0000
Subject: [PATCH] ASoC: rsnd: Don't stop HW even if a large number of errors
 occur

Current SSI/SRC restarts HW if under/over flow happened to avoid L/R
invert issue. But it will stop HW if too many error happen.
But if it stops on HW, other side under/over flow happen. OTHA, it will
be forever loop interrupt if something strange error happen on
HW/driver without escape route of large number error.

To avoid this issue, it indicates error message if large number error
occur, and disables error interrupt.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 17 ++++++++++-------
 sound/soc/sh/rcar/ssi.c | 15 +++++++++------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 3f6993f..0d96ce5 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -690,6 +690,8 @@ static void __rsnd_src_interrupt_gen2(struct rsnd_mod *mod,
 				      struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_src *src = rsnd_mod_to_src(mod);
+	struct device *dev = rsnd_priv_to_dev(priv);
 
 	spin_lock(&priv->lock);
 
@@ -698,18 +700,19 @@ static void __rsnd_src_interrupt_gen2(struct rsnd_mod *mod,
 		goto rsnd_src_interrupt_gen2_out;
 
 	if (rsnd_src_error_record_gen2(mod)) {
-		struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-		struct rsnd_src *src = rsnd_mod_to_src(mod);
-		struct device *dev = rsnd_priv_to_dev(priv);
 
 		dev_dbg(dev, "%s[%d] restart\n",
 			rsnd_mod_name(mod), rsnd_mod_id(mod));
 
 		_rsnd_src_stop_gen2(mod);
-		if (src->err < 1024)
-			_rsnd_src_start_gen2(mod, io);
-		else
-			dev_warn(dev, "no more SRC restart\n");
+		_rsnd_src_start_gen2(mod, io);
+	}
+
+	if (src->err > 1024) {
+		rsnd_src_irq_disable_gen2(mod);
+
+		dev_warn(dev, "no more %s[%d] restart\n",
+			 rsnd_mod_name(mod), rsnd_mod_id(mod));
 	}
 
 rsnd_src_interrupt_gen2_out:
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index c7d9434..86e51ce 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -456,6 +456,7 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	int is_dma = rsnd_ssi_is_dma_mode(mod);
 	u32 status;
 	bool elapsed = false;
@@ -489,8 +490,6 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 
 	/* DMA only */
 	if (is_dma && (status & (UIRQ | OIRQ))) {
-		struct device *dev = rsnd_priv_to_dev(priv);
-
 		/*
 		 * restart SSI
 		 */
@@ -498,14 +497,18 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 			rsnd_mod_name(mod), rsnd_mod_id(mod));
 
 		rsnd_ssi_stop(mod, io, priv);
-		if (ssi->err < 1024)
-			rsnd_ssi_start(mod, io, priv);
-		else
-			dev_warn(dev, "no more SSI restart\n");
+		rsnd_ssi_start(mod, io, priv);
 	}
 
 	rsnd_ssi_record_error(ssi, status);
 
+	if (ssi->err > 1024) {
+		rsnd_ssi_irq_disable(mod);
+
+		dev_warn(dev, "no more %s[%d] restart\n",
+			 rsnd_mod_name(mod), rsnd_mod_id(mod));
+	}
+
 rsnd_ssi_interrupt_out:
 	spin_unlock(&priv->lock);
 
-- 
2.6.1
