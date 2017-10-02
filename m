From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 34/39] axfer: add a unit test for
	vumeter calculation
Date: Mon,  2 Oct 2017 09:19:35 +0900
Message-ID: <20171002001940.17218-35-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id F371A266ECE
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 02:19:58 +0200 (CEST)
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

In a previous commit, vumeter is implemented. This commit adds a simple
unit test for the feature. This tests positive cases only.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/test/Makefile.am        |  14 +++-
 axfer/test/vumeter-test.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
 axfer/xfer-libasound-irq-rw.c |   2 +-
 3 files changed, 196 insertions(+), 4 deletions(-)
 create mode 100644 axfer/test/vumeter-test.c

diff --git a/axfer/test/Makefile.am b/axfer/test/Makefile.am
index 76a93bfc..0e48b9f2 100644
--- a/axfer/test/Makefile.am
+++ b/axfer/test/Makefile.am
@@ -1,10 +1,12 @@
 TESTS = \
-	container-test  \
-	mapper-test
+	container-test \
+	mapper-test \
+	vumeter-test
 
 check_PROGRAMS = \
 	container-test \
-	mapper-test
+	mapper-test \
+	vumeter-test
 
 container_test_SOURCES = \
 	../container.h \
@@ -29,3 +31,9 @@ mapper_test_SOURCES = \
 	../mapper-multiple.c \
 	generator.c \
 	mapper-test.c
