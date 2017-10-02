From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 38/39] axfer: add a feature to generate
	a file for process id
Date: Mon,  2 Oct 2017 09:19:39 +0900
Message-ID: <20171002001940.17218-39-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 23766267026
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 02:19:56 +0200 (CEST)
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

In current implementation of aplay, during transferring data frames, the
program generates a file with PID in given path for an option
'--process-id-file'.

This commit adds support for this feature. However, usually, an idea of
process ID file is used for programs such that they run several
sub-processes and one of them have significant role to maintain the other
sub-processes. Content of the process ID file includes PID for the
significant sub-process to avoid sending Unix signals to the other
processes. Apparently, aplay and this program are not this kind of program.
This feature makes less sense because process ID for this program can be
found by usual tools such as ps(1) or pgrep(1) which seek nodes on procfs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c | 41 +++++++++++++++++++++++++++++++++++++++--
 axfer/options.h |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index 7e112c42..6e935cd1 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -11,6 +11,8 @@
 
 #include <getopt.h>
 #include <math.h>
+#include <sys/types.h>
+#include <unistd.h>
 
 enum no_short_opts {
 	/* 128 belongs to non us-ascii character set. */
@@ -25,6 +27,7 @@ enum no_short_opts {
 	OPT_DISABLE_SOFTVOL,
 	OPT_SCHED_TYPE,
 	OPT_USE_STRFTIME,
+	OPT_PROCESS_ID_FILE,
 	/* Obsoleted. */
 	OPT_MAX_FILE_TIME,
 };
@@ -206,7 +209,8 @@ static int apply_policies(struct context_options *opts,
 			  const char *waiter_type_literal,
 			  const char *sched_type_literal,
 			  const char *vu_mode_literal,
-			  const char *chmap_literal)
+			  const char *chmap_literal,
+			  const char *pidfile_name_literal)
 {
 	int err;
 
@@ -254,6 +258,30 @@ static int apply_policies(struct context_options *opts,
 			return -ENOMEM;
 	}
 
+	if (pidfile_name_literal) {
+		FILE *fstream;
+
+		opts->pidfile_name = strdup(pidfile_name_literal);
+		if (opts->pidfile_name == NULL) {
+			fprintf(stderr,
+				"Fail to allocate for a name of file with "
+				"process id: %s\n",
+				pidfile_name_literal);
+			return -ENOMEM;
+		}
+
+		unlink(pidfile_name_literal);
+		fstream = fopen(pidfile_name_literal, "w");
+		if (fstream == NULL) {
+			fprintf(stderr,
+				"Fail to generate a file with process id: %s\n",
+				pidfile_name_literal);
+			return -errno;
+		}
+		fprintf(fstream, "%d\n", getpid());
+		fclose(fstream);
+	}
+
 	if (opts->samples_per_frame > 0) {
 		if (opts->samples_per_frame < 1 ||
 		    opts->samples_per_frame > 256) {
@@ -468,6 +496,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"vumeter",		1, 0, 'V'},
 		{"interactive",		0, 0, 'i'},
 		{"chmap",		1, 0, 'm'},
+		{"process-id-file",	1, 0, OPT_PROCESS_ID_FILE},
 		/* Obsoleted. */
 		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
 		{NULL,			0, 0, 0},
@@ -479,6 +508,7 @@ int context_options_init(struct context_options *opts, int argc,
 	const char *sched_type_literal = NULL;
 	const char *vu_mode_literal = NULL;
 	const char *chmap_literal = NULL;
+	const char *pidfile_name_literal = NULL;
 	int l_index = 0;
 	int c;
 	int err = 0;
@@ -555,6 +585,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->interactive = true;
 		else if (c == 'm')
 			chmap_literal = optarg;
+		else if (c == OPT_PROCESS_ID_FILE)
+			pidfile_name_literal = optarg;
 		else if (c == OPT_MAX_FILE_TIME) {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
@@ -575,7 +607,8 @@ int context_options_init(struct context_options *opts, int argc,
 	return apply_policies(opts, direction, cntr_format_literal,
 			      node_literal, sample_format_literal,
 			      waiter_type_literal, sched_type_literal,
-			      vu_mode_literal, chmap_literal);
+			      vu_mode_literal, chmap_literal,
+			      pidfile_name_literal);
 }
 
 /*
@@ -922,6 +955,10 @@ void context_options_destroy(struct context_options *opts)
 {
 	int i;
 
+	if (opts->pidfile_name)
+		unlink(opts->pidfile_name);
+	opts->pidfile_name = NULL;
+
 	if (opts->paths) {
 		for (i = 0; i < opts->path_count; ++i)
 			free(opts->paths[i]);
diff --git a/axfer/options.h b/axfer/options.h
index b8aba167..e8e4524b 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -74,6 +74,7 @@ struct context_options {
 	enum vumeter_mode vu_mode;
 	bool interactive;
 	char *chmap_literal;
+	char *pidfile_name;
 };
 
 int context_options_init(struct context_options *opts, int argc,
-- 
2.11.0
