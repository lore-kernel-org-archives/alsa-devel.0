From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next v3 1/1] ASoC: rsnd: ssi: Request dedicated dma channels for busif0 to 7
Date: Wed, 10 Oct 2018 18:17:25 +0900
Message-ID: <20181010091725.10016-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jiada Wang <jiada_wang@mentor.com>

Currently ssi driver only requests dma channel for SSI_0, with
naming of 'rxu/txu', which is used to transfer data to/from busif0.
But for GEN2/GEN3, there are also busif1 ~ busif7, which need to
be used when SSI works in TDM Split/Ex-Split mode.

This patch adds support to firstly try to request busif indexed
dma channel with naming "rxu[busif]/txu[busif]", if these dma channel
don't exist, then try to request 'rxu/txu' dma channel to keep
compatibility with platform hasn't had device-tree updated.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
v3:
- Drop device-tree changes
- Drop automatic busif selection

v2:
- Instead of configure BUSIF by kctl interface "SSI Out/In BUSIF",
  use rsnd_ssi_select_busif() to automatically select BUSIF.
- Keep 'rxu/txu' dma request, to keep compatibility with GEN2 series
- Re-order patch-set to satisfy git bisect

v1: initial version
---
 sound/soc/sh/rcar/ssi.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3adcc4f778f7..7e21b29249d7 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -76,6 +76,8 @@
 
 #define SSI_NAME "ssi"
 
+#define SSI_DMA_NAME_SIZE	10
+
 struct rsnd_ssi {
 	struct rsnd_mod mod;
 
@@ -938,12 +940,37 @@ static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_dai_stream *io,
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	int is_play = rsnd_io_is_play(io);
-	char *name;
+	char name[SSI_DMA_NAME_SIZE];
 
-	if (rsnd_ssi_use_busif(io))
-		name = is_play ? "rxu" : "txu";
-	else
-		name = is_play ? "rx" : "tx";
+	if (rsnd_ssi_use_busif(io)) {
+		int busif = rsnd_ssi_get_busif(io);
+		struct dma_chan *chan = NULL;
+
+		/* try to request rxu/txu channel with busif index first */
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rxu%d", busif);
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "txu%d", busif);
+
+		chan = rsnd_dma_request_channel(rsnd_ssi_of_node(priv),
+						mod, name);
+		if (!IS_ERR(chan))
+			return chan;
+
+		/*
+		 * If dma channel with busif index doesn't exist
+		 * request rxu/txu dma channel
+		 */
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rxu");
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "txu");
+	} else {
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rx");
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "tx");
+	}
 
 	return rsnd_dma_request_channel(rsnd_ssi_of_node(priv),
 					mod, name);
-- 
2.17.0
