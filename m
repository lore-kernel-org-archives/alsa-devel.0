From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 1/4] ASoC: SAMSUNG: Remove AC97 header file
Date: Fri,  7 Jan 2011 13:46:52 +0900
Message-ID: <1294375612-16776-1-git-send-email-sw.youn@samsung.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id A9EFA24633
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 06:11:05 +0100 (CET)
In-Reply-To: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch moves AC97 specific definitions, they doesn't need to be shared,
into 'ac97.c' from 'ac97.h'. This patch also remove header file, 'ac97.h',
and remove includes on machine drivers.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/samsung/ac97.c             |    4 +++-
 sound/soc/samsung/ac97.h             |   21 ---------------------
 sound/soc/samsung/ln2440sbc_alc650.c |    1 -
 sound/soc/samsung/smdk2443_wm9710.c  |    1 -
 sound/soc/samsung/smdk_wm9713.c      |    1 -
 5 files changed, 3 insertions(+), 25 deletions(-)
 delete mode 100644 sound/soc/samsung/ac97.h

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 4770a95..1e84ee0 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -25,11 +25,13 @@
 #include <plat/audio.h>
 
 #include "dma.h"
-#include "ac97.h"
 
 #define AC_CMD_ADDR(x) (x << 16)
 #define AC_CMD_DATA(x) (x & 0xffff)
 
+#define S3C_AC97_DAI_PCM 0
+#define S3C_AC97_DAI_MIC 1
+
 struct s3c_ac97_info {
 	struct clk         *ac97_clk;
 	void __iomem	   *regs;
diff --git a/sound/soc/samsung/ac97.h b/sound/soc/samsung/ac97.h
deleted file mode 100644
index 0d0e1b5..0000000
--- a/sound/soc/samsung/ac97.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* sound/soc/samsung/ac97.h
- *
- * ALSA SoC Audio Layer - S3C AC97 Controller driver
- *	Evolved from s3c2443-ac97.h
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd
- *	Author: Jaswinder Singh <jassi.brar@samsung.com>
- *	Credits: Graeme Gregory, Sean Choi
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __S3C_AC97_H_
-#define __S3C_AC97_H_
-
-#define S3C_AC97_DAI_PCM 0
-#define S3C_AC97_DAI_MIC 1
-
-#endif /* __S3C_AC97_H_ */
diff --git a/sound/soc/samsung/ln2440sbc_alc650.c b/sound/soc/samsung/ln2440sbc_alc650.c
index a2bb34d..0241429 100644
--- a/sound/soc/samsung/ln2440sbc_alc650.c
+++ b/sound/soc/samsung/ln2440sbc_alc650.c
@@ -23,7 +23,6 @@
 #include <sound/soc.h>
 
 #include "dma.h"
-#include "ac97.h"
 
 static struct snd_soc_card ln2440sbc;
 
diff --git a/sound/soc/samsung/smdk2443_wm9710.c b/sound/soc/samsung/smdk2443_wm9710.c
index 3be7e7e..4bd8c0b 100644
--- a/sound/soc/samsung/smdk2443_wm9710.c
+++ b/sound/soc/samsung/smdk2443_wm9710.c
@@ -19,7 +19,6 @@
 #include <sound/soc.h>
 
 #include "dma.h"
-#include "ac97.h"
 
 static struct snd_soc_card smdk2443;
 
diff --git a/sound/soc/samsung/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
index ae5fed6..d58d86e 100644
--- a/sound/soc/samsung/smdk_wm9713.c
+++ b/sound/soc/samsung/smdk_wm9713.c
@@ -16,7 +16,6 @@
 #include <sound/soc.h>
 
 #include "dma.h"
-#include "ac97.h"
 
 static struct snd_soc_card smdk;
 
-- 
1.6.2.5
