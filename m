From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [TINYCOMPRESS][v2 PATCH 7/7] tinycompress.h:
	explicitly include required headers
Date: Tue, 24 Mar 2015 10:32:34 +0000
Message-ID: <1427193154-6753-8-git-send-email-qais.yousef@imgtec.com>
References: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F403260464
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 11:32:45 +0100 (CET)
In-Reply-To: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
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
Cc: alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org

tinycompress.h was relying on other files to include linux/types.h and stdbool.h
which are required by it. Explicitly include it to fix compile errors when external
program tries to include this header.
---
 include/tinycompress/tinycompress.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 03c396fccea5..68626a42e4e7 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -53,6 +53,9 @@
 #ifndef __TINYCOMPRESS_H
 #define __TINYCOMPRESS_H
 
+#include <linux/types.h>
+#include <stdbool.h>
+
 #if defined(__cplusplus)
 extern "C" {
 #endif
-- 
2.1.0
