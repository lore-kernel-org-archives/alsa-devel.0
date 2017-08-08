From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_ssi_can_output_clk() macro" to the asoc tree
Date: Tue, 08 Aug 2017 12:06:10 +0100
Message-ID: <E1df2Kw-0004ve-BA@finisterre>
References: <871somn93g.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <871somn93g.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rsnd_ssi_can_output_clk() macro

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

>From bb002f925ae18c0c9d72d87b74b311a5209d7178 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 Aug 2017 01:32:42 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_ssi_can_output_clk() macro

For example SSI0/SSI1 case, SSI1 can share pin with SSI0.
And then, SSI1 needs SSI0's clock.
This clock controlling is very picky and difficult to understand
in current code.

This patch adds new rsnd_ssi_can_output_clk() macro,
the code will be more understandable.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3ee7b2de7dea..434996d4054a 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -106,6 +106,7 @@ struct rsnd_ssi {
 	(rsnd_ssi_multi_slaves(io) & (1 << rsnd_mod_id(mod)))
 #define rsnd_ssi_is_run_mods(mod, io) \
 	(rsnd_ssi_run_mods(io) & (1 << rsnd_mod_id(mod)))
+#define rsnd_ssi_can_output_clk(mod) (!__rsnd_ssi_is_pin_sharing(mod))
 
 int rsnd_ssi_hdmi_port(struct rsnd_dai_stream *io)
 {
@@ -255,7 +256,6 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
 	int chan = rsnd_runtime_channel_for_ssi(io);
 	int idx, ret;
 	unsigned int main_rate;
@@ -266,7 +266,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (!rsnd_rdai_is_clk_master(rdai))
 		return 0;
 
-	if (ssi_parent_mod && !rsnd_ssi_is_parent(mod, io))
+	if (!rsnd_ssi_can_output_clk(mod))
 		return 0;
 
 	if (rsnd_ssi_is_multi_slave(mod, io))
@@ -307,12 +307,11 @@ static void rsnd_ssi_master_clk_stop(struct rsnd_mod *mod,
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
 
 	if (!rsnd_rdai_is_clk_master(rdai))
 		return;
 
-	if (ssi_parent_mod && !rsnd_ssi_is_parent(mod, io))
+	if (!rsnd_ssi_can_output_clk(mod))
 		return;
 
 	if (ssi->usrcnt > 1)
-- 
2.13.2
