From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add
	rsnd_src_initialize_lock/unlock()" to the asoc tree
Date: Thu, 16 Jul 2015 22:30:00 +0100
Message-ID: <E1ZFqjA-0004kC-LV@finisterre>
References: <87lhehvqtf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4376266702
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:30:05 +0200 (CEST)
In-Reply-To: <87lhehvqtf.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add rsnd_src_initialize_lock/unlock()

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

>From d1ade514e84ea55cba999edb04cb88daa4da94b8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:13:47 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_src_initialize_lock/unlock()

Renesas SCU (Sampling Rate Convert Unit) includes SRC/CTU/MIX/DVC,
and these have similar register. xxxIR (Initialization Register) is one
of them. These xxxIR need be set to 1 during initialization.
Current rsnd driver has src.c / dvc.c, and we will have mix.c.
It is readable if these have same named function.
This patch adds rsnd_src_initialize_lock/unlock() and make sure it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 74ab644..b3d965e 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -124,6 +124,14 @@ static void rsnd_src_soft_reset(struct rsnd_mod *mod)
 	rsnd_mod_write(mod, SRC_SWRSR, 1);
 }
 
+
+#define rsnd_src_initialize_lock(mod)	__rsnd_src_initialize_lock(mod, 1)
+#define rsnd_src_initialize_unlock(mod)	__rsnd_src_initialize_lock(mod, 0)
+static void __rsnd_src_initialize_lock(struct rsnd_mod *mod, u32 enable)
+{
+	rsnd_mod_write(mod, SRC_SRCIR, enable);
+}
+
 static struct dma_chan *rsnd_src_dma_req(struct rsnd_dai_stream *io,
 					 struct rsnd_mod *mod)
 {
@@ -362,17 +370,13 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 
 	rsnd_src_soft_reset(mod);
 
+	rsnd_src_initialize_lock(mod);
+
 	src->err = 0;
 
 	/* reset sync convert_rate */
 	src->sync.val = 0;
 
-	/*
-	 * Initialize the operation of the SRC internal circuits
-	 * see rsnd_src_start()
-	 */
-	rsnd_mod_write(mod, SRC_SRCIR, 1);
-
 	return 0;
 }
 
@@ -399,11 +403,7 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 
 static int rsnd_src_start(struct rsnd_mod *mod)
 {
-	/*
-	 * Cancel the initialization and operate the SRC function
-	 * see rsnd_src_init()
-	 */
-	rsnd_mod_write(mod, SRC_SRCIR, 0);
+	rsnd_src_initialize_unlock(mod);
 
 	return 0;
 }
-- 
2.1.4
