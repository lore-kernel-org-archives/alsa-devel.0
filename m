From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/35] axfer: add support for a container of
	Sparc AU format
Date: Tue, 13 Nov 2018 15:41:17 +0900
Message-ID: <20181113064147.13577-5-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5472A267AA3
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:02 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id w24-v6so5525948plq.3
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:02 -0800 (PST)
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

This commit adds support for data of Sparc AU format. In this data format,
values in each of field are encoded in big-endian byte order and available
formats of data sample are restricted in big-endian byte order.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am    |   3 +-
 axfer/container-au.c | 203 +++++++++++++++++++++++++++++++++++++++++++
 axfer/container.c    |   6 +-
 axfer/container.h    |   4 +
 4 files changed, 214 insertions(+), 2 deletions(-)
 create mode 100644 axfer/container-au.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 092c966..35aa226 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -25,4 +25,5 @@ axfer_SOURCES = \
 	subcmd-list.c \
 	container.h \
 	container.c \
-	container-riff-wave.c
+	container-riff-wave.c \
+	container-au.c
diff --git a/axfer/container-au.c b/axfer/container-au.c
new file mode 100644
index 00000000..6459b16
--- /dev/null
+++ b/axfer/container-au.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// container-au.c - a parser/builder for a container of Sun Audio File.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "container.h"
+#include "misc.h"
+
+// Not portable to all of UNIX platforms.
+#include <endian.h>
+
+// Reference:
+//  * http://pubs.opengroup.org/external/auformat.html
+
+#define AU_MAGIC	".snd"
+#define UNKNOWN_SIZE	UINT32_MAX
+
+enum code_id {
+	CODE_ID_CCIT_MU_LAW_BE		= 0x01,
+	CODE_ID_GENERIC_MBLA_S8		= 0x02,
+	CODE_ID_GENERIC_MBLA_S16_BE	= 0x03,
+	CODE_ID_GENERIC_MBLA_S32_BE	= 0x05,
+	CODE_ID_IEEE754_FLOAT_S32_BE	= 0x06,
+	CODE_ID_IEEE754_DOUBLE_S64_BE	= 0x07,
+	CODE_ID_CCIT_ADPCM_G721_4BIT_BE	= 0x17,
+	CODE_ID_CCIT_ADPCM_G723_3BIT_BE	= 0x19,
+	CODE_ID_CCIT_A_LAW_BE		= 0x1b,
+};
+
+struct format_map {
+	enum code_id code_id;
+	snd_pcm_format_t format;
+};
+
+static const struct format_map format_maps[] = {
+	{CODE_ID_GENERIC_MBLA_S8,		SND_PCM_FORMAT_S8},
+	{CODE_ID_GENERIC_MBLA_S16_BE,		SND_PCM_FORMAT_S16_BE},
+	{CODE_ID_GENERIC_MBLA_S32_BE,		SND_PCM_FORMAT_S32_BE},
+	{CODE_ID_IEEE754_FLOAT_S32_BE,		SND_PCM_FORMAT_FLOAT_BE},
+	{CODE_ID_IEEE754_DOUBLE_S64_BE,		SND_PCM_FORMAT_FLOAT64_BE},
+	// CODE_ID_CCIT_ADPCM_G721_4BIT_BE is not supported by ALSA.
+	// CODE_ID_CCIT_ADPCM_G723_3BIT_BE is not supported due to width of
+	// its sample.
+	{CODE_ID_CCIT_A_LAW_BE,			SND_PCM_FORMAT_A_LAW},
+	{CODE_ID_CCIT_MU_LAW_BE,		SND_PCM_FORMAT_MU_LAW},
+};
+
+struct container_header {
+	uint8_t magic[4];
+	uint32_t hdr_size;
+	uint32_t data_size;
+	uint32_t code_id;
+	uint32_t frames_per_second;
+	uint32_t samples_per_frame;
+};
+
+struct container_annotation {
+	uint32_t chunks[0];
+};
+
+struct parser_state {
+	enum code_id code_id;
+	unsigned int samples_per_frame;
+	unsigned int bytes_per_sample;
+};
+
+static int au_parser_pre_process(struct container_context *cntr,
+				 snd_pcm_format_t *format,
+				 unsigned int *samples_per_frame,
+				 unsigned int *frames_per_second,
+				 uint64_t *byte_count)
+{
+	struct parser_state *state = cntr->private_data;
+	struct container_header header;
+	enum code_id code_id;
+	int i;
+	int err;
+
+	// Parse header. 4 bytes are enough to detect supported containers.
+	memcpy(&header.magic, cntr->magic, sizeof(cntr->magic));
+	err = container_recursive_read(cntr,
+				       (char *)&header + sizeof(cntr->magic),
+				       sizeof(header) - sizeof(cntr->magic));
+	if (err < 0)
+		return err;
+	if (cntr->eof)
+		return 0;
+
+	if (memcmp(header.magic, AU_MAGIC, sizeof(header.magic)) != 0)
+		return -EINVAL;
+	if (be32toh(header.hdr_size) != sizeof(struct container_header))
+		return -EINVAL;
+
+	code_id = be32toh(header.code_id);
+	for (i = 0; i < ARRAY_SIZE(format_maps); ++i) {
+		if (format_maps[i].code_id == code_id)
+			break;
+	}
+	if (i == ARRAY_SIZE(format_maps))
+		return -EINVAL;
+	*format = format_maps[i].format;
+	*frames_per_second = be32toh(header.frames_per_second);
+	*samples_per_frame = be32toh(header.samples_per_frame);
+
+	state->code_id = code_id;
+	state->samples_per_frame = *samples_per_frame;
+	state->bytes_per_sample = snd_pcm_format_physical_width(*format) / 8;
+
+	*byte_count = be32toh(header.data_size);
+
+	return 0;
+}
+
+struct builder_state {
+	unsigned int bytes_per_sample;
+	unsigned int samples_per_frame;
+	unsigned int frames_per_second;
+	enum code_id code_id;
+};
+
+static void build_container_header(struct builder_state *state,
+				   struct container_header *header,
+				   unsigned int frames_per_second,
+				   uint64_t byte_count)
+{
+	memcpy(header->magic, AU_MAGIC, sizeof(header->magic));
+	header->hdr_size = htobe32(sizeof(struct container_header));
+	header->data_size = htobe32(byte_count);
+	header->code_id = htobe32(state->code_id);
+	header->frames_per_second = htobe32(frames_per_second);
+	header->samples_per_frame = htobe32(state->samples_per_frame);
+}
+
+static int write_container_header(struct container_context *cntr,
+				  uint64_t byte_count)
+{
+	struct builder_state *state = cntr->private_data;
+	struct container_header header;
+
+	build_container_header(state, &header, state->frames_per_second,
+			       byte_count);
+
+	return container_recursive_write(cntr, &header, sizeof(header));
+}
+
+static int au_builder_pre_process(struct container_context *cntr,
+				  snd_pcm_format_t *format,
+				  unsigned int *samples_per_frame,
+				  unsigned int *frames_per_second,
+				  uint64_t *byte_count)
+{
+	struct builder_state *status = cntr->private_data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(format_maps); ++i) {
+		if (format_maps[i].format == *format)
+			break;
+	}
+	if (i == ARRAY_SIZE(format_maps))
+		return -EINVAL;
+
+	status->code_id = format_maps[i].code_id;
+	status->bytes_per_sample = snd_pcm_format_physical_width(*format) / 8;
+	status->frames_per_second = *frames_per_second;
+	status->samples_per_frame = *samples_per_frame;
+
+	return write_container_header(cntr, *byte_count);
+}
+
+static int au_builder_post_process(struct container_context *cntr,
+				   uint64_t handled_byte_count)
+{
+	int err;
+
+	err = container_seek_offset(cntr, 0);
+	if (err < 0)
+		return err;
+
+	return write_container_header(cntr, handled_byte_count);
+}
+
+const struct container_parser container_parser_au = {
+	.format = CONTAINER_FORMAT_AU,
+	.magic = AU_MAGIC,
+	.max_size = UINT32_MAX,
+	.ops = {
+		.pre_process = au_parser_pre_process,
+	},
+	.private_size = sizeof(struct parser_state),
+};
+
+const struct container_builder container_builder_au = {
+	.format = CONTAINER_FORMAT_AU,
+	.max_size = UINT32_MAX,
+	.ops = {
+		.pre_process	= au_builder_pre_process,
+		.post_process	= au_builder_post_process,
+	},
+	.private_size = sizeof(struct builder_state),
+};
diff --git a/axfer/container.c b/axfer/container.c
index 04042da..0e25605 100644
--- a/axfer/container.c
+++ b/axfer/container.c
@@ -21,10 +21,12 @@ static const char *const cntr_type_labels[] = {
 
 static const char *const cntr_format_labels[] = {
 	[CONTAINER_FORMAT_RIFF_WAVE] = "riff/wave",
+	[CONTAINER_FORMAT_AU] = "au",
 };
 
 static const char *const suffixes[] = {
-	[CONTAINER_FORMAT_RIFF_WAVE] = ".wav",
+	[CONTAINER_FORMAT_RIFF_WAVE]	= ".wav",
+	[CONTAINER_FORMAT_AU]		= ".au",
 };
 
 
@@ -142,6 +144,7 @@ int container_parser_init(struct container_context *cntr,
 {
 	const struct container_parser *parsers[] = {
 		[CONTAINER_FORMAT_RIFF_WAVE] = &container_parser_riff_wave,
+		[CONTAINER_FORMAT_AU] = &container_parser_au,
 	};
 	const struct container_parser *parser;
 	unsigned int size;
@@ -216,6 +219,7 @@ int container_builder_init(struct container_context *cntr,
 {
 	const struct container_builder *builders[] = {
 		[CONTAINER_FORMAT_RIFF_WAVE] = &container_builder_riff_wave,
+		[CONTAINER_FORMAT_AU] = &container_builder_au,
 	};
 	const struct container_builder *builder;
 	int err;
diff --git a/axfer/container.h b/axfer/container.h
index 5808933..19ef672 100644
--- a/axfer/container.h
+++ b/axfer/container.h
@@ -26,6 +26,7 @@ enum container_type {
 
 enum container_format {
 	CONTAINER_FORMAT_RIFF_WAVE = 0,
+	CONTAINER_FORMAT_AU,
 	CONTAINER_FORMAT_COUNT,
 };
 
@@ -111,4 +112,7 @@ int container_seek_offset(struct container_context *cntr, off64_t offset);
 extern const struct container_parser container_parser_riff_wave;
 extern const struct container_builder container_builder_riff_wave;
 
+extern const struct container_parser container_parser_au;
+extern const struct container_builder container_builder_au;
+
 #endif
-- 
2.19.1
