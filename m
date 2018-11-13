From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/35] axfer: add a common interface to handle
	a file with audio-specific data format
Date: Tue, 13 Nov 2018 15:41:15 +0900
Message-ID: <20181113064147.13577-3-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D0823267839
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:41:59 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id 70so5219743pgh.8
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:41:59 -0800 (PST)
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

Current aplay supports several types of data format for file; Microsoft/IBM
RIFF/Wave (.wav), Sparc AU (.au) and Creative Tech. voice (.voc). These
formats were designed to handle audio-related data with interleaved frame
alignment.

This commit adds a common interface to handle the file format, named as
'container' module. This includes several functions to build/parse
the format data from any file descriptors. Furthermore, this includes
several helper functions for implementations of each builder/parser.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am |   7 +-
 axfer/container.c | 423 ++++++++++++++++++++++++++++++++++++++++++++++
 axfer/container.h | 110 ++++++++++++
 3 files changed, 538 insertions(+), 2 deletions(-)
 create mode 100644 axfer/container.c
 create mode 100644 axfer/container.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 4e37b92..3913d0c 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -15,10 +15,13 @@ LDADD = \
 
 noinst_HEADERS = \
 	misc.h \
-	subcmd.h
+	subcmd.h \
+	container.h
 
 axfer_SOURCES = \
 	misc.h \
 	subcmd.h \
 	main.c \
