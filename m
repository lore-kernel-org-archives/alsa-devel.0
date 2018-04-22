From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: sgtl5000: Switch to SPDX identifier
Date: Sun, 22 Apr 2018 20:41:14 -0300
Message-ID: <1524440474-12360-2-git-send-email-festevam@gmail.com>
References: <1524440474-12360-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B436267284
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 01:43:30 +0200 (CEST)
Received: by mail-qt0-f195.google.com with SMTP id a25-v6so15800612qtm.1
 for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2018 16:43:30 -0700 (PDT)
In-Reply-To: <1524440474-12360-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/sgtl5000.c | 14 +++++---------
 sound/soc/codecs/sgtl5000.h |  1 +
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index ce0d0d7..60764f6 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1,12 +1,8 @@
-/*
- * sgtl5000.c  --  SGTL5000 ALSA SoC Audio driver
- *
- * Copyright 2010-2011 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// sgtl5000.c  --  SGTL5000 ALSA SoC Audio driver
+//
+// Copyright 2010-2011 Freescale Semiconductor, Inc. All Rights Reserved.
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 28cf637..3bd0f96 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * sgtl5000.h - SGTL5000 audio codec interface
  *
-- 
2.7.4
