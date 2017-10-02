From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 26/39] axfer: add an option to suppress
	event waiting
Date: Mon,  2 Oct 2017 09:19:27 +0900
Message-ID: <20171002001940.17218-27-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E4753266FCB
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 02:19:53 +0200 (CEST)
In-Reply-To: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

In aplay, '--test-nowait' is used to suppress calls of snd_pcm_wait()
when I/O operations return -EAGAIN or process truncated number of data
frames. This seems to be for debugging purpose. In this program, this
option is equivalent to suppress event waiting.

This commit adds support for this option.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c                 | 13 +++++++++++++
 axfer/options.h                 |  1 +
 axfer/xfer-libasound-irq-mmap.c |  1 +
 axfer/xfer-libasound-irq-rw.c   | 20 ++++++++++++--------
 axfer/xfer-libasound.c          |  2 +-
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index 3fa29341..b0ea99c3 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -16,6 +16,7 @@ enum no_short_opts {
 	/* 128 belongs to non us-ascii character set. */
 	OPT_DUMP_HW_PARAMS = 128,
 	OPT_FATAL_ERRORS,
+	OPT_TEST_NOWAIT,
 	/* Obsoleted. */
 	OPT_MAX_FILE_TIME,
 };
@@ -272,6 +273,15 @@ static int apply_policies(struct context_options *opts,
 		return -EINVAL;
 	}
 
+	if (opts->test_nowait) {
+		if (!opts->nonblock && !opts->mmap) {
+			fprintf(stderr,
+				"An option for nowait test should be used with "
+				"nonblock or mmap options.\n");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
@@ -318,6 +328,7 @@ int context_options_init(struct context_options *opts, int argc,
 		/* For debugging. */
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
+		{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
 		/* Obsoleted. */
 		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
 		{NULL,			0, 0, 0},
@@ -365,6 +376,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->dump_hw_params = true;
 		else if (c == OPT_FATAL_ERRORS)
 			opts->finish_at_xrun = true;
+		else if (c == OPT_TEST_NOWAIT)
+			opts->test_nowait = true;
 		else if (c == OPT_MAX_FILE_TIME) {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
diff --git a/axfer/options.h b/axfer/options.h
index 272ce9b9..3052d01a 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -39,6 +39,7 @@ struct context_options {
 	/* For debugging. */
 	bool dump_hw_params;
 	bool finish_at_xrun;
+	bool test_nowait;
 };
 
 int context_options_init(struct context_options *opts, int argc,
diff --git a/axfer/xfer-libasound-irq-mmap.c b/axfer/xfer-libasound-irq-mmap.c
index f798c4da..fb70bbc5 100644
--- a/axfer/xfer-libasound-irq-mmap.c
+++ b/axfer/xfer-libasound-irq-mmap.c
@@ -86,6 +86,7 @@ static int irq_mmap_process_frames(struct libasound_state *state,
 		err = waiter_context_wait_event(state->waiter, -1);
 		if (err < 0)
 			goto error;
+
 		/*
 		 * When rescheduled, current position of data transmission was
 		 * queried to actual hardware by a handler of IRQ. No need to
diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
index afe2d34c..ad320f6f 100644
--- a/axfer/xfer-libasound-irq-rw.c
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -185,10 +185,12 @@ static int r_process_frames_nonblocking(struct libasound_state *state,
 			goto error;
 	}
 
-	/* Wait for hardware IRQ when no available space. */
-	err = waiter_context_wait_event(state->waiter, -1);
-	if (err < 0)
-		goto error;
+	if (state->waiter) {
+		/* Wait for hardware IRQ when no available space. */
+		err = waiter_context_wait_event(state->waiter, -1);
+		if (err < 0)
+			goto error;
+	}
 
 	/* Check available space on the buffer. */
 	avail = snd_pcm_avail(state->handle);
@@ -341,10 +343,12 @@ static int w_process_frames_nonblocking(struct libasound_state *state,
 	unsigned int avail_count;
 	int err;
 
-	/* Wait for hardware IRQ when no left space. */
-	err = waiter_context_wait_event(state->waiter, -1);
-	if (err < 0)
-		goto error;
+	if (state->waiter) {
+		/* Wait for hardware IRQ when no left space. */
+		err = waiter_context_wait_event(state->waiter, -1);
+		if (err < 0)
+			goto error;
+	}
 
 	/* Check available space on the buffer. */
 	avail = snd_pcm_avail(state->handle);
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index dd882e62..5271d230 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -75,7 +75,7 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 	}
 
 	state->nonblock = !!(mode & SND_PCM_NONBLOCK);
-	if (opts->nonblock || opts->mmap) {
+	if ((opts->nonblock || opts->mmap) && !opts->test_nowait) {
 		state->waiter = malloc(sizeof(*state->waiter));
 		if (state->waiter == NULL)
 			return -ENOMEM;
-- 
2.11.0
