From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-generic-dmaengine-pcm: convert to
	SPDX identifiers" to the asoc tree
Date: Mon, 02 Jul 2018 11:10:10 +0100
Message-ID: <E1fZvmc-0006R6-IE@debutante>
References: <87601yf9b3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 240632677CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:11 +0200 (CEST)
In-Reply-To: <87601yf9b3.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-generic-dmaengine-pcm: convert to SPDX identifiers

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

>From 1356a6071cf4d7187652cd2b18dfab4763e0dba6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:25:11 +0000
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/dmaengine_pcm.h         | 14 +++-----------
 sound/soc/soc-generic-dmaengine-pcm.c | 19 +++++--------------
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index e3481eebdd98..2c4cfaa135a6 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -1,17 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  *  Copyright (C) 2012, Analog Devices Inc.
  *	Author: Lars-Peter Clausen <lars@metafoo.de>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
+
 #ifndef __SOUND_DMAENGINE_PCM_H__
 #define __SOUND_DMAENGINE_PCM_H__
 
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 56a541b9ff9e..13bdca6e41c5 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -1,17 +1,8 @@
-/*
- *  Copyright (C) 2013, Analog Devices Inc.
- *	Author: Lars-Peter Clausen <lars@metafoo.de>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  Copyright (C) 2013, Analog Devices Inc.
+//	Author: Lars-Peter Clausen <lars@metafoo.de>
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/dmaengine.h>
-- 
2.18.0.rc2
