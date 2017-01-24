From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup for_each_rsnd_mod_array{s}
	iterator increment" to the asoc tree
Date: Tue, 24 Jan 2017 18:39:27 +0000
Message-ID: <E1cW607-0006cV-72@debutante>
References: <87pojil5u4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9122B266CC1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 19:39:36 +0100 (CET)
In-Reply-To: <87pojil5u4.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hoan <na-hoan@jinso.co.jp>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup for_each_rsnd_mod_array{s} iterator increment

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

>From 90ffc1ecc500c04bf43a45d804bb151505c0d6a6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Jan 2017 04:23:29 +0000
Subject: [PATCH] ASoC: rsnd: fixup for_each_rsnd_mod_array{s} iterator
 increment

commit 5f222a292 ("ASoC: rsnd: use for_each_rsnd_mod_xxx() ...")
modifies rsnd_dai_call() to use for_each_rsnd_mod_arrays().

Current rsnd is incrementing iterator in rsnd_mod_next(),
but the iterator will indicate +1 position in for_each loop in
this case. Incremental position should be inside for()

Reported-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 --
 sound/soc/sh/rcar/rsnd.h | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 4bd68de76130..948c5ec87980 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -363,8 +363,6 @@ struct rsnd_mod *rsnd_mod_next(int *iterator,
 		if (!mod)
 			continue;
 
-		(*iterator)++;
-
 		return mod;
 	}
 
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index b90df77662df..7410ec0174db 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -374,10 +374,10 @@ struct rsnd_mod *rsnd_mod_next(int *iterator,
 			       int array_size);
 #define for_each_rsnd_mod(iterator, pos, io)				\
 	for (iterator = 0;						\
-	     (pos = rsnd_mod_next(&iterator, io, NULL, 0));)
+	     (pos = rsnd_mod_next(&iterator, io, NULL, 0)); iterator++)
 #define for_each_rsnd_mod_arrays(iterator, pos, io, array, size)	\
 	for (iterator = 0;						\
-	     (pos = rsnd_mod_next(&iterator, io, array, size));)
+	     (pos = rsnd_mod_next(&iterator, io, array, size)); iterator++)
 #define for_each_rsnd_mod_array(iterator, pos, io, array)		\
 	for_each_rsnd_mod_arrays(iterator, pos, io, array, ARRAY_SIZE(array))
 
-- 
2.11.0
