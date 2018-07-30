From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: convert to SPDX identifiers" to
	the asoc tree
Date: Mon, 30 Jul 2018 12:03:47 +0100 (BST)
Message-ID: <20180730110347.45D511124216@debutante.sirena.org.uk>
References: <87k1pdkvw6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E557B2677CD
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 13:03:47 +0200 (CEST)
In-Reply-To: <87k1pdkvw6.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ak4613: convert to SPDX identifiers

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

>From e028937c77f44bb38cdbc464afce2bf41d96006b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Jul 2018 07:53:08 +0000
Subject: [PATCH] ASoC: ak4613: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 8523ff9351cf..c1181a20714d 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -1,18 +1,14 @@
-/*
- * ak4613.c  --  Asahi Kasei ALSA Soc Audio driver
- *
- * Copyright (C) 2015 Renesas Electronics Corporation
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * Based on ak4642.c by Kuninori Morimoto
- * Based on wm8731.c by Richard Purdie
- * Based on ak4535.c by Richard Purdie
- * Based on wm8753.c by Liam Girdwood
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// ak4613.c  --  Asahi Kasei ALSA Soc Audio driver
+//
+// Copyright (C) 2015 Renesas Electronics Corporation
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+//
+// Based on ak4642.c by Kuninori Morimoto
+// Based on wm8731.c by Richard Purdie
+// Based on ak4535.c by Richard Purdie
+// Based on wm8753.c by Liam Girdwood
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.18.0
