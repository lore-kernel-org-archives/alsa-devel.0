From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 23/23] aplay: add a feature to generate
	PID file
Date: Thu, 17 Aug 2017 21:00:04 +0900
Message-ID: <20170817120004.15326-24-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 296F7266F04
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:16 +0200 (CEST)
In-Reply-To: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

In current implementation of aplay, during transferring data frames, the
program generates a file with PID in given path for an option
'--process-id-file'.

This commit adds a parser for this option. Actual code to generate the
ile is not implemented yet.
---
 aplay/options.c | 20 ++++++++++++++++++--
 aplay/options.h |  1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/aplay/options.c b/aplay/options.c
index 005a7bf..c9d0a13 100644
--- a/aplay/options.c
+++ b/aplay/options.c
@@ -27,6 +27,7 @@ enum no_short_opts {
 	OPT_TEST_NOWAIT,
 	OPT_DUMP_HWPARAMS,
 	OPT_FATAL_ERRORS,
+	OPT_PROCESS_ID_FILE,
 };
 
 static long parse_l(const char *str, int *err)
@@ -200,7 +201,8 @@ static int apply_policies(struct context_options *opts,
 			  const char *node_literal,
 			  const char *sample_format_literal,
 			  const char *vu_mode_literal,
-			  const char *chmap_literal)
+			  const char *chmap_literal,
+			  const char *pidfile_name_literal)
 {
 	int err;
 
@@ -247,6 +249,15 @@ static int apply_policies(struct context_options *opts,
 			return -ENOMEM;
 	}
 
+	if (pidfile_name_literal) {
+		opts->pidfile_name = strdup(pidfile_name_literal);
+		if (opts->pidfile_name == NULL) {
+			printf(_("Fail to allocate for pidfile name: %s\n"),
+			       pidfile_name_literal);
+			return -ENOMEM;
+		}
+	}
+
 	if (opts->samples_per_frame > 0) {
 		if (opts->samples_per_frame < 1 ||
 		    opts->samples_per_frame > 256) {
@@ -384,6 +395,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"vumeter",		1, 0, 'V'},
 		{"chmap",		1, 0, 'm'},
 		{"interactive",		0, 0, 'i'},
+		{"process-id-file",	1, 0, OPT_PROCESS_ID_FILE},
 		{NULL,			0, 0, 0},
 	};
 	const char *cntr_format_literal = NULL;
@@ -391,6 +403,7 @@ int context_options_init(struct context_options *opts, int argc,
 	const char *sample_format_literal = NULL;
 	const char *vu_mode_literal = NULL;
 	const char *chmap_literal = NULL;
+	const char *pidfile_name_literal = NULL;
 	int c;
 	int err = 0;
 
@@ -464,6 +477,8 @@ int context_options_init(struct context_options *opts, int argc,
 			chmap_literal = optarg;
 		else if (c == 'i')
 			opts->interactive = true;
+		else if (c == OPT_PROCESS_ID_FILE)
+			pidfile_name_literal = optarg;
 		else
 			continue;
 
@@ -477,7 +492,8 @@ int context_options_init(struct context_options *opts, int argc,
 
 	return apply_policies(opts, direction, cntr_format_literal,
 			      node_literal, sample_format_literal,
-			      vu_mode_literal, chmap_literal);
+			      vu_mode_literal, chmap_literal,
+			      pidfile_name_literal);
 }
 
 /*
diff --git a/aplay/options.h b/aplay/options.h
index 48ba859..0189432 100644
--- a/aplay/options.h
+++ b/aplay/options.h
@@ -58,6 +58,7 @@ struct context_options {
 
 	char **paths;
 	unsigned int path_count;
+	char *pidfile_name;
 };
 
 int context_options_init(struct context_options *opts, int argc,
-- 
2.11.0
