From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 28/38] axfer: add options for software
	parameters of PCM substream
Date: Tue, 19 Sep 2017 09:44:08 +0900
Message-ID: <20170919004418.24668-29-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id A387A266EFA
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:30 +0200 (CEST)
In-Reply-To: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
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
 axfer/options.c        | 11 +++++++-
 axfer/options.h        |  4 +++
 axfer/xfer-libasound.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index 5d5dda89..aaeba5f2 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -322,7 +322,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:A:R:T:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -345,6 +345,9 @@ int context_options_init(struct context_options *opts, int argc,
 		{"buffer-time",		1, 0, 'B'},
 		{"period-size",		1, 0, OPT_PERIOD_SIZE},
 		{"buffer-size",		1, 0, OPT_BUFFER_SIZE},
+		{"avail-min",		1, 0, 'A'},
+		{"start-delay",		1, 0, 'R'},
+		{"stop-delay",		1, 0, 'T'},
 		/* For debugging. */
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
@@ -400,6 +403,12 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->frames_per_period = parse_l(optarg, &err);
 		else if (c == OPT_BUFFER_SIZE)
 			opts->frames_per_buffer = parse_l(optarg, &err);
+		else if (c == 'A')
+			opts->msec_for_avail_min = parse_l(optarg, &err);
+		else if (c == 'R')
+			opts->msec_for_start_threshold = parse_l(optarg, &err);
+		else if (c == 'T')
+			opts->msec_for_stop_threshold = parse_l(optarg, &err);
 		else if (c == OPT_DUMP_HW_PARAMS)
 			opts->dump_hw_params = true;
 		else if (c == OPT_FATAL_ERRORS)
diff --git a/axfer/options.h b/axfer/options.h
index f4ac6c64..63b36364 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -41,6 +41,10 @@ struct context_options {
 	unsigned int frames_per_period;
 	unsigned int frames_per_buffer;
 
+	unsigned int msec_for_avail_min;
+	unsigned int msec_for_start_threshold;
+	unsigned int msec_for_stop_threshold;
+
 	/* For debugging. */
 	bool dump_hw_params;
 	bool finish_at_xrun;
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 54c58b04..40222e91 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -338,8 +338,76 @@ static int retrieve_actual_hw_params(snd_pcm_hw_params_t *hw_params,
 
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
+				_("The msec for 'avail_min' is too %s: %u "
+				  "msec (%lu frames at %u).\n"),
+				frame_count == 0 ? "small" : "large",
+				msec_for_avail_min, frame_count,
+				frames_per_second);
+			return -EINVAL;
+		}
+		err = snd_pcm_sw_params_set_avail_min(state->handle,
+						state->sw_params, frame_count);
+		if (err < 0) {
+			logging(state,
+				_("Fail to configure 'avail-min'.\n"));
+			return -EINVAL;
+		}
+	}
+
+	if (msec_for_start_threshold > 0) {
+		frame_count = msec_for_start_threshold * frames_per_second /
+			      1000000;
+		if (frame_count == 0 || frame_count > frames_per_buffer) {
+			logging(state,
+				_("The msec for 'start-delay' is too %s: %u "
+				  "msec (%lu frames at %u).\n"),
+				frame_count == 0 ? "small" : "large",
+				msec_for_start_threshold, frame_count,
+				frames_per_second);
+			return -EINVAL;
+		}
+		err = snd_pcm_sw_params_set_start_threshold(state->handle,
+						state->sw_params, frame_count);
+		if (err < 0) {
+			logging(state,
+				_("Fail to configure 'start-delay'.\n"));
+			return -EINVAL;
+		}
+	}
+
+	if (msec_for_stop_threshold > 0) {
+		frame_count = msec_for_stop_threshold * frames_per_second /
+			      1000000;
+		if (frame_count == 0 || frame_count > frames_per_buffer) {
+			logging(state,
+				_("The msec for 'stop-delay' is too %s: %u "
+				  "msec (%lu frames at %u).\n"),
+				frame_count == 0 ? "small" : "large",
+				msec_for_stop_threshold, frame_count,
+				frames_per_second);
+			return -EINVAL;
+		}
+		err = snd_pcm_sw_params_set_stop_threshold(state->handle,
+						state->sw_params, frame_count);
+		if (err < 0) {
+			logging(state,
+				_("Fail to configure 'stop-delay'.\n"));
+			return -EINVAL;
+		}
+	}
+
 	return snd_pcm_sw_params(state->handle, state->sw_params);
 }
 
@@ -404,7 +472,9 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return err;
 
 	err = configure_sw_params(state, *frames_per_second,
-				  *frames_per_buffer);
+				  *frames_per_buffer, opts->msec_for_avail_min,
+				  opts->msec_for_start_threshold,
+				  opts->msec_for_stop_threshold);
 	if (err < 0) {
 		logging(state, _("Current software parameters:\n"));
 		snd_pcm_sw_params_dump(state->sw_params, state->log);
-- 
2.11.0
