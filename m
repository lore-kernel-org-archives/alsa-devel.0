From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 21/23] aplay: add a parser for channel map
	API
Date: Thu, 17 Aug 2017 21:00:02 +0900
Message-ID: <20170817120004.15326-22-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 18E3C266F03
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

Current implementation of aplay uses channel map API, by an option
'--chmap' (-m). This API allows applications to get/set channel
position by getting position array; e.g. 'FR,FL'.

However, current implementation of ALSA PCM cure disallows applications
to set it as they prefer. This commit adds partly support for this API.
---
 aplay/options.c   | 28 +++++++++++++++++++++++---
 aplay/options.h   |  1 +
 aplay/xfer-alsa.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 aplay/xfer-alsa.h |  2 ++
 4 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/aplay/options.c b/aplay/options.c
index c16269d..7663703 100644
--- a/aplay/options.c
+++ b/aplay/options.c
@@ -199,7 +199,8 @@ static int apply_policies(struct context_options *opts,
 			  const char *cntr_format_literal,
 			  const char *node_literal,
 			  const char *sample_format_literal,
-			  const char *vu_mode_literal)
+			  const char *vu_mode_literal,
+			  const char *chmap_literal)
 {
 	int err;
 
@@ -232,6 +233,20 @@ static int apply_policies(struct context_options *opts,
 			return err;
 	}
 
+	if (chmap_literal) {
+		snd_pcm_chmap_t *chmap;
+		chmap = snd_pcm_chmap_parse_string(chmap_literal);
+		if (chmap == NULL) {
+			printf(_("Unable to parse channel map string: '%s'\n"),
+			       chmap_literal);
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
@@ -316,7 +331,7 @@ static int apply_policies(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hqid:vt:D:c:f:r:MNF:A:R:T:B:IV:";
+	static const char *s_opts = "hqid:vt:D:c:f:r:MNF:A:R:T:B:IV:m:";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -353,12 +368,14 @@ int context_options_init(struct context_options *opts, int argc,
 		{"dump-hw-params",	0, 0, OPT_DUMP_HWPARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 		{"vumeter",		1, 0, 'V'},
+		{"chmap",		1, 0, 'm'},
 		{NULL,			0, 0, 0},
 	};
 	const char *cntr_format_literal = NULL;
 	const char *node_literal = NULL;
 	const char *sample_format_literal = NULL;
 	const char *vu_mode_literal = NULL;
+	const char *chmap_literal = NULL;
 	int c;
 	int err = 0;
 
@@ -428,6 +445,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->dump_hw_params = true;
 		else if (c == OPT_FATAL_ERRORS)
 			opts->fatal_errors = true;
+		else if (c == 'm')
+			chmap_literal = optarg;
 		else
 			continue;
 
@@ -441,7 +460,7 @@ int context_options_init(struct context_options *opts, int argc,
 
 	return apply_policies(opts, direction, cntr_format_literal,
 			      node_literal, sample_format_literal,
-			      vu_mode_literal);
+			      vu_mode_literal, chmap_literal);
 }
 
 /*
@@ -614,6 +633,9 @@ void context_options_destroy(struct context_options *opts)
 	}
 	if (opts->node)
 		free(opts->node);
+	if (opts->chmap_literal)
+		free(opts->chmap_literal);
 	opts->paths = NULL;
 	opts->node = NULL;
+	opts->chmap_literal = NULL;
 }
diff --git a/aplay/options.h b/aplay/options.h
index 2536275..3bece52 100644
--- a/aplay/options.h
+++ b/aplay/options.h
@@ -53,6 +53,7 @@ struct context_options {
 	bool fatal_errors;
 
 	enum vumeter_mode vu_mode;
+	char *chmap_literal;
 
 	char **paths;
 	unsigned int path_count;
diff --git a/aplay/xfer-alsa.c b/aplay/xfer-alsa.c
index 2092f3e..e939005 100644
--- a/aplay/xfer-alsa.c
+++ b/aplay/xfer-alsa.c
@@ -53,7 +53,18 @@ static int set_access_hw_param(snd_pcm_t *handle,
 	return err;
 }
 
-static void dump_available_hw_params(snd_pcm_hw_params_t *hw_params,
+static void dump_chmap(const snd_pcm_chmap_t *chmap)
+{
+	int i;
+
+	printf("    channels: %u\n", chmap->channels);
+	for (i = 0; i < chmap->channels; ++i)
+		printf("      ch%u: %s\n",
+		       i, snd_pcm_chmap_name(chmap->pos[i]));
+}
+
+static void dump_available_hw_params(snd_pcm_t *handle,
+				     snd_pcm_hw_params_t *hw_params,
 				     const char *const node)
 {
 	unsigned int min_i, max_i;
@@ -61,6 +72,7 @@ static void dump_available_hw_params(snd_pcm_hw_params_t *hw_params,
 	snd_pcm_access_mask_t *access_mask;
 	snd_pcm_format_mask_t *format_mask;
 	snd_pcm_subformat_mask_t *subformat_mask;
+	snd_pcm_chmap_query_t **maps;
 	int i;
 	int err;
 
@@ -158,6 +170,19 @@ static void dump_available_hw_params(snd_pcm_hw_params_t *hw_params,
 			continue;
 		printf("    '%s'\n", snd_pcm_subformat_name(i));
 	}
+
+	maps = snd_pcm_query_chmaps(handle);
+	if (maps == NULL)
+		return;
+
+	printf("  available channel maps:\n");
+	for (i = 0; maps[i] != NULL; ++i) {
+		printf("    %u: %s\n", i,
+		       snd_pcm_chmap_type_name(maps[i]->type));
+		dump_chmap(&maps[i]->map);
+	}
+	snd_pcm_free_chmaps(maps);
+
 	printf("\n");
 }
 
@@ -204,8 +229,19 @@ static int xfer_alsa_init(struct xfer_context *xfer,
 	if (err < 0)
 		return err;
 
+	if (opts->chmap_literal != NULL) {
+		state->chmap = snd_pcm_chmap_parse_string(opts->chmap_literal);
+		if (state->chmap == NULL)
+			return -ENOMEM;
+
+		if (xfer->verbose) {
+			printf("Chmap argument:\n");
+			dump_chmap(state->chmap);
+		}
+	}
+
 	if (xfer->verbose)
-		dump_available_hw_params(state->hw_params, node);
+		dump_available_hw_params(state->handle, state->hw_params, node);
 
 	return set_access_hw_param(state->handle, state->hw_params, opts);
 }
@@ -262,6 +298,14 @@ static int configure_requested_params(struct alsa_state *state,
 	}
 
 	if (samples_per_frame > 0) {
+		if (state->chmap) {
+			if (samples_per_frame != state->chmap->channels) {
+				printf(_("Mismatch between channel number and "
+					 "given map: %u %u\n"),
+				samples_per_frame, state->chmap->channels);
+			}
+		}
+
 		err = snd_pcm_hw_params_set_channels(state->handle,
 						     state->hw_params,
 						     samples_per_frame);
@@ -319,6 +363,7 @@ static int retrieve_actual_params(snd_pcm_hw_params_t *hw_params,
 static void dump_sw_params(struct alsa_state *state)
 {
 	snd_pcm_uframes_t val_l;
+	snd_pcm_chmap_t *chmap;
 	int val_i;
 	int err;
 
@@ -354,6 +399,13 @@ static void dump_sw_params(struct alsa_state *state)
 		return;
 	printf("  silence-size: %lu\n", val_l);
 
+	chmap = snd_pcm_get_chmap(state->handle);
+	if (chmap != NULL) {
+		printf("  current-chmap:\n");
+		dump_chmap(chmap);
+		free(chmap);
+	}
+
 	printf("\n");
 }
 
@@ -539,6 +591,10 @@ static void xfer_alsa_destroy(struct xfer_context *xfer)
 		snd_pcm_sw_params_free(state->sw_params);
 	state->hw_params = NULL;
 	state->sw_params = NULL;
+
+	if (state->chmap)
+		free(state->chmap);
+	state->chmap = NULL;
 }
 
 const struct xfer_data xfer_alsa = {
diff --git a/aplay/xfer-alsa.h b/aplay/xfer-alsa.h
index 8702685..0257702 100644
--- a/aplay/xfer-alsa.h
+++ b/aplay/xfer-alsa.h
@@ -38,6 +38,8 @@ struct alsa_state {
 	void *private_data;
 
 	bool verbose;
+
+	snd_pcm_chmap_t *chmap;
 };
 
 struct xfer_alsa_io_ops {
-- 
2.11.0
