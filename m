From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup rsnd_get_slot_xxx()
	naming" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:24 +0000
Message-ID: <E1a9twS-000646-I1@debutante>
References: <874mfhiy38.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D058F265AE4
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:30 +0100 (CET)
In-Reply-To: <874mfhiy38.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup rsnd_get_slot_xxx() naming

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

>From c140284b8085e0fa07c24f4285db9dc107ad2ed3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:57:27 +0000
Subject: [PATCH] ASoC: rsnd: tidyup rsnd_get_slot_xxx() naming

rsnd_get_slot_rdai() returns total slots (it returns 6 if total 6
channels) , and rsnd_get_slot_extend() returns extended SSI width
(it returns 8 if total 6 channels). This will be used on SSI multi
channel support too (It will return 2 if total 6 channels with 3 SSI).
But, it is using confusable naming.
This patch changes rsnd_get_slot_rdai() -> rsnd_get_slot(),
rsnd_get_slot_extend() -> rsnd_get_slot_width()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 6 ++++--
 sound/soc/sh/rcar/dvc.c  | 3 +--
 sound/soc/sh/rcar/rsnd.h | 4 ++--
 sound/soc/sh/rcar/ssi.c  | 4 ++--
 sound/soc/sh/rcar/ssiu.c | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 7f3a7edba096..76af41633f9f 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -191,12 +191,14 @@ int rsnd_io_is_working(struct rsnd_dai_stream *io)
 	return !!io->substream;
 }
 
-int rsnd_get_slot_rdai(struct rsnd_dai *rdai)
+int rsnd_get_slot(struct rsnd_dai_stream *io)
 {
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+
 	return rdai->slots;
 }
 
-int rsnd_get_slot_extend(struct rsnd_dai_stream *io)
+int rsnd_get_slot_width(struct rsnd_dai_stream *io)
 {
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	int chan = runtime->channels;
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 42e6a230a3d1..d45ffe496397 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -242,10 +242,9 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			    struct rsnd_dai_stream *io,
 			    struct snd_soc_pcm_runtime *rtd)
 {
-	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
 	int is_play = rsnd_io_is_play(io);
-	int slots = rsnd_get_slot_rdai(rdai);
+	int slots = rsnd_get_slot(io);
 	int ret;
 
 	/* Volume */
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index e9909a4ce754..804f2f5622e0 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -293,8 +293,8 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 			void (*callback)(struct rsnd_mod *mod,
 					 struct rsnd_dai_stream *io));
 
-int rsnd_get_slot_rdai(struct rsnd_dai *rdai);
-int rsnd_get_slot_extend(struct rsnd_dai_stream *io);
+int rsnd_get_slot(struct rsnd_dai_stream *io);
+int rsnd_get_slot_width(struct rsnd_dai_stream *io);
 
 /*
  *	R-Car sound DAI
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 7481bc3e0dff..0b91692c5a66 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -180,7 +180,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_ssi *ssi,
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	struct rsnd_mod *mod = rsnd_mod_get(ssi);
 	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
-	int slots = rsnd_get_slot_extend(io);
+	int slots = rsnd_get_slot_width(io);
 	int j, ret;
 	int ssi_clk_mul_table[] = {
 		1, 2, 4, 8, 16, 6, 12,
@@ -267,7 +267,7 @@ static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
 	u32 wsr;
 	int is_tdm;
 
-	is_tdm = (rsnd_get_slot_extend(io) >= 6) ? 1 : 0;
+	is_tdm = (rsnd_get_slot_width(io) >= 6) ? 1 : 0;
 
 	/*
 	 * always use 32bit system word.
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index c7f89beff44f..7ae05a7621ae 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -78,7 +78,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	if (rsnd_get_slot_extend(io) >= 6) {
+	if (rsnd_get_slot_width(io) >= 6) {
 		/*
 		 * TDM Extend Mode
 		 * see
-- 
2.6.2
