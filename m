From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 01/23] aplay: add an abstraction of
	container to parse/build audio-specific data format
Date: Thu, 17 Aug 2017 20:59:42 +0900
Message-ID: <20170817120004.15326-2-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 32C39266812
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:10 +0200 (CEST)
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

Current implementation of aplay supports three types of data format for
file; Microsoft/IBM RIFF/Wave (.wav), Sparc AU (.au) and Creative Tech.
voice (.voc). These formats were designed to handle audio-related data
with interleaved frame alignment.

This commit adds an abstraction of the file format, named as 'container'
module. This abstraction includes several functions to build/parse
the format data from any file descriptors. Furthermore, this includes
several helper functions for implementations for each builders/parsers.
---
 aplay/Makefile.am |  14 ++-
 aplay/container.c | 340 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/container.h | 114 ++++++++++++++++++
 3 files changed, 463 insertions(+), 5 deletions(-)
 create mode 100644 aplay/container.c
 create mode 100644 aplay/container.h

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index c3256e9..44143e0 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -3,13 +3,17 @@ LIBRT = @LIBRT@
 AM_CPPFLAGS = -I$(top_srcdir)/include
 LDADD = $(LIBINTL) $(LIBRT)
 
-# debug flags
-#LDFLAGS = -static
-#LDADD += -ldl
-
 bin_PROGRAMS = aplay
 man_MANS = aplay.1 arecord.1
