From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 20/35] axfer: add options related to duration
	and obsolete '--max-file-size' option
Date: Tue, 13 Nov 2018 15:41:32 +0900
Message-ID: <20181113064147.13577-20-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 08A0A267AA4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:29 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id w22-v6so5528963plk.0
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:29 -0800 (PST)
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

In aplay, some options are available to stop data transmission by frame
unit. This commit adds support for the options below:
 * --duration (-d)
  * For duration seconds. The number of data frames transferred in this
  * runtime is calculated by this value and sampling rate.
 * --samples (-s)
  * For the number of data frames to handle in this runtime.

An original aplay has a similar option; '--max-file-time'. This option
is used for capture data transmission to switch file to write data frame
up to maximum number of frames which container format supports, instead
of terminating. However, this may brings complicated file handling to
this program. To reduce maintaining cost, this option is obsoleted.
Additionally, a handler for SIGUSR1 Unix signal has similar feature to
switch the file. For the same reason, the handler is also obsoleted.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/subcmd-transfer.c |  2 ++
 axfer/xfer-options.c    | 38 ++++++++++++++++++++++++++++++++++++--
 axfer/xfer.h            |  4 ++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index 36817f3..d5f16cb 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -327,6 +327,8 @@ static int context_pre_process(struct context *ctx, snd_pcm_stream_t direction,
 	if (err < 0)
 		return err;
 
+	xfer_options_calculate_duration(&ctx->xfer, total_frame_count);
+
 	return 0;
 }
 
diff --git a/axfer/xfer-options.c b/axfer/xfer-options.c
index 21fc6bb..9233647 100644
--- a/axfer/xfer-options.c
+++ b/axfer/xfer-options.c
@@ -17,6 +17,8 @@ enum no_short_opts {
 	// 128 or later belong to non us-ascii character set.
 	OPT_XFER_TYPE = 128,
 	OPT_DUMP_HW_PARAMS,
+	// Obsoleted.
+	OPT_MAX_FILE_TIME,
 };
 
 static int allocate_paths(struct xfer_context *xfer, char *const *paths,
@@ -228,7 +230,7 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			    const struct xfer_data *data, int argc,
 			    char *const *argv)
 {
-	static const char *short_opts = "CPhvqf:c:r:t:I";
+	static const char *short_opts = "CPhvqd:s:f:c:r:t:I";
 	static const struct option long_opts[] = {
 		// For generic purposes.
 		{"capture",		0, 0, 'C'},
@@ -237,6 +239,8 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 		{"help",		0, 0, 'h'},
 		{"verbose",		0, 0, 'v'},
 		{"quiet",		0, 0, 'q'},
+		{"duration",		1, 0, 'd'},
+		{"samples",		1, 0, 's'},
 		// For transfer backend.
 		{"format",		1, 0, 'f'},
 		{"channels",		1, 0, 'c'},
@@ -247,6 +251,8 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 		{"separate-channels",	0, 0, 'I'},
 		// For debugging.
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
+		// Obsoleted.
+		{"max-file-time",	1, 0, OPT_MAX_FILE_TIME},
 	};
 	char *s_opts;
 	struct option *l_opts;
@@ -295,6 +301,10 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			++xfer->verbose;
 		else if (key == 'q')
 			xfer->quiet = true;
+		else if (key == 'd')
+			xfer->duration_seconds = arg_parse_decimal_num(optarg, &err);
+		else if (key == 's')
+			xfer->duration_frames = arg_parse_decimal_num(optarg, &err);
 		else if (key == 'f')
 			xfer->sample_format_literal = arg_duplicate_string(optarg, &err);
 		else if (key == 'c')
@@ -309,7 +319,13 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			xfer->dump_hw_params = true;
 		else if (key == '?')
 			return -EINVAL;
-		else {
+		else if (key == OPT_MAX_FILE_TIME) {
+			fprintf(stderr,
+				"An option '--%s' is obsoleted and has no "
+				"effect.\n",
+				l_opts[l_index].name);
+			err = -EINVAL;
+		} else {
 			err = xfer->ops->parse_opt(xfer, key, optarg);
 			if (err < 0 && err != -ENXIO)
 				break;
@@ -326,6 +342,24 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 	return validate_options(xfer);
 }
 
+void xfer_options_calculate_duration(struct xfer_context *xfer,
+				     uint64_t *total_frame_count)
+{
+	uint64_t frame_count;
+
+	if (xfer->duration_seconds > 0) {
+		frame_count = xfer->duration_seconds * xfer->frames_per_second;
+		if (frame_count < *total_frame_count)
+			*total_frame_count = frame_count;
+	}
+
+	if (xfer->duration_frames > 0) {
+		frame_count = xfer->duration_frames;
+		if (frame_count < *total_frame_count)
+			*total_frame_count = frame_count;
+	}
+}
+
 static const char *const allowed_duplication[] = {
 	"/dev/null",
 	"/dev/zero",
diff --git a/axfer/xfer.h b/axfer/xfer.h
index a234851..21ab85d 100644
--- a/axfer/xfer.h
+++ b/axfer/xfer.h
@@ -30,6 +30,8 @@ struct xfer_context {
 	char *sample_format_literal;
 	char *cntr_format_literal;
 	unsigned int verbose;
+	unsigned int duration_seconds;
+	unsigned int duration_frames;
 	unsigned int frames_per_second;
 	unsigned int samples_per_frame;
 	bool help:1;
@@ -68,6 +70,8 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			    const struct xfer_data *data, int argc,
 			    char *const *argv);
 int xfer_options_fixup_paths(struct xfer_context *xfer);
+void xfer_options_calculate_duration(struct xfer_context *xfer,
+				     uint64_t *total_frame_count);
 
 // For internal use in 'xfer' module.
 
-- 
2.19.1
