From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: convert to SPDX
	identifiers" to the asoc tree
Date: Mon, 02 Jul 2018 11:12:06 +0100
Message-ID: <E1fZvoU-0006hx-Dm@debutante>
References: <871scmf929.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 389CE267214
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:58:51 +0200 (CEST)
In-Reply-To: <871scmf929.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: convert to SPDX identifiers

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

>From d573454d9b4f00061da314460908e19476d2ff6d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:30:28 +0000
Subject: [PATCH] ASoC: simple-card: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card.h     |  7 ++-----
 sound/soc/generic/simple-card.c | 17 +++++++----------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index a6a2e1547092..d264e5463f22 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * ASoC simple sound card support
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
  * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __SIMPLE_CARD_H
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c5b6e04cd926..64bf3560c1d1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -1,13 +1,10 @@
-/*
- * ASoC simple sound card support
- *
- * Copyright (C) 2012 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// ASoC simple sound card support
+//
+// Copyright (C) 2012 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/module.h>
-- 
2.18.0.rc2
