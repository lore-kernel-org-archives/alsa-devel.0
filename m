From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: move SRC specific macro into
	src.c" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:31 +0100
Message-ID: <E1ZFqRH-0002mW-FG@finisterre>
References: <87vbdlvqxj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1F0266837
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:37 +0200 (CEST)
In-Reply-To: <87vbdlvqxj.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: move SRC specific macro into src.c

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

>From da599fd34b1f2f14f2c387e6b3a909f9ff519c8a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:11:21 +0000
Subject: [PATCH] ASoC: rsnd: move SRC specific macro into src.c

rsnd_src_nr() is used only from src.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 2 --
 sound/soc/sh/rcar/src.c  | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 8f793f0..c8d2029 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -554,8 +554,6 @@ int rsnd_src_ssiu_stop(struct rsnd_mod *ssi_mod,
 int rsnd_src_ssi_irq_enable(struct rsnd_mod *ssi_mod);
 int rsnd_src_ssi_irq_disable(struct rsnd_mod *ssi_mod);
 
-#define rsnd_src_nr(priv) ((priv)->src_nr)
-
 /*
  *	R-Car SSI
  */
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 38d0aba..0b06ac8 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -30,6 +30,7 @@ struct rsnd_src {
 
 #define RSND_SRC_NAME_SIZE 16
 
+#define rsnd_src_nr(priv) ((priv)->src_nr)
 #define rsnd_enable_sync_convert(src) ((src)->sen.val)
 #define rsnd_src_of_node(priv) \
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,src")
-- 
2.1.4
