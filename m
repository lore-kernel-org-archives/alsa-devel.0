From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: use rsnd_mod_init() for ADG" to
	the asoc tree
Date: Fri, 22 Jan 2016 18:26:50 +0000
Message-ID: <E1aMgQ6-0004B2-Dl@debutante>
References: <87oacf4s3g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B682614D1
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:54 +0100 (CET)
In-Reply-To: <87oacf4s3g.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: use rsnd_mod_init() for ADG

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

>From 7c89746eede3acbbb67f848a741f8bca412986af Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:55:39 +0000
Subject: [PATCH] ASoC: rsnd: use rsnd_mod_init() for ADG

Current ADG doesn't use rsnd_mod_init(), but this limitation is no
longer necessary. Let's use common rsnd_mod_init()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 6d3ef366d536..19f5509f908d 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -518,13 +518,8 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 		return -ENOMEM;
 	}
 
-	/*
-	 * ADG is special module.
-	 * Use ADG mod without rsnd_mod_init() to make debug easy
-	 * for rsnd_write/rsnd_read
-	 */
-	adg->mod.ops = &adg_ops;
-	adg->mod.priv = priv;
+	rsnd_mod_init(priv, &adg->mod, &adg_ops,
+		      NULL, 0, 0);
 
 	rsnd_adg_get_clkin(priv, adg);
 	rsnd_adg_get_clkout(priv, adg);
-- 
2.7.0.rc3
