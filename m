From: Paolo Doz <paolo.doz@gmail.com>
Subject: [PATCH 3/4] ASoC: ak5702: include file for clock type
Date: Mon, 29 Oct 2012 09:44:09 +0100
Message-ID: <CAFsPKCXUrTrMLWScMFUb4zPpEJR2wvo4T+DvGcDkQ9otw9a90A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DDB7526531C
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 09:44:09 +0100 (CET)
Received: by mail-ea0-f179.google.com with SMTP id f14so1606704eaa.38
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 01:44:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Include file used to define clock type of ak5702.

Signed-off-by: Paolo Doz <paolo.doz@gmail.com>
---
 include/sound/ak5702.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/sound/ak5702.h

diff --git a/include/sound/ak5702.h b/include/sound/ak5702.h
new file mode 100644
index 0000000..0ea2792
--- /dev/null
+++ b/include/sound/ak5702.h
@@ -0,0 +1,27 @@
+/*
+ * ak5702.h -- AK5702 ALSA SoC driver
+ *
+ * Author:      Paolo Doz <paolo.doz@gmail.com>
+ * Copyright:   (C) 2012 Soft In S.r.l.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __AK5702_H
+#define __AK5702_H
+
+/**
+ * enum ak5702_clock mode
+ */
+
+enum ak5702_clock_mode {
+    PLL_master_mode,
+    PLL_slave_mode,
+    PLL_slave_mode2,
+    EXT_slave_mode,
+    EXT_master_mode
+};
+
+#endif /* __AK5702_H */
-- 
1.7.9.5
