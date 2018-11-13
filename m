From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 33/35] axfer: add support for timer-based
	scheduling model with MMAP operation
Date: Tue, 13 Nov 2018 15:41:45 +0900
Message-ID: <20181113064147.13577-33-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CDB5267B5C
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:52 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id z11so2594506pgu.0
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:52 -0800 (PST)
In-Reply-To: <20181113064147.13577-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In 2010, ALSA PCM interface got an flag of hardware parameters to suppress
periodical interrupts, according to a request from PulseAudio developer.

In typical PCM operation for usual hardware, PCM drivers configure the
hardware to generate the periodical interrupts to notify that the same
amount of data frames as a period of PCM buffer is actually transferred
via serial sound interface. The flag can suppress this if the driver
support it.

There's some merits of this configuration:
 - No interrupt context run for PCM substream. The PCM substream is
   handled in any process context only. No need to care of race
   conditions between interrupt/process contexts. This is good for
   developers of drivers and applications.
 - CPU time is not used for handlers on the interrupt context. The CPU
   time can be dedicated for the other tasks. This is good in a point
   of Time Sharing System.
 - Hardware is not configured to generate interrupts. This is good in a
   point of reduction of overall power consumption.

Disabling period interrupt is used for 'Timer-based scheduling' to
consume data frames on PCM buffer independently of interrupt context. As
noted, no interrupt context runs for PCM substream, thus any blocking
operation is not released. Furthermore, system calls for multiplexed I/O
is not also released without timeout.

In this scheduling model, applications need to care of available space on
PCM buffer by lapse of time, typically by yielding CPU and wait for
rescheduling. For the yielding, timeout is calculated for preferable
amount of PCM frames to process. This is an additional merit for
applications, like sound servers. when an I/O thread of the server wait
for the timeout, the other threads can process data frames for server
clients. Furthermore, with usage of rewinding/forwarding, applications
can achieve low latency between transmission position and handling
position even if they uses large size of PCM buffers.

But the timeout should be calculated with enough care of hardware
capabilities. To disable period interrupt, used hardware should satisfy
some requirements for data transmission:
1. Even if drivers don't handle interrupts to queue next data transmission,
   hardware voluntarily perform the data transmission when needed
   (typically by requesting DMA automatically).
2. hardware has a capability to report current position of data
   transmission with enough accuracy against the data transmission.
   developers refer this as 'granularity'. If hardware can always
   reports updated position after the data transmission finishes, the
   granularity equals to the size of period of PCM buffer.
3. a fine size of data transmission in one time. This size is decided
   depending on configuration of hardware or DMA controller, but for
   efficiency it may not be one byte. Thus some amount of data frame is
   transferred by one data transmission. Developers refer this as
   'burst-ness'.

The timeout should be calculated according to the item 2 and 3, however
in current ALSA PCM interface supplemental information is not delivered
from drivers to applications. Although at present userspace applications
should be written by a speculative way for this point, there's few
problems because there're a few hardware which satisfy the above items.
However, when more drivers supports this feature, the problem may largely
be exposed and bothers application developers.

This commit adds an option to use 'timer-based scheduling' for data
transmission. This commit adds '--sched-model' option, and the scheduling
mode is enabled when 'timer' is assigned to the option by equal sign.

Although there's some TODOs, you can see the scheduling mode in this
simple program, like:

$ axfer transfer --sched-model=timer -P -d 2 -D hw:0,3 /dev/urandom -f dat -vvv
$ axfer transfer --sched-model=timer -C -d 2 -D hw:1,0 /dev/null -r 48000 -vvv

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am                 |   3 +-
 axfer/xfer-libasound-timer-mmap.c | 455 ++++++++++++++++++++++++++++++
 axfer/xfer-libasound.c            | 108 ++++++-
 axfer/xfer-libasound.h            |  13 +
 4 files changed, 564 insertions(+), 15 deletions(-)
 create mode 100644 axfer/xfer-libasound-timer-mmap.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index ab1d0b4..497b9ff 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -53,4 +53,5 @@ axfer_SOURCES = \
 	waiter.c \
 	waiter-poll.c \
 	waiter-select.c \
