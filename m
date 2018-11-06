From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: move HDMI information from ssi.c
	to core.c" to the asoc tree
Date: Tue,  6 Nov 2018 17:53:00 +0000 (GMT)
Message-ID: <20181106175300.A7D3B112266B@debutante.sirena.org.uk>
References: <87a7mmx02k.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E9F6267AAB
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:53:01 +0100 (CET)
In-Reply-To: <87a7mmx02k.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: move HDMI information from ssi.c to core.c

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

>From beed78aeeb10214798b1fd5f1dd05e0b7199d65f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 05:19:48 +0000
Subject: [PATCH] ASoC: rsnd: move HDMI information from ssi.c to core.c

Current driver is supporting HDMI output, and its information
are handled under ssi.c. But, it is stream information.
Let's move it from ssi.c to core.c.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 30 +++++++++++++++++++-
 sound/soc/sh/rcar/rsnd.h | 13 ++++-----
 sound/soc/sh/rcar/ssi.c  | 60 +---------------------------------------
 sound/soc/sh/rcar/ssiu.c | 13 ++++-----
 4 files changed, 41 insertions(+), 75 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index cb592191bc86..1758fecaed4c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1005,6 +1005,29 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	.prepare	= rsnd_soc_dai_prepare,
 };
 
+static void rsnd_parse_connect_graph(struct rsnd_priv *priv,
+				     struct rsnd_dai_stream *io,
+				     struct device_node *endpoint)
+{
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct device_node *remote_node = of_graph_get_remote_port_parent(endpoint);
+
+	if (!rsnd_io_to_mod_ssi(io))
+		return;
+
+	/* HDMI0 */
+	if (strstr(remote_node->full_name, "hdmi@fead0000")) {
+		rsnd_flags_set(io, RSND_STREAM_HDMI0);
+		dev_dbg(dev, "%s connected to HDMI0\n", io->name);
+	}
+
+	/* HDMI1 */
+	if (strstr(remote_node->full_name, "hdmi@feae0000")) {
+		rsnd_flags_set(io, RSND_STREAM_HDMI1);
+		dev_dbg(dev, "%s connected to HDMI1\n", io->name);
+	}
+}
+
 void rsnd_parse_connect_common(struct rsnd_dai *rdai,
 		struct rsnd_mod* (*mod_get)(struct rsnd_priv *priv, int id),
 		struct device_node *node,
@@ -1177,7 +1200,12 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	if (is_graph) {
 		for_each_endpoint_of_node(dai_node, dai_np) {
 			__rsnd_dai_probe(priv, dai_np, dai_i);
-			rsnd_ssi_parse_hdmi_connection(priv, dai_np, dai_i);
+			if (rsnd_is_gen3(priv)) {
+				struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
+
+				rsnd_parse_connect_graph(priv, &rdai->playback, dai_np);
+				rsnd_parse_connect_graph(priv, &rdai->capture,  dai_np);
+			}
 			dai_i++;
 		}
 	} else {
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 4b547c6f62a2..9aeb5478fe02 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -458,7 +458,13 @@ struct rsnd_dai_stream {
 	struct rsnd_dai *rdai;
 	struct device *dmac_dev; /* for IPMMU */
 	u32 parent_ssi_status;
+	u32 flags;
 };
+
+/* flags */
+#define RSND_STREAM_HDMI0	(1 << 0) /* for HDMI0 */
+#define RSND_STREAM_HDMI1	(1 << 1) /* for HDMI1 */
+
 #define rsnd_io_to_mod(io, i)	((i) < RSND_MOD_MAX ? (io)->mod[(i)] : NULL)
 #define rsnd_io_to_mod_ssi(io)	rsnd_io_to_mod((io), RSND_MOD_SSI)
 #define rsnd_io_to_mod_ssiu(io)	rsnd_io_to_mod((io), RSND_MOD_SSIU)
@@ -718,13 +724,6 @@ int rsnd_ssi_use_busif(struct rsnd_dai_stream *io);
 int rsnd_ssi_get_busif(struct rsnd_dai_stream *io);
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io);
 
-#define RSND_SSI_HDMI_PORT0	0xf0
-#define RSND_SSI_HDMI_PORT1	0xf1
-int rsnd_ssi_hdmi_port(struct rsnd_dai_stream *io);
-void rsnd_ssi_parse_hdmi_connection(struct rsnd_priv *priv,
-				    struct device_node *endpoint,
-				    int dai_i);
-
 #define rsnd_ssi_is_pin_sharing(io)	\
 	__rsnd_ssi_is_pin_sharing(rsnd_io_to_mod_ssi(io))
 int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f5bda1617b02..e91d3c942ea0 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -99,9 +99,7 @@ struct rsnd_ssi {
 /* flags */
 #define RSND_SSI_CLK_PIN_SHARE		(1 << 0)
 #define RSND_SSI_NO_BUSIF		(1 << 1) /* SSI+DMA without BUSIF */
-#define RSND_SSI_HDMI0			(1 << 2) /* for HDMI0 */
-#define RSND_SSI_HDMI1			(1 << 3) /* for HDMI1 */
-#define RSND_SSI_PROBED			(1 << 4)
+#define RSND_SSI_PROBED			(1 << 2)
 
 #define for_each_rsnd_ssi(pos, priv, i)					\
 	for (i = 0;							\
@@ -119,20 +117,6 @@ struct rsnd_ssi {
 	(rsnd_ssi_run_mods(io) & (1 << rsnd_mod_id(mod)))
 #define rsnd_ssi_can_output_clk(mod) (!__rsnd_ssi_is_pin_sharing(mod))
 
-int rsnd_ssi_hdmi_port(struct rsnd_dai_stream *io)
-{
-	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-
-	if (rsnd_flags_has(ssi, RSND_SSI_HDMI0))
-		return RSND_SSI_HDMI_PORT0;
-
-	if (rsnd_flags_has(ssi, RSND_SSI_HDMI1))
-		return RSND_SSI_HDMI_PORT1;
-
-	return 0;
-}
-
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 {
 	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
@@ -1059,48 +1043,6 @@ void rsnd_parse_connect_ssi(struct rsnd_dai *rdai,
 	of_node_put(node);
 }
 
-static void __rsnd_ssi_parse_hdmi_connection(struct rsnd_priv *priv,
-					     struct rsnd_dai_stream *io,
-					     struct device_node *remote_ep)
-{
-	struct device *dev = rsnd_priv_to_dev(priv);
-	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
-	struct rsnd_ssi *ssi;
-	struct device_node *remote_node = of_graph_get_port_parent(remote_ep);
-
-	/* support Gen3 only */
-	if (!rsnd_is_gen3(priv))
-		return;
-
-	if (!mod)
-		return;
-
-	ssi  = rsnd_mod_to_ssi(mod);
-
-	/* HDMI0 */
-	if (strstr(remote_node->full_name, "hdmi@fead0000")) {
-		rsnd_flags_set(ssi, RSND_SSI_HDMI0);
-		dev_dbg(dev, "%s connected to HDMI0\n", rsnd_mod_name(mod));
-	}
-
-	/* HDMI1 */
-	if (strstr(remote_node->full_name, "hdmi@feae0000")) {
-		rsnd_flags_set(ssi, RSND_SSI_HDMI1);
-		dev_dbg(dev, "%s connected to HDMI1\n", rsnd_mod_name(mod));
-	}
-}
-
-void rsnd_ssi_parse_hdmi_connection(struct rsnd_priv *priv,
-				    struct device_node *endpoint,
-				    int dai_i)
-{
-	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
-	struct device_node *remote_ep = of_graph_get_remote_endpoint(endpoint);
-
-	__rsnd_ssi_parse_hdmi_connection(priv, &rdai->playback, remote_ep);
-	__rsnd_ssi_parse_hdmi_connection(priv, &rdai->capture,  remote_ep);
-}
-
 struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id)
 {
 	if (WARN_ON(id < 0 || id >= rsnd_ssi_nr(priv)))
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 645340ee4222..4f591008cfe5 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -135,7 +135,8 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 			       struct rsnd_priv *priv)
 {
 	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
-	int hdmi = rsnd_ssi_hdmi_port(io);
+	u32 has_hdmi0 = rsnd_flags_has(io, RSND_STREAM_HDMI0);
+	u32 has_hdmi1 = rsnd_flags_has(io, RSND_STREAM_HDMI1);
 	int ret;
 	u32 mode = 0;
 
@@ -212,7 +213,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 		}
 	}
 
-	if (hdmi) {
+	if (has_hdmi0 || has_hdmi1) {
 		enum rsnd_mod_type rsnd_ssi_array[] = {
 			RSND_MOD_SSIM1,
 			RSND_MOD_SSIM2,
@@ -238,14 +239,10 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 				rsnd_mod_id(pos) << shift;
 		}
 
-		switch (hdmi) {
-		case RSND_SSI_HDMI_PORT0:
+		if (has_hdmi0)
 			rsnd_mod_write(mod, HDMI0_SEL, val);
-			break;
-		case RSND_SSI_HDMI_PORT1:
+		if (has_hdmi1)
 			rsnd_mod_write(mod, HDMI1_SEL, val);
-			break;
-		}
 	}
 
 	return 0;
-- 
2.19.0.rc2