+
+vumeter_test_SOURCES = \
+	../vumeter.h \
+	../vumeter.c \
+	generator.c \
+	vumeter-test.c
diff --git a/axfer/test/vumeter-test.c b/axfer/test/vumeter-test.c
new file mode 100644
index 00000000..6df7c067
--- /dev/null
+++ b/axfer/test/vumeter-test.c
@@ -0,0 +1,184 @@
+/*
+ * test-vumeter.c - A unit test for Volume Unit meter.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "../vumeter.h"
+#include "../misc.h"
+
+#include "generator.h"
+
+#include <stdlib.h>
+
+static bool verbose;
+
+static int callback(struct test_generator *gen, snd_pcm_access_t access,
+		    snd_pcm_format_t sample_format,
+		    unsigned int samples_per_frame, void *frame_buffer,
+		    unsigned int frame_count)
+{
+	static const enum vumeter_mode modes[] = {
+		[0] = VUMETER_MODE_MONO,
+		[1] = VUMETER_MODE_STEREO,
+	};
+	struct vumeter_context *vu = gen->private_data;
+	int i;
+	int err;
+
+	char **vector = NULL;
+
+	if (access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+		char *buf;
+		unsigned int size;
+
+		vector = calloc(samples_per_frame, sizeof(*vector));
+		if (vector == NULL)
+			return -ENOMEM;
+
+		buf = frame_buffer;
+		size = snd_pcm_format_physical_width(sample_format) *
+		       frame_count / 8;
+
+		for (i = 0; i < samples_per_frame; ++i)
+			vector[i] = buf + size * i;
+
+		frame_buffer = vector;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(modes); ++i) {
+		int j;
+
+		if (verbose) {
+			printf("%d %s %s %d %d\n",
+			       modes[i], snd_pcm_access_name(access),
+			       snd_pcm_format_name(sample_format),
+			       samples_per_frame, frame_count);
+		}
+
+		memset(vu, 0, sizeof(*vu));
+		err = vumeter_context_init(vu, modes[i], access, sample_format,
+					   samples_per_frame, 4000);
+		if (err < 0)
+			break;
+		assert(vu->significant_bits_per_sample >= 0);
+		assert(vu->bytes_per_sample >= 0);
+		assert(vu->samples_per_frame >= 0);
+		assert(vu->frames_per_second >= 0);
+		assert(vu->max > 0);
+		assert(vu->peaks != NULL);
+		assert(vu->ratios != NULL);
+		assert(vu->max_ratios_in_second != NULL);
+		assert(vu->printer != NULL);
+		assert(vu->calculator != NULL);
+
+		vumeter_context_prepare(vu);
+		for (j = 0; j < samples_per_frame; ++j) {
+			assert(vu->ratios[j] == 0);
+			assert(vu->max_ratios_in_second[j] == 0);
+		}
+
+		vumeter_context_calculate(vu, frame_buffer, frame_count);
+		for (j = 0; j < samples_per_frame; ++j) {
+			assert(vu->peaks[j] <= vu->max);
+			assert(vu->max_ratios_in_second[j] <= vu->max);
+			assert(vu->max_ratios_in_second[j] <= 100);
+		}
+
+		vumeter_context_destroy(vu);
+		assert(vu->ratios == NULL);
+		assert(vu->max_ratios_in_second == NULL);
+		assert(vu->peaks == NULL);
+	}
+
+	if (vector != NULL)
+		free(vector);
+
+	return err;
+}
+
+int main(int argc, const char *argv[])
+{
+	const uint64_t sample_format_mask =
+		(1ul << SND_PCM_FORMAT_S8) |
+		(1ul << SND_PCM_FORMAT_U8) |
+		(1ul << SND_PCM_FORMAT_S16_LE) |
+		(1ul << SND_PCM_FORMAT_S16_BE) |
+		(1ul << SND_PCM_FORMAT_U16_LE) |
+		(1ul << SND_PCM_FORMAT_U16_BE) |
+		(1ul << SND_PCM_FORMAT_S24_LE) |
+		(1ul << SND_PCM_FORMAT_S24_BE) |
+		(1ul << SND_PCM_FORMAT_U24_LE) |
+		(1ul << SND_PCM_FORMAT_U24_BE) |
+		(1ul << SND_PCM_FORMAT_S32_LE) |
+		(1ul << SND_PCM_FORMAT_S32_BE) |
+		(1ul << SND_PCM_FORMAT_U32_LE) |
+		(1ul << SND_PCM_FORMAT_U32_BE) |
+		(1ul << SND_PCM_FORMAT_S24_3LE) |
+		(1ul << SND_PCM_FORMAT_S24_3BE) |
+		(1ul << SND_PCM_FORMAT_U24_3LE) |
+		(1ul << SND_PCM_FORMAT_U24_3BE) |
+		(1ul << SND_PCM_FORMAT_S24_3LE) |
+		(1ul << SND_PCM_FORMAT_S24_3BE) |
+		(1ul << SND_PCM_FORMAT_U24_3LE) |
+		(1ul << SND_PCM_FORMAT_U24_3BE) |
+		(1ul << SND_PCM_FORMAT_S20_3LE) |
+		(1ul << SND_PCM_FORMAT_S20_3BE) |
+		(1ul << SND_PCM_FORMAT_U20_3LE) |
+		(1ul << SND_PCM_FORMAT_U20_3BE) |
+		(1ul << SND_PCM_FORMAT_S18_3LE) |
+		(1ul << SND_PCM_FORMAT_S18_3BE) |
+		(1ul << SND_PCM_FORMAT_U18_3LE) |
+		(1ul << SND_PCM_FORMAT_U18_3BE);
+	uint64_t access_mask;
+	struct test_generator gen = {0};
+	snd_pcm_access_t access;
+	int err;
+
+	if (argc > 1) {
+		char *term;
+
+		access = strtol(argv[1], &term, 10);
+		if (errno != 0 || *term != '\0') {
+			err = -EINVAL;
+			goto end;
+		}
+		if (access < SND_PCM_ACCESS_MMAP_INTERLEAVED &&
+		    access > SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+			err = -EINVAL;
+			goto end;
+		}
+		if (access == SND_PCM_ACCESS_MMAP_COMPLEX) {
+			err = -EINVAL;
+			goto end;
+		}
+		access_mask = 1ul << access;
+		verbose = true;
+	} else {
+		access_mask = (1ul << SND_PCM_ACCESS_MMAP_INTERLEAVED) |
+			      (1ul << SND_PCM_ACCESS_MMAP_NONINTERLEAVED) |
+			      (1ul << SND_PCM_ACCESS_RW_INTERLEAVED) |
+			      (1ul << SND_PCM_ACCESS_RW_NONINTERLEAVED);
+		verbose = false;
+	}
+
+
+	err = generator_context_init(&gen, access_mask, sample_format_mask,
+				     1, 128, 23, 4500, 1024,
+				     sizeof(struct vumeter_context));
+	if (err < 0)
+		return EXIT_FAILURE;
+
+	err = generator_context_run(&gen, callback);
+
+	generator_context_destroy(&gen);
+end:
+	if (err < 0) {
+		printf("%s\n", strerror(-err));
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
index ee5ce801..a2152d92 100644
--- a/axfer/xfer-libasound-irq-rw.c
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -261,11 +261,11 @@ static int write_frames(struct libasound_state *state,
 		err = snd_pcm_writen(state->handle, cache->buf, consumed_count);
 	if (err < 0)
 		return err;
+	consumed_count = (unsigned int)err;
 
 	if (vu)
 		vumeter_context_calculate(vu, cache->buf, consumed_count);
 
-	consumed_count = (unsigned int)err;
 	cache->align_frames(cache, consumed_count, cache->bytes_per_sample,
 			    cache->samples_per_frame);
 
-- 
2.11.0
