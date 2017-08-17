From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 04/23] aplay: add an implementation of
	container for Creative Tech. voice format
Date: Thu, 17 Aug 2017 20:59:45 +0900
Message-ID: <20170817120004.15326-5-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 37D74266998
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

This commit adds support for data of Creative Tech. voice format. In this
data format, each of field can have value in little endian-ness. A file can
include multiple data streams in each block. However for simplicity, this
commit supports the first block for data stream.
---
 aplay/Makefile.am     |   3 +-
 aplay/container-voc.c | 736 ++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/container.c     |   4 +
 aplay/container.h     |   4 +
 4 files changed, 746 insertions(+), 1 deletion(-)
 create mode 100644 aplay/container-voc.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 8e4a31f..ef70bcb 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -15,7 +15,8 @@ aplay_SOURCES = \
 	container.h \
 	container.c \
 	container-riff-wave.c \
-	container-au.c
+	container-au.c \
+	container-voc.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/container-voc.c b/aplay/container-voc.c
new file mode 100644
index 0000000..d9491cd
--- /dev/null
+++ b/aplay/container-voc.c
@@ -0,0 +1,736 @@
+/*
+ * container-voc.c - a parser/builder for a container of Creative Voice File.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "container.h"
+
+/*
+ * References:
+ * - 'Creative Voice (VOC) file format' documentation in libRealSpace
+ */
+
+#define VOC_MAGIC	"Creative Voice File\x1A"
+#define VOC_VERSION_1_10	0x010a
+#define VOC_VERSION_1_20	0x0114
+
+enum block_type {
+	BLOCK_TYPE_TERMINATOR		= 0x00,
+	BLOCK_TYPE_V110_DATA		= 0x01,
+	BLOCK_TYPE_CONTINUOUS_DATA	= 0x02,
+	BLOCK_TYPE_SILENCE		= 0x03,
+	BLOCK_TYPE_MARKER		= 0x04,
+	BLOCK_TYPE_STRING		= 0x05,
+	BLOCK_TYPE_REPEAT_START		= 0x06,
+	BLOCK_TYPE_REPEAT_END		= 0x07,
+	BLOCK_TYPE_EXTENDED_V110_FORMAT	= 0x08,
+	BLOCK_TYPE_V120_DATA		= 0x09,
+};
+
+enum code_id {
+	/* Version 1.10. */
+	CODE_ID_GENERIC_MBLA_U8			= 0x00,
+	CODE_ID_CREATIVE_ADPCM_8BIT_TO_4BIT_LE	= 0x01,
+	CODE_ID_CREATIVE_ADPCM_8BIT_TO_3BIT_LE	= 0x02,
+	CODE_ID_CREATIVE_ADPCM_8BIT_TO_2BIT_LE	= 0x03,
+	/* Version 1.20. */
+	CODE_ID_GENERIC_MBLA_S16_LE		= 0x04,
+	CODE_ID_CCIT_A_LAW_LE			= 0x06,
+	CODE_ID_CCIT_MU_LAW_LE			= 0x07,
+	CODE_ID_CREATIVE_ADPCM_16BIT_TO_4BIT_LE	= 0x2000,
+};
+
+struct format_map {
+	unsigned int minimal_version;
+	enum code_id code_id;
+	snd_pcm_format_t format;
+};
+
+static const struct format_map format_maps[] = {
+	{VOC_VERSION_1_10, CODE_ID_GENERIC_MBLA_U8,	SND_PCM_FORMAT_U8},
+	{VOC_VERSION_1_20, CODE_ID_GENERIC_MBLA_S16_LE,	SND_PCM_FORMAT_S16_LE},
+	{VOC_VERSION_1_20, CODE_ID_CCIT_A_LAW_LE,	SND_PCM_FORMAT_A_LAW},
+	{VOC_VERSION_1_20, CODE_ID_CCIT_MU_LAW_LE,	SND_PCM_FORMAT_MU_LAW},
+	/* The other formats are not supported by ALSA. */
+};
+
+struct container_header {
+	uint8_t magic[20];
+	uint16_t hdr_size;
+	uint16_t version;
+	uint16_t version_compr;
+};
+
+/* A format for data blocks except for terminator type. */
+struct block_header {
+	uint8_t type;
+	uint8_t size[3];
+
+	uint8_t data[0];
+};
+
+/* Data block for terminator type has an exceptional format. */
+struct block_terminator {
+	uint8_t type;
+};
+
+/*
+ * v1.10 format:
+ * - monaural.
+ * - frames_per_second = 1,000,000 / (256 - time_const)
+ */
+struct block_v110_data {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to (2 + the size of frames). */
+
+	uint8_t time_const;
+	uint8_t code_id;
+	uint8_t samples[0];	/* Aligned to big-endian. */
+};
+
+struct block_continuous_data {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to the size of frames. */
+
+	uint8_t samples[0];	/* Aligned to big-endian. */
+};
+
+/*
+ * v1.10 format:
+ * - monaural.
+ * - frames_per_second = 1,000,000 / (256 - time_const).
+ */
+struct block_silence {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to 3. */
+
+	uint16_t frame_count;
+	uint8_t time_const;
+};
+
+struct block_marker {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to 2. */
+
+	uint16_t mark;
+};
+
+struct block_string {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to the length of string with 0x00. */
+
+	uint8_t chars[0];
+};
+
+struct block_repeat_start {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to 2. */
+
+	uint16_t count;
+};
+
+struct block_repeat_end {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to 0. */
+};
+
+/*
+ * Extended v1.10 format:
+ * - manaural/stereo.
+ * - frames_per_second =
+ *		256,000,000 / (samples_per_frame * (65536 - time_const)).
+ * - Appear just before v110_data block.
+ */
+struct block_extended_v110_format {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to 4. */
+
+	uint16_t time_const;
+	uint8_t code_id;
+	uint8_t ch_mode;	/* 0 is monaural, 1 is stereo. */
+};
+
+/*
+ * v1.20 format:
+ * - monaural/stereo.
+ * - 8/16 bits_per_sample.
+ * - time_const is not used.
+ * - code_id is extended.
+ */
+struct block_v120_format {
+	uint8_t type;
+	uint8_t size[3];	/* Equals to (12 + ). */
+
+	uint32_t frames_per_second;
+	uint8_t bits_per_sample;
+	uint8_t samples_per_frame;
+	uint16_t code_id;
+	uint8_t reserved[4];
+
+	uint8_t samples[0];
+};
+
+/* Aligned to little endian order but 24 bits field. */
+static unsigned int parse_block_data_size(uint8_t fields[3])
+{
+	return (fields[2] << 16) | (fields[1] << 8) | fields[0];
+}
+
+static void build_block_data_size(uint8_t fields[3], unsigned int size)
+{
+	fields[0] = (size & 0x0000ff);
+	fields[1] = (size & 0x00ff00) >> 8;
+	fields[2] = (size & 0xff0000) >> 16;
+}
+
+static unsigned int build_time_constant(unsigned int frames_per_second,
+					unsigned int samples_per_frame,
+					bool extended)
+{
+	unsigned int samples_per_second = samples_per_frame * frames_per_second;
+
+	/* 16 bits are available for this purpose. */
+	if (extended)
+		return 65536 - 256000000 / samples_per_second;
+
+	/* Should be within 8 bit. */
+	return 256 - 1000000 / samples_per_second;
+}
+
+static unsigned int parse_time_constant(unsigned int time_const,
+					unsigned int samples_per_frame,
+					bool extended)
+{
+	if (extended)
+		return 256000000 / (samples_per_frame * (65536 - time_const));
+
+	return 1000000 / (256 - time_const);
+}
+
+struct parser_state {
+	unsigned int version;
+	bool extended;
+
+	unsigned int frames_per_second;
+	unsigned int samples_per_frame;
+	unsigned int bytes_per_sample;
+	enum code_id code_id;
+	unsigned int byte_count;
+};
+
+static int parse_container_header(struct parser_state *state,
+				  struct container_header *header)
+{
+	uint16_t hdr_size;
+	uint16_t version;
+	uint16_t version_compr;
+
+	hdr_size = le16toh(header->hdr_size);
+	version = le16toh(header->version);
+	version_compr = le16toh(header->version_compr);
+
+	if (!memcmp(header->magic, VOC_MAGIC, sizeof(header->magic)))
+		return -EIO;
+
+	if (hdr_size != sizeof(*header))
+		return -EIO;
+
+	if (version_compr != 0x1234 - ~version)
+		return -EIO;
+
+	if (version != VOC_VERSION_1_10 || version != VOC_VERSION_1_20)
+		return -EIO;
+
+	state->version = version;
+
+	return 0;
+}
+
+static bool check_code_id(uint8_t code_id, unsigned int version)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(format_maps); ++i) {
+		if (format_maps[i].minimal_version > version)
+			continue;
+		if (format_maps[i].code_id == code_id)
+			return true;
+	}
+
+	return false;
+}
+
+static int parse_v120_format_block(struct parser_state *state,
+				   struct block_v120_format *block)
+{
+	state->frames_per_second = le32toh(block->frames_per_second);
+	state->bytes_per_sample = block->bits_per_sample / 8;
+	state->samples_per_frame = block->samples_per_frame;
+	state->code_id = le16toh(block->code_id);
+	state->byte_count = parse_block_data_size(block->size) - 12;
+
+	if (check_code_id(state->code_id, VOC_VERSION_1_20))
+		return -EIO;
+
+	return 0;
+}
+
+static int parse_extended_v110_format(struct parser_state *state,
+				      struct block_extended_v110_format *block)
+{
+	unsigned int time_const;
+
+	state->code_id = block->code_id;
+	if (check_code_id(state->code_id, VOC_VERSION_1_10))
+		return -EIO;
+
+	if (block->ch_mode == 0)
+		state->samples_per_frame = 1;
+	else if (block->ch_mode == 1)
+		state->samples_per_frame = 2;
+	else
+		return -EIO;
+
+	time_const = le16toh(block->time_const);
+	state->frames_per_second =
+		parse_time_constant(time_const, state->samples_per_frame, true);
+	if (state->frames_per_second == 0)
+		return -EIO;
+
+	state->extended = true;
+
+	return 0;
+}
+
+static int parse_v110_data(struct parser_state *state,
+			   struct block_v110_data *block)
+{
+	unsigned int time_const;
+
+	if (!state->extended) {
+		state->code_id = block->code_id;
+		if (check_code_id(state->code_id, VOC_VERSION_1_10))
+			return -EIO;
+
+		time_const = block->time_const;
+		state->frames_per_second =
+				parse_time_constant(time_const, 1, false);
+		if (state->frames_per_second == 0)
+			return -EIO;
+	}
+
+	state->bytes_per_sample = 1;
+	state->byte_count = parse_block_data_size(block->size) - 2;
+
+	return 0;
+}
+
+static int detect_container_version(struct container_context *cntr)
+{
+	struct parser_state *state = cntr->private_data;
+	struct container_header header = {0};
+	int err;
+
+	/* 4 bytes were alread read to detect container type. */
+	memcpy(&header.magic, cntr->magic, sizeof(cntr->magic));
+	err = container_recursive_read(cntr,
+				       (char *)&header + sizeof(cntr->magic),
+				       sizeof(header) - sizeof(cntr->magic));
+	if (err < 0)
+		return err;
+
+	return parse_container_header(state, &header);
+}
+
+static int allocate_for_block_cache(struct container_context *cntr,
+				    struct block_header *header, void **buf)
+{
+	unsigned int block_size;
+	char *cache;
+	int err;
+
+	if (header->type == BLOCK_TYPE_V110_DATA)
+		block_size = sizeof(struct block_v110_data);
+	else if (header->type == BLOCK_TYPE_CONTINUOUS_DATA)
+		block_size = sizeof(struct block_continuous_data);
+	else if (header->type == BLOCK_TYPE_V120_DATA)
+		block_size = sizeof(struct block_v120_format);
+	else
+		block_size = parse_block_data_size(header->size);
+
+	cache = malloc(block_size);
+	if (cache == NULL)
+		return -ENOMEM;
+	memset(cache, 0, block_size);
+
+	memcpy(cache, header, sizeof(*header));
+	err = container_recursive_read(cntr, cache + sizeof(*header),
+				       block_size - sizeof(*header));
+	if (err < 0) {
+		free(cache);
+		return err;
+	}
+
+	*buf = cache;
+
+	return 0;
+}
+
+static int cache_data_block(struct container_context *cntr,
+			    struct block_header *header, void **buf)
+{
+	int err;
+
+	/* Check type of this block. */
+	err = container_recursive_read(cntr, header, sizeof(*header));
+	if (err < 0)
+		return err;
+	if (header->type > BLOCK_TYPE_V120_DATA)
+		return -EIO;
+	if (header->type == BLOCK_TYPE_TERMINATOR)
+		return 0;
+
+	/* Check size of this block. If the block includes a batch of data, */
+	err = container_recursive_read(cntr, &header->size,
+				       sizeof(header->size));
+	if (err < 0)
+		return err;
+
+	return allocate_for_block_cache(cntr, header, buf);
+}
+
+static int detect_format_block(struct container_context *cntr)
+{
+	struct parser_state *state = cntr->private_data;
+	struct block_header header;
+	void *buf;
+	int err;
+
+again:
+	err = cache_data_block(cntr, &header, &buf);
+	if (err < 0)
+		return err;
+
+	if (header.type == BLOCK_TYPE_EXTENDED_V110_FORMAT) {
+		err = parse_extended_v110_format(state, buf);
+	} else if (header.type == BLOCK_TYPE_V120_DATA) {
+		err = parse_v120_format_block(state, buf);
+	} else if (header.type == BLOCK_TYPE_V110_DATA) {
+		err = parse_v110_data(state, buf);
+	} else {
+		free(buf);
+		goto again;
+	}
+
+	free(buf);
+
+	if (err < 0) {
+		return err;
+	}
+
+	/* Expect to detect block_v110_data. */
+	if (header.type == BLOCK_TYPE_EXTENDED_V110_FORMAT)
+		goto again;
+
+	return 0;
+}
+
+static int voc_parser_pre_process(struct container_context *cntr,
+				  snd_pcm_format_t *format,
+				  unsigned int *samples_per_frame,
+				  unsigned int *frames_per_second,
+				  uint64_t *frame_count)
+{
+	struct parser_state *state = cntr->private_data;
+	int i;
+	int err;
+
+	err = detect_container_version(cntr);
+	if (err < 0)
+		return err;
+
+	err = detect_format_block(cntr);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(format_maps); ++i) {
+		if (format_maps[i].code_id == state->code_id)
+			break;
+	}
+	if (i == ARRAY_SIZE(format_maps))
+		return -EINVAL;
+
+	*format = format_maps[i].format;
+	*samples_per_frame = state->samples_per_frame;
+	*frames_per_second = state->frames_per_second;
+
+	/* This program handles PCM frames in this data block only. */
+	*frame_count = state->byte_count / snd_pcm_format_width(*format) /
+		       state->samples_per_frame;
+
+	return 0;
+}
+
+struct builder_state {
+	unsigned int version;
+	bool extended;
+
+	unsigned int samples_per_frame;
+	unsigned int bytes_per_sample;
+};
+
+static int write_container_header(struct container_context *cntr, void *buf)
+{
+	struct builder_state *state = cntr->private_data;
+	struct container_header *header = buf;
+
+	/* Process container header. */
+	memcpy(header->magic, VOC_MAGIC, sizeof(header->magic));
+	header->hdr_size = htole16(sizeof(header));
+	header->version = htole16(state->version);
+	header->version_compr = htole16(0x1234 + ~state->version);
+
+	return container_recursive_write(cntr, &header, sizeof(*header));
+}
+
+static int write_v120_format_block(struct container_context *cntr,
+				   struct block_v120_format *block,
+				   unsigned int frames_per_second,
+				   uint64_t frame_count)
+{
+	struct builder_state *state = cntr->private_data;
+	uint64_t byte_count;
+
+	block->type = BLOCK_TYPE_V120_DATA;
+	byte_count = frame_count * state->samples_per_frame *
+		     state->bytes_per_sample;
+	build_block_data_size(block->size, 12 + byte_count);
+
+	block->frames_per_second = htole32(frames_per_second);
+	block->bits_per_sample = state->bytes_per_sample * 8;
+	block->samples_per_frame = state->samples_per_frame;
+	if (state->bytes_per_sample == 1)
+		block->code_id = htole16(CODE_ID_GENERIC_MBLA_U8);
+	else
+		block->code_id = htole16(CODE_ID_GENERIC_MBLA_S16_LE);
+
+	return container_recursive_write(cntr, block, sizeof(*block));
+}
+
+static int write_extended_v110_format_block(struct container_context *cntr,
+				unsigned int frames_per_second,
+				struct block_extended_v110_format *block)
+{
+	struct builder_state *state = cntr->private_data;
+	unsigned int time_const;
+
+	block->type = BLOCK_TYPE_EXTENDED_V110_FORMAT;
+	build_block_data_size(block->size, 4);
+
+	/* 16 bits are available for this purpose. */
+	time_const = build_time_constant(frames_per_second,
+					 state->samples_per_frame, true);
+	block->time_const = htobe16(time_const);
+	block->code_id = CODE_ID_GENERIC_MBLA_U8;
+
+	if (state->samples_per_frame == 1)
+		block->ch_mode = 0;
+	else
+		block->ch_mode = 1;
+
+	return container_recursive_write(cntr, block, sizeof(*block));
+}
+
+static int write_v110_format_block(struct container_context *cntr,
+				   struct block_v110_data *block,
+				   unsigned int frames_per_second,
+				   uint64_t frame_count)
+{
+	struct builder_state *state = cntr->private_data;
+	uint64_t byte_count;
+
+	block->type = BLOCK_TYPE_V110_DATA;
+	byte_count = state->bytes_per_sample * state->samples_per_frame *
+		     frame_count;
+	build_block_data_size(block->size, 2 + byte_count);
+
+	/* This field was obsoleted by extension. */
+	block->time_const = build_time_constant(frames_per_second, 1, false);
+	block->code_id = CODE_ID_GENERIC_MBLA_U8;
+
+	return container_recursive_write(cntr, block, sizeof(*block));
+}
+
+static int write_data_blocks(struct container_context *cntr,
+			     unsigned int frames_per_second,
+			     uint64_t frame_count)
+{
+	union {
+		struct container_header header;
+		struct block_v110_data v110_data;
+		struct block_extended_v110_format extended_v110_format;
+		struct block_v120_format v120_format;
+	} buf = {0};
+	struct builder_state *state = cntr->private_data;
+	int err;
+
+	err = write_container_header(cntr, &buf.header);
+	if (err < 0)
+		return err;
+
+	if (state->version == VOC_VERSION_1_20) {
+		err = write_v120_format_block(cntr, &buf.v120_format,
+					      frames_per_second, frame_count);
+	} else {
+		if (state->extended) {
+			err = write_extended_v110_format_block(cntr,
+					frames_per_second,
+					&buf.extended_v110_format);
+			if (err < 0)
+				return err;
+		}
+		err = write_v110_format_block(cntr, &buf.v110_data,
+					      frames_per_second, frame_count);
+	}
+
+	return err;
+}
+
+static int voc_builder_pre_process(struct container_context *cntr,
+				   snd_pcm_format_t *format,
+				   unsigned int *samples_per_frame,
+				   unsigned int *frames_per_second,
+				   uint64_t *frame_count)
+{
+	struct builder_state *state = cntr->private_data;
+	bool extended = false;
+	int i;
+
+	/* Validate parameters. */
+	for (i = 0; i < ARRAY_SIZE(format_maps); ++i) {
+		if (format_maps[i].format == *format)
+			break;
+	}
+	if (i == ARRAY_SIZE(format_maps))
+		return -EINVAL;
+
+	/* Decide container version. */
+	if (format_maps[i].minimal_version == VOC_VERSION_1_10) {
+		if (*samples_per_frame > 2)
+			return -EINVAL;
+		extended = !!(*samples_per_frame == 2);
+	}
+
+	state->bytes_per_sample = snd_pcm_format_physical_width(*format) / 8;
+	state->samples_per_frame = *samples_per_frame;
+	state->version = format_maps[i].minimal_version;
+	state->extended = extended;
+
+	return write_data_blocks(cntr, *frames_per_second, *frame_count);
+}
+
+static int write_block_terminator(struct container_context *cntr)
+{
+	struct block_terminator block = {0};
+
+	block.type = BLOCK_TYPE_TERMINATOR;
+	return container_recursive_write(cntr, &block, sizeof(block));
+}
+
+static int write_size_to_v120_format_block(struct container_context *cntr,
+					   uint64_t actual_frame_count)
+{
+	struct builder_state *state = cntr->private_data;
+	off64_t offset;
+	uint64_t actual_byte_count;
+	uint8_t size_field[3];
+	int err;
+
+	offset = sizeof(struct container_header) + sizeof(uint8_t);
+	err = container_seek_offset(cntr, offset);
+	if (err < 0)
+		return err;
+
+	/* Don't forget to add 12 bytes for this block. */
+	actual_byte_count = 12 + actual_frame_count *
+			state->samples_per_frame * state->bytes_per_sample;
+	size_field[0] = (actual_byte_count & 0x0000ff);
+	size_field[1] = (actual_byte_count & 0x00ff00) >> 8;
+	size_field[2] = (actual_byte_count & 0xff0000) >> 16;
+
+	return container_recursive_write(cntr, &size_field, sizeof(size_field));
+}
+
+static int write_size_to_v110_format_block(struct container_context *cntr,
+					   uint64_t actual_frame_count)
+{
+	struct builder_state *state = cntr->private_data;
+	off64_t offset;
+	uint64_t actual_byte_count;
+	uint8_t size_field[3];
+	int err;
+
+	offset = sizeof(struct container_header) + sizeof(uint8_t);
+	if (state->extended)
+		offset += sizeof(struct block_extended_v110_format);
+	err = container_seek_offset(cntr, offset);
+	if (err < 0)
+		return err;
+
+	/* Don't forget to add 2 bytes for this block. */
+	actual_byte_count = 2 + actual_frame_count;
+	size_field[0] = (actual_byte_count & 0x000000);
+	size_field[1] = (actual_byte_count & 0x000000) >> 8;
+	size_field[2] = (actual_byte_count & 0x000000) >> 16;
+
+	return container_recursive_write(cntr, &size_field, sizeof(size_field));
+}
+
+static int write_size_to_format_block(struct container_context *cntr,
+				      uint64_t actual_frame_count)
+{
+	struct builder_state *state = cntr->private_data;
+	int err;
+
+	if (state->version == VOC_VERSION_1_20)
+		err = write_size_to_v120_format_block(cntr, actual_frame_count);
+	else
+		err = write_size_to_v110_format_block(cntr, actual_frame_count);
+
+	return err;
+}
+
+static int voc_builder_post_process(struct container_context *cntr,
+				    uint64_t actual_frame_count)
+{
+	int err;
+
+	err = write_block_terminator(cntr);
+	if (err < 0)
+		return err;
+
+	return write_size_to_format_block(cntr, actual_frame_count);
+}
+
+const struct container_parser container_parser_voc = {
+	.format = CONTAINER_FORMAT_VOC,
+	.magic = VOC_MAGIC,
+	.max_size = 16000000ll,
+	.ops = {
+		.pre_process	= voc_parser_pre_process,
+	},
+	.private_size = sizeof(struct parser_state),
+};
+
+const struct container_builder container_builder_voc = {
+	.format = CONTAINER_FORMAT_VOC,
+	.max_size = 16000000ll,
+	.ops = {
+		.pre_process	= voc_builder_pre_process,
+		.post_process	= voc_builder_post_process,
+	},
+	.private_size = sizeof(struct builder_state),
+};
diff --git a/aplay/container.c b/aplay/container.c
index 6214bbf..1cd7ada 100644
--- a/aplay/container.c
+++ b/aplay/container.c
@@ -22,11 +22,13 @@ static const char *const cntr_type_labels[] = {
 static const char *const cntr_format_labels[] = {
 	[CONTAINER_FORMAT_RIFF_WAVE] = "riff/wave",
 	[CONTAINER_FORMAT_AU] = "au",
+	[CONTAINER_FORMAT_VOC] = "voc",
 };
 
 static const char *const suffixes[] = {
 	[CONTAINER_FORMAT_RIFF_WAVE]	= ".wav",
 	[CONTAINER_FORMAT_AU]		= ".au",
+	[CONTAINER_FORMAT_VOC]		= ".voc",
 };
 
 
@@ -151,6 +153,7 @@ int container_parser_init(struct container_context *cntr,
 	const struct container_parser *parsers[] = {
 		[CONTAINER_FORMAT_RIFF_WAVE] = &container_parser_riff_wave,
 		[CONTAINER_FORMAT_AU] = &container_parser_au,
+		[CONTAINER_FORMAT_VOC] = &container_parser_voc,
 	};
 	const struct container_parser *parser;
 	unsigned int size;
@@ -220,6 +223,7 @@ int container_builder_init(struct container_context *cntr,
 	const struct container_builder *builders[] = {
 		[CONTAINER_FORMAT_RIFF_WAVE] = &container_builder_riff_wave,
 		[CONTAINER_FORMAT_AU] = &container_builder_au,
+		[CONTAINER_FORMAT_VOC] = &container_builder_voc,
 	};
 	const struct container_builder *builder;
 	int err;
diff --git a/aplay/container.h b/aplay/container.h
index 73029f4..994ff9b 100644
--- a/aplay/container.h
+++ b/aplay/container.h
@@ -32,6 +32,7 @@ enum container_type {
 enum container_format {
 	CONTAINER_FORMAT_RIFF_WAVE = 0,
 	CONTAINER_FORMAT_AU,
+	CONTAINER_FORMAT_VOC,
 	CONTAINER_FORMAT_COUNT,
 };
 
@@ -119,4 +120,7 @@ extern const struct container_builder container_builder_riff_wave;
 extern const struct container_parser container_parser_au;
 extern const struct container_builder container_builder_au;
 
+extern const struct container_parser container_parser_voc;
+extern const struct container_builder container_builder_voc;
+
 #endif
-- 
2.11.0
