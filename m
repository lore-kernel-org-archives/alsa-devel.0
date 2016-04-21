From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 2/3] Add u8 in type_compat.h
Date: Thu, 21 Apr 2016 11:57:37 +0530
Message-ID: <1461220058-1378-3-git-send-email-vinod.koul@intel.com>
References: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ACC6264F22
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:23:11 +0200 (CEST)
In-Reply-To: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

Skylake headers use u8 data types which were not present in
type_compat so add them.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/type_compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/type_compat.h b/include/sound/type_compat.h
index eec86e4bc41e..e973ff3139e2 100644
--- a/include/sound/type_compat.h
+++ b/include/sound/type_compat.h
@@ -32,9 +32,11 @@ typedef int32_t __s32;
 #define __le64 __u64
 #define __le32 __u32
 #define __le16 __u16
+#define __le8  __u8
 #define __be64 __u64
 #define __be32 __u32
 #define __be16 __u16
+#define __be8  __u8
 #endif /* DOC_HIDDEN */
 
 #endif /* __TYPE_COMPAT_H */
-- 
1.9.1
