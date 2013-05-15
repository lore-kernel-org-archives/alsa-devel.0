From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 6/8] Fix build errors caused by
	-Werror=format-security.
Date: Wed, 15 May 2013 19:19:09 +0200
Message-ID: <1368638351-29200-7-git-send-email-jordi@debian.org>
References: <1368638351-29200-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 59C45261730
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:23 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id A629E62838
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:22 +0200 (CEST)
In-Reply-To: <1368638351-29200-1-git-send-email-jordi@debian.org>
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
List-Id: alsa-devel@alsa-project.org

When compiled with hardening-flags enabled, ld10k1 fails to build due to
a pair of unsafe printf usages that trigger -Werror=format-security.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 ld10k1/src/ld10k1.c |    2 +-
 ld10k1/src/lo10k1.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ld10k1/src/ld10k1.c b/ld10k1/src/ld10k1.c
index 7359f13..e31c5af 100644
--- a/ld10k1/src/ld10k1.c
+++ b/ld10k1/src/ld10k1.c
@@ -62,7 +62,7 @@ static void vlog(const char *label, const char *fmt, va_list va)
 			 localtime(&tp));
 		fprintf(out, "%s %s", timestr, label);
 	} else 
-		fprintf(out, label);
+		fprintf(out, "%s", label);
 	vfprintf(out, fmt, va);
 	fprintf(out, "\n");
 	fflush(out);
diff --git a/ld10k1/src/lo10k1.c b/ld10k1/src/lo10k1.c
index 3d04405..962c3ef 100644
--- a/ld10k1/src/lo10k1.c
+++ b/ld10k1/src/lo10k1.c
@@ -868,7 +868,7 @@ err:
 
 void debug_print(char *str)
 {
-	printf(str);
+	printf("%s", str);
 }
 
 static int debug(int deb)
-- 
1.7.10.4
