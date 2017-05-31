From: guneshwor.o.singh@intel.com
Subject: [PATCH 2/3] topology: Add max rates definition
Date: Wed, 31 May 2017 19:16:45 +0530
Message-ID: <20170531134646.9081-2-guneshwor.o.singh@intel.com>
References: <20170531134646.9081-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C9500266BED
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 15:46:49 +0200 (CEST)
In-Reply-To: <20170531134646.9081-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.com
Cc: vinod.koul@intel.com, mengdong.lin@intel.com, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 include/sound/asoc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 082c5429..a8accd01 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -26,6 +26,11 @@
 #define SND_SOC_TPLG_MAX_FORMATS	16
 
 /*
+ * Maximum number of PCM rates capability
+ */
+#define SND_SOC_TPLG_MAX_RATES	16
+
+/*
  * Maximum number of PCM stream configs
  */
 #define SND_SOC_TPLG_STREAM_CONFIG_MAX  8
-- 
2.13.0
