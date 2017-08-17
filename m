From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 12/23] aplay: options: add a parser for
	command-line options
Date: Thu, 17 Aug 2017 20:59:53 +0900
Message-ID: <20170817120004.15326-13-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 18733266EE4
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:13 +0200 (CEST)
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

In current implementation, several types of command-line options are
supported. Some of them have dependency or conflicts.

This commit adds a structure and a parser for the options.
---
 aplay/Makefile.am |   7 +-
 aplay/options.c   | 585 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/options.h   |  65 ++++++
 3 files changed, 655 insertions(+), 2 deletions(-)
 create mode 100644 aplay/options.c
 create mode 100644 aplay/options.h

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 4042bbe..196e1ca 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -9,7 +9,8 @@ noinst_HEADERS = \
 	formats.h \
 	container.h \
 	aligner.h \
-	waiter.h
+	waiter.h \
+	options.h
 
 aplay_SOURCES = \
 	formats.h \
@@ -26,7 +27,9 @@ aplay_SOURCES = \
 	waiter.h \
 	waiter.c \
 	waiter-poll.c \
-	waiter-epoll.c
+	waiter-epoll.c \
+	options.h \
+	options.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/options.c b/aplay/options.c
new file mode 100644
index 0000000..efe0ce0
--- /dev/null
+++ b/aplay/options.c
@@ -0,0 +1,585 @@
+/*
+ * options.c - a parser of commandline options.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "options.h"
+
+#include <gettext.h>
+#include <getopt.h>
+#include <math.h>
+
+enum no_short_opts {
+	/* 128 belongs to non us-ascii character set. */
+	OPT_USE_STRFTIME = 128,
+	OPT_MAX_FILE_TIME,
+	OPT_PERIOD_SIZE,
+	OPT_BUFFER_SIZE,
+	OPT_DISABLE_RESAMPLE,
+	OPT_DISABLE_CHANNELS,
+	OPT_DISABLE_FORMAT,
+	OPT_DISABLE_SOFTVOL,
+	OPT_TEST_POSITION,
+	OPT_TEST_COEF,
+	OPT_TEST_NOWAIT,
+	OPT_DUMP_HWPARAMS,
+	OPT_FATAL_ERRORS,
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
+	int i, j;
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
+		for (j = 0; j < i; ++j) {
+			if (!strcmp(paths[i], opts->paths[j])) {
+				printf("The same file name appears several "
+				       "times.\n");
+				return -EINVAL;
+			}
+		}
+
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
+	printf(_("unrecognized file format '%s'\n"), literal);
+
+	return -EINVAL;
+}
+
+/* This should be called after 'verify_cntr_format()'. */
+static int verify_sample_format(struct context_options *opts,
+				const char *literal)
+{
+	struct {
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
+			printf("'%s' format can't be used with rate except for "
+			       "%u.\n",
+			       entry->literal, entry->frames_per_second);
+			return -EINVAL;
+		}
+
+		if (opts->samples_per_frame > 0 &&
+		    opts->samples_per_frame != entry->samples_per_frame) {
+			printf("'%s' format can't be used with channel except "
+			       "for %u.\n",
+			       entry->literal, entry->samples_per_frame);
+			return -EINVAL;
+		}
+
+		if (opts->cntr_format == CONTAINER_FORMAT_AU)
+			opts->sample_format = entry->be_format;
+		else
+			opts->sample_format = entry->le_format;
+
+		return 0;
+	}
+
+	printf(_("wrong extended format '%s'\n"), literal);
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
+			printf(_("Fail to allocate for node: %s\n"),
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
+			printf(_("invalid channels argument '%u'\n"),
+			       opts->samples_per_frame);
+			return -EINVAL;
+		}
+	}
+
+	if (opts->multiple_cntrs) {
+		if (!strcmp(opts->paths[0], "-")) {
+			printf(_("An option for separated channels is not "
+				 "available with stdin/stdout.\n"));
+			return -EINVAL;
+		}
+
+		if (direction == SND_PCM_STREAM_PLAYBACK) {
+			/* Require several paths for containers. */
+			if (opts->path_count == 1) {
+				printf(_("An option for separated channels "
+					 "requires several files to playback "
+					 "PCM frames.\n"));
+				return -EINVAL;
+			}
+		} else {
+			/* Require to indicate the number of channels. */
+			if (opts->samples_per_frame == 0) {
+				printf(_("An option for separated channels "
+					 "requires an option for the number of "
+					 "channels to capture PCM frames.\n"));
+				return -EINVAL;
+			}
+
+			/*
+			 * Even if one path is given for container files, it can
+			 * be used to generate several paths for captured PCM
+			 * frames. For this purpose, please see
+			 * 'context_options_normalize_paths()'.
+			 */
+		}
+	} else {
+		/* A single path is available only. */
+		if (opts->path_count > 1) {
+			printf(_("When using several files, an option for"
+			         "sepatated channels is used with.\n"));
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
+			printf(_("bad speed value '%i'\n"), orig);
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
+	/* TODO: frames_per_period v.s. msec_per_period. */
+	/* TODO: frames_per_buffer v.s. msec_per_buffer. */
+
+	return 0;
+}
+
+int context_options_init(struct context_options *opts, int argc,
+			 char *const *argv, snd_pcm_stream_t direction)
+{
+	static const char *s_opts = "hqd:vt:D:c:f:r:MNF:A:R:T:B:I";
+	static const struct option l_opts[] = {
+		/* For generic purposes. */
+		{"help",		0, 0, 'h'},
+		{"quiet",		0, 0, 'q'},
+		{"duration",		1, 0 ,'d'},
+		{"verbose",		0, 0, 'v'},
+		/* For containers. */
+		{"file-type",		1, 0, 't'},
+		{"use-strftime",	0, 0, OPT_USE_STRFTIME},
+		{"max-file-time",	1, 0, OPT_MAX_FILE_TIME},
+		/* For aligner. */
+		{"separate-channels",	0, 0, 'I'},
+		/* For ALSA backend. */
+		{"device",		1, 0, 'D'},
+		{"channels",		1, 0, 'c'},
+		{"format",		1, 0, 'f'},
+		{"rate",		1, 0, 'r'},
+		{"mmap",		0, 0, 'M'},
+		{"nonblock",		0, 0, 'N'},
+		{"period-time",		1, 0, 'F'},
+		{"avail-min",		1, 0, 'A'},
+		{"start-delay",		1, 0, 'R'},
+		{"stop-delay",		1, 0, 'T'},
+		{"buffer-time",		1, 0, 'B'},
+		{"period-size",		1, 0, OPT_PERIOD_SIZE},
+		{"buffer-size",		1, 0, OPT_BUFFER_SIZE},
+		{"disable-resample",	0, 0, OPT_DISABLE_RESAMPLE},
+		{"disable-channels",	0, 0, OPT_DISABLE_CHANNELS},
+		{"disable-format",	0, 0, OPT_DISABLE_FORMAT},
+		{"disable-softvol",	0, 0, OPT_DISABLE_SOFTVOL},
+		{"test-position",	0, 0, OPT_TEST_POSITION},
+		{"test-coef",		1, 0, OPT_TEST_COEF},
+		{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
+		{"dump-hw-params",	0, 0, OPT_DUMP_HWPARAMS},
+		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
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
+		else if (c == 'q')
+			opts->quiet = true;
+		else if (c == 'd')
+			opts->timelimit_seconds = parse_l(optarg, &err);
+		else if (c == 'v')
+			++opts->verbose;
+		else if (c == 't')
+			cntr_format_literal = optarg;
+		else if (c == OPT_USE_STRFTIME)
+			opts->use_strftime = true;
+		else if (c == OPT_MAX_FILE_TIME)
+			opts->max_file_seconds = true;
+		else if (c == 'I')
+			opts->multiple_cntrs = true;
+		else if (c == 'D')
+			node_literal = optarg;
+		else if (c == 'c')
+			opts->samples_per_frame = parse_l(optarg, &err);
+		else if (c == 'f')
+			sample_format_literal = optarg;
+		else if (c == 'r')
+			opts->frames_per_second = parse_l(optarg, &err);
+		else if (c == 'M')
+			opts->mmap = true;
+		else if (c == 'N')
+			opts->nonblock = true;
+		else if (c == 'F')
+			opts->msec_per_period = parse_l(optarg, &err);
+		else if (c == 'A')
+			opts->msec_for_avail_min = parse_l(optarg, &err);
+		else if (c == 'R')
+			opts->msec_for_start_delay = parse_l(optarg, &err);
+		else if (c == 'T')
+			opts->msec_for_stop_threshold = parse_l(optarg, &err);
+		else if (c == 'B')
+			opts->msec_per_buffer = parse_l(optarg, &err);
+		else if (c == OPT_PERIOD_SIZE)
+			opts->frames_per_period = parse_l(optarg, &err);
+		else if (c == OPT_BUFFER_SIZE)
+			opts->frames_per_buffer = parse_l(optarg, &err);
+		else if (c == OPT_DISABLE_RESAMPLE)
+			opts->no_auto_resample = true;
+		else if (c == OPT_DISABLE_CHANNELS)
+			opts->no_auto_channels = true;
+		else if (c == OPT_DISABLE_FORMAT)
+			opts->no_auto_format = true;
+		else if (c == OPT_DISABLE_SOFTVOL)
+			opts->no_softvol = true;
+		else if (c == OPT_TEST_POSITION)
+			opts->test_position = true;
+		else if (c == OPT_TEST_COEF)
+			opts->text_coef = parse_l(optarg, &err);
+		else if (c == OPT_TEST_NOWAIT)
+			opts->test_nowait = true;
+		else if (c == OPT_DUMP_HWPARAMS)
+			opts->dump_hw_params = true;
+		else if (c == OPT_FATAL_ERRORS)
+			opts->fatal_errors = true;
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
+/*
+ * A variant of strftime(3) that supports additional format specifiers in the
+ * format string:
+ *  '%v': file number.
+ *
+ * This function should be called after 'samples_per_frame' is decided.
+ */
+static size_t generate_paths_with_strftime(struct context_options *opts,
+					   char *template,
+					   unsigned int path_count)
+{
+	char *format;
+	time_t now_time;
+	struct tm now_tm;
+	unsigned int len;
+	char *pos;
+	unsigned int width;
+	int i;
+	int err;
+
+	/* This might be enough to process formatted strings. */
+	format = malloc(4096);
+	if (format == NULL)
+		return -ENOMEM;
+
+	now_time = time(NULL);
+	if ((int)now_time < 0)
+		return -errno;
+
+	if (localtime_r(&now_time, &now_tm) == NULL)
+		return -errno;
+
+	len = strftime(format, strlen(template) + 1, template, &now_tm);
+	if (len == 0) {
+		err = -EINVAL;
+		goto end;
+	}
+	format[len] = '\0';
+
+	width = (unsigned int)log10(path_count);
+
+	/* Estimate required length for formatted result. */
+	len = 0;
+	for (pos = format; *pos != '\0'; ++pos) {
+		++len;
+		/* '%v' is unique format for numbering. */
+		if (*pos == '%')
+			len += width;
+	}
+
+	for (i = 0; i < opts->path_count; ++i) {
+		opts->paths[i] = malloc(len + 1);
+		if (opts->paths[i] == NULL) {
+			err = -ENOMEM;
+			goto end;
+		}
+		snprintf(opts->paths[i], len + 1, format, i);
+	}
+end:
+	free(format);
+	return err;
+}
+
+static size_t generate_paths_with_suffix(struct context_options *opts,
+					 const char *name,
+					 const char *suffix,
+					 unsigned int path_count)
+{
+	static const char *const format = "%s-%i.%s";
+	unsigned int width;
+	unsigned int len;
+	int i;
+
+	width = (unsigned int)log10(path_count) + 1;
+	len = strlen(name) + 3 + width + strlen(suffix);
+
+	for (i = 0; i < path_count; ++i) {
+		opts->paths[i] = malloc(len);
+		if (opts->paths[i] == NULL)
+			return -ENOMEM;
+		snprintf(opts->paths[i], len, format, name, i, suffix);
+	}
+
+	return 0;
+}
+
+static size_t generate_paths_without_suffix(struct context_options *opts,
+					    const char *name,
+					    unsigned int path_count)
+{
+	static const char *const format = "%s-%i";
+	unsigned int width;
+	unsigned int len;
+	int i;
+
+	width = (unsigned int)log10(path_count) + 1;
+	len = strlen(name) + 2 + width;
+
+	for (i = 0; i < path_count; ++i) {
+		opts->paths[i] = malloc(len);
+		if (opts->paths[i] == NULL)
+			return -ENOMEM;
+		snprintf(opts->paths[i], len, format, name, i);
+	}
+
+	return 0;
+}
+
+int context_options_normalize_paths(struct context_options *opts,
+				    enum container_format format,
+				    unsigned int path_count)
+{
+	const char *suffix;
+	char *template;
+	char *pos;
+	int err = 0;
+
+	/* This option should be used for one given path. */
+	if (opts->path_count > 1 ||
+	    opts->paths == NULL || opts->paths[0] == NULL)
+		return -EINVAL;
+
+	suffix = container_suffix_from_format(format);
+
+	/* Release at first. */
+	template = opts->paths[0];
+	free(opts->paths);
+	opts->paths = NULL;
+
+	/* Allocate again. */
+	opts->paths = calloc(path_count, sizeof(char *));
+	if (opts->paths == NULL) {
+		err = -ENOMEM;
+		goto end;
+	}
+
+	if (opts->use_strftime) {
+		err = generate_paths_with_strftime(opts, template, path_count);
+	} else {
+		pos = template + strlen(template) - strlen(suffix);
+		if (strcmp(pos, suffix) != 0) {
+			err = generate_paths_without_suffix(opts, template,
+							    path_count);
+		} else {
+			/* Separate extension from filename. */
+			template[pos - template] = '\0';
+			if (*suffix == '.')
+				++suffix;
+			err = generate_paths_with_suffix(opts, template, suffix,
+							 path_count);
+		}
+	}
+
+	/* TODO: check the paths. */
+end:
+	free(template);
+	return err;
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
diff --git a/aplay/options.h b/aplay/options.h
new file mode 100644
index 0000000..dc474d5
--- /dev/null
+++ b/aplay/options.h
@@ -0,0 +1,65 @@
+/*
+ * options.h - a header for a parser of commandline options.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_APLAY_OPTIONS__H_
+#define __ALSA_UTILS_APLAY_OPTIONS__H_
+
+#include "container.h"
+
+struct context_options {
+	bool help;
+
+	/* For generic purposes. */
+	bool quiet;
+	unsigned int timelimit_seconds;
+	unsigned int verbose;
+
+	/* For containers. */
+	enum container_format cntr_format;
+	bool use_strftime;
+	bool max_file_seconds;
+
+	/* For aligner. */
+	bool multiple_cntrs;
+
+	/* For ALSA backend. */
+	char *node;
+	unsigned int samples_per_frame;
+	snd_pcm_format_t sample_format;
+	unsigned int frames_per_second;
+	bool mmap;
+	bool nonblock;
+	unsigned int msec_per_period;
+	unsigned int msec_for_avail_min;
+	unsigned int msec_for_start_delay;
+	unsigned int msec_for_stop_threshold;
+	unsigned int msec_per_buffer;
+	unsigned int frames_per_period;
+	unsigned int frames_per_buffer;
+	bool no_auto_resample;
+	bool no_auto_channels;
+	bool no_auto_format;
+	bool no_softvol;
+	bool test_position;
+	int text_coef;
+	bool test_nowait;
+	bool dump_hw_params;
+	bool fatal_errors;
+
+	char **paths;
+	unsigned int path_count;
+};
+
+int context_options_init(struct context_options *opts, int argc,
+			 char *const *argv, snd_pcm_stream_t direction);
+int context_options_normalize_paths(struct context_options *opts,
+				    enum container_format format,
+				    unsigned int path_count);
+void context_options_destroy(struct context_options *opts);
+
+#endif
-- 
2.11.0
