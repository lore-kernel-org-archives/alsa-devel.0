From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: PIO related function cleanup" to
	the asoc tree
Date: Mon, 11 Dec 2017 12:13:27 +0000
Message-ID: <E1eOMxb-0004aY-5i@debutante>
References: <87lgiauhav.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 06CCB2673D4
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 13:13:30 +0100 (CET)
In-Reply-To: <87lgiauhav.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: PIO related function cleanup

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

>From d8d9b9730cd62c9c7d24d5277542da98c09ea728 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Dec 2017 02:40:22 +0000
Subject: [PATCH] ASoC: rsnd: PIO related function cleanup

SSI had shared counting pointer position method between PIO/DMA mode
before. But now DMA mode is using DMAEngine feature to get it.
Thus, this counting pointer position method is needed for only PIO mode.
We don't need to share code anymore.
This patch names PIO related functions as rsnd_ssi_pio_xxx(), and
merged/cleanuped each feature.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 153 +++++++++++++++++++++++-------------------------
 1 file changed, 72 insertions(+), 81 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 5a70fdc3c680..97a9db892a8f 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -79,6 +79,7 @@ struct rsnd_ssi {
 	int irq;
 	unsigned int usrcnt;
 
+	/* for PIO */
 	int byte_pos;
 	int byte_per_period;
 	int next_period_byte;
@@ -413,61 +414,6 @@ static void rsnd_ssi_register_setup(struct rsnd_mod *mod)
 					ssi->cr_en);
 }
 
-static void rsnd_ssi_pointer_init(struct rsnd_mod *mod,
-				  struct rsnd_dai_stream *io)
-{
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-
-	ssi->byte_pos		= 0;
-	ssi->byte_per_period	= runtime->period_size *
-				  runtime->channels *
-				  samples_to_bytes(runtime, 1);
-	ssi->next_period_byte	= ssi->byte_per_period;
-}
-
-static int rsnd_ssi_pointer_offset(struct rsnd_mod *mod,
-				   struct rsnd_dai_stream *io,
-				   int additional)
-{
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	int pos = ssi->byte_pos + additional;
-
-	pos %= (runtime->periods * ssi->byte_per_period);
-
-	return pos;
-}
-
-static bool rsnd_ssi_pointer_update(struct rsnd_mod *mod,
-				    struct rsnd_dai_stream *io,
-				    int byte)
-{
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	bool ret = false;
-	int byte_pos;
-
-	byte_pos = ssi->byte_pos + byte;
-
-	if (byte_pos >= ssi->next_period_byte) {
-		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-		int period_pos = byte_pos / ssi->byte_per_period;
-
-		ssi->next_period_byte = (period_pos + 1) * ssi->byte_per_period;
-
-		if (period_pos >= runtime->periods) {
-			byte_pos = 0;
-			ssi->next_period_byte = ssi->byte_per_period;
-		}
-
-		ret = true;
-	}
-
-	WRITE_ONCE(ssi->byte_pos, byte_pos);
-
-	return ret;
-}
-
 /*
  *	SSI mod common functions
  */
@@ -481,8 +427,6 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 	if (!rsnd_ssi_is_run_mods(mod, io))
 		return 0;
 
-	rsnd_ssi_pointer_init(mod, io);
-
 	ssi->usrcnt++;
 
 	rsnd_mod_power_on(mod);
@@ -653,6 +597,8 @@ static int rsnd_ssi_irq(struct rsnd_mod *mod,
 	return 0;
 }
 
