From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't auto-recover when
	under/over run error" to the asoc tree
Date: Wed, 27 Jan 2016 18:37:38 +0000
Message-ID: <E1aOUyI-00087b-7O@debutante>
References: <87r3h5kkmm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 18E4D265497
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 19:37:43 +0100 (CET)
In-Reply-To: <87r3h5kkmm.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: don't auto-recover when under/over run error

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

>From 6a25c8da00284f5612b404368bd07b69efd84aa2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Jan 2016 04:56:14 +0000
Subject: [PATCH] ASoC: rsnd: don't auto-recover when under/over run error

Renesas R-Car sound needs recovery (= restart) when under/over run
error occurred, and current driver tries it on under/over run error
handler automatically. But this recovery should be handled by userland,
not kernel. This patch stops XRUN when under/over run error occur, and
will leave the recovery of HW in userland.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 39 ++++----------------
 sound/soc/sh/rcar/ssi.c | 97 +++++++++++--------------------------------------
 2 files changed, 29 insertions(+), 107 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 7749615bd404..cccca154e4c3 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -25,7 +25,6 @@ struct rsnd_src {
 	struct rsnd_kctrl_cfg_s sen;  /* sync convert enable */
 	struct rsnd_kctrl_cfg_s sync; /* sync convert */
 	u32 convert_rate; /* sampling rate convert */
-	int err;
 	int irq;
 };
 
@@ -316,7 +315,7 @@ static void rsnd_src_status_clear(struct rsnd_mod *mod)
 	rsnd_mod_bset(mod, SCU_SYS_STATUS1, val, val);
 }
 
-static bool rsnd_src_record_error(struct rsnd_mod *mod)
+static bool rsnd_src_error_occurred(struct rsnd_mod *mod)
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	u32 val0, val1;
@@ -333,12 +332,8 @@ static bool rsnd_src_record_error(struct rsnd_mod *mod)
 		val0 = val0 & 0xffff;
 
 	if ((rsnd_mod_read(mod, SCU_SYS_STATUS0) & val0) ||
-	    (rsnd_mod_read(mod, SCU_SYS_STATUS1) & val1)) {
-		struct rsnd_src *src = rsnd_mod_to_src(mod);
-
-		src->err++;
+	    (rsnd_mod_read(mod, SCU_SYS_STATUS1) & val1))
 		ret = true;
-	}
 
 	return ret;
 }
@@ -388,8 +383,6 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 
 	rsnd_src_irq_enable(mod);
 
-	src->err = 0;
-
 	/* reset sync convert_rate */
 	src->sync.val = 0;
 
@@ -401,7 +394,6 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 			 struct rsnd_priv *priv)
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
-	struct device *dev = rsnd_priv_to_dev(priv);
 
 	rsnd_src_irq_disable(mod);
 
@@ -409,10 +401,6 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 
 	rsnd_mod_power_off(mod);
 
-	if (src->err)
-		dev_warn(dev, "%s[%d] under/over flow err = %d\n",
-			 rsnd_mod_name(mod), rsnd_mod_id(mod), src->err);
-
 	src->convert_rate = 0;
 
 	/* reset sync convert_rate */
@@ -425,8 +413,7 @@ static void __rsnd_src_interrupt(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct rsnd_src *src = rsnd_mod_to_src(mod);
-	struct device *dev = rsnd_priv_to_dev(priv);
+	bool stop = false;
 
 	spin_lock(&priv->lock);
 
@@ -434,26 +421,16 @@ static void __rsnd_src_interrupt(struct rsnd_mod *mod,
 	if (!rsnd_io_is_working(io))
 		goto rsnd_src_interrupt_out;
 
-	if (rsnd_src_record_error(mod)) {
-
-		dev_dbg(dev, "%s[%d] restart\n",
-			rsnd_mod_name(mod), rsnd_mod_id(mod));
-
-		rsnd_src_stop(mod, io, priv);
-		rsnd_src_start(mod, io, priv);
-	}
-
-	if (src->err > 1024) {
-		rsnd_src_irq_disable(mod);
-
-		dev_warn(dev, "no more %s[%d] restart\n",
-			 rsnd_mod_name(mod), rsnd_mod_id(mod));
-	}
+	if (rsnd_src_error_occurred(mod))
+		stop = true;
 
 	rsnd_src_status_clear(mod);
 rsnd_src_interrupt_out:
 
 	spin_unlock(&priv->lock);
+
+	if (stop)
+		snd_pcm_stop_xrun(io->substream);
 }
 
 static irqreturn_t rsnd_src_interrupt(int irq, void *data)
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 90674137aa90..5870434bbc58 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -74,7 +74,6 @@ struct rsnd_ssi {
 	u32 wsr;
 	int chan;
 	int rate;
-	int err;
 	int irq;
 	unsigned int usrcnt;
 };
@@ -385,8 +384,6 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	ssi->err	= -1; /* ignore 1st error */
-
 	/* clear error status */
 	rsnd_ssi_status_clear(mod);
 
@@ -409,13 +406,7 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 	}
 
 	if (!rsnd_ssi_is_parent(mod, io)) {
-		if (ssi->err > 0)
-			dev_warn(dev, "%s[%d] under/over flow err = %d\n",
-				 rsnd_mod_name(mod), rsnd_mod_id(mod),
-				 ssi->err);
-
 		ssi->cr_own	= 0;
-		ssi->err	= 0;
 
 		rsnd_ssi_irq_disable(mod);
 	}
