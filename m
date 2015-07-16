From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup rsnd_dma_ops definition
	place" to the asoc tree
Date: Thu, 16 Jul 2015 22:29:53 +0100
Message-ID: <E1ZFqj3-0004hr-V9@finisterre>
References: <87egk9vqqo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4E2F2666AC
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:29:58 +0200 (CEST)
In-Reply-To: <87egk9vqqo.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup rsnd_dma_ops definition place

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

>From 98d358af07aa6fc4cd6cdfd3256ab792eb3675cd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:15:27 +0000
Subject: [PATCH] ASoC: rsnd: tidyup rsnd_dma_ops definition place

rsnd_dma_ops is used only from dma.c, rsnd.h doesn't need it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c  | 8 ++++++++
 sound/soc/sh/rcar/rsnd.h | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index d306e29..9431061 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -27,6 +27,14 @@ struct rsnd_dma_ctrl {
 	int dmapp_num;
 };
 
+struct rsnd_dma_ops {
+	void (*start)(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
+	void (*stop)(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
+	int (*init)(struct rsnd_dai_stream *io, struct rsnd_dma *dma, int id,
+		    struct rsnd_mod *mod_from, struct rsnd_mod *mod_to);
+	void (*quit)(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
+};
+
 #define rsnd_priv_to_dmac(p)	((struct rsnd_dma_ctrl *)(p)->dma)
 
 /*
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 6c10a8b..705e66f 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -181,13 +181,6 @@ void rsnd_path_parse(struct rsnd_priv *priv,
  *	R-Car DMA
  */
 struct rsnd_dma;
-struct rsnd_dma_ops {
-	void (*start)(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
-	void (*stop)(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
-	int (*init)(struct rsnd_dai_stream *io, struct rsnd_dma *dma, int id,
-		    struct rsnd_mod *mod_from, struct rsnd_mod *mod_to);
-	void (*quit)(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
-};
 
 struct rsnd_dmaen {
 	struct dma_chan		*chan;
-- 
2.1.4
