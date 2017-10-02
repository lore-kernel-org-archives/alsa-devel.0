From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 24/39] axfer: add support for
	non-blocking operation
Date: Mon,  2 Oct 2017 09:19:25 +0900
Message-ID: <20171002001940.17218-25-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D564C266FC9
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

In alsa-lib PCM API, snd_pcm_read[i|n]() and snd_pcm_write[i|n] can be
used with non-blocking mode. This is available when SND_PCM_NONBLOCK is
used as 'mode' argument for a call of snd_pcm_open().

This commit adds support this type of operation. To reduce CPU usage, this
commit uses added waiter interface for event notification.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c               |   5 +-
 axfer/options.h               |   1 +
 axfer/xfer-libasound-irq-rw.c | 104 ++++++++++++++++++++++++++++++++++++++++--
 axfer/xfer-libasound.c        |  79 +++++++++++++++++++++++++++++++-
 axfer/xfer-libasound.h        |   4 ++
 5 files changed, 187 insertions(+), 6 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index 91708bb4..a8deaf98 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -289,7 +289,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:N";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -306,6 +306,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"format",		1, 0, 'f'},
 		{"channels",		1, 0, 'c'},
 		{"rate",		1, 0, 'r'},
+		{"nonblock",            0, 0, 'N'},
 		/* For debugging. */
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
@@ -348,6 +349,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->samples_per_frame = parse_l(optarg, &err);
 		else if (c == 'r')
 			opts->frames_per_second = parse_l(optarg, &err);
+		else if (c == 'N')
+			opts->nonblock = true;
 		else if (c == OPT_DUMP_HW_PARAMS)
 			opts->dump_hw_params = true;
 		else if (c == OPT_FATAL_ERRORS)
diff --git a/axfer/options.h b/axfer/options.h
index de9ac998..fc4f03c1 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -33,6 +33,7 @@ struct context_options {
 	snd_pcm_format_t sample_format;
 	unsigned int samples_per_frame;
 	unsigned int frames_per_second;
+	bool nonblock;
 
 	/* For debugging. */
 	bool dump_hw_params;
diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
index acbeaee9..afe2d34c 100644
--- a/axfer/xfer-libasound-irq-rw.c
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -169,6 +169,51 @@ error:
 	return err;
 }
 
