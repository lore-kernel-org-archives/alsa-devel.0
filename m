From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm.c: convert to SPDX identifiers"
	to the asoc tree
Date: Mon, 02 Jul 2018 11:11:31 +0100
Message-ID: <E1fZvnv-0006ax-Gv@debutante>
References: <87k1qef9f5.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F24F2677AD
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:00 +0200 (CEST)
In-Reply-To: <87k1qef9f5.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-pcm.c: convert to SPDX identifiers

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

>From ed51758247c51dfdb526d279164cfd925496f187 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:22:44 +0000
Subject: [PATCH] ASoC: soc-pcm.c: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 6ee4131941df..c2a31b51da4f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1,20 +1,14 @@
-/*
- * soc-pcm.c  --  ALSA SoC PCM
- *
- * Copyright 2005 Wolfson Microelectronics PLC.
- * Copyright 2005 Openedhand Ltd.
- * Copyright (C) 2010 Slimlogic Ltd.
- * Copyright (C) 2010 Texas Instruments Inc.
- *
- * Authors: Liam Girdwood <lrg@ti.com>
- *          Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// soc-pcm.c  --  ALSA SoC PCM
+//
+// Copyright 2005 Wolfson Microelectronics PLC.
+// Copyright 2005 Openedhand Ltd.
+// Copyright (C) 2010 Slimlogic Ltd.
+// Copyright (C) 2010 Texas Instruments Inc.
+//
+// Authors: Liam Girdwood <lrg@ti.com>
+//          Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.18.0.rc2
