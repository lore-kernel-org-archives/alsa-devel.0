From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/35] axfer: add unit test for container
	interface
Date: Tue, 13 Nov 2018 15:41:20 +0900
Message-ID: <20181113064147.13577-8-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 84A9B267AAC
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:08 +0100 (CET)
Received: by mail-pf1-f194.google.com with SMTP id x2-v6so5538500pfm.7
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:08 -0800 (PST)
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

In former commits, container module gets supports of parser/builder for
several types of file format. This commit adds a unit test for them.
This includes positive test cases only. The test cases actually generate
I/O to file systems for many test cases. It takes a long time to finish.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am           |   3 +-
 axfer/test/Makefile.am      |  15 ++
 axfer/test/container-test.c | 299 ++++++++++++++++++++++++++++++++++++
 axfer/test/generator.c      | 260 +++++++++++++++++++++++++++++++
 axfer/test/generator.h      |  47 ++++++
 configure.ac                |   3 +-
 6 files changed, 625 insertions(+), 2 deletions(-)
 create mode 100644 axfer/test/Makefile.am
 create mode 100644 axfer/test/container-test.c
 create mode 100644 axfer/test/generator.c
 create mode 100644 axfer/test/generator.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index f1ec1d1..55fcf71 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -6,7 +6,8 @@ AM_CPPFLAGS = \
 	-I$(top_srcdir)/include
 
 # Unit tests.
-SUBDIRS =
+SUBDIRS = \
+	test
 
 LIBRT = @LIBRT@
 LDADD = \
