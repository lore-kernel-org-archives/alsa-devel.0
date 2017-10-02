From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 20/39] axfer: add options related to
	duration and obsolete '--max-file-size' option
Date: Mon,  2 Oct 2017 09:19:21 +0900
Message-ID: <20171002001940.17218-21-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C9ED7266FBD
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

In aplay, some options are available to stop data transmission by frame
unit. This commit adds support for them.

There's a similar option; '--max-file-time'. This option is used for
capture data transmission to switch file to write data frame. However,
this may brings complicated file handling to this program. To reduce
maintaining cost, this option is obsoleted. Additionally, a handler for
SIGUSR1 Unix signal has similar feature to switch the file. For the same
reason, the handler is also obsoleted.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c         | 63 ++++++++++++++++++++++++++++++++++++++-----------
 axfer/options.h         |  2 ++
 axfer/subcmd-transfer.c |  3 +++
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index 08a047dd..f3d2dfcf 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -15,6 +15,8 @@
 enum no_short_opts {
 	/* 128 belongs to non us-ascii character set. */
 	OPT_DUMP_HW_PARAMS = 128,
+	/* Obsoleted. */
+	OPT_MAX_FILE_TIME,
 };
 
 static const char *const allowed_duplication[] = {
@@ -265,15 +267,35 @@ static int apply_policies(struct context_options *opts,
 	return 0;
 }
 
+void context_options_calculate_duration(struct context_options *opts,
+		unsigned int frames_per_second, uint64_t *total_frame_count)
+{
+	uint64_t frame_count;
+
+	if (opts->duration_seconds > 0) {
+		frame_count = opts->duration_seconds * frames_per_second;
+		if (frame_count < *total_frame_count)
+			*total_frame_count = frame_count;
+	}
+
+	if (opts->duration_frames > 0) {
+		frame_count = opts->duration_frames;
+		if (frame_count < *total_frame_count)
+			*total_frame_count = frame_count;
+	}
+}
+
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqt:ID:f:c:r:";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
 		{"verbose",		0, 0, 'v'},
 		{"quiet",		0, 0, 'q'},
+		{"duration",		1, 0, 'd'},
+		{"samples",		1, 0, 's'},
 		/* For containers. */
 		{"file-type",		1, 0, 't'},
 		/* For mapper. */
@@ -285,18 +307,21 @@ int context_options_init(struct context_options *opts, int argc,
 		{"rate",		1, 0, 'r'},
 		/* For debugging. */
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
+		/* Obsoleted. */
+		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
 		{NULL,			0, 0, 0},
 	};
 	const char *cntr_format_literal = NULL;
 	const char *node_literal = NULL;
 	const char *sample_format_literal = NULL;
+	int l_index = 0;
 	int c;
 	int err = 0;
 
 	optind = 0;
 	opterr = 0;
 	while (1) {
-		c = getopt_long(argc, argv, s_opts, l_opts, NULL);
+		c = getopt_long(argc, argv, s_opts, l_opts, &l_index);
 		if (c < 0)
 			break;
 		else if (c == 'h')
@@ -305,6 +330,10 @@ int context_options_init(struct context_options *opts, int argc,
 			++opts->verbose;
 		else if (c == 'q')
 			opts->quiet = true;
+		else if (c == 'd')
+			opts->duration_seconds = parse_l(optarg, &err);
+		else if (c == 's')
+			opts->duration_frames = parse_l(optarg, &err);
 		else if (c == 't')
 			cntr_format_literal = optarg;
 		else if (c == 'I')
@@ -319,7 +348,13 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->frames_per_second = parse_l(optarg, &err);
 		else if (c == OPT_DUMP_HW_PARAMS)
 			opts->dump_hw_params = true;
-		else
+		else if (c == OPT_MAX_FILE_TIME) {
+			fprintf(stderr,
+				"An option '--%s' is obsoleted and has no "
+				"effect.\n",
+				l_opts[l_index].name);
+			err = -EINVAL;
+		} else
 			continue;
 
 		if (err < 0)
@@ -492,20 +527,20 @@ int context_options_fixup_for_capture(struct context_options *opts,
 	int i, j;
 	int err;
 
-	if (!opts->multiple_cntrs) {
-		if (opts->path_count == 1)
+	if (opts->path_count == 1) {
+		if (!strcmp(opts->paths[0], "-"))
+			return 0;
+		if (!opts->multiple_cntrs)
 			err = fixup_paths(opts);
 		else
-			return -EINVAL;
-	} else {
-		if (opts->path_count == 1) {
 			err = create_paths(opts, samples_per_frame);
-		} else {
-			if (opts->path_count == samples_per_frame)
-				err = fixup_paths(opts);
-			else
-				return -EINVAL;
-		}
+	} else {
+		if (!opts->multiple_cntrs)
+			return -EINVAL;
+		if (opts->path_count != samples_per_frame)
+			return -EINVAL;
+		else
+			err = fixup_paths(opts);
 	}
 	if (err < 0)
 		return err;
diff --git a/axfer/options.h b/axfer/options.h
index 743279af..ddbdbfa9 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -17,6 +17,8 @@ struct context_options {
 	/* For generic purposes. */
 	unsigned int verbose;
 	bool quiet;
+	uint64_t duration_seconds;
+	uint64_t duration_frames;
 
 	/* For containers. */
 	char **paths;
diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index 317a57e3..6c7e6ad8 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -346,6 +346,9 @@ static int context_pre_process(struct context *ctx, snd_pcm_stream_t direction,
 	if (err < 0)
 		return err;
 
+	context_options_calculate_duration(&ctx->opts, frames_per_second,
+					   total_frame_count);
+
 	ctx->opts.sample_format = sample_format;
 	ctx->opts.samples_per_frame = samples_per_frame;
 	ctx->opts.frames_per_second = frames_per_second;
-- 
2.11.0
