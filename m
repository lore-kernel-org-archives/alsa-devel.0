From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 33/38] axfer: add an option to handle
	key events
Date: Tue, 19 Sep 2017 09:44:13 +0900
Message-ID: <20170919004418.24668-34-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 9CFCC266D90
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:32 +0200 (CEST)
In-Reply-To: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In current implementation of aplay, when an option '--interactive' (-i)
is given, users can pause data transmission by pushing 'space' or 'enter'
key. The key event is handled via control terminal.

This commit adds support for this feature. This feature includes an issue
of race condition between SIGTSTOP/SIGCONT. When transmission of data
frame is paused by key event, then this application goes to backend by the
signal, a handler for SIGTSTOP restart the PCM substream after catching
SIGCONT but this brings state contradiction for a handler of key event.
Currently, this scenario is not cared in this commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am       |   7 ++-
 axfer/key-event.c       | 121 ++++++++++++++++++++++++++++++++++++++++++++++++
 axfer/key-event.h       |  19 ++++++++
 axfer/options.c         |  20 +++++++-
 axfer/options.h         |   1 +
 axfer/subcmd-transfer.c |  22 +++++++++
 6 files changed, 187 insertions(+), 3 deletions(-)
 create mode 100644 axfer/key-event.c
 create mode 100644 axfer/key-event.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 8c22bb18..cf14a0f7 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -23,7 +23,8 @@ noinst_HEADERS = \
 	xfer.h \
 	xfer-alsa.h \
 	waiter.h \
-	vumeter.h
+	vumeter.h \
+	key-event.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -53,4 +54,6 @@ axfer_SOURCES = \
 	waiter-poll.c \
 	xfer-libasound-irq-mmap.c \
 	vumeter.h \
-	vumeter.c
+	vumeter.c \
+	key-event.h \
+	key-event.c
diff --git a/axfer/key-event.c b/axfer/key-event.c
new file mode 100644
index 00000000..61680f0c
--- /dev/null
+++ b/axfer/key-event.c
@@ -0,0 +1,121 @@
+/*
+ * key-event.c - a handler for key events via stdin.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "key-event.h"
+#include "misc.h"
+
+#include <stdio.h>
+#include <termios.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
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
+		if (len < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN)
+				break;
+			return -errno;
+		}
+		if (len == 0)
+			break;
+		if (b == ' ' || b == '\n') {
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
diff --git a/axfer/key-event.h b/axfer/key-event.h
new file mode 100644
index 00000000..2e11ebf0
--- /dev/null
+++ b/axfer/key-event.h
@@ -0,0 +1,19 @@
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
+struct keyevent_context {
+	int fd;
+	long c_lflag;
+};
+
+int keyevent_context_init(struct keyevent_context *key);
+int keyevent_context_check(struct keyevent_context *key,
+			   struct xfer_context *xfer);
+void keyevent_context_destroy(struct keyevent_context *key);
diff --git a/axfer/options.c b/axfer/options.c
index d292fead..a0c2a794 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -297,6 +297,21 @@ static int apply_policies(struct context_options *opts,
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
+			fprintf(stderr,
+				"An option for interactive mode is not "
+				"available with stdin.\n");
+			return -EINVAL;
+		}
+	}
+
 	opts->sample_format = SND_PCM_FORMAT_UNKNOWN;
 	if (sample_format_literal) {
 		err = verify_sample_format(opts, sample_format_literal);
@@ -358,7 +373,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:A:R:T:V:";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:A:R:T:V:i";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -396,6 +411,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
 		/* Misc features. */
 		{"vumeter",		1, 0, 'V'},
+		{"interactive",		0, 0, 'i'},
 		/* Obsoleted. */
 		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
 		{NULL,			0, 0, 0},
@@ -472,6 +488,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->test_nowait = true;
 		else if (c == 'V')
 			vu_mode_literal = optarg;
+		else if (c == 'i')
+			opts->interactive = true;
 		else if (c == OPT_MAX_FILE_TIME) {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
diff --git a/axfer/options.h b/axfer/options.h
index 0e3c5109..69a98df1 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -60,6 +60,7 @@ struct context_options {
 
 	/* Misc features. */
 	enum vumeter_mode vu_mode;
+	bool interactive;
 };
 
 int context_options_init(struct context_options *opts, int argc,
diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index 1527fae8..5c61e210 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -9,6 +9,7 @@
 #include "xfer.h"
 #include "subcmd.h"
 #include "misc.h"
+#include "key-event.h"
 
 #include <signal.h>
 
@@ -363,9 +364,19 @@ static int context_process_frames(struct context *ctx,
 				  uint64_t *actual_frame_count)
 {
 	unsigned int frame_count;
+	struct keyevent_context *key = NULL;
 	int i;
 	int err = 0;
 
+	if (ctx->opts.interactive) {
+		key = malloc(sizeof(*key));
+		if (key == NULL)
+			return -ENOMEM;
+		err = keyevent_context_init(key);
+		if (err < 0)
+			return err;
+	}
+
 	if (!ctx->opts.quiet) {
 		fprintf(stderr,
 			_("%s: Format '%s', Rate %u Hz, Channels "),
@@ -405,6 +416,17 @@ static int context_process_frames(struct context *ctx,
 		*actual_frame_count += frame_count;
 		if (*actual_frame_count >= expected_frame_count)
 			break;
+
+		if (key) {
+			err = keyevent_context_check(key, &ctx->xfer);
+			if (err < 0)
+				break;
+		}
+	}
+
+	if (key) {
+		keyevent_context_destroy(key);
+		free(key);
 	}
 
 	if (!ctx->opts.quiet) {
-- 
2.11.0
