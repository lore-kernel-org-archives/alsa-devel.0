From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Delete an error message for a failed memory allocation in three functions" to the asoc tree
Date: Thu, 10 Aug 2017 16:41:57 +0100
Message-ID: <E1dfpav-0001fF-Kv@finisterre>
References: <181b6355-b6b6-eeae-d85b-9fb465d96b85@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <181b6355-b6b6-eeae-d85b-9fb465d96b85@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Fengguang Wu <fengguang.wu@intel.com>, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Marek Vasut <marek.vasut+renesas@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Delete an error message for a failed memory allocation in three functions

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

>From 0d7820d0918efa6c2a53acdfc47cbfc3b48df727 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 17:13:19 +0200
Subject: [PATCH] ASoC: rsnd: Delete an error message for a failed memory
 allocation in three functions

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c  | 4 +---
 sound/soc/sh/rcar/core.c | 4 +---
 sound/soc/sh/rcar/gen.c  | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 5b5389e5b92b..938baff86ef2 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -586,10 +586,8 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 	int ret;
 
 	adg = devm_kzalloc(dev, sizeof(*adg), GFP_KERNEL);
-	if (!adg) {
-		dev_err(dev, "ADG allocate failed\n");
+	if (!adg)
 		return -ENOMEM;
-	}
 
 	ret = rsnd_mod_init(priv, &adg->mod, &adg_ops,
 		      NULL, NULL, 0, 0);
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 2c12ad2b2b34..650cc28b0fb6 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1401,10 +1401,8 @@ static int rsnd_probe(struct platform_device *pdev)
 	 *	init priv data
 	 */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "priv allocate failed\n");
+	if (!priv)
 		return -ENODEV;
-	}
 
 	priv->pdev	= pdev;
 	priv->flags	= (unsigned long)of_device_get_match_data(dev);
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index ee00e3516911..f04c4100043a 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -406,10 +406,8 @@ int rsnd_gen_probe(struct rsnd_priv *priv)
 	int ret;
 
 	gen = devm_kzalloc(dev, sizeof(*gen), GFP_KERNEL);
-	if (!gen) {
-		dev_err(dev, "GEN allocate failed\n");
+	if (!gen)
 		return -ENOMEM;
-	}
 
 	priv->gen = gen;
 
-- 
2.13.2
