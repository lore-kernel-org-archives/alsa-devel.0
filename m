From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/35] axfer: add a parser for command-line
	options
Date: Tue, 13 Nov 2018 15:41:26 +0900
Message-ID: <20181113064147.13577-14-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 77CE9267AE0
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:21 +0100 (CET)
Received: by mail-pg1-f196.google.com with SMTP id y4so5212925pgc.12
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:21 -0800 (PST)
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

In aplay, many command-line options are supported. Some of them have
dependency or conflicts. Furthemore, some of them are just for
runtime configuration of alsa-lib(libasound), and some options can
be used by several xfer backends commonly; e.g. options for file name,
sample format and sampling rate.

This commit adds a parser for the common options below.
 * --help (-h)
  * Just output 'help' string (not written yet).
 * --verbose (-v)
  * For verbose output, including information about xfer, mapper and
    container.
 * --format (-f): string. format literals or one of ['cd'|'cdr'|'dat']
  * For sample format supported by ALSA PCM interface. Special format
    can be used. For playback, this is auto-detected according to actual
    file format.
 * --channels (-c)
  * For the number of samples included in one data frame. For playback,
    this is auto-detected according to actual file format, except for
    'raw' format. This option can conflict to above format option.
 * --rate (-r)
  * For the number of data frames transferred in one second. For playback,
    this is auto-detected according to actual file format, except for
    'raw' format. This option can conflict to format option above.
 * --file-type (-f): string. one of ['wav'|'au'|'voc'|'raw']
  * For format of files of given paths. For playback, this is optional
    because the format is auto-detected. For capture, this is optional too
    because the format is decided according to suffix of given path.
    Anyway, this option is used for cases to fail to detect or decide.
 * --separate-channels (-I)
  * When using several files as source or destination for transmission
    of data frame, this option can be used with several file paths.

When '--separate-channels' option is used, users can give several file
paths to source/destination of data transmission, else they can give single
file path for the purpose. When multiple files are handled by this option,
for playback, data frames in first channel is used to construct buffer for
data transmission with multi channel. For capture, data frames in each
channel of buffer are written to each of given path. Furthermore, when a
single path is given for capture, file paths are auto-generated according
to available number of channels. For example, 'name.wav' is given for
2 channels capture, 'name-0.wav' and 'name-1.wav' are generated. In a
case of no suffix, 'name-0' and 'name-1' are generated.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am    |   3 +-
 axfer/main.c         |  36 +++
 axfer/misc.h         |   3 +
 axfer/xfer-options.c | 535 +++++++++++++++++++++++++++++++++++++++++++
 axfer/xfer.c         |  78 +++++++
 axfer/xfer.h         |  19 ++
 6 files changed, 673 insertions(+), 1 deletion(-)
 create mode 100644 axfer/xfer-options.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 9371365..5f0a6cf 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -37,4 +37,5 @@ axfer_SOURCES = \
 	mapper-single.c \
 	mapper-multiple.c \
 	xfer.h \
-	xfer.c
+	xfer.c \
+	xfer-options.c
diff --git a/axfer/main.c b/axfer/main.c
index c9cf104..f141439 100644
--- a/axfer/main.c
+++ b/axfer/main.c
@@ -24,6 +24,42 @@ enum subcmds {
 	SUBCMD_VERSION,
 };
 
