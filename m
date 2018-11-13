From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 25/35] axfer: add options for buffer arrangement
Date: Tue, 13 Nov 2018 15:41:37 +0900
Message-ID: <20181113064147.13577-25-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2465267B62
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:38 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so5232865pgu.2
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:38 -0800 (PST)
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
size of buffer for period size. However, these calculation should be
reconsidered somehow.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/xfer-libasound.c | 122 +++++++++++++++++++++++++++++++++++++++--
 axfer/xfer-libasound.h |   5 ++
 axfer/xfer-options.c   |   2 +
 3 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 61ae115..a23021e 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -11,15 +11,21 @@
 
 enum no_short_opts {
         // 200 or later belong to non us-ascii character set.
-	OPT_FATAL_ERRORS = 200,
+	OPT_PERIOD_SIZE = 200,
+	OPT_BUFFER_SIZE,
+	OPT_FATAL_ERRORS,
 	OPT_TEST_NOWAIT,
 };
 
-#define S_OPTS	"D:NM"
+#define S_OPTS	"D:NMF:B:"
 static const struct option l_opts[] = {
 	{"device",		1, 0, 'D'},
 	{"nonblock",		0, 0, 'N'},
 	{"mmap",		0, 0, 'M'},
+	{"period-time",		1, 0, 'F'},
+	{"buffer-time",		1, 0, 'B'},
+	{"period-size",		1, 0, OPT_PERIOD_SIZE},
+	{"buffer-size",		1, 0, OPT_BUFFER_SIZE},
 	// For debugging.
 	{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 	{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
@@ -54,6 +60,14 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 		state->nonblock = true;
 	else if (key == 'M')
 		state->mmap = true;
+	else if (key == 'F')
+		state->msec_per_period = arg_parse_decimal_num(optarg, &err);
+	else if (key == 'B')
+		state->msec_per_buffer = arg_parse_decimal_num(optarg, &err);
+	else if (key == OPT_PERIOD_SIZE)
+		state->frames_per_period = arg_parse_decimal_num(optarg, &err);
+	else if (key == OPT_BUFFER_SIZE)
+		state->frames_per_buffer = arg_parse_decimal_num(optarg, &err);
 	else if (key == OPT_FATAL_ERRORS)
 		state->finish_at_xrun = true;
 	else if (key == OPT_TEST_NOWAIT)
@@ -93,6 +107,20 @@ int xfer_libasound_validate_opts(struct xfer_context *xfer)
 		}
 	}
 
+	if (state->msec_per_period > 0 && state->msec_per_buffer > 0) {
+		if (state->msec_per_period > state->msec_per_buffer) {
+			state->msec_per_period = state->msec_per_buffer;
+			state->msec_per_buffer = 0;
+		}
+	}
+
+	if (state->frames_per_period > 0 && state->frames_per_buffer > 0) {
+		if (state->frames_per_period > state->frames_per_buffer) {
+			state->frames_per_period = state->frames_per_buffer;
+			state->frames_per_buffer = 0;
+		}
+	}
+
 	return err;
 }
 
@@ -161,7 +189,11 @@ static int open_handle(struct xfer_context *xfer)
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
 
@@ -232,6 +264,84 @@ static int configure_hw_params(struct libasound_state *state,
 		return err;
 	}
 
+	// Keep one of 'frames_per_buffer' and 'msec_per_buffer'.
+	if (frames_per_buffer == 0) {
+		if (msec_per_buffer == 0) {
+			err = snd_pcm_hw_params_get_buffer_time_max(
+				state->hw_params, &msec_per_buffer, NULL);
+			if (err < 0) {
+				logging(state,
+					"The maximum msec per buffer is not "
+					"available.\n");
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
+	// Keep one of 'frames_per_period' and 'msec_per_period'.
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
+				"Fail to configure period time: %u msec\n",
+				msec_per_period);
+			return err;
+		}
+	} else {
+		err = snd_pcm_hw_params_set_period_size_near(state->handle,
+				state->hw_params, &frames_per_period, NULL);
+		if (err < 0) {
+			logging(state,
+				"Fail to configure period size: %lu frames\n",
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
+				"Fail to configure buffer time: %u msec\n",
+				msec_per_buffer);
+			return err;
+		}
+	} else {
+		err = snd_pcm_hw_params_set_buffer_size_near(state->handle,
+					state->hw_params, &frames_per_buffer);
+		if (err < 0) {
+			logging(state,
+				"Fail to configure buffer size: %lu frames\n",
+				frames_per_buffer);
+			return err;
+		}
+	}
+
 	return snd_pcm_hw_params(state->handle, state->hw_params);
 }
 
@@ -287,7 +397,11 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return -ENXIO;
 
 	err = configure_hw_params(state, *format, *samples_per_frame,
-				  *frames_per_second);
+				  *frames_per_second,
+				  state->msec_per_period,
+				  state->msec_per_buffer,
+				  state->frames_per_period,
+				  state->frames_per_buffer);
 	if (err < 0) {
 		logging(state, "Current hardware parameters:\n");
 		snd_pcm_hw_params_dump(state->hw_params, state->log);
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index f3ce73f..4456fab 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -30,6 +30,11 @@ struct libasound_state {
 
 	char *node_literal;
 
+	unsigned int msec_per_period;
+	unsigned int msec_per_buffer;
+	unsigned int frames_per_period;
+	unsigned int frames_per_buffer;
+
 	bool finish_at_xrun:1;
 	bool nonblock:1;
 	bool mmap:1;
diff --git a/axfer/xfer-options.c b/axfer/xfer-options.c
index 9233647..d899134 100644
--- a/axfer/xfer-options.c
+++ b/axfer/xfer-options.c
@@ -17,6 +17,8 @@ enum no_short_opts {
 	// 128 or later belong to non us-ascii character set.
 	OPT_XFER_TYPE = 128,
 	OPT_DUMP_HW_PARAMS,
+	OPT_PERIOD_SIZE,
+	OPT_BUFFER_SIZE,
 	// Obsoleted.
 	OPT_MAX_FILE_TIME,
 };
-- 
2.19.1
