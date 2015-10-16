From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Gen1 probe is not error" to the
	asoc tree
Date: Fri, 16 Oct 2015 17:41:09 +0100
Message-ID: <E1Zn845-000879-Kj@debutante>
References: <87mvvkom0t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E6F8260517
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 18:41:22 +0200 (CEST)
In-Reply-To: <87mvvkom0t.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: Gen1 probe is not error

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

>From 8a98b4223d0eab88bba5eb215b275da4ff6ed99c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Oct 2015 03:25:28 +0000
Subject: [PATCH] ASoC: rsnd: Gen1 probe is not error

Probing from Gen1 is not error. This patch fixup it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c | 6 ++----
 sound/soc/sh/rcar/dvc.c | 6 ++----
 sound/soc/sh/rcar/mix.c | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index a3e7c716e1f7..f1541f464f30 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -118,10 +118,8 @@ int rsnd_ctu_probe(struct platform_device *pdev,
 	int i, nr, ret;
 
 	/* This driver doesn't support Gen1 at this point */
-	if (rsnd_is_gen1(priv)) {
-		dev_warn(dev, "CTU is not supported on Gen1\n");
-		return -EINVAL;
-	}
+	if (rsnd_is_gen1(priv))
+		return 0;
 
 	rsnd_of_parse_ctu(pdev, of_data, priv);
 
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 8d8eee6350c9..e36c0ac3374b 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -333,10 +333,8 @@ int rsnd_dvc_probe(struct platform_device *pdev,
 	int i, nr, ret;
 
 	/* This driver doesn't support Gen1 at this point */
-	if (rsnd_is_gen1(priv)) {
-		dev_warn(dev, "CMD is not supported on Gen1\n");
-		return -EINVAL;
-	}
+	if (rsnd_is_gen1(priv))
+		return 0;
 
 	rsnd_of_parse_dvc(pdev, of_data, priv);
 
diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index 8544403ffb26..ac2687d9ee55 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -151,10 +151,8 @@ int rsnd_mix_probe(struct platform_device *pdev,
 	int i, nr, ret;
 
 	/* This driver doesn't support Gen1 at this point */
-	if (rsnd_is_gen1(priv)) {
-		dev_warn(dev, "MIX is not supported on Gen1\n");
-		return -EINVAL;
-	}
+	if (rsnd_is_gen1(priv))
+		return 0;
 
 	rsnd_of_parse_mix(pdev, of_data, priv);
 
-- 
2.6.1
