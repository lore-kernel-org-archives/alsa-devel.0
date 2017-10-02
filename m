From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 13/39] axfer: add a parser for
	command-line options
Date: Mon,  2 Oct 2017 09:19:14 +0900
Message-ID: <20171002001940.17218-14-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D2F80266FAD
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 02:19:51 +0200 (CEST)
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

In aplay, many command-line options are supported. Some of them have
dependency or conflicts.

This commit adds a structure and a parser for the options. In this patch,
minimal set of options is supported. Additional options will be supported
later.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am |   5 +-
 axfer/options.c   | 594 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 axfer/options.h   |  47 +++++
 3 files changed, 645 insertions(+), 1 deletion(-)
 create mode 100644 axfer/options.c
 create mode 100644 axfer/options.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index f17e59b0..3b1a87c8 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -19,6 +19,7 @@ noinst_HEADERS = \
 	subcmd.h \
 	container.h \
 	mapper.h
+	options.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -34,4 +35,6 @@ axfer_SOURCES = \
 	mapper.h \
 	mapper.c \
 	mapper-single.c \
-	mapper-multiple.c
+	mapper-multiple.c \
+	options.h \
+	options.c
diff --git a/axfer/options.c b/axfer/options.c
new file mode 100644
index 00000000..256f93a1
--- /dev/null
+++ b/axfer/options.c
@@ -0,0 +1,594 @@
+/*
+ * options.c - a parser of commandline options.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "options.h"
+#include "misc.h"
+
+#include <getopt.h>
+#include <math.h>
+
+static const char *const allowed_duplication[] = {
+	"/dev/null",
+	"/dev/zero",
+	"/dev/full",
+	"/dev/random",
+	"/dev/urandom",
+};
+
+static long parse_l(const char *str, int *err)
+{
+	long val;
+	char *endptr;
+
+	val = strtol(str, &endptr, 10);
+	if (errno)
+		return -errno;
+	if (*endptr != '\0')
+		return -EINVAL;
+
+	return val;
+}
+
+static int allocate_paths(struct context_options *opts, char *const *paths,
+			  unsigned int count)
+{
+	bool stdio = false;
+	char *path;
+	int i;
+
+	if (count == 0) {
+		stdio = true;
+		count = 1;
+	}
+
+	opts->paths = calloc(count, sizeof(opts->paths[0]));
+	if (opts->paths == NULL)
+		return -ENOMEM;
+	opts->path_count = count;
+
+	if (stdio) {
+		opts->paths[0] = malloc(2);
+		if (opts->paths[0] == NULL)
+			return -ENOMEM;
+		strcpy(opts->paths[0], "-");
+		return 0;
+	}
+
+	for (i = 0; i < count; ++i) {
+		path = malloc(strlen(paths[i]) + 1);
+		if (path == NULL)
+			return -ENOMEM;
+		strcpy(path, paths[i]);
+		opts->paths[i] = path;
+	}
+
+	return 0;
+}
+
+static int verify_cntr_format(struct context_options *opts, const char *literal)
+{
+	static const struct {
+		const char *const literal;
+		enum container_format cntr_format;
+	} *entry, entries[] = {
+		{"raw",		CONTAINER_FORMAT_RAW},
+		{"voc",		CONTAINER_FORMAT_VOC},
+		{"wav",		CONTAINER_FORMAT_RIFF_WAVE},
+		{"au",		CONTAINER_FORMAT_AU},
+		{"sparc",	CONTAINER_FORMAT_AU},
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		entry = &entries[i];
+		if (strcasecmp(literal, entry->literal))
+			continue;
+
+		opts->cntr_format = entry->cntr_format;
+		return 0;
+	}
+
+	fprintf(stderr, "unrecognized file format '%s'\n", literal);
+
+	return -EINVAL;
+}
+
+/* This should be called after 'verify_cntr_format()'. */
+static int verify_sample_format(struct context_options *opts,
+				const char *literal)
+{
+	static const struct {
+		const char *const literal;
+		unsigned int frames_per_second;
+		unsigned int samples_per_frame;
+		snd_pcm_format_t le_format;
+		snd_pcm_format_t be_format;
+	} *entry, entries[] = {
+		{"cd",	44100, 2, SND_PCM_FORMAT_S16_LE, SND_PCM_FORMAT_S16_BE},
+		{"cdr",	44100, 2, SND_PCM_FORMAT_S16_LE, SND_PCM_FORMAT_S16_BE},
+		{"dat",	48000, 2, SND_PCM_FORMAT_S16_LE, SND_PCM_FORMAT_S16_BE},
+	};
+	int i;
+
+	opts->sample_format = snd_pcm_format_value(literal);
+	if (opts->sample_format != SND_PCM_FORMAT_UNKNOWN)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		entry = &entries[i];
+		if (strcmp(entry->literal, literal))
+			continue;
+
+		if (opts->frames_per_second > 0 &&
+		    opts->frames_per_second != entry->frames_per_second) {
+			fprintf(stderr,
+				"'%s' format can't be used with rate except "
+				"for %u.\n",
+				entry->literal, entry->frames_per_second);
+			return -EINVAL;
+		}
+
+		if (opts->samples_per_frame > 0 &&
+		    opts->samples_per_frame != entry->samples_per_frame) {
+			fprintf(stderr,
+				"'%s' format can't be used with channel except "
+				"for %u.\n",
+				entry->literal, entry->samples_per_frame);
+			return -EINVAL;
+		}
+
+		opts->frames_per_second = entry->frames_per_second;
+		opts->samples_per_frame = entry->samples_per_frame;
+		if (opts->cntr_format == CONTAINER_FORMAT_AU)
+			opts->sample_format = entry->be_format;
+		else
+			opts->sample_format = entry->le_format;
+
+		return 0;
+	}
+
+	fprintf(stderr, "wrong extended format '%s'\n", literal);
+
+	return -EINVAL;
+}
+
+static int apply_policies(struct context_options *opts,
+			  snd_pcm_stream_t direction,
+			  const char *cntr_format_literal,
+			  const char *node_literal,
+			  const char *sample_format_literal)
+{
+	int err;
+
+	if (node_literal != NULL) {
+		opts->node = malloc(strlen(node_literal) + 1);
+		if (opts->node == NULL) {
+			fprintf(stderr, "Fail to allocate for node: %s\n",
+			       node_literal);
+			return -ENOMEM;
+		}
+		strcpy(opts->node, node_literal);
+	}
+
+	if (!cntr_format_literal) {
+		if (direction == SND_PCM_STREAM_CAPTURE) {
+			/* To stdout. */
+			if (opts->path_count == 1 &&
+			    !strcmp(opts->paths[0], "-")) {
+				opts->cntr_format = CONTAINER_FORMAT_RAW;
+			} else {
+				/* Use first path as a representative. */
+				opts->cntr_format = container_format_from_path(
+								opts->paths[0]);
+			}
+		}
+		/* For playback, perform auto-detection. */
+	} else {
+		err = verify_cntr_format(opts, cntr_format_literal);
+		if (err < 0)
+			return err;
+	}
+
+	if (opts->samples_per_frame > 0) {
+		if (opts->samples_per_frame < 1 ||
+		    opts->samples_per_frame > 256) {
+			fprintf(stderr, "invalid channels argument '%u'\n",
+				opts->samples_per_frame);
+			return -EINVAL;
+		}
+	}
+
+	if (opts->multiple_cntrs) {
+		if (!strcmp(opts->paths[0], "-")) {
+			fprintf(stderr,
+				"An option for separated channels is not "
+				"available with stdin/stdout.\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * For captured PCM frames, even if one path is given for
+		 * container files, it can be used to generate several paths.
+		 * For this purpose, please see
+		 * 'context_options_fixup_for_capture()'.
+		 */
+		if (direction == SND_PCM_STREAM_PLAYBACK) {
+			/* Require several paths for containers. */
+			if (opts->path_count == 1) {
+				fprintf(stderr,
+					"An option for separated channels "
+					"requires several files to playback "
+					"PCM frames.\n");
+				return -EINVAL;
+			}
+		}
+	} else {
+		/* A single path is available only. */
+		if (opts->path_count > 1) {
+			fprintf(stderr,
+				"When using several files, an option for "
+				"sepatated channels is used with.\n");
+			return -EINVAL;
+		}
+	}
+
+	if (opts->frames_per_second > 0) {
+		unsigned int orig = opts->frames_per_second;
+
+		/* For backward compatibility. */
+		if (opts->frames_per_second < 300)
+			opts->frames_per_second *= 300;
+		if (opts->frames_per_second < 2000 ||
+		    opts->frames_per_second > 192000) {
+			fprintf(stderr, "bad speed value '%i'\n", orig);
+			return -EINVAL;
+		}
+	}
+
+	opts->sample_format = SND_PCM_FORMAT_UNKNOWN;
+	if (sample_format_literal) {
+		err = verify_sample_format(opts, sample_format_literal);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+int context_options_init(struct context_options *opts, int argc,
+			 char *const *argv, snd_pcm_stream_t direction)
+{
+	static const char *s_opts = "hvt:ID:f:c:r:";
+	static const struct option l_opts[] = {
+		/* For generic purposes. */
+		{"help",		0, 0, 'h'},
+		{"verbose",		0, 0, 'v'},
+		/* For containers. */
+		{"file-type",		1, 0, 't'},
+		/* For mapper. */
+		{"separate-channels",	0, 0, 'I'},
+		/* For transfer backend. */
+		{"device",		1, 0, 'D'},
+		{"format",		1, 0, 'f'},
+		{"channels",		1, 0, 'c'},
+		{"rate",		1, 0, 'r'},
+		{NULL,			0, 0, 0},
+	};
+	const char *cntr_format_literal = NULL;
+	const char *node_literal = NULL;
+	const char *sample_format_literal = NULL;
+	int c;
+	int err = 0;
+
+	optind = 0;
+	opterr = 0;
+	while (1) {
+		c = getopt_long(argc, argv, s_opts, l_opts, NULL);
+		if (c < 0)
+			break;
+		else if (c == 'h')
+			opts->help = true;
+		else if (c == 'v')
+			++opts->verbose;
+		else if (c == 't')
+			cntr_format_literal = optarg;
+		else if (c == 'I')
+			opts->multiple_cntrs = true;
+		else if (c == 'D')
+			node_literal = optarg;
+		else if (c == 'f')
+			sample_format_literal = optarg;
+		else if (c == 'c')
+			opts->samples_per_frame = parse_l(optarg, &err);
+		else if (c == 'r')
+			opts->frames_per_second = parse_l(optarg, &err);
+		else
+			continue;
+
+		if (err < 0)
+			return err;
+	}
+
+	err = allocate_paths(opts, argv + optind, argc - optind);
+	if (err < 0)
+		return err;
+
+	return apply_policies(opts, direction, cntr_format_literal,
+			      node_literal, sample_format_literal);
+}
+
+static int generate_path_with_suffix(struct context_options *opts,
+				     const char *template, unsigned int index,
+				     const char *suffix)
+{
+	static const char *const single_format = "%s%s";
+	static const char *const multiple_format = "%s-%i%s";
+	unsigned int len;
+
+	len = strlen(template) + strlen(suffix) + 1;
+	if (opts->path_count > 1)
+		len += (unsigned int)log10(opts->path_count) + 2;
+
+	opts->paths[index] = malloc(len);
+	if (opts->paths[index] == NULL)
+		return -ENOMEM;
+
+	if (opts->path_count == 1) {
+		snprintf(opts->paths[index], len, single_format, template,
+			 suffix);
+	} else {
+		snprintf(opts->paths[index], len, multiple_format, template,
+			 index, suffix);
+	}
+
+	return 0;
+}
+
+static int generate_path_without_suffix(struct context_options *opts,
+				        const char *template,
+					unsigned int index, const char *suffix)
+{
+	static const char *const single_format = "%s";
+	static const char *const multiple_format = "%s-%i";
+	unsigned int len;
+
+	len = strlen(template) + 1;
+	if (opts->path_count > 1)
+		len += (unsigned int)log10(opts->path_count) + 2;
+
+	opts->paths[index] = malloc(len);
+	if (opts->paths[index] == NULL)
+		return -ENOMEM;
+
+	if (opts->path_count == 1) {
+		snprintf(opts->paths[index], len, single_format, template);
+	} else {
+		snprintf(opts->paths[index], len, multiple_format, template,
+			index);
+	}
+
+	return 0;
+}
+
+static int generate_path(struct context_options *opts, char *template,
+			 unsigned int index, const char *suffix)
+{
+	int (*generator)(struct context_options *opts, const char *template,
+			 unsigned int index, const char *suffix);
+	char *pos;
+
+	if (strlen(suffix) > 0) {
+		pos = template + strlen(template) - strlen(suffix);
+		/* Separate filename and suffix. */
+		if (!strcmp(pos, suffix))
+			*pos = '\0';
+	}
+
+	/* Select handlers. */
+	if (strlen(suffix) > 0)
+		generator = generate_path_with_suffix;
+	else
+		generator = generate_path_without_suffix;
+
+	return generator(opts, template, index, suffix);
+}
+
+static int create_paths(struct context_options *opts, unsigned int path_count)
+{
+	char *template;
+	const char *suffix;
+	int i, j;
+	int err = 0;
+
+	/* Can cause memory leak. */
+	assert(opts->path_count == 1);
+	assert(opts->paths);
+	assert(opts->paths[0]);
+	assert(opts->paths[0][0] != '\0');
+
+	/* Release at first. */
+	template = opts->paths[0];
+	free(opts->paths);
+	opts->paths = NULL;
+
+	/* Allocate again. */
+	opts->paths = calloc(path_count, sizeof(*opts->paths));
+	if (opts->paths == NULL) {
+		err = -ENOMEM;
+		goto end;
+	}
+	opts->path_count = path_count;
+
+	suffix = container_suffix_from_format(opts->cntr_format);
+
+	for (i = 0; i < opts->path_count; ++i) {
+		/* Some file names are allowed to be duplicated. */
+		for (j = 0; j < ARRAY_SIZE(allowed_duplication); ++j) {
+			if (!strcmp(opts->paths[i], allowed_duplication[j]))
+				break;
+		}
+		if (j < ARRAY_SIZE(allowed_duplication))
+			continue;
+
+		err = generate_path(opts, template, i, suffix);
+		if (err < 0)
+			break;
+	}
+end:
+	free(template);
+
+	return err;
+}
+
+static int fixup_paths(struct context_options *opts)
+{
+	const char *suffix;
+	char *template;
+	int i, j;
+	int err = 0;
+
+	suffix = container_suffix_from_format(opts->cntr_format);
+
+	for (i = 0; i < opts->path_count; ++i) {
+		/* Some file names are allowed to be duplicated. */
+		for (j = 0; j < ARRAY_SIZE(allowed_duplication); ++j) {
+			if (!strcmp(opts->paths[i], allowed_duplication[j]))
+				break;
+		}
+		if (j < ARRAY_SIZE(allowed_duplication))
+			continue;
+
+		template = opts->paths[i];
+		opts->paths[i] = NULL;
+		err = generate_path(opts, template, i, suffix);
+		free(template);
+		if (err < 0)
+			break;
+	}
+
+	return err;
+}
+
+int context_options_fixup_for_capture(struct context_options *opts,
+				      unsigned int samples_per_frame)
+{
+	int i, j;
+	int err;
+
+	if (!opts->multiple_cntrs) {
+		if (opts->path_count == 1)
+			err = fixup_paths(opts);
+		else
+			return -EINVAL;
+	} else {
+		if (opts->path_count == 1) {
+			err = create_paths(opts, samples_per_frame);
+		} else {
+			if (opts->path_count == samples_per_frame)
+				err = fixup_paths(opts);
+			else
+				return -EINVAL;
+		}
+	}
+	if (err < 0)
+		return err;
+
+	/* Check duplication of the paths. */
+	for (i = 0; i < opts->path_count - 1; ++i) {
+		/* Some file names are allowed to be duplicated. */
+		for (j = 0; j < ARRAY_SIZE(allowed_duplication); ++j) {
+			if (!strcmp(opts->paths[i], allowed_duplication[j]))
+				break;
+		}
+		if (j < ARRAY_SIZE(allowed_duplication))
+			continue;
+
+		for (j = i + 1; j < opts->path_count; ++j) {
+			if (!strcmp(opts->paths[i], opts->paths[j])) {
+				fprintf(stderr,
+					"Detect duplicated file names:\n");
+				err = -EINVAL;
+				break;
+			}
+		}
+		if (j < opts->path_count)
+			break;
+	}
+
+	if (opts->verbose > 1)
+		fprintf(stderr, "Handled file names:\n");
+	if (err < 0 || opts->verbose > 1) {
+		for (i = 0; i < opts->path_count; ++i)
+			fprintf(stderr, "    %d: %s\n", i, opts->paths[i]);
+	}
+
+	return err;
+}
+
+int context_options_fixup_for_playback(struct context_options *opts,
+				       snd_pcm_format_t sample_format,
+				       unsigned int samples_per_frame,
+				       unsigned int frames_per_second)
+{
+	if (opts->sample_format != SND_PCM_FORMAT_UNKNOWN) {
+		if (sample_format != opts->sample_format) {
+			fprintf(stderr,
+				"Sample format mismatch: %s is given but %s by "
+				"files\n",
+				snd_pcm_format_name(opts->sample_format),
+				snd_pcm_format_name(sample_format));
+			return -EINVAL;
+		}
+	}
+
+	if (opts->samples_per_frame > 0) {
+		if (samples_per_frame != opts->samples_per_frame) {
+			fprintf(stderr,
+				"The number of channels mismatch: %u is given "
+				"but %u by files\n",
+				opts->samples_per_frame, samples_per_frame);
+			return -EINVAL;
+		}
+	}
+
+	if (opts->frames_per_second > 0) {
+		if (frames_per_second != opts->frames_per_second) {
+			fprintf(stderr,
+				"Sampling rate mismatch: %u is given but %u by "
+				"files\n",
+				opts->frames_per_second, frames_per_second);
+			return -EINVAL;
+		}
+	}
+
+	if (opts->verbose > 1) {
+		int i;
+
+		fprintf(stderr, "Handled file names:\n");
+		for (i = 0; i < opts->path_count; ++i) {
+			fprintf(stderr, "    %d: %s\n", i, opts->paths[i]);
+		}
+	}
+
+	return 0;
+}
+
+void context_options_destroy(struct context_options *opts)
+{
+	int i;
+
+	if (opts->paths) {
+		for (i = 0; i < opts->path_count; ++i)
+			free(opts->paths[i]);
+		free(opts->paths);
+	}
+	if (opts->node)
+		free(opts->node);
+	opts->paths = NULL;
+	opts->node = NULL;
+}
diff --git a/axfer/options.h b/axfer/options.h
new file mode 100644
index 00000000..38bdbb74
--- /dev/null
+++ b/axfer/options.h
@@ -0,0 +1,47 @@
+/*
+ * options.h - a header for a parser of commandline options.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_AXFER_OPTIONS__H_
+#define __ALSA_UTILS_AXFER_OPTIONS__H_
+
+#include "container.h"
+
+struct context_options {
+	bool help;
+
+	/* For generic purposes. */
+	unsigned int verbose;
+
+	/* For containers. */
+	char **paths;
+	unsigned int path_count;
+	enum container_format cntr_format;
+
+	/* For mapper. */
+	bool multiple_cntrs;
+
+	/* For transfer backend. */
+	char *node;
+	snd_pcm_format_t sample_format;
+	unsigned int samples_per_frame;
+	unsigned int frames_per_second;
+};
+
+int context_options_init(struct context_options *opts, int argc,
+			 char *const *argv, snd_pcm_stream_t direction);
+int context_options_fixup_for_playback(struct context_options *opts,
+				       snd_pcm_format_t sample_format,
+				       unsigned int samples_per_frame,
+				       unsigned int frames_per_second);
+int context_options_fixup_for_capture(struct context_options *opts,
+				      unsigned int samples_per_frame);
+void context_options_calculate_duration(struct context_options *opts,
+		unsigned int frames_per_second, uint64_t *total_frame_count);
+void context_options_destroy(struct context_options *opts);
+
+#endif
-- 
2.11.0
