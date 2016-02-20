From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rename RSND_DVC_CHANNELS to
	RSND_MAX_CHANNELS" to the asoc tree
Date: Sun, 21 Feb 2016 02:16:20 +0900
Message-ID: <E1aXB8m-0008Sq-SY@finisterre>
References: <87r3gatp7n.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5007126520A
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:34 +0100 (CET)
In-Reply-To: <87r3gatp7n.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: rename RSND_DVC_CHANNELS to RSND_MAX_CHANNELS

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

>From d2240f0dad488c66e14c45762bd23999901f57a1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:13:13 +0000
Subject: [PATCH] ASoC: rsnd: rename RSND_DVC_CHANNELS to RSND_MAX_CHANNELS

The channels number is not only for DVC. Let's rename it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 +-
 sound/soc/sh/rcar/dvc.c  | 6 +++---
 sound/soc/sh/rcar/rsnd.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 704ba7a..f86d627 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -988,7 +988,7 @@ int rsnd_kctrl_new_m(struct rsnd_mod *mod,
 		     int ch_size,
 		     u32 max)
 {
-	if (ch_size > RSND_DVC_CHANNELS)
+	if (ch_size > RSND_MAX_CHANNELS)
 		return -EINVAL;
 
 	_cfg->cfg.max	= max;
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 302c193..d757f13 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -83,15 +83,15 @@ static void rsnd_dvc_volume_parameter(struct rsnd_dai_stream *io,
 					      struct rsnd_mod *mod)
 {
 	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
-	u32 val[RSND_DVC_CHANNELS];
+	u32 val[RSND_MAX_CHANNELS];
 	int i;
 
 	/* Enable Ramp */
 	if (dvc->ren.val)
-		for (i = 0; i < RSND_DVC_CHANNELS; i++)
+		for (i = 0; i < RSND_MAX_CHANNELS; i++)
 			val[i] = dvc->volume.cfg.max;
 	else
-		for (i = 0; i < RSND_DVC_CHANNELS; i++)
+		for (i = 0; i < RSND_MAX_CHANNELS; i++)
 			val[i] = dvc->volume.val[i];
 
 	/* Enable Digital Volume */
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index bbaf89b..61cb4ae 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -550,10 +550,10 @@ struct rsnd_kctrl_cfg {
 	struct snd_kcontrol *kctrl;
 };
 
-#define RSND_DVC_CHANNELS	8
+#define RSND_MAX_CHANNELS	8
 struct rsnd_kctrl_cfg_m {
 	struct rsnd_kctrl_cfg cfg;
-	u32 val[RSND_DVC_CHANNELS];
+	u32 val[RSND_MAX_CHANNELS];
 };
 
 struct rsnd_kctrl_cfg_s {
-- 
2.7.0
