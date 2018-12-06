From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] tinycompress: Fix missing '}' around extern C
Date: Thu, 6 Dec 2018 10:04:27 +0000
Message-ID: <20181206100427.18472-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 76279267C5D
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 11:04:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Piotr Stankiewicz <piotrs@opensource.cirrus.com>

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/tinycompress/tinycompress.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 780dce6..f0fae30 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -276,4 +276,8 @@ int is_compress_ready(struct compress *compress);
 /* Returns a human readable reason for the last error */
 const char *compress_get_error(struct compress *compress);
 
+#if defined(__cplusplus)
+} // extern "C"
+#endif
+
 #endif
-- 
2.11.0