+static bool rsnd_ssi_pio_interrupt(struct rsnd_mod *mod,
+				   struct rsnd_dai_stream *io);
 static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io)
 {
@@ -671,27 +617,8 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 	status = rsnd_ssi_status_get(mod);
 
 	/* PIO only */
-	if (!is_dma && (status & DIRQ)) {
-		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-		u32 *buf = (u32 *)(runtime->dma_area +
-				   rsnd_ssi_pointer_offset(mod, io, 0));
-		int shift = 0;
-
-		if (snd_pcm_format_width(runtime->format) == 24)
-			shift = 8;
-
-		/*
-		 * 8/16/32 data can be assesse to TDR/RDR register
-		 * directly as 32bit data
-		 * see rsnd_ssi_init()
-		 */
-		if (rsnd_io_is_play(io))
-			rsnd_mod_write(mod, SSITDR, (*buf) << shift);
-		else
-			*buf = (rsnd_mod_read(mod, SSIRDR) >> shift);
-
-		elapsed = rsnd_ssi_pointer_update(mod, io, sizeof(*buf));
-	}
+	if (!is_dma && (status & DIRQ))
+		elapsed = rsnd_ssi_pio_interrupt(mod, io);
 
 	/* DMA only */
 	if (is_dma && (status & (UIRQ | OIRQ)))
@@ -829,7 +756,71 @@ static int rsnd_ssi_common_remove(struct rsnd_mod *mod,
 	return 0;
 }
 
-static int rsnd_ssi_pointer(struct rsnd_mod *mod,
+/*
+ *	SSI PIO functions
+ */
+static bool rsnd_ssi_pio_interrupt(struct rsnd_mod *mod,
+				   struct rsnd_dai_stream *io)
+{
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	u32 *buf = (u32 *)(runtime->dma_area + ssi->byte_pos);
+	int shift = 0;
+	int byte_pos;
+	bool elapsed = false;
+
+	if (snd_pcm_format_width(runtime->format) == 24)
+		shift = 8;
+
+	/*
+	 * 8/16/32 data can be assesse to TDR/RDR register
+	 * directly as 32bit data
+	 * see rsnd_ssi_init()
+	 */
+	if (rsnd_io_is_play(io))
+		rsnd_mod_write(mod, SSITDR, (*buf) << shift);
+	else
+		*buf = (rsnd_mod_read(mod, SSIRDR) >> shift);
+
+	byte_pos = ssi->byte_pos + sizeof(*buf);
+
+	if (byte_pos >= ssi->next_period_byte) {
+		int period_pos = byte_pos / ssi->byte_per_period;
+
+		if (period_pos >= runtime->periods) {
+			byte_pos = 0;
+			period_pos = 0;
+		}
+
+		ssi->next_period_byte = (period_pos + 1) * ssi->byte_per_period;
+
+		elapsed = true;
+	}
+
+	WRITE_ONCE(ssi->byte_pos, byte_pos);
+
+	return elapsed;
+}
+
+static int rsnd_ssi_pio_init(struct rsnd_mod *mod,
+			     struct rsnd_dai_stream *io,
+			     struct rsnd_priv *priv)
+{
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+
+	if (!rsnd_ssi_is_parent(mod, io)) {
+		ssi->byte_pos		= 0;
+		ssi->byte_per_period	= runtime->period_size *
+					  runtime->channels *
+					  samples_to_bytes(runtime, 1);
+		ssi->next_period_byte	= ssi->byte_per_period;
+	}
+
+	return rsnd_ssi_init(mod, io, priv);
+}
+
+static int rsnd_ssi_pio_pointer(struct rsnd_mod *mod,
 			    struct rsnd_dai_stream *io,
 			    snd_pcm_uframes_t *pointer)
 {
@@ -845,12 +836,12 @@ static struct rsnd_mod_ops rsnd_ssi_pio_ops = {
 	.name	= SSI_NAME,
 	.probe	= rsnd_ssi_common_probe,
 	.remove	= rsnd_ssi_common_remove,
-	.init	= rsnd_ssi_init,
+	.init	= rsnd_ssi_pio_init,
 	.quit	= rsnd_ssi_quit,
 	.start	= rsnd_ssi_start,
 	.stop	= rsnd_ssi_stop,
 	.irq	= rsnd_ssi_irq,
-	.pointer= rsnd_ssi_pointer,
+	.pointer = rsnd_ssi_pio_pointer,
 	.pcm_new = rsnd_ssi_pcm_new,
 	.hw_params = rsnd_ssi_hw_params,
 };
-- 
2.15.1
