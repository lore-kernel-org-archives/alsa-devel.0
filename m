From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai.h: convert to SPDX identifiers"
	to the asoc tree
Date: Mon, 02 Jul 2018 11:11:53 +0100
Message-ID: <E1fZvoH-0006cy-7N@debutante>
References: <87muvaf9fz.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CFD62677A1
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:58:58 +0200 (CEST)
In-Reply-To: <87muvaf9fz.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-dai.h: convert to SPDX identifiers

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

>From e2cfd2c9673f4e9d08971fed53fe1f41d8270ef0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:22:15 +0000
Subject: [PATCH] ASoC: soc-dai.h: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index e6f8c40ed43c..a14bc0608ae9 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * linux/sound/soc-dai.h -- ALSA SoC Layer
  *
  * Copyright:	2005-2008 Wolfson Microelectronics. PLC.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Digital Audio Interface (DAI) API.
  */
 
-- 
2.18.0.rc2
