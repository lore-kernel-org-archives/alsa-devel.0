From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 07/38] axfer: add support for a
	container of raw data
Date: Tue, 19 Sep 2017 09:43:47 +0900
Message-ID: <20170919004418.24668-8-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 99223266E4C
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:27 +0200 (CEST)
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

This commit adds support for raw data without any headers/chunks/blocks.
A parser of container cannot recognize format of sample without
supplemental information.

Additionally, it includes no magic bytes. A parser of container should
process first several bytes as a part of PCM frames, instead of magic
bytes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am     |  3 ++-
 axfer/container-raw.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 axfer/container.c     | 39 +++++++++++++++++++++++++-----
 axfer/container.h     |  4 ++++
 4 files changed, 105 insertions(+), 7 deletions(-)
 create mode 100644 axfer/container-raw.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 48d046e1..f1ec1d1d 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -27,4 +27,5 @@ axfer_SOURCES = \
 	container.c \
 	container-riff-wave.c \
 	container-au.c \
-	container-voc.c
+	container-voc.c \
+	container-raw.c
diff --git a/axfer/container-raw.c b/axfer/container-raw.c
new file mode 100644
index 00000000..b5e11e44
--- /dev/null
+++ b/axfer/container-raw.c
@@ -0,0 +1,66 @@
+/*
+ * container-raw.c - a parser/builder for a container with raw data frame.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "container.h"
+#include "misc.h"
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+static int raw_builder_pre_process(struct container_context *cntr,
+				   snd_pcm_format_t *sample_format,
+				   unsigned int *samples_per_frame,
+				   unsigned int *frames_per_second,
+				   uint64_t *byte_count)
+{
+	*byte_count = UINT64_MAX;
+
+	return 0;
+}
+
+static int raw_parser_pre_process(struct container_context *cntr,
+				  snd_pcm_format_t *sample_format,
+				  unsigned int *samples_per_frame,
+				  unsigned int *frames_per_second,
+				  uint64_t *byte_count)
+{
+	struct stat buf = {0};
+	int err;
+
+	if (cntr->stdio) {
+		*byte_count = UINT64_MAX;
+		return 0;
+	}
+
+	err = fstat(cntr->fd, &buf);
+	if (err < 0)
+		return err;
+
+	*byte_count = buf.st_size;
+	if (*byte_count == 0)
+		*byte_count = UINT64_MAX;
+
+	return 0;
+}
+
+const struct container_parser container_parser_raw = {
+	.format = CONTAINER_FORMAT_RAW,
+	.max_size = UINT64_MAX,
+	.ops = {
+		.pre_process = raw_parser_pre_process,
+	},
+};
+
+const struct container_builder container_builder_raw = {
+	.format = CONTAINER_FORMAT_RAW,
+	.max_size = UINT64_MAX,
+	.ops = {
+		.pre_process = raw_builder_pre_process,
+	},
+};
diff --git a/axfer/container.c b/axfer/container.c
index 99652e65..bdaf99ab 100644
--- a/axfer/container.c
+++ b/axfer/container.c
@@ -23,15 +23,16 @@ static const char *const cntr_format_labels[] = {
 	[CONTAINER_FORMAT_RIFF_WAVE] = "riff/wave",
 	[CONTAINER_FORMAT_AU] = "au",
 	[CONTAINER_FORMAT_VOC] = "voc",
+	[CONTAINER_FORMAT_RAW] = "raw",
 };
 
 static const char *const suffixes[] = {
 	[CONTAINER_FORMAT_RIFF_WAVE]	= ".wav",
 	[CONTAINER_FORMAT_AU]		= ".au",
 	[CONTAINER_FORMAT_VOC]		= ".voc",
+	[CONTAINER_FORMAT_RAW]		= "",
 };
 
-
 const char *const container_suffix_from_format(enum container_format format)
 {
 	return suffixes[format];
@@ -112,7 +113,7 @@ enum container_format container_format_from_path(const char *path)
 	}
 
 	/* Unsupported. */
-	return CONTAINER_FORMAT_COUNT;
+	return CONTAINER_FORMAT_RAW;
 }
 
 int container_seek_offset(struct container_context *cntr, off64_t offset)