diff --git a/axfer/test/Makefile.am b/axfer/test/Makefile.am
new file mode 100644
index 00000000..66b30ef
--- /dev/null
+++ b/axfer/test/Makefile.am
@@ -0,0 +1,15 @@
+TESTS = \
+	container-test
+
+check_PROGRAMS = \
+	container-test
+
+container_test_SOURCES = \
+	../container.h \
+	../container.c \
+	../container-riff-wave.c \
+	../container-au.c \
+	../container-voc.c \
+	../container-raw.c \
+	generator.c \
+	container-test.c
diff --git a/axfer/test/container-test.c b/axfer/test/container-test.c
new file mode 100644
index 00000000..0e2e6e9
--- /dev/null
+++ b/axfer/test/container-test.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// container-io.c - a unit test for parser/builder of supported containers.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "../container.h"
+#include "../misc.h"
+
+#include "generator.h"
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdbool.h>
+
+#include <assert.h>
+
+struct container_trial {
+	enum container_format format;
+
+	struct container_context cntr;
+	bool verbose;
+};
+
+static void test_builder(struct container_context *cntr,
+			 enum container_format format, const char *const name,
+			 snd_pcm_access_t access,
+			 snd_pcm_format_t sample_format,
+			 unsigned int samples_per_frame,
+			 unsigned int frames_per_second,
+			 void *frame_buffer, unsigned int frame_count,
+			 bool verbose)
+{
+	snd_pcm_format_t sample;
+	unsigned int channels;
+	unsigned int rate;
+	uint64_t max_frame_count;
+	unsigned int handled_frame_count;
+	uint64_t total_frame_count;
+	int err;
+
+	err = container_builder_init(cntr, name, format, verbose);
+	assert(err == 0);
+
+	sample = sample_format;
+	channels = samples_per_frame;
+	rate = frames_per_second;
+	max_frame_count = 0;
+	err = container_context_pre_process(cntr, &sample, &channels, &rate,
+					    &max_frame_count);
+	assert(err == 0);
+	assert(sample == sample_format);
+	assert(channels == samples_per_frame);
+	assert(rate == frames_per_second);
+	assert(max_frame_count > 0);
+
+	handled_frame_count = frame_count;
+	err = container_context_process_frames(cntr, frame_buffer,
+					       &handled_frame_count);
+	assert(err == 0);
+	assert(handled_frame_count > 0);
+	assert(handled_frame_count <= frame_count);
+
+	total_frame_count = 0;
+	err = container_context_post_process(cntr, &total_frame_count);
+	assert(err == 0);
+	assert(total_frame_count == frame_count);
+
+	container_context_destroy(cntr);
+}
+
+static void test_parser(struct container_context *cntr,
+		        enum container_format format, const char *const name,
+		        snd_pcm_access_t access, snd_pcm_format_t sample_format,
+		        unsigned int samples_per_frame,
+		        unsigned int frames_per_second,
+		        void *frame_buffer, unsigned int frame_count,
+			bool verbose)
+{
+	snd_pcm_format_t sample;
+	unsigned int channels;
+	unsigned int rate;
+	uint64_t total_frame_count;
+	unsigned int handled_frame_count;
+	int err;
+
+	err = container_parser_init(cntr, name, verbose);
+	assert(err == 0);
+
+	sample = sample_format;
+	channels = samples_per_frame;
+	rate = frames_per_second;
+	total_frame_count = 0;
+	err = container_context_pre_process(cntr, &sample, &channels, &rate,
+					    &total_frame_count);
+	assert(err == 0);
+	assert(sample == sample_format);
+	assert(channels == samples_per_frame);
+	assert(rate == frames_per_second);
+	assert(total_frame_count == frame_count);
+
+	handled_frame_count = total_frame_count;
+	err = container_context_process_frames(cntr, frame_buffer,
+					       &handled_frame_count);
+	assert(err == 0);
+	assert(handled_frame_count == frame_count);
+
+	total_frame_count = 0;
+	err = container_context_post_process(cntr, &total_frame_count);
+	assert(err == 0);
+	assert(total_frame_count == handled_frame_count);
+
+	container_context_destroy(cntr);
+}
+
+static int callback(struct test_generator *gen, snd_pcm_access_t access,
+		    snd_pcm_format_t sample_format,
+		    unsigned int samples_per_frame, void *frame_buffer,
+		    unsigned int frame_count)
+{
+	static const unsigned int entries[] = {
+		[0] = 44100,
+		[1] = 48000,
+		[2] = 88200,
+		[3] = 96000,
+		[4] = 176400,
+		[5] = 192000,
+	};
+	struct container_trial *trial = gen->private_data;
+	unsigned int frames_per_second;
+	const char *const name = "hoge";
+	unsigned int size;
+	void *buf;
+	int i;
+	int err = 0;
+
+	size = frame_count * samples_per_frame *
+			snd_pcm_format_physical_width(sample_format) / 8;
+	buf = malloc(size);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	// Remove a result of a previous trial.
+	unlink(name);
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		frames_per_second = entries[i];
+
+		test_builder(&trial->cntr, trial->format, name, access,
+			     sample_format, samples_per_frame,
+			     frames_per_second, frame_buffer, frame_count,
+			     trial->verbose);
+
+		test_parser(&trial->cntr, trial->format, name, access,
+			    sample_format, samples_per_frame, frames_per_second,
+			    buf, frame_count, trial->verbose);
+
+		err = memcmp(buf, frame_buffer, size);
+		assert(err == 0);
+
+		unlink(name);
+	}
+
+	free(buf);
+
+	return 0;
+}
+
+int main(int argc, const char *argv[])
+{
+	static const uint64_t sample_format_masks[] = {
+		[CONTAINER_FORMAT_RIFF_WAVE] =
+			(1ul << SND_PCM_FORMAT_U8) |
+			(1ul << SND_PCM_FORMAT_S16_LE) |
+			(1ul << SND_PCM_FORMAT_S16_BE) |
+			(1ul << SND_PCM_FORMAT_S24_LE) |
+			(1ul << SND_PCM_FORMAT_S24_BE) |
+			(1ul << SND_PCM_FORMAT_S32_LE) |
+			(1ul << SND_PCM_FORMAT_S32_BE) |
+			(1ul << SND_PCM_FORMAT_FLOAT_LE) |
+			(1ul << SND_PCM_FORMAT_FLOAT_BE) |
+			(1ul << SND_PCM_FORMAT_FLOAT64_LE) |
+			(1ul << SND_PCM_FORMAT_FLOAT64_BE) |
+			(1ul << SND_PCM_FORMAT_MU_LAW) |
+			(1ul << SND_PCM_FORMAT_A_LAW) |
+			(1ul << SND_PCM_FORMAT_S24_3LE) |
+			(1ul << SND_PCM_FORMAT_S24_3BE) |
+			(1ul << SND_PCM_FORMAT_S20_3LE) |
+			(1ul << SND_PCM_FORMAT_S20_3BE) |
+			(1ul << SND_PCM_FORMAT_S18_3LE) |
+			(1ul << SND_PCM_FORMAT_S18_3BE),
+		[CONTAINER_FORMAT_AU] =
+			(1ul << SND_PCM_FORMAT_S8) |
+			(1ul << SND_PCM_FORMAT_S16_BE) |
+			(1ul << SND_PCM_FORMAT_S32_BE) |
+			(1ul << SND_PCM_FORMAT_FLOAT_BE) |
+			(1ul << SND_PCM_FORMAT_FLOAT64_BE) |
+			(1ul << SND_PCM_FORMAT_MU_LAW) |
+			(1ul << SND_PCM_FORMAT_A_LAW),
+		[CONTAINER_FORMAT_VOC] =
+			(1ul << SND_PCM_FORMAT_U8) |
+			(1ul << SND_PCM_FORMAT_S16_LE) |
+			(1ul << SND_PCM_FORMAT_MU_LAW) |
+			(1ul << SND_PCM_FORMAT_A_LAW),
+		[CONTAINER_FORMAT_RAW] =
+			(1ul << SND_PCM_FORMAT_S8) |
+			(1ul << SND_PCM_FORMAT_U8) |
+			(1ul << SND_PCM_FORMAT_S16_LE) |
+			(1ul << SND_PCM_FORMAT_S16_BE) |
+			(1ul << SND_PCM_FORMAT_U16_LE) |
+			(1ul << SND_PCM_FORMAT_U16_BE) |
+			(1ul << SND_PCM_FORMAT_S24_LE) |
+			(1ul << SND_PCM_FORMAT_S24_BE) |
+			(1ul << SND_PCM_FORMAT_U24_LE) |
+			(1ul << SND_PCM_FORMAT_U24_BE) |
+			(1ul << SND_PCM_FORMAT_S32_LE) |
+			(1ul << SND_PCM_FORMAT_S32_BE) |
+			(1ul << SND_PCM_FORMAT_U32_LE) |
+			(1ul << SND_PCM_FORMAT_U32_BE) |
+			(1ul << SND_PCM_FORMAT_FLOAT_LE) |
+			(1ul << SND_PCM_FORMAT_FLOAT_BE) |
+			(1ul << SND_PCM_FORMAT_FLOAT64_LE) |
+			(1ul << SND_PCM_FORMAT_FLOAT64_BE) |
+			(1ul << SND_PCM_FORMAT_IEC958_SUBFRAME_LE) |
+			(1ul << SND_PCM_FORMAT_IEC958_SUBFRAME_BE) |
+			(1ul << SND_PCM_FORMAT_MU_LAW) |
+			(1ul << SND_PCM_FORMAT_A_LAW) |
+			(1ul << SND_PCM_FORMAT_S24_3LE) |
+			(1ul << SND_PCM_FORMAT_S24_3BE) |
+			(1ul << SND_PCM_FORMAT_U24_3LE) |
+			(1ul << SND_PCM_FORMAT_U24_3BE) |
+			(1ul << SND_PCM_FORMAT_S20_3LE) |
+			(1ul << SND_PCM_FORMAT_S20_3BE) |
+			(1ul << SND_PCM_FORMAT_U20_3LE) |
+			(1ul << SND_PCM_FORMAT_U20_3BE) |
+			(1ul << SND_PCM_FORMAT_S18_3LE) |
+			(1ul << SND_PCM_FORMAT_S18_3BE) |
+			(1ul << SND_PCM_FORMAT_U18_3LE) |
+			(1ul << SND_PCM_FORMAT_U18_3BE) |
+			(1ul << SND_PCM_FORMAT_DSD_U8) |
+			(1ul << SND_PCM_FORMAT_DSD_U16_LE) |
+			(1ul << SND_PCM_FORMAT_DSD_U32_LE) |
+			(1ul << SND_PCM_FORMAT_DSD_U16_BE) |
+			(1ul << SND_PCM_FORMAT_DSD_U32_BE),
+	};
+	static const uint64_t access_mask =
+		(1ul << SND_PCM_ACCESS_MMAP_INTERLEAVED) |
+		(1ul << SND_PCM_ACCESS_RW_INTERLEAVED);
+	struct test_generator gen = {0};
+	struct container_trial *trial;
+	int i;
+	int begin;
+	int end;
+	bool verbose;
+	int err;
+
+	if (argc > 1) {
+		char *term;
+		begin = strtol(argv[1], &term, 10);
+		if (errno || *term != '\0')
+			return EXIT_FAILURE;
+		if (begin < CONTAINER_FORMAT_RIFF_WAVE &&
+		    begin > CONTAINER_FORMAT_RAW)
+			return -EXIT_FAILURE;
+		end = begin + 1;
+		verbose = true;
+	} else {
+		begin = CONTAINER_FORMAT_RIFF_WAVE;
+		end = CONTAINER_FORMAT_RAW + 1;
+		verbose = false;
+	}
+
+	for (i = begin; i < end; ++i) {
+		err = generator_context_init(&gen, access_mask,
+					     sample_format_masks[i],
+					     1, 128, 23, 4500, 1024,
+					     sizeof(struct container_trial));
+		if (err >= 0) {
+			trial = gen.private_data;
+			trial->format = i;
+			trial->verbose = verbose;
+			err = generator_context_run(&gen, callback);
+		}
+
+		generator_context_destroy(&gen);
+
+		if (err < 0)
+			break;
+	}
+
+	if (err < 0) {
+		printf("%s\n", strerror(-err));
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
diff --git a/axfer/test/generator.c b/axfer/test/generator.c
new file mode 100644
index 00000000..cdea2c9
--- /dev/null
+++ b/axfer/test/generator.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// allocator.h - a header of a generator for test with buffers of PCM frames.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "generator.h"
+
+#include <stdlib.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <unistd.h>
+
+int generator_context_init(struct test_generator *gen,
+			   uint64_t access_mask, uint64_t sample_format_mask,
+			   unsigned int min_samples_per_frame,
+			   unsigned int max_samples_per_frame,
+			   unsigned int min_frame_count,
+			   unsigned int max_frame_count,
+			   unsigned int step_frame_count,
+			   unsigned int private_size)
+{
+	gen->fd = open("/dev/urandom", O_RDONLY);
+	if (gen->fd < 0)
+		return -errno;
+
+	gen->private_data = malloc(private_size);
+	if (gen->private_data == NULL)
+		return -ENOMEM;
+	memset(gen->private_data, 0, private_size);
+
+	gen->access_mask = access_mask;
+	gen->sample_format_mask = sample_format_mask;
+	gen->min_samples_per_frame = min_samples_per_frame;
+	gen->max_samples_per_frame = max_samples_per_frame;
+	gen->min_frame_count = min_frame_count;
+	gen->max_frame_count = max_frame_count;
+	gen->step_frame_count = step_frame_count;
+
+	return 0;
+}
+
+static void *allocate_buf(snd_pcm_access_t access,
+			  snd_pcm_format_t sample_format,
+			  unsigned int samples_per_frame,
+			  unsigned int frame_count)
+{
+	unsigned int bytes_per_sample;
+
+	bytes_per_sample = snd_pcm_format_physical_width(sample_format) / 8;
+
+	return calloc(samples_per_frame * frame_count, bytes_per_sample);
+}
+
+static void *allocate_vector(snd_pcm_access_t access,
+			     snd_pcm_format_t sample_format,
+			     unsigned int samples_per_frame,
+			     unsigned int frame_count)
+{
+	unsigned int bytes_per_sample;
+	char **bufs;
+	int i;
+
+	bytes_per_sample = snd_pcm_format_physical_width(sample_format) / 8;
+
+	bufs = calloc(samples_per_frame, sizeof(char *));
+	if (bufs == NULL)
+		return NULL;
+
+	for (i = 0; i < samples_per_frame; ++i) {
+		bufs[i] = calloc(frame_count, bytes_per_sample);
+		if (bufs[i] == NULL) {
+			for (; i >= 0; --i)
+				free(bufs[i]);
+			free(bufs);
+			return NULL;
+		}
+	}
+
+	return bufs;
+}
+
+static int fill_buf(int fd, void *frame_buffer, snd_pcm_access_t access,
+		    snd_pcm_format_t sample_format,
+		    unsigned int samples_per_frame, unsigned int frame_count)
+{
+	unsigned int size;
+	int len;
+
+	size = snd_pcm_format_physical_width(sample_format) / 8 *
+						samples_per_frame * frame_count;
+	while (size > 0) {
+		len = read(fd, frame_buffer, size);
+		if (len < 0)
+			return len;
+		size -= len;
+	}
+
+	return 0;
+}
+
+static int fill_vector(int fd, void *frame_buffer, snd_pcm_access_t access,
+		       snd_pcm_format_t sample_format,
+		       unsigned int samples_per_frame, unsigned int frame_count)
+{
+	char **bufs = frame_buffer;
+	unsigned int size;
+	int len;
+	int i;
+
+	for (i = 0; i < samples_per_frame; ++i) {
+		size = frame_count *
+			snd_pcm_format_physical_width(sample_format) / 8;
+
+		while (size > 0) {
+			len = read(fd, bufs[i], size);
+			if (len < 0)
+				return len;
+			size -= len;
+		}
+	}
+
+	return 0;
+}
+
+static void deallocate_buf(void *frame_buffer, unsigned int samples_per_frame)
+{
+	free(frame_buffer);
+}
+
+static void deallocate_vector(void *frame_buffer,
+			      unsigned int samples_per_frame)
+{
+	char **bufs = frame_buffer;
+	int i;
+
+	for (i = 0; i < samples_per_frame; ++i)
+		free(bufs[i]);
+
+	free(bufs);
+}
+
+static int test_frame_count(struct test_generator *gen,
+			    snd_pcm_access_t access,
+			    snd_pcm_format_t sample_format,
+			    unsigned int samples_per_frame)
+{
+	void *(*allocator)(snd_pcm_access_t access,
+			   snd_pcm_format_t sample_format,
+			   unsigned int samples_per_frame,
+			   unsigned int frame_count);
+	int (*fill)(int fd, void *frame_buffer, snd_pcm_access_t access,
+		    snd_pcm_format_t sample_format,
+		    unsigned int samples_per_frame, unsigned int frame_count);
+	void (*deallocator)(void *frame_buffer, unsigned int samples_per_frame);
+	void *frame_buffer;
+	int i;
+	int err = 0;
+
+	if (access != SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+		allocator = allocate_buf;
+		fill = fill_buf;
+		deallocator = deallocate_buf;
+	} else {
+		allocator = allocate_vector;
+		fill = fill_vector;
+		deallocator = deallocate_vector;
+	}
+
+	frame_buffer = allocator(access, sample_format, samples_per_frame,
+				 gen->max_frame_count);
+	if (frame_buffer == NULL)
+		return -ENOMEM;
+
+	err = fill(gen->fd, frame_buffer, access, sample_format,
+		   samples_per_frame, gen->max_frame_count);
+	if (err < 0)
+		goto end;
+
+
+	for (i = gen->min_frame_count;
+	     i <= gen->max_frame_count; i += gen->step_frame_count) {
+		err = gen->cb(gen, access ,sample_format, samples_per_frame,
+			      frame_buffer, i);
+		if (err < 0)
+			break;
+	}
+end:
+	deallocator(frame_buffer, samples_per_frame);
+
+	return err;
+}
+
+static int test_samples_per_frame(struct test_generator *gen,
+				  snd_pcm_access_t access,
+				  snd_pcm_format_t sample_format)
+{
+	int i;
+	int err = 0;
+
+	for (i = gen->min_samples_per_frame;
+	     i <= gen->max_samples_per_frame; ++i) {
+		err = test_frame_count(gen, access, sample_format, i);
+		if (err < 0)
+			break;
+	}
+
+	return err;
+}
+
+static int test_sample_format(struct test_generator *gen,
+			      snd_pcm_access_t access)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i <= SND_PCM_FORMAT_LAST; ++i) {
+		if (!((1ul << i) & gen->sample_format_mask))
+			continue;
+
+		err = test_samples_per_frame(gen, access, i);
+		if (err < 0)
+			break;
+	}
+
+	return err;
+}
+
+static int test_access(struct test_generator *gen)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i <= SND_PCM_ACCESS_LAST; ++i) {
+		if (!((1ul << i) & gen->access_mask))
+			continue;
+
+		err = test_sample_format(gen, i);
+		if (err < 0)
+			break;
+	}
+	return err;
+}
+
+int generator_context_run(struct test_generator *gen, generator_cb_t cb)
+{
+	gen->cb = cb;
+	return test_access(gen);
+}
+
+void generator_context_destroy(struct test_generator *gen)
+{
+	free(gen->private_data);
+	close(gen->fd);
+}
diff --git a/axfer/test/generator.h b/axfer/test/generator.h
new file mode 100644
index 00000000..c35ed98
--- /dev/null
+++ b/axfer/test/generator.h
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// generator.c - a generator for test with buffers of PCM frames.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#ifndef __ALSA_UTILS_AXFER_TEST_GENERATOR__H_
+#define __ALSA_UTILS_AXFER_TEST_GENERATOR__H_
+
+#include <stdint.h>
+#include <alsa/asoundlib.h>
+
+struct test_generator;
+typedef int (*generator_cb_t)(struct test_generator *gen,
+			      snd_pcm_access_t access,
+			      snd_pcm_format_t sample_format,
+			      unsigned int samples_per_frame,
+			      void *frame_buffer, unsigned int frame_count);
+
+struct test_generator {
+	int fd;
+	uint64_t access_mask;
+	uint64_t sample_format_mask;
+	unsigned int min_samples_per_frame;
+	unsigned int max_samples_per_frame;
+	unsigned int min_frame_count;
+	unsigned int max_frame_count;
+	unsigned int step_frame_count;
+
+	generator_cb_t cb;
+	void *private_data;
+};
+
+int generator_context_init(struct test_generator *gen,
+			   uint64_t access_mask, uint64_t sample_format_mask,
+			   unsigned int min_samples_per_frame,
+			   unsigned int max_samples_per_frame,
+			   unsigned int min_frame_count,
+			   unsigned int max_frame_count,
+			   unsigned int step_frame_count,
+			   unsigned int private_size);
+int generator_context_run(struct test_generator *gen, generator_cb_t cb);
+void generator_context_destroy(struct test_generator *gen);
+
+#endif
diff --git a/configure.ac b/configure.ac
index 404fa16..1c64617 100644
--- a/configure.ac
+++ b/configure.ac
@@ -430,4 +430,5 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
 	  speaker-test/Makefile speaker-test/samples/Makefile \
-	  alsaloop/Makefile alsa-info/Makefile axfer/Makefile)
+	  alsaloop/Makefile alsa-info/Makefile \
+	  axfer/Makefile axfer/test/Makefile)
-- 
2.19.1
