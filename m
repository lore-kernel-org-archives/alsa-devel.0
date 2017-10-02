From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 39/39] axfer: obsolete some test options
Date: Mon,  2 Oct 2017 09:19:40 +0900
Message-ID: <20171002001940.17218-40-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 01AE5267041
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 02:19:58 +0200 (CEST)
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

In aplay, some test options are available, however their test strategy is
not enough good to check runtime of PCM substream.

This commit obsoletes these options.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/axfer/options.c b/axfer/options.c
index 6e935cd1..baddfb27 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -30,6 +30,8 @@ enum no_short_opts {
 	OPT_PROCESS_ID_FILE,
 	/* Obsoleted. */
 	OPT_MAX_FILE_TIME,
+	OPT_TEST_POSITION,
+	OPT_TEST_COEF,
 };
 
 static const char *const allowed_duplication[] = {
@@ -499,6 +501,8 @@ int context_options_init(struct context_options *opts, int argc,
 		{"process-id-file",	1, 0, OPT_PROCESS_ID_FILE},
 		/* Obsoleted. */
 		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
+		{"test-position",	0, 0, OPT_TEST_POSITION},
+		{"test-coef",		1, 0, OPT_TEST_COEF},
 		{NULL,			0, 0, 0},
 	};
 	const char *cntr_format_literal = NULL;
@@ -587,7 +591,9 @@ int context_options_init(struct context_options *opts, int argc,
 			chmap_literal = optarg;
 		else if (c == OPT_PROCESS_ID_FILE)
 			pidfile_name_literal = optarg;
-		else if (c == OPT_MAX_FILE_TIME) {
+		else if (c == OPT_MAX_FILE_TIME ||
+			 c == OPT_TEST_POSITION ||
+			 c == OPT_TEST_COEF) {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
 				"effect.\n",
-- 
2.11.0
