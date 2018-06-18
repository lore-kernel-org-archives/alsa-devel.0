From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh7760-ac97: convert to SPDX
	identifiers" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:33 +0100
Message-ID: <E1fUspl-0000Ke-1b@debutante>
References: <87po0wr1l0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 60016267759
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:35 +0200 (CEST)
In-Reply-To: <87po0wr1l0.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh7760-ac97: convert to SPDX identifiers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 04433977b164c8ed0b65cd023c87c74da0fff2bf Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:59:27 +0000
Subject: [PATCH] ASoC: sh7760-ac97: convert to SPDX identifiers

Tidyup incoherence between MODULE_LICENSE and header license, too

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/sh7760-ac97.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index 4a3568a9bf59..4bb4c13cf860 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -1,10 +1,8 @@
-/*
- * Generic AC97 sound support for SH7760
- *
- * (c) 2007 Manuel Lauss
- *
- * Licensed under the GPLv2.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Generic AC97 sound support for SH7760
+//
+// (c) 2007 Manuel Lauss
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -68,6 +66,6 @@ static void __exit sh7760_ac97_exit(void)
 module_init(sh7760_ac97_init);
 module_exit(sh7760_ac97_exit);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Generic SH7760 AC97 sound machine");
 MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
2.17.1
