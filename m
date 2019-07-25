From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 3/3] iomap: fix Invalid License ID
Date: Thu, 25 Jul 2019 16:58:33 +0900
Message-ID: <20190725075833.3481-3-yamada.masahiro@socionext.com>
References: <20190725075833.3481-1-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725075833.3481-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: alsa-devel@alsa-project.org

Detected by:

  $ ./scripts/spdxcheck.py
  fs/iomap/Makefile: 1:27 Invalid License ID: GPL-2.0-or-newer

Fixes: 1c230208f53d ("iomap: start moving code to fs/iomap/")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - New patch

 fs/iomap/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 2d165388d952..93cd11938bf5 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-or-newer
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2019 Oracle.
 # All Rights Reserved.
-- 
2.17.1
