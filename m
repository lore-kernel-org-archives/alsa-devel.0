From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: check the Gen1 at the beginning
	of DVC probe" to the asoc tree
Date: Thu, 16 Jul 2015 22:29:52 +0100
Message-ID: <E1ZFqj2-0004hO-Sm@finisterre>
References: <87d1ztvqq6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 538142666A8
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:29:57 +0200 (CEST)
In-Reply-To: <87d1ztvqq6.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: check the Gen1 at the beginning of DVC probe

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

>From 9469b8b6092d347ef8a5fa9d2d7dde4c857a0994 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:15:47 +0000
Subject: [PATCH] ASoC: rsnd: check the Gen1 at the beginning of DVC probe

DVC doesn't support Gen1, check it beginning of probe

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index d06e4ee..5779638 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -332,18 +332,18 @@ int rsnd_dvc_probe(struct platform_device *pdev,
 	char name[RSND_DVC_NAME_SIZE];
 	int i, nr, ret;
 
-	rsnd_of_parse_dvc(pdev, of_data, priv);
-
-	nr = info->dvc_info_nr;
-	if (!nr)
-		return 0;
-
 	/* This driver doesn't support Gen1 at this point */
 	if (rsnd_is_gen1(priv)) {
 		dev_warn(dev, "CMD is not supported on Gen1\n");
 		return -EINVAL;
 	}
 
+	rsnd_of_parse_dvc(pdev, of_data, priv);
+
+	nr = info->dvc_info_nr;
+	if (!nr)
+		return 0;
+
 	dvc	= devm_kzalloc(dev, sizeof(*dvc) * nr, GFP_KERNEL);
 	if (!dvc)
 		return -ENOMEM;
-- 
2.1.4
