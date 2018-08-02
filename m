From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsi: convert to SPDX identifiers" to
	the asoc tree
Date: Thu,  2 Aug 2018 11:10:17 +0100 (BST)
Message-ID: <20180802101017.279DC1124241@debutante.sirena.org.uk>
References: <877el9ee9a.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CD442677BC
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 12:10:18 +0200 (CEST)
In-Reply-To: <877el9ee9a.wl-kuninori.morimoto.gx@renesas.com>
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

>From fdec79c18b08c68cfa079f2d3ee23c5a120a2eda Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 2 Aug 2018 01:47:30 +0000
Subject: [PATCH] ASoC: fsi: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sh_fsi.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/sound/sh_fsi.h b/include/sound/sh_fsi.h
index 7a9710b4b799..89eafe23ef88 100644
--- a/include/sound/sh_fsi.h
+++ b/include/sound/sh_fsi.h
@@ -1,16 +1,13 @@
-#ifndef __SOUND_FSI_H
-#define __SOUND_FSI_H
-
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Fifo-attached Serial Interface (FSI) support for SH7724
  *
  * Copyright (C) 2009 Renesas Solutions Corp.
  * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
+#ifndef __SOUND_FSI_H
+#define __SOUND_FSI_H
+
 #include <linux/clk.h>
 #include <sound/soc.h>
 
-- 
2.18.0
