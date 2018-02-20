From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH 1/2] ASoC: ak4458: Modify SPDX license format
Date: Tue, 20 Feb 2018 10:56:07 +0200
Message-ID: <1519116968-31759-2-git-send-email-cosmin.samoila@nxp.com>
References: <1519116968-31759-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0057.outbound.protection.outlook.com [104.47.36.57])
 by alsa0.perex.cz (Postfix) with ESMTP id CF6C9267096
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 10:55:45 +0100 (CET)
In-Reply-To: <1519116968-31759-1-git-send-email-cosmin.samoila@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, wakasugi.jb@om.asahi-kasei.co.jp, linux-imx@nxp.com, Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>, daniel.baluta@nxp.com, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org

Modify SPDX comment style to match the rules. Since the original
code had a GPL-2.0 license and SPDX is compatible with GPL-2.0+,
we also modified the MODULE_LICENSE.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 sound/soc/codecs/ak4458.c | 13 ++++++-------
 sound/soc/codecs/ak4458.h |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index d2815ac..8a49dd2 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Audio driver for AK4458 DAC
- *
- * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
- * Copyright 2018 NXP
- */
+//
+// Audio driver for AK4458 DAC
+//
+// Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+// Copyright 2018 NXP
 
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -655,4 +654,4 @@ module_i2c_driver(ak4458_i2c_driver);
 MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
 MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
 MODULE_DESCRIPTION("ASoC AK4458 DAC driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
index 16d9d22..f906215 100644
--- a/sound/soc/codecs/ak4458.h
+++ b/sound/soc/codecs/ak4458.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Audio driver for AK4458
  *
-- 
2.7.4
