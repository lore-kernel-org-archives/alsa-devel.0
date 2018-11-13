From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 26/35] axfer: add options for software
	parameters of PCM substream
Date: Tue, 13 Nov 2018 15:41:38 +0900
Message-ID: <20181113064147.13577-26-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id C6404267ABC
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:39 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id w24-v6so5526694plq.3
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:39 -0800 (PST)
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

In ALSA PCM interface, some parameters are used to configure runtime of
PCM substream independently of actual hardware. These parameters are
mainly used to decide the detailed timing to start/stop PCM substream and
release I/O blocking state of application. These parameters are
represented and delivered by a structure.

In alsa-lib PCM API, the structure is hidden from userspace applications.
The applications can set/get actual parameters by helper functions.

In aplay, three of the parameters are configurable. This commit adds
support for them. When no options are given, default values are used.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/xfer-libasound.c | 86 ++++++++++++++++++++++++++++++++++++++++--
 axfer/xfer-libasound.h |  4 ++
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index a23021e..1e709e0 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -17,7 +17,7 @@ enum no_short_opts {
 	OPT_TEST_NOWAIT,
 };
 
-#define S_OPTS	"D:NMF:B:"
+#define S_OPTS	"D:NMF:B:A:R:T:"
 static const struct option l_opts[] = {
 	{"device",		1, 0, 'D'},
 	{"nonblock",		0, 0, 'N'},
@@ -26,6 +26,9 @@ static const struct option l_opts[] = {
 	{"buffer-time",		1, 0, 'B'},
 	{"period-size",		1, 0, OPT_PERIOD_SIZE},
 	{"buffer-size",		1, 0, OPT_BUFFER_SIZE},
+	{"avail-min",		1, 0, 'A'},
+	{"start-delay",		1, 0, 'R'},
+	{"stop-delay",		1, 0, 'T'},
 	// For debugging.
 	{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 	{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
@@ -68,6 +71,12 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 		state->frames_per_period = arg_parse_decimal_num(optarg, &err);
 	else if (key == OPT_BUFFER_SIZE)
 		state->frames_per_buffer = arg_parse_decimal_num(optarg, &err);
+	else if (key == 'A')
+		state->msec_for_avail_min = arg_parse_decimal_num(optarg, &err);
+	else if (key == 'R')
+		state->msec_for_start_threshold = arg_parse_decimal_num(optarg, &err);
+	else if (key == 'T')
+		state->msec_for_stop_threshold = arg_parse_decimal_num(optarg, &err);
 	else if (key == OPT_FATAL_ERRORS)
 		state->finish_at_xrun = true;
 	else if (key == OPT_TEST_NOWAIT)
@@ -377,8 +386,76 @@ static int retrieve_actual_hw_params(snd_pcm_hw_params_t *hw_params,
 
 static int configure_sw_params(struct libasound_state *state,
 			       unsigned int frames_per_second,
-			       unsigned int frames_per_buffer)
+			       unsigned int frames_per_buffer,
+			       unsigned int msec_for_avail_min,
+			       unsigned int msec_for_start_threshold,
+			       unsigned int msec_for_stop_threshold)
 {
+	snd_pcm_uframes_t frame_count;
+	int err;
+
+	if (msec_for_avail_min > 0) {
+		frame_count = msec_for_avail_min * frames_per_second / 1000000;
+		if (frame_count == 0 || frame_count > frames_per_buffer) {
+			logging(state,
+				"The msec for 'avail_min' is too %s: %u "
+				"msec (%lu frames at %u).\n",
+				frame_count == 0 ? "small" : "large",
+				msec_for_avail_min, frame_count,
+				frames_per_second);
+			return -EINVAL;
+		}
+		err = snd_pcm_sw_params_set_avail_min(state->handle,
+						state->sw_params, frame_count);
+		if (err < 0) {
+			logging(state,
+				"Fail to configure 'avail-min'.\n");
+			return -EINVAL;
+		}
+	}
+
+	if (msec_for_start_threshold > 0) {
+		frame_count = msec_for_start_threshold * frames_per_second /
+			      1000000;
+		if (frame_count == 0 || frame_count > frames_per_buffer) {
+			logging(state,
+				"The msec for 'start-delay' is too %s: %u "
+				"msec (%lu frames at %u).\n",
+				frame_count == 0 ? "small" : "large",
+				msec_for_start_threshold, frame_count,
+				frames_per_second);
+			return -EINVAL;
+		}
+		err = snd_pcm_sw_params_set_start_threshold(state->handle,
+						state->sw_params, frame_count);
+		if (err < 0) {
+			logging(state,
+				"Fail to configure 'start-delay'.\n");
+			return -EINVAL;
+		}
+	}
+
+	if (msec_for_stop_threshold > 0) {
+		frame_count = msec_for_stop_threshold * frames_per_second /
+			      1000000;
+		if (frame_count == 0 || frame_count > frames_per_buffer) {
+			logging(state,
+				"The msec for 'stop-delay' is too %s: %u "
+				"msec (%lu frames at %u).\n",
+				frame_count == 0 ? "small" : "large",
+				msec_for_stop_threshold, frame_count,
+				frames_per_second);
+			return -EINVAL;
+		}
+		err = snd_pcm_sw_params_set_stop_threshold(state->handle,
+						state->sw_params, frame_count);
+		if (err < 0) {
+			logging(state,
+				"Fail to configure 'stop-delay'.\n");
+			return -EINVAL;
+		}
+	}
+
 	return snd_pcm_sw_params(state->handle, state->sw_params);
 }
 
@@ -444,7 +521,10 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return err;
 
 	err = configure_sw_params(state, *frames_per_second,
-				  *frames_per_buffer);
+				  *frames_per_buffer,
+				  state->msec_for_avail_min,
+				  state->msec_for_start_threshold,
+				  state->msec_for_stop_threshold);
 	if (err < 0) {
 		logging(state, "Current software parameters:\n");
 		snd_pcm_sw_params_dump(state->sw_params, state->log);
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 4456fab..113c1b9 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -35,6 +35,10 @@ struct libasound_state {
 	unsigned int frames_per_period;
 	unsigned int frames_per_buffer;
 
+	unsigned int msec_for_avail_min;
+	unsigned int msec_for_start_threshold;
+	unsigned int msec_for_stop_threshold;
+
 	bool finish_at_xrun:1;
 	bool nonblock:1;
 	bool mmap:1;
-- 
2.19.1
