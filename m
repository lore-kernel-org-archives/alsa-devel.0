From: Daniel Mentz <danielmentz@google.com>
Subject: [PATCH] ALSA: uapi: #include <time.h> in asound.h
Date: Fri, 29 Mar 2019 15:48:54 -0700
Message-ID: <20190329224854.38009-1-danielmentz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc4a.google.com (mail-yw1-xc4a.google.com
 [IPv6:2607:f8b0:4864:20::c4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAA7FF80C16
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 23:49:15 +0100 (CET)
Received: by mail-yw1-xc4a.google.com with SMTP id k127so2608085ywe.23
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 15:49:15 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, etam@google.com
Cc: Daniel Mentz <danielmentz@google.com>
List-Id: alsa-devel@alsa-project.org

The uapi header asound.h defines types based on struct timespec. We need
to #include <time.h> to get access to the definition of this struct.

Previously, we encountered the following error message when building
applications with a clang/bionic toolchain:

kernel-headers/sound/asound.h:350:19: error: field has incomplete type 'struct timespec'
  struct timespec trigger_tstamp;
                  ^

The absence of the time.h #include statement does not cause build errors
with glibc, because its version of stdlib.h indirectly includes time.h.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 include/uapi/sound/asound.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 404d4b9ffe76..df1153cea0b7 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -32,6 +32,7 @@
 
 #ifndef __KERNEL__
 #include <stdlib.h>
+#include <time.h>
 #endif
 
 /*
-- 
2.21.0.392.gf8f6787159e-goog
