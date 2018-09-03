From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssi: Fix issue in dma data
	address assignment" to the asoc tree
Date: Mon,  3 Sep 2018 14:45:56 +0100 (BST)
Message-ID: <20180903134556.7C5D911227AE@debutante.sirena.org.uk>
References: <874lf7f4lc.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E87932678BC
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:45:56 +0200 (CEST)
In-Reply-To: <874lf7f4lc.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: ssi: Fix issue in dma data address assignment

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

>From 0e289012b47a2de1f029a6b61c75998e2f159dd9 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 3 Sep 2018 07:07:07 +0000
Subject: [PATCH] ASoC: rsnd: ssi: Fix issue in dma data address assignment

Same SSI device may be used in different dai links,
by only having one dma struct in rsnd_ssi, after the first
instance's dma config be initilized, the following instances
can no longer configure dma, this causes issue, when their
dma data address are different from the first instance.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[Kuninori: tidyup for upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 1 +
 sound/soc/sh/rcar/ssi.c  | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 698b08155b06..20e6a2ebebed 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -431,6 +431,7 @@ struct rsnd_dai_stream {
 	char name[RSND_DAI_NAME_SIZE];
 	struct snd_pcm_substream *substream;
 	struct rsnd_mod *mod[RSND_MOD_MAX];
+	struct rsnd_mod *dma;
 	struct rsnd_dai *rdai;
 	struct device *dmac_dev; /* for IPMMU */
 	u32 parent_ssi_status;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 765ecc06c7c9..89cc433e2fc9 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -78,7 +78,6 @@
 
 struct rsnd_ssi {
 	struct rsnd_mod mod;
-	struct rsnd_mod *dma;
 
 	u32 flags;
 	u32 cr_own;
@@ -899,7 +898,6 @@ static int rsnd_ssi_dma_probe(struct rsnd_mod *mod,
 			      struct rsnd_dai_stream *io,
 			      struct rsnd_priv *priv)
 {
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	int ret;
 
 	/*
@@ -914,7 +912,7 @@ static int rsnd_ssi_dma_probe(struct rsnd_mod *mod,
 		return ret;
 
 	/* SSI probe might be called many times in MUX multi path */
-	ret = rsnd_dma_attach(io, mod, &ssi->dma);
+	ret = rsnd_dma_attach(io, mod, &io->dma);
 
 	return ret;
 }
-- 
2.19.0.rc1
