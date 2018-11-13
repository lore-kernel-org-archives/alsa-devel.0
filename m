From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/35] axfer: add an option to dump available
	hardware parameters
Date: Tue, 13 Nov 2018 15:41:31 +0900
Message-ID: <20181113064147.13577-19-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DAF22267AE5
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:27 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so2795170pln.9
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:27 -0800 (PST)
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

In ALSA PCM interface, before configuring hardware actually, applications
can request available set of hardware parameters for runtime of PCM
substream. The set of parameters are represented and delivered by a
structure.

In alsa-lib PCM API, the above design is abstracted by a series of
snd_pcm_hw_params_xxx() functions. An actual layout of the structure is
hidden from applications by an opaque pointer.

In aplay, '--dump-hw-params' option is for this purpose. With this option,
the command output available set of the hardware parameters.

This commit adds support for the option. Unlike aplay, this commit takes
this program to finish after dumping the parameters for simplicity of
usage.

I note that all of combinations in the set are not necessarily available
when the PCM substream includes dependencies of parameters described by
constraints and rules.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/subcmd-transfer.c | 2 +-
 axfer/xfer-libasound.c  | 9 +++++++++
 axfer/xfer-options.c    | 5 +++++
 axfer/xfer.h            | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index a165a93..36817f3 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -447,7 +447,7 @@ int subcmd_transfer(int argc, char *const *argv, snd_pcm_stream_t direction)
 	err = context_init(&ctx, direction, argc, argv);
 	if (err < 0)
 		goto end;
-	if (ctx.xfer.help)
+	if (ctx.xfer.help || ctx.xfer.dump_hw_params)
 		goto end;
 
 	err = context_pre_process(&ctx, direction, &expected_frame_count);
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index bf1b056..60e9aab 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -99,6 +99,15 @@ static int open_handle(struct xfer_context *xfer)
 
 	// TODO: Applying NO_PERIOD_WAKEUP should be done here.
 
+	if (xfer->dump_hw_params) {
+		logging(state, "Available HW Params of node: %s\n",
+			snd_pcm_name(state->handle));
+		snd_pcm_hw_params_dump(state->hw_params, state->log);
+		// TODO: there're more parameters which are not dumped by
+		// alsa-lib.
+		return 0;
+	}
+
 	return set_access_hw_param(state);
 }
 
diff --git a/axfer/xfer-options.c b/axfer/xfer-options.c
index 7790ea9..21fc6bb 100644
--- a/axfer/xfer-options.c
+++ b/axfer/xfer-options.c
@@ -16,6 +16,7 @@
 enum no_short_opts {
 	// 128 or later belong to non us-ascii character set.
 	OPT_XFER_TYPE = 128,
+	OPT_DUMP_HW_PARAMS,
 };
 
 static int allocate_paths(struct xfer_context *xfer, char *const *paths,
@@ -244,6 +245,8 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 		{"file-type",		1, 0, 't'},
 		// For mapper.
 		{"separate-channels",	0, 0, 'I'},
+		// For debugging.
+		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 	};
 	char *s_opts;
 	struct option *l_opts;
@@ -302,6 +305,8 @@ int xfer_options_parse_args(struct xfer_context *xfer,
 			xfer->cntr_format_literal = arg_duplicate_string(optarg, &err);
 		else if (key == 'I')
 			xfer->multiple_cntrs = true;
+		else if (key == OPT_DUMP_HW_PARAMS)
+			xfer->dump_hw_params = true;
 		else if (key == '?')
 			return -EINVAL;
 		else {
diff --git a/axfer/xfer.h b/axfer/xfer.h
index 0ed84e4..a234851 100644
--- a/axfer/xfer.h
+++ b/axfer/xfer.h
@@ -34,6 +34,7 @@ struct xfer_context {
 	unsigned int samples_per_frame;
 	bool help:1;
 	bool quiet:1;
+	bool dump_hw_params:1;
 	bool multiple_cntrs:1;	// For mapper.
 
 	snd_pcm_format_t sample_format;
-- 
2.19.1
