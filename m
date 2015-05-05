From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [TINYCOMPRESS][PATCH v3 7/7] tinycompress.h:
	explicitly include required headers
Date: Tue, 5 May 2015 11:21:11 +0100
Message-ID: <1430821271-15624-8-git-send-email-qais.yousef@imgtec.com>
References: <1430821271-15624-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 550E32652D1
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 12:22:34 +0200 (CEST)
In-Reply-To: <1430821271-15624-1-git-send-email-qais.yousef@imgtec.com>
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

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
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
