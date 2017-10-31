From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup rsnd_mod_next() for loop
	method" to the asoc tree
Date: Tue, 31 Oct 2017 11:21:42 +0000
Message-ID: <E1e9Uc2-0002qG-E9@debutante>
References: <87y3nsxipb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DF3622672A0
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 12:21:45 +0100 (CET)
In-Reply-To: <87y3nsxipb.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup rsnd_mod_next() for loop method

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

>From b12f1e3a798e19727ca632d92abe619b418ad0d0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 Oct 2017 00:38:36 +0000
Subject: [PATCH] ASoC: rsnd: tidyup rsnd_mod_next() for loop method

Let's remove point less "continue"

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index b338c0009506..8fc3bf2b20f5 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -408,10 +408,8 @@ struct rsnd_mod *rsnd_mod_next(int *iterator,
 	for (; *iterator < max; (*iterator)++) {
 		type = (array) ? array[*iterator] : *iterator;
 		mod = rsnd_io_to_mod(io, type);
-		if (!mod)
-			continue;
-
-		return mod;
+		if (mod)
+			return mod;
 	}
 
 	return NULL;
-- 
2.15.0.rc2
