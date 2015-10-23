From: Caleb Crome <caleb@crome.org>
Subject: [PATCH 1/2] BAT: Add missing locale.h header
Date: Fri, 23 Oct 2015 17:46:09 +0000
Message-ID: <1445622370-18673-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 3166C2625E3
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:46:17 +0200 (CEST)
Received: by pasz6 with SMTP id z6so123873307pas.2
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:46:15 -0700 (PDT)
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
Cc: Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

Missing include became apparent when -O3 was not specified.
Added the header to remove error messages during debug compile.

Signed-off-by: Caleb Crome <caleb@crome.org>
---
 bat/bat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bat/bat.c b/bat/bat.c
index 56cfaf6..086b9fa 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -23,6 +23,7 @@
 #include <getopt.h>
 #include <math.h>
 #include <limits.h>
+#include <locale.h>
 
 #include "aconfig.h"
 #include "gettext.h"
-- 
2.6.1
