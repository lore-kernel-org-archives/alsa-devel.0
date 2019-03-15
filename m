From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: [PATCH 3/5] alisp: add the missing include
Date: Fri, 15 Mar 2019 17:17:04 +0800
Message-ID: <20190315091706.26772-4-cwhuang@linux.org.tw>
References: <20190315091706.26772-1-cwhuang@linux.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CCA6F896F3
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 10:17:45 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id n125so5907011pfn.5
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 02:17:45 -0700 (PDT)
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

Commit d4e08c5e865 changed to use internal versioned functions.
However, the header is not included. It generates the errors:

 In file included from external/alsa-lib/src/alisp/alisp.c:3038:
 external/alsa-lib/src/alisp/alisp_snd.c:583:64: error: implicit declaration of function '__snd_ctl_elem_info_get_dimension' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                         p2 = add_cons2(instance, p2, idx > 0, new_integer(instance, INTERNAL(snd_ctl_elem_info_get_dimension)(&info, idx)));
                                                                                    ^
 external/alsa-lib/include/alsa-symbols.h:30:24: note: expanded from macro 'INTERNAL'
 #define INTERNAL(Name) INTERNAL_CONCAT2_2(__, Name)
                        ^
 external/alsa-lib/include/alsa-symbols.h:29:39: note: expanded from macro 'INTERNAL_CONCAT2_2'
 #define INTERNAL_CONCAT2_2(Pre, Post) Pre##Post
                                      ^
 <scratch space>:396:1: note: expanded from here
 __snd_ctl_elem_info_get_dimension
 ^
 external/alsa-lib/src/alisp/alisp_snd.c:583:64: note: did you mean '__snd_ctl_elem_info_get_dimensions'?
 external/alsa-lib/include/alsa-symbols.h:30:24: note: expanded from macro 'INTERNAL'
 #define INTERNAL(Name) INTERNAL_CONCAT2_2(__, Name)
                       ^
 external/alsa-lib/include/alsa-symbols.h:29:39: note: expanded from macro 'INTERNAL_CONCAT2_2'
 #define INTERNAL_CONCAT2_2(Pre, Post) Pre##Post
                                      ^
 <scratch space>:396:1: note: expanded from here
 __snd_ctl_elem_info_get_dimension
 ^
 external/alsa-lib/src/alisp/alisp_snd.c:578:8: note: '__snd_ctl_elem_info_get_dimensions' declared here
         err = INTERNAL(snd_ctl_elem_info_get_dimensions)(&info);
               ^
 external/alsa-lib/include/alsa-symbols.h:30:24: note: expanded from macro 'INTERNAL'
 #define INTERNAL(Name) INTERNAL_CONCAT2_2(__, Name)
                        ^
 external/alsa-lib/include/alsa-symbols.h:29:39: note: expanded from macro 'INTERNAL_CONCAT2_2'
 #define INTERNAL_CONCAT2_2(Pre, Post) Pre##Post
                                       ^
 <scratch space>:395:1: note: expanded from here
 __snd_ctl_elem_info_get_dimensions
 ^
 2 errors generated.

Fixes: d4e08c5e865 ("control: Proper reference of internal versioned functions")
Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
---
 src/alisp/alisp_snd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/alisp/alisp_snd.c b/src/alisp/alisp_snd.c
index 16115236..744dce90 100644
--- a/src/alisp/alisp_snd.c
+++ b/src/alisp/alisp_snd.c
@@ -19,6 +19,8 @@
  *
  */
 
+#include "../control/control_local.h"
+
 struct acall_table {
 	const char *name;
 	struct alisp_object * (*func) (struct alisp_instance *instance, struct acall_table * item, struct alisp_object * args);
-- 
2.20.1
