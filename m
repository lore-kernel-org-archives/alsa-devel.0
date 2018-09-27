From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next 01/10] ASoC: rsnd: ssi: Request dedicated dma channels for busif1 to 7
Date: Thu, 27 Sep 2018 14:03:58 +0900
Message-ID: <20180927050407.17765-2-jiada_wang@mentor.com>
References: <20180927050407.17765-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927050407.17765-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: jiada_wang@mentor.com, twischer@de.adit-jv.com, dragos_tarcatu@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jiada Wang <jiada_wang@mentor.com>

Currently ssi driver only request dma channel for SSI_0,
which is used to transfer data to/from busif0.

But since busif1 to busif7 also maybe used, dedicated dma channels
are request for data transfer between these busif.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3adcc4f778f7..75a3d15084c2 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -76,6 +76,8 @@
 
 #define SSI_NAME "ssi"
 
+#define SSI_DMA_NAME_SIZE	10
+
 struct rsnd_ssi {
 	struct rsnd_mod mod;
 
@@ -938,12 +940,20 @@ static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_dai_stream *io,
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	int is_play = rsnd_io_is_play(io);
-	char *name;
+	int busif = rsnd_ssi_get_busif(io);
+	char name[SSI_DMA_NAME_SIZE];
 
-	if (rsnd_ssi_use_busif(io))
-		name = is_play ? "rxu" : "txu";
-	else
-		name = is_play ? "rx" : "tx";
+	if (rsnd_ssi_use_busif(io)) {
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rxu%d", busif);
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "txu%d", busif);
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
