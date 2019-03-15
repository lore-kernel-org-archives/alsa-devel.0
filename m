From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: [PATCH 2/5] pcm: add the missing <strings.h> include
Date: Fri, 15 Mar 2019 17:17:03 +0800
Message-ID: <20190315091706.26772-3-cwhuang@linux.org.tw>
References: <20190315091706.26772-1-cwhuang@linux.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08FF2F896F3
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 10:17:43 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id v12so6053007pgq.1
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 02:17:43 -0700 (PDT)
In-Reply-To: <20190315091706.26772-1-cwhuang@linux.org.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Chih-Wei Huang <cwhuang@linux.org.tw>
List-Id: alsa-devel@alsa-project.org

To define the prototype of ffs. See 'man ffs'.

Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
---
 src/pcm/mask_inline.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/pcm/mask_inline.h b/src/pcm/mask_inline.h
index e9fb9f81..75ad3594 100644
--- a/src/pcm/mask_inline.h
+++ b/src/pcm/mask_inline.h
@@ -19,6 +19,7 @@
  *
  */
   
+#include <strings.h>
 #include <sys/types.h>
 
 #define MASK_INLINE static inline
-- 
2.20.1
