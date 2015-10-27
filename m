From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: DMA related definition goes to
	dma.c" to the asoc tree
Date: Tue, 27 Oct 2015 13:49:07 +0900
Message-ID: <E1ZqwC3-0004tU-Gy@finisterre>
References: <87y4eq3u6o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 390DA2657D2
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:16 +0100 (CET)
In-Reply-To: <87y4eq3u6o.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: DMA related definition goes to dma.c

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

>From 2e7f7286bd4f446df594a7b6846ad3c81fa47732 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:38:58 +0000
Subject: [PATCH] ASoC: rsnd: DMA related definition goes to dma.c

Renesas sound needs many devices
(SSI/SSIU/SRC/CTU/MIX/DVC/CMD/AudioDMAC/AudioDMACpp).
SSI/SRC/CTU/MIX/DVC are implemented as module.
SSI parent, SSIU are implemented as part of SSI
CMD is implemented as part of CTU/MIX/DVC
AudioDMAC/AudioDMACpp are implemented as part of SSI/SRC
It is nice sense that these all devices are implemented as mod.

DMA will be implemented as module. Current DMA definition is no longer
needed on rsnd.h. Let's move it to dma.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c  | 24 ++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h | 23 -----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 923120c..00e83e0 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -22,6 +22,27 @@
 /* PDMACHCR */
 #define PDMACHCR_DE		(1 << 0)
 
+
+struct rsnd_dmaen {
+	struct dma_chan		*chan;
+};
+
+struct rsnd_dmapp {
+	int			dmapp_id;
+	u32			chcr;
+};
+
+struct rsnd_dma {
+	struct rsnd_dma_ops	*ops;
+	struct rsnd_mod		*mod;
+	dma_addr_t		src_addr;
+	dma_addr_t		dst_addr;
+	union {
+		struct rsnd_dmaen en;
+		struct rsnd_dmapp pp;
+	} dma;
+};
+
 struct rsnd_dma_ctrl {
 	void __iomem *base;
 	int dmapp_num;
@@ -37,6 +58,9 @@ struct rsnd_dma_ops {
 };
 
 #define rsnd_priv_to_dmac(p)	((struct rsnd_dma_ctrl *)(p)->dma)
+#define rsnd_dma_to_dmaen(dma)	(&(dma)->dma.en)
+#define rsnd_dma_to_dmapp(dma)	(&(dma)->dma.pp)
+#define rsnd_dma_to_mod(_dma) ((dma)->mod)
 
 /*
  *		Audio DMAC
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 1c08eaa..1dc05a2 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -195,29 +195,6 @@ void rsnd_path_parse(struct rsnd_priv *priv,
  */
 struct rsnd_dma;
 
-struct rsnd_dmaen {
-	struct dma_chan		*chan;
-};
-
-struct rsnd_dmapp {
-	int			dmapp_id;
-	u32			chcr;
-};
-
-struct rsnd_dma {
-	struct rsnd_dma_ops	*ops;
-	struct rsnd_mod		*mod;
-	dma_addr_t		src_addr;
-	dma_addr_t		dst_addr;
-	union {
-		struct rsnd_dmaen en;
-		struct rsnd_dmapp pp;
-	} dma;
-};
-#define rsnd_dma_to_dmaen(dma)	(&(dma)->dma.en)
-#define rsnd_dma_to_dmapp(dma)	(&(dma)->dma.pp)
-#define rsnd_dma_to_mod(_dma) ((dma)->mod)
-
 void rsnd_dma_start(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
 void rsnd_dma_stop(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
 struct rsnd_dma *rsnd_dma_init(struct rsnd_dai_stream *io,
-- 
2.6.1
