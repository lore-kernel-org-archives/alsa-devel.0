From: yang.a.fang@intel.com
Subject: [PATCH 3/4] ASoC: ts3a227e: add platform data for
	ts3a227e driver
Date: Wed, 29 Apr 2015 18:43:57 -0700
Message-ID: <1430358238-74659-3-git-send-email-yang.a.fang@intel.com>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A6D662608CD
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 03:44:40 +0200 (CEST)
In-Reply-To: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, praveen.diwakar@intel.com, denny.iriawan@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

make irq flag part of platform data

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 include/sound/ts3a227e.h    |   19 +++++++++++++++++++
 sound/soc/codecs/ts3a227e.c |    9 ++++++++-
 sound/soc/codecs/ts3a227e.h |    2 ++
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/ts3a227e.h

diff --git a/include/sound/ts3a227e.h b/include/sound/ts3a227e.h
new file mode 100644
index 0000000..c005084
--- /dev/null
+++ b/include/sound/ts3a227e.h
@@ -0,0 +1,19 @@
+/*
+ * Platform data for TS3A227E
+ *
+ * Copyright (C) 2015 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_TS3A227E_H
+#define __LINUX_SND_TS3A227E_H
+
+struct ts3a227e_platform_data {
+
+	unsigned long irqflag;
+};
+
+#endif
diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 9fd80ac..422f66f 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -25,6 +25,7 @@
 struct ts3a227e {
 	struct regmap *regmap;
 	struct snd_soc_jack *jack;
+	struct ts3a227e_platform_data pdata;
 	bool plugged;
 	bool mic_present;
 	unsigned int buttons_held;
@@ -274,6 +275,7 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 {
 	struct ts3a227e *ts3a227e;
 	struct device *dev = &i2c->dev;
+	struct ts3a227e_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	int ret;
 	unsigned int acc_reg;
 
@@ -283,6 +285,11 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, ts3a227e);
 
+	ts3a227e->pdata.irqflag = IRQF_TRIGGER_LOW | IRQF_ONESHOT;
+
+	if (pdata)
+		ts3a227e->pdata = *pdata;
+
 	ts3a227e->regmap = devm_regmap_init_i2c(i2c, &ts3a227e_regmap_config);
 	if (IS_ERR(ts3a227e->regmap))
 		return PTR_ERR(ts3a227e->regmap);
@@ -296,7 +303,7 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 	}
 
 	ret = devm_request_threaded_irq(dev, i2c->irq, NULL, ts3a227e_interrupt,
-					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					ts3a227e->pdata.irqflag,
 					"TS3A227E", ts3a227e);
 	if (ret) {
 		dev_err(dev, "Cannot request irq %d (%d)\n", i2c->irq, ret);
diff --git a/sound/soc/codecs/ts3a227e.h b/sound/soc/codecs/ts3a227e.h
index e2acf9c..a587a72 100644
--- a/sound/soc/codecs/ts3a227e.h
+++ b/sound/soc/codecs/ts3a227e.h
@@ -11,6 +11,8 @@
 #ifndef _TS3A227E_H
 #define _TS3A227E_H
 
+#include <sound/ts3a227e.h>
+
 int ts3a227e_enable_jack_detect(struct snd_soc_component *component,
 				struct snd_soc_jack *jack);
 
-- 
1.7.9.5
