From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card.c: convert to SPDX
	identifiers" to the asoc tree
Date: Mon, 02 Jul 2018 11:11:57 +0100
Message-ID: <E1fZvoL-0006ea-IV@debutante>
References: <87va9ydug0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CBBDF2677A1
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:58:55 +0200 (CEST)
In-Reply-To: <87va9ydug0.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-scu-card.c: convert to SPDX identifiers

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

>From ac204c9b030fe2d27cf3a63386811254d99b3ce4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:31:33 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card.c: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 25 +++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index 095ef6426d42..92882e392d6c 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -1,17 +1,14 @@
-/*
- * ASoC audio graph SCU sound card support
- *
- * Copyright (C) 2017 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * based on
- *	${LINUX}/sound/soc/generic/simple-scu-card.c
- *	${LINUX}/sound/soc/generic/audio-graph-card.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// ASoC audio graph SCU sound card support
+//
+// Copyright (C) 2017 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+//
+// based on
+//	${LINUX}/sound/soc/generic/simple-scu-card.c
+//	${LINUX}/sound/soc/generic/audio-graph-card.c
+
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
-- 
2.18.0.rc2
