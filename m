From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove unused rsnd_xxx_to_dma()"
	to the asoc tree
Date: Tue, 22 Aug 2017 17:21:05 +0100
Message-ID: <E1dkBvN-0004QR-7I@debutante>
References: <87r2wkxb76.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 463782676D4
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 18:21:11 +0200 (CEST)
In-Reply-To: <87r2wkxb76.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove unused rsnd_xxx_to_dma()

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

>From c16293560a1c188a05cba1dcc46548d33b641c06 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Aug 2017 00:02:03 +0000
Subject: [PATCH] ASoC: rsnd: remove unused rsnd_xxx_to_dma()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 1 -
 sound/soc/sh/rcar/ssi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 46400397dbbd..510b68a483b4 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -27,7 +27,6 @@ struct rsnd_src {
 #define RSND_SRC_NAME_SIZE 16
 
 #define rsnd_src_get(priv, id) ((struct rsnd_src *)(priv->src) + id)
-#define rsnd_src_to_dma(src) ((src)->dma)
 #define rsnd_src_nr(priv) ((priv)->src_nr)
 #define rsnd_src_sync_is_enabled(mod) (rsnd_mod_to_src(mod)->sen.val)
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 8bb47144660b..fffc07e72627 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -99,7 +99,6 @@ struct rsnd_ssi {
 	     i++)
 
 #define rsnd_ssi_get(priv, id) ((struct rsnd_ssi *)(priv->ssi) + id)
-#define rsnd_ssi_to_dma(mod) ((ssi)->dma)
 #define rsnd_ssi_nr(priv) ((priv)->ssi_nr)
 #define rsnd_mod_to_ssi(_mod) container_of((_mod), struct rsnd_ssi, mod)
 #define rsnd_ssi_flags_has(p, f) ((p)->flags & f)
-- 
2.13.3
