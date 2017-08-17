From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 18/23] aplay: add a sub-command to
	transfer data frames
Date: Thu, 17 Aug 2017 20:59:59 +0900
Message-ID: <20170817120004.15326-19-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E220D266F11
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

In current implementation of aplay, default action is to transfer data
frames from/to devices.

This commit adds a file to handle the action. In future commit, this is
handled by 'transfer' sub-command. Event loop is included in this file.
In the loop, the number of handled data frames is maintained by an
appropriate way. As a result, users can stop data transmission frames by
frame.
---
 aplay/Makefile.am       |   3 +-
 aplay/subcmd-transfer.c | 414 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 aplay/subcmd-transfer.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 0113b5c..f604083 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -42,7 +42,8 @@ aplay_SOURCES = \
 	xfer-alsa-sched-irq.c \
 	xfer-alsa-sched-timer.c \
 	main.h \
-	subcmd-list.c
+	subcmd-list.c \
+	subcmd-transfer.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/subcmd-transfer.c b/aplay/subcmd-transfer.c
new file mode 100644
index 0000000..f163b05
--- /dev/null
+++ b/aplay/subcmd-transfer.c
@@ -0,0 +1,414 @@
+/*
+ * subcmd-transfer.c - operations for transfer sub command.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer.h"
+#include "key-event.h"
+
+#include <signal.h>
+#include <gettext.h>
+
+struct context {
+	struct xfer_context xfer;
+	struct aligner_context aligner;
+	struct container_context *cntrs;
+	unsigned int cntr_count;
+
+	struct context_options opts;
+	struct keyevent_context key;
+
+	/* NOTE: To handling Unix signal. */
+	bool interrupted;
+	int signal;
+};
+
+/* NOTE: To handling Unix signal. */
+static struct context *ctx_ptr;
+
+static void handle_unix_signal_for_finish(int sig)
+{
+	int i;
+
+	for (i = 0; i < ctx_ptr->cntr_count; ++i)
+		ctx_ptr->cntrs[i].interrupted = true;
+
+	ctx_ptr->signal = sig;
+	ctx_ptr->interrupted = true;
+}
+
+static void handle_unix_signal_for_suspend(int sig)
+{
+	sigset_t curr, prev;
+	struct sigaction sa = {0};
+
+	/*
+	 * 1. suspend substream.
+	 */
+	xfer_context_pause(&ctx_ptr->xfer, true);
+
+	/*
+	 * 2. Run default handler(SIG_DFL) for SIGTSTP to stop this process, by
+	 * yielding CPU.
+	 */
+	if (sigaction(SIGTSTP, NULL, &sa) < 0) {
+		printf("sigaction(2)\n");
+		exit(EXIT_FAILURE);
+	}
+	if (sa.sa_handler == SIG_ERR)
+		exit(EXIT_FAILURE);
+	if (sa.sa_handler == handle_unix_signal_for_suspend)
+		sa.sa_handler = SIG_DFL;
+	if (sigaction(SIGTSTP, &sa, NULL) < 0) {
+		printf("sigaction(2)\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Queue SIGTSTP. */
+	raise(SIGTSTP);
+
+	/*
+	 * Release the queued signal from being blocked, then yield CPU to the
+	 * default handler.
+	 */
+	sigemptyset(&curr);
+	sigaddset(&curr, SIGTSTP);
+	if (sigprocmask(SIG_UNBLOCK, &curr, &prev) < 0) {
+		printf("sigprocmask(2)\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/*
+	 * 3. SIGCONT is cought and rescheduled again, then continue substream.
+	 */
+	if (sigprocmask(SIG_SETMASK, &prev, NULL) < 0) {
+		printf("sigprocmask(2)\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Reconfigure this handler for SIGTSTP. */
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sa.sa_handler = handle_unix_signal_for_suspend;
+	if (sigaction(SIGTSTP, &sa, NULL) < 0) {
+		printf("sigaction(2)\n");
+		exit(EXIT_FAILURE);
+	}
+
+	xfer_context_pause(&ctx_ptr->xfer, false);
+}
+
+static int prepare_signal_handler(struct context *ctx)
+{
+	struct sigaction sa = {0};
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = handle_unix_signal_for_finish;
+
+	if (sigaction(SIGINT, &sa, NULL) < 0)
+		return -errno;
+	if (sigaction(SIGTERM, &sa, NULL) < 0)
+		return -errno;
+	if (sigaction(SIGABRT, &sa, NULL) < 0)
+		return -errno;
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = handle_unix_signal_for_suspend;
+	if (sigaction(SIGTSTP, &sa, NULL) < 0)
+		return -errno;
+
+	ctx_ptr = ctx;
+
+	return 0;
+}
+
+static int context_init(struct context *ctx, snd_pcm_stream_t direction)
+{
+	enum aligner_type type;
+	int err;
+
+	/* Initialize transfer. */
+	err = xfer_context_init(&ctx->xfer, XFER_TYPE_ALSA, direction,
+				&ctx->opts);
+	if (err < 0)
+		return err;
+
+	/* Allocate containers. */
+	ctx->cntrs = calloc(ctx->opts.path_count, sizeof(*ctx->cntrs));
+	if (ctx->cntrs == NULL)
+		return -ENOMEM;
+	ctx->cntr_count = ctx->opts.path_count;
+
+	/* Initialize aligner. */
+	if (direction == SND_PCM_STREAM_CAPTURE)
+		type = ALIGNER_TYPE_DEMUXER;
+	else
+		type = ALIGNER_TYPE_MUXER;
+	err = aligner_context_init(&ctx->aligner, type, ctx->cntr_count,
+				   ctx->opts.verbose);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static uint64_t calculate_expected_frame_count(struct context_options *opts,
+					   unsigned int frames_per_second,
+					   uint64_t total_frame_count)
+{
+	uint64_t frame_count;
+
+	if (opts->timelimit_seconds > 0) {
+		frame_count = frames_per_second * opts->timelimit_seconds;
+
+		if (frame_count < total_frame_count)
+			return frame_count;
+	}
+
+	return total_frame_count;
+}
+
+static int capture_context_pre_process(struct context *ctx,
+				       uint64_t *total_frame_count)
+{
+	snd_pcm_access_t access = 0;
+	snd_pcm_format_t sample_format = SND_PCM_FORMAT_UNKNOWN;
+	unsigned int samples_per_frame = 0;
+	unsigned int frames_per_second = 0;
+	snd_pcm_uframes_t frames_per_buffer = 0;
+	int i;
+	int err;
+
+	/*
+	 * Use given options for common parameters. Else, leave the decition to
+	 * each backend.
+	 */
+	if (ctx->opts.sample_format != SND_PCM_FORMAT_UNKNOWN)
+		sample_format = ctx->opts.sample_format;
+	if (ctx->opts.samples_per_frame > 0)
+		samples_per_frame = ctx->opts.samples_per_frame;
+	if (ctx->opts.frames_per_second > 0)
+		frames_per_second = ctx->opts.frames_per_second;
+
+	err = xfer_context_pre_process(&ctx->xfer, &sample_format,
+				       &samples_per_frame, &frames_per_second,
+				       &access, &frames_per_buffer,
+				       ctx->opts.chmap, ctx->opts.vu_mode);
+	if (err < 0)
+		return err;
+
+	/* Normalize paths. */
+	if (ctx->opts.path_count != samples_per_frame) {
+		err = context_options_normalize_paths(&ctx->opts,
+						      ctx->opts.cntr_format,
+						      samples_per_frame);
+		if (err < 0)
+			return err;
+	}
+
+	for (i = 0; i < ctx->cntr_count; ++i) {
+		err = container_builder_init(ctx->cntrs + i, ctx->opts.paths[i],
+					     ctx->opts.cntr_format,
+					     ctx->opts.verbose);
+		if (err < 0)
+			return err;
+
+		err = container_context_pre_process(ctx->cntrs + i,
+						    &sample_format,
+						    &samples_per_frame,
+						    &frames_per_second,
+						    total_frame_count);
+		if (err < 0)
+			return err;
+	}
+
+	err = aligner_context_pre_process(&ctx->aligner, access, sample_format,
+					  samples_per_frame, frames_per_buffer,
+					  ctx->cntrs);
+	if (err < 0)
+		return err;
+
+	*total_frame_count = calculate_expected_frame_count(&ctx->opts,
+					frames_per_second, *total_frame_count);
+
+	return 0;
+}
+
+static int playback_context_pre_process(struct context *ctx,
+					uint64_t *total_frame_count)
+{
+	snd_pcm_access_t access = 0;
+	snd_pcm_format_t sample_format;
+	unsigned int samples_per_frame;
+	unsigned int frames_per_second;
+	snd_pcm_uframes_t frames_per_buffer;
+	int i;
+	int err;
+
+	/* Initialize containers to retrieve parameters. */
+	for (i = 0; i < ctx->cntr_count; ++i) {
+		err = container_parser_init(ctx->cntrs + i, ctx->opts.paths[i],
+					    ctx->opts.verbose);
+		if (err < 0)
+			return err;
+
+		err = container_context_pre_process(ctx->cntrs + i,
+						    &sample_format,
+						    &samples_per_frame,
+						    &frames_per_second,
+						    total_frame_count);
+		if (err < 0)
+			return err;
+	}
+
+	/* Configure hardware with these parameters. */
+	err = xfer_context_pre_process(&ctx->xfer, &sample_format,
+				       &samples_per_frame, &frames_per_second,
+				       &access, &frames_per_buffer,
+				       ctx->opts.chmap, ctx->opts.vu_mode);
+	if (err < 0)
+		return err;
+
+	err = aligner_context_pre_process(&ctx->aligner, access, sample_format,
+					  samples_per_frame, frames_per_buffer,
+					  ctx->cntrs);
+	if (err < 0)
+		return err;
+
+	*total_frame_count = calculate_expected_frame_count(&ctx->opts,
+					frames_per_second, *total_frame_count);
+
+	return 0;
+}
+
+static int context_process_frames(struct context *ctx,
+				  uint64_t expected_frame_count,
+				  uint64_t *actual_frame_count)
+{
+	bool verbose = ctx->opts.verbose;
+	unsigned int frame_count;
+	bool emitted;
+	int i;
+	int err;
+
+	*actual_frame_count = 0;
+	while (!ctx->interrupted) {
+		/* Tell remains to expected frame count. */
+		frame_count = expected_frame_count - *actual_frame_count;
+		err = xfer_context_process_frames(&ctx->xfer, &ctx->aligner,
+						  ctx->cntrs, &frame_count);
+		if (err < 0) {
+			if (err == -EAGAIN || err == -EINTR)
+				continue;
+			break;
+		}
+		/* Perhaps, reach EOF of any container file for playback. */
+		if (frame_count == 0) {
+			struct container_context *cntr;
+			for (i = 0; i < ctx->cntr_count; ++i) {
+				cntr = &ctx->cntrs[i];
+				if (cntr->type != CONTAINER_TYPE_PARSER &&
+				    cntr->eof)
+					break;
+			}
+		}
+
+		*actual_frame_count += frame_count;
+		if (*actual_frame_count >= expected_frame_count)
+			break;
+	}
+
+	if (verbose) {
+		printf(_("Total frames: expected: %lu, actual: %lu\n"),
+		       expected_frame_count, *actual_frame_count);
+	}
+
+	return err;
+}
+
+static void context_post_process(struct context *ctx,
+				 uint64_t accumulated_frame_count)
+{
+	int i;
+
+	for (i = 0; i < ctx->cntr_count; ++i) {
+		container_context_post_process(ctx->cntrs + i,
+					       accumulated_frame_count);
+		container_context_destroy(ctx->cntrs + i);
+	}
+
+	xfer_context_post_process(&ctx->xfer);
+
+	aligner_context_post_process(&ctx->aligner);
+}
+
+static void context_destroy(struct context *ctx)
+{
+	context_options_destroy(&ctx->opts);
+
+	free(ctx->cntrs);
+
+	aligner_context_destroy(&ctx->aligner);
+	xfer_context_destroy(&ctx->xfer);
+}
+
+int subcmd_transfer(int argc, char *const *argv, snd_pcm_stream_t direction)
+{
+	struct context ctx = {0};
+
+	uint64_t expected_frame_count;
+	uint64_t actual_frame_count = 0;
+
+	int err = 0;
+
+	/* Renewed command system. */
+	if (argc > 2 && !strcmp(argv[1], "transfer")) {
+		/* Go ahead to parse file paths properly. */
+		--argc;
+		++argv;
+	}
+
+	err = prepare_signal_handler(&ctx);
+	if (err < 0)
+		return err;
+
+	err = context_options_init(&ctx.opts, argc, argv, direction);
+	if (err < 0)
+		return err;
+	if (ctx.opts.help) {
+		printf("xfer help.\n");
+		return 0;
+	}
+
+	err = context_init(&ctx, direction);
+	if (err < 0)
+		goto end;
+
+	if (direction == SND_PCM_STREAM_CAPTURE)
+		err = capture_context_pre_process(&ctx, &expected_frame_count);
+	else
+		err = playback_context_pre_process(&ctx, &expected_frame_count);
+	if (err < 0)
+		goto end;
+
+	err = context_process_frames(&ctx, expected_frame_count,
+				     &actual_frame_count);
+end:
+	context_post_process(&ctx, actual_frame_count);
+
+	context_destroy(&ctx);
+
+	if (ctx.interrupted) {
+		printf(_("Aborted by signal: %s\n"),
+		       strsignal(ctx.signal));
+		return 0;
+	}
+
+	return err;
+}
+
-- 
2.11.0
