From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsi: convert to SPDX identifiers" to
	the asoc tree
Date: Mon, 18 Jun 2018 13:00:48 +0100
Message-ID: <E1fUsq0-0000RG-5b@debutante>
References: <871sdcsg9s.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD3B2676DC
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:50 +0200 (CEST)
In-Reply-To: <871sdcsg9s.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsi: convert to SPDX identifiers

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

>From 134c875bff58ac988c64a1ea2a337acba1711d4b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:56:51 +0000
Subject: [PATCH] ASoC: fsi: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 3bae06dd121f..aa7e902f0c02 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1,16 +1,12 @@
-/*
- * Fifo-attached Serial Interface (FSI) support for SH7724
- *
- * Copyright (C) 2009 Renesas Solutions Corp.
- * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * Based on ssi.c
- * Copyright (c) 2007 Manuel Lauss <mano@roarinelk.homelinux.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Fifo-attached Serial Interface (FSI) support for SH7724
+//
+// Copyright (C) 2009 Renesas Solutions Corp.
+// Kuninori Morimoto <morimoto.kuninori@renesas.com>
+//
+// Based on ssi.c
+// Copyright (c) 2007 Manuel Lauss <mano@roarinelk.homelinux.net>
 
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-- 
2.17.1
