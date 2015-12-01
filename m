From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add missing ADINR::CHNUM on
	DVC/SRC/SSIU" to the asoc tree
Date: Tue, 01 Dec 2015 23:00:03 +0000
Message-ID: <E1a3ttz-0007DA-8f@debutante>
References: <87a8pvub5l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5352266299
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 00:00:07 +0100 (CET)
In-Reply-To: <87a8pvub5l.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add missing ADINR::CHNUM on DVC/SRC/SSIU

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

>From c45f7263a805e1c5d8579569884d32141330589f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:49:33 +0000
Subject: [PATCH] ASoC: rsnd: add missing ADINR::CHNUM on DVC/SRC/SSIU

DVC/SRC/SSIU needs ADINR::CHNUM settings too. This patch adds
these missing value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c  | 6 +++++-
 sound/soc/sh/rcar/src.c  | 3 ++-
 sound/soc/sh/rcar/ssiu.c | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 0f61e1344431..c622dec24362 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -97,11 +97,15 @@ static void rsnd_dvc_volume_init(struct rsnd_dai_stream *io,
 				 struct rsnd_mod *mod)
 {
 	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
+	u32 adinr = 0;
 	u32 dvucr = 0;
 	u32 vrctr = 0;
 	u32 vrpdr = 0;
 	u32 vrdbr = 0;
 
+	adinr = rsnd_get_adinr_bit(mod, io) |
+		rsnd_get_adinr_chan(mod, io);
+
 	/* Enable Digital Volume, Zero Cross Mute Mode */
 	dvucr |= 0x101;
 
@@ -124,7 +128,7 @@ static void rsnd_dvc_volume_init(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, DVC_DVUIR, 1);
 
 	/* General Information */
-	rsnd_mod_write(mod, DVC_ADINR, rsnd_get_adinr_bit(mod, io));
+	rsnd_mod_write(mod, DVC_ADINR, adinr);
 	rsnd_mod_write(mod, DVC_DVUCR, dvucr);
 
 	/* Volume Ramp Parameter */
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 6d93c4ed8275..30cad79deab0 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -199,7 +199,8 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	/*
 	 *	SRC_ADINR
 	 */
-	adinr = rsnd_get_adinr_bit(mod, io);
+	adinr = rsnd_get_adinr_bit(mod, io) |
+		rsnd_get_adinr_chan(mod, io);
 
 	/*
 	 *	SRC_IFSCR / SRC_IFSVR
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index bc245047e904..6120b0a66958 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -82,7 +82,8 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 		u32 val = rsnd_get_dalign(mod, io);
 
 		rsnd_mod_write(mod, SSI_BUSIF_ADINR,
-			       rsnd_get_adinr_bit(mod, io));
+			       rsnd_get_adinr_bit(mod, io) |
+			       rsnd_get_adinr_chan(mod, io));
 		rsnd_mod_write(mod, SSI_BUSIF_MODE,  1);
 		rsnd_mod_write(mod, SSI_BUSIF_DALIGN, val);
 	}
-- 
2.6.2
