From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 14/23] aplay: add an implementation for
	transferring by ALSA PCM APIs
Date: Thu, 17 Aug 2017 20:59:55 +0900
Message-ID: <20170817120004.15326-15-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1AB9B266EEA
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:13 +0200 (CEST)
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

This commit adds an implementation of xfer to transfer data frames
via ALSA PCM interface. Actually, APIs in alsa-lib are used. Hardware
and software parameters are configured directly by this implementation.
There're two ways to handle PCM frames; on mapped page frames or call
system call with buffer in user space. For these ways, this
implementation has an abstraction named as 'xfer_alsa_io_ops'.

Furthermore, in a recent decade, timer-based scheduling model is
introduced by PulseAudio developers. To support this model, this
implementation has an abstraction named as 'xfer_alsa_sched_ops'.
---
 aplay/Makefile.am |   7 +-
 aplay/xfer-alsa.c | 537 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/xfer-alsa.h |  57 ++++++
 aplay/xfer.c      |   2 +-
 4 files changed, 600 insertions(+), 3 deletions(-)
 create mode 100644 aplay/xfer-alsa.c
 create mode 100644 aplay/xfer-alsa.h

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 9056f56..9108049 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -11,7 +11,8 @@ noinst_HEADERS = \
 	aligner.h \
 	waiter.h \
 	options.h \
-	xfer.h
+	xfer.h \
+	xfer-alsa.h
 
 aplay_SOURCES = \
 	formats.h \
@@ -32,7 +33,9 @@ aplay_SOURCES = \
 	options.h \
 	options.c \
 	xfer.h \
