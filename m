From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: MIX settings matches to
	datasheet" to the asoc tree
Date: Wed, 04 Nov 2015 14:53:04 +0000
Message-ID: <E1ZtzQu-0002zC-Hc@finisterre>
References: <87d1vqw43v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CD6726578F
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:53:22 +0100 (CET)
In-Reply-To: <87d1vqw43v.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: MIX settings matches to datasheet

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

>From 42cc196fc742a72c89193c9e243c47acfed7d802 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 4 Nov 2015 08:44:32 +0000
Subject: [PATCH] ASoC: rsnd: MIX settings matches to datasheet

Current MIX settings order was rough.
This patch makes it match to datasheet.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/mix.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index bcbd821..2baa2d7 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -31,24 +31,41 @@ static void rsnd_mix_soft_reset(struct rsnd_mod *mod)
 	rsnd_mod_write(mod, MIX_SWRSR, 1);
 }
 
-#define rsnd_mix_initialize_lock(mod)	__rsnd_mix_initialize_lock(mod, 1)
-#define rsnd_mix_initialize_unlock(mod)	__rsnd_mix_initialize_lock(mod, 0)
-static void __rsnd_mix_initialize_lock(struct rsnd_mod *mod, u32 enable)
+static void rsnd_mix_volume_parameter(struct rsnd_dai_stream *io,
+				      struct rsnd_mod *mod)
 {
-	rsnd_mod_write(mod, MIX_MIXIR, enable);
+	rsnd_mod_write(mod, MIX_MDBAR, 0);
+	rsnd_mod_write(mod, MIX_MDBBR, 0);
+	rsnd_mod_write(mod, MIX_MDBCR, 0);
+	rsnd_mod_write(mod, MIX_MDBDR, 0);
+}
+
+static void rsnd_mix_volume_init(struct rsnd_dai_stream *io,
+				 struct rsnd_mod *mod)
+{
+	rsnd_mod_write(mod, MIX_MIXIR, 1);
+
+	/* General Information */
+	rsnd_mod_write(mod, MIX_ADINR, rsnd_get_adinr_chan(mod, io));
+
+	/* volume step */
+	rsnd_mod_write(mod, MIX_MIXMR, 0);
+	rsnd_mod_write(mod, MIX_MVPDR, 0);
+
+	/* common volume parameter */
+	rsnd_mix_volume_parameter(io, mod);
+
+	rsnd_mod_write(mod, MIX_MIXIR, 0);
 }
 
 static void rsnd_mix_volume_update(struct rsnd_dai_stream *io,
 				  struct rsnd_mod *mod)
 {
-
 	/* Disable MIX dB setting */
 	rsnd_mod_write(mod, MIX_MDBER, 0);
 
-	rsnd_mod_write(mod, MIX_MDBAR, 0);
-	rsnd_mod_write(mod, MIX_MDBBR, 0);
-	rsnd_mod_write(mod, MIX_MDBCR, 0);
-	rsnd_mod_write(mod, MIX_MDBDR, 0);
+	/* common volume parameter */
+	rsnd_mix_volume_parameter(io, mod);
 
 	/* Enable MIX dB setting */
 	rsnd_mod_write(mod, MIX_MDBER, 1);
@@ -69,18 +86,10 @@ static int rsnd_mix_init(struct rsnd_mod *mod,
 
 	rsnd_mix_soft_reset(mod);
 
-	rsnd_mix_initialize_lock(mod);
-
-	rsnd_mod_write(mod, MIX_ADINR, rsnd_get_adinr_chan(mod, io));
-
-	/* volume step */
-	rsnd_mod_write(mod, MIX_MIXMR, 0);
-	rsnd_mod_write(mod, MIX_MVPDR, 0);
+	rsnd_mix_volume_init(io, mod);
 
 	rsnd_mix_volume_update(io, mod);
 
-	rsnd_mix_initialize_unlock(mod);
-
 	return 0;
 }
 
-- 
2.6.1
