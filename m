From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: codecs: ak5558: Fix style for SPDX
	identifier
Date: Tue, 20 Feb 2018 14:53:10 +0200
Message-ID: <1519131190-15046-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0074.outbound.protection.outlook.com [104.47.36.74])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC35266F0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 14:55:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, linux-imx@nxp.com, cosmin.samoila@nxp.com, daniel.baluta@nxp.com, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org

Use // for .c and /* for .h files according to:
Documentation/process/license-rules.rst file.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/codecs/ak5558.c | 11 +++++------
 sound/soc/codecs/ak5558.h |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index f224831..f4ed5cc 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Audio driver for AK5558 ADC
- *
- * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
- * Copyright 2018 NXP
- */
+//
+// Audio driver for AK5558 ADC
+//
+// Copyright (C) 2015 Asahi Kasei Microdevices Corporation
+// Copyright 2018 NXP
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
diff --git a/sound/soc/codecs/ak5558.h b/sound/soc/codecs/ak5558.h
index 7c9e373..6105908 100644
--- a/sound/soc/codecs/ak5558.h
+++ b/sound/soc/codecs/ak5558.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Audio driver header for AK5558
  *
  * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
-- 
2.7.4
