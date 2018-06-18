From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dma-sh7760: convert to SPDX
	identifiers" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:35 +0100
Message-ID: <E1fUspn-0000LU-6u@debutante>
References: <87r2lcr1lg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8459F2676DC
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:37 +0200 (CEST)
In-Reply-To: <87r2lcr1lg.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: dma-sh7760: convert to SPDX identifiers

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

>From ddfe227c0cbfb97b37afe123e014b9bc4df217b5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:59:11 +0000
Subject: [PATCH] ASoC: dma-sh7760: convert to SPDX identifiers

Tidyup incoherence between MODULE_LICENSE and header license, too

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/dma-sh7760.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 2dc3b762fdd9..922fb6aa3ed1 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -1,16 +1,14 @@
-/*
- * SH7760 ("camelot") DMABRG audio DMA unit support
- *
- * Copyright (C) 2007 Manuel Lauss <mano@roarinelk.homelinux.net>
- *  licensed under the terms outlined in the file COPYING at the root
- *  of the linux kernel sources.
- *
- * The SH7760 DMABRG provides 4 dma channels (2x rec, 2x play), which
- * trigger an interrupt when one half of the programmed transfer size
- * has been xmitted.
- *
- * FIXME: little-endian only for now
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// SH7760 ("camelot") DMABRG audio DMA unit support
+//
+// Copyright (C) 2007 Manuel Lauss <mano@roarinelk.homelinux.net>
+//
+// The SH7760 DMABRG provides 4 dma channels (2x rec, 2x play), which
+// trigger an interrupt when one half of the programmed transfer size
+// has been xmitted.
+//
+// FIXME: little-endian only for now
 
 #include <linux/module.h>
 #include <linux/gfp.h>
@@ -341,6 +339,6 @@ static struct platform_driver sh7760_pcm_driver = {
 
 module_platform_driver(sh7760_pcm_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("SH7760 Audio DMA (DMABRG) driver");
 MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
2.17.1
