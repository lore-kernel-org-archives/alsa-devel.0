From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: move DVC specific macro into
	dvc.c" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:33 +0100
Message-ID: <E1ZFqRJ-0002mz-9Z@finisterre>
References: <87wpy1vqy3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6395D266839
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:38 +0200 (CEST)
In-Reply-To: <87wpy1vqy3.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: move DVC specific macro into dvc.c

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

>From 4f35fabaa30b116d549d95fe7dae907510c71862 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:11:02 +0000
Subject: [PATCH] ASoC: rsnd: move DVC specific macro into dvc.c

rsnd_dvc_nr() is used only from dvc.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c  | 1 +
 sound/soc/sh/rcar/rsnd.h | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index dbf0da6..8a61aa3 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -24,6 +24,7 @@ struct rsnd_dvc {
 	struct rsnd_kctrl_cfg_s rdown;	/* Ramp Rate Down */
 };
 
+#define rsnd_dvc_nr(priv) ((priv)->dvc_nr)
 #define rsnd_dvc_of_node(priv) \
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,dvc")
 
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 46eb4da..8f793f0 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -579,7 +579,4 @@ void rsnd_dvc_remove(struct platform_device *pdev,
 		     struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_dvc_mod_get(struct rsnd_priv *priv, int id);
 
-#define rsnd_dvc_nr(priv) ((priv)->dvc_nr)
-
-
 #endif
-- 
2.1.4
