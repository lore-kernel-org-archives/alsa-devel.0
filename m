From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] hda-emu: Add logging prefix option
Date: Fri, 20 Jul 2012 14:59:50 +0200
Message-ID: <1342789192-11191-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B6A57265306
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 14:59:56 +0200 (CEST)
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

When working with automated runs of hda-emu, it will be easier to
catch warnings and errors if they are not color coded. With the
-F option, each line is instead prefixed with "Warning: ", "Info: "
etc, for easy parsing by automated tools.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-emu.c         |    6 +++++-
 hda-log.c         |   32 ++++++++++++++++++++++++++++++++
 include/hda-log.h |    1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

(There is no [PATCH 0/3] mail, because the patches are mostly unrelated.)

diff --git a/hda-emu.c b/hda-emu.c
index 87a198e..8bf1c81 100644
--- a/hda-emu.c
+++ b/hda-emu.c
@@ -934,6 +934,7 @@ static void usage(void)
 	fprintf(stderr, "  -q             don't echo but only to log file\n");
 	fprintf(stderr, "  -C             print messages in color (default)\n");
 	fprintf(stderr, "  -M             no color print\n");
+	fprintf(stderr, "  -F             print prefixes to messages\n");
 	fprintf(stderr, "  -a             issues SIGTRAP at codec errors\n");
 	fprintf(stderr, "  -P pincfg      initialize pin-configuration from sysfs entry\n");
 	fprintf(stderr, "  -j NID         turn on the initial jack-state of the given pin\n");
@@ -982,7 +983,7 @@ int main(int argc, char **argv)
 	int num_active_jacks = 0;
 	unsigned int active_jacks[16];
 
-	while ((c = getopt(argc, argv, "al:i:p:m:do:qCMP:j:")) != -1) {
+	while ((c = getopt(argc, argv, "al:i:p:m:do:qCMFP:j:")) != -1) {
 		switch (c) {
 		case 'a':
 			hda_log_trap_on_error = 1;
@@ -1012,6 +1013,9 @@ int main(int argc, char **argv)
 		case 'C':
 			log_flags |= HDA_LOG_FLAG_COLOR;
 			break;
+		case 'F':
+			log_flags |= HDA_LOG_FLAG_PREFIX;
+			break;
 		case 'M':
 			log_flags &= ~HDA_LOG_FLAG_COLOR;
 			break;
diff --git a/hda-log.c b/hda-log.c
index 1ad9bda..65f3044 100644
--- a/hda-log.c
+++ b/hda-log.c
@@ -35,6 +35,7 @@ static FILE *logfp;
 static int log_flags = HDA_LOG_FLAG_COLOR;
 
 int hda_log_trap_on_error;
+static int log_previous_prefix = -1;
 
 static void set_color(int level)
 {
@@ -61,15 +62,43 @@ static void reset_color(void)
 	printf("\x1b[0m");
 }
 
+static void print_prefix(int level)
+{
+	static char *prefix_seq[] = {
+		[HDA_LOG_ERR] = "Error",
+		[HDA_LOG_WARN] = "Warning",
+		[HDA_LOG_KERN] = "Kernel",
+		[HDA_LOG_INFO] = "Info",
+		[HDA_LOG_VERB] = "Verb",
+	};
+
+	if (!(log_flags & HDA_LOG_FLAG_PREFIX))
+		return;
+	if (level < 0)
+		level = 0;
+	else if (level > HDA_LOG_VERB)
+		level = HDA_LOG_VERB;
+
+	if (log_previous_prefix == level)
+		return;
+	if (log_previous_prefix != -1)
+		fprintf(logfp, "\n");
+	fprintf(logfp, "%s: ", prefix_seq[level]);
+	log_previous_prefix = level;
+}
+
 static void _hda_log(int level, const char *fmt, va_list ap)
 {
 	va_list ap2;
+	int i;
 
 	if (level > log_level)
 		return;
 
 	if (logfp == stdout)
 		set_color(level);
+	print_prefix(level);
+
 	va_copy(ap2, ap);
 	vfprintf(logfp, fmt, ap);
 	if (!(log_flags & HDA_LOG_FLAG_NO_ECHO) && logfp != stdout)
@@ -77,6 +106,9 @@ static void _hda_log(int level, const char *fmt, va_list ap)
 	va_end(ap2);
 	if (logfp == stdout)
 		reset_color();
+	if (((i = strlen(fmt)) > 0) && (fmt[i-1] == '\n'))
+		log_previous_prefix = -1;
+
 	if ((level == HDA_LOG_ERR || level == HDA_LOG_WARN) &&
 	    hda_log_trap_on_error)
 		raise(SIGTRAP);
diff --git a/include/hda-log.h b/include/hda-log.h
index 351a427..2e2137b 100644
--- a/include/hda-log.h
+++ b/include/hda-log.h
@@ -12,6 +12,7 @@ enum {
 /* flags */
 #define HDA_LOG_FLAG_NO_ECHO	(1 << 0)
 #define HDA_LOG_FLAG_COLOR	(1 << 1)
+#define HDA_LOG_FLAG_PREFIX	(1 << 2)
 
 int hda_log_init(const char *file, unsigned int flags);
 void hda_log(int level, const char *fmt, ...);
-- 
1.7.9.5
