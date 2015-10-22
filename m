From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove duplicate parameter from
	rsnd_ssi_xxx()" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:44 +0900
Message-ID: <E1ZpOzQ-0008Te-1L@finisterre>
References: <87r3knsiml.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F95B266B31
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:53 +0200 (CEST)
In-Reply-To: <87r3knsiml.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove duplicate parameter from rsnd_ssi_xxx()

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

>From b415b4d3122a466f3a73d86a1dd2dcdc13de7ef3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Oct 2015 03:15:46 +0000
Subject: [PATCH] ASoC: rsnd: remove duplicate parameter from rsnd_ssi_xxx()

rsnd_ssi_use_busif() and rsnd_ssi_is_pin_sharing() are the function
which returns current SSI status. But these requests duplicated parameter.
This patch removes duplicated parameter.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c  |  3 +--
 sound/soc/sh/rcar/dma.c  |  2 +-
 sound/soc/sh/rcar/rsnd.h |  7 +++++--
 sound/soc/sh/rcar/src.c  |  2 +-
 sound/soc/sh/rcar/ssi.c  | 11 ++++++-----
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index c4ebbb7..2a5b3a2 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -69,11 +69,10 @@ static u32 rsnd_adg_calculate_rbgx(unsigned long div)
 static u32 rsnd_adg_ssi_ws_timing_gen2(struct rsnd_dai_stream *io)
 {
 	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	int id = rsnd_mod_id(mod);
 	int ws = id;
 
-	if (rsnd_ssi_is_pin_sharing(rsnd_ssi_mod_get(priv, id))) {
+	if (rsnd_ssi_is_pin_sharing(io)) {
 		switch (id) {
 		case 1:
 		case 2:
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index bfbb8a5..5d084d0 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -470,7 +470,7 @@ rsnd_gen2_dma_addr(struct rsnd_dai_stream *io,
 		dev_err(dev, "DVC is selected without SRC\n");
 
 	/* use SSIU or SSI ? */
-	if (is_ssi && rsnd_ssi_use_busif(io, mod))
+	if (is_ssi && rsnd_ssi_use_busif(io))
 		is_ssi++;
 
 	return (is_from) ?
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 38c16d7..0853298 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -572,9 +572,12 @@ int rsnd_ssi_probe(struct platform_device *pdev,
 void rsnd_ssi_remove(struct platform_device *pdev,
 		     struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id);
-int rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
 int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
-int rsnd_ssi_use_busif(struct rsnd_dai_stream *io, struct rsnd_mod *mod);
+int rsnd_ssi_use_busif(struct rsnd_dai_stream *io);
+
+#define rsnd_ssi_is_pin_sharing(io)	\
+	__rsnd_ssi_is_pin_sharing(rsnd_io_to_mod_ssi(io))
+int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
 
 /*
  *	R-Car SRC
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 37d41f0..261b502 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -159,7 +159,7 @@ int rsnd_src_ssiu_start(struct rsnd_mod *ssi_mod,
 	/*
 	 * SSI_MODE1
 	 */
-	if (rsnd_ssi_is_pin_sharing(ssi_mod)) {
+	if (rsnd_ssi_is_pin_sharing(io)) {
 		int shift = -1;
 		switch (ssi_id) {
 		case 1:
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index e550621..1427ec2 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -86,8 +86,9 @@ struct rsnd_ssi {
 #define rsnd_ssi_of_node(priv) \
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,ssi")
 
-int rsnd_ssi_use_busif(struct rsnd_dai_stream *io, struct rsnd_mod *mod)
+int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 {
+	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	int use_busif = 0;
 
@@ -394,7 +395,7 @@ static int rsnd_ssi_start(struct rsnd_mod *mod,
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 
-	rsnd_src_ssiu_start(mod, io, rsnd_ssi_use_busif(io, mod));
+	rsnd_src_ssiu_start(mod, io, rsnd_ssi_use_busif(io));
 
 	rsnd_ssi_hw_start(ssi, io);
 
@@ -613,7 +614,7 @@ static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_dai_stream *io,
 	int is_play = rsnd_io_is_play(io);
 	char *name;
 
-	if (rsnd_ssi_use_busif(io, mod))
+	if (rsnd_ssi_use_busif(io))
 		name = is_play ? "rxu" : "txu";
 	else
 		name = is_play ? "rx" : "tx";
@@ -659,7 +660,7 @@ struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id)
 	return rsnd_mod_get((struct rsnd_ssi *)(priv->ssi) + id);
 }
 
-int rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod)
+int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 
@@ -670,7 +671,7 @@ static void rsnd_ssi_parent_setup(struct rsnd_priv *priv, struct rsnd_ssi *ssi)
 {
 	struct rsnd_mod *mod = rsnd_mod_get(ssi);
 
-	if (!rsnd_ssi_is_pin_sharing(mod))
+	if (!__rsnd_ssi_is_pin_sharing(mod))
 		return;
 
 	switch (rsnd_mod_id(mod)) {
-- 
2.6.1