-	xfer.c
+	xfer.c \
+	xfer-alsa.h \
+	xfer-alsa.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/xfer-alsa.c b/aplay/xfer-alsa.c
new file mode 100644
index 0000000..4a84153
--- /dev/null
+++ b/aplay/xfer-alsa.c
@@ -0,0 +1,537 @@
+/*
+ * xfer-alsa.c - receive/transmit frames by ALSA.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer-alsa.h"
+#include <gettext.h>
+
+static int get_mode(struct context_options *options)
+{
+	int mode = 0;
+
+	if (options->nonblock)
+		mode |= SND_PCM_NONBLOCK;
+	if (options->no_auto_resample)
+		mode |= SND_PCM_NO_AUTO_RESAMPLE;
+	if (options->no_auto_channels)
+		mode |= SND_PCM_NO_AUTO_CHANNELS;
+	if (options->no_auto_format)
+		mode |= SND_PCM_NO_AUTO_FORMAT;
+	if (options->no_softvol)
+		mode |= SND_PCM_NO_SOFTVOL;
+
+	return mode;
+}
+
+static int set_access_hw_param(snd_pcm_t *handle,
+			       snd_pcm_hw_params_t *hw_params,
+			       struct context_options *opts)
+{
+	snd_pcm_access_mask_t *mask;
+	int err;
+
+	err = snd_pcm_access_mask_malloc(&mask);
+	if (err < 0)
+		return err;
+	snd_pcm_access_mask_none(mask);
+	if (opts->mmap) {
+		snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_INTERLEAVED);
+		snd_pcm_access_mask_set(mask,
+					SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
+	} else {
+		snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_INTERLEAVED);
+		snd_pcm_access_mask_set(mask,
+					SND_PCM_ACCESS_RW_NONINTERLEAVED);
+	}
+	err = snd_pcm_hw_params_set_access_mask(handle, hw_params, mask);
+	snd_pcm_access_mask_free(mask);
+
+	return err;
+}
+
+static void dump_available_hw_params(snd_pcm_hw_params_t *hw_params,
+				     const char *const node)
+{
+	unsigned int min_i, max_i;
+	snd_pcm_uframes_t min_l, max_l;
+	snd_pcm_access_mask_t *access_mask;
+	snd_pcm_format_mask_t *format_mask;
+	snd_pcm_subformat_mask_t *subformat_mask;
+	int i;
+	int err;
+
+	printf("Avail params for node: %s\n", node);
+
+	err = snd_pcm_hw_params_get_channels_min(hw_params, &min_i);
+	if (err < 0)
+		return;
+	err = snd_pcm_hw_params_get_channels_max(hw_params, &max_i);
+	if (err < 0)
+		return;
+	printf("  samples/frame: %u to %u\n", min_i, max_i);
+
+	err = snd_pcm_hw_params_get_rate_min(hw_params, &min_i, NULL);
+	if (err < 0)
+		return;
+	err = snd_pcm_hw_params_get_rate_max(hw_params, &max_i, NULL);
+	if (err < 0)
+		return;
+	printf("  frames/second: %u to %u\n", min_i, max_i);
+
+	err = snd_pcm_hw_params_get_period_time_min(hw_params, &min_i, NULL);
+	if (err < 0)
+		return;
+	err = snd_pcm_hw_params_get_period_time_max(hw_params, &max_i, NULL);
+	if (err < 0)
+		return;
+	printf("  msec/period: %u to %u\n", min_i, max_i);
+
+	err = snd_pcm_hw_params_get_period_size_min(hw_params, &min_l, NULL);
+	if (err < 0)
+		return;
+	err = snd_pcm_hw_params_get_period_size_max(hw_params, &max_l, NULL);
+	if (err < 0)
+		return;
+	printf("  frames/period: %lu to %lu\n", min_l, max_l);
+
+	err = snd_pcm_hw_params_get_periods_min(hw_params, &min_i, NULL);
+	if (err < 0)
+		return;
+	err = snd_pcm_hw_params_get_periods_max(hw_params, &max_i, NULL);
+	if (err < 0)
+		return;
+	printf("  periods/buffer: %u to %u\n", min_i, max_i);
+
+	err = snd_pcm_hw_params_get_buffer_time_min(hw_params, &min_i, NULL);
+	if (err < 0)
+		return;
+	err = snd_pcm_hw_params_get_buffer_time_max(hw_params, &max_i, NULL);
+	if (err < 0)
+		return;
+	printf("  msec/buffer: %u to %u\n", min_i, max_i);
+
+	err = snd_pcm_hw_params_get_buffer_size_min(hw_params, &min_l);
+	if (err < 0)
+		return;
+	err = snd_pcm_hw_params_get_buffer_size_max(hw_params, &max_l);
+	if (err < 0)
+		return;
+	printf("  frames/buffer: %lu to %lu\n", min_l, max_l);
+
+	err = snd_pcm_access_mask_malloc(&access_mask);
+	if (err < 0)
+		return;
+	err = snd_pcm_hw_params_get_access_mask(hw_params, access_mask);
+	if (err < 0)
+		return;
+	printf("  supported access methods:\n");
+	for (i = 0; i <= SND_PCM_ACCESS_LAST; ++i) {
+		if (!snd_pcm_access_mask_test(access_mask, i))
+			continue;
+		printf("    '%s'\n", snd_pcm_access_name(i));
+	}
+	snd_pcm_access_mask_free(access_mask);
+
+	err = snd_pcm_format_mask_malloc(&format_mask);
+	if (err < 0)
+		return;
+	snd_pcm_hw_params_get_format_mask(hw_params, format_mask);
+	printf("  supported sample formats:\n");
+	for (i = 0; i <= SND_PCM_FORMAT_LAST; ++i) {
+		if (!snd_pcm_format_mask_test(format_mask, i))
+			continue;
+		printf("    '%s'\n", snd_pcm_format_name(i));
+	}
+	snd_pcm_format_mask_free(format_mask);
+
+	err = snd_pcm_subformat_mask_malloc(&subformat_mask);
+	if (err < 0)
+		return;
+	snd_pcm_hw_params_get_subformat_mask(hw_params, subformat_mask);
+	printf("  supported sample sub-formats:\n");
+	for (i = 0; i <= SND_PCM_SUBFORMAT_LAST; ++i) {
+		if (!snd_pcm_subformat_mask_test(subformat_mask, i))
+			continue;
+		printf("    '%s'\n", snd_pcm_subformat_name(i));
+	}
+	printf("\n");
+}
+
+static int xfer_alsa_init(struct xfer_context *xfer,
+			  snd_pcm_stream_t direction,
+			  struct context_options *opts)
+{
+	struct alsa_state *state = xfer->private_data;
+	char *node;
+	int mode = 0;
+	int err;
+
+	state->verbose = xfer->verbose;
+
+	if (opts->node == NULL)
+		node = "default";
+	else
+		node = opts->node;
+
+	mode = get_mode(opts);
+	if (mode & SND_PCM_NONBLOCK) {
+		state->waiter = malloc(sizeof(*state->waiter));
+		if (state->waiter == NULL)
+			return -ENOMEM;
+
+		/* TODO: configurable. */
+		err = waiter_context_init(state->waiter, WAITER_TYPE_POLL);
+		if (err < 0)
+			return err;
+	}
+
+	err = snd_pcm_open(&state->handle, node, direction, mode);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_malloc(&state->hw_params);
+	if (err < 0)
+		return err;
+	err = snd_pcm_sw_params_malloc(&state->sw_params);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_any(state->handle, state->hw_params);
+	if (err < 0)
+		return err;
+
+	if (xfer->verbose)
+		dump_available_hw_params(state->hw_params, node);
+
+	return set_access_hw_param(state->handle, state->hw_params, opts);
+}
+
+static int prepare_waiter(struct alsa_state *state)
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
+static int configure_requested_params(struct alsa_state *state,
+				      snd_pcm_format_t format,
+				      unsigned int samples_per_frame,
+				      unsigned int frames_per_second)
+{
+	int err;
+
+	if (format != SND_PCM_FORMAT_UNKNOWN) {
+		err = snd_pcm_hw_params_set_format(state->handle,
+						   state->hw_params, format);
+		if (err < 0) {
+			printf(_("Sample format '%s' is not available: %s\n"),
+			       snd_pcm_format_name(format), snd_strerror(err));
+			return err;
+		}
+	}
+
+	if (samples_per_frame > 0) {
+		err = snd_pcm_hw_params_set_channels(state->handle,
+						     state->hw_params,
+						     samples_per_frame);
+		if (err < 0) {
+			printf(_("Channels count '%u' is not available: %s\n"),
+			       samples_per_frame, snd_strerror(err));
+			return err;
+		}
+	}
+
+	if (frames_per_second > 0) {
+		err = snd_pcm_hw_params_set_rate(state->handle,
+						 state->hw_params,
+						 frames_per_second, 0);
+		if (err < 0) {
+			printf(_("Sampling rate '%u' is not available: %s\n"),
+			       frames_per_second, snd_strerror(err));
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int retrieve_actual_params(snd_pcm_hw_params_t *hw_params,
+				  snd_pcm_format_t *format,
+				  unsigned int *samples_per_frame,
+				  unsigned int *frames_per_second,
+				  snd_pcm_access_t *access,
+				  snd_pcm_uframes_t *frames_per_buffer)
+{
+	int err;
+
+	err = snd_pcm_hw_params_get_format(hw_params, format);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_channels(hw_params,
+					     samples_per_frame);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_rate(hw_params, frames_per_second,
+					 NULL);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_access(hw_params, access);
+	if (err < 0)
+		return err;
+
+	return snd_pcm_hw_params_get_buffer_size(hw_params, frames_per_buffer);
+}
+
+static void dump_sw_params(struct alsa_state *state)
+{
+	snd_pcm_uframes_t val_l;
+	int val_i;
+	int err;
+
+	printf("sw params\n");
+
+	err = snd_pcm_sw_params_get_avail_min(state->sw_params, &val_l);
+	if (err < 0)
+		return;
+	printf("  avail-min: %lu\n", val_l);
+
+	err = snd_pcm_sw_params_get_period_event(state->sw_params, &val_i);
+	if (err < 0)
+		return;
+	printf("  period-event: %d\n", val_i);
+
+	err = snd_pcm_sw_params_get_start_threshold(state->sw_params, &val_l);
+	if (err < 0)
+		return;
+	printf("  start-threshold: %lu\n", val_l);
+
+	err = snd_pcm_sw_params_get_stop_threshold(state->sw_params, &val_l);
+	if (err < 0)
+		return;
+	printf("  stop-threshold: %lu\n", val_l);
+
+	err = snd_pcm_sw_params_get_silence_threshold(state->sw_params, &val_l);
+	if (err < 0)
+		return;
+	printf("  silence-threshold: %lu\n", val_l);
+
+	err = snd_pcm_sw_params_get_silence_size(state->sw_params, &val_l);
+	if (err < 0)
+		return;
+	printf("  silence-size: %lu\n", val_l);
+
+	printf("\n");
+}
+
+static int xfer_alsa_pre_process(struct xfer_context *xfer,
+				 snd_pcm_format_t *format,
+				 unsigned int *samples_per_frame,
+				 unsigned int *frames_per_second,
+				 snd_pcm_access_t *access,
+				 snd_pcm_uframes_t *frames_per_buffer)
+{
+	struct alsa_state *state = xfer->private_data;
+	int err;
+
+	err = configure_requested_params(state, *format, *samples_per_frame,
+					 *frames_per_second);
+	if (err < 0)
+		return err;
+
+	/* Configure hardware parameters. */
+	err = snd_pcm_hw_params(state->handle, state->hw_params);
+	if (err < 0)
+		return err;
+
+	/* Retrieve actual parameters. */
+	err = retrieve_actual_params(state->hw_params, format,
+				     samples_per_frame, frames_per_second,
+				     access, frames_per_buffer);
+	if (err < 0)
+		return err;
+	state->frames_per_buffer = *frames_per_buffer;
+
+	/* Query software parameters. */
+	err = snd_pcm_sw_params_current(state->handle, state->sw_params);
+	if (err < 0)
+		return err;
+
+	/* Assign I/O operation. */
+	if (state->io_ops->private_size > 0) {
+		state->io_private_data = malloc(state->io_ops->private_size);
+		if (state->io_private_data == NULL)
+			return -ENOMEM;
+		memset(state->io_private_data, 0, state->io_ops->private_size);
+	}
+	state->access = *access;
+	err = state->io_ops->pre_process(state);
+	if (err < 0)
+		return err;
+
+	/* Assign scheduling operation. */
+	err = state->sched_ops->pre_process(xfer);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_sw_params(state->handle, state->sw_params);
+	if (err < 0)
+		return err;
+
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
+	if (xfer->verbose)
+		dump_sw_params(state);
+
+	return 0;
+}
+
+static int xfer_alsa_process_frames(struct xfer_context *xfer,
+				    unsigned int *frame_count,
+				    struct aligner_context *aligner,
+				    struct container_context *cntrs)
+{
+	struct alsa_state *state = xfer->private_data;
+	int err;
+	err = state->io_ops->process_frames(state, frame_count, aligner, cntrs);
+	if (err < 0) {
+		if (err == -EPIPE)
+			err = snd_pcm_prepare(state->handle);
+	}
+
+	return err;
+}
+
+static void xfer_alsa_pause(struct xfer_context *xfer, bool enable)
+{
+	struct alsa_state *state = xfer->private_data;
+	snd_pcm_state_t s = snd_pcm_state(state->handle);
+	int err;
+
+	if (enable) {
+		if (s != SND_PCM_STATE_RUNNING)
+			return;
+	} else {
+		if (s != SND_PCM_STATE_PAUSED)
+			return;
+	}
+
+	/* Not supported. Leave the substream to enter XRUN state. */
+	if (!snd_pcm_hw_params_can_pause(state->hw_params))
+		return;
+
+	err = snd_pcm_pause(state->handle, enable);
+	if (err < 0 && xfer->verbose > 0) {
+		printf("snd_pcm_pause(): %s\n",
+		       snd_strerror(err));
+	}
+}
+
+static void xfer_alsa_post_process(struct xfer_context *xfer)
+{
+	struct alsa_state *state = xfer->private_data;
+	snd_pcm_state_t pcm_state;
+	int err;
+
+	pcm_state = snd_pcm_state(state->handle);
+	if (pcm_state != SND_PCM_STATE_OPEN &&
+	    pcm_state != SND_PCM_STATE_DISCONNECTED) {
+		if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE) {
+			err = snd_pcm_drop(state->handle);
+			if (err < 0)
+				printf("snd_pcm_drop(): %s\n",
+				       snd_strerror(err));
+		} else {
+			err = snd_pcm_drain(state->handle);
+			if (err < 0)
+				printf("snd_pcm_drain(): %s\n",
+				       snd_strerror(err));
+		}
+	}
+
+	err = snd_pcm_hw_free(state->handle);
+	if (err < 0)
+		printf("snd_pcm_hw_free(): %s\n", snd_strerror(err));
+
+	snd_pcm_close(state->handle);
+	state->handle = NULL;
+
+	if (state->io_ops && state->io_ops->post_process)
+		state->io_ops->post_process(state);
+	if (state->io_private_data)
+		free(state->io_private_data);
+	state->io_private_data = NULL;
+
+	if (state->waiter)
+		waiter_context_release(state->waiter);
+}
+
+static void xfer_alsa_destroy(struct xfer_context *xfer)
+{
+	struct alsa_state *state = xfer->private_data;
+
+	if (state->waiter)
+		waiter_context_destroy(state->waiter);
+	free(state->waiter);
+	state->waiter = NULL;
+
+	if (state->hw_params)
+		snd_pcm_hw_params_free(state->hw_params);
+	if (state->sw_params)
+		snd_pcm_sw_params_free(state->sw_params);
+	state->hw_params = NULL;
+	state->sw_params = NULL;
+}
+
+const struct xfer_data xfer_alsa = {
+	.ops = {
+		.init		= xfer_alsa_init,
+		.pre_process	= xfer_alsa_pre_process,
+		.process_frames	= xfer_alsa_process_frames,
+		.pause		= xfer_alsa_pause,
+		.post_process	= xfer_alsa_post_process,
+		.destroy	= xfer_alsa_destroy,
+	},
+	.private_size = sizeof(struct alsa_state),
+};
diff --git a/aplay/xfer-alsa.h b/aplay/xfer-alsa.h
new file mode 100644
index 0000000..10c417b
--- /dev/null
+++ b/aplay/xfer-alsa.h
@@ -0,0 +1,57 @@
+/*
+ * xfer-alsa.h - a header for receiver/transmitter of frames by ALSA.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_APLAY_XFER_ALSA__H_
+#define __ALSA_UTILS_APLAY_XFER_ALSA__H_
+
+#include "xfer.h"
+#include "waiter.h"
+
+enum xfer_alsa_sched_mode {
+	XFER_ALSA_SCHED_MODE_IRQ = 0,
+	XFER_ALSA_SCHED_MODE_TIMER,
+};
+
+struct xfer_alsa_io_ops;
+struct xfer_alsa_sched_ops;
+
+struct alsa_state {
+	snd_pcm_t *handle;
+	snd_pcm_hw_params_t *hw_params;
+	snd_pcm_sw_params_t *sw_params;
+
+	struct waiter_context *waiter;
+
+	snd_pcm_access_t access;
+	snd_pcm_uframes_t frames_per_buffer;
+	bool running;
+
+	const struct xfer_alsa_io_ops *io_ops;
+	void *io_private_data;
+
+	const struct xfer_alsa_sched_ops *sched_ops;
+	void *private_data;
+
+	bool verbose;
+};
+
+struct xfer_alsa_io_ops {
+	int (*pre_process)(struct alsa_state *state);
+	int (*process_frames)(struct alsa_state *state,
+			      unsigned int *frame_count,
+			      struct aligner_context *aligner,
+			      struct container_context *cntrs);
+	void (*post_process)(struct alsa_state *state);
+	unsigned int private_size;
+};
+
+struct xfer_alsa_sched_ops {
+	int (*pre_process)(struct xfer_context *xfer);
+};
+
+#endif
diff --git a/aplay/xfer.c b/aplay/xfer.c
index 3fe094e..977f00a 100644
--- a/aplay/xfer.c
+++ b/aplay/xfer.c
@@ -21,7 +21,7 @@ int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
 		enum xfer_type type;
 		const struct xfer_data *data;
 	} entries[] = {
-		{XFER_TYPE_ALSA, NULL},
+		{XFER_TYPE_ALSA, &xfer_alsa},
 	};
 	int i;
 
-- 
2.11.0
