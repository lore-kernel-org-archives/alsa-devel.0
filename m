From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 37/39] axfer: add a parser for channel
	map API
Date: Mon,  2 Oct 2017 09:19:38 +0900
Message-ID: <20171002001940.17218-38-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 2B58D26702F
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

Current aplay has an option to use channel map API of alsa-lib. This API
allows applications to get/set channel position by a position array; e.g.
'FR,FL' and 'LFE,FL,FR'.

This commit adds support for the feature. However, neither alsa-lib
implementation nor ALSA PCM interface, configuring the channel map is not
supported. Therefore, this feature makes no sense except for displaying
current channel map.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c        | 29 ++++++++++++++++++++++++++---
 axfer/options.h        |  1 +
 axfer/xfer-libasound.c | 32 ++++++++++++++++++++++++++++++++
 axfer/xfer-libasound.h |  2 ++
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index d4e7876b..7e112c42 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -205,7 +205,8 @@ static int apply_policies(struct context_options *opts,
 			  const char *sample_format_literal,
 			  const char *waiter_type_literal,
 			  const char *sched_type_literal,
-			  const char *vu_mode_literal)
+			  const char *vu_mode_literal,
+			  const char *chmap_literal)
 {
 	int err;
 
@@ -238,6 +239,21 @@ static int apply_policies(struct context_options *opts,
 			return err;
 	}
 
+	if (chmap_literal) {
+		snd_pcm_chmap_t *chmap;
+		chmap = snd_pcm_chmap_parse_string(chmap_literal);
+		if (chmap == NULL) {
+			fprintf(stderr,
+				"Unable to parse channel map string: '%s'\n",
+				chmap_literal);
+			return -EINVAL;
+		}
+		free(chmap);
+		opts->chmap_literal = strdup(chmap_literal);
+		if (opts->chmap_literal == NULL)
+			return -ENOMEM;
+	}
+
 	if (opts->samples_per_frame > 0) {
 		if (opts->samples_per_frame < 1 ||
 		    opts->samples_per_frame > 256) {
@@ -409,7 +425,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMw:F:B:A:R:T:V:i";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMw:F:B:A:R:T:V:im:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -451,6 +467,7 @@ int context_options_init(struct context_options *opts, int argc,
 		/* Misc features. */
 		{"vumeter",		1, 0, 'V'},
 		{"interactive",		0, 0, 'i'},
+		{"chmap",		1, 0, 'm'},
 		/* Obsoleted. */
 		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
 		{NULL,			0, 0, 0},
@@ -461,6 +478,7 @@ int context_options_init(struct context_options *opts, int argc,
 	const char *waiter_type_literal = NULL;
 	const char *sched_type_literal = NULL;
 	const char *vu_mode_literal = NULL;
+	const char *chmap_literal = NULL;
 	int l_index = 0;
 	int c;
 	int err = 0;
@@ -535,6 +553,8 @@ int context_options_init(struct context_options *opts, int argc,
 			vu_mode_literal = optarg;
 		else if (c == 'i')
 			opts->interactive = true;
+		else if (c == 'm')
+			chmap_literal = optarg;
 		else if (c == OPT_MAX_FILE_TIME) {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
@@ -555,7 +575,7 @@ int context_options_init(struct context_options *opts, int argc,
 	return apply_policies(opts, direction, cntr_format_literal,
 			      node_literal, sample_format_literal,
 			      waiter_type_literal, sched_type_literal,
-			      vu_mode_literal);
+			      vu_mode_literal, chmap_literal);
 }
 
 /*
@@ -909,6 +929,9 @@ void context_options_destroy(struct context_options *opts)
 	}
 	if (opts->node)
 		free(opts->node);
+	if (opts->chmap_literal)
+		free(opts->chmap_literal);
 	opts->paths = NULL;
 	opts->node = NULL;
+	opts->chmap_literal = NULL;
 }
diff --git a/axfer/options.h b/axfer/options.h
index fed9a40e..b8aba167 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -73,6 +73,7 @@ struct context_options {
 	/* Misc features. */
 	enum vumeter_mode vu_mode;
 	bool interactive;
+	char *chmap_literal;
 };
 
 int context_options_init(struct context_options *opts, int argc,
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 92aba3c4..4e8c6e2e 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -84,6 +84,17 @@ static int disable_period_wakeup(struct libasound_state *state)
 	return err;
 }
 
+static void dump_chmap(struct libasound_state *state,
+		       const snd_pcm_chmap_t *chmap)
+{
+	int i;
+
+	logging(state, "    channels: %u\n", chmap->channels);
+	for (i = 0; i < chmap->channels; ++i)
+		logging(state, "      ch%u: %s\n",
+			i, snd_pcm_chmap_name(chmap->pos[i]));
+}
+
 static int xfer_libasound_init(struct xfer_context *xfer,
 			       snd_pcm_stream_t direction,
 			       struct context_options *opts)
@@ -152,6 +163,17 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 		return 0;
 	}
 
+	if (opts->chmap_literal != NULL) {
+		state->chmap = snd_pcm_chmap_parse_string(opts->chmap_literal);
+		if (state->chmap == NULL)
+			return -ENOMEM;
+
+		if (xfer->verbose) {
+			logging(state, "Chmap argument:\n");
+			dump_chmap(state, state->chmap);
+		}
+	}
+
 	return set_access_hw_param(state->handle, state->hw_params, opts);
 }
 
@@ -238,6 +260,12 @@ static int configure_hw_params(struct libasound_state *state,
 			return err;
 		}
 	}
+	if (state->chmap && samples_per_frame != state->chmap->channels) {
+		logging(state,
+			_("Mismatch between channel number and given map: %u "
+			  "%u\n"),
+			samples_per_frame, state->chmap->channels);
+	}
 	err = snd_pcm_hw_params_set_channels(state->handle, state->hw_params,
 					     samples_per_frame);
 	if (err < 0) {
@@ -690,6 +718,10 @@ static void xfer_libasound_destroy(struct xfer_context *xfer)
 	if (state->log)
 		snd_output_close(state->log);
 	state->log = NULL;
+
+	if (state->chmap)
+		free(state->chmap);
+	state->chmap = NULL;
 }
 
 const struct xfer_data xfer_libasound = {
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 004613fa..11e610d8 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -34,6 +34,8 @@ struct libasound_state {
 
 	bool verbose;
 	bool finish_at_xrun;
+
+	snd_pcm_chmap_t *chmap;
 };
 
 struct xfer_libasound_ops {
-- 
2.11.0
