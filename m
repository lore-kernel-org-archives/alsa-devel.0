From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 8/9] ARM: DaVinci: ASoC: Adds header file for
	DM646X DIT/DIR driver
Date: Mon, 16 Mar 2009 08:06:07 -0400
Message-ID: <1237205167-30268-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 21D35103835
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 13:23:21 +0100 (CET)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2GCNG1f025438
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 07:23:21 -0500
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

Adds header file for DM646X  DIT/DIR driver

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies on the ASoC tree available at http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=commit;h=168776ef58d38503f8ac4f8a7eb1039137208032.

 sound/soc/codecs/codec_stubs.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/codec_stubs.h

diff --git a/sound/soc/codecs/codec_stubs.h b/sound/soc/codecs/codec_stubs.h
new file mode 100644
index 0000000..693797b
--- /dev/null
+++ b/sound/soc/codecs/codec_stubs.h
@@ -0,0 +1,23 @@
+/*
+ * ALSA SoC DIT/DIR driver header
+ *
+ * Author:      Steve Chen,  <schen@mvista.com>
+ * Copyright:   (C) 2008 MontaVista Software, Inc., <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef CODEC_STUBS_H
+#define CODEC_STUBS_H
+
+#ifdef CONFIG_SND_SOC_CODEC_STUBS
+extern struct snd_soc_dai dit_stub_dai[];
+extern struct snd_soc_dai dir_stub_dai[];
+#else
+#define dit_stub_dai	NULL
+#define dir_stub_dai	NULL
+#endif
+
+#endif /* CODEC_STUBS_H */
-- 
1.5.6
