From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_ssi_flags_has/add() macro" to the asoc tree
Date: Thu, 10 Aug 2017 16:42:23 +0100
Message-ID: <E1dfpbL-0001ki-Re@finisterre>
References: <874ltgz3yp.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <874ltgz3yp.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add rsnd_ssi_flags_has/add() macro

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

>From bf9b29c784b393d1e506945f1e24e871d2587eb3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Aug 2017 00:07:20 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_ssi_flags_has/add() macro

Current rsnd_ssi_mode_flags() is not useful. This patch adds
new rsnd_ssi_flags_has/add() macro for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 281ed0da6ba1..ca9355b86bd9 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -101,7 +101,8 @@ struct rsnd_ssi {
 #define rsnd_ssi_to_dma(mod) ((ssi)->dma)
 #define rsnd_ssi_nr(priv) ((priv)->ssi_nr)
 #define rsnd_mod_to_ssi(_mod) container_of((_mod), struct rsnd_ssi, mod)
-#define rsnd_ssi_mode_flags(p) ((p)->flags)
+#define rsnd_ssi_flags_has(p, f) ((p)->flags & f)
+#define rsnd_ssi_flags_set(p, f) ((p)->flags |= f)
 #define rsnd_ssi_is_parent(ssi, io) ((ssi) == rsnd_io_to_mod_ssip(io))
 #define rsnd_ssi_is_multi_slave(mod, io) \
 	(rsnd_ssi_multi_slaves(io) & (1 << rsnd_mod_id(mod)))
@@ -114,10 +115,10 @@ int rsnd_ssi_hdmi_port(struct rsnd_dai_stream *io)
 	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 
-	if (rsnd_ssi_mode_flags(ssi) & RSND_SSI_HDMI0)
+	if (rsnd_ssi_flags_has(ssi, RSND_SSI_HDMI0))
 		return RSND_SSI_HDMI_PORT0;
 
-	if (rsnd_ssi_mode_flags(ssi) & RSND_SSI_HDMI1)
+	if (rsnd_ssi_flags_has(ssi, RSND_SSI_HDMI1))
 		return RSND_SSI_HDMI_PORT1;
 
 	return 0;
@@ -132,7 +133,7 @@ int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 	if (!rsnd_ssi_is_dma_mode(mod))
 		return 0;
 
-	if (!(rsnd_ssi_mode_flags(ssi) & RSND_SSI_NO_BUSIF))
+	if (!(rsnd_ssi_flags_has(ssi, RSND_SSI_NO_BUSIF)))
 		use_busif = 1;
 	if (rsnd_io_to_mod_src(io))
 		use_busif = 1;
@@ -986,13 +987,13 @@ static void __rsnd_ssi_parse_hdmi_connection(struct rsnd_priv *priv,
 	ssi  = rsnd_mod_to_ssi(mod);
 
 	if (strstr(remote_ep->full_name, "hdmi0")) {
-		ssi->flags |= RSND_SSI_HDMI0;
+		rsnd_ssi_flags_set(ssi, RSND_SSI_HDMI0);
 		dev_dbg(dev, "%s[%d] connected to HDMI0\n",
 			 rsnd_mod_name(mod), rsnd_mod_id(mod));
 	}
 
 	if (strstr(remote_ep->full_name, "hdmi1")) {
-		ssi->flags |= RSND_SSI_HDMI1;
+		rsnd_ssi_flags_set(ssi, RSND_SSI_HDMI1);
 		dev_dbg(dev, "%s[%d] connected to HDMI1\n",
 			rsnd_mod_name(mod), rsnd_mod_id(mod));
 	}
@@ -1025,7 +1026,7 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 
-	return !!(rsnd_ssi_mode_flags(ssi) & RSND_SSI_CLK_PIN_SHARE);
+	return !!(rsnd_ssi_flags_has(ssi, RSND_SSI_CLK_PIN_SHARE));
 }
 
 static u32 *rsnd_ssi_get_status(struct rsnd_dai_stream *io,
@@ -1108,10 +1109,10 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 		}
 
 		if (of_get_property(np, "shared-pin", NULL))
-			ssi->flags |= RSND_SSI_CLK_PIN_SHARE;
+			rsnd_ssi_flags_set(ssi, RSND_SSI_CLK_PIN_SHARE);
 
 		if (of_get_property(np, "no-busif", NULL))
-			ssi->flags |= RSND_SSI_NO_BUSIF;
+			rsnd_ssi_flags_set(ssi, RSND_SSI_NO_BUSIF);
 
 		ssi->irq = irq_of_parse_and_map(np, 0);
 		if (!ssi->irq) {
-- 
2.13.2
