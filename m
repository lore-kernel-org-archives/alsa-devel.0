From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/35] axfer: add informative output and an
	option to suppress it
Date: Tue, 13 Nov 2018 15:41:30 +0900
Message-ID: <20181113064147.13577-18-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24FCE267B3E
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:25 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so5554462pfk.0
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:25 -0800 (PST)
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

In current aplay, some informative output is available as a default. This
can be suppressed by a quiet option. This commit adds support for it.

An original aplay implementation has no effect of this option in a case
to handle multiple files. However, in a point of usability, this commit
support this case.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/subcmd-transfer.c | 27 +++++++++++++++++++++++++++
 axfer/xfer-options.c    |  5 ++++-
 axfer/xfer.h            |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index 188589f..a165a93 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -340,6 +340,21 @@ static int context_process_frames(struct context *ctx,
 	int i;
 	int err = 0;
 
+	if (!ctx->xfer.quiet) {
+		fprintf(stderr,
+			"%s: Format '%s', Rate %u Hz, Channels ",
+			snd_pcm_stream_name(direction),
+			snd_pcm_format_description(ctx->xfer.sample_format),
+			ctx->xfer.frames_per_second);
+		if (ctx->xfer.samples_per_frame == 1)
+			fprintf(stderr, "'monaural'");
+		else if (ctx->xfer.samples_per_frame == 2)
+			fprintf(stderr, "'Stereo'");
+		else
+			fprintf(stderr, "%u", ctx->xfer.samples_per_frame);
+		fprintf(stderr, "\n");
+	}
+
 	*actual_frame_count = 0;
 	while (!ctx->interrupted) {
 		struct container_context *cntr;
@@ -370,6 +385,18 @@ static int context_process_frames(struct context *ctx,
 			break;
 	}
 
+	if (!ctx->xfer.quiet) {
+		fprintf(stderr,
+			"%s: Expected %lu frames, Actual %lu frames\n",
+			snd_pcm_stream_name(direction), expected_frame_count,
+			*actual_frame_count);
+		if (ctx->interrupted) {
+			fprintf(stderr, "Aborted by signal: %s\n",
+			       strsignal(ctx->signal));
+			return 0;
+		}
+	}
+
 	return err;
 }
 
diff --git a/axfer/xfer-options.c b/axfer/xfer-options.c
index fb71244..7790ea9 100644
--- a/axfer/xfer-options.c
+++ b/axfer/xfer-options.c
@@ -227,7 +227,7 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			    const struct xfer_data *data, int argc,
 			    char *const *argv)
 {
-	static const char *short_opts = "CPhvf:c:r:t:I";
+	static const char *short_opts = "CPhvqf:c:r:t:I";
 	static const struct option long_opts[] = {
 		// For generic purposes.
 		{"capture",		0, 0, 'C'},
@@ -235,6 +235,7 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 		{"xfer-type",		1, 0, OPT_XFER_TYPE},
 		{"help",		0, 0, 'h'},
 		{"verbose",		0, 0, 'v'},
+		{"quiet",		0, 0, 'q'},
 		// For transfer backend.
 		{"format",		1, 0, 'f'},
 		{"channels",		1, 0, 'c'},
@@ -289,6 +290,8 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			xfer->help = true;
 		else if (key == 'v')
 			++xfer->verbose;
+		else if (key == 'q')
+			xfer->quiet = true;
 		else if (key == 'f')
 			xfer->sample_format_literal = arg_duplicate_string(optarg, &err);
 		else if (key == 'c')
diff --git a/axfer/xfer.h b/axfer/xfer.h
index df43d1c..0ed84e4 100644
--- a/axfer/xfer.h
+++ b/axfer/xfer.h
@@ -33,6 +33,7 @@ struct xfer_context {
 	unsigned int frames_per_second;
 	unsigned int samples_per_frame;
 	bool help:1;
+	bool quiet:1;
 	bool multiple_cntrs:1;	// For mapper.
 
 	snd_pcm_format_t sample_format;
-- 
2.19.1