+char *arg_duplicate_string(const char *str, int *err)
+{
+	char *ptr;
+
+	// For safe.
+	if (strlen(str) > 1024) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	ptr = strdup(str);
+	if (ptr == NULL)
+		*err = -ENOMEM;
+
+	return ptr;
+}
+
+long arg_parse_decimal_num(const char *str, int *err)
+{
+	long val;
+	char *endptr;
+
+	errno = 0;
+	val = strtol(str, &endptr, 0);
+	if (errno > 0) {
+		*err = -errno;
+		return 0;
+	}
+	if (*endptr != '\0') {
+		*err = -EINVAL;
+		return 0;
+	}
+
+	return val;
+}
+
 static void print_version(const char *const cmdname)
 {
 	printf("%s: version %s\n", cmdname, SND_UTIL_VERSION_STR);
diff --git a/axfer/misc.h b/axfer/misc.h
index 7c8bfb3..5f27d28 100644
--- a/axfer/misc.h
+++ b/axfer/misc.h
@@ -13,4 +13,7 @@
 
 #define ARRAY_SIZE(array)	(sizeof(array)/sizeof(array[0]))
 
+char *arg_duplicate_string(const char *str, int *err);
+long arg_parse_decimal_num(const char *str, int *err);
+
 #endif
diff --git a/axfer/xfer-options.c b/axfer/xfer-options.c
new file mode 100644
index 00000000..fb71244
--- /dev/null
+++ b/axfer/xfer-options.c
@@ -0,0 +1,535 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// xfer-options.c - a parser of commandline options for xfer.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "xfer.h"
+#include "misc.h"
+
+#include <getopt.h>
+#include <math.h>
+#include <limits.h>
+
+enum no_short_opts {
+	// 128 or later belong to non us-ascii character set.
+	OPT_XFER_TYPE = 128,
+};
+
+static int allocate_paths(struct xfer_context *xfer, char *const *paths,
+			   unsigned int count)
+{
+	bool stdio = false;
+	int i;
+
+	if (count == 0) {
+		stdio = true;
+		count = 1;
+	}
+
+	xfer->paths = calloc(count, sizeof(xfer->paths[0]));
+	if (xfer->paths == NULL)
+		return -ENOMEM;
+	xfer->path_count = count;
+
+	if (stdio) {
+		xfer->paths[0] = strndup("-", PATH_MAX);
+		if (xfer->paths[0] == NULL)
+			return -ENOMEM;
+	} else {
+		for (i = 0; i < count; ++i) {
+			xfer->paths[i] = strndup(paths[i], PATH_MAX);
+			if (xfer->paths[i] == NULL)
+				return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static int verify_cntr_format(struct xfer_context *xfer)
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
+		if (strcasecmp(xfer->cntr_format_literal, entry->literal))
+			continue;
+
+		xfer->cntr_format = entry->cntr_format;
+		return 0;
+	}
+
+	fprintf(stderr, "unrecognized file format '%s'\n",
+		xfer->cntr_format_literal);
+
+	return -EINVAL;
+}
+
+// This should be called after 'verify_cntr_format()'.
+static int verify_sample_format(struct xfer_context *xfer)
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
+	xfer->sample_format = snd_pcm_format_value(xfer->sample_format_literal);
+	if (xfer->sample_format != SND_PCM_FORMAT_UNKNOWN)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		entry = &entries[i];
+		if (strcmp(entry->literal, xfer->sample_format_literal))
+			continue;
+
+		if (xfer->frames_per_second > 0 &&
+		    xfer->frames_per_second != entry->frames_per_second) {
+			fprintf(stderr,
+				"'%s' format can't be used with rate except "
+				"for %u.\n",
+				entry->literal, entry->frames_per_second);
+			return -EINVAL;
+		}
+
+		if (xfer->samples_per_frame > 0 &&
+		    xfer->samples_per_frame != entry->samples_per_frame) {
+			fprintf(stderr,
+				"'%s' format can't be used with channel except "
+				"for %u.\n",
+				entry->literal, entry->samples_per_frame);
+			return -EINVAL;
+		}
+
+		xfer->frames_per_second = entry->frames_per_second;
+		xfer->samples_per_frame = entry->samples_per_frame;
+		if (xfer->cntr_format == CONTAINER_FORMAT_AU)
+			xfer->sample_format = entry->be_format;
+		else
+			xfer->sample_format = entry->le_format;
+
+		return 0;
+	}
+
+	fprintf(stderr, "wrong extended format '%s'\n",
+		xfer->sample_format_literal);
+
+	return -EINVAL;
+}
+
+static int validate_options(struct xfer_context *xfer)
+{
+	unsigned int val;
+	int err = 0;
+
+	if (xfer->cntr_format_literal == NULL) {
+		if (xfer->direction == SND_PCM_STREAM_CAPTURE) {
+			// To stdout.
+			if (xfer->path_count == 1 &&
+			    !strcmp(xfer->paths[0], "-")) {
+				xfer->cntr_format = CONTAINER_FORMAT_RAW;
+			} else {
+				// Use first path as a representative.
+				xfer->cntr_format = container_format_from_path(
+								xfer->paths[0]);
+			}
+		}
+		// For playback, perform auto-detection.
+	} else {
+		err = verify_cntr_format(xfer);
+	}
+	if (err < 0)
+		return err;
+
+	if (xfer->multiple_cntrs) {
+		if (!strcmp(xfer->paths[0], "-")) {
+			fprintf(stderr,
+				"An option for separated channels is not "
+				"available with stdin/stdout.\n");
+			return -EINVAL;
+		}
+
+		// For captured PCM frames, even if one path is given for
+		// container files, it can be used to generate several paths.
+		// For this purpose, please see
+		// 'xfer_options_fixup_paths()'.
+		if (xfer->direction == SND_PCM_STREAM_PLAYBACK) {
+			// Require several paths for containers.
+			if (xfer->path_count == 1) {
+				fprintf(stderr,
+					"An option for separated channels "
+					"requires several files to playback "
+					"PCM frames.\n");
+				return -EINVAL;
+			}
+		}
+	} else {
+		// A single path is available only.
+		if (xfer->path_count > 1) {
+			fprintf(stderr,
+				"When using several files, an option for "
+				"sepatated channels is used with.\n");
+			return -EINVAL;
+		}
+	}
+
+	xfer->sample_format = SND_PCM_FORMAT_UNKNOWN;
+	if (xfer->sample_format_literal) {
+		err = verify_sample_format(xfer);
+		if (err < 0)
+			return err;
+	}
+
+	val = xfer->frames_per_second;
+	if (xfer->frames_per_second == 0)
+		xfer->frames_per_second = 8000;
+	if (xfer->frames_per_second < 1000)
+		xfer->frames_per_second *= 1000;
+	if (xfer->frames_per_second < 2000 ||
+	    xfer->frames_per_second > 192000) {
+		fprintf(stderr, "bad speed value '%i'\n", val);
+		return -EINVAL;
+	}
+
+	if (xfer->samples_per_frame > 0) {
+		if (xfer->samples_per_frame < 1 ||
+		    xfer->samples_per_frame > 256) {
+			fprintf(stderr, "invalid channels argument '%u'\n",
+				xfer->samples_per_frame);
+			return -EINVAL;
+		}
+	}
+
+	return err;
+}
+
+int xfer_options_parse_args(struct xfer_context *xfer,
+			    const struct xfer_data *data, int argc,
+			    char *const *argv)
+{
+	static const char *short_opts = "CPhvf:c:r:t:I";
+	static const struct option long_opts[] = {
+		// For generic purposes.
+		{"capture",		0, 0, 'C'},
+		{"playback",		0, 0, 'P'},
+		{"xfer-type",		1, 0, OPT_XFER_TYPE},
+		{"help",		0, 0, 'h'},
+		{"verbose",		0, 0, 'v'},
+		// For transfer backend.
+		{"format",		1, 0, 'f'},
+		{"channels",		1, 0, 'c'},
+		{"rate",		1, 0, 'r'},
+		// For containers.
+		{"file-type",		1, 0, 't'},
+		// For mapper.
+		{"separate-channels",	0, 0, 'I'},
+	};
+	char *s_opts;
+	struct option *l_opts;
+	int l_index;
+	int key;
+	int err = 0;
+
+	// Concatenate short options.
+	s_opts = malloc(strlen(data->s_opts) + strlen(short_opts) + 1);
+	if (s_opts == NULL)
+		return -ENOMEM;
+	strcpy(s_opts, data->s_opts);
+	strcpy(s_opts + strlen(s_opts), short_opts);
+	s_opts[strlen(data->s_opts) + strlen(short_opts)] = '\0';
+
+	// Concatenate long options, including a sentinel.
+	l_opts = calloc(ARRAY_SIZE(long_opts) * data->l_opts_count + 1,
+			sizeof(*l_opts));
+	if (l_opts == NULL) {
+		free(s_opts);
+		return -ENOMEM;
+	}
+	memcpy(l_opts, long_opts, ARRAY_SIZE(long_opts) * sizeof(*l_opts));
+	memcpy(&l_opts[ARRAY_SIZE(long_opts)], data->l_opts,
+	       data->l_opts_count * sizeof(*l_opts));
+
+	// Parse options.
+	l_index = 0;
+	optarg = NULL;
+	optind = 1;
+	opterr = 1;	// use error output.
+	optopt = 0;
+	while (1) {
+		key = getopt_long(argc, argv, s_opts, l_opts, &l_index);
+		if (key < 0)
+			break;
+		else if (key == 'C')
+			;	// already parsed.
+		else if (key == 'P')
+			;	// already parsed.
+		else if (key == OPT_XFER_TYPE)
+			;	// already parsed.
+		else if (key == 'h')
+			xfer->help = true;
+		else if (key == 'v')
+			++xfer->verbose;
+		else if (key == 'f')
+			xfer->sample_format_literal = arg_duplicate_string(optarg, &err);
+		else if (key == 'c')
+			xfer->samples_per_frame = arg_parse_decimal_num(optarg, &err);
+		else if (key == 'r')
+			xfer->frames_per_second = arg_parse_decimal_num(optarg, &err);
+		else if (key == 't')
+			xfer->cntr_format_literal = arg_duplicate_string(optarg, &err);
+		else if (key == 'I')
+			xfer->multiple_cntrs = true;
+		else if (key == '?')
+			return -EINVAL;
+		else {
+			err = xfer->ops->parse_opt(xfer, key, optarg);
+			if (err < 0 && err != -ENXIO)
+				break;
+		}
+	}
+
+	free(l_opts);
+	free(s_opts);
+
+	err = allocate_paths(xfer, argv + optind, argc - optind);
+	if (err < 0)
+		return err;
+
+	return validate_options(xfer);
+}
+
+static const char *const allowed_duplication[] = {
+	"/dev/null",
+	"/dev/zero",
+	"/dev/full",
+	"/dev/random",
+	"/dev/urandom",
+};
+
+static int generate_path_with_suffix(struct xfer_context *xfer,
+				     const char *template, unsigned int index,
+				     const char *suffix)
+{
+	static const char *const single_format = "%s%s";
+	static const char *const multiple_format = "%s-%i%s";
+	unsigned int len;
+
+	len = strlen(template) + strlen(suffix) + 1;
+	if (xfer->path_count > 1)
+		len += (unsigned int)log10(xfer->path_count) + 2;
+
+	xfer->paths[index] = malloc(len);
+	if (xfer->paths[index] == NULL)
+		return -ENOMEM;
+
+	if (xfer->path_count == 1) {
+		snprintf(xfer->paths[index], len, single_format, template,
+			 suffix);
+	} else {
+		snprintf(xfer->paths[index], len, multiple_format, template,
+			 index, suffix);
+	}
+
+	return 0;
+}
+
+static int generate_path_without_suffix(struct xfer_context *xfer,
+				        const char *template,
+					unsigned int index, const char *suffix)
+{
+	static const char *const single_format = "%s";
+	static const char *const multiple_format = "%s-%i";
+	unsigned int len;
+
+	len = strlen(template) + 1;
+	if (xfer->path_count > 1)
+		len += (unsigned int)log10(xfer->path_count) + 2;
+
+	xfer->paths[index] = malloc(len);
+	if (xfer->paths[index] == NULL)
+		return -ENOMEM;
+
+	if (xfer->path_count == 1) {
+		snprintf(xfer->paths[index], len, single_format, template);
+	} else {
+		snprintf(xfer->paths[index], len, multiple_format, template,
+			index);
+	}
+
+	return 0;
+}
+
+static int generate_path(struct xfer_context *xfer, char *template,
+			 unsigned int index, const char *suffix)
+{
+	int (*generator)(struct xfer_context *xfer, const char *template,
+			 unsigned int index, const char *suffix);
+	char *pos;
+
+	if (strlen(suffix) > 0) {
+		pos = template + strlen(template) - strlen(suffix);
+		// Separate filename and suffix.
+		if (!strcmp(pos, suffix))
+			*pos = '\0';
+	}
+
+	// Select handlers.
+	if (strlen(suffix) > 0)
+		generator = generate_path_with_suffix;
+	else
+		generator = generate_path_without_suffix;
+
+	return generator(xfer, template, index, suffix);
+}
+
+static int create_paths(struct xfer_context *xfer, unsigned int path_count)
+{
+	char *template;
+	const char *suffix;
+	int i, j;
+	int err = 0;
+
+	// Can cause memory leak.
+	assert(xfer->path_count == 1);
+	assert(xfer->paths);
+	assert(xfer->paths[0]);
+	assert(xfer->paths[0][0] != '\0');
+
+	// Release at first.
+	template = xfer->paths[0];
+	free(xfer->paths);
+	xfer->paths = NULL;
+
+	// Allocate again.
+	xfer->paths = calloc(path_count, sizeof(*xfer->paths));
+	if (xfer->paths == NULL) {
+		err = -ENOMEM;
+		goto end;
+	}
+	xfer->path_count = path_count;
+
+	suffix = container_suffix_from_format(xfer->cntr_format);
+
+	for (i = 0; i < xfer->path_count; ++i) {
+		// Some file names are allowed to be duplicated.
+		for (j = 0; j < ARRAY_SIZE(allowed_duplication); ++j) {
+			if (!strcmp(template, allowed_duplication[j]))
+				break;
+		}
+		if (j < ARRAY_SIZE(allowed_duplication))
+			continue;
+
+		err = generate_path(xfer, template, i, suffix);
+		if (err < 0)
+			break;
+	}
+end:
+	free(template);
+
+	return err;
+}
+
+static int fixup_paths(struct xfer_context *xfer)
+{
+	const char *suffix;
+	char *template;
+	int i, j;
+	int err = 0;
+
+	suffix = container_suffix_from_format(xfer->cntr_format);
+
+	for (i = 0; i < xfer->path_count; ++i) {
+		// Some file names are allowed to be duplicated.
+		for (j = 0; j < ARRAY_SIZE(allowed_duplication); ++j) {
+			if (!strcmp(xfer->paths[i], allowed_duplication[j]))
+				break;
+		}
+		if (j < ARRAY_SIZE(allowed_duplication))
+			continue;
+
+		template = xfer->paths[i];
+		xfer->paths[i] = NULL;
+		err = generate_path(xfer, template, i, suffix);
+		free(template);
+		if (err < 0)
+			break;
+	}
+
+	return err;
+}
+
+int xfer_options_fixup_paths(struct xfer_context *xfer)
+{
+	int i, j;
+	int err;
+
+	if (xfer->path_count == 1) {
+		// Nothing to do for sign of stdin/stdout.
+		if (!strcmp(xfer->paths[0], "-"))
+			return 0;
+		if (!xfer->multiple_cntrs)
+			err = fixup_paths(xfer);
+		else
+			err = create_paths(xfer, xfer->samples_per_frame);
+	} else {
+		if (!xfer->multiple_cntrs)
+			return -EINVAL;
+		if (xfer->path_count != xfer->samples_per_frame)
+			return -EINVAL;
+		else
+			err = fixup_paths(xfer);
+	}
+	if (err < 0)
+		return err;
+
+	// Check duplication of the paths.
+	for (i = 0; i < xfer->path_count - 1; ++i) {
+		// Some file names are allowed to be duplicated.
+		for (j = 0; j < ARRAY_SIZE(allowed_duplication); ++j) {
+			if (!strcmp(xfer->paths[i], allowed_duplication[j]))
+				break;
+		}
+		if (j < ARRAY_SIZE(allowed_duplication))
+			continue;
+
+		for (j = i + 1; j < xfer->path_count; ++j) {
+			if (!strcmp(xfer->paths[i], xfer->paths[j])) {
+				fprintf(stderr,
+					"Detect duplicated file names:\n");
+				err = -EINVAL;
+				break;
+			}
+		}
+		if (j < xfer->path_count)
+			break;
+	}
+
+	if (xfer->verbose > 1)
+		fprintf(stderr, "Handled file names:\n");
+	if (err < 0 || xfer->verbose > 1) {
+		for (i = 0; i < xfer->path_count; ++i)
+			fprintf(stderr, "    %d: %s\n", i, xfer->paths[i]);
+	}
+
+	return err;
+}
diff --git a/axfer/xfer.c b/axfer/xfer.c
index 7c41a65..594abca 100644
--- a/axfer/xfer.c
+++ b/axfer/xfer.c
@@ -64,11 +64,17 @@ int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
 	if (err < 0)
 		return err;
 
