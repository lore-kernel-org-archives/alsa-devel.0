From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 27/39] axfer: add options for buffer
	arrangement
Date: Mon,  2 Oct 2017 09:19:28 +0900
Message-ID: <20171002001940.17218-28-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 13EDD266FCC
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

In ALSA PCM interface, two parameters are used for size of intermediate
buffer for data frames; period size and buffer size. Actual effects of
these sizes differs depending on hardware, but basically the size of
period is used for intervals of hardware interrupts and the size of buffer
is used to maintain the intermediate buffer as ring buffer. These
parameters can be configured as a part of hardware parameters by
data frame unit or micro second. PCM API in alsa-lib also includes
helper functions to configure them by the two units.

This commit adds support for options to the parameters by both units. When
no options are given, default values are applied according to current
aplay; available maximum size of buffer up to 500msec, a quarter of the
size of buffer for period size. These calculation should be reconsidered
perhaps.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c         | 30 +++++++++++++++-
 axfer/options.h         |  5 +++
 axfer/subcmd-transfer.c |  6 ++--
 axfer/xfer-libasound.c  | 92 +++++++++++++++++++++++++++++++++++++++++++++++--
 axfer/xfer-libasound.h  |  1 -
 axfer/xfer.c            |  5 +--
 axfer/xfer.h            |  6 ++--
 7 files changed, 134 insertions(+), 11 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index b0ea99c3..325bc16b 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -17,6 +17,8 @@ enum no_short_opts {
 	OPT_DUMP_HW_PARAMS = 128,
 	OPT_FATAL_ERRORS,
 	OPT_TEST_NOWAIT,
+	OPT_PERIOD_SIZE,
+	OPT_BUFFER_SIZE,
 	/* Obsoleted. */
 	OPT_MAX_FILE_TIME,
 };
@@ -266,6 +268,20 @@ static int apply_policies(struct context_options *opts,
 			return err;
 	}
 
