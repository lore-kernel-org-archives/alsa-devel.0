From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add workaround for SRC sync
	convert + DVC" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:35 +0100
Message-ID: <E1ZFqRL-0002nv-Ui@finisterre>
References: <87zj2xvqz4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71BE226683E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:41 +0200 (CEST)
In-Reply-To: <87zj2xvqz4.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add workaround for SRC sync convert + DVC

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

>From 1a1bf58aafd09b3cb148eead3d709e2d7974a1f3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:10:22 +0000
Subject: [PATCH] ASoC: rsnd: add workaround for SRC sync convert + DVC

We couldn't use SRC sync convert mode together with DVC,
but we can use workaround for it.
This patch adds workaround and can use SRC sync convert + DVC

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 9e11f73..38d0aba 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -616,6 +616,14 @@ static void rsnd_src_irq_ctrol_gen2(struct rsnd_mod *mod, int enable)
 		int_val = 0;
 	}
 
+	/*
+	 * WORKAROUND
+	 *
+	 * ignore over flow error when rsnd_enable_sync_convert()
+	 */
+	if (rsnd_enable_sync_convert(src))
+		sys_int_val = sys_int_val & 0xffff;
+
 	rsnd_mod_write(mod, SRC_INT_ENABLE0, int_val);
 	rsnd_mod_bset(mod, SCU_SYS_INT_EN0, sys_int_mask, sys_int_val);
 	rsnd_mod_bset(mod, SCU_SYS_INT_EN1, sys_int_mask, sys_int_val);
@@ -631,11 +639,22 @@ static void rsnd_src_error_clear_gen2(struct rsnd_mod *mod)
 
 static bool rsnd_src_error_record_gen2(struct rsnd_mod *mod)
 {
-	u32 val = OUF_SRC(rsnd_mod_id(mod));
+	struct rsnd_src *src = rsnd_mod_to_src(mod);
+	u32 val0, val1;
 	bool ret = false;
 
-	if ((rsnd_mod_read(mod, SCU_SYS_STATUS0) & val) ||
-	    (rsnd_mod_read(mod, SCU_SYS_STATUS1) & val)) {
+	val0 = val1 = OUF_SRC(rsnd_mod_id(mod));
+
+	/*
+	 * WORKAROUND
+	 *
+	 * ignore over flow error when rsnd_enable_sync_convert()
+	 */
+	if (rsnd_enable_sync_convert(src))
+		val0 = val0 & 0xffff;
+
+	if ((rsnd_mod_read(mod, SCU_SYS_STATUS0) & val0) ||
+	    (rsnd_mod_read(mod, SCU_SYS_STATUS1) & val1)) {
 		struct rsnd_src *src = rsnd_mod_to_src(mod);
 
 		src->err++;
@@ -651,7 +670,16 @@ static bool rsnd_src_error_record_gen2(struct rsnd_mod *mod)
 static int _rsnd_src_start_gen2(struct rsnd_mod *mod,
 				struct rsnd_dai_stream *io)
 {
-	u32 val = rsnd_io_to_mod_dvc(io) ? 0x01 : 0x11;
+	struct rsnd_src *src = rsnd_mod_to_src(mod);
+	u32 val;
+
+	/*
+	 * WORKAROUND
+	 *
+	 * Enable SRC output if you want to use sync convert together with DVC
+	 */
+	val = (rsnd_io_to_mod_dvc(io) && !rsnd_enable_sync_convert(src)) ?
+		0x01 : 0x11;
 
 	rsnd_mod_write(mod, SRC_CTRL, val);
 
@@ -921,13 +949,6 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 		return 0;
 
 	/*
-	 * We can't use SRC sync convert
-	 * if it has DVC
-	 */
-	if (rsnd_io_to_mod_dvc(io))
-		return 0;
-
-	/*
 	 * enable sync convert
 	 */
 	ret = rsnd_kctrl_new_s(mod, io, rtd,
-- 
2.1.4
