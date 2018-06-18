From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssi: convert to SPDX identifiers" to
	the asoc tree
Date: Mon, 18 Jun 2018 13:00:43 +0100
Message-ID: <E1fUspv-0000Pb-Sc@debutante>
References: <87wov4r1ns.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB22267786
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:46 +0200 (CEST)
In-Reply-To: <87wov4r1ns.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ssi: convert to SPDX identifiers

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

>From 217bc8c898b24fa2098a375a575f6170cfac45a9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:57:47 +0000
Subject: [PATCH] ASoC: ssi: convert to SPDX identifiers

Tidyup incoherence between MODULE_LICENSE and header license, too

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/ssi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 89ed1b107ac5..8125fa3840b6 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -1,14 +1,11 @@
-/*
- * Serial Sound Interface (I2S) support for SH7760/SH7780
- *
- * Copyright (c) 2007 Manuel Lauss <mano@roarinelk.homelinux.net>
- *
- *  licensed under the terms outlined in the file COPYING at the root
- *  of the linux kernel sources.
- *
- * dont forget to set IPSEL/OMSEL register bits (in your board code) to
- * enable SSI output pins!
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Serial Sound Interface (I2S) support for SH7760/SH7780
+//
+// Copyright (c) 2007 Manuel Lauss <mano@roarinelk.homelinux.net>
+//
+// dont forget to set IPSEL/OMSEL register bits (in your board code) to
+// enable SSI output pins!
 
 /*
  * LIMITATIONS:
@@ -400,6 +397,6 @@ static struct platform_driver sh4_ssi_driver = {
 
 module_platform_driver(sh4_ssi_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("SuperH onchip SSI (I2S) audio driver");
 MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
2.17.1
