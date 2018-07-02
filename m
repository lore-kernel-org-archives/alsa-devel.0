From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dapm: convert to SPDX identifiers"
	to the asoc tree
Date: Mon, 02 Jul 2018 11:10:34 +0100
Message-ID: <E1fZvn0-0006Tr-LF@debutante>
References: <87a7raf9c6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C679B2677CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:06 +0200 (CEST)
In-Reply-To: <87a7raf9c6.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-dapm: convert to SPDX identifiers

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

>From c01f3af4d32071915119ffcb933e75d7c165378e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:24:31 +0000
Subject: [PATCH] ASoC: soc-dapm: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h | 11 ++++-------
 sound/soc/soc-dapm.c     | 42 +++++++++++++++++-----------------------
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a6ce2de4e20a..af9ef16cc34d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * linux/sound/soc-dapm.h -- ALSA SoC Dynamic Audio Power Management
  *
- * Author:		Liam Girdwood
- * Created:		Aug 11th 2005
+ * Author:	Liam Girdwood
+ * Created:	Aug 11th 2005
  * Copyright:	Wolfson Microelectronics. PLC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __LINUX_SND_SOC_DAPM_H
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a099c3e45504..0602b2888d52 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1,27 +1,21 @@
-/*
- * soc-dapm.c  --  ALSA SoC Dynamic Audio Power Management
- *
- * Copyright 2005 Wolfson Microelectronics PLC.
- * Author: Liam Girdwood <lrg@slimlogic.co.uk>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  Features:
- *    o Changes power status of internal codec blocks depending on the
- *      dynamic configuration of codec internal audio paths and active
- *      DACs/ADCs.
- *    o Platform power domain - can support external components i.e. amps and
- *      mic/headphone insertion events.
- *    o Automatic Mic Bias support
- *    o Jack insertion power event initiation - e.g. hp insertion will enable
- *      sinks, dacs, etc
- *    o Delayed power down of audio subsystem to reduce pops between a quick
- *      device reopen.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// soc-dapm.c  --  ALSA SoC Dynamic Audio Power Management
+//
+// Copyright 2005 Wolfson Microelectronics PLC.
+// Author: Liam Girdwood <lrg@slimlogic.co.uk>
+//
+//  Features:
+//    o Changes power status of internal codec blocks depending on the
+//      dynamic configuration of codec internal audio paths and active
+//      DACs/ADCs.
+//    o Platform power domain - can support external components i.e. amps and
+//      mic/headphone insertion events.
+//    o Automatic Mic Bias support
+//    o Jack insertion power event initiation - e.g. hp insertion will enable
+//      sinks, dacs, etc
+//    o Delayed power down of audio subsystem to reduce pops between a quick
+//      device reopen.
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.18.0.rc2
