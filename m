From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH 2/3] ASoC: sta32x: add platform data definition
Date: Mon, 14 Nov 2011 17:23:17 +0100
Message-ID: <1321287798-20462-3-git-send-email-js@sig21.net>
References: <1321287798-20462-1-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C7C824720
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 17:32:38 +0100 (CET)
In-Reply-To: <1321287798-20462-1-git-send-email-js@sig21.net>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Add a structure for platform specific configuration and use it,
thereby removing a few FIXMEs which marked hard-coded values.

Cc: Sven Neumann <s.neumann@raumfeld.com>
Cc: Daniel Mack <daniel@zonque.org>
Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
 include/sound/sta32x.h    |   34 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sta32x.c |   30 +++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 9 deletions(-)
 create mode 100644 include/sound/sta32x.h

diff --git a/include/sound/sta32x.h b/include/sound/sta32x.h
new file mode 100644
index 0000000..45d7477
--- /dev/null
+++ b/include/sound/sta32x.h
@@ -0,0 +1,34 @@
+/*
+ * Platform data for ST STA32x ASoC codec driver.
+ *
+ * Copyright: 2011 Raumfeld GmbH
+ * Author: Johannes Stezenbach <js@sig21.net>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __LINUX_SND__STA32X_H
+#define __LINUX_SND__STA32X_H
+
+#define STA32X_OCFG_2CH		0
+#define STA32X_OCFG_2_1CH	1
+#define STA32X_OCFG_1CH		3
+
+#define STA32X_OM_CH1		0
+#define STA32X_OM_CH2		1
+#define STA32X_OM_CH3		2
+
+#define STA32X_THERMAL_ADJUSTMENT_ENABLE	1
+#define STA32X_THERMAL_RECOVERY_ENABLE		2
+
+struct sta32x_platform_data {
+	int output_conf;
+	int ch1_output_mapping;
+	int ch2_output_mapping;
+	int ch3_output_mapping;
+	int thermal_conf;
+};
+
+#endif /* __LINUX_SND__STA32X_H */
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index d2f3715..97091e3 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -35,6 +35,7 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
+#include <sound/sta32x.h>
 #include "sta32x.h"
 
 #define STA32X_RATES (SNDRV_PCM_RATE_32000 | \
@@ -73,6 +74,7 @@ static const char *sta32x_supply_names[] = {
 struct sta32x_priv {
 	struct regulator_bulk_data supplies[ARRAY_SIZE(sta32x_supply_names)];
 	struct snd_soc_codec *codec;
+	struct sta32x_platform_data *pdata;
 
 	unsigned int mclk;
 	unsigned int format;
@@ -775,9 +777,10 @@ static int sta32x_resume(struct snd_soc_codec *codec)
 static int sta32x_probe(struct snd_soc_codec *codec)
 {
 	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
-	int i, ret = 0;
+	int i, ret = 0, thermal = 0;
 
 	sta32x->codec = codec;
+	sta32x->pdata = dev_get_platdata(codec->dev);
 
 	/* regulators */
 	for (i = 0; i < ARRAY_SIZE(sta32x->supplies); i++)
@@ -820,25 +823,34 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 	snd_soc_cache_write(codec, STA32X_AUTO3, 0x00);
 	snd_soc_cache_write(codec, STA32X_C3CFG, 0x40);
 
-	/* FIXME enable thermal warning adjustment and recovery  */
+	/* set thermal warning adjustment and recovery */
+	if (!(sta32x->pdata->thermal_conf & STA32X_THERMAL_ADJUSTMENT_ENABLE))
+		thermal |= STA32X_CONFA_TWAB;
+	if (!(sta32x->pdata->thermal_conf & STA32X_THERMAL_RECOVERY_ENABLE))
+		thermal |= STA32X_CONFA_TWRB;
 	snd_soc_update_bits(codec, STA32X_CONFA,
-			    STA32X_CONFA_TWAB | STA32X_CONFA_TWRB, 0);
+			    STA32X_CONFA_TWAB | STA32X_CONFA_TWRB,
+			    thermal);
 
-	/* FIXME select 2.1 mode  */
+	/* select output configuration  */
 	snd_soc_update_bits(codec, STA32X_CONFF,
 			    STA32X_CONFF_OCFG_MASK,
-			    1 << STA32X_CONFF_OCFG_SHIFT);
+			    sta32x->pdata->output_conf
+			    << STA32X_CONFF_OCFG_SHIFT);
 
-	/* FIXME channel to output mapping */
+	/* channel to output mapping */
 	snd_soc_update_bits(codec, STA32X_C1CFG,
 			    STA32X_CxCFG_OM_MASK,
-			    0 << STA32X_CxCFG_OM_SHIFT);
+			    sta32x->pdata->ch1_output_mapping
+			    << STA32X_CxCFG_OM_SHIFT);
 	snd_soc_update_bits(codec, STA32X_C2CFG,
 			    STA32X_CxCFG_OM_MASK,
-			    1 << STA32X_CxCFG_OM_SHIFT);
+			    sta32x->pdata->ch2_output_mapping
+			    << STA32X_CxCFG_OM_SHIFT);
 	snd_soc_update_bits(codec, STA32X_C3CFG,
 			    STA32X_CxCFG_OM_MASK,
-			    2 << STA32X_CxCFG_OM_SHIFT);
+			    sta32x->pdata->ch3_output_mapping
+			    << STA32X_CxCFG_OM_SHIFT);
 
 	/* initialize coefficient shadow RAM with reset values */
 	for (i = 4; i <= 49; i += 5)
-- 
1.7.7.2
