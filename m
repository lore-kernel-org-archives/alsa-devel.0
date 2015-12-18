From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove rsnd_get_slot_runtime()"
	to the asoc tree
Date: Fri, 18 Dec 2015 12:15:25 +0000
Message-ID: <E1a9twT-00064Z-GF@debutante>
References: <8760zxiy3q.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4065B2657E5
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:30 +0100 (CET)
In-Reply-To: <8760zxiy3q.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove rsnd_get_slot_runtime()

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

>From 5858a7d17e266945b9860768d0549aeb6a52d31f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:57:07 +0000
Subject: [PATCH] ASoC: rsnd: remove rsnd_get_slot_runtime()

Current Renesas sound driver is using rsnd_get_slot_runtime(), but
it is same as runtime->channels. This patch removes
rsnd_get_slot_runtime()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 19 ++++---------------
 sound/soc/sh/rcar/rsnd.h |  1 -
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index e59dc8a461bb..7f3a7edba096 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -196,21 +196,10 @@ int rsnd_get_slot_rdai(struct rsnd_dai *rdai)
 	return rdai->slots;
 }
 
-int rsnd_get_slot_runtime(struct rsnd_dai_stream *io)
-{
-	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	int chan = rsnd_get_slot_rdai(rdai);
-
-	if (runtime->channels < chan)
-		chan = runtime->channels;
-
-	return chan;
-}
-
 int rsnd_get_slot_extend(struct rsnd_dai_stream *io)
 {
-	int chan = rsnd_get_slot_runtime(io);
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	int chan = runtime->channels;
 
 	/* TDM Extend Mode needs 8ch */
 	if (chan == 6)
@@ -243,9 +232,9 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 u32 rsnd_get_adinr_chan(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-	u32 chan = rsnd_get_slot_rdai(rdai);
+	u32 chan = runtime->channels;
 
 	switch (chan) {
 	case 1:
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 4b677e074c7a..e9909a4ce754 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -294,7 +294,6 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 					 struct rsnd_dai_stream *io));
 
 int rsnd_get_slot_rdai(struct rsnd_dai *rdai);
-int rsnd_get_slot_runtime(struct rsnd_dai_stream *io);
 int rsnd_get_slot_extend(struct rsnd_dai_stream *io);
 
 /*
-- 
2.6.2
