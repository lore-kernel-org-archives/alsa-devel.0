From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 7/9] ARM: DaVinci: ASoC: Adds ALSA SoC DIT/DIR
	driver support for DM646X
Date: Mon, 16 Mar 2009 08:05:48 -0400
Message-ID: <1237205148-30242-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AA98103835
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 13:23:03 +0100 (CET)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2GCMvhX032069
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 07:23:02 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds ALSA SoC DIT/DIR driver support for DM646X

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies on the ASoC tree available at http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=commit;h=168776ef58d38503f8ac4f8a7eb1039137208032.

 sound/soc/codecs/codec_stubs.c |   63 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/codec_stubs.c

diff --git a/sound/soc/codecs/codec_stubs.c b/sound/soc/codecs/codec_stubs.c
new file mode 100644
index 0000000..60d3446
--- /dev/null
+++ b/sound/soc/codecs/codec_stubs.c
@@ -0,0 +1,63 @@
+/*
+ * ALSA SoC DaVinci DIT/DIR driver
+ *
+ *  TI DaVinci audio controller can operate in DIT/DIR (SPDI/F) where
+ *  no codec is needed.  This file provides stub codec that can be used
+ *  in these configurations.
+ *
+ * Author:      Steve Chen,  <schen@mvista.com>
+ * Copyright:   (C) 2008 MontaVista Software, Inc., <source@mvista.com>
+ * Copyright:   (C) 2008  Texas Instruments, India
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+
+#define STUB_RATES	SNDRV_PCM_RATE_8000_96000
+#define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai dit_stub_dai[] = {
+	{
+		.name = "DIT",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 384,
+			.rates = STUB_RATES,
+			.formats = STUB_FORMATS,
+		},
+	}
+};
+
+struct snd_soc_dai dir_stub_dai[] = {
+	{
+		.name = "DIR",
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 384,
+			.rates = STUB_RATES,
+			.formats = STUB_FORMATS,
+		},
+	}
+};
+
+static int __init dit_modinit(void)
+{
+	return snd_soc_register_dai(dit_stub_dai);
+}
+module_init(dit_modinit);
+
+static void __exit dit_exit(void)
+{
+	snd_soc_unregister_dai(dit_stub_dai);
+}
+module_exit(dit_exit);
+
-- 
1.5.6
