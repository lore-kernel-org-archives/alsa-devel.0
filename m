From: Rajeev Kumar <rajeevkumar.linux@gmail.com>
Subject: [PATCH] ASoC: Update email id of the author
Date: Tue,  9 Sep 2014 12:27:19 +0530
Message-ID: <1410245839-32680-1-git-send-email-rajeevkumar.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 00716261AF9
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 08:57:33 +0200 (CEST)
Received: by mail-wi0-f180.google.com with SMTP id ex7so3859629wid.7
 for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2014 23:57:33 -0700 (PDT)
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I moved from ST Microelectronics and so updating email-id to personal one.

Signed-off-by: Rajeev Kumar <rajeevkumar.linux@gmail.com>
---
 sound/soc/codecs/sta529.c      |    4 ++--
 sound/soc/dwc/designware_i2s.c |    2 +-
 sound/soc/spear/spear_pcm.c    |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 9aa1323..89c748d 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -4,7 +4,7 @@
  * sound/soc/codecs/sta529.c -- spear ALSA Soc codec driver
  *
  * Copyright (C) 2012 ST Microelectronics
- * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar <rajeevkumar.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -426,5 +426,5 @@ static struct i2c_driver sta529_i2c_driver = {
 module_i2c_driver(sta529_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC STA529 codec driver");
-MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
+MODULE_AUTHOR("Rajeev Kumar <rajeevkumar.linux@gmail.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 25c31f1..17b5cee 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -455,7 +455,7 @@ static struct platform_driver dw_i2s_driver = {
 
 module_platform_driver(dw_i2s_driver);
 
-MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
+MODULE_AUTHOR("Rajeev Kumar <rajeevkumar.linux@gmail.com>");
 MODULE_DESCRIPTION("DESIGNWARE I2S SoC Interface");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:designware_i2s");
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 0e5a8f3..a7dc3c5 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -4,7 +4,7 @@
  * sound/soc/spear/spear_pcm.c
  *
  * Copyright (C) 2012 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ * Rajeev Kumar<rajeevkumar.linux@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -50,6 +50,6 @@ int devm_spear_pcm_platform_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_spear_pcm_platform_register);
 
-MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
+MODULE_AUTHOR("Rajeev Kumar <rajeevkumar.linux@gmail.com>");
 MODULE_DESCRIPTION("SPEAr PCM DMA module");
 MODULE_LICENSE("GPL");
-- 
1.7.9.5
