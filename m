From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 2/2] topology: Quit and show error message
	on big-endian machines
Date: Thu, 19 Nov 2015 03:33:12 -0500
Message-ID: <61e90290970cd46a60fd17159bcbb1250938cbe1.1447921888.git.mengdong.lin@linux.intel.com>
References: <cover.1447921888.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 492012614C1
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 09:17:30 +0100 (CET)
In-Reply-To: <cover.1447921888.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This tool can only support little-endian machines atm.
Many codes directly refer to  __le32/__le64 variables of ABI objects,
so will be broken on big-endian machines.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/parser.c b/src/topology/parser.c
index 18bb9c7..2048733 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -371,10 +371,25 @@ void snd_tplg_verbose(snd_tplg_t *tplg, int verbose)
 	tplg->verbose = verbose;
 }
 
+static bool is_little_endian(void)
+{
+#ifdef __BYTE_ORDER
+	#if __BYTE_ORDER == __LITTLE_ENDIAN
+		return true;
+	#endif
+#endif
+	return false;
+}
+
 snd_tplg_t *snd_tplg_new(void)
 {
 	snd_tplg_t *tplg;
 
+	if (!is_little_endian()) {
+		SNDERR("error: cannot support big-endian machines\n");
+		return NULL;
+	}
+
 	tplg = calloc(1, sizeof(snd_tplg_t));
 	if (!tplg)
 		return NULL;
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 06cb100..e66d7f4 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -12,6 +12,8 @@
 
 #include <limits.h>
 #include <stdint.h>
+#include <stdbool.h>
+#include <endian.h>
 #include <linux/types.h>
 
 #include "local.h"
-- 
2.5.0
