From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: disable SRC.out/in in same time"
	to the asoc tree
Date: Fri, 22 Jan 2016 18:26:38 +0000
Message-ID: <E1aMgPu-00044l-FL@debutante>
References: <8760yn4rvu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B49872605CA
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:47 +0100 (CET)
In-Reply-To: <8760yn4rvu.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: disable SRC.out/in in same time

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

>From 31739a689f828345a7ef52fd8dbbb200df1b6555 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 02:00:13 +0000
Subject: [PATCH] ASoC: rsnd: disable SRC.out/in in same time

commit b761bf272bce ("ASoC: rsnd: disable SRC.out only when stop timing")
disabled SRC.out/in in different timing, but was based on
picky HW information. Now, we have confirmed that we can disable
both in the same time. This patch do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 8dc9b483b5fa..7749615bd404 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -367,11 +367,7 @@ static int rsnd_src_stop(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	/*
-	 * stop SRC output only
-	 * see rsnd_src_quit
-	 */
-	rsnd_mod_write(mod, SRC_CTRL, 0x01);
+	rsnd_mod_write(mod, SRC_CTRL, 0);
 
 	return 0;
 }
@@ -409,9 +405,6 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 
 	rsnd_src_irq_disable(mod);
 
-	/* stop both out/in */
-	rsnd_mod_write(mod, SRC_CTRL, 0);
-
 	rsnd_src_halt(mod);
 
 	rsnd_mod_power_off(mod);
-- 
2.7.0.rc3
