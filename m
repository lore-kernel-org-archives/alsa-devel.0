From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] tinycompress: clarify dual-license wording
Date: Wed, 18 Oct 2017 13:11:25 -0500
Message-ID: <20171018181125.27538-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E379E266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 20:11:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There were reports of confusion in legal circles introduced by the wording
"tinycompress is provided under LGPL and BSD dual license" in the README.

Clarify with the addition of the wording traditionally used for dual licenses:

"This file is provided under a dual BSD/LGPLv2.1 license.  When using or
redistributing this file, you may do so under either license"

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 COPYING                             | 3 +++
 README                              | 3 ++-
 include/tinycompress/tinycompress.h | 3 +++
 include/tinycompress/tinymp3.h      | 3 +++
 include/tinycompress/version.h      | 3 +++
 src/lib/compress.c                  | 3 +++
 src/utils/cplay.c                   | 3 +++
 src/utils/crecord.c                 | 3 +++
 8 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/COPYING b/COPYING
index f963926..dfc7426 100644
--- a/COPYING
+++ b/COPYING
@@ -1,3 +1,6 @@
+tinycompress is provided under a dual BSD/LGPLv2.1 license.  When using or
+  redistributing tinycompress, you may do so under either license.
+
 BSD LICENSE
 
 tinycompress library for compress audio offload in alsa
diff --git a/README b/README
index 73c19a6..689ca75 100644
--- a/README
+++ b/README
@@ -22,7 +22,8 @@ Http: http://git.alsa-project.org/?p=tinycompress.git
 alsa-devel@alsa-project.org. 
 
 4. LICENSE
-	tinycompress is provided under LGPL and BSD dual license
+	tinycompress is provided under a dual BSD/LGPLv2.1 license.  When using or
+  redistributing tinycompress, you may do so under either license.
 
 5. CREDITS
 - Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> for library design
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 68626a4..780dce6 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -1,4 +1,7 @@
 /*
+ * This file is provided under a dual BSD/LGPLv2.1 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
  * BSD LICENSE
  *
  * Copyright (c) 2011-2012, Intel Corporation
diff --git a/include/tinycompress/tinymp3.h b/include/tinycompress/tinymp3.h
index a709c39..b0d429d 100644
--- a/include/tinycompress/tinymp3.h
+++ b/include/tinycompress/tinymp3.h
@@ -1,4 +1,7 @@
 /*
+ * This file is provided under a dual BSD/LGPLv2.1 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
  * BSD LICENSE
  *
  * mp3 header and prasing
diff --git a/include/tinycompress/version.h b/include/tinycompress/version.h
index 000f6a2..82a3e6c 100644
--- a/include/tinycompress/version.h
+++ b/include/tinycompress/version.h
@@ -1,4 +1,7 @@
 /*
+ * This file is provided under a dual BSD/LGPLv2.1 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
  * BSD LICENSE
  *
  * Copyright (c) 2011-2012, Intel Corporation
diff --git a/src/lib/compress.c b/src/lib/compress.c
index 84738d2..8ae6bbd 100644
--- a/src/lib/compress.c
+++ b/src/lib/compress.c
@@ -1,4 +1,7 @@
 /*
+ * This file is provided under a dual BSD/LGPLv2.1 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
  * BSD LICENSE
  *
  * tinycompress library for compress audio offload in alsa
diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index 032a971..e0603fd 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -1,4 +1,7 @@
 /*
+ * This file is provided under a dual BSD/LGPLv2.1 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
  * BSD LICENSE
  *
  * tinyplay command line player for compress audio offload in alsa
diff --git a/src/utils/crecord.c b/src/utils/crecord.c
index 1fd3698..e051c2d 100644
--- a/src/utils/crecord.c
+++ b/src/utils/crecord.c
@@ -1,4 +1,7 @@
 /*
+ * This file is provided under a dual BSD/LGPLv2.1 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
  * BSD LICENSE
  *
  * crecord command line recorder for compress audio record in alsa
-- 
2.11.0
