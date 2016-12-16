From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] tinycompress: rename crec.c
Date: Fri, 16 Dec 2016 13:04:17 +0530
Message-ID: <1481873657-3092-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D761265AF3
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 08:34:47 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Since the compress recorder utility is called crecord, it makes it apt to
have src file named crecord.c.

Reported-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 src/utils/Makefile.am           | 2 +-
 src/utils/{crec.c => crecord.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename src/utils/{crec.c => crecord.c} (100%)

diff --git a/src/utils/Makefile.am b/src/utils/Makefile.am
index 5f685e3b2ffe..1b996d430f21 100644
--- a/src/utils/Makefile.am
+++ b/src/utils/Makefile.am
@@ -1,7 +1,7 @@
 bin_PROGRAMS = cplay crecord
 
 cplay_SOURCES = cplay.c
-crecord_SOURCES = crec.c
+crecord_SOURCES = crecord.c
 
 cplay_CFLAGS = -I$(top_srcdir)/include
 crecord_CFLAGS = -I$(top_srcdir)/include
diff --git a/src/utils/crec.c b/src/utils/crecord.c
similarity index 100%
rename from src/utils/crec.c
rename to src/utils/crecord.c
-- 
1.9.1
