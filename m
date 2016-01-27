From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add .irq callback" to the asoc
	tree
Date: Wed, 27 Jan 2016 18:37:33 +0000
Message-ID: <E1aOUyD-000876-1t@debutante>
References: <87powpkklh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DBEF7265353
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 19:37:38 +0100 (CET)
In-Reply-To: <87powpkklh.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add .irq callback

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

>From b5b442abd9d5cfe4f04a1e83be9900c87444bd66 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Jan 2016 04:56:57 +0000
Subject: [PATCH] ASoC: rsnd: add .irq callback

Current rsnd driver has .init/.start/.stop/.quit callbacks,
and it needs many IPs (SRC/CTU/MUX/DVC/CMD/SSIU/SSI).
Because of these relationship, it might get unnecessary
error IRQ when start/stop.
This patch adds new .irq callback and control IRQ enable/disable
timing to avoid it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c |  9 ++++++++-
 sound/soc/sh/rcar/rsnd.h |  6 ++++++
 sound/soc/sh/rcar/src.c  | 16 ++++++++--------
 sound/soc/sh/rcar/ssi.c  | 36 +++++++++++++-----------------------
 4 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1fcefab03ad6..704ba7ae9eaf 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -568,9 +568,16 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		ret = rsnd_dai_call(start, io, priv);
 		if (ret < 0)
 			goto dai_trigger_end;
