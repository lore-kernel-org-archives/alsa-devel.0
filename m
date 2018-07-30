From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7210: convert to SPDX identifiers" to
	the asoc tree
Date: Mon, 30 Jul 2018 12:03:56 +0100 (BST)
Message-ID: <20180730110356.E462F1124216@debutante.sirena.org.uk>
References: <87lg9tkvws.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5213B26779F
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 13:03:57 +0200 (CEST)
In-Reply-To: <87lg9tkvws.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: da7210: convert to SPDX identifiers

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

>From c0ca5604d43233b0f5cfb793be9638af21f5535d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Jul 2018 07:52:46 +0000
Subject: [PATCH] ASoC: da7210: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7210.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index a664111b7184..e172913d04a4 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1,19 +1,14 @@
-/*
- * DA7210 ALSA Soc codec driver
- *
- * Copyright (c) 2009 Dialog Semiconductor
- * Written by David Chen <Dajun.chen@diasemi.com>
- *
- * Copyright (C) 2009 Renesas Solutions Corp.
- * Cleanups by Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * Tested on SuperH Ecovec24 board with S16/S24 LE in 48KHz using I2S
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// DA7210 ALSA Soc codec driver
+//
+// Copyright (c) 2009 Dialog Semiconductor
+// Written by David Chen <Dajun.chen@diasemi.com>
+//
+// Copyright (C) 2009 Renesas Solutions Corp.
+// Cleanups by Kuninori Morimoto <morimoto.kuninori@renesas.com>
+//
+// Tested on SuperH Ecovec24 board with S16/S24 LE in 48KHz using I2S
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
-- 
2.18.0
