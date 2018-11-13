From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 34/35] axfer: obsolete some unimplemented
	options
Date: Tue, 13 Nov 2018 15:41:46 +0900
Message-ID: <20181113064147.13577-34-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id E6708267B94
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:53 +0100 (CET)
Received: by mail-pl1-f195.google.com with SMTP id w24-v6so5526945plq.3
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:53 -0800 (PST)
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

Althogh many options are actually supported by aplay, some of them are
not enough good in practical points. For example, '--test-position'
option is meaningless for some use cases. Furthermore, due to practical
reasons, some options are not implemented well; e.g. vumeter.

This commit marks such options as 'obsoleted'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/xfer-libasound.c | 13 ++++++++++++-
 axfer/xfer-options.c   | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index f6d0515..bacd835 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -26,9 +26,12 @@ enum no_short_opts {
 	OPT_DISABLE_SOFTVOL,
 	OPT_FATAL_ERRORS,
 	OPT_TEST_NOWAIT,
+	// Obsoleted.
+	OPT_TEST_POSITION,
+	OPT_TEST_COEF,
 };
 
-#define S_OPTS	"D:NMF:B:A:R:T:"
+#define S_OPTS	"D:NMF:B:A:R:T:m:"
 static const struct option l_opts[] = {
 	{"device",		1, 0, 'D'},
 	{"nonblock",		0, 0, 'N'},
@@ -50,6 +53,10 @@ static const struct option l_opts[] = {
 	// For debugging.
 	{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 	{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
+	// Obsoleted.
+	{"chmap",		1, 0, 'm'},
+	{"test-position",	0, 0, OPT_TEST_POSITION},
+	{"test-coef",		1, 0, OPT_TEST_COEF},
 };
 
 static int xfer_libasound_init(struct xfer_context *xfer,
@@ -107,6 +114,10 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 		state->no_auto_format = true;
 	else if (key == OPT_DISABLE_SOFTVOL)
 		state->no_softvol = true;
+	else if (key == 'm' ||
+		 key == OPT_TEST_POSITION ||
+		 key == OPT_TEST_COEF)
+		err = -EINVAL;
 	else if (key == OPT_FATAL_ERRORS)
 		state->finish_at_xrun = true;
 	else if (key == OPT_TEST_NOWAIT)
diff --git a/axfer/xfer-options.c b/axfer/xfer-options.c
index d899134..5a68646 100644
--- a/axfer/xfer-options.c
+++ b/axfer/xfer-options.c
@@ -21,6 +21,8 @@ enum no_short_opts {
 	OPT_BUFFER_SIZE,
 	// Obsoleted.
 	OPT_MAX_FILE_TIME,
+	OPT_USE_STRFTIME,
+	OPT_PROCESS_ID_FILE,
 };
 
 static int allocate_paths(struct xfer_context *xfer, char *const *paths,
@@ -232,7 +234,7 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			    const struct xfer_data *data, int argc,
 			    char *const *argv)
 {
-	static const char *short_opts = "CPhvqd:s:f:c:r:t:I";
+	static const char *short_opts = "CPhvqd:s:f:c:r:t:IV:i";
 	static const struct option long_opts[] = {
 		// For generic purposes.
 		{"capture",		0, 0, 'C'},
@@ -255,6 +257,10 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		// Obsoleted.
 		{"max-file-time",	1, 0, OPT_MAX_FILE_TIME},
+		{"use-strftime",	0, 0, OPT_USE_STRFTIME},
+		{"process-id-file",	1, 0, OPT_PROCESS_ID_FILE},
+		{"vumeter",		1, 0, 'V'},
+		{"interactive",		0, 0, 'i'},
 	};
 	char *s_opts;
 	struct option *l_opts;
@@ -321,7 +327,11 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			xfer->dump_hw_params = true;
 		else if (key == '?')
 			return -EINVAL;
-		else if (key == OPT_MAX_FILE_TIME) {
+		else if (key == OPT_MAX_FILE_TIME ||
+			 key == OPT_USE_STRFTIME ||
+			 key == OPT_PROCESS_ID_FILE ||
+			 key == 'V' ||
+			 key == 'i') {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
 				"effect.\n",
-- 
2.19.1
