From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: siu: convert to SPDX identifiers" to
	the asoc tree
Date: Mon, 18 Jun 2018 13:00:41 +0100
Message-ID: <E1fUspt-0000Oe-O0@debutante>
References: <87vaaor1n8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F244B2676FE
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:43 +0200 (CEST)
In-Reply-To: <87vaaor1n8.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: siu: convert to SPDX identifiers

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

>From 4e6fdaf1bd334e7e3ad9d6ef7aef4a433c770952 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:58:07 +0000
Subject: [PATCH] ASoC: siu: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/siu.h     | 26 ++++++--------------------
 sound/soc/sh/siu_dai.c | 26 ++++++--------------------
 sound/soc/sh/siu_pcm.c | 27 +++++++--------------------
 3 files changed, 19 insertions(+), 60 deletions(-)

diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index 6088d627c0e4..63a508fdfe78 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -1,23 +1,9 @@
-/*
- * siu.h - ALSA SoC driver for Renesas SH7343, SH7722 SIU peripheral.
- *
- * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- * Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// siu.h - ALSA SoC driver for Renesas SH7343, SH7722 SIU peripheral.
+//
+// Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+// Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
 
 #ifndef SIU_H
 #define SIU_H
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index ee2211635e92..f2a386fcd92e 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -1,23 +1,9 @@
-/*
- * siu_dai.c - ALSA SoC driver for Renesas SH7343, SH7722 SIU peripheral.
- *
- * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- * Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// siu_dai.c - ALSA SoC driver for Renesas SH7343, SH7722 SIU peripheral.
+//
+// Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+// Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
 
 #include <linux/delay.h>
 #include <linux/firmware.h>
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 172909570ed5..e263757e4a69 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -1,23 +1,10 @@
-/*
- * siu_pcm.c - ALSA driver for Renesas SH7343, SH7722 SIU peripheral.
- *
- * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- * Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// siu_pcm.c - ALSA driver for Renesas SH7343, SH7722 SIU peripheral.
+//
+// Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+// Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
+
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-- 
2.17.1
