From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 5/6] dt-bindings: clock: add clock id for renesas adg clocks
Date: Mon, 3 Dec 2018 20:24:09 +0900
Message-ID: <20181203112409.18276-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, vladimir_zapolskiy@mentor.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Jiada Wang <jiada_wang@mentor.com>

This patch adds clock ID for renesas adg clocks

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 include/dt-bindings/clock/renesas-adg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/clock/renesas-adg.h

diff --git a/include/dt-bindings/clock/renesas-adg.h b/include/dt-bindings/clock/renesas-adg.h
new file mode 100644
index 000000000000..fe30c186cef7
--- /dev/null
+++ b/include/dt-bindings/clock/renesas-adg.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Mentor Graphics inc.
+ */
+#ifndef __DT_BINDINGS_RENESAS_ADG_H__
+#define __DT_BINDINGS_RENESAS_ADG_H__
+
+#define ADG_FIX				0
+#define ADG_AVB				1
+
+#endif /* __DT_BINDINGS_RENESAS_ADG_H__ */
-- 
2.17.0
