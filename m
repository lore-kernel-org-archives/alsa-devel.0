From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: move definitions of dt-binding
	constants to include/dt-bindings" to the asoc tree
Date: Mon, 12 Mar 2018 21:17:59 +0000 (GMT)
Message-ID: <20180312211759.CFFD1440079@finisterre.ee.mobilebroadband>
References: <20180312193436.8385-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 550F7267048
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 22:18:02 +0100 (CET)
In-Reply-To: <20180312193436.8385-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: move definitions of dt-binding constants to include/dt-bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0f2d4f162f4f54b431420df23122901a6ccd641e Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Mar 2018 20:34:35 +0100
Subject: [PATCH] ASoC: rt5651: move definitions of dt-binding constants to
 include/dt-bindings

Move the definitions of constants used in the dt-bindings from
include/sound/rt5651.h to include/dt-bindings/sound/rt5651.h.

As dt-bindings headers may also be parsed by the dt-compiler, they cannot
use enums, only defines, so this commit also changes the code declaring
the constants to use defines.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.16.2
