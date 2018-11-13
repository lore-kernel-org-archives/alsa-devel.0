From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 29/35] axfer: add an option for waiter type
Date: Tue, 13 Nov 2018 15:41:41 +0900
Message-ID: <20181113064147.13577-29-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 2858A267AA4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:44 +0100 (CET)
Received: by mail-pf1-f194.google.com with SMTP id v76-v6so2716766pfa.5
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:44 -0800 (PST)
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

This commit is an integration to add an option for users to choose waiter
type. Users give the type to value to '--waiter-type' ('-w') option to
choose it. Currently, 'snd_pcm_wait()' is just supported as a default.
This alsa-lib API is implemented with a call of poll(2).

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/xfer-libasound.c | 26 +++++++++++++++++++++++++-
 axfer/xfer-libasound.h |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 5cef9f1..fa72839 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -13,6 +13,7 @@ enum no_short_opts {
         // 200 or later belong to non us-ascii character set.
 	OPT_PERIOD_SIZE = 200,
 	OPT_BUFFER_SIZE,
+	OPT_WAITER_TYPE,
 	OPT_DISABLE_RESAMPLE,
 	OPT_DISABLE_CHANNELS,
 	OPT_DISABLE_FORMAT,
@@ -33,6 +34,7 @@ static const struct option l_opts[] = {
 	{"avail-min",		1, 0, 'A'},
 	{"start-delay",		1, 0, 'R'},
 	{"stop-delay",		1, 0, 'T'},
+	{"waiter-type",		1, 0, OPT_WAITER_TYPE},
 	// For plugins in alsa-lib.
 	{"disable-resample",	0, 0, OPT_DISABLE_RESAMPLE},
 	{"disable-channels",	0, 0, OPT_DISABLE_CHANNELS},
@@ -86,6 +88,8 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 		state->msec_for_start_threshold = arg_parse_decimal_num(optarg, &err);
 	else if (key == 'T')
 		state->msec_for_stop_threshold = arg_parse_decimal_num(optarg, &err);
+	else if (key == OPT_WAITER_TYPE)
+		state->waiter_type_literal = arg_duplicate_string(optarg, &err);
 	else if (key == OPT_DISABLE_RESAMPLE)
 		state->no_auto_resample = true;
 	else if (key == OPT_DISABLE_CHANNELS)
@@ -147,6 +151,25 @@ int xfer_libasound_validate_opts(struct xfer_context *xfer)
 		}
 	}
 
+	if (state->waiter_type_literal != NULL) {
+		if (state->test_nowait) {
+			fprintf(stderr,
+				"An option for waiter type should not be "
+				"used with nowait test option.\n");
+			return -EINVAL;
+		}
+		if (!state->nonblock && !state->mmap) {
+			fprintf(stderr,
+				"An option for waiter type should be used "
+				"with nonblock or mmap options.\n");
+			return -EINVAL;
+		}
+		state->waiter_type =
+			waiter_type_from_label(state->waiter_type_literal);
+	} else {
+		state->waiter_type = WAITER_TYPE_DEFAULT;
+	}
+
 	return err;
 }
 
@@ -201,7 +224,6 @@ static int open_handle(struct xfer_context *xfer)
 
 	if ((state->nonblock || state->mmap) && !state->test_nowait)
 		state->use_waiter = true;
-	state->waiter_type = WAITER_TYPE_DEFAULT;
 
 	err = snd_pcm_hw_params_any(state->handle, state->hw_params);
 	if (err < 0)
@@ -751,7 +773,9 @@ static void xfer_libasound_destroy(struct xfer_context *xfer)
 	struct libasound_state *state = xfer->private_data;
 
 	free(state->node_literal);
+	free(state->waiter_type_literal);
 	state->node_literal = NULL;
+	state->waiter_type_literal = NULL;
 
 	if (state->hw_params)
 		snd_pcm_hw_params_free(state->hw_params);
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 0bcfb40..20b0d74 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -30,6 +30,7 @@ struct libasound_state {
 	bool verbose;
 
 	char *node_literal;
+	char *waiter_type_literal;
 
 	unsigned int msec_per_period;
 	unsigned int msec_per_buffer;
-- 
2.19.1
