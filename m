From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 17/39] axfer: add a sub-command to
	transfer data frames
Date: Mon,  2 Oct 2017 09:19:18 +0900
Message-ID: <20171002001940.17218-18-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C9956266EBF
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

In current aplay, default action is to transfer data frames from/to
devices. This commit adds support for this functionality.

Event loop is included in an added file. In the loop, the number of
handled data frames is manipulated by an appropriate way. As a result, users
can stop data transmission frames by frame.

At present, below command line options are supported as a minimal set:
 * --help (-h)
  * Just output 'help' string (not written yet).
 * --verbose (-v)
  * For verbose output, including information about xfer, mapper and
    container.
 * --file-type (-f): string. one of ['wav'|'au'|'voc'|'raw']
  * For format of files of given paths. For playback, this is optional
    because the format is auto-detected. For capture, this is optional too
    because the format is decided according to suffix of given path.
    Anyway, this option is used for cases to fail to detect or decide.
 * --separate-channels (-I)
  * When using several files as source or destination for data
    transmission, this option can be used with several file paths.
 * --device (-D): string
  * For PCM node in alsa-lib configuration. When this option is not used,
    'default' node is used for data transmission.
 * --format (-f): string. format literals or one of ['cd'|'cdr'|'dat']
  * For sample format supported by ALSA PCM interface. Special format
    can be used. For playback, this is auto-detected according to actual
    file format.
 * --channels (-c)
  * For the number of samples included in one data frame. For playback,
    this is auto-detected according to actual file format, except for
    'raw' format.
 * --rate (-r)
  * For the number of data frames transferred in one second. For playback,
    this is auto-detected according to actual file format, except for
    'raw' format.

When '--separate-channels' option is used, users can give several file
paths to source/destination of data transmission, else they can give single
file path for the purpose. When multiple files are handled by this option,
for playback, data frames in first channel is used to construct buffer for
data transmission with multi channel. For capture, data frames in each
channel of buffer is written to each of given path. Furthermore, when a
single path is given for capture, file paths are auto-generated according
to available number of channels. For example, 'name.wav' is given for
2 channels capture, 'name-0.wav' and 'name-1.wav' are generated. Without
suffix, 'name-0' and 'name-1' are generated.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am       |   3 +-
 axfer/main.c            |   2 +-
 axfer/subcmd-transfer.c | 470 ++++++++++++++++++++++++++++++++++++++++++++++++
 axfer/subcmd.h          |   2 +
 4 files changed, 475 insertions(+), 2 deletions(-)
 create mode 100644 axfer/subcmd-transfer.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index e928f796..b378442b 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -44,4 +44,5 @@ axfer_SOURCES = \
 	xfer.c \
 	xfer-libasound.h \
 	xfer-libasound.c \
-	xfer-libasound-irq-rw.c
+	xfer-libasound-irq-rw.c \
+	subcmd-transfer.c
diff --git a/axfer/main.c b/axfer/main.c
index 9bf02fd9..fecf397a 100644
--- a/axfer/main.c
+++ b/axfer/main.c
@@ -180,7 +180,7 @@ int main(int argc, char *const *argv)
 		decide_subcmd(argc, argv, &subcmd);
 
 	if (subcmd == SUBCMD_TRANSFER)
-		printf("execute 'transfer' subcmd.\n");
+		err = subcmd_transfer(argc, argv, direction);
 	else if (subcmd == SUBCMD_LIST)
 		err = subcmd_list(argc, argv, direction);
 	else if (subcmd == SUBCMD_VERSION)
diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
new file mode 100644
index 00000000..5ce312e0
--- /dev/null
+++ b/axfer/subcmd-transfer.c
@@ -0,0 +1,470 @@
+/*
+ * subcmd-transfer.c - operations for transfer sub command.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer.h"
+#include "subcmd.h"
+#include "misc.h"
+
+#include <signal.h>
+
+struct context {
+	struct xfer_context xfer;
+	struct mapper_context mapper;
+	struct container_context *cntrs;
+	unsigned int cntr_count;
+
+	struct context_options opts;
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
+	 * 2. Prepare for default handler(SIG_DFL) of SIGTSTP to stop this
+	 * process.
+	 */
+	if (sigaction(SIGTSTP, NULL, &sa) < 0) {
+		fprintf(stderr, "sigaction(2)\n");
+		exit(EXIT_FAILURE);
+	}
+	if (sa.sa_handler == SIG_ERR)
+		exit(EXIT_FAILURE);
+	if (sa.sa_handler == handle_unix_signal_for_suspend)
+		sa.sa_handler = SIG_DFL;
+	if (sigaction(SIGTSTP, &sa, NULL) < 0) {
+		fprintf(stderr, "sigaction(2)\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Queue SIGTSTP. */
+	raise(SIGTSTP);
+
+	/*
+	 * Release the queued signal from being blocked. This causes an
+	 * additional interrupt for the default handler.
+	 */
+	sigemptyset(&curr);
+	sigaddset(&curr, SIGTSTP);
+	if (sigprocmask(SIG_UNBLOCK, &curr, &prev) < 0) {
+		fprintf(stderr, "sigprocmask(2)\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/*
+	 * 3. SIGCONT is cought and rescheduled. Recover blocking status of
+	 * UNIX signals.
+	 */
+	if (sigprocmask(SIG_SETMASK, &prev, NULL) < 0) {
+		fprintf(stderr, "sigprocmask(2)\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Reconfigure this handler for SIGTSTP, instead of default one. */
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sa.sa_handler = handle_unix_signal_for_suspend;
+	if (sigaction(SIGTSTP, &sa, NULL) < 0) {
+		fprintf(stderr, "sigaction(2)\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* 4. Continue the PCM substream. */
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
+	/* Initialize transfer. */
+	return xfer_context_init(&ctx->xfer, XFER_TYPE_LIBASOUND, direction,
+				 &ctx->opts);
+}
+
+static int capture_pre_process(struct context *ctx, snd_pcm_access_t *access,
+			       snd_pcm_format_t *sample_format,
+			       unsigned int *samples_per_frame,
+			       unsigned int *frames_per_second,
+			       snd_pcm_uframes_t *frames_per_buffer,
+			       uint64_t *total_frame_count)
+{
+	unsigned int channels;
+	int i;
+	int err;
+
+	/*
+	 * Use given options for common parameters. Else, leave the decition to
+	 * each backend.
+	 */
+	if (ctx->opts.sample_format != SND_PCM_FORMAT_UNKNOWN)
+		*sample_format = ctx->opts.sample_format;
+	if (ctx->opts.samples_per_frame > 0)
+		*samples_per_frame = ctx->opts.samples_per_frame;
+	if (ctx->opts.frames_per_second > 0)
+		*frames_per_second = ctx->opts.frames_per_second;
+
+	err = xfer_context_pre_process(&ctx->xfer, sample_format,
+				       samples_per_frame, frames_per_second,
+				       access, frames_per_buffer);
+	if (err < 0)
+		return err;
+
+	err = context_options_fixup_for_capture(&ctx->opts, *samples_per_frame);
+	if (err < 0)
+		return err;
+
+	ctx->cntr_count = ctx->opts.path_count;
+	if (ctx->cntr_count > 1)
+		channels = 1;
+	else
+		channels = *samples_per_frame;
+
+	/* Prepare for containers. */
+	ctx->cntrs = calloc(ctx->cntr_count, sizeof(*ctx->cntrs));
+	if (ctx->cntrs == NULL)
+		return -ENOMEM;
+
+	*total_frame_count = 0;
+	for (i = 0; i < ctx->cntr_count; ++i) {
+		uint64_t frame_count;
+
+		err = container_builder_init(ctx->cntrs + i, ctx->opts.paths[i],
+					     ctx->opts.cntr_format,
+					     ctx->opts.verbose > 1);
+		if (err < 0)
+			return err;
+
+		err = container_context_pre_process(ctx->cntrs + i,
+						    sample_format, &channels,
+						    frames_per_second,
+						    &frame_count);
+		if (err < 0)
+			return err;
+
+		if (*total_frame_count == 0)
+			*total_frame_count = frame_count;
+		if (frame_count < *total_frame_count)
+			*total_frame_count = frame_count;
+	}
+
+	return 0;
+}
+
+static int playback_pre_process(struct context *ctx, snd_pcm_access_t *access,
+				snd_pcm_format_t *sample_format,
+				unsigned int *samples_per_frame,
+				unsigned int *frames_per_second,
+				snd_pcm_uframes_t *frames_per_buffer,
+				uint64_t *total_frame_count)
+{
+	int i;
+	int err;
+
+	/* Prepare for containers. */
+	ctx->cntrs = calloc(ctx->opts.path_count, sizeof(*ctx->cntrs));
+	if (ctx->cntrs == NULL)
+		return -ENOMEM;
+	ctx->cntr_count = ctx->opts.path_count;
+
+	for (i = 0; i < ctx->cntr_count; ++i) {
+		snd_pcm_format_t format;
+		unsigned int channels;
+		unsigned int rate;
+		uint64_t frame_count;
+
+		err = container_parser_init(ctx->cntrs + i, ctx->opts.paths[i],
+					    ctx->opts.verbose > 1);
+		if (err < 0)
+			return err;
+
+		if (i == 0) {
+			/* For a raw container. */
+			format = ctx->opts.sample_format;
+			channels = ctx->opts.samples_per_frame;
+			rate = ctx->opts.frames_per_second;
+		} else {
+			format = *sample_format;
+			channels = *samples_per_frame;
+			rate = *frames_per_second;
+		}
+
+		err = container_context_pre_process(ctx->cntrs + i, &format,
+						    &channels, &rate,
+						    &frame_count);
+		if (err < 0)
+			return err;
+
+		if (format == SND_PCM_FORMAT_UNKNOWN || channels == 0 ||
+		    rate == 0) {
+			fprintf(stderr,
+				_("Sample format, channels and rate should be "
+				"indicated for given files.\n"));
+			return -EINVAL;
+		}
+
+		if (i == 0) {
+			*sample_format = format;
+			*samples_per_frame = channels;
+			*frames_per_second = rate;
+			*total_frame_count = frame_count;
+		} else {
+			if (format != *sample_format) {
+				fprintf(stderr,
+					_("When using several files, they "
+					  "should include the same sample "
+					  "format.\n"));
+				return -EINVAL;
+			}
+			/*
+			 * No need to check channels to handle multiple
+			 * containers.
+			 */
+			if (rate != *frames_per_second) {
+				fprintf(stderr,
+					_("When using several files, they "
+					  "should include samples at the same "
+					  "sampling rate.\n"));
+				return -EINVAL;
+			}
+			if (frame_count < *total_frame_count)
+				*total_frame_count = frame_count;
+		}
+	}
+
+	if (ctx->cntr_count > 1)
+		*samples_per_frame = ctx->cntr_count;
+	err = context_options_fixup_for_playback(&ctx->opts, *sample_format,
+						 *samples_per_frame,
+						 *frames_per_second);
+	if (err < 0)
+		return err;
+
+	/* Configure hardware with these parameters. */
+	err = xfer_context_pre_process(&ctx->xfer, sample_format,
+				       samples_per_frame, frames_per_second,
+				       access, frames_per_buffer);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int context_pre_process(struct context *ctx, snd_pcm_stream_t direction,
+			       uint64_t *total_frame_count)
+{
+	snd_pcm_access_t access;
+	snd_pcm_format_t sample_format = SND_PCM_FORMAT_UNKNOWN;
+	unsigned int samples_per_frame = 0;
+	unsigned int frames_per_second = 0;
+	snd_pcm_uframes_t frames_per_buffer = 0;
+	unsigned int bytes_per_sample = 0;
+	enum mapper_type mapper_type;
+	int err;
+
+	if (direction == SND_PCM_STREAM_CAPTURE) {
+		mapper_type = MAPPER_TYPE_DEMUXER;
+		err = capture_pre_process(ctx, &access, &sample_format,
+					  &samples_per_frame,
+					  &frames_per_second,
+					  &frames_per_buffer,
+					  total_frame_count);
+	} else {
+		mapper_type = MAPPER_TYPE_MUXER;
+		err = playback_pre_process(ctx, &access, &sample_format,
+					   &samples_per_frame,
+					   &frames_per_second,
+					   &frames_per_buffer,
+					   total_frame_count);
+	}
+	if (err < 0)
+		return err;
+
+	/* Prepare for mapper. */
+	err = mapper_context_init(&ctx->mapper, mapper_type, ctx->cntr_count,
+				  ctx->opts.verbose > 1);
+	if (err < 0)
+		return err;
+
+	bytes_per_sample = snd_pcm_format_physical_width(sample_format) / 8;
+	if (bytes_per_sample <= 0)
+		return -ENXIO;
+	err = mapper_context_pre_process(&ctx->mapper, access, bytes_per_sample,
+					  samples_per_frame, frames_per_buffer,
+					  ctx->cntrs);
+	if (err < 0)
+		return err;
+
+	ctx->opts.sample_format = sample_format;
+	ctx->opts.samples_per_frame = samples_per_frame;
+	ctx->opts.frames_per_second = frames_per_second;
+
+	return 0;
+}
+
+static int context_process_frames(struct context *ctx,
+				  snd_pcm_stream_t direction,
+				  uint64_t expected_frame_count,
+				  uint64_t *actual_frame_count)
+{
+	bool verbose = ctx->opts.verbose > 2;
+	unsigned int frame_count;
+	int i;
+	int err = 0;
+
+	*actual_frame_count = 0;
+	while (!ctx->interrupted) {
+		struct container_context *cntr;
+
+		/* Tell remains to expected frame count. */
+		frame_count = expected_frame_count - *actual_frame_count;
+		err = xfer_context_process_frames(&ctx->xfer, &ctx->mapper,
+						  ctx->cntrs, &frame_count);
+		if (err < 0) {
+			if (err == -EAGAIN || err == -EINTR)
+				continue;
+			break;
+		}
+		if (verbose) {
+			fprintf(stderr,
+				"  handled: %u\n", frame_count);
+		}
+		for (i = 0; i < ctx->cntr_count; ++i) {
+			cntr = &ctx->cntrs[i];
+			if (cntr->eof)
+				break;
+		}
+		if (i < ctx->cntr_count)
+			break;
+
+		*actual_frame_count += frame_count;
+		if (*actual_frame_count >= expected_frame_count)
+			break;
+	}
+
+	return err;
+}
+
+static void context_post_process(struct context *ctx,
+				 uint64_t accumulated_frame_count)
+{
+	uint64_t total_frame_count;
+	int i;
+
+	xfer_context_post_process(&ctx->xfer);
+
+	if (ctx->cntrs) {
+		for (i = 0; i < ctx->cntr_count; ++i) {
+			container_context_post_process(ctx->cntrs + i,
+						       &total_frame_count);
+			container_context_destroy(ctx->cntrs + i);
+		}
+		free(ctx->cntrs);
+	}
+
+	mapper_context_post_process(&ctx->mapper);
+	mapper_context_destroy(&ctx->mapper);
+}
+
+static void context_destroy(struct context *ctx)
+{
+	xfer_context_destroy(&ctx->xfer);
+	context_options_destroy(&ctx->opts);
+}
+
+int subcmd_transfer(int argc, char *const *argv, snd_pcm_stream_t direction)
+{
+	struct context ctx = {0};
+
+	uint64_t expected_frame_count = 0;
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
+	err = context_options_init(&ctx.opts, argc, argv, direction);
+	if (err < 0)
+		return err;
+	if (ctx.opts.help) {
+		printf("xfer help.\n");
+		return 0;
+	}
+
+	err = prepare_signal_handler(&ctx);
+	if (err < 0)
+		return err;
+
+	err = context_init(&ctx, direction);
+	if (err < 0)
+		goto end;
+
+	err = context_pre_process(&ctx, direction, &expected_frame_count);
+	if (err < 0)
+		goto end;
+
+	err = context_process_frames(&ctx, direction, expected_frame_count,
+				     &actual_frame_count);
+end:
+	context_post_process(&ctx, actual_frame_count);
+
+	context_destroy(&ctx);
+
+	return err;
+}
diff --git a/axfer/subcmd.h b/axfer/subcmd.h
index 940d6814..25bfa4f8 100644
--- a/axfer/subcmd.h
+++ b/axfer/subcmd.h
@@ -13,4 +13,6 @@
 
 int subcmd_list(int argc, char *const *argv, snd_pcm_stream_t direction);
 
+int subcmd_transfer(int argc, char *const *argv, snd_pcm_stream_t direction);
+
 #endif
-- 
2.11.0
