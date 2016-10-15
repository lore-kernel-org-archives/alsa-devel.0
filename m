From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: ak4641: Move register defines to
	main source
Date: Sat, 15 Oct 2016 21:32:41 +0200
Message-ID: <1476559961-23134-3-git-send-email-lars@metafoo.de>
References: <1476559961-23134-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7857E26690B
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 21:32:48 +0200 (CEST)
In-Reply-To: <1476559961-23134-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ak4641 driver only has a few register defines. As they are only used in
the one main driver file there is not really a need to keep them in a
separate header.

Moving them to the main source file allows to remove the now empty header
file completely.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ak4641.c | 22 +++++++++++++++++++++-
 sound/soc/codecs/ak4641.h | 39 ---------------------------------------
 sound/soc/pxa/hx4700.c    |  2 --
 3 files changed, 21 insertions(+), 42 deletions(-)
 delete mode 100644 sound/soc/codecs/ak4641.h

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index c91717d..ebdaf56 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -27,7 +27,27 @@
 #include <sound/tlv.h>
 #include <sound/ak4641.h>
 
-#include "ak4641.h"
+/* AK4641 register space */
+#define AK4641_PM1		0x00
+#define AK4641_PM2		0x01
+#define AK4641_SIG1		0x02
+#define AK4641_SIG2		0x03
+#define AK4641_MODE1		0x04
+#define AK4641_MODE2		0x05
+#define AK4641_DAC		0x06
+#define AK4641_MIC		0x07
+#define AK4641_TIMER		0x08
+#define AK4641_ALC1		0x09
+#define AK4641_ALC2		0x0a
+#define AK4641_PGA		0x0b
+#define AK4641_LATT		0x0c
+#define AK4641_RATT		0x0d
+#define AK4641_VOL		0x0e
+#define AK4641_STATUS		0x0f
+#define AK4641_EQLO		0x10
+#define AK4641_EQMID		0x11
+#define AK4641_EQHI		0x12
+#define AK4641_BTIF		0x13
 
 /* codec private data */
 struct ak4641_priv {
diff --git a/sound/soc/codecs/ak4641.h b/sound/soc/codecs/ak4641.h
deleted file mode 100644
index e00af5c..0000000
--- a/sound/soc/codecs/ak4641.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * ak4641.h  --  AK4641 SoC Audio driver
- *
- * Copyright 2008 Harald Welte <laforge@gnufiish.org>
- *
- * Based on ak4535.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _AK4641_H
-#define _AK4641_H
-
-/* AK4641 register space */
-
-#define AK4641_PM1		0x00
-#define AK4641_PM2		0x01
-#define AK4641_SIG1		0x02
-#define AK4641_SIG2		0x03
-#define AK4641_MODE1		0x04
-#define AK4641_MODE2		0x05
-#define AK4641_DAC		0x06
-#define AK4641_MIC		0x07
-#define AK4641_TIMER		0x08
-#define AK4641_ALC1		0x09
-#define AK4641_ALC2		0x0a
-#define AK4641_PGA		0x0b
-#define AK4641_LATT		0x0c
-#define AK4641_RATT		0x0d
-#define AK4641_VOL		0x0e
-#define AK4641_STATUS		0x0f
-#define AK4641_EQLO		0x10
-#define AK4641_EQMID		0x11
-#define AK4641_EQHI		0x12
-#define AK4641_BTIF		0x13
-
-#endif
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index ecbf287..8548304 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -27,8 +27,6 @@
 #include <asm/mach-types.h>
 #include "pxa2xx-i2s.h"
 
-#include "../codecs/ak4641.h"
-
 static struct snd_soc_jack hs_jack;
 
 /* Headphones jack detection DAPM pin */
-- 
2.1.4
