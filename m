From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 04/10] ALSA: axd: add fw binary header manipulation files
Date: Mon, 24 Aug 2015 13:39:13 +0100
Message-ID: <1440419959-14315-5-git-send-email-qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These files provide functions to get information from the fw binary
header.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/img/axd/axd_hdr.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/img/axd/axd_hdr.h | 24 +++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 sound/soc/img/axd/axd_hdr.c
 create mode 100644 sound/soc/img/axd/axd_hdr.h

diff --git a/sound/soc/img/axd/axd_hdr.c b/sound/soc/img/axd/axd_hdr.c
new file mode 100644
index 000000000000..7be3d11df120
--- /dev/null
+++ b/sound/soc/img/axd/axd_hdr.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Helper functions to parse AXD Header in the firmware binary.
+ */
+#include <linux/kernel.h>
+
+#include "axd_api.h"
+#include "axd_hdr.h"
+
+static struct axd_hdr *hdr;
+
+static void dump_hdr(void)
+{
+	unsigned int offset = 0;
+	unsigned long address = (unsigned long)hdr;
+
+	pr_debug("header <0x%08lX>:\n", address);
+	while (offset <= sizeof(*hdr)) {
+		pr_debug("0x%08X\t", *(unsigned int *)(address+offset));
+		offset += 4;
+		if ((offset % (4*4)) == 0)
+			pr_debug("\n");
+	}
+	pr_debug("\n");
+}
+
+void axd_hdr_init(unsigned long address)
+{
+	hdr = (struct axd_hdr *)address;
+	dump_hdr();
+}
+
+unsigned long axd_hdr_get_pc(unsigned int thread)
+{
+	if (thread >= THREAD_COUNT)
+		return -1;
+	return hdr->thread_pc[thread];
+}
+
+unsigned long axd_hdr_get_cmdblock_offset(void)
+{
+	pr_debug("cmdblock_offset = 0x%08X\n", hdr->cmd_block_offset);
+	return hdr->cmd_block_offset;
+}
+
+char *axd_hdr_get_build_str(void)
+{
+	return hdr->build_str;
+}
+
+unsigned long axd_hdr_get_log_offset(void)
+{
+	return hdr->log_offset;
+}
diff --git a/sound/soc/img/axd/axd_hdr.h b/sound/soc/img/axd/axd_hdr.h
new file mode 100644
index 000000000000..dc0b1e3be5a2
--- /dev/null
+++ b/sound/soc/img/axd/axd_hdr.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Helper functions to parse AXD Header in the firmware binary
+ */
+#ifndef AXD_HDR_H_
+#define AXD_HDR_H_
+
+void axd_hdr_init(unsigned long address);
+unsigned long axd_hdr_get_pc(unsigned int thread);
+unsigned long axd_hdr_get_cmdblock_offset(void);
+char *axd_hdr_get_build_str(void);
+unsigned long axd_hdr_get_log_offset(void);
+
+#endif /* AXD_HDR_H_ */
-- 
2.1.0
