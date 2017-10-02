From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 15/39] axfer: add support to transfer
	data frames by alsa-lib PCM APIs
Date: Mon,  2 Oct 2017 09:19:16 +0900
Message-ID: <20171002001940.17218-16-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 52524266FE1
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 02:19:54 +0200 (CEST)
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

This commit adds support fo alsa-lib PCM API as a backend of 'xfer'
module. In a set of alsa-lib PCM API, there're two ways to handle data
frames; by calling ioctl(2) with some specific commands and buffer in
user space, or copying data frames on mapped page frames. To support
these two ways, this commit adds operation structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am      |   7 +-
 axfer/xfer-libasound.c | 374 +++++++++++++++++++++++++++++++++++++++++++++++++
 axfer/xfer-libasound.h |  45 ++++++
 axfer/xfer.c           |   4 +-
 axfer/xfer.h           |   4 +-
 5 files changed, 428 insertions(+), 6 deletions(-)
 create mode 100644 axfer/xfer-libasound.c
 create mode 100644 axfer/xfer-libasound.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index c1534411..ab4e3ae1 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -20,7 +20,8 @@ noinst_HEADERS = \
 	container.h \
 	mapper.h
 	options.h \
-	xfer.h
+	xfer.h \
+	xfer-alsa.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -40,4 +41,6 @@ axfer_SOURCES = \
 	options.h \
 	options.c \
 	xfer.h \
