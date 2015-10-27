From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: move
	rsnd_src_ssi_irq_enable/disable() to ssi.c" to the asoc tree
Date: Tue, 27 Oct 2015 13:48:44 +0900
Message-ID: <E1ZqwBg-0004r1-RS@finisterre>
References: <87r3ki3u3t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98E352654F1
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:48:53 +0100 (CET)
In-Reply-To: <87r3ki3u3t.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: move rsnd_src_ssi_irq_enable/disable() to ssi.c

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

>From 3931a39c5edc57a0477bc2e9fcaf1fa0698bf168 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:40:41 +0000
Subject: [PATCH] ASoC: rsnd: move rsnd_src_ssi_irq_enable/disable() to ssi.c

Part of SSI IRQ enable/disable was controlled by SRU (on Gen1)
or CMD (on Gen2). Because of this reason SSI IRQ function was
implemented under src.c. but it is not understandable.
Let's move it to ssi.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h |  2 --
 sound/soc/sh/rcar/src.c  | 28 ----------------------------
 sound/soc/sh/rcar/ssi.c  | 32 ++++++++++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 996fa1e..d6365dc 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -576,8 +576,6 @@ int rsnd_src_ssiu_start(struct rsnd_mod *ssi_mod,
 			int use_busif);
 int rsnd_src_ssiu_stop(struct rsnd_mod *ssi_mod,
 		       struct rsnd_dai_stream *io);
-int rsnd_src_ssi_irq_enable(struct rsnd_mod *ssi_mod);
-int rsnd_src_ssi_irq_disable(struct rsnd_mod *ssi_mod);
 
 /*
  *	R-Car CTU
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index abfcc24..513094e 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -210,34 +210,6 @@ int rsnd_src_ssiu_stop(struct rsnd_mod *ssi_mod,
 	return 0;
 }
 
-int rsnd_src_ssi_irq_enable(struct rsnd_mod *ssi_mod)
-{
-	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
-
-	if (rsnd_is_gen1(priv))
-		return 0;
-
-	/* enable SSI interrupt if Gen2 */
-	rsnd_mod_write(ssi_mod, SSI_INT_ENABLE,
-		       rsnd_ssi_is_dma_mode(ssi_mod) ?
-		       0x0e000000 : 0x0f000000);
-
-	return 0;
-}
-
-int rsnd_src_ssi_irq_disable(struct rsnd_mod *ssi_mod)
-{
-	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
-
-	if (rsnd_is_gen1(priv))
-		return 0;
-
-	/* disable SSI interrupt if Gen2 */
-	rsnd_mod_write(ssi_mod, SSI_INT_ENABLE, 0x00000000);
-
-	return 0;
-}
-
 static u32 rsnd_src_convert_rate(struct rsnd_dai_stream *io,
 				 struct rsnd_src *src)
 {
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index d4803a8..c7d9434 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -124,6 +124,34 @@ static void rsnd_ssi_status_check(struct rsnd_mod *mod,
 	dev_warn(dev, "status check failed\n");
 }
 
+static int rsnd_ssi_irq_enable(struct rsnd_mod *ssi_mod)
+{
+	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
+
+	if (rsnd_is_gen1(priv))
+		return 0;
+
+	/* enable SSI interrupt if Gen2 */
+	rsnd_mod_write(ssi_mod, SSI_INT_ENABLE,
+		       rsnd_ssi_is_dma_mode(ssi_mod) ?
+		       0x0e000000 : 0x0f000000);
+
+	return 0;
+}
+
+static int rsnd_ssi_irq_disable(struct rsnd_mod *ssi_mod)
+{
+	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
+
+	if (rsnd_is_gen1(priv))
+		return 0;
+
+	/* disable SSI interrupt if Gen2 */
+	rsnd_mod_write(ssi_mod, SSI_INT_ENABLE, 0x00000000);
+
+	return 0;
+}
+
 static int rsnd_ssi_master_clk_start(struct rsnd_ssi *ssi,
 				     struct rsnd_dai_stream *io)
 {
@@ -401,7 +429,7 @@ static int rsnd_ssi_start(struct rsnd_mod *mod,
 
 	rsnd_ssi_hw_start(ssi, io);
 
-	rsnd_src_ssi_irq_enable(mod);
+	rsnd_ssi_irq_enable(mod);
 
 	return 0;
 }
@@ -412,7 +440,7 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 
-	rsnd_src_ssi_irq_disable(mod);
+	rsnd_ssi_irq_disable(mod);
 
 	rsnd_ssi_record_error(ssi, rsnd_mod_read(mod, SSISR));
 
-- 
2.6.1
