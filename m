From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: indicates Channel and Mode for
	debug" to the asoc tree
Date: Tue,  4 Dec 2018 17:27:13 +0000 (GMT)
Message-ID: <20181204172713.D9F1C11251E3@debutante.sirena.org.uk>
References: <87k1kp3f5k.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A2B97267B81
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 18:27:14 +0100 (CET)
In-Reply-To: <87k1kp3f5k.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: indicates Channel and Mode for debug

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

>From 5d9bb5554c1dadb141eda9afc06dea350e277b18 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 4 Dec 2018 07:59:05 +0000
Subject: [PATCH] ASoC: rsnd: indicates Channel and Mode for debug

For TDM debug purpose, indicating Channel and Mode is very
useful. This patch indicate it if it has #define DEBUG

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 1996aea21172..1fdcc7c3fc7e 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -329,7 +329,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	ssi->rate = rate;
 	ssi->chan = chan;
 
-	dev_dbg(dev, "%s outputs %u Hz\n", rsnd_mod_name(mod), rate);
+	dev_dbg(dev, "%s outputs %d chan %u Hz\n",
+		rsnd_mod_name(mod), chan, rate);
 
 	return 0;
 }
@@ -360,6 +361,8 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 				struct rsnd_dai_stream *io)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	u32 cr_own	= ssi->cr_own;
@@ -371,6 +374,11 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	is_tdm		= rsnd_runtime_is_tdm(io);
 	is_tdm_split	= rsnd_runtime_is_tdm_split(io);
 
+	if (is_tdm)
+		dev_dbg(dev, "TDM mode\n");
+	if (is_tdm_split)
+		dev_dbg(dev, "TDM Split mode\n");
+
 	cr_own |= FORCE | rsnd_rdai_width_to_swl(rdai);
 
 	if (rdai->bit_clk_inv)
-- 
2.19.0.rc2
