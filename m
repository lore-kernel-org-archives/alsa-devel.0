From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: rsnd: dma: Calculate dma address with
	consider of BUSIF" to the asoc tree
Date: Mon,  3 Sep 2018 14:45:35 +0100 (BST)
Message-ID: <20180903134535.3B92B11227AE@debutante.sirena.org.uk>
References: <871sabf4kb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 950692678BC
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:45:35 +0200 (CEST)
In-Reply-To: <871sabf4kb.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoc: rsnd: dma: Calculate dma address with consider of BUSIF

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

>From 5e45a6fab3b90ca300e13191fc68baaa8e37d1d4 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 3 Sep 2018 07:07:43 +0000
Subject: [PATCH] ASoc: rsnd: dma: Calculate dma address with consider of BUSIF

DMA address calculated by rsnd_dma_addr() only considers BUSIF0 so far.
But BUSIF1 ~ BUSIF7 also maybe used, in the future.

This patch updates DMA address calculations, to also consider
BUSIF number used by SSI.

One note is that we can't support SSI9-4/5/6/7 so far,
because its address is out of calculation rule.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[kuninori: adjust to upstreaming]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c  | 43 +++++++++++++++++++++++++---------------
 sound/soc/sh/rcar/rsnd.h |  1 +
 sound/soc/sh/rcar/ssi.c  |  5 +++++
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index fe63ef8600d0..73f743ea3d08 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -487,11 +487,11 @@ static struct rsnd_mod_ops rsnd_dmapp_ops = {
 #define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
 #define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
 
-#define RDMA_SSIU_I_N(addr, i)	(addr ##_reg - 0x00441000 + (0x1000 * i))
-#define RDMA_SSIU_O_N(addr, i)	(addr ##_reg - 0x00441000 + (0x1000 * i))
+#define RDMA_SSIU_I_N(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400))
+#define RDMA_SSIU_O_N(addr, i, j) RDMA_SSIU_I_N(addr, i, j)
 
-#define RDMA_SSIU_I_P(addr, i)	(addr ##_reg - 0x00141000 + (0x1000 * i))
-#define RDMA_SSIU_O_P(addr, i)	(addr ##_reg - 0x00141000 + (0x1000 * i))
+#define RDMA_SSIU_I_P(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400))
+#define RDMA_SSIU_O_P(addr, i, j) RDMA_SSIU_I_P(addr, i, j)
 
 #define RDMA_SRC_I_N(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))
 #define RDMA_SRC_O_N(addr, i)	(addr ##_reg - 0x004fc000 + (0x400 * i))
@@ -517,6 +517,7 @@ rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
 		      !!rsnd_io_to_mod_mix(io) ||
 		      !!rsnd_io_to_mod_ctu(io);
 	int id = rsnd_mod_id(mod);
+	int busif = rsnd_ssi_get_busif(io);
 	struct dma_addr {
 		dma_addr_t out_addr;
 		dma_addr_t in_addr;
@@ -533,25 +534,35 @@ rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
 		},
 		/* SSI */
 		/* Capture */
-		{{{ RDMA_SSI_O_N(ssi, id),	0 },
-		  { RDMA_SSIU_O_P(ssi, id),	0 },
-		  { RDMA_SSIU_O_P(ssi, id),	0 } },
+		{{{ RDMA_SSI_O_N(ssi, id),		0 },
+		  { RDMA_SSIU_O_P(ssi, id, busif),	0 },
+		  { RDMA_SSIU_O_P(ssi, id, busif),	0 } },
 		 /* Playback */
-		 {{ 0,				RDMA_SSI_I_N(ssi, id) },
-		  { 0,				RDMA_SSIU_I_P(ssi, id) },
-		  { 0,				RDMA_SSIU_I_P(ssi, id) } }
+		 {{ 0,			RDMA_SSI_I_N(ssi, id) },
+		  { 0,			RDMA_SSIU_I_P(ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P(ssi, id, busif) } }
 		},
 		/* SSIU */
 		/* Capture */
-		{{{ RDMA_SSIU_O_N(ssi, id),	0 },
-		  { RDMA_SSIU_O_P(ssi, id),	0 },
-		  { RDMA_SSIU_O_P(ssi, id),	0 } },
+		{{{ RDMA_SSIU_O_N(ssi, id, busif),	0 },
+		  { RDMA_SSIU_O_P(ssi, id, busif),	0 },
+		  { RDMA_SSIU_O_P(ssi, id, busif),	0 } },
 		 /* Playback */
-		 {{ 0,				RDMA_SSIU_I_N(ssi, id) },
-		  { 0,				RDMA_SSIU_I_P(ssi, id) },
-		  { 0,				RDMA_SSIU_I_P(ssi, id) } } },
+		 {{ 0,			RDMA_SSIU_I_N(ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P(ssi, id, busif) },
+		  { 0,			RDMA_SSIU_I_P(ssi, id, busif) } } },
 	};
 
+	/*
+	 * FIXME
+	 *
+	 * We can't support SSI9-4/5/6/7, because its address is
+	 * out of calculation rule
+	 */
+	if ((id == 9) && (busif >= 4))
+		dev_err(dev, "This driver doesn't support SSI%d-%d, so far",
+			id, busif);
+
 	/* it shouldn't happen */
 	if (use_cmd && !use_src)
 		dev_err(dev, "DVC is selected without SRC\n");
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 20e6a2ebebed..cb27a679dc65 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -692,6 +692,7 @@ void rsnd_ssi_remove(struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id);
 int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io);
+int rsnd_ssi_get_busif(struct rsnd_dai_stream *io);
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io);
 
 #define RSND_SSI_HDMI_PORT0	0xf0
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3f6dd9f07bc6..85da4fc82011 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -150,6 +150,11 @@ int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 	return use_busif;
 }
 
+int rsnd_ssi_get_busif(struct rsnd_dai_stream *io)
+{
+	return 0; /* BUSIF0 only for now */
+}
+
 static void rsnd_ssi_status_clear(struct rsnd_mod *mod)
 {
 	rsnd_mod_write(mod, SSISR, 0);
-- 
2.19.0.rc1