+	err = xfer_options_parse_args(xfer, entry->data, argc, argv);
+	if (err < 0)
+		return err;
+
 	return xfer->ops->validate_opts(xfer);
 }
 
 void xfer_context_destroy(struct xfer_context *xfer)
 {
+	int i;
+
 	assert(xfer);
 
 	if (!xfer->ops)
@@ -78,6 +84,20 @@ void xfer_context_destroy(struct xfer_context *xfer)
 		xfer->ops->destroy(xfer);
 	if (xfer->private_data)
 		free(xfer->private_data);
+
+	if (xfer->paths) {
+		for (i = 0; i < xfer->path_count; ++i)
+			free(xfer->paths[i]);
+		free(xfer->paths);
+	}
+
+	xfer->paths = NULL;
+
+	free(xfer->sample_format_literal);
+	xfer->sample_format_literal = NULL;
+
+	free(xfer->cntr_format_literal);
+	xfer->cntr_format_literal = NULL;
 }
 
 int xfer_context_pre_process(struct xfer_context *xfer,
@@ -99,6 +119,54 @@ int xfer_context_pre_process(struct xfer_context *xfer,
 	if (!xfer->ops)
 		return -ENXIO;
 
+	if (xfer->direction == SND_PCM_STREAM_CAPTURE) {
+		// For capture direction, use values in options if given.
+		if (xfer->sample_format != SND_PCM_FORMAT_UNKNOWN)
+			*format = xfer->sample_format;
+		if (xfer->samples_per_frame > 0)
+			*samples_per_frame = xfer->samples_per_frame;
+		if (xfer->frames_per_second > 0)
+			*frames_per_second = xfer->frames_per_second;
+	} else if (xfer->direction == SND_PCM_STREAM_PLAYBACK) {
+		// For playback direction, check values in given options so that
+		// they don't mismatch to parameters from media container.
+		if (*format != xfer->sample_format) {
+			// Not initial value.
+			if (xfer->sample_format != SND_PCM_FORMAT_UNKNOWN) {
+				fprintf(stderr,
+					"Sample format mismatch: %s is given "
+					"but %s by files\n",
+					snd_pcm_format_name(xfer->sample_format),
+					snd_pcm_format_name(*format));
+				return -EINVAL;
+			}
+		}
+
+		if (*samples_per_frame != xfer->samples_per_frame) {
+			// Not initial value.
+			if (xfer->samples_per_frame > 0) {
+				fprintf(stderr,
+					"The number of channels mismatch: %u "
+					"is given but %u by files\n",
+					xfer->samples_per_frame,
+					*samples_per_frame);
+				return -EINVAL;
+			}
+		}
+
+		if (*frames_per_second != xfer->frames_per_second) {
+			// Not initial value.
+			if (xfer->frames_per_second != 8000) {
+				fprintf(stderr,
+					"Sampling rate mismatch: %u is given "
+					"but %u by files\n",
+					xfer->frames_per_second,
+					*frames_per_second);
+				return -EINVAL;
+			}
+		}
+	}
+
 	err = xfer->ops->pre_process(xfer, format, samples_per_frame,
 				     frames_per_second, access,
 				     frames_per_buffer);
@@ -113,6 +181,16 @@ int xfer_context_pre_process(struct xfer_context *xfer,
 	assert(*access <= SND_PCM_ACCESS_LAST);
 	assert(*frames_per_buffer > 0);
 
+	xfer->sample_format = *format;
+	xfer->samples_per_frame = *samples_per_frame;
+	xfer->frames_per_second = *frames_per_second;
+
+	if (xfer->direction == SND_PCM_STREAM_CAPTURE) {
+		err = xfer_options_fixup_paths(xfer);
+		if (err < 0)
+			return err;
+	}
+
 	if (xfer->verbose > 1) {
 		fprintf(stderr, "Transfer: %s\n",
 			xfer_type_labels[xfer->type]);
diff --git a/axfer/xfer.h b/axfer/xfer.h
index 3faaec0..3eaa045 100644
--- a/axfer/xfer.h
+++ b/axfer/xfer.h
@@ -26,7 +26,20 @@ struct xfer_context {
 	const struct xfer_ops *ops;
 	void *private_data;
 
+	char *sample_format_literal;
+	char *cntr_format_literal;
 	unsigned int verbose;
+	unsigned int frames_per_second;
+	unsigned int samples_per_frame;
+	bool help:1;
+	bool multiple_cntrs:1;	// For mapper.
+
+	snd_pcm_format_t sample_format;
+
+	// For containers.
+	char **paths;
+	unsigned int path_count;
+	enum container_format cntr_format;
 };
 
 enum xfer_type xfer_type_from_label(const char *label);
@@ -47,6 +60,12 @@ int xfer_context_process_frames(struct xfer_context *xfer,
 void xfer_context_pause(struct xfer_context *xfer, bool enable);
 void xfer_context_post_process(struct xfer_context *xfer);
 
+struct xfer_data;
+int xfer_options_parse_args(struct xfer_context *xfer,
+			    const struct xfer_data *data, int argc,
+			    char *const *argv);
+int xfer_options_fixup_paths(struct xfer_context *xfer);
+
 // For internal use in 'xfer' module.
 
 struct xfer_ops {
-- 
2.19.1
