From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ac97: convert to SPDX identifiers" to
	the asoc tree
Date: Mon, 02 Jul 2018 11:10:08 +0100
Message-ID: <E1fZvma-0006QJ-DA@debutante>
References: <874lhif98z.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3498A2677CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:12 +0200 (CEST)
In-Reply-To: <874lhif98z.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ac97: convert to SPDX identifiers

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

>From 1a8f0a3c13c136951de7ea24ccb148e745db98a2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:26:27 +0000
Subject: [PATCH] ASoC: ac97: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/ac97/codec.h      |  8 +++-----
 include/sound/ac97/compat.h     |  9 +++------
 include/sound/ac97/controller.h |  8 +++-----
 include/sound/ac97/regs.h       | 20 ++------------------
 include/sound/ac97_codec.h      | 25 +++++--------------------
 sound/soc/soc-ac97.c            | 29 ++++++++++++-----------------
 6 files changed, 28 insertions(+), 71 deletions(-)

diff --git a/include/sound/ac97/codec.h b/include/sound/ac97/codec.h
index ec04be9ab119..9792d25fa369 100644
--- a/include/sound/ac97/codec.h
+++ b/include/sound/ac97/codec.h
@@ -1,10 +1,8 @@
-/*
- *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+/* SPDX-License-Identifier: GPL-2.0
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
  */
+
 #ifndef __SOUND_AC97_CODEC2_H
 #define __SOUND_AC97_CODEC2_H
 
diff --git a/include/sound/ac97/compat.h b/include/sound/ac97/compat.h
index 1351cba40048..57e19afa31ab 100644
--- a/include/sound/ac97/compat.h
+++ b/include/sound/ac97/compat.h
@@ -1,14 +1,11 @@
-/*
- *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+/* SPDX-License-Identifier: GPL-2.0
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
  *
  * This file is for backward compatibility with snd_ac97 structure and its
  * multiple usages, such as the snd_ac97_bus and snd_ac97_build_ops.
- *
  */
+
 #ifndef AC97_COMPAT_H
 #define AC97_COMPAT_H
 
diff --git a/include/sound/ac97/controller.h b/include/sound/ac97/controller.h
index b36ecdd64f14..06b5afb7fa6b 100644
--- a/include/sound/ac97/controller.h
+++ b/include/sound/ac97/controller.h
@@ -1,10 +1,8 @@
-/*
- *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+/* SPDX-License-Identifier: GPL-2.0
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
  */
+
 #ifndef AC97_CONTROLLER_H
 #define AC97_CONTROLLER_H
 
diff --git a/include/sound/ac97/regs.h b/include/sound/ac97/regs.h
index 9a4fa0c3264a..843f73f3705a 100644
--- a/include/sound/ac97/regs.h
+++ b/include/sound/ac97/regs.h
@@ -1,27 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  *  Universal interface for Audio Codec '97
  *
  *  For more details look to AC '97 component specification revision 2.1
  *  by Intel Corporation (http://developer.intel.com).
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
-
 /*
  *  AC'97 codec registers
  */
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 89d311a503d3..cc383991c0fe 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -1,30 +1,15 @@
-#ifndef __SOUND_AC97_CODEC_H
-#define __SOUND_AC97_CODEC_H
-
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  *  Universal interface for Audio Codec '97
  *
  *  For more details look to AC '97 component specification revision 2.1
  *  by Intel Corporation (http://developer.intel.com).
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 
+#ifndef __SOUND_AC97_CODEC_H
+#define __SOUND_AC97_CODEC_H
+
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 3f424f214bca..c086786e4471 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -1,20 +1,15 @@
-/*
- * soc-ac97.c  --  ALSA SoC Audio Layer AC97 support
- *
- * Copyright 2005 Wolfson Microelectronics PLC.
- * Copyright 2005 Openedhand Ltd.
- * Copyright (C) 2010 Slimlogic Ltd.
- * Copyright (C) 2010 Texas Instruments Inc.
- *
- * Author: Liam Girdwood <lrg@slimlogic.co.uk>
- *         with code, comments and ideas from :-
- *         Richard Purdie <richard@openedhand.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// soc-ac97.c  --  ALSA SoC Audio Layer AC97 support
+//
+// Copyright 2005 Wolfson Microelectronics PLC.
+// Copyright 2005 Openedhand Ltd.
+// Copyright (C) 2010 Slimlogic Ltd.
+// Copyright (C) 2010 Texas Instruments Inc.
+//
+// Author: Liam Girdwood <lrg@slimlogic.co.uk>
+//         with code, comments and ideas from :-
+//         Richard Purdie <richard@openedhand.com>
 
 #include <linux/ctype.h>
 #include <linux/delay.h>
-- 
2.18.0.rc2