+	if (opts->msec_per_period > 0 && opts->msec_per_buffer > 0) {
+		if (opts->msec_per_period > opts->msec_per_buffer) {
+			opts->msec_per_period = opts->msec_per_buffer;
+			opts->msec_per_buffer = 0;
+		}
+	}
+
+	if (opts->frames_per_period > 0 && opts->frames_per_buffer > 0) {
+		if (opts->frames_per_period > opts->frames_per_buffer) {
+			opts->frames_per_period = opts->frames_per_buffer;
+			opts->frames_per_buffer = 0;
+		}
+	}
+
 	if (opts->mmap && opts->nonblock) {
 		fprintf(stderr,
 			"An option for mmap operation should not be used with "
@@ -306,7 +322,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NM";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -325,6 +341,10 @@ int context_options_init(struct context_options *opts, int argc,
 		{"rate",		1, 0, 'r'},
 		{"nonblock",            0, 0, 'N'},
 		{"mmap",                0, 0, 'M'},
+		{"period-time",		1, 0, 'F'},
+		{"buffer-time",		1, 0, 'B'},
+		{"period-size",		1, 0, OPT_PERIOD_SIZE},
+		{"buffer-size",		1, 0, OPT_BUFFER_SIZE},
 		/* For debugging. */
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
@@ -372,6 +392,14 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->nonblock = true;
 		else if (c == 'M')
 			opts->mmap = true;
+		else if (c == 'F')
+			opts->msec_per_period = parse_l(optarg, &err);
+		else if (c == 'B')
+			opts->msec_per_buffer = parse_l(optarg, &err);
+		else if (c == OPT_PERIOD_SIZE)
+			opts->frames_per_period = parse_l(optarg, &err);
+		else if (c == OPT_BUFFER_SIZE)
+			opts->frames_per_buffer = parse_l(optarg, &err);
 		else if (c == OPT_DUMP_HW_PARAMS)
 			opts->dump_hw_params = true;
 		else if (c == OPT_FATAL_ERRORS)
diff --git a/axfer/options.h b/axfer/options.h
index 3052d01a..f4ac6c64 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -36,6 +36,11 @@ struct context_options {
 	bool nonblock;
 	bool mmap;
 
+	unsigned int msec_per_period;
+	unsigned int msec_per_buffer;
+	unsigned int frames_per_period;
+	unsigned int frames_per_buffer;
+
 	/* For debugging. */
 	bool dump_hw_params;
 	bool finish_at_xrun;
diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index 6c7e6ad8..e9a8c181 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -157,7 +157,8 @@ static int capture_pre_process(struct context *ctx, snd_pcm_access_t *access,
 
 	err = xfer_context_pre_process(&ctx->xfer, sample_format,
 				       samples_per_frame, frames_per_second,
-				       access, frames_per_buffer);
+				       access, frames_per_buffer,
+				       &ctx->opts);
 	if (err < 0)
 		return err;
 
@@ -294,7 +295,8 @@ static int playback_pre_process(struct context *ctx, snd_pcm_access_t *access,
 	/* Configure hardware with these parameters. */
 	err = xfer_context_pre_process(&ctx->xfer, sample_format,
 				       samples_per_frame, frames_per_second,
-				       access, frames_per_buffer);
+				       access, frames_per_buffer,
+				       &ctx->opts);
 	if (err < 0)
 		return err;
 
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 5271d230..1911c160 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -149,7 +149,11 @@ end:
 static int configure_hw_params(struct libasound_state *state,
 			       snd_pcm_format_t format,
 			       unsigned int samples_per_frame,
-			       unsigned int frames_per_second)
+			       unsigned int frames_per_second,
+			       unsigned int msec_per_period,
+			       unsigned int msec_per_buffer,
+			       snd_pcm_uframes_t frames_per_period,
+			       snd_pcm_uframes_t frames_per_buffer)
 {
 	int err;
 
@@ -220,6 +224,84 @@ static int configure_hw_params(struct libasound_state *state,
 		return err;
 	}
 
+	/* Keep one of 'frames_per_buffer' and 'msec_per_buffer'. */
+	if (frames_per_buffer == 0) {
+		if (msec_per_buffer == 0) {
+			err = snd_pcm_hw_params_get_buffer_time_max(
+				state->hw_params, &msec_per_buffer, NULL);
+			if (err < 0) {
+				logging(state,
+					_("The maximum msec per buffer is not "
+					  "available.\n"));
+				return err;
+			}
+			if (msec_per_buffer > 500000)
+				msec_per_buffer = 500000;
+		}
+	} else if (msec_per_buffer > 0) {
+		uint64_t msec;
+
+		msec = 1000000 * frames_per_buffer / frames_per_second;
+		if (msec < msec_per_buffer)
+			msec_per_buffer = 0;
+	}
+
+	/* Keep one of 'frames_per_period' and 'msec_per_period'. */
+	if (frames_per_period == 0) {
+		if (msec_per_period == 0) {
+			if (msec_per_buffer > 0)
+				msec_per_period = msec_per_buffer / 4;
+			else
+				frames_per_period = frames_per_buffer / 4;
+		}
+	} else if (msec_per_period > 0) {
+		uint64_t msec;
+
+		msec = 1000000 * frames_per_period / frames_per_second;
+		if (msec < msec_per_period)
+			msec_per_period = 0;
+	}
+
+	if (msec_per_period) {
+		err = snd_pcm_hw_params_set_period_time_near(state->handle,
+				state->hw_params, &msec_per_period, NULL);
+		if (err < 0) {
+			logging(state,
+				_("Fail to configure period time: %u msec\n"),
+				msec_per_period);
+			return err;
+		}
+	} else {
+		err = snd_pcm_hw_params_set_period_size_near(state->handle,
+				state->hw_params, &frames_per_period, NULL);
+		if (err < 0) {
+			logging(state,
+				_("Fail to configure period size: %lu frames\n"),
+				frames_per_period);
+			return err;
+		}
+	}
+
+	if (msec_per_buffer) {
+		err = snd_pcm_hw_params_set_buffer_time_near(state->handle,
+				state->hw_params, &msec_per_buffer, NULL);
+		if (err < 0) {
+			logging(state,
+				_("Fail to configure buffer time: %u msec\n"),
+				msec_per_buffer);
+			return err;
+		}
+	} else {
+		err = snd_pcm_hw_params_set_buffer_size_near(state->handle,
+					state->hw_params, &frames_per_buffer);
+		if (err < 0) {
+			logging(state,
+				_("Fail to configure buffer size: %lu frames\n"),
+				frames_per_buffer);
+			return err;
+		}
+	}
+
 	return snd_pcm_hw_params(state->handle, state->hw_params);
 }
 
@@ -265,7 +347,8 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 				      unsigned int *samples_per_frame,
 				      unsigned int *frames_per_second,
 				      snd_pcm_access_t *access,
-				      snd_pcm_uframes_t *frames_per_buffer)
+				      snd_pcm_uframes_t *frames_per_buffer,
+				      struct context_options *opts)
 {
 	struct libasound_state *state = xfer->private_data;
 	int err;
@@ -274,7 +357,10 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return -ENXIO;
 
 	err = configure_hw_params(state, *format, *samples_per_frame,
-				  *frames_per_second);
+				  *frames_per_second, opts->msec_per_period,
+				  opts->msec_per_buffer,
+				  opts->frames_per_period,
+				  opts->frames_per_buffer);
 	if (err < 0) {
 		logging(state, _("Current hardware parameters:\n"));
 		snd_pcm_hw_params_dump(state->hw_params, state->log);
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index d0771f8a..db85e604 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -22,7 +22,6 @@ struct libasound_state {
 	snd_output_t *log;
 
 	snd_pcm_hw_params_t *hw_params;
-
 	snd_pcm_sw_params_t *sw_params;
 
 	bool running;
diff --git a/axfer/xfer.c b/axfer/xfer.c
index 4677bd5b..2f9f9422 100644
--- a/axfer/xfer.c
+++ b/axfer/xfer.c
@@ -68,7 +68,8 @@ int xfer_context_pre_process(struct xfer_context *xfer,
 			     unsigned int *samples_per_frame,
 			     unsigned int *frames_per_second,
 			     snd_pcm_access_t *access,
-			     snd_pcm_uframes_t *frames_per_buffer)
+			     snd_pcm_uframes_t *frames_per_buffer,
+			     struct context_options *opts)
 {
 	int err;
 
@@ -84,7 +85,7 @@ int xfer_context_pre_process(struct xfer_context *xfer,
 
 	err = xfer->ops->pre_process(xfer, format, samples_per_frame,
 				     frames_per_second, access,
-				     frames_per_buffer);
+				     frames_per_buffer, opts);
 	if (err < 0)
 		return err;
 
diff --git a/axfer/xfer.h b/axfer/xfer.h
index b90c005b..167c9903 100644
--- a/axfer/xfer.h
+++ b/axfer/xfer.h
@@ -34,7 +34,8 @@ int xfer_context_pre_process(struct xfer_context *xfer,
 			     unsigned int *samples_per_frame,
 			     unsigned int *frames_per_second,
 			     snd_pcm_access_t *access,
-			     snd_pcm_uframes_t *frames_per_buffer);
+			     snd_pcm_uframes_t *frames_per_buffer,
+			     struct context_options *opts);
 int xfer_context_process_frames(struct xfer_context *xfer,
 				struct mapper_context *mapper,
 				struct container_context *cntrs,
@@ -51,7 +52,8 @@ struct xfer_ops {
 			   unsigned int *samples_per_frame,
 			   unsigned int *frames_per_second,
 			   snd_pcm_access_t *access,
-			   snd_pcm_uframes_t *frames_per_buffer);
+			   snd_pcm_uframes_t *frames_per_buffer,
+			   struct context_options *opts);
 	int (*process_frames)(struct xfer_context *xfer,
 			      unsigned int *frame_count,
 			      struct mapper_context *mapper,
-- 
2.11.0
