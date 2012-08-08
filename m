From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] hda-emu: Flush output before prompt
Date: Wed,  8 Aug 2012 11:54:29 +0200
Message-ID: <1344419670-8946-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A77332660C3
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 11:24:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When stdout is redirected, there is a risk not all stdout is sent
before the prompt is sent on stderr. Thanks to Jeremy Kerr for
help with this issue.
---
 hda-ctlsh.c       |    1 +
 hda-log.c         |    5 +++++
 include/hda-log.h |    1 +
 3 files changed, 7 insertions(+)

diff --git a/hda-ctlsh.c b/hda-ctlsh.c
index 4c21341..d84cc71 100644
--- a/hda-ctlsh.c
+++ b/hda-ctlsh.c
@@ -851,6 +851,7 @@ int cmd_loop(FILE *fp)
 	init_completion();
 
 	for (;;) {
+		hda_log_flush();
 		line = readline("> ");
 		if (!line)
 			break;
diff --git a/hda-log.c b/hda-log.c
index 65f3044..67ee8e2 100644
--- a/hda-log.c
+++ b/hda-log.c
@@ -179,6 +179,11 @@ int hda_log_level_set(int level)
 	return saved;
 }
 
+void hda_log_flush()
+{
+	fflush(logfp);
+}
+
 FILE *hda_get_logfp(void)
 {
 	return logfp;
diff --git a/include/hda-log.h b/include/hda-log.h
index 2e2137b..8b0d392 100644
--- a/include/hda-log.h
+++ b/include/hda-log.h
@@ -18,6 +18,7 @@ int hda_log_init(const char *file, unsigned int flags);
 void hda_log(int level, const char *fmt, ...);
 void hda_log_printk(const char *fmt, ...);
 void hda_log_echo(int level, const char *fmt, ...);
+void hda_log_flush(void);
 
 extern int hda_log_trap_on_error;
 
-- 
1.7.9.5
