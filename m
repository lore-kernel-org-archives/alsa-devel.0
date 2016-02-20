From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Parent SSI attach is not needed
	if not clock master" to the asoc tree
Date: Sun, 21 Feb 2016 02:16:01 +0900
Message-ID: <E1aXB8T-0008PU-5e@finisterre>
References: <87h9h6tozy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F165E265139
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:04 +0100 (CET)
In-Reply-To: <87h9h6tozy.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: Parent SSI attach is not needed if not clock master

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

>From 098bd8911a5eacc3b70fdc09fa4084657511c584 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:17:52 +0000
Subject: [PATCH] ASoC: rsnd: Parent SSI attach is not needed if not clock
 master

Parent SSI is needed if it is PIN sharing and clock master,
otherwise, not needed. But, whether clockk master is judged on
.set_fmt, thus, it can't call rsnd_ssi_parent_attach() on .probe.

Now, .pcm_new will be called after .set_fmt, so this patch reuses it
at this point.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 1205872..b5c6f0c 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -545,12 +545,17 @@ static irqreturn_t rsnd_ssi_interrupt(int irq, void *data)
  *		SSI PIO
  */
 static void rsnd_ssi_parent_attach(struct rsnd_mod *mod,
-				   struct rsnd_dai_stream *io,
-				   struct rsnd_priv *priv)
+				   struct rsnd_dai_stream *io)
 {
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+
 	if (!__rsnd_ssi_is_pin_sharing(mod))
 		return;
 
+	if (!rsnd_rdai_is_clk_master(rdai))
+		return;
+
 	switch (rsnd_mod_id(mod)) {
 	case 1:
 	case 2:
@@ -565,6 +570,20 @@ static void rsnd_ssi_parent_attach(struct rsnd_mod *mod,
 	}
 }
 
+static int rsnd_ssi_pcm_new(struct rsnd_mod *mod,
+			    struct rsnd_dai_stream *io,
+			    struct snd_soc_pcm_runtime *rtd)
+{
+	/*
+	 * rsnd_rdai_is_clk_master() will be enabled after set_fmt,
+	 * and, pcm_new will be called after it.
+	 * This function reuse pcm_new at this point.
+	 */
+	rsnd_ssi_parent_attach(mod, io);
+
+	return 0;
+}
+
 static int rsnd_ssi_common_probe(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io,
 				 struct rsnd_priv *priv)
@@ -580,7 +599,10 @@ static int rsnd_ssi_common_probe(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
-	rsnd_ssi_parent_attach(mod, io, priv);
+	/*
+	 * It can't judge ssi parent at this point
+	 * see rsnd_ssi_pcm_new()
+	 */
 
 	ret = rsnd_ssiu_attach(io, mod);
 	if (ret < 0)
@@ -602,6 +624,7 @@ static struct rsnd_mod_ops rsnd_ssi_pio_ops = {
 	.start	= rsnd_ssi_start,
 	.stop	= rsnd_ssi_stop,
 	.irq	= rsnd_ssi_irq,
+	.pcm_new = rsnd_ssi_pcm_new,
 	.hw_params = rsnd_ssi_hw_params,
 };
 
@@ -691,6 +714,7 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
 	.start	= rsnd_ssi_start,
 	.stop	= rsnd_ssi_stop,
 	.irq	= rsnd_ssi_irq,
+	.pcm_new = rsnd_ssi_pcm_new,
 	.fallback = rsnd_ssi_fallback,
 	.hw_params = rsnd_ssi_hw_params,
 };
-- 
2.7.0
