From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 21/38] axfer: add an option to finish
	transmission at XRUN
Date: Tue, 19 Sep 2017 09:44:01 +0900
Message-ID: <20170919004418.24668-22-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 768A9266EE0
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

In aplay, '--fatal-errors' option has an effect to give up recovery of PCM
substream from XRUN state. This commit adds support for this option.

In original implementation, this option brings program abort. This seems
to generate core dump of process VMA. However, typically, XRUN comes from
timing mismatch between hardware and application, therefore core dump has
less helpful. This commit finishes this program in usual way with this
option at XRUN.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c        | 4 ++++
 axfer/options.h        | 1 +
 axfer/xfer-libasound.c | 4 ++--
 axfer/xfer-libasound.h | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index eb049f96..5f16cd43 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -15,6 +15,7 @@
 enum no_short_opts {
 	/* 128 belongs to non us-ascii character set. */
 	OPT_DUMP_HW_PARAMS = 128,
+	OPT_FATAL_ERRORS,
 	/* Obsoleted. */
 	OPT_MAX_FILE_TIME,
 };
@@ -307,6 +308,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"rate",		1, 0, 'r'},
 		/* For debugging. */
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
+		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 		/* Obsoleted. */
 		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
 		{NULL,			0, 0, 0},
@@ -348,6 +350,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->frames_per_second = parse_l(optarg, &err);
 		else if (c == OPT_DUMP_HW_PARAMS)
 			opts->dump_hw_params = true;
+		else if (c == OPT_FATAL_ERRORS)
+			opts->finish_at_xrun = true;
 		else if (c == OPT_MAX_FILE_TIME) {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
diff --git a/axfer/options.h b/axfer/options.h
index ddbdbfa9..de9ac998 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -36,6 +36,7 @@ struct context_options {
 
 	/* For debugging. */
 	bool dump_hw_params;
+	bool finish_at_xrun;
 };
 
 int context_options_init(struct context_options *opts, int argc,
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 4ad01bbb..9016644b 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -41,6 +41,7 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 		return err;
 
 	state->verbose = xfer->verbose;
+	state->finish_at_xrun = opts->finish_at_xrun;
 
 	if (opts->node == NULL)
 		node = "default";
@@ -273,13 +274,12 @@ static int xfer_libasound_process_frames(struct xfer_context *xfer,
 
 	err = state->ops->process_frames(state, frame_count, mapper, cntrs);
 	if (err < 0) {
-		if (err == -EPIPE) {
+		if (err == -EPIPE && !state->finish_at_xrun) {
 			/*
 			 * Recover the stream and continue processing
 			 * immediately. In this program -EPIPE comes from
 			 * libasound implementation instead of file I/O.
 			 */
-
 			err = snd_pcm_prepare(state->handle);
 		}
 
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 97b26634..25768c41 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -30,6 +30,7 @@ struct libasound_state {
 	void *private_data;
 
 	bool verbose;
+	bool finish_at_xrun;
 };
 
 struct xfer_libasound_ops {
-- 
2.11.0
