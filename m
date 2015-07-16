From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove unnecessary 'out of
	memory' message from SSI" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:45 +0100
Message-ID: <E1ZFqRV-0002qj-2M@finisterre>
References: <878uahx5mv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1501B266828
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:51 +0200 (CEST)
In-Reply-To: <878uahx5mv.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove unnecessary 'out of memory' message from SSI

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

>From afa700729646761f58cc068d86a37e09a70e4cf6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:08:24 +0000
Subject: [PATCH] ASoC: rsnd: remove unnecessary 'out of memory' message from
 SSI

Current checkpatch.pl indicates 'out of memory' message is unnecessary.
Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 2fbe59f..d45b9a7 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -770,10 +770,8 @@ int rsnd_ssi_probe(struct platform_device *pdev,
 	 */
 	nr	= info->ssi_info_nr;
 	ssi	= devm_kzalloc(dev, sizeof(*ssi) * nr, GFP_KERNEL);
-	if (!ssi) {
-		dev_err(dev, "SSI allocate failed\n");
+	if (!ssi)
 		return -ENOMEM;
-	}
 
 	priv->ssi	= ssi;
 	priv->ssi_nr	= nr;
-- 
2.1.4