-	subcmd-list.c
+	subcmd-list.c \
+	container.h \
+	container.c
diff --git a/axfer/container.c b/axfer/container.c
new file mode 100644
index 00000000..77bbd6c
--- /dev/null
+++ b/axfer/container.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// container.c - an interface of parser/builder for formatted files.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "container.h"
+#include "misc.h"
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
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
+			     unsigned int byte_count)
+{
+	char *dst = buf;
+	ssize_t result;
+	size_t consumed = 0;
+
+	while (consumed < byte_count && !cntr->interrupted) {
+		result = read(cntr->fd, dst + consumed, byte_count - consumed);
+		if (result < 0) {
+			// This descriptor was configured with non-blocking
+			// mode. EINTR is not cought when get any interrupts.
+			if (cntr->interrupted)
+				return -EINTR;
+			if (errno == EAGAIN)
+				continue;
+			return -errno;
+		}
+		// Reach EOF.
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
+			      unsigned int byte_count)
+{
+	char *src = buf;
+	ssize_t result;
+	size_t consumed = 0;
+
+	while (consumed < byte_count && !cntr->interrupted) {
+		result = write(cntr->fd, src + consumed, byte_count - consumed);
+		if (result < 0) {
+			// This descriptor was configured with non-blocking
+			// mode. EINTR is not cought when get any interrupts.
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
+		// Check last part of the string.
+		pos = path + strlen(path) - strlen(suffix);
+		if (!strcmp(pos, suffix))
+			return i;
+	}
+
+	// Unsupported.
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
+// To avoid blocking execution at system call iteration after receiving UNIX
+// signals.
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
+	assert(cntr);
+	assert(path);
+	assert(path[0] != '\0');
+
+	// Detect forgotten to destruct.
+	assert(cntr->fd == 0);
+	assert(cntr->private_data == NULL);
+
+	memset(cntr, 0, sizeof(*cntr));
+
+	// Open a target descriptor.
+	if (!strcmp(path, "-")) {
+		cntr->fd = fileno(stdin);
+		err = set_nonblock_flag(cntr->fd);
+		if (err < 0)
+			return err;
+		cntr->stdio = true;
+	} else {
+		cntr->fd = open(path, O_RDONLY | O_NONBLOCK);
+		if (cntr->fd < 0)
+			return -errno;
+	}
+
+	// 4 bytes are enough to detect supported containers.
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
+
+	// Don't forget that the first 4 bytes were already read for magic
+	// bytes.
+	cntr->magic_handled = false;
+
+	// Unless detected, use raw container.
+	if (i == ARRAY_SIZE(parsers))
+		return -EINVAL;
+
+	// Allocate private data for the parser.
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
+	assert(cntr);
+	assert(path);
+	assert(path[0] != '\0');
+
+	// Detect forgotten to destruct.
+	assert(cntr->fd == 0);
+	assert(cntr->private_data == NULL);
+
+	memset(cntr, 0, sizeof(*cntr));
+
+	// Open a target descriptor.
+	if (path == NULL || *path == '\0')
+		return -EINVAL;
+	if (!strcmp(path, "-")) {
+		cntr->fd = fileno(stdout);
+		err = set_nonblock_flag(cntr->fd);
+		if (err < 0)
+			return err;
+		cntr->stdio = true;
+	} else {
+		cntr->fd = open(path, O_RDWR | O_NONBLOCK | O_CREAT | O_TRUNC,
+				0644);
+		if (cntr->fd < 0)
+			return -errno;
+	}
+
+	builder = builders[format];
+
+	// Allocate private data for the builder.
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
+	uint64_t byte_count;
+	unsigned int bytes_per_frame;
+	int err;
+
+	assert(cntr);
+	assert(format);
+	assert(samples_per_frame);
+	assert(frames_per_second);
+	assert(frame_count);
+
+	if (cntr->type == CONTAINER_TYPE_BUILDER)
+		byte_count = cntr->max_size;
+
+	if (cntr->ops->pre_process) {
+		err = cntr->ops->pre_process(cntr, format, samples_per_frame,
+					     frames_per_second, &byte_count);
+		if (err < 0)
+			return err;
+		if (cntr->eof)
+			return 0;
+	}
+
+	assert(*format >= SND_PCM_FORMAT_S8);
+	assert(*format <= SND_PCM_FORMAT_LAST);
+	assert(*samples_per_frame > 0);
+	assert(*frames_per_second > 0);
+	assert(byte_count > 0);
+
+	cntr->bytes_per_sample = snd_pcm_format_physical_width(*format) / 8;
+	cntr->samples_per_frame = *samples_per_frame;
+	cntr->frames_per_second = *frames_per_second;
+
+	bytes_per_frame = cntr->bytes_per_sample * *samples_per_frame;
+	*frame_count = byte_count / bytes_per_frame;
+	cntr->max_size -= cntr->max_size / bytes_per_frame;
+
+	if (cntr->verbose > 0) {
+		fprintf(stderr, "Container: %s\n",
+			cntr_type_labels[cntr->type]);
+		fprintf(stderr, "  format: %s\n",
+			cntr_format_labels[cntr->format]);
+		fprintf(stderr, "  sample format: %s\n",
+			snd_pcm_format_name(*format));
+		fprintf(stderr, "  bytes/sample: %u\n",
+			cntr->bytes_per_sample);
+		fprintf(stderr, "  samples/frame: %u\n",
+			cntr->samples_per_frame);
+		fprintf(stderr, "  frames/second: %u\n",
+			cntr->frames_per_second);
+		if (cntr->type == CONTAINER_TYPE_PARSER) {
+			fprintf(stderr, "  frames: %lu\n",
+				*frame_count);
+		} else {
+			fprintf(stderr, "  max frames: %lu\n",
+				*frame_count);
+		}
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
+	unsigned int bytes_per_frame;
+	unsigned int byte_count;
+	int err;
+
+	assert(cntr);
+	assert(!cntr->eof);
+	assert(frame_buffer);
+	assert(frame_count);
+
+	bytes_per_frame = cntr->bytes_per_sample * cntr->samples_per_frame;
+	byte_count = *frame_count * bytes_per_frame;
+
+	// Each container has limitation for its volume for sample data.
+	if (cntr->handled_byte_count > cntr->max_size - byte_count)
+		byte_count = cntr->max_size - cntr->handled_byte_count;
+
+	// All of supported containers include interleaved PCM frames.
+	// TODO: process frames for truncate case.
+	err = cntr->process_bytes(cntr, buf, byte_count);
+	if (err < 0) {
+		*frame_count = 0;
+		return err;
+	}
+
+	cntr->handled_byte_count += byte_count;
+	if (cntr->handled_byte_count == cntr->max_size)
+		cntr->eof = true;
+
+	*frame_count = byte_count / bytes_per_frame;
+
+	return 0;
+}
+
+int container_context_post_process(struct container_context *cntr,
+				   uint64_t *frame_count)
+{
+	int err = 0;
+
+	assert(cntr);
+	assert(frame_count);
+
+	if (cntr->verbose && cntr->handled_byte_count > 0) {
+		fprintf(stderr, "  Handled bytes: %lu\n",
+			cntr->handled_byte_count);
+	}
+
+	// NOTE* we cannot seek when using standard input/output.
+	if (!cntr->stdio && cntr->ops && cntr->ops->post_process) {
+		// Usually, need to write out processed bytes in container
+		// header even it this program is interrupted.
+		cntr->interrupted = false;
+
+		err = cntr->ops->post_process(cntr, cntr->handled_byte_count);
+	}
+
+	// Ensure to perform write-back from disk cache.
+	if (cntr->type == CONTAINER_TYPE_BUILDER)
+		fsync(cntr->fd);
+
+	if (err < 0)
+		return err;
+
+	if (cntr->bytes_per_sample == 0 || cntr->samples_per_frame == 0) {
+		*frame_count = 0;
+	} else {
+		*frame_count = cntr->handled_byte_count /
+			       cntr->bytes_per_sample /
+			       cntr->samples_per_frame;
+	}
+
+	return 0;
+}
+
+void container_context_destroy(struct container_context *cntr)
+{
+	assert(cntr);
+
+	close(cntr->fd);
+	if (cntr->private_data)
+		free(cntr->private_data);
+
+	cntr->fd = 0;
+	cntr->private_data = NULL;
+}
diff --git a/axfer/container.h b/axfer/container.h
new file mode 100644
index 00000000..4a94d7f
--- /dev/null
+++ b/axfer/container.h
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// container.h - an interface of parser/builder for formatted files.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#ifndef __ALSA_UTILS_AXFER_CONTAINER__H_
+#define __ALSA_UTILS_AXFER_CONTAINER__H_
+
+#define _LARGEFILE64_SOURCE
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <alsa/asoundlib.h>
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
+	bool stdio;
+
+	enum container_format format;
+	uint64_t max_size;
+	char magic[4];
+	const struct container_ops *ops;
+	void *private_data;
+
+	// Available after pre-process.
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
+				   uint64_t *frame_count);
+
+// For internal use in 'container' module.
+
+struct container_ops {
+	int (*pre_process)(struct container_context *cntr,
+			   snd_pcm_format_t *format,
+			   unsigned int *samples_per_frame,
+			   unsigned int *frames_per_second,
+			   uint64_t *byte_count);
+	int (*post_process)(struct container_context *cntr,
+			    uint64_t handled_byte_count);
+};
+struct container_parser {
+	enum container_format format;
+	const char *const magic;
+	uint64_t max_size;
+	struct container_ops ops;
+	unsigned int private_size;
+};
+
+struct container_builder {
+	enum container_format format;
+	const char *const suffix;
+	uint64_t max_size;
+	struct container_ops ops;
+	unsigned int private_size;
+};
+
+int container_recursive_read(struct container_context *cntr, void *buf,
+			     unsigned int byte_count);
+int container_recursive_write(struct container_context *cntr, void *buf,
+			      unsigned int byte_count);
+int container_seek_offset(struct container_context *cntr, off64_t offset);
+
+#endif
-- 
2.19.1
