From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Correct a macro for FW message
Date: Mon,  3 Nov 2014 21:59:37 +0800
Message-ID: <1415023177-9442-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 69193260489
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 14:59:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

For the broadwell official released FW(Since 8.4.1.43), the macro
SST_HSW_NO_CHANNELS is changed and fixed to 4, so here change it
to 4.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index afd0ae1..387511f 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -21,7 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
-#define SST_HSW_NO_CHANNELS		2
+#define SST_HSW_NO_CHANNELS		4
 #define SST_HSW_MAX_DX_REGIONS		14
 #define SST_HSW_DX_CONTEXT_SIZE        (640 * 1024)
 
-- 
1.9.1
