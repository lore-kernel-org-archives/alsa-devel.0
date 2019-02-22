From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] printk: Remove no longer used LOG_PREFIX.
Date: Fri, 22 Feb 2019 18:59:40 +0900
Message-ID: <1550829580-9189-1-git-send-email-penguin-kernel__34109.6882287943$1551098883$gmane$org@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8450F807A4
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 11:00:34 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When commit 5becfb1df5ac8e49 ("kmsg: merge continuation records while
printing") introduced LOG_PREFIX, we used KERN_DEFAULT etc. as a flag
for setting LOG_PREFIX in order to tell whether to call cont_add()
(i.e. whether to append the message to "struct cont").

But since commit 4bcc595ccd80decb ("printk: reinstate KERN_CONT for
printing continuation lines") inverted the behavior (i.e. don't append
the message to "struct cont" unless KERN_CONT is specified) and commit
5aa068ea4082b39e ("printk: remove games with previous record flags")
removed the last LOG_PREFIX check, setting LOG_PREFIX via KERN_DEFAULT
etc. is no longer meaningful.

Therefore, we can remove LOG_PREFIX and make KERN_DEFAULT empty string.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/kern_levels.h | 2 +-
 include/linux/printk.h      | 1 -
 kernel/printk/printk.c      | 6 +-----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
index d237fe8..bf2389c 100644
--- a/include/linux/kern_levels.h
+++ b/include/linux/kern_levels.h
@@ -14,7 +14,7 @@
 #define KERN_INFO	KERN_SOH "6"	/* informational */
 #define KERN_DEBUG	KERN_SOH "7"	/* debug-level messages */
 
-#define KERN_DEFAULT	KERN_SOH "d"	/* the default kernel loglevel */
+#define KERN_DEFAULT	""		/* the default kernel loglevel */
 
 /*
  * Annotation for a "continued" line of log printout (only done after a
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77740a5..9fe6c9e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -18,7 +18,6 @@ static inline int printk_get_level(const char *buffer)
 	if (buffer[0] == KERN_SOH_ASCII && buffer[1]) {
 		switch (buffer[1]) {
 		case '0' ... '7':
-		case 'd':	/* KERN_DEFAULT */
 		case 'c':	/* KERN_CONT */
 			return buffer[1];
 		}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d1703..3e4a735 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -344,7 +344,6 @@ enum con_msg_format_flags {
 
 enum log_flags {
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
-	LOG_PREFIX	= 4,	/* text started with a prefix */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
@@ -1867,9 +1866,6 @@ int vprintk_store(int facility, int level,
 			case '0' ... '7':
 				if (level == LOGLEVEL_DEFAULT)
 					level = kern_level - '0';
-				/* fallthrough */
-			case 'd':	/* KERN_DEFAULT */
-				lflags |= LOG_PREFIX;
 				break;
 			case 'c':	/* KERN_CONT */
 				lflags |= LOG_CONT;
@@ -1884,7 +1880,7 @@ int vprintk_store(int facility, int level,
 		level = default_message_loglevel;
 
 	if (dict)
-		lflags |= LOG_PREFIX|LOG_NEWLINE;
+		lflags |= LOG_NEWLINE;
 
 	return log_output(facility, level, lflags,
 			  dict, dictlen, text, text_len);
-- 
1.8.3.1
