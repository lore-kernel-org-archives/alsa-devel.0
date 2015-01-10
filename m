From: rumko@rumko.net
Subject: [PATCH - alsa-lib 1/1] include/global.h: missing
	struct on FreeBSD
Date: Sat, 10 Jan 2015 11:04:59 +0100
Message-ID: <54b0f97b.ca51c20a.1b71.ffffc3db@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C7C5260698
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 11:05:49 +0100 (CET)
Received: by mail-wi0-f171.google.com with SMTP id bs8so6539429wib.4
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 02:05:48 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Rumko <rumko@rumko.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Rumko <rumko@rumko.net>

On FreeBSD, struct timespec is not accessible through <time.h>,
but through <sys/tiespec.h>. Add specific include for that header
on that platform only.

Signed-off-by: Rumko <rumko@rumko.net>

diff --git a/include/global.h b/include/global.h
index 16a26dc..70be1f9 100644
--- a/include/global.h
+++ b/include/global.h
@@ -31,6 +31,10 @@
 /* for timeval and timespec */
 #include <time.h>
 
+#if defined(__FreeBSD__)
+#include <sys/timespec.h>
+#endif
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.2.1
