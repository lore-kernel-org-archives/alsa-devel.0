From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup debug print position on
	rsnd_dma_attach()" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:28 +0000
Message-ID: <E1a9twW-00065y-9S@debutante>
References: <87a8p9iy5b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 869A52665C2
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:34 +0100 (CET)
In-Reply-To: <87a8p9iy5b.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup debug print position on rsnd_dma_attach()

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

>From c90269c1fbfcb3082d379237f0912ea231e90a24 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:56:11 +0000
Subject: [PATCH] ASoC: rsnd: tidyup debug print position on rsnd_dma_attach()

It can't output corrent dma name *before* rsnd_mod_init().
It goes to *after* rsnd_mod_init() by this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 33eb37331498..418e6fdd06a3 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -680,16 +680,16 @@ struct rsnd_mod *rsnd_dma_attach(struct rsnd_dai_stream *io,
 
 	dma_mod = rsnd_mod_get(dma);
 
-	dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
-		rsnd_mod_name(dma_mod), rsnd_mod_id(dma_mod),
-		rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
-		rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
-
 	ret = rsnd_mod_init(priv, dma_mod,
 			    ops, NULL, type, dma_id);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
+	dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
+		rsnd_mod_name(dma_mod), rsnd_mod_id(dma_mod),
+		rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
+		rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
+
 	ret = attach(io, dma, id, mod_from, mod_to);
 	if (ret < 0)
 		return ERR_PTR(ret);
-- 
2.6.2
