From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: judge work SSI in runtime" to the
	asoc tree
Date: Sun, 21 Feb 2016 02:15:57 +0900
Message-ID: <E1aXB8P-0008O6-Cm@finisterre>
References: <87d1rutoxq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DFB932651B8
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:01 +0100 (CET)
In-Reply-To: <87d1rutoxq.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: judge work SSI in runtime

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

>From fd9adcfdc1434fdd4d0a14ddfe686449a6ffeeb3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:19:12 +0000
Subject: [PATCH] ASoC: rsnd: judge work SSI in runtime

Current rsnd supports multi SSI (maximum 4 SSI for 8ch),
and, it should determine whether using each SSI or not in runtime.
All SSIs are not used even if there are 4 SSI in case of stereo.

Current driver setups un-used SSI in such case. It is no problem,
but not needed. This patch judges it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 32f1f5f..0979db8 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -96,6 +96,8 @@ struct rsnd_ssi {
 #define rsnd_ssi_is_parent(ssi, io) ((ssi) == rsnd_io_to_mod_ssip(io))
 #define rsnd_ssi_is_multi_slave(mod, io) \
 	(rsnd_ssi_multi_slaves(io) & (1 << rsnd_mod_id(mod)))
+#define rsnd_ssi_is_run_mods(mod, io) \
+	(rsnd_ssi_run_mods(io) & (1 << rsnd_mod_id(mod)))
 
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 {
@@ -166,6 +168,16 @@ static u32 rsnd_ssi_multi_slaves(struct rsnd_dai_stream *io)
 	return mask;
 }
 
+static u32 rsnd_ssi_run_mods(struct rsnd_dai_stream *io)
+{
+	struct rsnd_mod *ssi_mod = rsnd_io_to_mod_ssi(io);
+	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
+
+	return rsnd_ssi_multi_slaves_runtime(io) |
+		1 << rsnd_mod_id(ssi_mod) |
+		1 << rsnd_mod_id(ssi_parent_mod);
+}
+
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io)
 {
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
@@ -348,6 +360,9 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	int ret;
 
+	if (!rsnd_ssi_is_run_mods(mod, io))
+		return 0;
+
 	ssi->usrcnt++;
 
 	rsnd_mod_power_on(mod);
@@ -374,6 +389,9 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
+	if (!rsnd_ssi_is_run_mods(mod, io))
+		return 0;
+
 	if (!ssi->usrcnt) {
 		dev_err(dev, "%s[%d] usrcnt error\n",
 			rsnd_mod_name(mod), rsnd_mod_id(mod));
@@ -422,6 +440,9 @@ static int rsnd_ssi_start(struct rsnd_mod *mod,
 			  struct rsnd_dai_stream *io,
 			  struct rsnd_priv *priv)
 {
+	if (!rsnd_ssi_is_run_mods(mod, io))
+		return 0;
+
 	/*
 	 * EN will be set via SSIU :: SSI_CONTROL
 	 * if Multi channel mode
@@ -441,6 +462,9 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	u32 cr;
 
+	if (!rsnd_ssi_is_run_mods(mod, io))
+		return 0;
+
 	/*
 	 * don't stop if not last user
 	 * see also
@@ -483,6 +507,9 @@ static int rsnd_ssi_irq(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
+	if (!rsnd_ssi_is_run_mods(mod, io))
+		return 0;
+
 	if (enable)
 		val = rsnd_ssi_is_dma_mode(mod) ? 0x0e000000 : 0x0f000000;
 
-- 
2.7.0
