From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: remove rsnd_kctrl_remove()" to
	the asoc tree
Date: Wed, 29 Mar 2017 12:02:27 +0100
Message-ID: <E1ctBMx-0007K9-Fk@debutante>
References: <87o9wmkueb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF871266EFD
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:02:39 +0200 (CEST)
In-Reply-To: <87o9wmkueb.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: remove rsnd_kctrl_remove()

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

>From e0c4211854bfebd5507761a2bfddaa9e37074230 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Mar 2017 02:31:23 +0000
Subject: [PATCH] ASoC: rcar: remove rsnd_kctrl_remove()

Current rcar driver is trying to remove kctrl when remove time.
But, 1) rcar driver can't/shouldn't remove before removing sound
card driver, 2) sound card driver will call snd_ctl_dev_free()
and removes all kctrls by snd_ctl_remove().
Thus, rsnd_kctrl_remove() is not necessary. Current implementation
will get Oops when removing rcar driver after sound card.
This patch fix this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c |  9 ---------
 sound/soc/sh/rcar/dvc.c  | 16 ----------------
 sound/soc/sh/rcar/rsnd.h |  3 ---
 3 files changed, 28 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 3e852e00b277..134fe2ea4d9e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1039,15 +1039,6 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
 	return 0;
 }
 
-void _rsnd_kctrl_remove(struct rsnd_kctrl_cfg *cfg)
-{
-	if (cfg->card && cfg->kctrl)
-		snd_ctl_remove(cfg->card, cfg->kctrl);
-
-	cfg->card = NULL;
-	cfg->kctrl = NULL;
-}
-
 int rsnd_kctrl_new_m(struct rsnd_mod *mod,
 		     struct rsnd_dai_stream *io,
 		     struct snd_soc_pcm_runtime *rtd,
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index cf8f59cdd8d7..994fdb7d0034 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -218,21 +218,6 @@ static int rsnd_dvc_probe_(struct rsnd_mod *mod,
 	return rsnd_cmd_attach(io, rsnd_mod_id(mod));
 }
 
-static int rsnd_dvc_remove_(struct rsnd_mod *mod,
-			    struct rsnd_dai_stream *io,
-			    struct rsnd_priv *priv)
-{
-	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
-
-	rsnd_kctrl_remove(dvc->volume);
-	rsnd_kctrl_remove(dvc->mute);
-	rsnd_kctrl_remove(dvc->ren);
-	rsnd_kctrl_remove(dvc->rup);
-	rsnd_kctrl_remove(dvc->rdown);
-
-	return 0;
-}
-
 static int rsnd_dvc_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
@@ -332,7 +317,6 @@ static struct rsnd_mod_ops rsnd_dvc_ops = {
 	.name		= DVC_NAME,
 	.dma_req	= rsnd_dvc_dma_req,
 	.probe		= rsnd_dvc_probe_,
-	.remove		= rsnd_dvc_remove_,
 	.init		= rsnd_dvc_init,
 	.quit		= rsnd_dvc_quit,
 	.pcm_new	= rsnd_dvc_pcm_new,
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 7410ec0174db..81ef3f18834a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -611,9 +611,6 @@ struct rsnd_kctrl_cfg_s {
 	u32 val;
 };
 
-void _rsnd_kctrl_remove(struct rsnd_kctrl_cfg *cfg);
-#define rsnd_kctrl_remove(_cfg)	_rsnd_kctrl_remove(&((_cfg).cfg))
-
 int rsnd_kctrl_new_m(struct rsnd_mod *mod,
 		     struct rsnd_dai_stream *io,
 		     struct snd_soc_pcm_runtime *rtd,
-- 
2.11.0
