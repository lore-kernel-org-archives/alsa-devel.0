From: Gustavo Zacarias <gustavo@zacarias.com.ar>
Subject: [PATCH] ucm: parser needs limits.h
Date: Wed, 21 Dec 2016 19:46:34 -0300
Message-ID: <20161221224634.914-1-gustavo@zacarias.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.zacarias.com.ar (www.zacarias.com.ar [176.9.42.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DE71266A39
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 23:46:44 +0100 (CET)
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
Cc: Gustavo Zacarias <gustavo@zacarias.com.ar>
List-Id: alsa-devel@alsa-project.org

It's using PATH_MAX which is defined there, otherwise the build fails on
musl libc.

Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
---
 src/ucm/parser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index c98373a..f520abc 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -32,6 +32,7 @@
 
 #include "ucm_local.h"
 #include <dirent.h>
+#include <limits.h>
 
 /** The name of the environment variable containing the UCM directory */
 #define ALSA_CONFIG_UCM_VAR "ALSA_CONFIG_UCM"
-- 
2.10.2
