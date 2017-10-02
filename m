From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 19/39] axfer: add an option to dump
	available hardware parameters
Date: Mon,  2 Oct 2017 09:19:20 +0900
Message-ID: <20171002001940.17218-20-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 5C871266FEA
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
 axfer/options.c         |  9 +++++++++
 axfer/options.h         |  3 +++
 axfer/subcmd-transfer.c |  2 ++
 axfer/xfer-libasound.c  | 11 +++++++++++
 4 files changed, 25 insertions(+)

diff --git a/axfer/options.c b/axfer/options.c
index 6154c0c2..08a047dd 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -12,6 +12,11 @@
 #include <getopt.h>
 #include <math.h>
 
+enum no_short_opts {
+	/* 128 belongs to non us-ascii character set. */
+	OPT_DUMP_HW_PARAMS = 128,
+};
+
 static const char *const allowed_duplication[] = {
 	"/dev/null",
 	"/dev/zero",
@@ -278,6 +283,8 @@ int context_options_init(struct context_options *opts, int argc,
 		{"format",		1, 0, 'f'},
 		{"channels",		1, 0, 'c'},
 		{"rate",		1, 0, 'r'},
+		/* For debugging. */
+		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		{NULL,			0, 0, 0},
 	};
 	const char *cntr_format_literal = NULL;
@@ -310,6 +317,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->samples_per_frame = parse_l(optarg, &err);
 		else if (c == 'r')
 			opts->frames_per_second = parse_l(optarg, &err);
+		else if (c == OPT_DUMP_HW_PARAMS)
+			opts->dump_hw_params = true;
 		else
 			continue;
 
diff --git a/axfer/options.h b/axfer/options.h
index 9c9b46d7..743279af 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -31,6 +31,9 @@ struct context_options {
 	snd_pcm_format_t sample_format;
 	unsigned int samples_per_frame;
 	unsigned int frames_per_second;
+
+	/* For debugging. */
+	bool dump_hw_params;
 };
 
 int context_options_init(struct context_options *opts, int argc,
diff --git a/axfer/subcmd-transfer.c b/axfer/subcmd-transfer.c
index 25fa6715..317a57e3 100644
--- a/axfer/subcmd-transfer.c
+++ b/axfer/subcmd-transfer.c
@@ -481,6 +481,8 @@ int subcmd_transfer(int argc, char *const *argv, snd_pcm_stream_t direction)
 	err = context_init(&ctx, direction);
 	if (err < 0)
 		goto end;
+	if (ctx.opts.dump_hw_params)
+		goto end;
 
 	err = context_pre_process(&ctx, direction, &expected_frame_count);
 	if (err < 0)
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 52451fff..f75dc176 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -67,6 +67,17 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 
 	/* TODO: Applying NO_PERIOD_WAKEUP should be done here. */
 
+	if (opts->dump_hw_params) {
+		logging(state, _("Available HW Params of node: %s\n"),
+			snd_pcm_name(state->handle));
+		snd_pcm_hw_params_dump(state->hw_params, state->log);
+		/*
+		 * TODO: there're more parameters which are not dumped by
+		 * alsa-lib.
+		 */
+		return 0;
+	}
+
 	return set_access_hw_param(state->handle, state->hw_params, opts);
 }
 
-- 
2.11.0
