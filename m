From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 22/23] aplay: add a handler for key events
Date: Thu, 17 Aug 2017 21:00:03 +0900
Message-ID: <20170817120004.15326-23-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 374FD26684C
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:16 +0200 (CEST)
In-Reply-To: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

In current implementation of aplay, when an option '--interactive' (-i)
is given, users can pause data transmission by pushing 'space' or 'enter'
key. The key event is handled via control terminal.

This commit adds support for this feature with a different shape.
---
 aplay/Makefile.am       |   7 ++-
 aplay/key-event.c       | 120 ++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/key-event.h       |  21 +++++++++
 aplay/options.c         |  19 +++++++-
 aplay/options.h         |   1 +
 aplay/subcmd-transfer.c |  22 +++++++++
 6 files changed, 187 insertions(+), 3 deletions(-)
 create mode 100644 aplay/key-event.c
 create mode 100644 aplay/key-event.h

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index a0d498c..cffa4bc 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -13,7 +13,8 @@ noinst_HEADERS = \
 	xfer.h \
 	xfer-alsa.h \
 	main.h \
-	vumeter.h
+	vumeter.h \
+	key-event.h
 
 aplay_SOURCES = \
 	container.h \
@@ -44,7 +45,9 @@ aplay_SOURCES = \
 	subcmd-transfer.c \
 	main.c \
 	vumeter.h \
