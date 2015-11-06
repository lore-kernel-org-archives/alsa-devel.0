From: mengdong.lin@linux.intel.com
Subject: [PATCH] topology: Include <linux/types.h> in API
	header file
Date: Fri,  6 Nov 2015 20:39:36 +0800
Message-ID: <1446813576-29295-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C3469260429
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 13:24:09 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Include <linux/types.h> in the API header file topology.h

The struct snd_tplg_stream_caps_template has a member "formats"
of type __le64. So <linux/types.h> is needed.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index b631871..5ee67e2 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -21,6 +21,8 @@
 #ifndef __ALSA_TOPOLOGY_H
 #define __ALSA_TOPOLOGY_H
 
+#include <linux/types.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
1.9.1