@@ -455,21 +446,9 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
 	return 0;
 }
 
-static u32 rsnd_ssi_record_error(struct rsnd_ssi *ssi)
-{
-	struct rsnd_mod *mod = rsnd_mod_get(ssi);
-	u32 status = rsnd_ssi_status_get(mod);
-
-	/* under/over flow error */
-	if (status & (UIRQ | OIRQ))
-		ssi->err++;
-
-	return status;
-}
-
-static int __rsnd_ssi_start(struct rsnd_mod *mod,
-			    struct rsnd_dai_stream *io,
-			    struct rsnd_priv *priv)
+static int rsnd_ssi_start(struct rsnd_mod *mod,
+			  struct rsnd_dai_stream *io,
+			  struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	u32 cr;
@@ -491,25 +470,21 @@ static int __rsnd_ssi_start(struct rsnd_mod *mod,
 	return 0;
 }
 
-static int rsnd_ssi_start(struct rsnd_mod *mod,
-			  struct rsnd_dai_stream *io,
-			  struct rsnd_priv *priv)
+static int rsnd_ssi_stop(struct rsnd_mod *mod,
+			 struct rsnd_dai_stream *io,
+			 struct rsnd_priv *priv)
 {
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	u32 cr;
+
 	/*
-	 * no limit to start
+	 * don't stop if not last user
 	 * see also
-	 *	rsnd_ssi_stop
+	 *	rsnd_ssi_start
 	 *	rsnd_ssi_interrupt
 	 */
-	return __rsnd_ssi_start(mod, io, priv);
-}
-
-static int __rsnd_ssi_stop(struct rsnd_mod *mod,
-			   struct rsnd_dai_stream *io,
-			   struct rsnd_priv *priv)
-{
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	u32 cr;
+	if (ssi->usrcnt > 1)
+		return 0;
 
 	/*
 	 * disable all IRQ,
@@ -531,33 +506,14 @@ static int __rsnd_ssi_stop(struct rsnd_mod *mod,
 	return 0;
 }
 
-static int rsnd_ssi_stop(struct rsnd_mod *mod,
-			 struct rsnd_dai_stream *io,
-			 struct rsnd_priv *priv)
-{
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-
-	/*
-	 * don't stop if not last user
-	 * see also
-	 *	rsnd_ssi_start
-	 *	rsnd_ssi_interrupt
-	 */
-	if (ssi->usrcnt > 1)
-		return 0;
-
-	return __rsnd_ssi_stop(mod, io, priv);
-}
-
 static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io)
 {
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct device *dev = rsnd_priv_to_dev(priv);
 	int is_dma = rsnd_ssi_is_dma_mode(mod);
 	u32 status;
 	bool elapsed = false;
+	bool stop = false;
 
 	spin_lock(&priv->lock);
 
@@ -565,7 +521,7 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 	if (!rsnd_io_is_working(io))
 		goto rsnd_ssi_interrupt_out;
 
-	status = rsnd_ssi_record_error(ssi);
+	status = rsnd_ssi_status_get(mod);
 
 	/* PIO only */
 	if (!is_dma && (status & DIRQ)) {
@@ -587,23 +543,8 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 	}
 
 	/* DMA only */
-	if (is_dma && (status & (UIRQ | OIRQ))) {
-		/*
-		 * restart SSI
-		 */
-		dev_dbg(dev, "%s[%d] restart\n",
-			rsnd_mod_name(mod), rsnd_mod_id(mod));
-
-		__rsnd_ssi_stop(mod, io, priv);
-		__rsnd_ssi_start(mod, io, priv);
-	}
-
-	if (ssi->err > 1024) {
-		rsnd_ssi_irq_disable(mod);
-
-		dev_warn(dev, "no more %s[%d] restart\n",
-			 rsnd_mod_name(mod), rsnd_mod_id(mod));
-	}
+	if (is_dma && (status & (UIRQ | OIRQ)))
+		stop = true;
 
 	rsnd_ssi_status_clear(mod);
 rsnd_ssi_interrupt_out:
@@ -611,6 +552,10 @@ rsnd_ssi_interrupt_out:
 
 	if (elapsed)
 		rsnd_dai_period_elapsed(io);
+
+	if (stop)
+		snd_pcm_stop_xrun(io->substream);
+
 }
 
 static irqreturn_t rsnd_ssi_interrupt(int irq, void *data)
-- 
2.7.0.rc3
