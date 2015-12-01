From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup wrong snd_soc_dai_driver
	pointer access" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:49 +0000
Message-ID: <E1a3ttl-0006dg-Iz@debutante>
References: <87d1uqy3lf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C9526645C
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:55 +0100 (CET)
In-Reply-To: <87d1uqy3lf.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup wrong snd_soc_dai_driver pointer access

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

>From 2ff2ecca06d5302782c73626b841a509a9b01ef6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 1 Dec 2015 08:31:38 +0000
Subject: [PATCH] ASoC: rsnd: fixup wrong snd_soc_dai_driver pointer access

drv pointer should be "base + offset" instead of
"current + offset". This patch fixup this issue, otherwise
third and subsequent pointer will be broken

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index b187a8927e29..f1d7af114a31 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -603,7 +603,7 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	struct device_node *playback, *capture;
 	struct rsnd_dai_stream *io_playback;
 	struct rsnd_dai_stream *io_capture;
-	struct snd_soc_dai_driver *drv;
+	struct snd_soc_dai_driver *rdrv, *drv;
 	struct rsnd_dai *rdai;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	int nr, dai_i, io_i, np_i;
@@ -616,15 +616,15 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 		goto rsnd_dai_probe_done;
 	}
 
-	drv  = devm_kzalloc(dev, sizeof(*drv)  * nr, GFP_KERNEL);
+	rdrv = devm_kzalloc(dev, sizeof(*rdrv) * nr, GFP_KERNEL);
 	rdai = devm_kzalloc(dev, sizeof(*rdai) * nr, GFP_KERNEL);
-	if (!drv || !rdai) {
+	if (!rdrv || !rdai) {
 		ret = -ENOMEM;
 		goto rsnd_dai_probe_done;
 	}
 
 	priv->rdai_nr	= nr;
-	priv->daidrv	= drv;
+	priv->daidrv	= rdrv;
 	priv->rdai	= rdai;
 
 	/*
@@ -633,7 +633,7 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	dai_i = 0;
 	for_each_child_of_node(dai_node, dai_np) {
 		rdai		= rsnd_rdai_get(priv, dai_i);
-		drv		= drv + dai_i;
+		drv		= rdrv + dai_i;
 		io_playback	= &rdai->playback;
 		io_capture	= &rdai->capture;
 
-- 
2.6.2