+static int r_process_frames_nonblocking(struct libasound_state *state,
+					snd_pcm_state_t status,
+					unsigned int *frame_count,
+					struct mapper_context *mapper,
+					struct container_context *cntrs)
+{
+	snd_pcm_sframes_t avail;
+	snd_pcm_uframes_t avail_count;
+	int err = 0;
+
+	if (status != SND_PCM_STATE_RUNNING) {
+		err = snd_pcm_start(state->handle);
+		if (err < 0)
+			goto error;
+	}
+
+	/* Wait for hardware IRQ when no available space. */
+	err = waiter_context_wait_event(state->waiter, -1);
+	if (err < 0)
+		goto error;
+
+	/* Check available space on the buffer. */
+	avail = snd_pcm_avail(state->handle);
+	if (avail < 0) {
+		err = avail;
+		goto error;
+	}
+	avail_count = (snd_pcm_uframes_t)avail;
+
+	if (avail_count == 0) {
+		/* Let's go to a next iteration. */
+		err = 0;
+		goto error;
+	}
+
+	err = read_frames(state, frame_count, avail_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
 static int write_frames(struct libasound_state *state,
 			unsigned int *frame_count, unsigned int avail_count,
 			struct mapper_context *mapper,
@@ -286,6 +331,50 @@ error:
 	return err;
 }
 
+static int w_process_frames_nonblocking(struct libasound_state *state,
+					snd_pcm_state_t status,
+					unsigned int *frame_count,
+					struct mapper_context *mapper,
+					struct container_context *cntrs)
+{
+	snd_pcm_sframes_t avail;
+	unsigned int avail_count;
+	int err;
+
+	/* Wait for hardware IRQ when no left space. */
+	err = waiter_context_wait_event(state->waiter, -1);
+	if (err < 0)
+		goto error;
+
+	/* Check available space on the buffer. */
+	avail = snd_pcm_avail(state->handle);
+	if (avail < 0) {
+		err = avail;
+		goto error;
+	}
+	avail_count = (unsigned int)avail;
+
+	if (avail_count == 0) {
+		/* Let's go to a next iteration. */
+		err = 0;
+		goto error;
+	}
+
+	err = write_frames(state, frame_count, avail_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	/*
+	 * NOTE: The substream starts automatically when the accumulated number
+	 * of queued data frame exceeds start_threshold.
+	 */
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
 static int irq_rw_pre_process(struct libasound_state *state)
 {
 	struct frame_cache *cache = state->private_data;
@@ -350,10 +439,17 @@ static int irq_rw_pre_process(struct libasound_state *state)
 		return -ENXIO;
 	}
 
-	if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
-		cache->handle = r_process_frames_blocking;
-	else
-		cache->handle = w_process_frames_blocking;
+	if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE) {
+		if (state->nonblock)
+			cache->handle = r_process_frames_nonblocking;
+		else
+			cache->handle = r_process_frames_blocking;
+	} else {
+		if (state->nonblock)
+			cache->handle = w_process_frames_nonblocking;
+		else
+			cache->handle = w_process_frames_blocking;
+	}
 
 	return 0;
 }
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 7ffbc287..1987b573 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -9,6 +9,16 @@
 #include "xfer-libasound.h"
 #include "misc.h"
 
+static int get_mode(struct context_options *options)
+{
+	int mode = 0;
+
+	if (options->nonblock)
+		mode |= SND_PCM_NONBLOCK;
+
+	return mode;
+}
+
 static int set_access_hw_param(snd_pcm_t *handle,
 			       snd_pcm_hw_params_t *hw_params,
 			       struct context_options *opts)
@@ -34,6 +44,7 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 {
 	struct libasound_state *state = xfer->private_data;
 	char *node;
+	int mode;
 	int err;
 
 	err = snd_output_stdio_attach(&state->log, stderr, 0);
@@ -48,13 +59,25 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 	else
 		node = opts->node;
 
-	err = snd_pcm_open(&state->handle, node, direction, 0);
+	mode = get_mode(opts);
+	err = snd_pcm_open(&state->handle, node, direction, mode);
 	if (err < 0) {
 		logging(state, "Fail to open libasound PCM node for %s: %s\n",
 			snd_pcm_stream_name(direction), node);
 		return err;
 	}
 
+	state->nonblock = !!(mode & SND_PCM_NONBLOCK);
+	if (opts->nonblock) {
+		state->waiter = malloc(sizeof(*state->waiter));
+		if (state->waiter == NULL)
+			return -ENOMEM;
+
+		err = waiter_context_init(state->waiter, WAITER_TYPE_POLL);
+		if (err < 0)
+			return err;
+	}
+
 	err = snd_pcm_hw_params_malloc(&state->hw_params);
 	if (err < 0)
 		return err;
@@ -82,6 +105,40 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 	return set_access_hw_param(state->handle, state->hw_params, opts);
 }
 
+static int prepare_waiter(struct libasound_state *state)
+{
+	int fd_count;
+	int *fds;
+	struct pollfd *pfds;
+	int i;
+	int err;
+
+	fd_count = snd_pcm_poll_descriptors_count(state->handle);
+
+	fds = calloc(fd_count, sizeof(int));
+	if (fds == NULL)
+		return -ENOMEM;
+
+	pfds = calloc(fd_count, sizeof(struct pollfd));
+	if (pfds == NULL) {
+		free(fds);
+		return -ENOMEM;
+	}
+
+	err = snd_pcm_poll_descriptors(state->handle, pfds, fd_count);
+	if (err < 0)
+		goto end;
+
+	for (i = 0; i < fd_count; ++i)
+		fds[i] = pfds[i].fd;
+
+	err = waiter_context_prepare(state->waiter, fds, fd_count);
+end:
+	free(pfds);
+	free(fds);
+	return err;
+}
+
 static int configure_hw_params(struct libasound_state *state,
 			       snd_pcm_format_t format,
 			       unsigned int samples_per_frame,
@@ -254,6 +311,16 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return err;
 	}
 
+	if (state->waiter) {
+		/*
+		 * NOTE: This should be after configuring sw_params due to
+		 * timer descriptor.
+		 */
+		err = prepare_waiter(state);
+		if (err < 0)
+			return err;
+	}
+
 	if (xfer->verbose > 0)
 		snd_pcm_dump(state->handle, state->log);
 
@@ -341,7 +408,12 @@ static void xfer_libasound_post_process(struct xfer_context *xfer)
 				logging(state, "snd_pcm_drop(): %s\n",
 				       snd_strerror(err));
 		} else {
+			/* TODO: this is a bug in kernel land. */
+			if (state->nonblock)
+				snd_pcm_nonblock(state->handle, 0);
 			err = snd_pcm_drain(state->handle);
+			if (state->nonblock)
+				snd_pcm_nonblock(state->handle, 1);
 			if (err < 0)
 				logging(state, "snd_pcm_drain(): %s\n",
 				       snd_strerror(err));
@@ -366,6 +438,11 @@ static void xfer_libasound_destroy(struct xfer_context *xfer)
 {
 	struct libasound_state *state = xfer->private_data;
 
+	if (state->waiter)
+		waiter_context_destroy(state->waiter);
+	free(state->waiter);
+	state->waiter = NULL;
+
 	if (state->hw_params)
 		snd_pcm_hw_params_free(state->hw_params);
 	if (state->sw_params)
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 25768c41..342651d1 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -10,6 +10,7 @@
 #define __ALSA_UTILS_AXFER_XFER_LIBASOUND__H_
 
 #include "xfer.h"
+#include "waiter.h"
 
 #define logging(state, ...) \
 	snd_output_printf(state->log, __VA_ARGS__)
@@ -25,6 +26,9 @@ struct libasound_state {
 	snd_pcm_sw_params_t *sw_params;
 
 	bool running;
+	bool nonblock;
+
+	struct waiter_context *waiter;
 
 	const struct xfer_libasound_ops *ops;
 	void *private_data;
-- 
2.11.0
