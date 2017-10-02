From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 18/39] axfer: add informative output and
	an option to suppress it
Date: Mon,  2 Oct 2017 09:19:19 +0900
Message-ID: <20171002001940.17218-19-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 507F7266FE0
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

In current aplay, some informative output is available as a default. This
can be suppressed by a quiet option. This commit adds support for it.

Unfortunately, original implementation includes contradiction in a case
to handle multiple files, thus this commit cannot keep fully compatibility.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c         |  5 ++++-
 axfer/options.h         |  1 +
 axfer/subcmd-transfer.c | 27 +++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/axfer/options.c b/axfer/options.c
index 256f93a1..6154c0c2 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -263,11 +263,12 @@ static int apply_policies(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvt:ID:f:c:r:";
+	static const char *s_opts = "hvqt:ID:f:c:r:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
 		{"verbose",		0, 0, 'v'},
+		{"quiet",		0, 0, 'q'},
 		/* For containers. */
 		{"file-type",		1, 0, 't'},
 		/* For mapper. */
@@ -295,6 +296,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->help = true;
 		else if (c == 'v')
 			++opts->verbose;
+		else if (c == 'q')
+			opts->quiet = true;
 		else if (c == 't')
 			cntr_format_literal = optarg;
 		else if (c == 'I')
diff --git a/axfer/options.h b/axfer/options.h
index 38bdbb74..9c9b46d7 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -16,6 +16,7 @@ struct context_options {
 
 	/* For generic purposes. */
 	unsigned int verbose;
+	bool quiet;
 
 	/* For containers. */
 	char **paths;
diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index 5ce312e0..25fa6715 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -363,6 +363,21 @@ static int context_process_frames(struct context *ctx,
 	int i;
 	int err = 0;
 
+	if (!ctx->opts.quiet) {
+		fprintf(stderr,
+			_("%s: Format '%s', Rate %u Hz, Channels "),
+			snd_pcm_stream_name(direction),
+			snd_pcm_format_description(ctx->opts.sample_format),
+			ctx->opts.frames_per_second);
+		if (ctx->opts.samples_per_frame == 1)
+			fprintf(stderr, _("'monaural'"));
+		else if (ctx->opts.samples_per_frame == 2)
+			fprintf(stderr, "'Stereo'");
+		else
+			fprintf(stderr, "%u", ctx->opts.samples_per_frame);
+		fprintf(stderr, "\n");
+	}
+
 	*actual_frame_count = 0;
 	while (!ctx->interrupted) {
 		struct container_context *cntr;
@@ -393,6 +408,18 @@ static int context_process_frames(struct context *ctx,
 			break;
 	}
 
+	if (!ctx->opts.quiet) {
+		fprintf(stderr,
+			_("%s: Expected %lu frames, Actual %lu frames\n"),
+			snd_pcm_stream_name(direction), expected_frame_count,
+			*actual_frame_count);
+		if (ctx->interrupted) {
+			fprintf(stderr, _("Aborted by signal: %s\n"),
+			       strsignal(ctx->signal));
+			return 0;
+		}
+	}
+
 	return err;
 }
 
-- 
2.11.0
