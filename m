From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_set_slot() /
	rsnd_get_slot_num()" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:23 +0000
Message-ID: <E1a9twR-00063d-KI@debutante>
References: <8737v1iy2n.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 308152658CE
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:30 +0100 (CET)
In-Reply-To: <8737v1iy2n.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add rsnd_set_slot() / rsnd_get_slot_num()

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

>From 750fd445ac53f1623cfcbf710d2bfc7aa1b7086d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:57:47 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_set_slot() / rsnd_get_slot_num()

TDM will use 6 or 8 slots on 1 SSI, and Multi channel will use
6 or 8 slots on few SSI (each SSI uses 2 slots).
Thus, this adds new slot control functions which can be prepare
for Multi channel support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 20 +++++++++++++++++---
 sound/soc/sh/rcar/rsnd.h |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 76af41633f9f..528041eff704 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -191,6 +191,13 @@ int rsnd_io_is_working(struct rsnd_dai_stream *io)
 	return !!io->substream;
 }
 
+void rsnd_set_slot(struct rsnd_dai *rdai,
+		   int slots, int num)
+{
+	rdai->slots	= slots;
+	rdai->slots_num	= num;
+}
+
 int rsnd_get_slot(struct rsnd_dai_stream *io)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
@@ -198,10 +205,17 @@ int rsnd_get_slot(struct rsnd_dai_stream *io)
 	return rdai->slots;
 }
 
+int rsnd_get_slot_num(struct rsnd_dai_stream *io)
+{
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+
+	return rdai->slots_num;
+}
+
 int rsnd_get_slot_width(struct rsnd_dai_stream *io)
 {
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	int chan = runtime->channels;
+	int chan = runtime->channels / rsnd_get_slot_num(io);
 
 	/* TDM Extend Mode needs 8ch */
 	if (chan == 6)
@@ -579,7 +593,7 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	switch (slots) {
 	case 6:
 		/* TDM Extend Mode */
-		rdai->slots = slots;
+		rsnd_set_slot(rdai, slots, 1);
 		break;
 	default:
 		dev_err(dev, "unsupported TDM slots (%d)\n", slots);
@@ -660,7 +674,7 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 
 		rdai->playback.rdai		= rdai;
 		rdai->capture.rdai		= rdai;
-		rdai->slots			= 2; /* default */
+		rsnd_set_slot(rdai, 2, 1); /* default */
 
 #define mod_parse(name)							\
 node = rsnd_##name##_of_node(priv);					\
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 804f2f5622e0..c9aef234d002 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -293,8 +293,11 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 			void (*callback)(struct rsnd_mod *mod,
 					 struct rsnd_dai_stream *io));
 
+void rsnd_set_slot(struct rsnd_dai *rdai,
+		   int slots, int slots_total);
 int rsnd_get_slot(struct rsnd_dai_stream *io);
 int rsnd_get_slot_width(struct rsnd_dai_stream *io);
+int rsnd_get_slot_num(struct rsnd_dai_stream *io);
 
 /*
  *	R-Car sound DAI
@@ -334,6 +337,7 @@ struct rsnd_dai {
 	struct rsnd_priv *priv;
 
 	int slots;
+	int slots_num;
 
 	unsigned int clk_master:1;
 	unsigned int bit_clk_inv:1;
-- 
2.6.2