-	xfer.c
+	xfer.c \
+	xfer-libasound.h \
+	xfer-libasound.c
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
new file mode 100644
index 00000000..66e8e1de
--- /dev/null
+++ b/axfer/xfer-libasound.c
@@ -0,0 +1,374 @@
+/*
+ * xfer-libasound.c - receive/transmit frames by alsa-lib.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer-libasound.h"
+#include "misc.h"
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
+	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_INTERLEAVED);
+	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_NONINTERLEAVED);
+	err = snd_pcm_hw_params_set_access_mask(handle, hw_params, mask);
+	snd_pcm_access_mask_free(mask);
+
+	return err;
+}
+
+static int xfer_libasound_init(struct xfer_context *xfer,
+			       snd_pcm_stream_t direction,
+			       struct context_options *opts)
+{
+	struct libasound_state *state = xfer->private_data;
+	char *node;
+	int err;
+
+	err = snd_output_stdio_attach(&state->log, stderr, 0);
+	if (err < 0)
+		return err;
+
+	state->verbose = xfer->verbose > 1;
+
+	if (opts->node == NULL)
+		node = "default";
+	else
+		node = opts->node;
+
+	err = snd_pcm_open(&state->handle, node, direction, 0);
+	if (err < 0) {
+		logging(state, "Fail to open libasound PCM node for %s: %s\n",
+			snd_pcm_stream_name(direction), node);
+		return err;
+	}
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
+	/* TODO: Applying NO_PERIOD_WAKEUP should be done here. */
+
+	return set_access_hw_param(state->handle, state->hw_params, opts);
+}
+
+static int configure_hw_params(struct libasound_state *state,
+			       snd_pcm_format_t format,
+			       unsigned int samples_per_frame,
+			       unsigned int frames_per_second)
+{
+	int err;
+
+	/* Configure sample format. */
+	if (format == SND_PCM_FORMAT_UNKNOWN) {
+		snd_pcm_format_mask_t *mask;
+
+		err = snd_pcm_format_mask_malloc(&mask);
+		if (err < 0)
+			return err;
+		snd_pcm_hw_params_get_format_mask(state->hw_params, mask);
+		for (format = 0; format <= SND_PCM_FORMAT_LAST; ++format) {
+			if (snd_pcm_format_mask_test(mask, format))
+				break;
+		}
+		snd_pcm_format_mask_free(mask);
+		if (format > SND_PCM_FORMAT_LAST) {
+			logging(state,
+				"Any sample format is not available.\n");
+			return -EINVAL;
+		}
+	}
+	err = snd_pcm_hw_params_set_format(state->handle, state->hw_params,
+					   format);
+	if (err < 0) {
+		logging(state,
+			_("Sample format '%s' is not available: %s\n"),
+			snd_pcm_format_name(format), snd_strerror(err));
+		return err;
+	}
+
+	/* Configure channels. */
+	if (samples_per_frame == 0) {
+		err = snd_pcm_hw_params_get_channels_min(state->hw_params,
+							 &samples_per_frame);
+		if (err < 0) {
+			logging(state,
+				_("Any channel number is not available.\n"));
+			return err;
+		}
+	}
+	err = snd_pcm_hw_params_set_channels(state->handle, state->hw_params,
+					     samples_per_frame);
+	if (err < 0) {
+		logging(state,
+			_("Channels count '%u' is not available: %s\n"),
+			samples_per_frame, snd_strerror(err));
+		return err;
+	}
+
+	/* Configure rate. */
+	if (frames_per_second == 0) {
+		err = snd_pcm_hw_params_get_rate_min(state->hw_params,
+						     &frames_per_second, NULL);
+		if (err < 0) {
+			logging(state,
+				_("Any rate is not available.\n"));
+			return err;
+		}
+
+	}
+	err = snd_pcm_hw_params_set_rate(state->handle, state->hw_params,
+					 frames_per_second, 0);
+	if (err < 0) {
+		logging(state,
+			_("Sampling rate '%u' is not available: %s\n"),
+			frames_per_second, snd_strerror(err));
+		return err;
+	}
+
+	return snd_pcm_hw_params(state->handle, state->hw_params);
+}
+
+static int retrieve_actual_hw_params(snd_pcm_hw_params_t *hw_params,
+				     snd_pcm_format_t *format,
+				     unsigned int *samples_per_frame,
+				     unsigned int *frames_per_second,
+				     snd_pcm_access_t *access,
+				     snd_pcm_uframes_t *frames_per_buffer)
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
+static int configure_sw_params(struct libasound_state *state,
+			       unsigned int frames_per_second,
+			       unsigned int frames_per_buffer)
+{
+	return snd_pcm_sw_params(state->handle, state->sw_params);
+}
+
+static int xfer_libasound_pre_process(struct xfer_context *xfer,
+				      snd_pcm_format_t *format,
+				      unsigned int *samples_per_frame,
+				      unsigned int *frames_per_second,
+				      snd_pcm_access_t *access,
+				      snd_pcm_uframes_t *frames_per_buffer)
+{
+	struct libasound_state *state = xfer->private_data;
+	int err;
+
+	if (state->handle == NULL)
+		return -ENXIO;
+
+	err = configure_hw_params(state, *format, *samples_per_frame,
+				  *frames_per_second);
+	if (err < 0) {
+		logging(state, _("Current hardware parameters:\n"));
+		snd_pcm_hw_params_dump(state->hw_params, state->log);
+		return err;
+	}
+
+	/* Retrieve actual parameters. */
+	err = retrieve_actual_hw_params(state->hw_params, format,
+					samples_per_frame, frames_per_second,
+					access, frames_per_buffer);
+	if (err < 0)
+		return err;
+
+	/* Query software parameters. */
+	err = snd_pcm_sw_params_current(state->handle, state->sw_params);
+	if (err < 0)
+		return err;
+
+	/* Assign I/O operation. */
+	if (state->ops->private_size > 0) {
+		state->private_data = malloc(state->ops->private_size);
+		if (state->private_data == NULL)
+			return -ENOMEM;
+		memset(state->private_data, 0, state->ops->private_size);
+	}
+	err = state->ops->pre_process(state);
+	if (err < 0)
+		return err;
+
+	err = configure_sw_params(state, *frames_per_second,
+				  *frames_per_buffer);
+	if (err < 0) {
+		logging(state, _("Current software parameters:\n"));
+		snd_pcm_sw_params_dump(state->sw_params, state->log);
+		return err;
+	}
+
+	if (xfer->verbose > 0)
+		snd_pcm_dump(state->handle, state->log);
+
+	return 0;
+}
+
+static int xfer_libasound_process_frames(struct xfer_context *xfer,
+					 unsigned int *frame_count,
+					 struct mapper_context *mapper,
+					 struct container_context *cntrs)
+{
+	struct libasound_state *state = xfer->private_data;
+	int err;
+
+	if (state->handle == NULL)
+		return -ENXIO;
+
+	err = state->ops->process_frames(state, frame_count, mapper, cntrs);
+	if (err < 0) {
+		if (err == -EPIPE) {
+			/*
+			 * Recover the stream and continue processing
+			 * immediately. In this program -EPIPE comes from
+			 * libasound implementation instead of file I/O.
+			 */
+
+			err = snd_pcm_prepare(state->handle);
+		}
+
+		if (err < 0) {
+			/*
+			 * TODO: -EIO from libasound for hw PCM node means
+			 * that IRQ disorder. This should be reported to help
+			 * developers for drivers.
+			 */
+			logging(state, "Fail to process frames: %s\n",
+				snd_strerror(err));
+		}
+	}
+
+	return err;
+}
+
+static void xfer_libasound_pause(struct xfer_context *xfer, bool enable)
+{
+	struct libasound_state *state = xfer->private_data;
+	snd_pcm_state_t s = snd_pcm_state(state->handle);
+	int err;
+
+	if (state->handle == NULL)
+		return;
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
+	if (err < 0 && state->verbose) {
+		logging(state, "snd_pcm_pause(): %s\n", snd_strerror(err));
+	}
+}
+
+static void xfer_libasound_post_process(struct xfer_context *xfer)
+{
+	struct libasound_state *state = xfer->private_data;
+	snd_pcm_state_t pcm_state;
+	int err;
+
+	if (state->handle == NULL)
+		return;
+
+	pcm_state = snd_pcm_state(state->handle);
+	if (pcm_state != SND_PCM_STATE_OPEN &&
+	    pcm_state != SND_PCM_STATE_DISCONNECTED) {
+		if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE) {
+			err = snd_pcm_drop(state->handle);
+			if (err < 0)
+				logging(state, "snd_pcm_drop(): %s\n",
+				       snd_strerror(err));
+		} else {
+			err = snd_pcm_drain(state->handle);
+			if (err < 0)
+				logging(state, "snd_pcm_drain(): %s\n",
+				       snd_strerror(err));
+		}
+	}
+
+	err = snd_pcm_hw_free(state->handle);
+	if (err < 0)
+		logging(state, "snd_pcm_hw_free(): %s\n", snd_strerror(err));
+
+	snd_pcm_close(state->handle);
+	state->handle = NULL;
+
+	if (state->ops && state->ops->post_process)
+		state->ops->post_process(state);
+	if (state->private_data)
+		free(state->private_data);
+	state->private_data = NULL;
+}
+
+static void xfer_libasound_destroy(struct xfer_context *xfer)
+{
+	struct libasound_state *state = xfer->private_data;
+
+	if (state->hw_params)
+		snd_pcm_hw_params_free(state->hw_params);
+	if (state->sw_params)
+		snd_pcm_sw_params_free(state->sw_params);
+	state->hw_params = NULL;
+	state->sw_params = NULL;
+
+	if (state->log)
+		snd_output_close(state->log);
+	state->log = NULL;
+}
+
+const struct xfer_data xfer_libasound = {
+	.ops = {
+		.init		= xfer_libasound_init,
+		.pre_process	= xfer_libasound_pre_process,
+		.process_frames	= xfer_libasound_process_frames,
+		.pause		= xfer_libasound_pause,
+		.post_process	= xfer_libasound_post_process,
+		.destroy	= xfer_libasound_destroy,
+	},
+	.private_size = sizeof(struct libasound_state),
+};
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
new file mode 100644
index 00000000..72807cdd
--- /dev/null
+++ b/axfer/xfer-libasound.h
@@ -0,0 +1,45 @@
+/*
+ * xfer-libasound.h - a header for receiver/transmitter of frames by alsa-lib.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_AXFER_XFER_LIBASOUND__H_
+#define __ALSA_UTILS_AXFER_XFER_LIBASOUND__H_
+
+#include "xfer.h"
+
+#define logging(state, ...) \
+	snd_output_printf(state->log, __VA_ARGS__)
+
+struct xfer_libasound_ops;
+
+struct libasound_state {
+	snd_pcm_t *handle;
+	snd_output_t *log;
+
+	snd_pcm_hw_params_t *hw_params;
+
+	snd_pcm_sw_params_t *sw_params;
+
+	bool running;
+
+	const struct xfer_libasound_ops *ops;
+	void *private_data;
+
+	bool verbose;
+};
+
+struct xfer_libasound_ops {
+	int (*pre_process)(struct libasound_state *state);
+	int (*process_frames)(struct libasound_state *state,
+			      unsigned int *frame_count,
+			      struct mapper_context *mapper,
+			      struct container_context *cntrs);
+	void (*post_process)(struct libasound_state *state);
+	unsigned int private_size;
+};
+
+#endif
diff --git a/axfer/xfer.c b/axfer/xfer.c
index 46b36d42..4677bd5b 100644
--- a/axfer/xfer.c
+++ b/axfer/xfer.c
@@ -12,7 +12,7 @@
 #include <stdio.h>
 
 static const char *const xfer_type_labels[] = {
-	[XFER_TYPE_COUNT] = "",
+	[XFER_TYPE_LIBASOUND] = "libasound",
 };
 
 int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
@@ -22,7 +22,7 @@ int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
 		enum xfer_type type;
 		const struct xfer_data *data;
 	} entries[] = {
-		{XFER_TYPE_COUNT, NULL},
+		{XFER_TYPE_LIBASOUND, &xfer_libasound},
 	};
 	int i;
 
diff --git a/axfer/xfer.h b/axfer/xfer.h
index 4e3f1f37..b90c005b 100644
--- a/axfer/xfer.h
+++ b/axfer/xfer.h
@@ -13,7 +13,7 @@
 #include "options.h"
 
 enum xfer_type {
-	XFER_TYPE_COUNT,
+	XFER_TYPE_LIBASOUND = 0,
 };
 
 struct xfer_ops;
@@ -66,6 +66,6 @@ struct xfer_data {
 	unsigned int private_size;
 };
 
-extern const struct xfer_data xfer_alsa;
+extern const struct xfer_data xfer_libasound;
 
 #endif
-- 
2.11.0
