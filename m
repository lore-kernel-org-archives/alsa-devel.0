From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup semantics of
	rsnd_src_record_error()" to the asoc tree
Date: Fri, 27 Nov 2015 12:55:42 +0000
Message-ID: <E1a2IYw-0005r4-EU@debutante>
References: <87a8q1c91t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 15C03261B31
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2015 13:55:47 +0100 (CET)
In-Reply-To: <87a8q1c91t.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup semantics of rsnd_src_record_error()

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

>From 8cc225f713a42eab098d51a4353998db979f0f8a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 26 Nov 2015 11:11:03 +0000
Subject: [PATCH] ASoC: rsnd: tidyup semantics of rsnd_src_record_error()

rsnd_src_error_record() should recorde error, but it clears error too.
this patch fixes up semantic of rsnd_src_error_record that it records
error but doesn't clear error.
And this patch renames
rsnd_src_error_clear()  to rsnd_src_status_clear()
rsnd_src_error_record() to rsnd_src_record_error()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index c103aa775e96..6d93c4ed8275 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -300,7 +300,7 @@ static void rsnd_src_irq_ctrol(struct rsnd_mod *mod, int enable)
 	rsnd_mod_bset(mod, SCU_SYS_INT_EN1, sys_int_mask, sys_int_val);
 }
 
-static void rsnd_src_error_clear(struct rsnd_mod *mod)
+static void rsnd_src_status_clear(struct rsnd_mod *mod)
 {
 	u32 val = OUF_SRC(rsnd_mod_id(mod));
 
@@ -308,7 +308,7 @@ static void rsnd_src_error_clear(struct rsnd_mod *mod)
 	rsnd_mod_bset(mod, SCU_SYS_STATUS1, val, val);
 }
 
-static bool rsnd_src_error_record(struct rsnd_mod *mod)
+static bool rsnd_src_record_error(struct rsnd_mod *mod)
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	u32 val0, val1;
@@ -332,9 +332,6 @@ static bool rsnd_src_error_record(struct rsnd_mod *mod)
 		ret = true;
 	}
 
-	/* clear error static */
-	rsnd_src_error_clear(mod);
-
 	return ret;
 }
 
@@ -383,7 +380,7 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 
 	rsnd_src_set_convert_rate(io, mod);
 
-	rsnd_src_error_clear(mod);
+	rsnd_src_status_clear(mod);
 
 	rsnd_src_irq_enable(mod);
 
@@ -434,7 +431,7 @@ static void __rsnd_src_interrupt(struct rsnd_mod *mod,
 	if (!rsnd_io_is_working(io))
 		goto rsnd_src_interrupt_out;
 
-	if (rsnd_src_error_record(mod)) {
+	if (rsnd_src_record_error(mod)) {
 
 		dev_dbg(dev, "%s[%d] restart\n",
 			rsnd_mod_name(mod), rsnd_mod_id(mod));
@@ -450,7 +447,9 @@ static void __rsnd_src_interrupt(struct rsnd_mod *mod,
 			 rsnd_mod_name(mod), rsnd_mod_id(mod));
 	}
 
+	rsnd_src_status_clear(mod);
 rsnd_src_interrupt_out:
+
 	spin_unlock(&priv->lock);
 }
 
-- 
2.6.2
