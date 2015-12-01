From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssi enables non-stereo sound" to
	the asoc tree
Date: Tue, 01 Dec 2015 22:59:52 +0000
Message-ID: <E1a3tto-0006k6-Nl@debutante>
References: <87vb8jswen.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B4EB26641A
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:57 +0100 (CET)
In-Reply-To: <87vb8jswen.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: ssi enables non-stereo sound

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

>From 8ec85e7f7e9a2f9c36a92596db53c30b1ca45f17 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:53:27 +0000
Subject: [PATCH] ASoC: rsnd: ssi enables non-stereo sound

Current SSI is assuming that the sound is always stereo. But, SSI needs
to calculate its frequency when master mode. Then This frequency depends
on each SSI's slots, and TDM mode (= TDM Extend Mode, TDM split Mode,
TDM Multichannel Mode).
This patch enables to use non-stereo sound.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 29 +++++++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h |  6 ++++++
 sound/soc/sh/rcar/ssi.c  |  5 +++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 81a6bdb6848c..f990b4cb7192 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -191,6 +191,34 @@ int rsnd_io_is_working(struct rsnd_dai_stream *io)
 	return !!io->substream;
 }
 
+int rsnd_get_slot_rdai(struct rsnd_dai *rdai)
+{
+	return rdai->slots;
+}
+
+int rsnd_get_slot_runtime(struct rsnd_dai_stream *io)
+{
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	int chan = rsnd_get_slot_rdai(rdai);
+
+	if (runtime->channels < chan)
+		chan = runtime->channels;
+
+	return chan;
+}
+
+int rsnd_get_slot_extend(struct rsnd_dai_stream *io)
+{
+	int chan = rsnd_get_slot_runtime(io);
+
+	/* TDM Extend Mode needs 8ch */
+	if (chan == 6)
+		chan = 8;
+
+	return chan;
+}
+
 /*
  *	ADINR function
  */
@@ -611,6 +639,7 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 
 		rdai->playback.rdai		= rdai;
 		rdai->capture.rdai		= rdai;
+		rdai->slots			= 2; /* default */
 
 #define mod_parse(name)							\
 node = rsnd_##name##_of_node(priv);					\
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index bb2c29cdc892..38fd212ffe5a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -285,6 +285,10 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 			void (*callback)(struct rsnd_mod *mod,
 					 struct rsnd_dai_stream *io));
 
+int rsnd_get_slot_rdai(struct rsnd_dai *rdai);
+int rsnd_get_slot_runtime(struct rsnd_dai_stream *io);
+int rsnd_get_slot_extend(struct rsnd_dai_stream *io);
+
 /*
  *	R-Car sound DAI
  */
@@ -321,6 +325,8 @@ struct rsnd_dai {
 	struct rsnd_dai_stream capture;
 	struct rsnd_priv *priv;
 
+	int slots;
+
 	unsigned int clk_master:1;
 	unsigned int bit_clk_inv:1;
 	unsigned int frm_clk_inv:1;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index d97f365f1b41..44e914132b02 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -177,6 +177,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_ssi *ssi,
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_mod *mod = rsnd_mod_get(ssi);
 	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
+	int slots = rsnd_get_slot_extend(io);
 	int j, ret;
 	int ssi_clk_mul_table[] = {
 		1, 2, 4, 8, 16, 6, 12,
@@ -206,10 +207,10 @@ static int rsnd_ssi_master_clk_start(struct rsnd_ssi *ssi,
 
 		/*
 		 * this driver is assuming that
-		 * system word is 64fs (= 2 x 32bit)
+		 * system word is 32bit x slots
 		 * see rsnd_ssi_init()
 		 */
-		main_rate = rate * 32 * 2 * ssi_clk_mul_table[j];
+		main_rate = rate * 32 * slots * ssi_clk_mul_table[j];
 
 		ret = rsnd_adg_ssi_clk_try_start(mod, main_rate);
 		if (0 == ret) {
-- 
2.6.2