-	vumeter.c
+	vumeter.c \
+	key-event.h \
+	key-event.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/key-event.c b/aplay/key-event.c
new file mode 100644
index 0000000..df36740
--- /dev/null
+++ b/aplay/key-event.c
@@ -0,0 +1,120 @@
+/*
+ * key-event.c - a handler for key events via stdin.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "key-event.h"
+
+#include <stdio.h>
+#include <termios.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+#include <gettext.h>
+
+int keyevent_context_init(struct keyevent_context *key)
+{
+	struct termios term;
+	int err;
+
+	key->fd = fileno(stdin);
+	if (!isatty(key->fd)) {
+		printf(_("isatty(3): %s\n"),
+		       strerror(errno));
+		return -EINVAL;
+	}
+
+	err = tcgetattr(key->fd, &term);
+	if (err < 0) {
+		printf(_("tcgetattr(3): %s\n"),
+		       strerror(errno));
+		return -errno;
+	}
+	key->c_lflag = term.c_lflag;
+
+	term.c_lflag &= ~ICANON;
+	err = tcsetattr(key->fd, TCSANOW, &term);
+	if (err < 0) {
+		printf(_("tcsetattr(3): %s\n"),
+			 strerror(errno));
+		return -errno;
+	}
+
+	return 0;
+}
+
+static int set_nonblock_flag(int fd, bool nonblock)
+{
+	int err;
+
+	err = fcntl(fd, F_GETFL);
+	if (err < 0) {
+		printf(_("fcntl(2) with F_GETFL: %s\n"),
+			 strerror(errno));
+		return -errno;
+	}
+
+	if (nonblock)
+		err |= O_NONBLOCK;
+	else
+		err &= ~O_NONBLOCK;
+	err = fcntl(fd, F_SETFL, err);
+	if (err < 0) {
+		printf(_("fcntl(2) with F_SETFL: %s\n"),
+			 strerror(errno));
+		return -errno;
+	}
+
+	return 0;
+}
+
+int keyevent_context_check(struct keyevent_context *key,
+			   struct xfer_context *xfer)
+{
+	char b;
+	ssize_t len;
+	bool paused = false;
+	int err;
+
+	while (1) {
+		err = set_nonblock_flag(key->fd, !paused);
+		if (err < 0)
+			return err;
+
+		len = read(key->fd, &b, sizeof(b));
+		if (len == -EINTR)
+			continue;
+		if (len == -EAGAIN)
+			break;
+		if (len < 0)
+			return len;
+		if (len == 0)
+			break;
+		if (b == ' ' || b == '\r') {
+			xfer_context_pause(xfer, !paused);
+			if (paused)
+				break;
+			paused = !paused;
+		}
+	}
+
+	return 0;
+}
+
+void keyevent_context_destroy(struct keyevent_context *key)
+{
+	struct termios term;
+	int err;
+
+	tcgetattr(key->fd, &term);
+	term.c_lflag = key->c_lflag;
+	err = tcsetattr(key->fd, TCSANOW, &term);
+	if (err < 0) {
+		printf(_("tcsetattr(3): %s\n"),
+		       strerror(errno));
+	}
+}
diff --git a/aplay/key-event.h b/aplay/key-event.h
new file mode 100644
index 0000000..967e6d0
--- /dev/null
+++ b/aplay/key-event.h
@@ -0,0 +1,21 @@
+/*
+ * key-event.h - a header to a handler for key events via stdin.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer.h"
+
+#include <stdbool.h>
+
+struct keyevent_context {
+	int fd;
+	long c_lflag;
+};
+
+int keyevent_context_init(struct keyevent_context *key);
+int keyevent_context_check(struct keyevent_context *key,
+			   struct xfer_context *xfer);
+void keyevent_context_destroy(struct keyevent_context *key);
diff --git a/aplay/options.c b/aplay/options.c
index 7663703..005a7bf 100644
--- a/aplay/options.c
+++ b/aplay/options.c
@@ -315,6 +315,20 @@ static int apply_policies(struct context_options *opts,
 		}
 	}
 
+	if (opts->interactive) {
+		/*
+		 * In interactive mode, users can suspend/resume PCM substream
+		 * by keyboard input, thus stdin cannot used for source of
+		 * PCM frames.
+		 */
+		if (direction == SND_PCM_STREAM_PLAYBACK &&
+		    !strcmp(opts->paths[0], "-")) {
+			printf(_("An option for interactive mode is not "
+				 "available with stdin.\n"));
+			return -EINVAL;
+		}
+	}
+
 	opts->sample_format = SND_PCM_FORMAT_UNKNOWN;
 	if (sample_format_literal) {
 		err = verify_sample_format(opts, sample_format_literal);
@@ -331,7 +345,7 @@ static int apply_policies(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hqid:vt:D:c:f:r:MNF:A:R:T:B:IV:m:";
+	static const char *s_opts = "hqd:vt:D:c:f:r:MNF:A:R:T:B:IV:m:i";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -369,6 +383,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 		{"vumeter",		1, 0, 'V'},
 		{"chmap",		1, 0, 'm'},
+		{"interactive",		0, 0, 'i'},
 		{NULL,			0, 0, 0},
 	};
 	const char *cntr_format_literal = NULL;
@@ -447,6 +462,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->fatal_errors = true;
 		else if (c == 'm')
 			chmap_literal = optarg;
+		else if (c == 'i')
+			opts->interactive = true;
 		else
 			continue;
 
diff --git a/aplay/options.h b/aplay/options.h
index 3bece52..48ba859 100644
--- a/aplay/options.h
+++ b/aplay/options.h
@@ -54,6 +54,7 @@ struct context_options {
 
 	enum vumeter_mode vu_mode;
 	char *chmap_literal;
+	bool interactive;
 
 	char **paths;
 	unsigned int path_count;
diff --git a/aplay/subcmd-transfer.c b/aplay/subcmd-transfer.c
index 9138558..814c90f 100644
--- a/aplay/subcmd-transfer.c
+++ b/aplay/subcmd-transfer.c
@@ -7,6 +7,7 @@
  */
 
 #include "xfer.h"
+#include "key-event.h"
 
 #include <signal.h>
 #include <gettext.h>
@@ -288,9 +289,19 @@ static int context_process_frames(struct context *ctx,
 {
 	bool verbose = ctx->opts.verbose;
 	unsigned int frame_count;
+	struct keyevent_context *key = NULL;
 	int i;
 	int err;
 
+	if (ctx->opts.interactive) {
+		key = malloc(sizeof(*key));
+		if (key == NULL)
+			return -ENOMEM;
+		err = keyevent_context_init(key);
+		if (err < 0)
+			return err;
+	}
+
 	*actual_frame_count = 0;
 	while (!ctx->interrupted) {
 		/* Tell remains to expected frame count. */
@@ -316,6 +327,17 @@ static int context_process_frames(struct context *ctx,
 		*actual_frame_count += frame_count;
 		if (*actual_frame_count >= expected_frame_count)
 			break;
+
+		if (key) {
+			err = keyevent_context_check(key, &ctx->xfer);
+			if (err < 0 && err != -EAGAIN)
+				break;
+		}
+	}
+
+	if (key) {
+		keyevent_context_destroy(key);
+		free(key);
 	}
 
 	if (verbose) {
-- 
2.11.0
