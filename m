From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/6] ASoC: Intel: Skylake: Use acpi header
	for NHLT header
Date: Sat,  1 Aug 2015 19:40:40 +0530
Message-ID: <1438438244-17974-3-git-send-email-vinod.koul@intel.com>
References: <1438438244-17974-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 754CC261685
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 16:09:02 +0200 (CEST)
In-Reply-To: <1438438244-17974-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Instead of defining own acpi header, use the available acpi
header defined in acpi framework.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c |  1 -
 sound/soc/intel/skylake/skl-nhlt.h | 14 ++------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index a14009b47b29..13036b19d7e5 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -17,7 +17,6 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
-#include <linux/acpi.h>
 #include "skl.h"
 
 /* Unique identification for getting NHLT blobs */
diff --git a/sound/soc/intel/skylake/skl-nhlt.h b/sound/soc/intel/skylake/skl-nhlt.h
index b0e2e4da42a1..3769f9fefe2b 100644
--- a/sound/soc/intel/skylake/skl-nhlt.h
+++ b/sound/soc/intel/skylake/skl-nhlt.h
@@ -20,17 +20,7 @@
 #ifndef __SKL_NHLT_H__
 #define __SKL_NHLT_H__
 
-struct acpi_desc_header {
-	u32  signature;
-	u32  length;
-	u8   revision;
-	u8   checksum;
-	u8   oem_id[6];
-	u64  oem_table_id;
-	u32  oem_revision;
-	u32  creator_id;
-	u32  creator_revision;
-} __packed;
+#include <linux/acpi.h>
 
 struct wav_fmt {
 	u16 fmt_tag;
@@ -98,7 +88,7 @@ struct nhlt_endpoint {
 } __packed;
 
 struct nhlt_acpi_table {
-	struct acpi_desc_header header;
+	struct acpi_table_header header;
 	u8 endpoint_count;
 	struct nhlt_endpoint desc[0];
 } __packed;
-- 
1.9.1
