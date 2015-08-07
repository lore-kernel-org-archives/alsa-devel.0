From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Use acpi header for
	NHLT header" to the asoc tree
Date: Fri, 07 Aug 2015 14:26:30 +0100
Message-ID: <E1ZNhfK-0003MI-Uc@finisterre>
References: <1438438244-17974-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E793E2612C7
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 15:26:43 +0200 (CEST)
In-Reply-To: <1438438244-17974-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Use acpi header for NHLT header

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From aba3dd5ace59d038a9d69e0f5319b6fec61012c8 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Sat, 1 Aug 2015 19:40:40 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Use acpi header for NHLT header

Instead of defining own acpi header, use the available acpi
header defined in acpi framework.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c |  1 -
 sound/soc/intel/skylake/skl-nhlt.h | 14 ++------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index a14009b..13036b1 100644
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
index b0e2e4d..3769f9f 100644
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
2.5.0
