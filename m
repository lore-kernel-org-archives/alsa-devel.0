From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 3/4] Fix a build failure due to a misused
	format string.
Date: Wed, 15 May 2013 19:12:56 +0200
Message-ID: <1368637977-29096-4-git-send-email-jordi@debian.org>
References: <1368637977-29096-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 85A62265373
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:13:12 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id C681162988
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:13:11 +0200 (CEST)
In-Reply-To: <1368637977-29096-1-git-send-email-jordi@debian.org>
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

This fixes builds with -Werror=format-security.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 alsactl/utils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alsactl/utils.c b/alsactl/utils.c
index 7ac2db1..072c239 100644
--- a/alsactl/utils.c
+++ b/alsactl/utils.c
@@ -111,7 +111,7 @@ static void syslog_(int prio, const char *fcn, long line,
 	buf[sizeof(buf)-1] = '\0';
 	vsnprintf(buf + strlen(buf), sizeof(buf)-strlen(buf), fmt, ap);
 	buf[sizeof(buf)-1] = '\0';
-	syslog(LOG_INFO, buf);
+	syslog(LOG_INFO, "%s", buf);
 }
 
 void info_(const char *fcn, long line, const char *fmt, ...)
-- 
1.7.10.4
