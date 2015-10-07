From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Remove obsolete platform data
	support" to the asoc tree
Date: Wed, 07 Oct 2015 12:18:53 +0100
Message-ID: <E1ZjmkH-0006Ry-SP@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC52266085
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 13:19:21 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Remove obsolete platform data support

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

>From 971a41f034ce46c82f3ab7abebe14c2d1bc54e17 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 7 Oct 2015 12:42:22 +0200
Subject: [PATCH] ASoC: rsnd: Remove obsolete platform data support

Since commit 3d7608e4c169af03 ("ARM: shmobile: bockw: remove legacy
board file and config"), Renesas R-Car SoCs are only supported in
generic DT-only ARM multi-platform builds.  The driver doesn't need to
use platform data anymore, hence remove platform data configuration.

Move <sound/rcar_snd.h> to sound/soc/sh/rcar/, as it's no longer needed
by platform code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c                        | 19 +++++--------------
 {include/sound => sound/soc/sh/rcar}/rcar_snd.h |  0
 sound/soc/sh/rcar/rsnd.h                        |  3 ++-
 sound/soc/sh/rcar/ssi.c                         |  3 ---
 4 files changed, 7 insertions(+), 18 deletions(-)
 rename {include/sound => sound/soc/sh/rcar}/rcar_snd.h (100%)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f3feed5..00bf1ff 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1224,20 +1224,11 @@ static int rsnd_probe(struct platform_device *pdev)
 	};
 	int ret, i;
 
-	info = NULL;
-	of_data = NULL;
-	if (of_id) {
-		info = devm_kzalloc(&pdev->dev,
-				    sizeof(struct rcar_snd_info), GFP_KERNEL);
-		of_data = of_id->data;
-	} else {
-		info = pdev->dev.platform_data;
-	}
-
-	if (!info) {
-		dev_err(dev, "driver needs R-Car sound information\n");
-		return -ENODEV;
-	}
+	info = devm_kzalloc(&pdev->dev, sizeof(struct rcar_snd_info),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	of_data = of_id->data;
 
 	/*
 	 *	init priv data
diff --git a/include/sound/rcar_snd.h b/sound/soc/sh/rcar/rcar_snd.h
similarity index 100%
rename from include/sound/rcar_snd.h
rename to sound/soc/sh/rcar/rcar_snd.h
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 7a0e52b..f604f69 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -21,10 +21,11 @@
 #include <linux/of_irq.h>
 #include <linux/sh_dma.h>
 #include <linux/workqueue.h>
-#include <sound/rcar_snd.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
+#include "rcar_snd.h"
+
 /*
  *	pseudo register
  *
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index d45b9a7..3f5f195 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -697,9 +697,6 @@ static void rsnd_of_parse_ssi(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	int nr, i;
 
-	if (!of_data)
-		return;
-
 	node = rsnd_ssi_of_node(priv);
 	if (!node)
 		return;
-- 
2.5.0
