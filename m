From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rename rsnd_runtime_is_ssi_xxx()"
	to the asoc tree
Date: Tue,  6 Nov 2018 17:53:21 +0000 (GMT)
Message-ID: <20181106175321.0D4FC112266B@debutante.sirena.org.uk>
References: <87d0rix03j.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E8E8267AA8
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:53:21 +0100 (CET)
In-Reply-To: <87d0rix03j.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: rename rsnd_runtime_is_ssi_xxx()

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

>From a607280293b4b804fa080c75412b256ec37ce04c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 05:19:19 +0000
Subject: [PATCH] ASoC: rsnd: rename rsnd_runtime_is_ssi_xxx()

Current rsnd driver has rsnd_runtime_is_ssi_xxx() functions,
but it is not only related to SSI, thus, it is misunderstandable.
This patch renames it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 6 +++---
 sound/soc/sh/rcar/rsnd.h | 4 ++--
 sound/soc/sh/rcar/ssi.c  | 4 ++--
 sound/soc/sh/rcar/ssiu.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 5e100122391a..cbe846e4438f 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -287,7 +287,7 @@ int rsnd_runtime_channel_for_ssi_with_params(struct rsnd_dai_stream *io,
 		rsnd_runtime_channel_original_with_params(io, params);
 
 	/* Use Multi SSI */
-	if (rsnd_runtime_is_ssi_multi(io))
+	if (rsnd_runtime_is_multi_ssi(io))
 		chan /= rsnd_rdai_ssi_lane_get(rdai);
 
 	/* TDM Extend Mode needs 8ch */
@@ -297,7 +297,7 @@ int rsnd_runtime_channel_for_ssi_with_params(struct rsnd_dai_stream *io,
 	return chan;
 }
 
-int rsnd_runtime_is_ssi_multi(struct rsnd_dai_stream *io)
+int rsnd_runtime_is_multi_ssi(struct rsnd_dai_stream *io)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	int lane = rsnd_rdai_ssi_lane_get(rdai);
@@ -308,7 +308,7 @@ int rsnd_runtime_is_ssi_multi(struct rsnd_dai_stream *io)
 	return (chan > 2) && (lane > 1);
 }
 
-int rsnd_runtime_is_ssi_tdm(struct rsnd_dai_stream *io)
+int rsnd_runtime_is_tdm(struct rsnd_dai_stream *io)
 {
 	return rsnd_runtime_channel_for_ssi(io) >= 6;
 }
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 28bd90ab5a99..4b547c6f62a2 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -431,8 +431,8 @@ int rsnd_runtime_channel_after_ctu_with_params(struct rsnd_dai_stream *io,
 	rsnd_runtime_channel_for_ssi_with_params(io, NULL)
 int rsnd_runtime_channel_for_ssi_with_params(struct rsnd_dai_stream *io,
 				 struct snd_pcm_hw_params *params);
-int rsnd_runtime_is_ssi_multi(struct rsnd_dai_stream *io);
-int rsnd_runtime_is_ssi_tdm(struct rsnd_dai_stream *io);
+int rsnd_runtime_is_multi_ssi(struct rsnd_dai_stream *io);
+int rsnd_runtime_is_tdm(struct rsnd_dai_stream *io);
 
 /*
  * DT
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 10a53e2adcad..f5bda1617b02 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -223,7 +223,7 @@ static u32 rsnd_ssi_run_mods(struct rsnd_dai_stream *io)
 
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io)
 {
-	if (rsnd_runtime_is_ssi_multi(io))
+	if (rsnd_runtime_is_multi_ssi(io))
 		return rsnd_ssi_multi_slaves(io);
 
 	return 0;
@@ -383,7 +383,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	u32 wsr		= ssi->wsr;
 	int is_tdm;
 
-	is_tdm = rsnd_runtime_is_ssi_tdm(io);
+	is_tdm = rsnd_runtime_is_tdm(io);
 
 	cr_own |= FORCE | rsnd_rdai_width_to_swl(rdai);
 
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index ebcb826b849f..645340ee4222 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -145,7 +145,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 
 	ssiu->usrcnt++;
 
-	if (rsnd_runtime_is_ssi_tdm(io)) {
+	if (rsnd_runtime_is_tdm(io)) {
 		/*
 		 * TDM Extend Mode
 		 * see
-- 
2.19.0.rc2
