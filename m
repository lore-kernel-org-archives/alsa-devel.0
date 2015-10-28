From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: call rsnd_src_quit() from
	rsnd_src_quit_gen2()" to the asoc tree
Date: Wed, 28 Oct 2015 13:57:54 +0900
Message-ID: <E1ZrIo6-00043D-LJ@finisterre>
References: <87vb9r8vs3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF4EF265900
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 05:58:05 +0100 (CET)
In-Reply-To: <87vb9r8vs3.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: call rsnd_src_quit() from rsnd_src_quit_gen2()

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

>From 7b0beb13bc31693ede4f6b4a3f24c451b74118ac Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Oct 2015 04:30:11 +0000
Subject: [PATCH] ASoC: rsnd: call rsnd_src_quit() from rsnd_src_quit_gen2()

2d604e03("ASoC: rsnd: disable SRC.out only when stop timing")
added rsnd_src_quit_gen2(), but it should call rsnd_src_quit()
same as before. This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index a710799c..776b0ef 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -621,7 +621,7 @@ static int rsnd_src_quit_gen2(struct rsnd_mod *mod,
 	/* stop both out/in */
 	rsnd_mod_write(mod, SRC_CTRL, 0);
 
-	return 0;
+	return rsnd_src_quit(mod, io, priv);
 }
 
 static void __rsnd_src_interrupt_gen2(struct rsnd_mod *mod,
-- 
2.6.1