@@ -205,7 +206,7 @@ int container_parser_init(struct container_context *cntr,
 	 * Unless detected, use raw container.
 	 */
 	if (i == ARRAY_SIZE(parsers))
-		return -EINVAL;
+		parser = &container_parser_raw;
 
 	/* Allocate private data for the parser. */
 	if (parser->private_size > 0) {
@@ -233,6 +234,7 @@ int container_builder_init(struct container_context *cntr,
 		[CONTAINER_FORMAT_RIFF_WAVE] = &container_builder_riff_wave,
 		[CONTAINER_FORMAT_AU] = &container_builder_au,
 		[CONTAINER_FORMAT_VOC] = &container_builder_voc,
+		[CONTAINER_FORMAT_RAW] = &container_builder_raw,
 	};
 	const struct container_builder *builder;
 	int err;
@@ -311,6 +313,16 @@ int container_context_pre_process(struct container_context *cntr,
 			return 0;
 	}
 
+	if (cntr->format == CONTAINER_FORMAT_RAW) {
+		if (*format == SND_PCM_FORMAT_UNKNOWN ||
+		    *samples_per_frame == 0 || *frames_per_second == 0) {
+			fprintf(stderr,
+				"Any file format is not detected. Need to "
+				"indicate all of sample format, channels and "
+				"rate explicitly.\n");
+			return -EINVAL;
+		}
+	}
 	assert(*format >= SND_PCM_FORMAT_S8);
 	assert(*format <= SND_PCM_FORMAT_LAST);
 	assert(*samples_per_frame > 0);
@@ -357,6 +369,7 @@ int container_context_process_frames(struct container_context *cntr,
 	char *buf = frame_buffer;
 	unsigned int bytes_per_frame;
 	unsigned int byte_count;
+	unsigned int target_byte_count;
 	int err;
 
 	assert(cntr);
@@ -365,7 +378,21 @@ int container_context_process_frames(struct container_context *cntr,
 	assert(frame_count);
 
 	bytes_per_frame = cntr->bytes_per_sample * cntr->samples_per_frame;
-	byte_count = *frame_count * bytes_per_frame;
+	target_byte_count = *frame_count * bytes_per_frame;
+
+	/*
+	 * A parser of cotainers already read first 4 bytes to detect format
+	 * of container, however they includes PCM frames when any format was
+	 * undetected. Surely to write out them.
+	 */
+	byte_count = target_byte_count;
+	if (cntr->format == CONTAINER_FORMAT_RAW &&
+	    cntr->type == CONTAINER_TYPE_PARSER && !cntr->magic_handled) {
+		memcpy(buf, cntr->magic, sizeof(cntr->magic));
+		buf += sizeof(cntr->magic);
+		byte_count -= sizeof(cntr->magic);
+		cntr->magic_handled = true;
+	}
 
 	/* Each container has limitation for its volume for sample data. */
 	if (cntr->handled_byte_count > cntr->max_size - byte_count)
@@ -379,11 +406,11 @@ int container_context_process_frames(struct container_context *cntr,
 		return err;
 	}
 
-	cntr->handled_byte_count += byte_count;
+	cntr->handled_byte_count += target_byte_count;
 	if (cntr->handled_byte_count == cntr->max_size)
 		cntr->eof = true;
 
-	*frame_count = byte_count / bytes_per_frame;
+	*frame_count = target_byte_count / bytes_per_frame;
 
 	return 0;
 }
diff --git a/axfer/container.h b/axfer/container.h
index caba7398..9825f48d 100644
--- a/axfer/container.h
+++ b/axfer/container.h
@@ -28,6 +28,7 @@ enum container_format {
 	CONTAINER_FORMAT_RIFF_WAVE = 0,
 	CONTAINER_FORMAT_AU,
 	CONTAINER_FORMAT_VOC,
+	CONTAINER_FORMAT_RAW,
 	CONTAINER_FORMAT_COUNT,
 };
 
@@ -119,4 +120,7 @@ extern const struct container_builder container_builder_au;
 extern const struct container_parser container_parser_voc;
 extern const struct container_builder container_builder_voc;
 
+const struct container_parser container_parser_raw;
+const struct container_builder container_builder_raw;
+
 #endif
-- 
2.11.0
