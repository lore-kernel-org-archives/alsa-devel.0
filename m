From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH 2/2] ASoC: ak4458: Sort headers alphabetically
Date: Tue, 20 Feb 2018 10:56:08 +0200
Message-ID: <1519116968-31759-3-git-send-email-cosmin.samoila@nxp.com>
References: <1519116968-31759-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0062.outbound.protection.outlook.com [104.47.41.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 90AC22671A9
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 10:55:46 +0100 (CET)
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

Keep headers sorted alphabetically.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 sound/soc/codecs/ak4458.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 8a49dd2..31ec0ba 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -5,19 +5,19 @@
 // Copyright (C) 2016 Asahi Kasei Microdevices Corporation
 // Copyright 2018 NXP
 
-#include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
-#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <sound/initval.h>
 #include <sound/tlv.h>
-#include <sound/pcm_params.h>
 
 #include "ak4458.h"
 
-- 
2.7.4