-	waiter-epoll.c
+	waiter-epoll.c \
+	xfer-libasound-timer-mmap.c
diff --git a/axfer/xfer-libasound-timer-mmap.c b/axfer/xfer-libasound-timer-mmap.c
new file mode 100644
index 00000000..1c642fe
--- /dev/null
+++ b/axfer/xfer-libasound-timer-mmap.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// xfer-libasound-irq-mmap.c - Timer-based scheduling model for mmap operation.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "xfer-libasound.h"
+#include "misc.h"
+
+struct map_layout {
+	snd_pcm_status_t *status;
+	bool need_forward_or_rewind;
+	char **vector;
+
+	unsigned int frames_per_second;
+	unsigned int samples_per_frame;
+	unsigned int frames_per_buffer;
+};
+
+static int timer_mmap_pre_process(struct libasound_state *state)
+{
+	struct map_layout *layout = state->private_data;
+	snd_pcm_access_t access;
+	snd_pcm_uframes_t frame_offset;
+	snd_pcm_uframes_t avail = 0;
+	snd_pcm_uframes_t frames_per_buffer;
+	int i;
+	int err;
+
+	// This parameter, 'period event', is a software feature in alsa-lib.
+	// This switch a handler in 'hw' PCM plugin from irq-based one to
+	// timer-based one. This handler has two file descriptors for
+	// ALSA PCM character device and ALSA timer device. The latter is used
+	// to catch suspend/resume events as wakeup event.
+	err = snd_pcm_sw_params_set_period_event(state->handle,
+						 state->sw_params, 1);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_status_malloc(&layout->status);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_access(state->hw_params, &access);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_channels(state->hw_params,
+					     &layout->samples_per_frame);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_rate(state->hw_params,
+					 &layout->frames_per_second, NULL);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_buffer_size(state->hw_params,
+						&frames_per_buffer);
+	if (err < 0)
+		return err;
+	layout->frames_per_buffer = (unsigned int)frames_per_buffer;
+
+	if (access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+		layout->vector = calloc(layout->samples_per_frame,
+					sizeof(*layout->vector));
+		if (layout->vector == NULL)
+			return err;
+	}
+
+	if (state->verbose) {
+		const snd_pcm_channel_area_t *areas;
+		err = snd_pcm_mmap_begin(state->handle, &areas, &frame_offset,
+					 &avail);
+		if (err < 0)
+			return err;
+
+		logging(state, "attributes for mapped page frame:\n");
+		for (i = 0; i < layout->samples_per_frame; ++i) {
+			const snd_pcm_channel_area_t *area = areas + i;
+
+			logging(state, "  sample number: %d\n", i);
+			logging(state, "    address: %p\n", area->addr);
+			logging(state, "    bits for offset: %u\n", area->first);
+			logging(state, "    bits/frame: %u\n", area->step);
+		}
+	}
+
+	return 0;
+}
+
+static void *get_buffer(struct libasound_state *state,
+			const snd_pcm_channel_area_t *areas,
+			snd_pcm_uframes_t frame_offset)
+{
+	struct map_layout *layout = state->private_data;
+	void *frame_buf;
+
+	if (layout->vector == NULL) {
+		char *buf;
+		buf = areas[0].addr + snd_pcm_frames_to_bytes(state->handle,
+							      frame_offset);
+		frame_buf = buf;
+	} else {
+		int i;
+		for (i = 0; i < layout->samples_per_frame; ++i) {
+			layout->vector[i] = areas[i].addr;
+			layout->vector[i] += snd_pcm_samples_to_bytes(
+						state->handle, frame_offset);
+		}
+		frame_buf = layout->vector;
+	}
+
+	return frame_buf;
+}
+
+static int timer_mmap_process_frames(struct libasound_state *state,
+				     unsigned int *frame_count,
+				     struct mapper_context *mapper,
+				     struct container_context *cntrs)
+{
+	struct map_layout *layout = state->private_data;
+	snd_pcm_uframes_t planned_count;
+	snd_pcm_sframes_t avail;
+	snd_pcm_uframes_t avail_count;
+	const snd_pcm_channel_area_t *areas;
+	snd_pcm_uframes_t frame_offset;
+	void *frame_buf;
+	snd_pcm_sframes_t consumed_count;
+	int err;
+
+	// Retrieve avail space on PCM buffer between kernel/user spaces.
+	// On cache incoherent architectures, still care of data
+	// synchronization.
+	avail = snd_pcm_avail_update(state->handle);
+	if (avail < 0)
+		return (int)avail;
+
+	// Retrieve pointers of the buffer and left space up to the boundary.
+	avail_count = (snd_pcm_uframes_t)avail;
+	err = snd_pcm_mmap_begin(state->handle, &areas, &frame_offset,
+				 &avail_count);
+	if (err < 0)
+		return err;
+
+	// MEMO: Use the amount of data frames as you like.
+	planned_count = layout->frames_per_buffer * random() / RAND_MAX;
+	if (frame_offset + planned_count > layout->frames_per_buffer)
+		planned_count = layout->frames_per_buffer - frame_offset;
+
+	// Trim up to expected frame count.
+	if (*frame_count < planned_count)
+		planned_count = *frame_count;
+
+	// Yield this CPU till planned amount of frames become available.
+	if (avail_count < planned_count) {
+		unsigned short revents;
+		int timeout_msec;
+
+		// TODO; precise granularity of timeout; e.g. ppoll(2).
+		// Furthermore, wrap up according to granularity of reported
+		// value for hw_ptr.
+		timeout_msec = ((planned_count - avail_count) * 1000 +
+				layout->frames_per_second - 1) /
+			       layout->frames_per_second;
+
+		// TODO: However, experimentally, the above is not enough to
+		// keep planned amount of frames when waking up. I don't know
+		// exactly the mechanism yet.
+		err = xfer_libasound_wait_event(state, timeout_msec,
+						&revents);
+		if (err < 0)
+			return err;
+		if (revents & POLLERR) {
+			// TODO: error reporting.
+			return -EIO;
+		}
+		if (!(revents & (POLLIN | POLLOUT)))
+			return -EAGAIN;
+
+		// MEMO: Need to perform hwsync explicitly because hwptr is not
+		// synchronized to actual position of data frame transmission
+		// on hardware because IRQ handlers are not used in this
+		// scheduling strategy.
+		avail = snd_pcm_avail(state->handle);
+		if (avail < 0)
+			return (int)avail;
+		if (avail < planned_count) {
+			logging(state,
+				"Wake up but not enough space: %lu %lu %u\n",
+				planned_count, avail, timeout_msec);
+			planned_count = avail;
+		}
+	}
+
+	// Let's process data frames.
+	*frame_count = planned_count;
+	frame_buf = get_buffer(state, areas, frame_offset);
+	err = mapper_context_process_frames(mapper, frame_buf, frame_count,
+					    cntrs);
+	if (err < 0)
+		return err;
+
+	consumed_count = snd_pcm_mmap_commit(state->handle, frame_offset,
+					     *frame_count);
+	if (consumed_count != *frame_count) {
+		logging(state,
+			"A bug of 'hw' PCM plugin or driver for this PCM "
+			"node.\n");
+	}
+	*frame_count = consumed_count;
+
+	return 0;
+}
+
+static int forward_appl_ptr(struct libasound_state *state)
+{
+	struct map_layout *layout = state->private_data;
+	snd_pcm_uframes_t forwardable_count;
+	snd_pcm_sframes_t forward_count;
+
+	forward_count = snd_pcm_forwardable(state->handle);
+	if (forward_count < 0)
+		return (int)forward_count;
+	forwardable_count = forward_count;
+
+	// No need to add safe-gurard because hwptr goes ahead.
+	forward_count = snd_pcm_forward(state->handle, forwardable_count);
+	if (forward_count < 0)
+		return (int)forward_count;
+
+	if (state->verbose) {
+		logging(state,
+			"  forwarded: %lu/%u\n",
+			forward_count, layout->frames_per_buffer);
+	}
+
+	return 0;
+}
+
+static int timer_mmap_r_process_frames(struct libasound_state *state,
+				       unsigned *frame_count,
+				       struct mapper_context *mapper,
+				       struct container_context *cntrs)
+{
+	struct map_layout *layout = state->private_data;
+	snd_pcm_state_t s;
+	int err;
+
+	// SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP suppresses any IRQ to notify
+	// period elapse for data transmission, therefore no need to care of
+	// concurrent access by IRQ context and process context, unlike
+	// IRQ-based operations.
+	// Here, this is just to query current status to hardware, for later
+	// processing.
+	err = snd_pcm_status(state->handle, layout->status);
+	if (err < 0)
+		goto error;
+	s = snd_pcm_status_get_state(layout->status);
+
+	// TODO: if reporting something, do here with the status data.
+
+	if (s == SND_PCM_STATE_RUNNING) {
+		// Reduce delay between sampling on hardware and handling by
+		// this program.
+		if (layout->need_forward_or_rewind) {
+			err = forward_appl_ptr(state);
+			if (err < 0)
+				goto error;
+			layout->need_forward_or_rewind = false;
+		}
+
+		err = timer_mmap_process_frames(state, frame_count, mapper,
+						cntrs);
+		if (err < 0)
+			goto error;
+	} else {
+		if (s == SND_PCM_STATE_PREPARED) {
+			// For capture direction, need to start stream
+			// explicitly.
+			err = snd_pcm_start(state->handle);
+			if (err < 0)
+				goto error;
+			layout->need_forward_or_rewind = true;
+			// Not yet.
+			*frame_count = 0;
+		} else {
+			err = -EPIPE;
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static int rewind_appl_ptr(struct libasound_state *state)
+{
+	struct map_layout *layout = state->private_data;
+	snd_pcm_uframes_t rewindable_count;
+	snd_pcm_sframes_t rewind_count;
+
+	rewind_count = snd_pcm_rewindable(state->handle);
+	if (rewind_count < 0)
+		return (int)rewind_count;
+	rewindable_count = rewind_count;
+
+	// If appl_ptr were rewound just to position of hw_ptr, at next time,
+	// hw_ptr could catch up appl_ptr. This is overrun. We need a space
+	// between these two pointers to prevent this XRUN.
+	// This space is largely affected by time to process data frames later.
+	//
+	// TODO: a generous way to estimate a good value.
+	if (rewindable_count < 32)
+		return 0;
+	rewindable_count -= 32;
+
+	rewind_count = snd_pcm_rewind(state->handle, rewindable_count);
+	if (rewind_count < 0)
+		return (int)rewind_count;
+
+	if (state->verbose) {
+		logging(state,
+			"  rewound: %lu/%u\n",
+			rewind_count, layout->frames_per_buffer);
+	}
+
+	return 0;
+}
+
+static int fill_buffer_with_zero_samples(struct libasound_state *state)
+{
+	struct map_layout *layout = state->private_data;
+	const snd_pcm_channel_area_t *areas;
+	snd_pcm_uframes_t frame_offset;
+	snd_pcm_uframes_t avail_count;
+	snd_pcm_format_t sample_format;
+	snd_pcm_uframes_t consumed_count;
+	int err;
+
+	err = snd_pcm_hw_params_get_buffer_size(state->hw_params,
+						&avail_count);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_mmap_begin(state->handle, &areas, &frame_offset,
+				 &avail_count);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_format(state->hw_params, &sample_format);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_areas_silence(areas, frame_offset,
+				    layout->samples_per_frame, avail_count,
+				    sample_format);
+	if (err < 0)
+		return err;
+
+	consumed_count = snd_pcm_mmap_commit(state->handle, frame_offset,
+					     avail_count);
+	if (consumed_count != avail_count)
+		logging(state, "A bug of access plugin for this PCM node.\n");
+
+	return 0;
+}
+
+static int timer_mmap_w_process_frames(struct libasound_state *state,
+				       unsigned *frame_count,
+				       struct mapper_context *mapper,
+				       struct container_context *cntrs)
+{
+	struct map_layout *layout = state->private_data;
+	snd_pcm_state_t s;
+	int err;
+
+	// Read my comment in 'timer_mmap_w_process_frames()'.
+	err = snd_pcm_status(state->handle, layout->status);
+	if (err < 0)
+		goto error;
+	s = snd_pcm_status_get_state(layout->status);
+
+	// TODO: if reporting something, do here with the status data.
+
+	if (s == SND_PCM_STATE_RUNNING) {
+		// Reduce delay between queueing by this program and presenting
+		// on hardware.
+		if (layout->need_forward_or_rewind) {
+			err = rewind_appl_ptr(state);
+			if (err < 0)
+				goto error;
+			layout->need_forward_or_rewind = false;
+		}
+
+		err = timer_mmap_process_frames(state, frame_count, mapper,
+						cntrs);
+		if (err < 0)
+			goto error;
+	} else {
+		// Need to start playback stream explicitly
+		if (s == SND_PCM_STATE_PREPARED) {
+			err = fill_buffer_with_zero_samples(state);
+			if (err < 0)
+				goto error;
+
+			err = snd_pcm_start(state->handle);
+			if (err < 0)
+				goto error;
+
+			layout->need_forward_or_rewind = true;
+			// Not yet.
+			*frame_count = 0;
+		} else {
+			err = -EPIPE;
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static void timer_mmap_post_process(struct libasound_state *state)
+{
+	struct map_layout *layout = state->private_data;
+
+	if (layout->status)
+		snd_pcm_status_free(layout->status);
+	layout->status = NULL;
+
+	if (layout->vector)
+		free(layout->vector);
+	layout->vector = NULL;
+}
+
+const struct xfer_libasound_ops xfer_libasound_timer_mmap_w_ops = {
+	.pre_process	= timer_mmap_pre_process,
+	.process_frames	= timer_mmap_w_process_frames,
+	.post_process	= timer_mmap_post_process,
+	.private_size	= sizeof(struct map_layout),
+};
+
+const struct xfer_libasound_ops xfer_libasound_timer_mmap_r_ops = {
+	.pre_process	= timer_mmap_pre_process,
+	.process_frames	= timer_mmap_r_process_frames,
+	.post_process	= timer_mmap_post_process,
+	.private_size	= sizeof(struct map_layout),
+};
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index fa72839..f6d0515 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -9,11 +9,17 @@
 #include "xfer-libasound.h"
 #include "misc.h"
 
+static const char *const sched_model_labels [] = {
+	[SCHED_MODEL_IRQ] = "irq",
+	[SCHED_MODEL_TIMER] = "timer",
+};
+
 enum no_short_opts {
         // 200 or later belong to non us-ascii character set.
 	OPT_PERIOD_SIZE = 200,
 	OPT_BUFFER_SIZE,
 	OPT_WAITER_TYPE,
+	OPT_SCHED_MODEL,
 	OPT_DISABLE_RESAMPLE,
 	OPT_DISABLE_CHANNELS,
 	OPT_DISABLE_FORMAT,
@@ -35,6 +41,7 @@ static const struct option l_opts[] = {
 	{"start-delay",		1, 0, 'R'},
 	{"stop-delay",		1, 0, 'T'},
 	{"waiter-type",		1, 0, OPT_WAITER_TYPE},
+	{"sched-model",		1, 0, OPT_SCHED_MODEL},
 	// For plugins in alsa-lib.
 	{"disable-resample",	0, 0, OPT_DISABLE_RESAMPLE},
 	{"disable-channels",	0, 0, OPT_DISABLE_CHANNELS},
@@ -90,6 +97,8 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 		state->msec_for_stop_threshold = arg_parse_decimal_num(optarg, &err);
 	else if (key == OPT_WAITER_TYPE)
 		state->waiter_type_literal = arg_duplicate_string(optarg, &err);
+	else if (key == OPT_SCHED_MODEL)
+		state->sched_model_literal = arg_duplicate_string(optarg, &err);
 	else if (key == OPT_DISABLE_RESAMPLE)
 		state->no_auto_resample = true;
 	else if (key == OPT_DISABLE_CHANNELS)
@@ -151,6 +160,15 @@ int xfer_libasound_validate_opts(struct xfer_context *xfer)
 		}
 	}
 
+	state->sched_model = SCHED_MODEL_IRQ;
+	if (state->sched_model_literal != NULL) {
+		if (!strcmp(state->sched_model_literal, "timer")) {
+			state->sched_model = SCHED_MODEL_TIMER;
+			state->mmap = true;
+			state->nonblock = true;
+		}
+	}
+
 	if (state->waiter_type_literal != NULL) {
 		if (state->test_nowait) {
 			fprintf(stderr,
@@ -161,7 +179,8 @@ int xfer_libasound_validate_opts(struct xfer_context *xfer)
 		if (!state->nonblock && !state->mmap) {
 			fprintf(stderr,
 				"An option for waiter type should be used "
-				"with nonblock or mmap options.\n");
+				"with nonblock or mmap or timer-based "
+				"scheduling options.\n");
 			return -EINVAL;
 		}
 		state->waiter_type =
@@ -196,6 +215,37 @@ static int set_access_hw_param(struct libasound_state *state)
 	return err;
 }
 
+static int disable_period_wakeup(struct libasound_state *state)
+{
+	int err;
+
+	if (snd_pcm_type(state->handle) != SND_PCM_TYPE_HW) {
+		logging(state,
+			"Timer-based scheduling is only available for 'hw' "
+			"PCM plugin.\n");
+		return -ENXIO;
+	}
+
+	if (!snd_pcm_hw_params_can_disable_period_wakeup(state->hw_params)) {
+		logging(state,
+			"This hardware doesn't support the mode of no-period-"
+			"wakeup. In this case, timer-based scheduling is not "
+			"available.\n");
+		return -EIO;
+	}
+
+	err = snd_pcm_hw_params_set_period_wakeup(state->handle,
+						  state->hw_params, 0);
+	if (err < 0) {
+		logging(state,
+			"Fail to disable period wakeup so that the hardware "
+			"generates no IRQs during transmission of data "
+			"frames.\n");
+	}
+
+	return err;
+}
+
 static int open_handle(struct xfer_context *xfer)
 {
 	struct libasound_state *state = xfer->private_data;
@@ -229,7 +279,11 @@ static int open_handle(struct xfer_context *xfer)
 	if (err < 0)
 		return err;
 
-	// TODO: Applying NO_PERIOD_WAKEUP should be done here.
+	if (state->sched_model == SCHED_MODEL_TIMER) {
+		err = disable_period_wakeup(state);
+		if (err < 0)
+			return err;
+	}
 
 	if (xfer->dump_hw_params) {
 		logging(state, "Available HW Params of node: %s\n",
@@ -575,6 +629,7 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 				      snd_pcm_uframes_t *frames_per_buffer)
 {
 	struct libasound_state *state = xfer->private_data;
+	unsigned int flag;
 	int err;
 
 	err = open_handle(xfer);
@@ -606,24 +661,43 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return err;
 
 	// Assign I/O operation.
-	if (*access == SND_PCM_ACCESS_RW_INTERLEAVED ||
-	    *access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
-		state->ops = &xfer_libasound_irq_rw_ops;
-	} else if (*access == SND_PCM_ACCESS_MMAP_INTERLEAVED ||
-		   *access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) {
-		if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
-			state->ops = &xfer_libasound_irq_mmap_r_ops;
-		else
-			state->ops = &xfer_libasound_irq_mmap_w_ops;
+	err = snd_pcm_hw_params_get_period_wakeup(state->handle,
+						  state->hw_params, &flag);
+	if (err < 0)
+		return err;
+
+	if (flag) {
+		if (*access == SND_PCM_ACCESS_RW_INTERLEAVED ||
+		    *access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+			state->ops = &xfer_libasound_irq_rw_ops;
+		} else if (*access == SND_PCM_ACCESS_MMAP_INTERLEAVED ||
+			   *access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+			if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
+				state->ops = &xfer_libasound_irq_mmap_r_ops;
+			else
+				state->ops = &xfer_libasound_irq_mmap_w_ops;
+		} else {
+			return -ENXIO;
+		}
 	} else {
-		return -ENXIO;
+		if (*access == SND_PCM_ACCESS_MMAP_INTERLEAVED ||
+		    *access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+			if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
+				state->ops = &xfer_libasound_timer_mmap_r_ops;
+			else
+				state->ops = &xfer_libasound_timer_mmap_w_ops;
+		} else {
+			return -ENXIO;
+		}
 	}
+
 	if (state->ops->private_size > 0) {
 		state->private_data = malloc(state->ops->private_size);
 		if (state->private_data == NULL)
 			return -ENOMEM;
 		memset(state->private_data, 0, state->ops->private_size);
 	}
+
 	err = state->ops->pre_process(state);
 	if (err < 0)
 		return err;
@@ -639,8 +713,11 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return err;
 	}
 
-	if (xfer->verbose > 0)
+	if (xfer->verbose > 0) {
 		snd_pcm_dump(state->handle, state->log);
+		logging(state, "Scheduling model:\n");
+		logging(state, "  %s\n", sched_model_labels[state->sched_model]);
+	}
 
 	if (state->use_waiter) {
 		// NOTE: This should be after configuring sw_params due to
@@ -733,7 +810,8 @@ static void xfer_libasound_post_process(struct xfer_context *xfer)
 	pcm_state = snd_pcm_state(state->handle);
 	if (pcm_state != SND_PCM_STATE_OPEN &&
 	    pcm_state != SND_PCM_STATE_DISCONNECTED) {
-		if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE) {
+		if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE ||
+		    state->ops == &xfer_libasound_timer_mmap_w_ops) {
 			err = snd_pcm_drop(state->handle);
 			if (err < 0)
 				logging(state, "snd_pcm_drop(): %s\n",
@@ -774,8 +852,10 @@ static void xfer_libasound_destroy(struct xfer_context *xfer)
 
 	free(state->node_literal);
 	free(state->waiter_type_literal);
+	free(state->sched_model_literal);
 	state->node_literal = NULL;
 	state->waiter_type_literal = NULL;
+	state->sched_model_literal = NULL;
 
 	if (state->hw_params)
 		snd_pcm_hw_params_free(state->hw_params);
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 20b0d74..dfe8577 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -15,6 +15,12 @@
 #define logging(state, ...) \
 	snd_output_printf(state->log, __VA_ARGS__)
 
+enum sched_model {
+	SCHED_MODEL_IRQ = 0,
+	SCHED_MODEL_TIMER,
+	SCHED_MODEL_COUNT,
+};
+
 struct xfer_libasound_ops;
 
 struct libasound_state {
@@ -31,6 +37,7 @@ struct libasound_state {
 
 	char *node_literal;
 	char *waiter_type_literal;
+	char *sched_model_literal;
 
 	unsigned int msec_per_period;
 	unsigned int msec_per_buffer;
@@ -54,6 +61,9 @@ struct libasound_state {
 
 	enum waiter_type waiter_type;
 	struct waiter_context *waiter;
+
+	// For scheduling type.
+	enum sched_model sched_model;
 };
 
 // For internal use in 'libasound' module.
@@ -76,4 +86,7 @@ extern const struct xfer_libasound_ops xfer_libasound_irq_rw_ops;
 extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_r_ops;
 extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_w_ops;
 
+extern const struct xfer_libasound_ops xfer_libasound_timer_mmap_w_ops;
+extern const struct xfer_libasound_ops xfer_libasound_timer_mmap_r_ops;
+
 #endif
-- 
2.19.1