-noinst_HEADERS = formats.h
+noinst_HEADERS = \
+	formats.h \
+	container.h
+
+aplay_SOURCES = \
+	formats.h \
+	aplay.c \
+	container.h \
+	container.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/container.c b/aplay/container.c
new file mode 100644
index 0000000..7f8e31b
--- /dev/null
+++ b/aplay/container.c
@@ -0,0 +1,340 @@
+/*
+ * container.c - utilities for I/O to file.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "container.h"
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
+#include <gettext.h>
+
+static const char *const cntr_type_labels[] = {
+	[CONTAINER_TYPE_PARSER] = "parser",
+	[CONTAINER_TYPE_BUILDER] = "builder",
+};
+
+static const char *const cntr_format_labels[] = {
+	[CONTAINER_FORMAT_COUNT] = "",
+};
+
+static const char *const suffixes[] = {
+	[CONTAINER_FORMAT_COUNT] = "",
+};
+
+const char *const container_suffix_from_format(enum container_format format)
+{
+	return suffixes[format];
+}
+
+int container_recursive_read(struct container_context *cntr, void *buf,
+			     unsigned int size)
+{
+	char *dst = buf;
+	ssize_t result;
+	size_t consumed = 0;
+
+	while (consumed < size && !cntr->interrupted) {
+		result = read(cntr->fd, dst + consumed, size - consumed);
+		if (result < 0) {
+			/*
+			 * This descriptor was configured with non-blocking
+			 * mode. EINTR is not cought when get any interrupts.
+			 */
+			if (cntr->interrupted)
+				return -EINTR;
+			if (errno == EAGAIN)
+				continue;
+			return -errno;
+		}
+		/* Reach EOF. */
+		if (result == 0) {
+			cntr->eof = true;
+			return 0;
+		}
+
+		consumed += result;
+	}
+
+	return 0;
+}
+
+int container_recursive_write(struct container_context *cntr, void *buf,
+			      unsigned int size)
+{
+	char *src = buf;
+	ssize_t result;
+	size_t consumed = 0;
+
+	while (consumed < size && !cntr->interrupted) {
+		result = write(cntr->fd, src + consumed, size - consumed);
+		if (result < 0) {
+			/*
+			 * This descriptor was configured with non-blocking
+			 * mode. EINTR is not cought when get any interrupts.
+			 */
+			if (cntr->interrupted)
+				return -EINTR;
+			if (errno == EAGAIN)
+				continue;
+			return -errno;
+		}
+
+		consumed += result;
+	}
+
+	return 0;
+}
+
+enum container_format container_format_from_path(const char *path)
+{
+	const char *suffix;
+	const char *pos;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(suffixes); ++i) {
+		suffix = suffixes[i];
+
+		/* Check last part of the string. */
+		pos = path + strlen(path) - strlen(suffix);
+		if (!strcmp(pos, suffix))
+			return i;
+	}
+
+	/* Unsupported. */
+	return CONTAINER_FORMAT_COUNT;
+}
+
+int container_seek_offset(struct container_context *cntr, off64_t offset)
+{
+	off64_t pos;
+
+	pos = lseek64(cntr->fd, offset, SEEK_SET);
+	if (pos < 0)
+		return -errno;
+	if (pos != offset)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * To avoid blocking execution at system call iteration after receiving UNIX
+ * signals.
+ */
+static int set_nonblock_flag(int fd)
+{
+	int flags;
+
+	flags = fcntl(fd, F_GETFL);
+	if (flags < 0)
+		return -errno;
+
+	flags |= O_NONBLOCK;
+	if (fcntl(fd, F_SETFL, flags) < 0)
+		return -errno;
+
+	return 0;
+}
+
+int container_parser_init(struct container_context *cntr,
+			  const char *const path, unsigned int verbose)
+{
+	const struct container_parser *parsers[] = {
+		NULL,
+	};
+	const struct container_parser *parser;
+	unsigned int size;
+	int i;
+	int err;
+
+	/* Open a target descriptor. */
+	if (path == NULL || path == '\0')
+		return -EINVAL;
+	if (!strcmp(path, "-")) {
+		cntr->fd = fileno(stdin);
+		err = set_nonblock_flag(cntr->fd);
+		if (err < 0)
+			return err;
+	} else {
+		cntr->fd = open(path, O_RDONLY | O_NONBLOCK);
+		if (cntr->fd < 0)
+			return -errno;
+	}
+
+	/* 4 bytes are enough to detect supported containers. */
+	err = container_recursive_read(cntr, cntr->magic, sizeof(cntr->magic));
+	if (err < 0)
+		return err;
+	for (i = 0; i < ARRAY_SIZE(parsers); ++i) {
+		parser = parsers[i];
+		size = strlen(parser->magic);
+		if (size > 4)
+			size = 4;
+		if (!strncmp(cntr->magic, parser->magic, size))
+			break;
+	}
+	/*
+	 * Don't forget that the first 4 bytes were already read for magic
+	 * bytes.
+	 */
+	cntr->magic_handled = false;
+
+	/*
+	 * Unless detected, use raw container.
+	 */
+	if (i == ARRAY_SIZE(parsers))
+		return -EINVAL;
+
+	/* Allocate private data for the parser. */
+	if (parser->private_size > 0) {
+		cntr->private_data = malloc(parser->private_size);
+		if (cntr->private_data == NULL)
+			return -ENOMEM;
+		memset(cntr->private_data, 0, parser->private_size);
+	}
+
+	cntr->type = CONTAINER_TYPE_PARSER;
+	cntr->process_bytes = container_recursive_read;
+	cntr->format = parser->format;
+	cntr->ops = &parser->ops;
+	cntr->max_size = parser->max_size;
+	cntr->verbose = verbose;
+
+	return 0;
+}
+
+int container_builder_init(struct container_context *cntr,
+			   const char *const path, enum container_format format,
+			   unsigned int verbose)
+{
+	const struct container_builder *builders[] = {
+		NULL,
+	};
+	const struct container_builder *builder;
+	int err;
+
+	/* Open a target descriptor. */
+	if (path == NULL || path == '\0')
+		return -EINVAL;
+	if (!strcmp(path, "-")) {
+		cntr->fd = fileno(stdout);
+		err = set_nonblock_flag(cntr->fd);
+		if (err < 0)
+			return err;
+	} else {
+		cntr->fd = open(path, O_RDWR | O_NONBLOCK | O_CREAT, 0644);
+		if (cntr->fd < 0)
+			return -errno;
+	}
+
+	builder = builders[format];
+
+	/* Allocate private data for the builder. */
+	if (builder->private_size > 0) {
+		cntr->private_data = malloc(builder->private_size);
+		if (cntr->private_data == NULL)
+			return -ENOMEM;
+		memset(cntr->private_data, 0, builder->private_size);
+	}
+
+	cntr->type = CONTAINER_TYPE_BUILDER;
+	cntr->process_bytes = container_recursive_write;
+	cntr->format = builder->format;
+	cntr->ops = &builder->ops;
+	cntr->max_size = builder->max_size;
+	cntr->verbose = verbose;
+
+	return 0;
+}
+
+int container_context_pre_process(struct container_context *cntr,
+				  snd_pcm_format_t *format,
+				  unsigned int *samples_per_frame,
+				  unsigned int *frames_per_second,
+				  uint64_t *frame_count)
+{
+	int err;
+
+	if (cntr->ops->pre_process) {
+		err = cntr->ops->pre_process(cntr, format, samples_per_frame,
+					     frames_per_second, frame_count);
+		if (err < 0) {
+			printf("%s(): %s\n", __func__, snd_strerror(err));
+			return err;
+		}
+	}
+
+	cntr->bytes_per_sample = snd_pcm_format_physical_width(*format) / 8;
+	cntr->samples_per_frame = *samples_per_frame;
+	cntr->frames_per_second = *frames_per_second;
+
+	if (cntr->verbose > 0) {
+		printf(_("Container: %s\n"), cntr_type_labels[cntr->type]);
+		printf(_("  format: %s\n"), cntr_format_labels[cntr->format]);
+		printf(_("  sample format: %s\n"), snd_pcm_format_name(*format));
+		printf(_("  bytes/sample: %u\n"), cntr->bytes_per_sample);
+		printf(_("  samples/frame: %u\n"), cntr->samples_per_frame);
+		printf(_("  frames/second: %u\n"), cntr->frames_per_second);
+		printf(_("  frames: %lu\n"), *frame_count);
+		printf("\n");
+	}
+
+	return 0;
+}
+
+int container_context_process_frames(struct container_context *cntr,
+				     void *frame_buffer,
+				     unsigned int *frame_count)
+{
+	char *buf = frame_buffer;
+	unsigned int size = cntr->bytes_per_sample * cntr->samples_per_frame *
+			    *frame_count;
+	int err;
+
+	/* All of supported containers include interleaved PCM frames. */
+	err = cntr->process_bytes(cntr, buf, size);
+	if (err < 0) {
+		*frame_count = 0;
+		return err;
+	}
+
+	/* NOTE: For simplicity, drop the last chunk. */
+	if (cntr->eof) {
+		*frame_count = 0;
+		return 0;
+	}
+
+	cntr->handled_byte_count += size;
+
+	return 0;
+}
+
+int container_context_post_process(struct container_context *cntr,
+				   uint64_t actual_frame_count)
+{
+	/* We cannot seek when using standard input/output. */
+	if (cntr->fd == fileno(stdin) || cntr->fd == fileno(stdout))
+		return 0;
+	if (cntr->verbose && cntr->handled_byte_count > 0) {
+		printf("%s:\n", __func__);
+		printf("  Handled bytes: %lu\n", cntr->handled_byte_count);
+	}
+
+	if (!cntr->ops || !cntr->ops->post_process)
+		return 0;
+
+	return cntr->ops->post_process(cntr, actual_frame_count);
+}
+
+void container_context_destroy(struct container_context *cntr)
+{
+	close(cntr->fd);
+	if (cntr->private_data)
+		free(cntr->private_data);
+}
diff --git a/aplay/container.h b/aplay/container.h
new file mode 100644
index 0000000..df1a90c
--- /dev/null
+++ b/aplay/container.h
@@ -0,0 +1,114 @@
+/*
+ * container.h - a header file for parser/builder of any containers.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_APLAY_CONTAINER__H_
+#define __ALSA_UTILS_APLAY_CONTAINER__H_
+
+#define _LARGEFILE64_SOURCE
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <stdbool.h>
+#include <stdint.h>
+
+/* Not portable to all of UNIX platforms. */
+#include <endian.h>
+
+#include <alsa/asoundlib.h>
+
+#define ARRAY_SIZE(array)	(sizeof(array)/sizeof(array[0]))
+
+enum container_type {
+	CONTAINER_TYPE_PARSER = 0,
+	CONTAINER_TYPE_BUILDER,
+	CONTAINER_TYPE_COUNT,
+};
+
+enum container_format {
+	CONTAINER_FORMAT_COUNT,
+};
+
+struct container_ops;
+
+struct container_context {
+	enum container_type type;
+	int fd;
+	int (*process_bytes)(struct container_context *cntr,
+			     void *buffer, unsigned int byte_count);
+	bool magic_handled;
+	bool eof;
+	bool interrupted;
+
+	enum container_format format;
+	uint64_t max_size;
+	char magic[4];
+	const struct container_ops *ops;
+	void *private_data;
+
+	/* Available after pre-process. */
+	unsigned int bytes_per_sample;
+	unsigned int samples_per_frame;
+	unsigned int frames_per_second;
+
+	unsigned int verbose;
+	uint64_t handled_byte_count;
+};
+
+const char *const container_suffix_from_format(enum container_format format);
+enum container_format container_format_from_path(const char *path);
+int container_parser_init(struct container_context *cntr,
+			  const char *const path, unsigned int verbose);
+int container_builder_init(struct container_context *cntr,
+			   const char *const path, enum container_format format,
+			   unsigned int verbose);
+void container_context_destroy(struct container_context *cntr);
+int container_context_pre_process(struct container_context *cntr,
+				  snd_pcm_format_t *format,
+				  unsigned int *samples_per_frame,
+				  unsigned int *frames_per_second,
+				  uint64_t *frame_count);
+int container_context_process_frames(struct container_context *cntr,
+				     void *frame_buffer,
+				     unsigned int *frame_count);
+int container_context_post_process(struct container_context *cntr,
+				   uint64_t actual_frame_count);
+
+/* For internal use in 'container' module. */
+
+struct container_ops {
+	int (*pre_process)(struct container_context *cntr,
+			   snd_pcm_format_t *format,
+			   unsigned int *samples_per_frame,
+			   unsigned int *frames_per_second,
+			   uint64_t *frame_count);
+	int (*post_process)(struct container_context *cntr,
+			    uint64_t actual_frame_count);
+};
+struct container_parser {
+	enum container_format format;
+	const char const *magic;
+	uint64_t max_size;
+	struct container_ops ops;
+	unsigned int private_size;
+};
+
+struct container_builder {
+	enum container_format format;
+	const char const *suffix;
+	uint64_t max_size;
+	struct container_ops ops;
+	unsigned int private_size;
+};
+
+int container_recursive_read(struct container_context *cntr, void *buf,
+			     unsigned int size);
+int container_recursive_write(struct container_context *cntr, void *buf,
+			      unsigned int size);
+int container_seek_offset(struct container_context *cntr, off64_t offset);
+
+#endif
-- 
2.11.0
