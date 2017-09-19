From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 34/38] axfer: add a parser for channel
	map API
Date: Tue, 19 Sep 2017 09:44:14 +0900
Message-ID: <20170919004418.24668-35-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 0CE7C266E29
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:33 +0200 (CEST)
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
index a0c2a794..335d8af3 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -202,7 +202,8 @@ static int apply_policies(struct context_options *opts,
 			  const char *cntr_format_literal,
 			  const char *node_literal,
 			  const char *sample_format_literal,
-			  const char *vu_mode_literal)
+			  const char *vu_mode_literal,
+			  const char *chmap_literal)
 {
 	int err;
 
@@ -235,6 +236,21 @@ static int apply_policies(struct context_options *opts,
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
@@ -373,7 +389,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:A:R:T:V:i";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NMF:B:A:R:T:V:im:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -412,6 +428,7 @@ int context_options_init(struct context_options *opts, int argc,
 		/* Misc features. */
 		{"vumeter",		1, 0, 'V'},
 		{"interactive",		0, 0, 'i'},
+		{"chmap",		1, 0, 'm'},
 		/* Obsoleted. */
 		{"max-file-time",       1, 0, OPT_MAX_FILE_TIME},
 		{NULL,			0, 0, 0},
@@ -420,6 +437,7 @@ int context_options_init(struct context_options *opts, int argc,
 	const char *node_literal = NULL;
 	const char *sample_format_literal = NULL;
 	const char *vu_mode_literal = NULL;
+	const char *chmap_literal = NULL;
 	int l_index = 0;
 	int c;
 	int err = 0;
@@ -490,6 +508,8 @@ int context_options_init(struct context_options *opts, int argc,
 			vu_mode_literal = optarg;
 		else if (c == 'i')
 			opts->interactive = true;
+		else if (c == 'm')
+			chmap_literal = optarg;
 		else if (c == OPT_MAX_FILE_TIME) {
 			fprintf(stderr,
 				"An option '--%s' is obsoleted and has no "
@@ -509,7 +529,7 @@ int context_options_init(struct context_options *opts, int argc,
 
 	return apply_policies(opts, direction, cntr_format_literal,
 			      node_literal, sample_format_literal,
-			      vu_mode_literal);
+			      vu_mode_literal, chmap_literal);
 }
 
 /*
@@ -863,6 +883,9 @@ void context_options_destroy(struct context_options *opts)
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
index 69a98df1..e90dc6b7 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -61,6 +61,7 @@ struct context_options {
 	/* Misc features. */
 	enum vumeter_mode vu_mode;
 	bool interactive;
+	char *chmap_literal;
 };
 
 int context_options_init(struct context_options *opts, int argc,
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 77131a7e..e00cfaa9 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -53,6 +53,17 @@ static int set_access_hw_param(snd_pcm_t *handle,
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
@@ -118,6 +129,17 @@ static int xfer_libasound_init(struct xfer_context *xfer,
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
 
@@ -204,6 +226,12 @@ static int configure_hw_params(struct libasound_state *state,
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
@@ -635,6 +663,10 @@ static void xfer_libasound_destroy(struct xfer_context *xfer)
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
index 7214ebbf..dac49774 100644
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
