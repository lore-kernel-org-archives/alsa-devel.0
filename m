From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove mismatch explain comment from src.c" to the asoc tree
Date: Wed, 17 May 2017 10:52:21 +0100
Message-ID: <E1dAvcz-0006r0-4K@debutante>
References: <87tw4mj37h.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87tw4mj37h.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove mismatch explain comment from src.c

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

>From 607ee05828dadfb1e65ea8d0db3c0728c6fab0df Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 May 2017 01:57:52 +0000
Subject: [PATCH] ASoC: rsnd: remove mismatch explain comment from src.c

Before, src.c cares SRC and SSIU, but now SSIU is cared by ssiu.c by
commit c7f69ab5364d ("ASoC: rsnd: use mod base common method on SSIU").
This patch removes mismatched explanation for SRC/SSIU from src.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index a8ab26d70a8b..e4bde0c8d93a 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -51,20 +51,6 @@ struct rsnd_src {
  *
  */
 
-/*
- * src.c is caring...
- *
- * Gen1
- *
- * [mem] -> [SRU] -> [SSI]
- *        |--------|
- *
- * Gen2
- *
- * [mem] -> [SRC] -> [SSIU] -> [SSI]
- *        |-----------------|
- */
-
 static void rsnd_src_activation(struct rsnd_mod *mod)
 {
 	rsnd_mod_write(mod, SRC_SWRSR, 0);
-- 
2.11.0
