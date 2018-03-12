From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] ASoC: rt5651: move definitions of
	dt-binding constants to include/dt-bindings
Date: Mon, 12 Mar 2018 20:34:35 +0100
Message-ID: <20180312193436.8385-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC6A267048
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 20:34:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Move the definitions of constants used in the dt-bindings from
include/sound/rt5651.h to include/dt-bindings/sound/rt5651.h.

As dt-bindings headers may also be parsed by the dt-compiler, they cannot
use enums, only defines, so this commit also changes the code declaring
the constants to use defines.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/dt-bindings/sound/rt5651.h | 15 +++++++++++++++
 include/sound/rt5651.h             | 36 ------------------------------------
 sound/soc/codecs/rt5651.h          |  4 ++--
 3 files changed, 17 insertions(+), 38 deletions(-)
 create mode 100644 include/dt-bindings/sound/rt5651.h
 delete mode 100644 include/sound/rt5651.h

diff --git a/include/dt-bindings/sound/rt5651.h b/include/dt-bindings/sound/rt5651.h
new file mode 100644
index 000000000000..2f2dac915168
--- /dev/null
+++ b/include/dt-bindings/sound/rt5651.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_RT5651_H
+#define __DT_RT5651_H
+
+#define RT5651_JD_NULL			0
+#define RT5651_JD1_1			1
+#define RT5651_JD1_2			2
+#define RT5651_JD2			3
+
+#define RT5651_OVCD_SF_0P5		0
+#define RT5651_OVCD_SF_0P75		1
+#define RT5651_OVCD_SF_1P0		2
+#define RT5651_OVCD_SF_1P5		3
+
+#endif /* __DT_RT5651_H */
diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
deleted file mode 100644
index 6403b862fb9a..000000000000
--- a/include/sound/rt5651.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * linux/sound/rt286.h -- Platform data for RT286
- *
- * Copyright 2013 Realtek Microelectronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __LINUX_SND_RT5651_H
-#define __LINUX_SND_RT5651_H
-
-/*
- * Note these MUST match the values from the DT binding:
- * Documentation/devicetree/bindings/sound/rt5651.txt
- */
-enum rt5651_jd_src {
-	RT5651_JD_NULL,
-	RT5651_JD1_1,
-	RT5651_JD1_2,
-	RT5651_JD2,
-};
-
-/*
- * Note these MUST match the values from the DT binding:
- * Documentation/devicetree/bindings/sound/rt5651.txt
- */
-enum rt5651_ovcd_sf {
-	RT5651_OVCD_SF_0P5,
-	RT5651_OVCD_SF_0P75,
-	RT5651_OVCD_SF_1P0,
-	RT5651_OVCD_SF_1P5,
-};
-
-#endif
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index f20c9be94fb2..3a0968c53fde 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -12,7 +12,7 @@
 #ifndef __RT5651_H__
 #define __RT5651_H__
 
-#include <sound/rt5651.h>
+#include <dt-bindings/sound/rt5651.h>
 
 /* Info */
 #define RT5651_RESET				0x00
@@ -2073,7 +2073,7 @@ struct rt5651_priv {
 	struct regmap *regmap;
 	struct snd_soc_jack *hp_jack;
 	struct work_struct jack_detect_work;
-	enum rt5651_jd_src jd_src;
+	unsigned int jd_src;
 	unsigned int ovcd_th;
 	unsigned int ovcd_sf;
 
-- 
2.14.3
