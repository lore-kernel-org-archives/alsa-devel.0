From: Chandrakanth Gorantla <cgorantla@nvidia.com>
Subject: [PATCH] tinycompress: compilation fix
Date: Wed, 21 May 2014 19:12:16 +0530
Message-ID: <1400679736-619-1-git-send-email-cgorantla@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 64732262607
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 15:43:02 +0200 (CEST)
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
Cc: Chandrakanth Gorantla <cgorantla@nvidia.com>
List-Id: alsa-devel@alsa-project.org

fix missing extern C closing statement.
---
 include/tinycompress/tinycompress.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 03c396f..3d94da6 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -270,4 +270,8 @@ int is_compress_ready(struct compress *compress);
 /* Returns a human readable reason for the last error */
 const char *compress_get_error(struct compress *compress);
 
+#if defined(__cplusplus)
+}  /* extern "C" */
+#endif
+
 #endif
-- 
1.8.1.5
