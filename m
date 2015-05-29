From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH - alsa-plugins/arcam-av ] arcam-av: Include
	sys/select.h for fd_set definition
Date: Fri, 29 May 2015 15:38:49 -0700
Message-ID: <1432939129-8343-1-git-send-email-raj.khem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id D318E266972
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 00:38:54 +0200 (CEST)
Received: by igbjd9 with SMTP id jd9so25386698igb.1
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 15:38:54 -0700 (PDT)
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
Cc: Khem Raj <raj.khem@gmail.com>
List-Id: alsa-devel@alsa-project.org

fixes build errors on non-glibc based systems

arcam-av/arcam_av.c:389:2: error: unknown type name 'fd_set'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 arcam-av/arcam_av.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arcam-av/arcam_av.c b/arcam-av/arcam_av.c
index 0491fc6..fff96f9 100644
--- a/arcam-av/arcam_av.c
+++ b/arcam-av/arcam_av.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 
 #include <sys/ipc.h>
+#include <sys/select.h>
 #include <sys/shm.h>
 #include <sys/stat.h>
 #include <sys/stat.h>
-- 
2.1.4
