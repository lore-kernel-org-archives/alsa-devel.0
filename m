From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup void* cast for 64bit
	compiler" to the asoc tree
Date: Fri, 20 Nov 2015 18:20:22 +0000
Message-ID: <E1ZzqII-0003t0-9z@debutante>
References: <87io4yipws.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C180426666F
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:20:30 +0100 (CET)
In-Reply-To: <87io4yipws.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup void* cast for 64bit compiler

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

>From c51eb1c66e55bf23af4a10dd6e71c5a82c0e6d81 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Nov 2015 04:22:56 +0000
Subject: [PATCH] ASoC: rsnd: tidyup void* cast for 64bit compiler

64bit compiler indicates this without this patch

linux/sound/soc/sh/rcar/core.c: In function 'rsnd_probe':
linux/sound/soc/sh/rcar/core.c:1002:16: warning: cast from pointer to\
     integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 +-
 sound/soc/sh/rcar/rsnd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 8dceae4b731a..81a6bdb6848c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -999,7 +999,7 @@ static int rsnd_probe(struct platform_device *pdev)
 	}
 
 	priv->pdev	= pdev;
-	priv->flags	= (u32)of_id->data;
+	priv->flags	= (unsigned long)of_id->data;
 	spin_lock_init(&priv->lock);
 
 	/*
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ae69670c5c0c..42d2ac5cb0d1 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -379,7 +379,7 @@ struct rsnd_priv {
 
 	struct platform_device *pdev;
 	spinlock_t lock;
-	u32 flags;
+	unsigned long flags;
 #define RSND_GEN_MASK	(0xF << 0)
 #define RSND_GEN1	(1 << 0)
 #define RSND_GEN2	(2 << 0)
-- 
2.6.2
