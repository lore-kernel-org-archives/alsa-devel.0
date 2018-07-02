From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-ops.c: convert to SPDX identifiers"
	to the asoc tree
Date: Mon, 02 Jul 2018 11:11:33 +0100
Message-ID: <E1fZvnx-0006bk-Lz@debutante>
References: <87lgauf9fj.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EAC126771C
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:58:59 +0200 (CEST)
In-Reply-To: <87lgauf9fj.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-ops.c: convert to SPDX identifiers

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

>From 4eef5a90ca8b2aab61c98853141f9242af4a8339 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:22:30 +0000
Subject: [PATCH] ASoC: soc-ops.c: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-ops.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 7144a51ddfa9..592efb370c44 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -1,20 +1,15 @@
-/*
- * soc-ops.c  --  Generic ASoC operations
- *
- * Copyright 2005 Wolfson Microelectronics PLC.
- * Copyright 2005 Openedhand Ltd.
- * Copyright (C) 2010 Slimlogic Ltd.
- * Copyright (C) 2010 Texas Instruments Inc.
- *
- * Author: Liam Girdwood <lrg@slimlogic.co.uk>
- *         with code, comments and ideas from :-
- *         Richard Purdie <richard@openedhand.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// soc-ops.c  --  Generic ASoC operations
+//
+// Copyright 2005 Wolfson Microelectronics PLC.
+// Copyright 2005 Openedhand Ltd.
+// Copyright (C) 2010 Slimlogic Ltd.
+// Copyright (C) 2010 Texas Instruments Inc.
+//
+// Author: Liam Girdwood <lrg@slimlogic.co.uk>
+//         with code, comments and ideas from :-
+//         Richard Purdie <richard@openedhand.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.18.0.rc2