+
+		ret = rsnd_dai_call(irq, io, priv, 1);
+		if (ret < 0)
+			goto dai_trigger_end;
+
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		ret = rsnd_dai_call(stop, io, priv);
+		ret = rsnd_dai_call(irq, io, priv, 0);
+
+		ret |= rsnd_dai_call(stop, io, priv);
 
 		ret |= rsnd_dai_call(quit, io, priv);
 
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 4974db6679c3..bbaf89b6de8a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -249,6 +249,9 @@ struct rsnd_mod_ops {
 	int (*stop)(struct rsnd_mod *mod,
 		    struct rsnd_dai_stream *io,
 		    struct rsnd_priv *priv);
+	int (*irq)(struct rsnd_mod *mod,
+		   struct rsnd_dai_stream *io,
+		   struct rsnd_priv *priv, int enable);
 	int (*pcm_new)(struct rsnd_mod *mod,
 		       struct rsnd_dai_stream *io,
 		       struct snd_soc_pcm_runtime *rtd);
@@ -293,6 +296,7 @@ struct rsnd_mod {
 #define __rsnd_mod_shift_stop		8
 #define __rsnd_mod_shift_probe		28 /* always called */
 #define __rsnd_mod_shift_remove		28 /* always called */
+#define __rsnd_mod_shift_irq		28 /* always called */
 #define __rsnd_mod_shift_pcm_new	28 /* always called */
 #define __rsnd_mod_shift_fallback	28 /* always called */
 #define __rsnd_mod_shift_hw_params	28 /* always called */
@@ -303,6 +307,7 @@ struct rsnd_mod {
 #define __rsnd_mod_add_quit		-1
 #define __rsnd_mod_add_start		 1
 #define __rsnd_mod_add_stop		-1
+#define __rsnd_mod_add_irq		0
 #define __rsnd_mod_add_pcm_new		0
 #define __rsnd_mod_add_fallback		0
 #define __rsnd_mod_add_hw_params	0
@@ -313,6 +318,7 @@ struct rsnd_mod {
 #define __rsnd_mod_call_quit		1
 #define __rsnd_mod_call_start		0
 #define __rsnd_mod_call_stop		1
+#define __rsnd_mod_call_irq		0
 #define __rsnd_mod_call_pcm_new		0
 #define __rsnd_mod_call_fallback	0
 #define __rsnd_mod_call_hw_params	0
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index cccca154e4c3..ab5f13155055 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -271,9 +271,10 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 		rsnd_adg_set_convert_timing_gen2(mod, io);
 }
 
-#define rsnd_src_irq_enable(mod)  rsnd_src_irq_ctrol(mod, 1)
-#define rsnd_src_irq_disable(mod) rsnd_src_irq_ctrol(mod, 0)
-static void rsnd_src_irq_ctrol(struct rsnd_mod *mod, int enable)
+static int rsnd_src_irq(struct rsnd_mod *mod,
+			struct rsnd_dai_stream *io,
+			struct rsnd_priv *priv,
+			int enable)
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	u32 sys_int_val, int_val, sys_int_mask;
@@ -305,6 +306,8 @@ static void rsnd_src_irq_ctrol(struct rsnd_mod *mod, int enable)
 	rsnd_mod_write(mod, SRC_INT_ENABLE0, int_val);
 	rsnd_mod_bset(mod, SCU_SYS_INT_EN0, sys_int_mask, sys_int_val);
 	rsnd_mod_bset(mod, SCU_SYS_INT_EN1, sys_int_mask, sys_int_val);
+
+	return 0;
 }
 
 static void rsnd_src_status_clear(struct rsnd_mod *mod)
@@ -381,8 +384,6 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 
 	rsnd_src_status_clear(mod);
 
-	rsnd_src_irq_enable(mod);
-
 	/* reset sync convert_rate */
 	src->sync.val = 0;
 
@@ -395,8 +396,6 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 
-	rsnd_src_irq_disable(mod);
-
 	rsnd_src_halt(mod);
 
 	rsnd_mod_power_off(mod);
@@ -455,7 +454,7 @@ static int rsnd_src_probe_(struct rsnd_mod *mod,
 		/*
 		 * IRQ is not supported on non-DT
 		 * see
-		 *	rsnd_src_irq_enable()
+		 *	rsnd_src_irq()
 		 */
 		ret = devm_request_irq(dev, irq,
 				       rsnd_src_interrupt,
@@ -518,6 +517,7 @@ static struct rsnd_mod_ops rsnd_src_ops = {
 	.quit	= rsnd_src_quit,
 	.start	= rsnd_src_start,
 	.stop	= rsnd_src_stop,
+	.irq	= rsnd_src_irq,
 	.hw_params = rsnd_src_hw_params,
 	.pcm_new = rsnd_src_pcm_new,
 };
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 5870434bbc58..803e9ae65915 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -142,30 +142,24 @@ static void rsnd_ssi_status_check(struct rsnd_mod *mod,
 	dev_warn(dev, "status check failed\n");
 }
 
-static int rsnd_ssi_irq_enable(struct rsnd_mod *ssi_mod)
+static int rsnd_ssi_irq(struct rsnd_mod *mod,
+			struct rsnd_dai_stream *io,
+			struct rsnd_priv *priv,
+			int enable)
 {
-	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	u32 val = 0;
 
 	if (rsnd_is_gen1(priv))
 		return 0;
 
-	/* enable SSI interrupt if Gen2 */
-	rsnd_mod_write(ssi_mod, SSI_INT_ENABLE,
-		       rsnd_ssi_is_dma_mode(ssi_mod) ?
-		       0x0e000000 : 0x0f000000);
-
-	return 0;
-}
-
-static int rsnd_ssi_irq_disable(struct rsnd_mod *ssi_mod)
-{
-	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
-
-	if (rsnd_is_gen1(priv))
+	if (ssi->usrcnt != 1)
 		return 0;
 
-	/* disable SSI interrupt if Gen2 */
-	rsnd_mod_write(ssi_mod, SSI_INT_ENABLE, 0x00000000);
+	if (enable)
+		val = rsnd_ssi_is_dma_mode(mod) ? 0x0e000000 : 0x0f000000;
+
+	rsnd_mod_write(mod, SSI_INT_ENABLE, val);
 
 	return 0;
 }
@@ -387,8 +381,6 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 	/* clear error status */
 	rsnd_ssi_status_clear(mod);
 
-	rsnd_ssi_irq_enable(mod);
-
 	return 0;
 }
 
@@ -405,12 +397,9 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 		return -EIO;
 	}
 
-	if (!rsnd_ssi_is_parent(mod, io)) {
+	if (!rsnd_ssi_is_parent(mod, io))
 		ssi->cr_own	= 0;
 
-		rsnd_ssi_irq_disable(mod);
-	}
-
 	rsnd_ssi_master_clk_stop(ssi, io);
 
 	rsnd_mod_power_off(mod);
@@ -627,6 +616,7 @@ static struct rsnd_mod_ops rsnd_ssi_pio_ops = {
 	.quit	= rsnd_ssi_quit,
 	.start	= rsnd_ssi_start,
 	.stop	= rsnd_ssi_stop,
+	.irq	= rsnd_ssi_irq,
 	.hw_params = rsnd_ssi_hw_params,
 };
 
-- 
2.7.0.rc3
