From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 38/38] axfer: add an option for waiter
	type
Date: Tue, 19 Sep 2017 09:44:18 +0900
Message-ID: <20170919004418.24668-39-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 73842266E8B
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:34 +0200 (CEST)
In-Reply-To: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit is an integration to add an option for users to select waiter
type. Currently, 'poll' and 'epoll' types are supported. Users give the
type for '--waiter-type' ('-w') option to select it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c        | 35 ++++++++++++++++++++++++++++++++---
 axfer/options.h        |  3 +++
 axfer/waiter.c         | 17 +++++++++++++++++
 axfer/waiter.h         |  2 ++
 axfer/xfer-libasound.c |  2 +-
 5 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index 76d93034..425d51ab 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -207,6 +207,7 @@ static int apply_policies(struct context_options *opts,
 			  const char *cntr_format_literal,
 			  const char *node_literal,
 			  const char *sample_format_literal,
+			  const char *waiter_type_literal,
 			  const char *vu_mode_literal,
 			  const char *chmap_literal,
 			  const char *pidfile_name_literal)
@@ -395,6 +396,30 @@ static int apply_policies(struct context_options *opts,
 		}
 	}
 
+	if (waiter_type_literal != NULL) {
+		if (opts->test_nowait) {
+			fprintf(stderr,
+				"An option for waiter type should not be used "
+				"with nowait test option.\n");
+			return -EINVAL;
+		}
+		if (!opts->nonblock && !opts->mmap) {
+			fprintf(stderr,
+				"An option for waiter type should be used with "
+				"nonblock or mmap options.\n");
+			return -EINVAL;
+		}
+		opts->waiter_type = waiter_type_from_label(waiter_type_literal);
+		if (opts->waiter_type == WAITER_TYPE_UNKNOWN) {
+			fprintf(stderr,
+				"An option for waiter type is invalid: %s\n",
+				waiter_type_literal);
+			return -EINVAL;
+		}
+	} else {
+		opts->waiter_type = WAITER_TYPE_POLL;
+	}
+
 	return 0;
 }
 
@@ -419,7 +444,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:A:R:T:V:im:";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMw:F:B:A:R:T:V:im:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -439,6 +464,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"rate",		1, 0, 'r'},
 		{"nonblock",            0, 0, 'N'},
 		{"mmap",                0, 0, 'M'},
+		{"waiter-type",		1, 0, 'w'},
 		{"period-time",		1, 0, 'F'},
 		{"buffer-time",		1, 0, 'B'},
 		{"period-size",		1, 0, OPT_PERIOD_SIZE},
@@ -469,6 +495,7 @@ int context_options_init(struct context_options *opts, int argc,
 	const char *cntr_format_literal = NULL;
 	const char *node_literal = NULL;
 	const char *sample_format_literal = NULL;
+	const char *waiter_type_literal = NULL;
 	const char *vu_mode_literal = NULL;
 	const char *chmap_literal = NULL;
 	const char *pidfile_name_literal = NULL;
@@ -510,6 +537,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->nonblock = true;
 		else if (c == 'M')
 			opts->mmap = true;
+		else if (c == 'w')
+			waiter_type_literal = optarg;
 		else if (c == 'F')
 			opts->msec_per_period = parse_l(optarg, &err);
 		else if (c == 'B')
@@ -567,8 +596,8 @@ int context_options_init(struct context_options *opts, int argc,
 
 	return apply_policies(opts, direction, cntr_format_literal,
 			      node_literal, sample_format_literal,
-			      vu_mode_literal, chmap_literal,
-			      pidfile_name_literal);
+			      waiter_type_literal, vu_mode_literal,
+			      chmap_literal, pidfile_name_literal);
 }
 
 /*
diff --git a/axfer/options.h b/axfer/options.h
index f1989ae6..22b149a7 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -11,6 +11,7 @@
 
 #include "container.h"
 #include "vumeter.h"
+#include "waiter.h"
 
 struct context_options {
 	bool help;
@@ -38,6 +39,8 @@ struct context_options {
 	bool nonblock;
 	bool mmap;
 
+	enum waiter_type waiter_type;
+
 	unsigned int msec_per_period;
 	unsigned int msec_per_buffer;
 	unsigned int frames_per_period;
diff --git a/axfer/waiter.c b/axfer/waiter.c
index f4e21a16..8e3789b9 100644
--- a/axfer/waiter.c
+++ b/axfer/waiter.c
@@ -14,6 +14,23 @@
 
 #include "misc.h"
 
+const char *const waiter_type_labels[] = {
+	[WAITER_TYPE_POLL] = "poll",
+	[WAITER_TYPE_EPOLL] = "epoll",
+};
+
+enum waiter_type waiter_type_from_label(const char *label)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(waiter_type_labels); ++i) {
+		if (!strcmp(waiter_type_labels[i], label))
+				return i;
+	}
+
+	return WAITER_TYPE_UNKNOWN;
+}
+
 int waiter_context_init(struct waiter_context *waiter, enum waiter_type type)
 {
 	struct {
diff --git a/axfer/waiter.h b/axfer/waiter.h
index 3f0dd744..aedc42f8 100644
--- a/axfer/waiter.h
+++ b/axfer/waiter.h
@@ -10,6 +10,7 @@
 #define __ALSA_UTILS_AXFER_WAITER__H_
 
 enum waiter_type {
+	WAITER_TYPE_UNKNOWN = -1,
 	WAITER_TYPE_POLL = 0,
 	WAITER_TYPE_EPOLL,
 	WAITER_TYPE_COUNT,
@@ -23,6 +24,7 @@ struct waiter_context {
 	void *private_data;
 };
 
+enum waiter_type waiter_type_from_label(const char *label);
 int waiter_context_init(struct waiter_context *waiter, enum waiter_type type);
 int waiter_context_prepare(struct waiter_context *waiter, int *fds,
 			   unsigned int fd_count);
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index e00cfaa9..1bd23f12 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -100,7 +100,7 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 		if (state->waiter == NULL)
 			return -ENOMEM;
 
-		err = waiter_context_init(state->waiter, WAITER_TYPE_POLL);
+		err = waiter_context_init(state->waiter, opts->waiter_type);
 		if (err < 0)
 			return err;
 	}
-- 
2.11.0
