From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 21/35] axfer: add an option to finish
	transmission at XRUN
Date: Tue, 13 Nov 2018 15:41:33 +0900
Message-ID: <20181113064147.13577-21-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id E6745267B58
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:31 +0100 (CET)
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so2866601pfm.4
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:31 -0800 (PST)
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

In aplay, '--fatal-errors' option has an effect to give up recovery of PCM
substream from XRUN state. This commit adds support for this option.

In original implementation, this option brings program abort. This seems
to generate core dump of process VMA. However, typically, XRUN comes from
timing mismatch between hardware and application, therefore core dump has
less helpful. This commit finishes this program in usual way with this
option at XRUN.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/xfer-libasound.c | 11 ++++++++++-
 axfer/xfer-libasound.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 60e9aab..77c142e 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -9,9 +9,16 @@
 #include "xfer-libasound.h"
 #include "misc.h"
 
+enum no_short_opts {
+        // 200 or later belong to non us-ascii character set.
+	OPT_FATAL_ERRORS = 200,
+};
+
 #define S_OPTS	"D:"
 static const struct option l_opts[] = {
 	{"device",		1, 0, 'D'},
+	// For debugging.
+	{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 };
 
 static int xfer_libasound_init(struct xfer_context *xfer,
@@ -39,6 +46,8 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 
 	if (key == 'D')
 		state->node_literal = arg_duplicate_string(optarg, &err);
+	else if (key == OPT_FATAL_ERRORS)
+		state->finish_at_xrun = true;
 	else
 		err = -ENXIO;
 
@@ -305,7 +314,7 @@ static int xfer_libasound_process_frames(struct xfer_context *xfer,
 	if (err < 0) {
 		if (err == -EAGAIN)
 			return err;
-		if (err == -EPIPE) {
+		if (err == -EPIPE && !state->finish_at_xrun) {
 			// Recover the stream and continue processing
 			// immediately. In this program -EPIPE comes from
 			// libasound implementation instead of file I/O.
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 3f3ae6e..270288d 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -29,6 +29,8 @@ struct libasound_state {
 	bool verbose;
 
 	char *node_literal;
+
+	bool finish_at_xrun:1;
 };
 
 // For internal use in 'libasound' module.
-- 
2.19.1
